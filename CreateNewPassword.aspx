<%@ Page Language="C#"  MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="CreateNewPassword.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.CreateNewPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
    
    <div class="card shadow-lg p-4" style="width: 400px; border-radius: 15px;">
        
        <h3 class="text-center mb-3">Reset Password</h3>
        <p class="text-center text-muted">Enter your new password below</p>

        <!-- Hidden Email -->
        <asp:HiddenField ID="hfEmail" runat="server" />

        <!-- New Password -->
        <div class="mb-3">
            <label class="form-label">New Password</label>
            <asp:TextBox ID="txtNewPassword" runat="server" 
                CssClass="form-control" TextMode="Password" />
            
            <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server"
                ControlToValidate="txtNewPassword"
                ErrorMessage="Password is required"
                ForeColor="Red"
                Display="Dynamic" />
        </div>

        <!-- Confirm Password -->
        <div class="mb-3">
            <label class="form-label">Confirm Password</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" 
                CssClass="form-control" TextMode="Password" />

            <asp:CompareValidator ID="cvPassword" runat="server"
                ControlToCompare="txtNewPassword"
                ControlToValidate="txtConfirmPassword"
                ErrorMessage="Passwords do not match"
                ForeColor="Red"
                Display="Dynamic" />
        </div>

        <!-- Message -->
        <asp:Label ID="lblMessage" runat="server" CssClass="d-block text-center mb-2" />

        <!-- Button -->
        <asp:Button ID="btnReset" runat="server" 
            Text="Update Password"
            CssClass="btn btn-primary w-100"
            OnClick="btnReset_Click" />

    </div>

</div>

</asp:Content>
