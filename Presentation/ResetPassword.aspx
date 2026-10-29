<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ResetPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Password | Forte Events</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0" />

    <link href="../Forte.css" rel="stylesheet" />

    <style>
        .reset-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            background: var(--background-color, #f4f6f9);
        }

        .reset-card {
            width: 100%;
            max-width: 440px;
            padding: 35px;
            background: var(--surface-color, #ffffff);
            border: 1px solid var(--border-color, #e2e8f0);
            border-radius: 14px;
            box-shadow: 0 12px 35px rgba(15,23,42,.12);
        }

        .reset-brand {
            text-align: center;
            color: #1e3a8a;
            font-weight: 800;
            letter-spacing: 1px;
            margin-bottom: 24px;
        }

        .reset-title {
            text-align: center;
            color: #1e3a8a;
            margin-bottom: 10px;
        }

        .reset-description {
            text-align: center;
            color: #64748b;
            margin-bottom: 28px;
        }

        .reset-label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
        }

        .reset-input {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
        }

        .reset-hint {
            color: #64748b;
            font-size: 13px;
            margin-bottom: 20px;
        }

        .reset-submit {
            width: 100%;
            padding: 13px;
            background: #1e3a8a;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }

        .reset-submit:hover {
            background: #3b82f6;
        }

        .reset-message {
            display: block;
            margin-top: 18px;
            text-align: center;
        }

        .reset-back {
            display: block;
            margin-top: 22px;
            text-align: center;
            color: #1e3a8a;
            text-decoration: none;
        }

        @media (max-width: 480px) {
            .reset-card {
                padding: 24px;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <main class="reset-page">

            <section class="reset-card">

                <div class="reset-brand">
                    FORTE EVENTS
                </div>

                <h1 class="reset-title">
                    Reset Your Password
                </h1>

                <p class="reset-description">
                    Create a new password for your
                    FEHMS account.
                </p>

                <asp:Label
                    ID="lblNewPassword"
                    runat="server"
                    AssociatedControlID="txtNewPassword"
                    CssClass="reset-label"
                    Text="New Password" />

                <asp:TextBox
                    ID="txtNewPassword"
                    runat="server"
                    TextMode="Password"
                    MaxLength="128"
                    CssClass="reset-input" />

                <asp:Label
                    ID="lblConfirmPassword"
                    runat="server"
                    AssociatedControlID="txtConfirmPassword"
                    CssClass="reset-label"
                    Text="Confirm New Password" />

                <asp:TextBox
                    ID="txtConfirmPassword"
                    runat="server"
                    TextMode="Password"
                    MaxLength="128"
                    CssClass="reset-input" />

                <p class="reset-hint">
                    Your password must contain at least
                    12 characters.
                </p>

                <asp:Button
                    ID="btnResetPassword"
                    runat="server"
                    Text="Reset Password"
                    CssClass="reset-submit"
                    OnClick="btnResetPassword_Click" />

                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="reset-message"
                    role="status" />

                <a href="Login.aspx" class="reset-back">
                    Back to Login
                </a>

            </section>

        </main>

    </form>
</body>
</html>
