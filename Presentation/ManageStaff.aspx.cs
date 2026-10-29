using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageStaff : Page
    {
        private string ConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["ForteDB"].ConnectionString; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRoles();
                BindStaff();
            }
        }
        private void BindRoles()
        {
            using (SqlConnection c = new SqlConnection(ConnectionString))
            using (SqlDataAdapter a = new SqlDataAdapter("SELECT RoleName,RoleName AS Value FROM dbo.Roles WHERE IsStaffRole=1 AND IsActive=1 AND RoleName NOT IN (N'Administrator',N'Admin',N'Manager')" +
                " ORDER BY RoleName;", c))
            {
                DataTable d = new DataTable(); a.Fill(d); ddlRole.DataSource = d; ddlRole.DataTextField = "RoleName";
                ddlRole.DataValueField = "Value"; ddlRole.DataBind();
            }
        }
        private void BindStaff()
        {
            using (SqlConnection c = new SqlConnection(ConnectionString))
            using (SqlDataAdapter a = new SqlDataAdapter(@"SELECT s.UserID,s.StaffNumber,u.FirstName+N' '+u.LastName AS FullName,u.EmailAddress,s.JobTitle,r.RoleName,u.IsActive,CASE WHEN u.IsActive=1 THEN N'Active' ELSE N'Inactive' END AS Status FROM dbo.Staff s JOIN dbo.Users u ON u.UserID=s.UserID JOIN dbo.Roles r ON r.RoleID=u.RoleID ORDER BY u.LastName,u.FirstName;", c))
            {
                DataTable d = new DataTable(); a.Fill(d); gvStaff.DataSource = d; gvStaff.DataBind();
            }
        }
        protected void btnShowAdd_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = true;
            pnlMessage.Visible = false;
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string first = txtFirstName.Text.Trim(), last = txtLastName.Text.Trim(), email = txtEmail.Text.Trim();
            if (first.Length == 0 || last.Length == 0 || txtPassword.Text.Length < 10)
            {
                Show("Enter a first name, last name and a temporary password of at least 10 characters.", false);
                return;
            }
            try
            {
                if (new MailAddress(email).Address != email)
                {
                    Show("Enter a valid email address.", false); return;
                }
            }
            catch
            {
                Show("Enter a valid email address.", false);
                return;
            }
            if (String.IsNullOrWhiteSpace(ddlRole.SelectedValue))
            {
                Show("Choose a staff role.", false);
                return;
            }
            using (SqlConnection c = new SqlConnection(ConnectionString))
            {
                c.Open();
                using (SqlTransaction tx = c.BeginTransaction())
                {
                    try
                    {
                        int userId;
                        using (SqlCommand q = new SqlCommand(@"INSERT dbo.Users(FullName,FirstName,LastName,Email,EmailAddress,PhoneNumber,PasswordHash,UserRole,RoleID,IsActive) SELECT @FullName,@First,@Last,@Email,@Email,@Phone,@Hash,r.RoleName,r.RoleID,1 FROM dbo.Roles r WHERE r.RoleName=@Role AND r.IsStaffRole=1 AND r.IsActive=1; SELECT CONVERT(int,SCOPE_IDENTITY());", c, tx))
                        {
                            q.Parameters.AddWithValue("@FullName", first + " " + last);
                            q.Parameters.AddWithValue("@First", first);
                            q.Parameters.AddWithValue("@Last", last);
                            q.Parameters.AddWithValue("@Email", email);
                            q.Parameters.AddWithValue("@Phone", String.IsNullOrWhiteSpace(txtPhone.Text) ? (object)DBNull.Value : txtPhone.Text.Trim());
                            q.Parameters.AddWithValue("@Hash", FEHMS_FortEventHireManagementSystem.RegistrationSecurityService.HashPassword(txtPassword.Text));
                            q.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);
                            userId = Convert.ToInt32(q.ExecuteScalar());
                        }
                        if (userId <= 0) throw new InvalidOperationException("The selected staff role is unavailable.");
                        string staffNo = "STF" + userId.ToString("D6");
                        using (SqlCommand q = new SqlCommand("INSERT dbo.Staff(UserID,StaffNumber,JobTitle,HireDate,IsActive) VALUES(@ID,@No,@Title,CONVERT(date,SYSUTCDATETIME()),1);", c, tx))
                        {
                            q.Parameters.AddWithValue("@ID", userId);
                            q.Parameters.AddWithValue("@No", staffNo);
                            q.Parameters.AddWithValue("@Title", String.IsNullOrWhiteSpace(txtJobTitle.Text) ? (object)DBNull.Value : txtJobTitle.Text.Trim());
                            q.ExecuteNonQuery();
                        }
                        tx.Commit();
                        pnlForm.Visible = false;
                        txtPassword.Text = String.Empty;
                        Show("Staff account created. Give the temporary password to the staff member securely and ask them to change it.", true);
                        BindStaff();
                    }
                    catch (Exception ex)
                    {
                        try
                        {
                            tx.Rollback();
                        }
                        catch
                        {
                        }
                        System.Diagnostics.Trace.TraceError("Manage staff create error: " + ex);
                        Show(ex is SqlException && (((SqlException)ex).Number == 2601 || ((SqlException)ex).Number == 2627) ? "That email is already registered." : "The staff account could not be created.", false);
                    }
                }
            }
        }
        protected void gvStaff_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Toggle") return; int id;
            if (!Int32.TryParse(Convert.ToString(e.CommandArgument), out id)) return;
            using (SqlConnection c = new SqlConnection(ConnectionString))
            using (SqlCommand q = new SqlCommand("UPDATE dbo.Users SET IsActive=1-IsActive,UpdatedAt=SYSUTCDATETIME()" +
                " WHERE UserID=@ID AND RoleID IN(SELECT RoleID FROM dbo.Roles WHERE IsStaffRole=1 AND RoleName NOT IN(N'Administrator',N'Admin',N'Manager'));" +
                " UPDATE dbo.Staff SET IsActive=(SELECT IsActive FROM dbo.Users WHERE UserID=@ID) WHERE UserID=@ID;", c))
            {
                q.Parameters.AddWithValue("@ID", id); c.Open();
                q.ExecuteNonQuery();
            }
            Show("Staff access updated.", true);
            BindStaff();
        }
        private void Show(string text, bool ok)
        {
            lblMessage.Text = HttpUtility.HtmlEncode(text);
            pnlMessage.CssClass = ok ? "alert alert-success" : "alert alert-danger"; pnlMessage.Visible = true;
        }

    }
}

