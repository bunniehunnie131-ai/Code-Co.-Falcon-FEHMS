<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="BookingCalender.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.BookingCalender" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
    <link href="../Stylesheet/AdminStyle.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <div class="admin-workspace">
    <div class="admin-page-heading">
        <div>
            <h1 class="h2 text-navy mb-1 heading-font">Booking Calendar</h1>
            <p class="text-muted mb-0">
                View pending, confirmed and cancelled events by date.
            </p>
        </div>

        <asp:HyperLink ID="lnkToday" runat="server"
            NavigateUrl="BookingCalendar.aspx"
            CssClass="btn btn-outline-dark">
            Today
        </asp:HyperLink>
    </div>

    <asp:Panel ID="pnlMessage" runat="server"
        Visible="false"
        CssClass="alert alert-warning">
        <asp:Label ID="lblMessage" runat="server" />
    </asp:Panel>

    <section class="card admin-calendar-card">
        <div class="card-body">
            <asp:Calendar ID="calBookings" runat="server"
                CssClass="admin-calendar"
                DayNameFormat="Short"
                FirstDayOfWeek="Sunday"
                ShowGridLines="false"
                NextPrevFormat="CustomText"
                NextMonthText="Next"
                PrevMonthText="Previous"
                OnDayRender="calBookings_DayRender"
                OnVisibleMonthChanged="calBookings_VisibleMonthChanged"
                SelectionMode="Day" />
        </div>
    </section>

    <div class="d-flex flex-wrap gap-3 small mt-3 admin-calendar-legend">
        <span><i class="calendar-legend confirmed"></i>Confirmed</span>
        <span><i class="calendar-legend pending"></i>Pending</span>
        <span><i class="calendar-legend cancelled"></i>Cancelled</span>
    </div>

    <%-- Kept for data binding, hidden from the page. --%>
    <section class="card mt-4 d-none" aria-hidden="true">
        <div class="card-header bg-white">
            <h2 class="h5 mb-0">
                <asp:Literal ID="litMonthTitle" runat="server" /> events
            </h2>
        </div>

        <div class="card-body">
            <div class="admin-event-grid">
                <asp:Repeater ID="rptMonthEvents" runat="server">
                    <ItemTemplate>
                        <a class="admin-event-card" href="ManageBookings.aspx">
                            <div class="d-flex justify-content-between align-items-start gap-3">
                                <strong><%#: Eval("EventType") %></strong>
                                <span class='<%# Eval("StatusCss") %>'>
                                    <%#: Eval("BookingStatus") %>
                                </span>
                            </div>
                            <div class="small text-muted mt-2">
                                <%#: Eval("EventDate", "{0:ddd, dd MMM}") %>
                                · <%#: Eval("CustomerFullName") %>
                            </div>
                            <div class="small mt-1"><%#: Eval("DeliveryCity") %></div>
                            <div class="small text-muted">
                                <%#: Eval("BookingReference") %>
                            </div>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <asp:Panel ID="pnlNoEvents" runat="server"
                Visible="false"
                CssClass="p-4 text-center text-muted">
                No events scheduled this month.
            </asp:Panel>
        </div>
    </section>
</div>


</asp:Content>
