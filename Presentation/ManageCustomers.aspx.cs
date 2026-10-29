using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageCustomers : System.Web.UI.Page
    {
        private static string ConnectionString
        {
            get
            {
                ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["ForteDB"];
                if (settings == null)
                    throw new InvalidOperationException("The CatalogueDatabase connection string is missing from Web.config.");
                return settings.ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindCustomers();
        }

        protected void btnShowAdd_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblFormHeading.Text = "Add Customer";
            btnSaveCustomer.Text = "Add Customer";
            customerPasswordRow.Visible = true;
            customerTermsRow.Visible = true;
            pnlCustomerForm.Visible = true;
            pnlMessage.Visible = false;
        }

        protected void btnCancelForm_Click(object sender, EventArgs e)
        {
            pnlCustomerForm.Visible = false;
            ClearForm();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            pnlMessage.Visible = false;
            BindCustomers();
        }

        protected void btnSaveCustomer_Click(object sender, EventArgs e)
        {
            Page.Validate("CustomerForm");
            if (!Page.IsValid) return;

            if (!IsValidEmail(txtEmailAddress.Text.Trim()))
            {
                ShowMessage("Enter a valid email address, for example name@example.com.", false);
                return;
            }

            int userId;
            bool isEdit = Int32.TryParse(hfCustomerUserId.Value, out userId);
            DateTime dateOfBirth;
            if (!DateTime.TryParseExact(txtDateOfBirth.Text.Trim(), "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out dateOfBirth) || dateOfBirth.Date > DateTime.Today || dateOfBirth.Year < 1900)
            {
                ShowMessage("Enter a valid date of birth.", false);
                return;
            }

            string idNumber = (txtIDNumber.Text ?? String.Empty).Trim();
            if ((!isEdit || idNumber.Length > 0) && !IsValidSouthAfricanId(idNumber))
            {
                ShowMessage("Enter a South African ID number containing 13 digits.", false);
                return;
            }

            if (!isEdit && (txtCustomerPassword.Text.Length < 12 || txtCustomerPassword.Text != txtConfirmPassword.Text))
            {
                ShowMessage(txtCustomerPassword.Text.Length < 12 ? "Use a temporary password of at least 12 characters." : "The passwords do not match.", false);
                return;
            }
            if (isEdit && txtCustomerPassword.Text.Length > 0 && (txtCustomerPassword.Text.Length < 12 || txtCustomerPassword.Text != txtConfirmPassword.Text))
            {
                ShowMessage(txtCustomerPassword.Text.Length < 12 ? "Use a password of at least 12 characters." : "The passwords do not match.", false);
                return;
            }
            if (!isEdit && !chkTermsAccepted.Checked)
            {
                ShowMessage("Confirm that the customer has accepted the Terms and Conditions and Privacy Policy.", false);
                return;
            }

            byte[] encryptedId = idNumber.Length == 0 ? null : FEHMS_FortEventHireManagementSystem.RegistrationSecurityService.EncryptIDNumber(idNumber);

            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                using (SqlCommand command = connection.CreateCommand())
                {
                    if (isEdit)
                    {
                        command.CommandText = @"
UPDATE dbo.Users
SET FirstName = @FirstName, LastName = @LastName, FullName=@FirstName + N' ' + @LastName, Email=@EmailAddress, EmailAddress = @EmailAddress,
    DateOfBirth=@DateOfBirth, IDNumberEncrypted=COALESCE(@IDNumberEncrypted,IDNumberEncrypted),
    PhoneNumber = @PhoneNumber, IsActive = @IsActive, UpdatedAt = SYSUTCDATETIME()
WHERE UserID = @UserID
  AND RoleID = (SELECT RoleID FROM dbo.Roles WHERE RoleName = N'Customer' AND IsStaffRole = 0);
UPDATE dbo.Customer SET Phone=@PhoneNumber,UpdatedAt=SYSUTCDATETIME() WHERE UserID=@UserID;";
                        command.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    }
                    else
                    {
                        command.CommandText = @"
DECLARE @NewUsers TABLE (UserID INT);

INSERT INTO dbo.Users (FullName,FirstName,LastName,Email,EmailAddress,DateOfBirth,IDNumberEncrypted,PhoneNumber,PasswordHash,UserRole,RoleID,IsActive,TermsAcceptedAt)
OUTPUT INSERTED.UserID INTO @NewUsers (UserID)
SELECT @FirstName + N' ' + @LastName,@FirstName, @LastName, @EmailAddress, @EmailAddress, @DateOfBirth, @IDNumberEncrypted, @PhoneNumber, @PasswordHash, RoleName, RoleID, @IsActive, SYSUTCDATETIME()
FROM dbo.Roles
WHERE RoleName = N'Customer' AND IsStaffRole = 0;

SELECT ISNULL((SELECT TOP (1) UserID FROM @NewUsers), 0);";
                    }

                    command.Parameters.Add("@FirstName", SqlDbType.NVarChar, 80).Value = txtFirstName.Text.Trim();
                    command.Parameters.Add("@LastName", SqlDbType.NVarChar, 80).Value = txtLastName.Text.Trim();
                    command.Parameters.Add("@EmailAddress", SqlDbType.NVarChar, 254).Value = txtEmailAddress.Text.Trim();
                    command.Parameters.Add("@PhoneNumber", SqlDbType.NVarChar, 30).Value = String.IsNullOrWhiteSpace(txtPhoneNumber.Text) ? (object)DBNull.Value : txtPhoneNumber.Text.Trim();
                    command.Parameters.Add("@DateOfBirth", SqlDbType.Date).Value = dateOfBirth.Date;
                    command.Parameters.Add("@IDNumberEncrypted", SqlDbType.VarBinary, -1).Value = encryptedId == null ? (object)DBNull.Value : encryptedId;
                    command.Parameters.Add("@IsActive", SqlDbType.Bit).Value = chkActive.Checked;

                    if (!isEdit)
                        command.Parameters.Add("@PasswordHash", SqlDbType.NVarChar, 512).Value = FEHMS_FortEventHireManagementSystem.RegistrationSecurityService.HashPassword(txtCustomerPassword.Text);

                    connection.Open();
                    if (isEdit)
                    {
                        if (command.ExecuteNonQuery() == 0) throw new InvalidOperationException("This customer no longer exists.");
                    }
                    else
                    {
                        int newUserId = Convert.ToInt32(command.ExecuteScalar());
                        if (newUserId <= 0) throw new InvalidOperationException("The Customer role is missing from dbo.Roles.");
                        using (SqlCommand profile = new SqlCommand("IF NOT EXISTS(SELECT 1 FROM dbo.Customer WHERE UserID=@UserID) INSERT dbo.Customer(UserID,Phone) VALUES(@UserID,@Phone);", connection))
                        {
                            profile.Parameters.Add("@UserID", SqlDbType.Int).Value = newUserId;
                            profile.Parameters.Add("@Phone", SqlDbType.NVarChar, 30).Value = String.IsNullOrWhiteSpace(txtPhoneNumber.Text) ? (object)DBNull.Value : txtPhoneNumber.Text.Trim();
                            profile.ExecuteNonQuery();
                        }
                    }
                }

                pnlCustomerForm.Visible = false;
                customerPasswordRow.Visible = false;
                customerTermsRow.Visible = false;
                ClearForm();
                ShowMessage(isEdit ? "Customer details updated." : "Customer added.", true);
                BindCustomers();
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2601 || ex.Number == 2627)
                    ShowMessage("That email address is already used by an account.", false);
                else
                    ShowError("Unable to save the customer.", ex);
            }
            catch (Exception ex)
            {
                ShowError("Unable to save the customer.", ex);
            }
        }

        protected void rptCustomers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int userId;
            if (!Int32.TryParse(Convert.ToString(e.CommandArgument), out userId)) return;

            if (e.CommandName == "EditCustomer")
            {
                LoadCustomer(userId);
            }
            else if (e.CommandName == "ToggleStatus")
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(ConnectionString))
                    using (SqlCommand command = new SqlCommand(@"
UPDATE dbo.Users
SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END, UpdatedAt = SYSUTCDATETIME()
WHERE UserID = @UserID
  AND RoleID = (SELECT RoleID FROM dbo.Roles WHERE RoleName = N'Customer' AND IsStaffRole = 0);", connection))
                    {
                        command.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                        connection.Open();
                        if (command.ExecuteNonQuery() == 1)
                            ShowMessage("Customer status updated.", true);
                        else
                            ShowMessage("Customer not found.", false);
                    }
                }
                catch (Exception ex)
                {
                    ShowError("Unable to update the customer status.", ex);
                }

                BindCustomers();
            }
        }

        private void BindCustomers()
        {
            try
            {
                const string query = @"
SELECT u.UserID AS CustomerID,
       u.FirstName + N' ' + u.LastName AS FullName,
       u.EmailAddress,
       u.PhoneNumber,
       COUNT(b.BookingID) AS BookingCount,
       u.IsActive,
       CASE WHEN u.IsActive = 1 THEN N'Active' ELSE N'Inactive' END AS Status
FROM dbo.Users AS u
INNER JOIN dbo.Roles AS r ON r.RoleID = u.RoleID
LEFT JOIN dbo.Bookings AS b ON b.CustomerUserID = u.UserID
WHERE r.RoleName = N'Customer'
  AND r.IsStaffRole = 0
  AND (@Search = N'' OR u.FirstName LIKE N'%' + @Search + N'%' OR u.LastName LIKE N'%' + @Search + N'%'
       OR u.EmailAddress LIKE N'%' + @Search + N'%' OR u.PhoneNumber LIKE N'%' + @Search + N'%')
  AND (@Status = -1 OR u.IsActive = @Status)
GROUP BY u.UserID, u.FirstName, u.LastName, u.EmailAddress, u.PhoneNumber, u.IsActive
ORDER BY u.LastName, u.FirstName;";

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                using (SqlCommand command = new SqlCommand(query, connection))
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    command.Parameters.Add("@Search", SqlDbType.NVarChar, 200).Value = (txtSearch.Text ?? String.Empty).Trim();
                    command.Parameters.Add("@Status", SqlDbType.Int).Value = ddlStatus.SelectedValue == String.Empty ? -1 : Convert.ToInt32(ddlStatus.SelectedValue);

                    DataTable customers = new DataTable();
                    adapter.Fill(customers);
                    rptCustomers.DataSource = customers;
                    rptCustomers.DataBind();
                    pnlNoCustomers.Visible = customers.Rows.Count == 0;
                }
            }
            catch (Exception ex)
            {
                rptCustomers.DataSource = null;
                rptCustomers.DataBind();
                pnlNoCustomers.Visible = false;
                ShowError("Unable to load customers.", ex);
            }
        }

        private void LoadCustomer(int userId)
        {
            try
            {
                const string query = @"
SELECT u.UserID, u.FirstName, u.LastName, u.EmailAddress, u.PhoneNumber, u.DateOfBirth, u.IsActive
FROM dbo.Users AS u
INNER JOIN dbo.Roles AS r ON r.RoleID = u.RoleID
WHERE u.UserID = @UserID AND r.RoleName = N'Customer' AND r.IsStaffRole = 0;";

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) { ShowMessage("Customer not found.", false); return; }
                        hfCustomerUserId.Value = reader["UserID"].ToString();
                        txtFirstName.Text = reader["FirstName"].ToString();
                        txtLastName.Text = reader["LastName"].ToString();
                        txtEmailAddress.Text = reader["EmailAddress"].ToString();
                        txtPhoneNumber.Text = reader["PhoneNumber"] == DBNull.Value ? String.Empty : reader["PhoneNumber"].ToString();
                        txtDateOfBirth.Text = reader["DateOfBirth"] == DBNull.Value ? String.Empty : Convert.ToDateTime(reader["DateOfBirth"]).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
                        txtIDNumber.Text = String.Empty;
                        chkActive.Checked = Convert.ToBoolean(reader["IsActive"]);
                    }
                }

                lblFormHeading.Text = "Edit Customer";
                customerPasswordRow.Visible = false;
                customerTermsRow.Visible = false;
                btnSaveCustomer.Text = "Save Changes";
                pnlCustomerForm.Visible = true;
                pnlMessage.Visible = false;
            }
            catch (Exception ex)
            {
                ShowError("Unable to load this customer.", ex);
            }
        }

        private void ClearForm()
        {
            hfCustomerUserId.Value = String.Empty;
            txtFirstName.Text = String.Empty;
            txtLastName.Text = String.Empty;
            txtEmailAddress.Text = String.Empty;
            txtPhoneNumber.Text = String.Empty;
            txtDateOfBirth.Text = String.Empty;
            txtIDNumber.Text = String.Empty;
            txtCustomerPassword.Text = String.Empty;
            txtConfirmPassword.Text = String.Empty;
            chkTermsAccepted.Checked = false;
            chkActive.Checked = true;
        }

        private static bool IsValidEmail(string email)
        {
            try
            {
                return new MailAddress(email).Address == email;
            }
            catch (FormatException)
            {
                return false;
            }
        }

        private static bool IsValidSouthAfricanId(string idNumber)
        {
            if (idNumber == null || idNumber.Length != 13) return false;
            foreach (char character in idNumber)
                if (character < '0' || character > '9') return false;
            return true;
        }

        private void ShowMessage(string message, bool success)
        {
            pnlMessage.CssClass = success ? "alert alert-success" : "alert alert-danger";
            lblMessage.Text = Server.HtmlEncode(message);
            pnlMessage.Visible = true;
        }

        // On your own PC the real reason is added, so a connection problem is easy to find.
        // Visitors on other machines only see the short message.
        private void ShowError(string message, Exception ex)
        {
            if (Request.IsLocal) message += " (" + ex.Message + ")";
            ShowMessage(message, false);
        }

    }
}