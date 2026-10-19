using FEHMS_FortEventHireManagementSystem;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class WebForm9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            // Get the information entered by the user.
            string email = txtEmail.Text.Trim().ToLowerInvariant();
            string password = txtPassword.Text;

            // Check that both fields are completed.
            if (string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(password))
            {
                lblMessage.Text = "Please enter your email and password.";
                return;
            }

            // Read the database connection from Web.config.
            var settings =
                ConfigurationManager.ConnectionStrings["ForteDB"];

            if (settings == null)
            {
                lblMessage.Text = "Database connection is not configured.";
                return;
            }

            try
            {
                using (SqlConnection connection =
                    new SqlConnection(settings.ConnectionString))
                {
                    connection.Open();

                    // Find the account using the email address.
                    string query =
                        @"SELECT
                              UserID,
                              Email,
                              FullName,
                              PasswordHash,
                              UserRole,
                              IsActive
                          FROM dbo.Users
                          WHERE Email = @Email";

                    using (SqlCommand command =
                        new SqlCommand(query, connection))
                    {
                        command.Parameters.Add(
                            "@Email",
                            SqlDbType.NVarChar,
                            254).Value = email;

                        using (SqlDataReader reader =
                            command.ExecuteReader())
                        {
                            if (!reader.Read())
                            {
                                lblMessage.Text =
                                    "Invalid email or password.";
                                return;
                            }

                            int userID =
                                Convert.ToInt32(reader["UserID"]);

                            string fullName =
                                reader["FullName"].ToString();

                            string userEmail =
                                reader["Email"].ToString();

                            string storedPasswordHash =
                                reader["PasswordHash"].ToString();

                            string userRole =
                                reader["UserRole"].ToString();

                            bool isActive =
                                Convert.ToBoolean(reader["IsActive"]);

                            // Verify the account is active.
                            if (!isActive)
                            {
                                lblMessage.Text =
                                    "This account is currently inactive.";
                                return;
                            }

                            // Verify the entered password.
                            bool validPassword =
                                RegistrationSecurityService.VerifyPassword(
                                    password,
                                    storedPasswordHash);

                            if (!validPassword)
                            {
                                lblMessage.Text =
                                    "Invalid email or password.";
                                return;
                            }

                            // Clear any existing session information.
                            Session.Clear();

                            // Regenerate the session identifier.
                            SessionIDManager manager =
                                new SessionIDManager();

                            string newSessionID = manager.CreateSessionID(Context);
                            bool redirected;
                            bool cookieAdded;

                            manager.SaveSessionID(
                                Context,
                                newSessionID,
                                out redirected,
                                out cookieAdded);

                            // Store the authenticated user's information.
                            Session["LoggedIn"] = true;
                            Session["UserID"] = userID;
                            Session["FullName"] = fullName;
                            Session["UserEmail"] = userEmail;
                            Session["UserRole"] = userRole;

                            // Redirect according to the user's role.
                            if (userRole.Equals(
                                "Admin",
                                StringComparison.OrdinalIgnoreCase))
                            {
                                Response.Redirect(
                                    "~/Presentation/StaffDashboard.aspx",
                                    false);
                            }
                            else if (userRole.Equals(
                                "Staff",
                                StringComparison.OrdinalIgnoreCase))
                            {
                                Response.Redirect(
                                    "~/Presentation/StaffDashboard.aspx",
                                    false);
                            }
                            else if (userRole.Equals(
                                "Customer",
                                StringComparison.OrdinalIgnoreCase))
                            {
                                Response.Redirect(
                                    "~/Presentation/CustomerDashboard.aspx",
                                    false);
                            }
                            else
                            {
                                Session.Clear();

                                lblMessage.Text =
                                    "Your account does not have a valid role.";

                                return;
                            }

                            Context.ApplicationInstance.CompleteRequest();
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "FEHMS login database error: " + ex);

                lblMessage.Text =
                    "Unable to sign in right now. Please try again.";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "FEHMS login error: " + ex);

                lblMessage.Text =
                    "An unexpected error occurred. Please try again.";
            }
        }
    }
}
