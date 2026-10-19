<%@ Page Title="Customer Dashboard"
    Language="C#"
    MasterPageFile="~/Presentation/SystemLayout.Master"
    AutoEventWireup="true"
    CodeBehind="CustomerDashboard.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.CustomerDashboard"
    Culture="en-ZA" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />

    <div class="d-flex justify-content-between align-items-center
                flex-wrap gap-3 mb-4 pb-3 border-bottom">

        <div>
            <h2 class="text-navy mb-1 heading-font">
                Welcome Back,
                <asp:Label ID="lblCustomerName"
                    runat="server" Text="Customer" />!
            </h2>

            <p class="text-muted m-0">
                View your bookings, track their status and download receipts.
            </p>
        </div>

        <a href="Catalogue.aspx" class="btn btn-primary">
            New Booking
        </a>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card stat-card h-100 p-3 bg-white">
                <span class="text-muted small fw-bold">
                    ACTIVE BOOKINGS
                </span>

                <h3 class="text-navy mt-2 fw-bold">
                    <asp:Label ID="lblActiveBookings"
                        runat="server" Text="0" />
                </h3>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card stat-card h-100 p-3 bg-white">
                <span class="text-muted small fw-bold">
                    TOTAL PAID
                </span>

                <h3 class="text-navy mt-2 fw-bold">
                    R <asp:Label ID="lblOutstandingBalance"
                        runat="server" Text="0.00" />
                </h3>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card stat-card h-100 p-3 bg-white">
                <span class="text-muted small fw-bold">
                    TOTAL ITEMS BOOKED
                </span>

                <h3 class="text-navy mt-2 fw-bold">
                    <asp:Label ID="lblItemsHired"
                        runat="server" Text="0" />
                </h3>
            </div>
        </div>
    </div>

    <h4 class="text-navy heading-font mb-3">
        My Bookings
    </h4>

    <div class="table-responsive">
        <table class="table table-hover align-middle border">
            <thead class="table-light">
                <tr>
                    <th>Booking Reference</th>
                    <th>Event Date</th>
                    <th>Equipment</th>
                    <th>Status</th>
                    <th>Amount Paid</th>
                    <th>Actions</th>
                </tr>
            </thead>

            <tbody>
                <asp:Repeater ID="rptBookings" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td class="fw-bold text-blue">
                                <%#: Eval("BookingReference") %>
                            </td>

                            <td>
                                <%#: Eval("EventDate") %>
                            </td>

                            <td>
                                <%#: Eval("ItemsSummary") %>
                            </td>

                            <td>
                                <span class='<%# "badge " + GetStatusBadgeClass(Convert.ToString(Eval("BookingStatus"))) %>'>
                                    <%#: Eval("BookingStatus") %>
                                </span>
                            </td>

                            <td>
                                R <%#: Eval("PaymentAmount", "{0:N2}") %>
                            </td>

                            <td>
                                <a href='TrackOrder.aspx?booking=<%#: Eval("DownloadId") %>'
                                   class="btn btn-sm btn-outline-primary mb-1">
                                    Track / View Details
                                </a>

                                <a href='CustomerDashboard.aspx?receipt=<%#: Eval("DownloadId") %>'
                                   class="btn btn-sm btn-outline-secondary mb-1">
                                    Download Receipt
                                </a>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <asp:Panel ID="pnlNoBookings"
        runat="server"
        Visible="false"
        CssClass="text-center text-muted py-4">

        You have no saved bookings in this session.
        <a href="Catelogue.aspx">Browse our catalogue</a>
        to make a booking.
    </asp:Panel>

</asp:Content>