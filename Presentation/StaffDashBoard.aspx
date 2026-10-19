<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="StaffDashBoard.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.StaffDashBoard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
    
    .staff-page-content .badge
    {
    color: #000 !important;

    }
</style>
    <div class="staff-page-content container-fluid px-3 px-xl-4 py-3">
        <div class="page-header d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div>
                <h1 class="page-title">Welcome back, <asp:Literal ID="litStaffName" runat="server" /></h1>
                <p class="page-subtitle mb-0">Here’s your schedule and tasks for today.</p>
            </div>
            <span class="badge badge-forte"><asp:Literal ID="litStaffRole" runat="server" /></span>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-6 col-xl-3"><div class="card stat-card h-100 p-3"><div class="d-flex justify-content-between"><span class="text-muted">Today’s Deliveries</span><i class="bi bi-truck text-primary fs-4"></i></div><div class="h2 mt-2 mb-0"><asp:Literal ID="litDeliveryCount" runat="server" /></div><a href="ManageDeliveries.aspx" class="small text-decoration-none">View deliveries <i class="bi bi-arrow-right"></i></a></div></div>
            <div class="col-6 col-xl-3"><div class="card stat-card h-100 p-3"><div class="d-flex justify-content-between"><span class="text-muted">Today’s Collections</span><i class="bi bi-box-seam text-success fs-4"></i></div><div class="h2 mt-2 mb-0"><asp:Literal ID="litCollectionCount" runat="server" /></div><a href="ManageCollection.aspx" class="small text-decoration-none">View collections <i class="bi bi-arrow-right"></i></a></div></div>
            <div class="col-6 col-xl-3"><div class="card stat-card h-100 p-3"><div class="d-flex justify-content-between"><span class="text-muted">Returns to Record</span><i class="bi bi-arrow-return-left text-warning fs-4"></i></div><div class="h2 mt-2 mb-0"><asp:Literal ID="litReturnsCount" runat="server" /></div><a href="ManageCollection.aspx" class="small text-decoration-none">Manage returns <i class="bi bi-arrow-right"></i></a></div></div>
            <div class="col-6 col-xl-3"><div class="card stat-card h-100 p-3"><div class="d-flex justify-content-between"><span class="text-muted">Assigned Bookings</span><i class="bi bi-clipboard-check text-primary fs-4"></i></div><div class="h2 mt-2 mb-0"><asp:Literal ID="litAssignedCount" runat="server" /></div><span class="small text-muted">Across today’s schedule</span></div></div>
        </div>

        <div class="row g-3">
            <div class="col-xl-8">
                <div class="card h-100">
                    <div class="card-header d-flex flex-wrap justify-content-between align-items-center gap-2">
                        <div><h2 class="h5 mb-0">Today’s Schedule</h2><span class="small text-muted"><asp:Literal ID="litScheduleDate" runat="server" /></span></div>
                        <a href="ManageDeliveries.aspx" class="small">View full schedule</a>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead><tr><th>Time</th><th>Type</th><th>Booking ID</th><th>Customer</th><th>Venue</th><th>Status</th><th></th></tr></thead>
                                <tbody>
                                    <asp:Repeater ID="rptSchedule" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%#: Eval("Time") %></td><td><%#: Eval("Type") %></td><td><strong><%#: Eval("BookingId") %></strong></td><td><%#: Eval("Customer") %></td><td><%#: Eval("Venue") %></td>
                                                <td><span class='badge <%# StatusBadge(Eval("Status")) %>'><%#: Eval("Status") %></span></td>
                                                <td><a class="btn btn-sm btn-outline-primary" href="ManageDeliveries.aspx">View</a></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                        <asp:Panel ID="pnlNoSchedule" runat="server" Visible="false" CssClass="p-4 text-center text-muted">No deliveries or collections are scheduled for today.</asp:Panel>
                    </div>
                </div>
            </div>
            <div class="col-xl-4">
                <div class="card h-100">
                    <div class="card-header"><h2 class="h5 mb-0">Quick Actions</h2></div>
                    <div class="card-body">
                        <h3 class="h6">Recent Activity</h3>
                        <asp:Repeater ID="rptActivity" runat="server"><ItemTemplate><div class="border-top py-2"><div><i class='bi <%#: Eval("Icon") %> me-2 text-primary'></i><%#: Eval("Message") %></div><small class="text-muted"><%#: Eval("When") %></small></div></ItemTemplate></asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

