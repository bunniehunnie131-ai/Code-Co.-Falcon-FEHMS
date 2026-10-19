<%@ Page Title="Track My Bookings"
    Language="C#"
    MasterPageFile="~/Presentation/Customer.master"
    AutoEventWireup="true"
    CodeBehind="TrackOrder.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.TrackOrder"
    Culture="en-ZA" %>

<asp:Content ID="ContentStyles"
    ContentPlaceHolderID="CustomerHead"
    runat="server">

    <link href="../Stylesheet/Pages/TrackOrderIntegration.css"
          rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content1"
    ContentPlaceHolderID="CustomerContent"
    runat="server">

    <div class="tracker-page">

        <asp:Panel ID="pnlListView"
            runat="server"
            CssClass="tracker-view">

            <div class="tracker-header">
                <span class="tracker-eyebrow">BOOKING TRACKER</span>
                <h2>Track Your Bookings</h2>

                <p>
                    Select a booking to view its recorded status and details.
                </p>

                <a href="CustomerDashboard.aspx"
                   class="btn btn-outline-primary">
                    Back to Dashboard
                </a>
            </div>

            <asp:Panel ID="pnlMessage"
                runat="server"
                Visible="false"
                CssClass="tracker-message mb-3"
                role="alert">

                <asp:Label ID="lblStatusMessage" runat="server" />
            </asp:Panel>

            <asp:Repeater ID="rptTrackableOrders"
                runat="server"
                OnItemCommand="rptTrackableOrders_ItemCommand">

                <ItemTemplate>
                    <div class="tracker-order-card mb-3">
                        <div class="d-flex justify-content-between
                                    align-items-center flex-wrap gap-3">

                            <div>
                                <div class="mb-2">
                                    <span class="booking-reference">
                                        <%#: Eval("BookingReference") %>
                                    </span>

                                    <span class='<%# "badge-status " + GetStatusBadgeClass(Eval("BookingStatus")) %>'>
                                        <%#: Eval("BookingStatus") %>
                                    </span>
                                </div>

                                <h6 class="fw-bold">
                                    <%#: Eval("EventType") %>
                                </h6>

                                <p class="text-muted small mb-1">
                                    Event Date:
                                    <%#: Eval("EventDate") %>
                                </p>

                                <p class="text-muted small mb-0">
                                    Delivery / Collection:
                                    <%#: Eval("FirstTime") %>
                                </p>
                            </div>

                            <div>
                                <span class="text-muted small d-block">
                                    Amount Paid
                                </span>

                                <strong>
                                    R <%#: Eval("PaymentAmount", "{0:N2}") %>
                                </strong>
                            </div>

                            <asp:LinkButton ID="btnTrack"
                                runat="server"
                                CssClass="btn-track-order"
                                CausesValidation="false"
                                CommandName="ViewDetails"
                                CommandArgument='<%# Eval("DownloadId") %>'
                                Text="Track Order" />

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoTrackableOrders"
                runat="server"
                Visible="false"
                CssClass="empty-state text-center">

                <h6>No bookings to track</h6>
                <p class="text-muted">
                    Completed checkout bookings will appear here.
                </p>
            </asp:Panel>
        </asp:Panel>

        <asp:Panel ID="pnlDetailView"
            runat="server"
            Visible="false"
            CssClass="tracker-view">

            <div class="d-flex gap-2 mb-3 flex-wrap">
                <asp:LinkButton ID="btnBackToList"
                    runat="server"
                    CssClass="btn btn-outline-secondary"
                    CausesValidation="false"
                    OnClick="btnBackToList_Click"
                    Text="Back to My Bookings" />

                <asp:HyperLink ID="lnkRefresh"
                    runat="server"
                    CssClass="btn btn-outline-primary"
                    Text="Refresh Status" />

                <asp:HyperLink ID="lnkReceipt"
                    runat="server"
                    CssClass="btn btn-primary"
                    Text="Download Receipt" />
            </div>

            <div class="tracker-summary-card p-4 mb-3">
                <span class="text-muted small">BOOKING REFERENCE</span>

                <h4 class="text-navy fw-bold">
                    <asp:Label ID="lblDetailReference" runat="server" />
                </h4>

                <p>
                    Booked for
                    <strong>
                        <asp:Label ID="lblDetailCustomerName"
                            runat="server" />
                    </strong>
                </p>

                <div class="d-flex gap-3 flex-wrap">
                    <div class="tracker-pill">
                        <span class="text-muted small d-block">
                            Payment
                        </span>
                        <asp:Label ID="lblDetailPaymentStatus"
                            runat="server" />
                    </div>

                    <div class="tracker-pill tracker-pill-active">
                        <span class="text-muted small d-block">
                            Current Status
                        </span>
                        <asp:Label ID="lblDetailCurrentStatus"
                            runat="server" />
                    </div>
                </div>

                <h6 class="fw-bold mt-4">Order Progress</h6>

                <p>
                    <asp:Label ID="lblProgressHeadline"
                        runat="server" />
                </p>

                <div class="stepper">
                    <asp:Repeater ID="rptSteps" runat="server">
                        <ItemTemplate>
                            <div class='<%# "step-item " + Eval("StateCss") %>'>
                                <div class="step-circle">
                                    <%#: Eval("StepNumber") %>
                                </div>

                                <div class="step-label">
                                    <%#: Eval("Label") %>
                                </div>

                                <div class="step-date">
                                    <%#: Eval("DateText") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="delivery-estimate-bar mt-3">
                    <div>
                        Scheduled delivery / collection:
                        <asp:Label ID="lblEstimatedDelivery"
                            runat="server" />
                    </div>

                    <div class="mt-2 small">
                        <asp:Label ID="lblLastUpdated"
                            runat="server" />
                    </div>
                </div>
            </div>

            <div class="tracker-summary-card p-4 mb-3">
                <h5 class="fw-bold mb-3">Event &amp; Delivery Details</h5>

                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                            <tr>
                                <th>Event Date</th>
                                <td>
                                    <asp:Label ID="lblEventDate"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Event Type</th>
                                <td>
                                    <asp:Label ID="lblEventType"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Transport Method</th>
                                <td>
                                    <asp:Label ID="lblTransportMethod"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Address / Collection Point</th>
                                <td>
                                    <asp:Label ID="lblDeliveryAddress"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Delivery / Collection</th>
                                <td>
                                    <asp:Label ID="lblDeliveryDate"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Collection / Return</th>
                                <td>
                                    <asp:Label ID="lblEstimatedTime"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Phone</th>
                                <td>
                                    <asp:Label ID="lblCustomerContact"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td>
                                    <asp:Label ID="lblCustomerEmail"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Setup Required</th>
                                <td>
                                    <asp:Label ID="lblSetupRequired"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Service Providers</th>
                                <td>
                                    <asp:Label ID="lblServiceProviders"
                                        runat="server" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="tracker-summary-card p-4 mb-3">
                <h5 class="fw-bold mb-3">Booked Equipment</h5>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Equipment</th>
                                <th>Colour / Unit Price</th>
                                <th>Quantity</th>
                                <th>Line Total</th>
                            </tr>
                        </thead>

                        <tbody>
                            <asp:Repeater ID="rptBookingItems"
                                runat="server">

                                <ItemTemplate>
                                    <tr>
                                        <td><%#: Eval("Name") %></td>
                                        <td><%#: Eval("SubLabel") %></td>
                                        <td><%#: Eval("Quantity") %></td>
                                        <td>
                                            R <%#: Eval("LineTotal", "{0:N2}") %>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>

                <table class="table">
                    <tbody>
                        <tr>
                            <th>Item Total</th>
                            <td>
                                <asp:Label ID="lblSubtotal"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th>Delivery &amp; Collection Fee</th>
                            <td>
                                <asp:Label ID="lblDeliveryFee"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th>Setup Fee</th>
                            <td>
                                <asp:Label ID="lblSetupFee"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th>Service Provider Fee</th>
                            <td>
                                <asp:Label ID="lblProviderFee"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th>Late / No-Show Fee Applied</th>
                            <td>
                                <asp:Label ID="lblLateFee"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr class="fw-bold">
                            <th>Booking Total</th>
                            <td>
                                <asp:Label ID="lblGrandTotal"
                                    runat="server" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="tracker-summary-card p-4 mb-3">
                <h5 class="fw-bold mb-3">Payment Details</h5>

                <table class="table">
                    <tbody>
                        <tr>
                            <th>Payment Reference</th>
                            <td>
                                <asp:Label ID="lblPaymentMethod"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th>Payment Date &amp; Time</th>
                            <td>
                                <asp:Label ID="lblPaidAt"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th>Payment Status</th>
                            <td>
                                <asp:Label ID="lblPaymentStatusRow"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr class="fw-bold">
                            <th>Amount Paid</th>
                            <td>
                                <asp:Label ID="lblAmountPaid"
                                    runat="server" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </asp:Panel>
    </div>
</asp:Content>
