<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="AssignedBookings.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.AssignedBookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="assigned-bookings-page container-fluid px-3 px-xl-4 py-3">
    <div class="page-header">
        <h1 class="page-title">My Assigned Bookings</h1>
        <p class="page-subtitle mb-0">View bookings assigned to you.</p>
    </div>

    <div class="card">
        <div class="card-body">
            <ul class="nav nav-tabs assigned-bookings-tabs mb-3">
                <li class="nav-item"><a class="nav-link active" href="#allBookings">All</a></li>
                <li class="nav-item"><a class="nav-link" href="#deliveryBookings">Deliveries</a></li>
                <li class="nav-item"><a class="nav-link" href="#collectionBookings">Collections</a></li>
            </ul>

            <div class="row g-2 align-items-center mb-3">
                <div class="col-md-6"><asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by booking ID, customer or venue..." aria-label="Search assigned bookings" /></div>
                <div class="col-sm-6 col-md-3"><asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="form-control" aria-label="Filter by event date" /></div>
                <div class="col-sm-6 col-md-3"><asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select" aria-label="Filter by booking status"><asp:ListItem Text="All Statuses" Value="" /><asp:ListItem Text="Pending" Value="Pending" /><asp:ListItem Text="Out for Delivery" Value="Out for Delivery" /><asp:ListItem Text="Scheduled" Value="Scheduled" /><asp:ListItem Text="Completed" Value="Completed" /><asp:ListItem Text="Collected" Value="Collected" /></asp:DropDownList></div>
            </div>

            <div id="allBookings" class="table-responsive">
                <asp:Repeater ID="rptAssignedBookings" runat="server">
                    <HeaderTemplate><table class="table table-hover align-middle mb-0"><thead><tr><th>Booking ID</th><th>Customer</th><th>Event Type</th><th>Event Date</th><th>Venue</th><th>Assignment</th><th>Status</th><th>Action</th></tr></thead><tbody></HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><strong><%#: Eval("BookingId") %></strong></td>
                            <td><%#: Eval("Customer") %></td>
                            <td><%#: Eval("EventType") %></td>
                            <td><%#: Eval("EventDate", "{0:dd MMM yyyy}") %></td>
                            <td><%#: Eval("Venue") %></td>
                            <td><%#: Eval("AssignmentType") %></td>
                            <td><span class='badge <%# StatusBadge(Eval("Status")) %>'><%#: Eval("Status") %></span></td>
                            <td><a class="btn btn-sm btn-outline-primary" href='<%# ResolveAssignmentUrl(Eval("AssignmentType"), Eval("BookingId")) %>'>View</a></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate></tbody></table></FooterTemplate>
                </asp:Repeater>
            </div>
            <asp:Panel ID="pnlNoAssignedBookings" runat="server" CssClass="text-center text-muted py-4">No bookings are currently assigned to you.</asp:Panel>
        </div>
    </div>
</div>


</asp:Content>
