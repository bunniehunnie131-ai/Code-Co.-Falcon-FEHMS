<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm9" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
            <div>
            <h1>Welcome Back</h1>
            <h3>Login to access your account</h3>
            <!-- Email Field -->
            <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email Address" />
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                ForeColor="Red" Text="*"/><br /><br />
            <!-- <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                ForeColor="Red" ErrorMessage="Enter Valid Email Address" ValidationExpression="@" /><br /><br />
            -->

            <!-- Password Field-->
            <asp:TextBox ID="txtPassword" runat="server" Placeholder="Password" TextMode="Password"/>
           <!-- <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                 ForeColor="Red" Text="*"/><br /><br />
            -->
           

            <br /><br />
            <!-- Forgot Password -->
            <asp:LinkButton ID="lnkForgotPassword" runat="server" Text="Forgot Password" /> <br /><br />

            <!-- Login -->
            <asp:Button ID="btnLogin" runat="server" Text="Login" /><br /><br />

            <label>Or</label><br /><br />

            <!-- Create New Account -->
            <asp:button ID="btnCreateNewAccount" runat="server" Text="Create New Account" /><br /><br />
            <label>Don't have an Account?</label> <asp:LinkButton ID="lnkRegister" runat="server" Text="Register Here" /> <br /><br /> <hr />

            <asp:Label ID="lblMessage" runat="server" Text="" />
         </div>
</asp:Content>
