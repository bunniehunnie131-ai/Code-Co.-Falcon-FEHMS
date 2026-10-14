
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Net.Mail;
using System.Web;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Check required fields.
            if (string.IsNullOrWhiteSpace(txtFullName.Text) ||
                string.IsNullOrWhiteSpace(txtEmailAddress.Text) ||
                string.IsNullOrWhiteSpace(txtDateOfBirth.Text) ||
                string.IsNullOrWhiteSpace(txtIDNumber.Text) ||
                string.IsNullOrWhiteSpace(txtPassword.Text) ||
                string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                ShowMessage("Please complete all registration fields.");
                return;
            }

            string fullName = txtFullName.Text.Trim();
            string email = txtEmailAddress.Text.Trim().ToLowerInvariant();
            string idNumber = txtIDNumber.Text.Trim();
            string password = txtPassword.Text;

            // Validate name and email lengths.
            if (fullName.Length > 150 || email.Length > 254)
            {
                ShowMessage("Name or email address is too long.");
                return;
            }

            // Validate email.
            try
            {
                MailAddress address = new MailAddress(email);

                if (!address.Address.Equals(
                    email,
                    StringComparison.OrdinalIgnoreCase))
                {
                    ShowMessage("Please enter a valid email address.");
                    return;
                }
            }
            catch (FormatException)
            {
                ShowMessage("Please enter a valid email address.");
                return;
            }

            // Validate date of birth.
            DateTime dateOfBirth;

            if (!DateTime.TryParseExact(
                txtDateOfBirth.Text.Trim(),
                "yyyy-MM-dd",
                CultureInfo.InvariantCulture,
                DateTimeStyles.None,
                out dateOfBirth))
            {
                ShowMessage("Please enter a valid date of birth.");
                return;
            }

            if (dateOfBirth.Date > DateTime.Today ||
                dateOfBirth.Year < 1900)
            {
                ShowMessage("Please enter a valid date of birth.");
                return;
            }

            // Validate the South African ID number format.
            if (idNumber.Length != 13)
            {
                ShowMessage("ID number must contain 13 digits.");
                return;
            }

            foreach (char character in idNumber)
            {
                if (character < '0' || character > '9')
                {
                    ShowMessage("ID number must contain digits only.");
                    return;
                }
            }

            // Check passwords.
            if (password != txtConfirmPassword.Text)
            {
                ShowMessage("Passwords do not match.");
                return;
            }

            if (password.Length < 12)
            {
                ShowMessage(
                    "Password must contain at least 12 characters.");
                return;
            }

            // Check Terms and Conditions.
            if (!cbUserAgreement.Checked)
            {
                ShowMessage(
                    "Please accept the Terms and Conditions.");
                return;
            }

            // Get the database connection from Web.config.
            var settings =
                ConfigurationManager.ConnectionStrings["ForteDB"];

            if (settings == null)
            {
                ShowMessage("Database connection is not configured.");
                return;
            }

            try
            {
                // Protect sensitive customer information.
                string passwordHash =
                    RegistrationSecurityService.HashPassword(password);

                byte[] encryptedID =
                    RegistrationSecurityService.EncryptIDNumber(idNumber);

                using (SqlConnection connection =
                    new SqlConnection(settings.ConnectionString))
                {
                    connection.Open();

                    // Both database inserts must succeed together.
                    using (SqlTransaction transaction =
                        connection.BeginTransaction())
                    {
                        try
                        {
                            // Check whether email is already registered.
                            string checkSql =
                                @"SELECT COUNT(1)
                                  FROM dbo.Users
                                  WHERE Email = @Email";

                            using (SqlCommand checkCommand =
                                new SqlCommand(
                                    checkSql,
                                    connection,
                                    transaction))
                            {
                                checkCommand.Parameters.Add(
                                    "@Email",
                                    SqlDbType.NVarChar,
                                    254).Value = email;

                                int count = Convert.ToInt32(
                                    checkCommand.ExecuteScalar());

                                if (count > 0)
                                {
                                    transaction.Rollback();

                                    ShowMessage(
                                        "This email address is already registered.");
                                    return;
                                }
                            }

                            // Insert customer login details into Users.
                            string insertUserSql =
                                @"INSERT INTO dbo.Users
                                  (
                                      FullName,
                                      Email,
                                      DateOfBirth,
                                      IDNumberEncrypted,
                                      PasswordHash,
                                      UserRole,
                                      IsActive,
                                      TermsAcceptedAt
                                  )
                                  OUTPUT INSERTED.UserID
                                  VALUES
                                  (
                                      @FullName,
                                      @Email,
                                      @DateOfBirth,
                                      @IDNumberEncrypted,
                                      @PasswordHash,
                                      'Customer',
                                      1,
                                      SYSDATETIME()
                                  );";

                            int newUserID;

                            using (SqlCommand userCommand =
                                new SqlCommand(
                                    insertUserSql,
                                    connection,
                                    transaction))
                            {
                                userCommand.Parameters.Add(
                                    "@FullName",
                                    SqlDbType.NVarChar,
                                    150).Value = fullName;

                                userCommand.Parameters.Add(
                                    "@Email",
                                    SqlDbType.NVarChar,
                                    254).Value = email;

                                userCommand.Parameters.Add(
                                    "@DateOfBirth",
                                    SqlDbType.Date).Value = dateOfBirth.Date;

                                userCommand.Parameters.Add(
                                    "@IDNumberEncrypted",
                                    SqlDbType.VarBinary,
                                    -1).Value = encryptedID;

                                userCommand.Parameters.Add(
                                    "@PasswordHash",
                                    SqlDbType.NVarChar,
                                    512).Value = passwordHash;

                                newUserID = Convert.ToInt32(
                                    userCommand.ExecuteScalar());
                            }

                            // Create the linked Customer record.
                            string insertCustomerSql =
                                @"INSERT INTO dbo.Customer
                                  (
                                      UserID,
                                      Phone,
                                      Address
                                  )
                                  VALUES
                                  (
                                      @UserID,
                                      NULL,
                                      NULL
                                  );";

                            using (SqlCommand customerCommand =
                                new SqlCommand(
                                    insertCustomerSql,
                                    connection,
                                    transaction))
                            {
                                customerCommand.Parameters.Add(
                                    "@UserID",
                                    SqlDbType.Int).Value = newUserID;

                                customerCommand.ExecuteNonQuery();
                            }

                            // Save both records.
                            transaction.Commit();
                        }
                        catch
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }

                // Send customer to login page.
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "FEHMS registration SQL error: " + ex);

                if (ex.Number == 2601 || ex.Number == 2627)
                {
                    ShowMessage(
                        "This email address is already registered.");
                }
                else
                {
                    ShowMessage(
                        "Registration failed. Please try again.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "FEHMS registration error: " + ex);

                ShowMessage(
                    "An error occurred during registration.");
            }
        }

        private void ShowMessage(string message)
        {
            string safeMessage =
                HttpUtility.JavaScriptStringEncode(message);

            ClientScript.RegisterStartupScript(
                GetType(),
                "registrationMessage",
                "alert('" + safeMessage + "');",
                true);
        }
    }
}
