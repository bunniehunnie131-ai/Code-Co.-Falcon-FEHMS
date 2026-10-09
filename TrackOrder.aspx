<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/Customer.master" AutoEventWireup="true" CodeBehind="TrackOrder.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.TrackOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerContent" runat="server">

    <link href="<%= ResolveUrl("~/Stylesheet/Forte.css") %>" rel="stylesheet" />
    <link href="../Stylesheet/CustomerDesign.css" rel="stylesheet" />  
<!-- ================= LIST VIEW ================= -->
<asp:Panel ID="pnlListView" runat="server" CssClass="tracker-view">

    <div class="mb-4">
        <span class="tracker-eyebrow">BOOKING TRACKER</span>
        <h2 class="text-navy mb-1 heading-font">Track Your Bookings</h2>
        <p class="text-muted m-0">Select a paid booking below to see its live delivery status.</p>
    </div>

    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-success mb-4" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>
        <asp:Label ID="lblStatusMessage" runat="server" Text=""></asp:Label>
    </asp:Panel>

    <div class="row g-3">
        <asp:Repeater ID="rptTrackableOrders" runat="server" OnItemCommand="rptTrackableOrders_ItemCommand">
            <ItemTemplate>
                <div class="col-12">
                    <div class="card tracker-order-card p-3">
                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">

                            <div class="tracker-order-info">
                                <div class="d-flex align-items-center gap-2 mb-2">
                                    <span class="fw-bold text-blue"><%# Eval("BookingReference") %></span>
                                    <span class="badge <%# GetStageBadgeClass(Convert.ToInt32(Eval("CurrentStageIndex"))) %> badge-status">
                                        <%# GetStageLabel(Convert.ToInt32(Eval("CurrentStageIndex"))) %>
                                    </span>
                                </div>
                                <h6 class="text-navy fw-bold mb-1"><%# Eval("EventType") %></h6>
                                <p class="text-muted small mb-0">
                                    <i class="bi bi-calendar-event me-1"></i>
                                    Event Date: <%# Eval("EventDate", "{0:dd MMM yyyy}") %>
                                </p>
                                <p class="text-muted small mb-0">
                                    <i class="bi bi-truck me-1"></i>
                                    Estimated Delivery: <%# Eval("DeliveryDate", "{0:dd MMM yyyy}") %>
                                </p>
                            </div>

                            <div class="tracker-order-amount text-center">
                                <span class="text-muted text-uppercase small fw-bold d-block">Amount Paid</span>
                                <span class="text-navy fw-bold fs-5">R <%# Eval("AmountPaid", "{0:N2}") %></span>
                            </div>

                            <div class="tracker-order-action">
                                <asp:LinkButton ID="btnTrack" runat="server" CssClass="btn btn-save-profile btn-sm rounded-pill px-4"
                                    CommandName="ViewDetails" CommandArgument='<%# Eval("OrderID") %>'>
                                    Track Order <i class="bi bi-chevron-right ms-1"></i>
                                </asp:LinkButton>
                            </div>

                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlNoTrackableOrders" runat="server" Visible="false" CssClass="empty-state text-center py-5">
            <i class="bi bi-truck fs-1 text-muted mb-3 d-block"></i>
            <h6 class="text-navy fw-bold">Nothing to track right now</h6>
            <p class="text-muted small mb-0">Paid bookings awaiting delivery will show up here.</p>
        </asp:Panel>
    </div>

</asp:Panel>

<!-- ================= DETAIL VIEW ================= -->
<asp:Panel ID="pnlDetailView" runat="server" CssClass="tracker-view" Visible="false">

    <asp:LinkButton ID="btnBackToList" runat="server" CssClass="btn-back-link mb-3" OnClick="btnBackToList_Click">
        <i class="bi bi-arrow-left me-1"></i>Back to My Bookings
    </asp:LinkButton>

    <!-- BOOKING SUMMARY BAR -->
    <div class="card tracker-summary-card p-4 mb-3">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
            <div>
                <span class="text-muted small text-uppercase fw-bold">Booking reference</span>
                <h4 class="text-navy fw-bold mb-1"><asp:Label ID="lblDetailReference" runat="server" /></h4>
                <span class="text-muted small">Booked for <asp:Label ID="lblDetailCustomerName" runat="server" /></span>
            </div>
            <div class="d-flex gap-2">
                <div class="tracker-pill">
                    <span class="text-muted small d-block">Payment</span>
                    <span class="fw-bold text-navy"><asp:Label ID="lblDetailPaymentStatus" runat="server" /></span>
                </div>
                <div class="tracker-pill tracker-pill-active">
                    <span class="small d-block">Current status</span>
                    <span class="fw-bold"><asp:Label ID="lblDetailCurrentStatus" runat="server" /></span>
                </div>
            </div>
        </div>

        <!-- PROGRESS STEPPER -->
        <div class="order-progress mt-4">
            <div class="d-flex align-items-center gap-2 mb-3">
                <i class="bi bi-box-seam text-blue fs-5"></i>
                <div>
                    <span class="text-muted small text-uppercase fw-bold d-block">Order Progress</span>
                    <span class="text-navy fw-bold"><asp:Label ID="lblProgressHeadline" runat="server" /></span>
                </div>
            </div>

            <div class="stepper">
                <asp:Repeater ID="rptSteps" runat="server">
                    <ItemTemplate>
                        <div class='step-item <%# Eval("StateCss") %>'>
                            <div class="step-circle">
                                <i class="bi bi-check-lg" style='<%# (bool)Eval("IsComplete") ? "" : "display:none;" %>'></i>
                                <span style='<%# (bool)Eval("IsComplete") ? "display:none;" : "" %>'><%# Eval("StepNumber") %></span>
                            </div>
                            <div class="step-label"><%# Eval("Label") %></div>
                            <div class="step-date"><%# Eval("DateText") %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="delivery-estimate-bar d-flex justify-content-between flex-wrap gap-2 mt-3">
                <span><i class="bi bi-truck me-2"></i>Estimated delivery: <asp:Label ID="lblEstimatedDelivery" runat="server" /></span>
                <span><asp:Label ID="lblLastUpdated" runat="server" /></span>
            </div>
        </div>
    </div>

    <!-- DELIVERY & EVENT DETAILS -->
    <div class="card tracker-summary-card p-4 mb-3">
        <h5 class="text-navy fw-bold mb-1">Delivery & Event Details</h5>
        <p class="text-muted small mb-3">Logistics and contact information for your upcoming event.</p>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="detail-item">
                    <i class="bi bi-calendar3"></i>
                    <div>
                        <span class="detail-label">Event Date</span>
                        <span class="detail-value"><asp:Label ID="lblEventDate" runat="server" /></span>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="detail-item">
                    <i class="bi bi-cake2"></i>
                    <div>
                        <span class="detail-label">Event Type</span>
                        <span class="detail-value"><asp:Label ID="lblEventType" runat="server" /></span>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="detail-item">
                    <i class="bi bi-geo-alt"></i>
                    <div>
                        <span class="detail-label">Delivery Address</span>
                        <span class="detail-value"><asp:Label ID="lblDeliveryAddress" runat="server" /></span>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="detail-item">
                    <i class="bi bi-truck"></i>
                    <div>
                        <span class="detail-label">Delivery Date</span>
                        <span class="detail-value"><asp:Label ID="lblDeliveryDate" runat="server" /></span>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="detail-item">
                    <i class="bi bi-clock"></i>
                    <div>
                        <span class="detail-label">Estimated Time</span>
                        <span class="detail-value"><asp:Label ID="lblEstimatedTime" runat="server" /></span>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="detail-item">
                    <i class="bi bi-telephone"></i>
                    <div>
                        <span class="detail-label">Customer Contact</span>
                        <span class="detail-value"><asp:Label ID="lblCustomerContact" runat="server" /></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- YOUR BOOKING ITEMS -->
    <div class="card tracker-summary-card p-4 mb-3">
        <div class="d-flex justify-content-between align-items-start mb-3">
            <div>
                <h5 class="text-navy fw-bold mb-1">Your Booking</h5>
                <p class="text-muted small mb-0">Items, packages, and services reserved for your event.</p>
            </div>
        </div>

        <asp:Repeater ID="rptBookingItems" runat="server">
            <ItemTemplate>
                <div class="booking-item-row d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center gap-3">
                        <div class="booking-item-icon"><i class="bi <%# Eval("IconClass") %>"></i></div>
                        <div>
                            <span class="fw-bold text-navy d-block"><%# Eval("Name") %></span>
                            <span class="text-muted small"><%# Eval("SubLabel") %></span>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-4">
                        <span class="text-muted">Qty <%# Eval("Quantity") %></span>
                        <span class="fw-bold text-navy">R <%# Eval("LineTotal", "{0:N2}") %></span>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <div class="booking-totals mt-3 pt-3 border-top">
            <div class="d-flex justify-content-between text-muted">
                <span>Subtotal</span>
                <span><asp:Label ID="lblSubtotal" runat="server" /></span>
            </div>
            <div class="d-flex justify-content-between text-muted mb-2">
                <span>Delivery</span>
                <span><asp:Label ID="lblDeliveryFee" runat="server" /></span>
            </div>
            <div class="d-flex justify-content-between">
                <span class="fw-bold text-navy">Total</span>
                <span class="fw-bold text-navy fs-5"><asp:Label ID="lblGrandTotal" runat="server" /></span>
            </div>
        </div>
    </div>

    <!-- PAYMENT SUMMARY -->
    <div class="card tracker-summary-card p-4 mb-3">
        <h5 class="text-navy fw-bold mb-3">Payment Summary</h5>
        <div class="d-flex justify-content-between text-muted mb-2">
            <span>Payment method</span>
            <span><asp:Label ID="lblPaymentMethod" runat="server" /></span>
        </div>
        <div class="d-flex justify-content-between text-muted mb-3">
            <span>Payment status</span>
            <span><asp:Label ID="lblPaymentStatusRow" runat="server" /></span>
        </div>
        <div class="d-flex justify-content-between pt-3 border-top">
            <span class="fw-bold text-navy">Amount paid</span>
            <span class="fw-bold text-navy fs-5"><asp:Label ID="lblAmountPaid" runat="server" /></span>
        </div>
    </div>
    

    <!-- SUPPORT BANNER -->
    <div class="p-4 rounded d-flex align-items-center justify-content-between flex-wrap gap-3 support-banner">
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-person-plus-fill fs-3"></i>
            <div>
                <h6 class="fw-bold mb-1">Need Help With Your Booking?</h6>
                <p class="m-0 small">Contact Forte support if you have questions about your delivery, hired items, or booking.</p>
            </div>
        </div>
        <div class="d-flex gap-2">
            <a href="Contact.aspx" class="btn btn-light btn-sm px-3">Contact Support</a>
        </div>
    </div>
    </asp:Panel>

</asp:Content>
