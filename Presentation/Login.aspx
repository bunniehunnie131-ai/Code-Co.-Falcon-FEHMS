<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm9" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
