<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="StaffDashBoard.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.StaffDashBoard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    
    <link href="../Stylesheet/Forte.css" rel="stylesheet" />

    <!-- PAGE HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
        <div>
            <h2 class="text-navy mb-1 heading-font">Dashboard</h2>
            <p class="text-muted m-0">Overview of your delivery activity</p>
        </div>
        <div class="d-flex align-items-center gap-3">
            <div class="text-end">
                <span class="fw-bold text-navy d-block"><asp:Label ID="lblStaffName" runat="server" Text="" /></span>
                <span class="text-muted small"><asp:Label ID="lblStaffRole" runat="server" Text="" /></span>
            </div>
            <div class="staff-avatar-circle">
                <asp:Label ID="lblStaffInitials" runat="server" Text="" />
            </div>
        </div>
    </div>

    <!-- STATS CARDS ROW -->
    <div class="row g-3 mb-4">
        <div class="col-md-3 col-sm-6">
            <div class="card stat-card h-100 p-3 bg-white">
                <div class="d-flex align-items-center justify-content-between">
                    <span class="text-muted small">Total Deliveries</span>
                    <i class="bi bi-truck text-blue"></i>
                </div>
                <h3 class="text-navy mt-2 fw-bold">
                    <asp:Label ID="lblTotalDeliveries" runat="server" Text="0" />
                </h3>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="card stat-card h-100 p-3 bg-white">
                <div class="d-flex align-items-center justify-content-between">
                    <span class="text-muted small">Pending Deliveries</span>
                    <i class="bi bi-clock text-blue"></i>
                </div>
                <h3 class="text-navy mt-2 fw-bold">
                    <asp:Label ID="lblPendingDeliveries" runat="server" Text="0" />
                </h3>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="card stat-card h-100 p-3 bg-white">
                <div class="d-flex align-items-center justify-content-between">
                    <span class="text-muted small">Out for Delivery</span>
                    <i class="bi bi-bicycle text-blue"></i>
                </div>
                <h3 class="text-navy mt-2 fw-bold">
                    <asp:Label ID="lblOutForDelivery" runat="server" Text="0" />
                </h3>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="card stat-card h-100 p-3 bg-white">
                <div class="d-flex align-items-center justify-content-between">
                    <span class="text-muted small">Completed Deliveries</span>
                    <i class="bi bi-box-seam text-blue"></i>
                </div>
                <h3 class="text-navy mt-2 fw-bold">
                    <asp:Label ID="lblCompletedDeliveries" runat="server" Text="0" />
                </h3>
            </div>
        </div>
    </div>

    <!-- TODAY'S DELIVERIES -->
    <div class="card stat-card p-3 mb-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h6 class="text-navy fw-bold m-0">
                Today's Deliveries &mdash; <asp:Label ID="lblTodayDate" runat="server" Text="" />
            </h6>
            <a href="ManageDeliveries.aspx" class="text-blue small fw-semibold text-decoration-none">Manage all deliveries</a>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr class="staff-table-head">
                        <th>Delivery ID</th>
                        <th>Customer</th>
                        <th>Time</th>
                        <th>Address</th>
                        <th>Items / Services</th>
                        <th>Status</th>
                        <th class="text-end">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptTodayDeliveries" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td class="fw-bold text-blue">#<%# Eval("DeliveryID") %></td>
                                <td><%# Eval("CustomerName") %></td>
                                <td><%# Eval("Time") %></td>
                                <td><%# Eval("Address") %></td>
                                <td class="text-muted small"><%# Eval("ItemsSummary") %></td>
                                <td>
                                   <span class="badge bg-light text-dark badge-status">
    <%# Eval("Status") %>
</span>
                                </td>
                                <td class="text-end">
                                    <a href='DeliveryDetails.aspx?ID=<%# Eval("DeliveryID") %>' class="btn btn-outline-primary btn-sm rounded-pill px-3">View Details</a>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>

            <asp:Panel ID="pnlNoDeliveries" runat="server" Visible="false" CssClass="text-center text-muted py-4">
                No deliveries scheduled for today.
            </asp:Panel>
        </div>
    </div>

    <!-- UPCOMING DELIVERIES + RECENT ACTIVITY -->
    <div class="row g-3">
        <div class="col-lg-6">
            <div class="card stat-card p-3 h-100">
                <h6 class="text-navy fw-bold mb-3">Upcoming Deliveries</h6>
                <asp:Repeater ID="rptUpcomingDeliveries" runat="server">
                    <ItemTemplate>
                        <div class="upcoming-item d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold text-navy d-block small">#<%# Eval("DeliveryID") %>&ndash; <%# Eval("CustomerName") %></span>
                                <span class="text-muted small"><%# Eval("DeliveryDate", "{0:dd MMM yyyy}") %> &middot; <%# Eval("Address") %></span>
                            </div>
                            <span class="badge bg-light text-dark badge-status"><%# Eval("Status") %></span>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Panel ID="pnlNoUpcoming" runat="server" Visible="false" CssClass="text-center text-muted py-3">
                    No upcoming deliveries scheduled.
                </asp:Panel>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card stat-card p-3 h-100">
                <h6 class="text-navy fw-bold mb-3">Recent Activity</h6>
                <asp:Repeater ID="rptRecentActivity" runat="server">
                    <ItemTemplate>
                        <div class="activity-item d-flex align-items-start gap-2">
                            <i class="bi <%# Eval("IconClass") %> text-blue mt-1"></i>
                            <div>
                                <span class="text-navy small d-block"><%# Eval("Message") %></span>
                                <span class="text-muted activity-time"><%# Eval("TimeAgo") %></span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Panel ID="pnlNoActivity" runat="server" Visible="false" CssClass="text-center text-muted py-3">
                    No recent activity.
                </asp:Panel>
            </div>
        </div>
    </div>

</asp:Content>
