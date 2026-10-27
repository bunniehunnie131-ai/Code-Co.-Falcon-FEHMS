<%@ Page Title="Manage Staff" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManageStaff.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageStaff" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
    <link href="../Stylesheet/AdminStyle.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-workspace admin-workspace-staff">
        <div class="admin-page-heading">
            <div>
                <h1 class="h2 text-navy mb-1">Manage Staff</h1>
                <p class="text-muted mb-0">Add staff accounts, set their roles and manage access.</p>
            </div>
            <asp:Button ID="btnShowAdd" runat="server" Text="Add staff" CssClass="btn btn-dark" OnClick="btnShowAdd_Click" CausesValidation="false" /></div>
        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert">
            <asp:Label ID="lblMessage" runat="server" /></asp:Panel>
        <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="card mb-4">
            <div class="card-body">
                <h3 class="h5">New staff account</h3>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">First name</label><asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" MaxLength="80" /></div>
                    <div class="col-md-6">
                        <label class="form-label">Last name</label><asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" MaxLength="80" /></div>
                    <div class="col-md-6">
                        <label class="form-label">Email</label><asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" MaxLength="254" /></div>
                    <div class="col-md-6">
                        <label class="form-label">Phone</label><asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" MaxLength="30" /></div>
                    <div class="col-md-6">
                        <label class="form-label">Staff role</label><asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select" /></div>
                    <div class="col-md-6">
                        <label class="form-label">Job title</label><asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" MaxLength="80" /></div>
                    <div class="col-md-6">
                        <label class="form-label">Temporary password</label><asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" autocomplete="new-password" /></div>
                </div>
                <div class="mt-3">
                    <asp:Button ID="btnSave" runat="server" Text="Create Staff Account" CssClass="btn btn-primary" OnClick="btnSave_Click" /><asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary ms-2" OnClick="btnCancel_Click" CausesValidation="false" /></div>
            </div>
        </asp:Panel>
        <div class="table-responsive">
            <asp:GridView ID="gvStaff" runat="server" AutoGenerateColumns="false" CssClass="table admin-data-table align-middle mb-0" DataKeyNames="UserID" OnRowCommand="gvStaff_RowCommand" EmptyDataText="No staff accounts found.">
                <Columns>
                    <asp:BoundField DataField="StaffNumber" HeaderText="Staff ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Name" />
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email" />
                    <asp:BoundField DataField="JobTitle" HeaderText="Job title" />
                    <asp:BoundField DataField="RoleName" HeaderText="Role" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:TemplateField HeaderText="Access">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnToggle" runat="server" CommandName="Toggle" CommandArgument='<%# Eval("UserID") %>' CssClass="btn btn-sm btn-outline-dark admin-icon-button" ToolTip='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate staff account" : "Reactivate staff account" %>' aria-label='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate staff account" : "Reactivate staff account" %>'><i class='<%# Convert.ToBoolean(Eval("IsActive")) ? "bi bi-person-dash" : "bi bi-person-check" %>' aria-hidden="true"></i></asp:LinkButton></ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
