<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManageBookings.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageBookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
    <link href="../Stylesheet/AdminStyle.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-workspace admin-workspace-bookings">
    <div class="admin-page-heading">
        <div><h1 class="h2 text-navy mb-1 heading-font">Manage Bookings</h1>
            <p class="text-muted mb-0">Review booking details and update booking status.</p></div></div>
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert">
        <asp:Label ID="lblMessage" runat="server" /></asp:Panel>
    <div class="admin-filter-tabs mb-3" aria-label="Booking status filters">
        <asp:LinkButton ID="lnkAll" runat="server" CssClass="admin-filter-tab active" OnClick="Filter_Click" CommandArgument="" CausesValidation="false">All Bookings (<asp:Literal ID="litAllCount" runat="server" />)</asp:LinkButton>
        <asp:LinkButton ID="lnkPending" runat="server" CssClass="admin-filter-tab" OnClick="Filter_Click" CommandArgument="Pending" CausesValidation="false">Pending (<asp:Literal ID="litPendingCount" runat="server" />)</asp:LinkButton>
        <asp:LinkButton ID="lnkConfirmed" runat="server" CssClass="admin-filter-tab" OnClick="Filter_Click" CommandArgument="Confirmed" CausesValidation="false">Confirmed (<asp:Literal ID="litConfirmedCount" runat="server" />)</asp:LinkButton>
        <asp:LinkButton ID="lnkCancelled" runat="server" CssClass="admin-filter-tab" OnClick="Filter_Click" CommandArgument="Cancelled" CausesValidation="false">Cancelled (<asp:Literal ID="litCancelledCount" runat="server" />)</asp:LinkButton></div>
    <div class="row g-2 mb-3">
        <div class="col-lg-6">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search booking ID, customer name or event..." /></div>
        <div class="col-6 col-lg-2"><asp:TextBox ID="txtFrom" runat="server" TextMode="Date" CssClass="form-control" /></div>
        <div class="col-6 col-lg-2"><asp:TextBox ID="txtTo" runat="server" TextMode="Date" CssClass="form-control" /></div>
        <div class="col-12 col-lg-2">
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100" OnClick="btnSearch_Click" CausesValidation="false" /></div></div>
    <div class="table-responsive">
        <table class="table admin-data-table align-middle mb-0">
            <thead><tr><th>Booking ID</th><th>Customer</th><th>Event type</th><th>Event date</th><th>Total</th><th>Status</th><th>Update status</th><th>Action</th></tr></thead><tbody>
                <asp:Repeater ID="rptBookings" runat="server" OnItemCommand="rptBookings_ItemCommand">
                    <ItemTemplate>
                        <tr><td class="fw-semibold"><%#: Eval("BookingReference") %></td>
                            <td><%#: Eval("CustomerFullName") %><div class="small text-muted"><%#: Eval("CustomerEmail") %></div></td><td><%#: Eval("EventType") %></td>
                            <td><%#: Eval("EventDate", "{0:dd/MM/yyyy}") %></td>
                            <td><%#: FormatRands(Eval("GrandTotal")) %></td><td>
                                <span class='<%# Eval("StatusCss") %>'><%#: Eval("BookingStatus") %></span></td>
                            <td><asp:DropDownList ID="ddlRowStatus" runat="server" CssClass="form-select form-select-sm" SelectedValue='<%# Eval("BookingStatus") %>'>
                                <asp:ListItem Text="Draft" Value="Draft" /><asp:ListItem Text="Pending" Value="Pending" />
                                <asp:ListItem Text="Confirmed" Value="Confirmed" />
                                <asp:ListItem Text="Cancelled" Value="Cancelled" />
                                <asp:ListItem Text="Completed" Value="Completed" />
                                </asp:DropDownList></td><td class="text-nowrap">
                                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-outline-dark btn-sm admin-icon-button" CommandName="UpdateStatus" CommandArgument='<%# Eval("BookingID") %>' CausesValidation="false" ToolTip="Update booking status" aria-label="Update booking status">
                                        <i class="bi bi-check2-square" aria-hidden="true"></i></asp:LinkButton></td></tr></ItemTemplate></asp:Repeater></tbody></table></div>
    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="card p-5 text-center text-muted mt-3">No bookings match those filters.</asp:Panel>
</div>


</asp:Content>
