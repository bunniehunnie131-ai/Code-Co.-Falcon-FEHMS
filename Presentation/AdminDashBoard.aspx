<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="AdminDashBoard.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.AdminDashBoard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>

        /* Admin dashboard — uses the Forte global stylesheet variables */
.admin-workspace {
    width: 100%;
    min-width: 0;
    color: var(--text-color);
}

.admin-workspace .admin-stat-card {
    display: flex;
    align-items: center;
    min-height: 96px;
    height: 100%;
    padding: 20px 22px;
    background: var(--surface-color);
    border: 1px solid var(--border-light);
    border-left: 5px solid var(--primary-color);
    border-radius: var(--radius-medium);
    box-shadow: var(--shadow-small);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.admin-workspace .admin-stat-card:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-medium);
}

.admin-workspace .admin-stat-card > div {
    display: flex;
    flex-direction: column;
    gap: 4px;
    min-width: 0;
}

.admin-workspace .admin-stat-card strong {
    color: var(--primary-color);
    font-size: 1.6rem;
    font-weight: 700;
    line-height: 1.2;
}

.admin-workspace .admin-stat-card span {
    color: var(--muted-text);
    font-size: 0.88rem;
}

.admin-workspace .admin-dashboard-panel {
    height: 100%;
    overflow: hidden;
    background: var(--surface-color);
    border: 1px solid var(--border-light);
    border-radius: var(--radius-medium);
    box-shadow: var(--shadow-small);
}

.admin-workspace .admin-dashboard-panel-heading {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    min-height: 72px;
    padding: 16px 20px;
    border-bottom: 1px solid var(--border-color);
}

.admin-workspace .admin-dashboard-panel-heading h2 {
    color: var(--secondary-color);
}

.admin-workspace .admin-dashboard-panel-heading .small {
    display: block;
    margin-top: 4px;
    color: var(--muted-text);
}

.admin-workspace .admin-dashboard-panel-body {
    padding: 18px 20px;
}

.admin-workspace .admin-dashboard-list-head,
.admin-workspace .admin-dashboard-list-row {
    display: grid;
    grid-template-columns: minmax(0, 1fr) minmax(0, 1fr)
                           minmax(0, 1.2fr) minmax(0, 0.85fr);
    align-items: center;
    gap: 12px;
    padding: 12px 18px;
}

.admin-workspace .admin-dashboard-list-head {
    background: var(--background-color);
    color: var(--secondary-color);
    font-size: 0.78rem;
    font-weight: 700;
}

.admin-workspace .admin-dashboard-list-row {
    min-height: 52px;
    border-top: 1px solid var(--border-light);
    color: var(--text-color);
    font-size: 0.88rem;
}

.admin-workspace .admin-dashboard-list-row > span {
    min-width: 0;
    overflow-wrap: anywhere;
}

.admin-workspace .admin-dashboard-empty {
    padding: 22px 20px;
    color: var(--muted-text);
    text-align: center;
}

.admin-workspace .admin-chart {
    display: flex;
    align-items: flex-end;
    justify-content: space-around;
    gap: 12px;
    min-height: 230px;
    padding: 12px 8px 0;
}

.admin-workspace .admin-chart-column {
    display: flex;
    flex: 1 1 0;
    flex-direction: column;
    align-items: center;
    justify-content: flex-end;
    gap: 7px;
    height: 210px;
    min-width: 0;
}

.admin-workspace .admin-chart-value,
.admin-workspace .admin-chart-month {
    color: var(--muted-text);
    font-size: 0.75rem;
    text-align: center;
}

.admin-workspace .admin-chart-track {
    display: flex;
    align-items: flex-end;
    justify-content: center;
    width: 100%;
    height: 160px;
}

.admin-workspace .admin-chart-bar {
    width: min(36px, 75%);
    min-height: 3px;
    background: var(--primary-color);
    border-radius: 5px 5px 0 0;
}

@media (max-width: 767px) {
    .admin-workspace .admin-dashboard-panel-heading {
        align-items: flex-start;
        flex-direction: column;
    }

    .admin-workspace .admin-dashboard-list-head,
    .admin-workspace .admin-dashboard-list-row {
        gap: 7px;
        padding: 10px;
        font-size: 0.75rem;
    }
}

    </style>

    <div class="admin-workspace">
    <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-4">
        <div><h1 class="h2 text-navy mb-1 heading-font">Admin Dashboard</h1>
            <p class="text-muted mb-0">Welcome back, <asp:Literal ID="litAdminName" runat="server" />. Here is today's business overview.</p></div>
        <div class="text-muted small"><asp:Literal ID="litToday" runat="server" /></div>
    </div>
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-warning"><asp:Label ID="lblMessage" runat="server" /></asp:Panel>

    <h2 class="h5 mb-3">Business at a glance</h2>
    <div class="row g-3 mb-4">
        <div class="col-6 col-xl-3"><div class="admin-stat-card"><div><strong><asp:Literal ID="litTotalBookings" runat="server" /></strong><span>Total bookings</span></div></div></div>
        <div class="col-6 col-xl-3"><div class="admin-stat-card"><div><strong><asp:Literal ID="litPendingBookings" runat="server" /></strong><span>Awaiting approval</span></div></div></div>
        <div class="col-6 col-xl-3"><div class="admin-stat-card"><div><strong><asp:Literal ID="litUpcoming" runat="server" /></strong><span>Upcoming events</span></div></div></div>
        <div class="col-6 col-xl-3"><div class="admin-stat-card"><div><strong><asp:Literal ID="litActiveStaff" runat="server" /></strong><span>Active staff</span></div></div></div>
        <div class="col-6 col-xl-3"><div class="admin-stat-card"><div><strong><asp:Literal ID="litRentalItems" runat="server" /></strong><span>Available rental items</span></div></div></div>
        <div class="col-6 col-xl-3"><div class="admin-stat-card"><div><strong><asp:Literal ID="litRevenue" runat="server" /></strong><span>Payments received</span></div></div></div>
        <div class="col-6 col-xl-3"><div class="admin-stat-card"><div><strong><asp:Literal ID="litPendingPayments" runat="server" /></strong><span>Pending payments</span></div></div></div>
        <div class="col-6 col-xl-3"><div class="admin-stat-card"><div><strong><asp:Literal ID="litUnassignedTasks" runat="server" /></strong><span>Tasks needing staff</span></div></div></div>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-lg-7"><section class="admin-dashboard-panel h-100">
            <div class="admin-dashboard-panel-heading">
                <div><h2 class="h5 mb-0">Upcoming events</h2>
                    <span class="small text-muted">Next confirmed and pending bookings</span></div>
                <a href="ManageBookings.aspx" class="btn btn-outline-dark btn-sm">Manage bookings</a></div>
            <div class="admin-dashboard-list" role="table" aria-label="Upcoming events">
                <div class="admin-dashboard-list-head" role="row">
                    <span role="columnheader">Date</span>
                    <span role="columnheader">Event</span><span role="columnheader">Customer</span>
                    <span role="columnheader">Status</span></div>
                <asp:Repeater ID="rptUpcoming" runat="server">
                    <ItemTemplate>
                        <div class="admin-dashboard-list-row" role="row">
                        <span role="cell"><%#: Eval("EventDate", "{0:dd MMM yyyy}") %></span>
                        <span role="cell"><%#: Eval("EventType") %></span>
                        <span role="cell"><%#: Eval("CustomerFullName") %></span>
                        <span role="cell"><span class='<%# Eval("StatusCss") %>'><%#: Eval("BookingStatus") %>
                        </span>
                        </span>
                        </div></ItemTemplate></asp:Repeater>
            </div><asp:Panel ID="pnlNoUpcoming" runat="server" Visible="false" CssClass="admin-dashboard-empty">No upcoming events are booked.</asp:Panel>
        </section></div>
        <div class="col-lg-5"><section class="admin-dashboard-panel h-100">
            <div class="admin-dashboard-panel-heading">
                <div><h2 class="h5 mb-0">Monthly revenue</h2>
                    <span class="small text-muted">Payments recorded as paid</span></div></div>
            <div class="admin-dashboard-panel-body"><div class="admin-chart" role="img" aria-label="Monthly paid revenue chart">
                <asp:Repeater ID="rptRevenue" runat="server"><ItemTemplate>
                    <div class="admin-chart-column">
                        <span class="admin-chart-value"><%#: Eval("AmountLabel") %></span><div class="admin-chart-track"><div class="admin-chart-bar" style='height:<%#: Eval("BarHeight") %>%'></div></div>
                        <span class="admin-chart-month"><%#: Eval("MonthLabel") %></span></div></ItemTemplate></asp:Repeater></div></div></section></div>
    </div>

    <div class="row g-3">
        <div class="col-lg-6"><section class="admin-dashboard-panel h-100">
            <div class="admin-dashboard-panel-heading">
                <div><h2 class="h5 mb-0">Operations requiring attention</h2>
                    <span class="small text-muted">Open delivery and collection tasks</span>

                </div>
                <a href="AdminAssignBookings.aspx" class="btn btn-outline-dark btn-sm">Assign bookings</a></div>
            <div class="admin-dashboard-list" role="table" aria-label="Operations requiring attention">
                <div class="admin-dashboard-list-head" role="row">
                    <span role="columnheader">Booking</span><span role="columnheader">Task</span><span role="columnheader">Due</span>
                    <span role="columnheader">Staff</span></div>
                <asp:Repeater ID="rptOperations" runat="server"><ItemTemplate>
                    <div class="admin-dashboard-list-row" role="row">
                        <span role="cell"><%#: Eval("BookingReference") %><small class="d-block text-muted"><%#: Eval("CustomerFullName") %></small></span>
                        <span role="cell"><%#: Eval("TaskType") %></span>
                        <span role="cell"><%#: Eval("ScheduledAt", "{0:dd MMM, HH:mm}") %></span>
                        <span role="cell"><%#: Eval("StaffName") %></span></div></ItemTemplate></asp:Repeater>
            </div><asp:Panel ID="pnlNoOperations" runat="server" Visible="false" CssClass="admin-dashboard-empty">No open operations need attention.</asp:Panel>
        </section></div>
        <div class="col-lg-6"><section class="admin-dashboard-panel h-100">
            <div class="admin-dashboard-panel-heading">
                <div><h2 class="h5 mb-0">Low inventory</h2>
                    <span class="small text-muted">Available items with five or fewer units</span></div>
                <a href="ManageInventory.aspx" class="btn btn-outline-dark btn-sm">Manage inventory</a></div>
            <div class="admin-dashboard-list" role="table" aria-label="Low inventory">
                <div class="admin-dashboard-list-head" role="row">
                    <span role="columnheader">Item</span>
                    <span role="columnheader">Category</span>
                    <span role="columnheader">Available</span>
                    <span role="columnheader">Daily price</span></div>
                <asp:Repeater ID="rptLowStock" runat="server">
                    <ItemTemplate><div class="admin-dashboard-list-row" role="row">
                        <span role="cell"><%#: Eval("ProductName") %></span>
                        <span role="cell"><%#: Eval("Category") %></span>
                        <span role="cell"><span class="badge text-bg-warning"><%#: Eval("QuantityAvailable") %></span></span>
                        <span role="cell"><%#: FormatRands(Eval("Price")) %></span></div></ItemTemplate></asp:Repeater>
            </div><asp:Panel ID="pnlNoLowStock" runat="server" Visible="false" CssClass="admin-dashboard-empty">No low inventory items to report.</asp:Panel>
        </section></div>
    </div>
</div>


</asp:Content>
