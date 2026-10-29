using FEHMS_FortEventHireManagementSystem.Service;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
            protected void btnSendLink_Click(object sender, EventArgs e)
            {
                const string confirmation =
                    "If an active account exists for this email, " +
                    "a password-reset link will be sent.";

                string email = txtEmail.Text.Trim().ToLowerInvariant();

                if (string.IsNullOrWhiteSpace(email))
                {
                    lblMessage.Text = "Please enter your email address.";
                    return;
                }

                try
                {
                    MailAddress address = new MailAddress(email);

                    if (email.Length > 254 ||
                        !address.Address.Equals(
                            email, StringComparison.OrdinalIgnoreCase))
                    {
                        lblMessage.Text = "Enter a valid email address.";
                        return;
                    }
                }
                catch (FormatException)
                {
                    lblMessage.Text = "Enter a valid email address.";
                    return;
                }

                try
                {
                    string connectionString =
                        ConfigurationManager
                            .ConnectionStrings["ForteDB"]
                            .ConnectionString;

                    int? userId = null;

                    using (SqlConnection connection =
                        new SqlConnection(connectionString))
                    {
                        connection.Open();

                        const string findUserSql =
                            @"SELECT UserID
                          FROM dbo.Users
                          WHERE Email = @Email
                            AND IsActive = 1";

                        using (SqlCommand command =
                            new SqlCommand(findUserSql, connection))
                        {
                            command.Parameters.Add(
                                "@Email", SqlDbType.NVarChar, 254
                            ).Value = email;

                            object result = command.ExecuteScalar();

                            if (result != null && result != DBNull.Value)
                            {
                                userId = Convert.ToInt32(result);
                            }
                        }

                        if (userId.HasValue)
                        {
                            // Generate 32 cryptographically random bytes.
                            byte[] tokenBytes = new byte[32];

                            using (RandomNumberGenerator rng =
                                RandomNumberGenerator.Create())
                            {
                                rng.GetBytes(tokenBytes);
                            }

                            // Encode the token for use in a URL.
                            string token = Convert.ToBase64String(tokenBytes)
                                .TrimEnd('=')
                                .Replace('+', '-')
                                .Replace('/', '_');

                            // Store only the SHA-256 hash.
                            byte[] tokenHash;

                            using (SHA256 sha = SHA256.Create())
                            {
                                tokenHash = sha.ComputeHash(tokenBytes);
                            }

                            DateTime expiresAt =
                                DateTime.UtcNow.AddMinutes(30);

                            const string insertSql =
                                @"INSERT INTO dbo.PasswordResetTokens
                              (UserID, TokenHash, CreatedAt, ExpiresAt)
                              VALUES
                              (@UserID, @TokenHash,
                               @CreatedAt, @ExpiresAt)";

                            using (SqlCommand command =
                                new SqlCommand(insertSql, connection))
                            {
                                command.Parameters.Add(
                                    "@UserID", SqlDbType.Int
                                ).Value = userId.Value;

                                command.Parameters.Add(
                                    "@TokenHash", SqlDbType.VarBinary, 32
                                ).Value = tokenHash;

                                command.Parameters.Add(
                                    "@CreatedAt", SqlDbType.DateTime2
                                ).Value = DateTime.UtcNow;

                                command.Parameters.Add(
                                    "@ExpiresAt", SqlDbType.DateTime2
                                ).Value = expiresAt;

                                command.ExecuteNonQuery();
                            }

                            string resetLink =
                                Request.Url.GetLeftPart(
                                    UriPartial.Authority) +
                                ResolveUrl("~/Presentation/ResetPassword.aspx") +
                                "?token=" + HttpUtility.UrlEncode(token);

                            EmailService.SendPasswordResetEmail(
                                email, resetLink);
                        }
                    }

                    lblMessage.Text = confirmation;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Trace.TraceError(
                        "FEHMS password reset request error: " + ex);

                    lblMessage.Text =
                        "Unable to process the request right now. " +
                        "Please try again later.";
                }
            }
        }
    }
