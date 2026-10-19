using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class WebForm9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Convert.ToBoolean(Session["LoggedIn"] ?? false))
            {
                RedirectForRole(Convert.ToString(Session["UserRole"]));
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Text = string.Empty;

            string email = (txtEmail.Text ?? string.Empty).Trim().ToLowerInvariant();
            string password = txtPassword.Text ?? string.Empty;

            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrEmpty(password))
            {
                ShowMessage("Enter your email address and password.");
                return;
            }

            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["ForteDB"];
            if (settings == null)
            {
                ShowMessage("The ForteDB connection is not configured.");
                return;
            }

            try
            {
                int userId;
                string fullName;
                string storedHash;
                string role;

                using (SqlConnection connection = new SqlConnection(settings.ConnectionString))
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"
SELECT TOP (1)
    u.UserID,
    COALESCE(NULLIF(u.FullName, N''), LTRIM(RTRIM(CONCAT(u.FirstName, N' ', u.LastName)))) AS FullName,
    u.PasswordHash,
    COALESCE(NULLIF(r.RoleName, N''), NULLIF(u.UserRole, N'')) AS UserRole,
    u.IsActive
FROM dbo.Users AS u
LEFT JOIN dbo.Roles AS r ON r.RoleID = u.RoleID
WHERE LOWER(COALESCE(NULLIF(u.Email, N''), u.EmailAddress)) = @Email;";
                    command.Parameters.Add("@Email", SqlDbType.NVarChar, 254).Value = email;

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader(CommandBehavior.SingleRow))
                    {
                        if (!reader.Read() || !Convert.ToBoolean(reader["IsActive"]))
                        {
                            ShowMessage("The email address or password is incorrect.");
                            return;
                        }

                        userId = Convert.ToInt32(reader["UserID"]);
                        fullName = Convert.ToString(reader["FullName"]);
                        storedHash = Convert.ToString(reader["PasswordHash"]);
                        role = Convert.ToString(reader["UserRole"]);
                    }
                }

                if (string.IsNullOrWhiteSpace(storedHash) ||
                    !RegistrationSecurityService.VerifyPassword(password, storedHash))
                {
                    ShowMessage("The email address or password is incorrect.");
                    return;
                }

                if (!IsKnownRole(role))
                {
                    ShowMessage("This account does not have an active system role.");
                    return;
                }

                Session["LoggedIn"] = true;
                Session["UserID"] = userId;
                Session["UserEmail"] = email;
                Session["UserName"] = string.IsNullOrWhiteSpace(fullName) ? email : fullName;
                Session["UserRole"] = role;

                string returnUrl = Request.QueryString["returnUrl"];
                if (IsLocalReturnUrl(returnUrl))
                {
                    Response.Redirect(returnUrl, false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                RedirectForRole(role);
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Trace.TraceError("FEHMS login SQL error: " + ex);
                ShowMessage("Unable to sign in right now. Check the database connection and try again.");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError("FEHMS login error: " + ex);
                ShowMessage("Unable to sign in right now. Please try again.");
            }
        }

        private bool IsKnownRole(string role)
        {
            return string.Equals(role, "Customer", StringComparison.OrdinalIgnoreCase) ||
                   IsStaffRole(role);
        }

        private bool IsStaffRole(string role)
        {
            return string.Equals(role, "Administrator", StringComparison.OrdinalIgnoreCase) ||
                   string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase) ||
                   string.Equals(role, "Manager", StringComparison.OrdinalIgnoreCase) ||
                   string.Equals(role, "Delivery Staff", StringComparison.OrdinalIgnoreCase) ||
                   string.Equals(role, "Collection Staff", StringComparison.OrdinalIgnoreCase) ||
                   string.Equals(role, "Staff", StringComparison.OrdinalIgnoreCase);
        }

        private bool IsLocalReturnUrl(string returnUrl)
        {
            return !string.IsNullOrWhiteSpace(returnUrl) &&
                   returnUrl.StartsWith("/Presentation/", StringComparison.OrdinalIgnoreCase) &&
                   !returnUrl.Contains("..") &&
                   !returnUrl.StartsWith("//", StringComparison.Ordinal);
        }

        private void RedirectForRole(string role)
        {
            string destination = string.Equals(role, "Customer", StringComparison.OrdinalIgnoreCase)
                ? "~/Presentation/CustomerDashboard.aspx"
                : "~/Presentation/StaffDashBoard.aspx";

            Response.Redirect(ResolveUrl(destination), false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void ShowMessage(string message)
        {
            lblMessage.Text = HttpUtility.HtmlEncode(message);
        }
    }
}
