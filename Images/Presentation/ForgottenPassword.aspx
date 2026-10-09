<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ForgottenPassword.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm4" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    

    <style>
        body {
            background: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .forgot-container {
            max-width: 420px;
            margin: 100px auto;
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            padding: 30px;
        }

        .card h3 {
            font-weight: 600;
            margin-bottom: 10px;
        }

        .card p {
            color: #6c757d;
            font-size: 14px;
        }

        .btn-primary {
            border-radius: 8px;
            padding: 10px;
        }

        .form-control {
            border-radius: 8px;
            padding: 10px;
        }

        .back-link {
            display: block;
            margin-top: 15px;
            text-align: center;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <div class="forgot-container">
            <div class="card">

                <h3>Forgot Password</h3>
                <p>Enter your email address and we’ll send you a link to reset your password.</p>

                <!-- Email Input -->
                <div class="mb-3">
                    <asp:Label ID="lblEmail" runat="server" Text="Email Address" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
                </div>

                <!-- Button -->
                <div class="d-grid">
                    <asp:Button ID="btnSendLink" runat="server" Text="Reset Password"
                        CssClass="btn btn-primary" OnClick="btnSendLink_Click" />
                </div>

                <!-- Message -->
                <asp:Label ID="lblMessage" runat="server" CssClass="text-success mt-3 d-block"></asp:Label>

                <!-- Back to Login -->
                <a href="Login.aspx" class="back-link">← Back to Login</a>

            </div>
        </div>
    </form>

</body>
</html>