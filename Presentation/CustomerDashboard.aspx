<%@ Page Title="Customer Dashboard"
    Language="C#"
    MasterPageFile="~/Presentation/SystemLayout.master"
    AutoEventWireup="true"
    CodeBehind="CustomerDashboard.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.CustomerDashboard" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />

    <style>
        /* CUSTOMER DASHBOARD */

        .customer-dashboard {
            width: 100%;
            min-width: 0;
        }

        .customer-dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 28px;
        }

        .customer-dashboard-header h2 {
            font-size: 28px;
            font-weight: 700;
        }

        .customer-dashboard-header p {
            font-size: 14px;
        }

        .customer-dashboard .stat-card {
            border: 1px solid #e5eaf1;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(15, 23, 42, 0.05);
            transition: transform 0.2s ease;
        }

        .customer-dashboard .stat-card:hover {
            transform: translateY(-3px);
        }

        .customer-dashboard .stat-card h3 {
            font-size: 27px;
            font-weight: 700;
        }

        .customer-dashboard .dashboard-section-title {
            font-size: 21px;
            font-weight: 700;
            margin-top: 30px;
            margin-bottom: 18px;
        }

        .customer-bookings-table {
            background: #ffffff;
            border: 1px solid #e5eaf1;
            border-radius: 12px;
            overflow-x: auto;
        }

        .customer-bookings-table table {
            min-width: 850px;
            margin-bottom: 0;
        }

        .customer-bookings-table th {
            padding: 15px 12px;
            color: #334155;
            font-size: 12px;
            text-transform: uppercase;
            white-space: nowrap;
        }

        .customer-bookings-table td {
            padding: 14px 12px;
            font-size: 13px;
            vertical-align: middle;
        }

        .customer-bookings-table .booking-reference {
            color: #2457d6;
            font-weight: 700;
        }

        .customer-dashboard .dashboard-action {
            white-space: nowrap;
            margin: 2px;
        }

        .customer-empty-bookings {
            padding: 35px 20px;
            background: #ffffff;
            border: 1px dashed #cbd5e1;
            border-radius: 12px;
        }

        .customer-empty-bookings .customer-empty-icon {
            font-size: 38px;
            color: #94a3b8;
        }

        @media (max-width: 767.98px) {
            .customer-dashboard-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .customer-dashboard-header h2 {
                font-size: 23px;
            }

            .customer-dashboard .stat-card h3 {
                font-size: 24px;
            }
        }
    </style>

    <div class="customer-dashboard">

        <!-- DASHBOARD HEADER -->

        <div class="customer-dashboard-header">

            <div>
                <h2 class="text-navy mb-1 heading-font">
                    Welcome Back,
                    <asp:Label
                        ID="lblCustomerName"
                        runat="server"
                        Text="Customer" />!
                </h2>

                <p class="text-muted mb-0">
                    View your bookings, track their status and access your receipts.
                </p>
            </div>

            <a href="Catalogue.aspx"
               class="btn btn-primary">
                <i class="bi bi-plus-circle me-1"></i>
                New Booking
            </a>

        </div>


        <!-- BOOKING STATISTICS -->

        <div class="row g-3 mb-4">

            <!-- ACTIVE BOOKINGS -->

            <div class="col-md-4">

                <div class="card stat-card h-100 p-3 bg-white">

                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-calendar-check text-primary fs-4"></i>

                        <span class="text-muted small fw-bold">
                            ACTIVE BOOKINGS
                        </span>
                    </div>

                    <h3 class="text-navy mt-3 mb-0">
                        <asp:Label
                            ID="lblActiveBookings"
                            runat="server"
                            Text="0" />
                    </h3>

                </div>

            </div>


            <!-- TOTAL PAID -->

            <div class="col-md-4">

                <div class="card stat-card h-100 p-3 bg-white">

                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-wallet2 text-primary fs-4"></i>

                        <span class="text-muted small fw-bold">
                            TOTAL PAID
                        </span>
                    </div>

                    <h3 class="text-navy mt-3 mb-0">
                        R
                        <asp:Label
                            ID="lblOutstandingBalance"
                            runat="server"
                            Text="0.00" />
                    </h3>

                </div>

            </div>


            <!-- TOTAL ITEMS BOOKED -->

            <div class="col-md-4">

                <div class="card stat-card h-100 p-3 bg-white">

                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-box-seam text-primary fs-4"></i>

                        <span class="text-muted small fw-bold">
                            TOTAL ITEMS BOOKED
                        </span>
                    </div>

                    <h3 class="text-navy mt-3 mb-0">
                        <asp:Label
                            ID="lblItemsHired"
                            runat="server"
                            Text="0" />
                    </h3>

                </div>

            </div>

        </div>


        <!-- BOOKINGS SECTION -->

        <h4 class="text-navy heading-font dashboard-section-title">
            <i class="bi bi-calendar-event me-2"></i>
            My Bookings
        </h4>


        <!-- BOOKINGS TABLE -->

        <div class="table-responsive customer-bookings-table">

            <table class="table table-hover align-middle">

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

                    <asp:Repeater
                        ID="rptBookings"
                        runat="server">

                        <ItemTemplate>

                            <tr>

                                <td class="booking-reference">
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

                                <td class="text-nowrap">
                                    R <%#: Eval("PaymentAmount", "{0:N2}") %>
                                </td>

                                <td>

                                    <a href='TrackOrder.aspx?booking=<%#: Eval("DownloadId") %>'
                                       class="btn btn-sm btn-outline-primary dashboard-action">

                                        <i class="bi bi-eye me-1"></i>
                                        Track / View

                                    </a>

                                    <a href='CustomerDashboard.aspx?receipt=<%#: Eval("DownloadId") %>'
                                       class="btn btn-sm btn-outline-secondary dashboard-action">

                                        <i class="bi bi-download me-1"></i>
                                        Receipt

                                    </a>

                                </td>

                            </tr>

                        </ItemTemplate>

                    </asp:Repeater>

                </tbody>

            </table>

        </div>


        <!-- EMPTY BOOKINGS MESSAGE -->

        <asp:Panel
            ID="pnlNoBookings"
            runat="server"
            Visible="false"
            CssClass="customer-empty-bookings text-center text-muted mt-3">

            <i class="bi bi-calendar-x customer-empty-icon"></i>

            <h5 class="text-navy mt-3">
                No bookings yet
            </h5>

            <p class="mb-2">
                You do not have any saved bookings to display.
            </p>

            <a href="Catalogue.aspx"
               class="btn btn-primary mt-2">

                <i class="bi bi-bag me-1"></i>
                Browse Catalogue

            </a>

        </asp:Panel>

    </div>

</asp:Content>
