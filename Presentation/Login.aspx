<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm9" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
    /* ================================
       FEHMS LOGIN PAGE
       ================================ */

    .login-container {
        max-width: 440px;
        margin: 70px auto;
        padding: 0 15px;
    }

    /* Login Card */
    .login-card {
        background: #ffffff;
        border-radius: 18px;
        padding: 40px 38px;
        border: 1px solid #e5e7eb;
        box-shadow: 0 12px 35px rgba(15, 23, 42, 0.12);
    }

    /* Logo */
    .logo-area {
        text-align: center;
        margin-bottom: 22px;
    }

    .logo-area img {
        height: 72px;
        width: auto;
        object-fit: contain;
    }

    /* Heading */
    .login-card h3 {
        color: #142c6b;
        font-size: 27px;
        font-weight: 700;
        margin-bottom: 8px;
        text-align: center;
        letter-spacing: -0.3px;
    }

    /* Description */
    .login-card p {
        text-align: center;
        color: #64748b;
        font-size: 14px;
        margin-bottom: 28px;
        line-height: 1.6;
    }

    /* Form Labels */
    .login-card label {
        color: #1e293b;
        font-size: 14px;
        font-weight: 600;
        margin-bottom: 7px;
    }

    /* Input Fields */
    .form-control {
        border: 1px solid #dbe1ea;
        border-radius: 10px;
        padding: 12px 14px;
        font-size: 14px;
        color: #1e293b;
        background-color: #ffffff;
        transition: all 0.2s ease;
    }

    .form-control:focus {
        border-color: #1e3a8a;
        box-shadow: 0 0 0 3px rgba(30, 58, 138, 0.12);
        outline: none;
    }

    .form-control::placeholder {
        color: #94a3b8;
    }

    /* Login Button */
    .btn-login {
        width: 100%;
        background: #1e3a8a;
        color: #ffffff;
        border: none;
        border-radius: 10px;
        padding: 13px;
        font-size: 15px;
        font-weight: 600;
        margin-top: 8px;
        transition: all 0.2s ease;
    }

    .btn-login:hover {
        background: #142c6b;
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 5px 14px rgba(30, 58, 138, 0.25);
    }

    .btn-login:active {
        transform: translateY(0);
    }

    /* Extra Links */
    .extra-links {
        text-align: center;
        margin-top: 20px;
        font-size: 14px;
        color: #64748b;
    }

    .extra-links a {
        text-decoration: none;
        color: #1e3a8a;
        font-weight: 600;
        transition: color 0.2s ease;
    }

    .extra-links a:hover {
        color: #142c6b;
        text-decoration: underline;
    }

    /* Forgot Password */
    .forgot-password {
        text-align: right;
        margin-top: 7px;
        margin-bottom: 20px;
    }

    .forgot-password a {
        color: #1e3a8a;
        text-decoration: none;
        font-size: 13px;
        font-weight: 500;
    }

    .forgot-password a:hover {
        text-decoration: underline;
    }

    /* Divider */
    .login-divider {
        display: flex;
        align-items: center;
        gap: 12px;
        margin: 24px 0 18px;
        color: #94a3b8;
        font-size: 12px;
    }

    .login-divider::before,
    .login-divider::after {
        content: "";
        flex: 1;
        height: 1px;
        background: #e5e7eb;
    }

    /* Registration Link */
    .register-link {
        text-align: center;
        font-size: 14px;
        color: #64748b;
    }

    .register-link a {
        color: #1e3a8a;
        font-weight: 600;
        text-decoration: none;
    }

    .register-link a:hover {
        text-decoration: underline;
    }

    /* Validation Messages */
    .login-card .text-danger {
        font-size: 13px;
        margin-top: 5px;
    }

    /* Mobile Responsive */
    @media (max-width: 576px) {

        .login-container {
            margin: 35px auto;
            padding: 0 15px;
        }

        .login-card {
            padding: 30px 24px;
            border-radius: 15px;
        }

        .login-card h3 {
            font-size: 24px;
        }

        .logo-area img {
            height: 62px;
        }
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Forte.css" rel="stylesheet" />

    <div class="login-container">
        <div class="login-card">

            <!-- OPTIONAL LOGO -->
            <div class="logo-area">
                <img src="../Images/FEHMS_Logo.jpeg" alt="Logo" />
            </div>

            <h3>Welcome Back</h3>
            <p>Login to manage your bookings and events</p>

            <!-- EMAIL -->
            <div class="mb-3">
                <asp:Label ID="lblEmail" runat="server" Text="Email Address" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
            </div>

            <!-- PASSWORD -->
            <div class="mb-3">
                <asp:Label ID="lblPassword" runat="server" Text="Password" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter your password"></asp:TextBox>
            </div>

            <!-- LOGIN BUTTON -->
            <div class="d-grid">
                <asp:Button ID="btnLogin" runat="server" Text="Login"
                    CssClass="btn btn-login" OnClick="btnLogin_Click" />
            </div>

            <!-- MESSAGE -->
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-3 d-block text-center"></asp:Label>

            <!-- LINKS -->
            <div class="extra-links">
                <a href="ForgottenPassword.aspx">Forgot Password?</a> |
                <a href="Registration.aspx">Create Account</a>
            </div>

        </div>
    </div>

</asp:Content>