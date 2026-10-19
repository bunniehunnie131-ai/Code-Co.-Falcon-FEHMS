<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManageReturns.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageReturns" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-4 pb-3 border-bottom">
        <div><h2 class="text-navy mb-1 heading-font">Manage Returns</h2>
            <p class="text-muted mb-0">Record the condition of returned items.</p>

        </div>
        <span class="badge text-bg-secondary">Static demo data</span>
    </div>
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-success"><asp:Label ID="lblMessage" runat="server" /></asp:Panel>
    <asp:Panel ID="pnlList" runat="server">
        <div class="nav nav-pills mb-3" aria-label="Return status">
            <asp:LinkButton ID="lnkPending" runat="server" CssClass="nav-link" OnClick="lnkPending_Click" CausesValidation="false">Awaiting Inspection (<asp:Label ID="lblPendingCount" runat="server" />)</asp:LinkButton><asp:LinkButton ID="lnkCompleted" runat="server" CssClass="nav-link" OnClick="lnkCompleted_Click" CausesValidation="false">Inspection Recorded (<asp:Label ID="lblCompletedCount" runat="server" />)</asp:LinkButton></div><div class="row g-2 mb-3">
            <div class="col-md-7"><asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by booking ID or customer..." /></div>
            <div class="col-md-3"><asp:DropDownList ID="ddlCondition" runat="server" CssClass="form-select"><asp:ListItem Text="All Conditions" Value="" /><asp:ListItem Text="Awaiting Inspection" Value="Awaiting Inspection" /><asp:ListItem Text="Good" Value="Good" /><asp:ListItem Text="Partially Damaged" Value="Partially Damaged" /><asp:ListItem Text="Damaged" Value="Damaged" /><asp:ListItem Text="Missing Items" Value="Missing Items" /></asp:DropDownList></div>
            <div class="col-md-2 d-grid"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" /></div>
        </div>
        <div class="table-responsive"><table class="table table-hover align-middle"><thead class="table-light"><tr><th>Booking ID</th><th>Customer</th><th>Return Date</th><th>Items Returned</th><th>Condition</th><th>Notes</th><th class="text-end">Action</th></tr></thead><tbody>
            <asp:Repeater ID="rptReturns" runat="server" OnItemCommand="rptReturns_ItemCommand"><ItemTemplate><tr>
                <td class="fw-semibold"><%#: Eval("Id") %></td>
                <td><%#: Eval("Customer") %></td>
                <td><%#: Eval("ReturnDate", "{0:dd/MM/yyyy}") %></td>
                <td><%#: Eval("ItemsSummary") %></td>
                <td><span class='<%# GetBadgeClass(Eval("Condition").ToString()) %>'><%#: Eval("Condition") %></span></td>
                <td><%#: Eval("Notes") %></td>
                <td class="text-end"><asp:LinkButton ID="btnOpen" runat="server" CssClass="btn btn-outline-primary btn-sm" CommandName="Open" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"><%# Convert.ToBoolean(Eval("Recorded")) ? "View / Update" : "Record Return" %></asp:LinkButton></td></tr></ItemTemplate></asp:Repeater></tbody></table></div><asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="text-center text-muted py-4">No returns match this view.</asp:Panel></asp:Panel><asp:Panel ID="pnlDetails" runat="server" Visible="false">
        <div class="d-flex justify-content-between align-items-start gap-3 flex-wrap mb-3"><div><h3 class="h4 text-navy mb-1">Record Return</h3><asp:Label ID="lblBooking" runat="server" CssClass="text-muted" /></div><asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnBack_Click" CausesValidation="false">Back to returns</asp:LinkButton></div><asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger"><asp:Label ID="lblError" runat="server" /></asp:Panel>
        <div class="card mb-4"><div class="card-body"><div class="row g-3">
            <div class="col-md-4"><span class="d-block small text-muted">Customer</span><asp:Label ID="lblCustomer" runat="server" CssClass="fw-semibold" /></div>
            <div class="col-md-4"><span class="d-block small text-muted">Event ended / return due</span><asp:Label ID="lblDates" runat="server" CssClass="fw-semibold" /></div>
            <div class="col-md-4"><span class="d-block small text-muted">Collection location</span><asp:Label ID="lblLocation" runat="server" CssClass="fw-semibold" /></div>
            <div class="col-12"><span class="d-block small text-muted">Return instructions</span><asp:Label ID="lblInstructions" runat="server" /></div>
        </div></div></div>
        <h4 class="h5 mb-1">Equipment returned</h4><p class="small text-muted">Good + damaged + missing must equal the booked quantity. Add a note for any damaged item.</p><div class="table-responsive"><table class="table align-middle"><thead class="table-light"><tr><th>Equipment</th><th>Booked</th><th>Good</th><th>Damaged</th><th>Missing</th><th>Damage notes</th></tr></thead><tbody>
            <asp:Repeater ID="rptItems" runat="server"><ItemTemplate><tr>
                <td><strong><%#: Eval("Name") %></strong><span class="d-block small text-muted"><%#: Eval("Description") %></span></td><td class="fw-semibold"><%#: Eval("Expected") %></td>
                <td><asp:TextBox ID="txtGood" runat="server" Text='<%# Bind("Good") %>' TextMode="Number" min="0" CssClass="form-control form-control-sm" /></td>
                <td><asp:TextBox ID="txtDamaged" runat="server" Text='<%# Bind("Damaged") %>' TextMode="Number" min="0" CssClass="form-control form-control-sm" /></td>
                <td><asp:TextBox ID="txtMissing" runat="server" Text='<%# Bind("Missing") %>' TextMode="Number" min="0" CssClass="form-control form-control-sm" /></td>
                <td><asp:TextBox ID="txtNote" runat="server" Text='<%# Bind("DamageNote") %>' CssClass="form-control form-control-sm" placeholder="Describe damage" /></td>
            </tr></ItemTemplate></asp:Repeater>
        </tbody></table></div>
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3"><div><span class="text-muted">Overall condition:</span> <asp:Label ID="lblOverall" runat="server" CssClass="fw-semibold" /></div><asp:Button ID="btnSave" runat="server" Text="Save Return" CssClass="btn btn-primary px-4" OnClick="btnSave_Click" /></div>
    </asp:Panel>

</asp:Content>

