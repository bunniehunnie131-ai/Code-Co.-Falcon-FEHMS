<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManageCustomers.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageCustomers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
<link href="../Stylesheet/AdminStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div class="admin-workspace admin-workspace-customers">

     <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-4 pb-3 border-bottom">
        <div>
            <h2 class="text-navy mb-1 heading-font">Manage Customers</h2>
            <p class="text-muted mb-0">View and manage customer accounts.</p>
        </div>
        <asp:Button ID="btnShowAdd" runat="server" Text="Add customer" CssClass="btn btn-dark" OnClick="btnShowAdd_Click" CausesValidation="false" />
    </div>

    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert" role="status">
        <asp:Label ID="lblMessage" runat="server" />
    </asp:Panel>

    <asp:Panel ID="pnlCustomerForm" runat="server" Visible="false" CssClass="card mb-4">
        <div class="card-body">
            <h3 class="h5 mb-3"><asp:Label ID="lblFormHeading" runat="server" Text="Add Customer" /></h3>
            <asp:HiddenField ID="hfCustomerUserId" runat="server" />
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label" for="txtFirstName">First name</label>
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" MaxLength="80" />
                    <asp:RequiredFieldValidator ID="valFirstName" runat="server" ControlToValidate="txtFirstName" ValidationGroup="CustomerForm" CssClass="text-danger small" ErrorMessage="Enter a first name." Display="Dynamic" />
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="txtLastName">Last name</label>
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" MaxLength="80" />
                    <asp:RequiredFieldValidator ID="valLastName" runat="server" ControlToValidate="txtLastName" ValidationGroup="CustomerForm" CssClass="text-danger small" ErrorMessage="Enter a last name." Display="Dynamic" />
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="txtEmailAddress">Email address</label>
                    <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-control" TextMode="Email" MaxLength="254" />
                    <asp:RequiredFieldValidator ID="valEmail" runat="server" ControlToValidate="txtEmailAddress" ValidationGroup="CustomerForm" CssClass="text-danger small" ErrorMessage="Enter an email address." Display="Dynamic" />
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="txtDateOfBirth">Date of birth</label>
                    <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="txtIDNumber">South African ID number</label>
                    <asp:TextBox ID="txtIDNumber" runat="server" CssClass="form-control" MaxLength="13" inputmode="numeric" />
                    <small class="form-text text-muted">For edits, leave blank to keep the securely stored ID number.</small>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="txtPhoneNumber">Phone number</label>
                    <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" TextMode="Phone" MaxLength="30" />
                </div>
                <div class="col-12" id="customerPasswordRow" runat="server">
                    <div class="row g-3">
                        <div class="col-md-6"><label class="form-label" for="txtCustomerPassword">Temporary password</label><asp:TextBox ID="txtCustomerPassword" runat="server" CssClass="form-control" TextMode="Password" autocomplete="new-password" /></div>
                        <div class="col-md-6"><label class="form-label" for="txtConfirmPassword">Confirm password</label><asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" autocomplete="new-password" /></div>
                        <div class="col-12"><small class="form-text text-muted">Use at least 12 characters, matching the registration requirements.</small></div>
                    </div>
                </div>
                <div class="col-12" id="customerTermsRow" runat="server">
                    <div class="form-check admin-form-check">
                        <asp:CheckBox ID="chkTermsAccepted" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label" for="<%= chkTermsAccepted.ClientID %>">Customer has accepted the Terms and Conditions and Privacy Policy.</label>
                    </div>
                </div>
                <div class="col-md-6">
                    <asp:CheckBox ID="chkActive" runat="server" CssClass="form-check-input" Checked="true" />
                    <asp:Label ID="lblActive" runat="server" AssociatedControlID="chkActive" CssClass="form-check-label" Text="Active account" />
                </div>
                <div class="col-12 d-flex gap-2">
                    <asp:Button ID="btnSaveCustomer" runat="server" Text="Add Customer" CssClass="btn btn-primary" ValidationGroup="CustomerForm" OnClick="btnSaveCustomer_Click" />
                    <asp:Button ID="btnCancelForm" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary" OnClick="btnCancelForm_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </asp:Panel>

    <div class="row g-3 mb-4 admin-filter-row">
        <div class="col-md-7">
            <label class="visually-hidden" for="txtSearch">Search customers</label>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name, email, or phone..." />
        </div>
        <div class="col-md-3">
            <label class="visually-hidden" for="ddlStatus">Customer status</label>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                <asp:ListItem Text="All Statuses" Value="" />
                <asp:ListItem Text="Active" Value="1" />
                <asp:ListItem Text="Inactive" Value="0" />
            </asp:DropDownList>
        </div>
        <div class="col-md-2 d-grid">
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" CausesValidation="false" />
        </div>
    </div>

    <div class="table-responsive">
        <table class="table admin-data-table align-middle mb-0">
            <thead>
                <tr>
                    <th>Customer ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Bookings</th><th>Status</th><th class="text-end">Actions</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptCustomers" runat="server" OnItemCommand="rptCustomers_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td class="fw-semibold"><%#: Eval("CustomerID") %></td>
                            <td><%#: Eval("FullName") %></td>
                            <td><%#: Eval("Email") %></td>
                            <td><%#: Eval("PhoneNumber") %></td>
                            <td><%#: Eval("BookingCount") %></td>
                            <td><span class='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge rounded-pill text-bg-success" : "badge rounded-pill text-bg-secondary" %>'><%#: Eval("Status") %></span></td>
                            <td class="text-end text-nowrap">
                                <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-outline-dark btn-sm admin-icon-button" CommandName="EditCustomer" CommandArgument='<%# Eval("CustomerID") %>' CausesValidation="false" ToolTip="Edit customer" aria-label="Edit customer"><i class="bi bi-pencil-square" aria-hidden="true"></i></asp:LinkButton>
                                <asp:LinkButton ID="btnToggleStatus" runat="server" CssClass="btn btn-outline-dark btn-sm admin-icon-button" CommandName="ToggleStatus" CommandArgument='<%# Eval("CustomerID") %>' CausesValidation="false" ToolTip="Change account status" aria-label="Change account status"><i class='<%# Convert.ToBoolean(Eval("IsActive")) ? "bi bi-person-dash" : "bi bi-person-check" %>' aria-hidden="true"></i></asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
    <asp:Panel ID="pnlNoCustomers" runat="server" Visible="false" CssClass="text-center text-muted py-5">
        No customers found. Use Add Customer to create the first customer account.
    </asp:Panel>
</div>


</asp:Content>
