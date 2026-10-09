<%@ Page Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.ForgotPassword" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Forte.css" rel="stylesheet" />

    
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
</asp:Content>
