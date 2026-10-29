using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace FEHMS_FortEventHireManagementSystem.Service
{
        public static class EmailService
        {
            public static void SendPasswordResetEmail(
                string recipientEmail,
                string resetLink)
            {
                string host = ConfigurationManager
                    .AppSettings["SMTPHost"];

                string portValue = ConfigurationManager
                    .AppSettings["SMTPPort"];

                string senderEmail = ConfigurationManager
                    .AppSettings["SMTPEmail"];

                string sslValue = ConfigurationManager
                    .AppSettings["SMTPEnableSSL"];

                string appPassword = Environment
                    .GetEnvironmentVariable(
                        "FEHMS_SMTP_APP_PASSWORD");

                if (string.IsNullOrWhiteSpace(host) ||
                    string.IsNullOrWhiteSpace(senderEmail) ||
                    string.IsNullOrWhiteSpace(appPassword))
                {
                    throw new InvalidOperationException(
                        "FEHMS email configuration is incomplete.");
                }

                int port = int.Parse(portValue);
                bool enableSsl = bool.Parse(sslValue);

                using (MailMessage message = new MailMessage())
                {
                    message.From = new MailAddress(
                        senderEmail,
                        "FEHMS Support");

                    message.To.Add(recipientEmail);

                    message.Subject =
                        "FEHMS - Reset Your Password";

                    message.Body =
                        "Hello,\n\n" +
                        "We received a request to reset your " +
                        "FEHMS account password.\n\n" +
                        "Use the following link to reset it:\n\n" +
                        resetLink + "\n\n" +
                        "This link expires in 30 minutes.\n\n" +
                        "If you did not request this reset, " +
                        "you can ignore this email.\n\n" +
                        "FEHMS Support Team";

                    using (SmtpClient smtp = new SmtpClient(host, port))
                    {
                        smtp.EnableSsl = enableSsl;

                        smtp.Credentials =
                            new NetworkCredential(
                                senderEmail,
                                appPassword);

                        smtp.Send(message);
                    }
                }
            }
        }
    }
