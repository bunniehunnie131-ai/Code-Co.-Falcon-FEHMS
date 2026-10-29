using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                if (!IsPostBack)
                {
                    if (GetTokenHash() == null)
                    {
                        ShowMessage(
                            "This password-reset link is invalid.",
                            false);

                        btnResetPassword.Enabled = false;
                    }
                }
            }

            protected void btnResetPassword_Click(
                object sender, EventArgs e)
            {
                string newPassword = txtNewPassword.Text;
                string confirmPassword = txtConfirmPassword.Text;

                byte[] tokenHash = GetTokenHash();

                if (tokenHash == null)
                {
                    ShowMessage(
                        "This password-reset link is invalid.",
                        false);
                    return;
                }

                if (string.IsNullOrEmpty(newPassword) ||
                    newPassword.Length < 12)
                {
                    ShowMessage(
                        "Your password must contain at least 12 characters.",
                        false);
                    return;
                }

                if (newPassword != confirmPassword)
                {
                    ShowMessage(
                        "The passwords do not match.",
                        false);
                    return;
                }

                try
                {
                    string connectionString =
                        ConfigurationManager.ConnectionStrings[
                            "ForteDB"].ConnectionString;

                    using (SqlConnection connection =
                        new SqlConnection(connectionString))
                    {
                        connection.Open();

                        using (SqlTransaction transaction =
                            connection.BeginTransaction(
                                IsolationLevel.Serializable))
                        {
                            int userId;
                            int resetId;

                            using (SqlCommand findCommand =
                                new SqlCommand(@"
                                SELECT TOP (1)
                                    pr.ResetID,
                                    pr.UserID
                                FROM PasswordResetTokens pr
                                INNER JOIN Users u
                                    ON u.UserID = pr.UserID
                                WHERE pr.TokenHash = @TokenHash
                                  AND pr.UsedAt IS NULL
                                  AND pr.ExpiresAt > SYSUTCDATETIME()
                                  AND u.IsActive = 1",
                                    connection, transaction))
                            {
                                findCommand.Parameters.Add(
                                    "@TokenHash",
                                    SqlDbType.VarBinary, 32).Value = tokenHash;

                                using (SqlDataReader reader =
                                    findCommand.ExecuteReader())
                                {
                                    if (!reader.Read())
                                    {
                                        ShowMessage(
                                            "This reset link has expired or has already been used. Please request a new link.",
                                            false);

                                        transaction.Rollback();
                                        return;
                                    }

                                    resetId = reader.GetInt32(0);
                                    userId = reader.GetInt32(1);
                                }
                            }

                            string passwordHash =
                                RegistrationSecurityService.HashPassword(
                                    newPassword);

                            using (SqlCommand updatePassword =
                                new SqlCommand(@"
                                UPDATE Users
                                SET PasswordHash = @PasswordHash
                                WHERE UserID = @UserID
                                  AND IsActive = 1",
                                    connection, transaction))
                            {
                                updatePassword.Parameters.Add(
                                    "@PasswordHash",
                                    SqlDbType.NVarChar, 500).Value = passwordHash;

                                updatePassword.Parameters.Add(
                                    "@UserID",
                                    SqlDbType.Int).Value = userId;

                                if (updatePassword.ExecuteNonQuery() != 1)
                                {
                                    transaction.Rollback();
                                    ShowMessage(
                                        "Unable to reset your password. Please request a new link.",
                                        false);
                                    return;
                                }
                            }

                            using (SqlCommand markUsed =
                                new SqlCommand(@"
                                UPDATE PasswordResetTokens
                                SET UsedAt = SYSUTCDATETIME()
                                WHERE UserID = @UserID
                                  AND UsedAt IS NULL",
                                    connection, transaction))
                            {
                                markUsed.Parameters.Add(
                                    "@UserID",
                                    SqlDbType.Int).Value = userId;

                                markUsed.ExecuteNonQuery();
                            }

                            transaction.Commit();
                        }
                    }

                    txtNewPassword.Text = "";
                    txtConfirmPassword.Text = "";
                    btnResetPassword.Enabled = false;

                    ShowMessage(
                        "Your password has been reset successfully. You can now log in.",
                        true);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Trace.TraceError(
                        "Password reset failed: " + ex);

                    ShowMessage(
                        "Unable to reset your password right now. Please try again.",
                        false);
                }
            }

            private byte[] GetTokenHash()
            {
                string token = Request.QueryString["token"];

                if (string.IsNullOrWhiteSpace(token))
                    return null;

                try
                {
                    string base64 = token
                        .Replace('-', '+')
                        .Replace('_', '/');

                    switch (base64.Length % 4)
                    {
                        case 2:
                            base64 += "==";
                            break;
                        case 3:
                            base64 += "=";
                            break;
                        case 1:
                            return null;
                    }

                    byte[] tokenBytes =
                        Convert.FromBase64String(base64);

                    if (tokenBytes.Length != 32)
                        return null;

                    using (SHA256 sha = SHA256.Create())
                    {
                        return sha.ComputeHash(tokenBytes);
                    }
                }
                catch (FormatException)
                {
                    return null;
                }
            }

            private void ShowMessage(
                string message, bool success)
            {
                lblMessage.Text = message;
                lblMessage.ForeColor = success
                    ? System.Drawing.Color.Green
                    : System.Drawing.Color.DarkRed;
            }
        }
    }

