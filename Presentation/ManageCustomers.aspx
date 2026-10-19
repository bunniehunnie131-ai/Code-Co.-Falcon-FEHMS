<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManageCustomers.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageCustomers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-4 pb-3 border-bottom">
        <div>
            <h2 class="text-navy mb-1 heading-font">Manage Customers</h2>
            <p class="text-muted mb-0">View and manage customer accounts.</p>
        </div>
        <asp:Button ID="btnShowAdd" runat="server" Text="＋ Add Customer" CssClass="btn btn-primary" OnClick="btnShowAdd_Click" CausesValidation="false" />
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
                    <label class="form-label" for="txtPhoneNumber">Phone number</label>
                    <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" TextMode="Phone" MaxLength="30" />
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

    <div class="row g-2 mb-3">
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
        <table class="table table-hover align-middle">
            <thead class="table-light">
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
                            <td><%#: Eval("EmailAddress") %></td>
                            <td><%#: Eval("PhoneNumber") %></td>
                            <td><%#: Eval("BookingCount") %></td>
                            <td><span class='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge rounded-pill text-bg-success" : "badge rounded-pill text-bg-secondary" %>'><%#: Eval("Status") %></span></td>
                            <td class="text-end text-nowrap">
                                <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-outline-primary btn-sm" CommandName="EditCustomer" CommandArgument='<%# Eval("CustomerID") %>' CausesValidation="false">Edit</asp:LinkButton>
                                <asp:LinkButton ID="btnToggleStatus" runat="server" CssClass="btn btn-outline-secondary btn-sm" CommandName="ToggleStatus" CommandArgument='<%# Eval("CustomerID") %>' CausesValidation="false"><%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate" : "Activate" %></asp:LinkButton>
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

</asp:Content>

