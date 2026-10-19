<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.OrderConfirmation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Order Confirmation - Forte Event Hire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body{background:#f5f7fa;font-family:"Segoe UI",Arial,sans-serif;color:#263238}.top{background:#1a2d5c;color:#fff;padding:22px 5%}.wrap{width:92%;max-width:1120px;margin:35px auto 70px}.cardx{background:#fff;border-radius:14px;padding:26px;box-shadow:0 4px 15px rgba(0,0,0,.07);margin-bottom:24px}.title{color:#1a2d5c;font-weight:800}.success{text-align:center;border-top:5px solid #28a745}.ok{width:70px;height:70px;border-radius:50%;background:#e9f8ed;color:#28a745;display:flex;align-items:center;justify-content:center;margin:0 auto 14px;font-size:38px;font-weight:800}.rowx{display:flex;justify-content:space-between;gap:20px;padding:9px 0;border-bottom:1px solid #eee}.item{display:flex;justify-content:space-between;gap:20px;padding:11px 0;border-bottom:1px solid #eee}.total{font-size:22px;font-weight:800;color:#0052cc}.muted{color:#6c757d}.btn-main{background:#0052cc;color:#fff;border:none;border-radius:8px;padding:13px 20px;font-weight:800}.btn-secondaryx{background:#fff;color:#1a2d5c;border:1px solid #ccd3dc;border-radius:8px;padding:13px 20px;font-weight:700}.status{display:inline-block;background:#e8f7ed;color:#24843e;padding:6px 10px;border-radius:20px;font-weight:800}.chip{display:inline-block;background:#eef5ff;color:#1a2d5c;padding:5px 9px;border-radius:20px;margin:2px 4px 2px 0}@media(max-width:650px){.rowx,.item{flex-direction:column;gap:3px}}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="top"><h2 class="m-0">Order Confirmation</h2><div>Catalogue → Cart → Checkout → Delivery & Extras → Payment → <strong>Confirmation</strong></div></div>
<main class="wrap">
    <section class="cardx success">
        <div class="ok">✓</div><h2 class="text-success fw-bold">Booking Confirmed!</h2>
        <p>Thank you, <strong><asp:Label ID="lblCustomerName" runat="server" /></strong>.</p>
        <p>Booking Reference: <strong><asp:Label ID="lblBookingReference" runat="server" /></strong></p>
        <p>Payment Reference: <strong><asp:Label ID="lblPaymentReference" runat="server" /></strong></p>
        <span class="status"><asp:Label ID="lblBookingStatus" runat="server" /></span>
        <span class="status ms-2"><asp:Label ID="lblPaymentStatus" runat="server" /></span>
    </section>

    <section class="cardx">
        <h3 class="title">Booking Details</h3>
        <div class="rowx"><span>Customer</span><asp:Label ID="lblCustomer" runat="server" /></div>
        <div class="rowx"><span>Email</span><asp:Label ID="lblEmail" runat="server" /></div>
        <div class="rowx"><span>Phone</span><asp:Label ID="lblPhone" runat="server" /></div>
        <div class="rowx"><span>Event Date</span><asp:Label ID="lblEventDate" runat="server" /></div>
        <div class="rowx"><span>Event Type</span><asp:Label ID="lblEventType" runat="server" /></div>
        <div class="rowx"><span>Payment Date & Time</span><asp:Label ID="lblPaymentDateTime" runat="server" /></div>
    </section>

    <section class="cardx">
        <h3 class="title">Booked Items</h3>
        <asp:Repeater ID="rptItems" runat="server"><ItemTemplate><div class="item"><div><strong><%# Eval("Name") %></strong><div class="muted"><%# Eval("Colour") %> · Qty <%# Eval("Quantity") %> · R<%# Convert.ToDecimal(Eval("UnitPrice")).ToString("N2") %> each</div></div><div>R<%# (Convert.ToDecimal(Eval("UnitPrice"))*Convert.ToInt32(Eval("Quantity"))).ToString("N2") %></div></div></ItemTemplate></asp:Repeater>
    </section>

    <section class="cardx">
        <h3 class="title">Delivery & Extras</h3>
        <div class="rowx"><span>Transport Method</span><asp:Label ID="lblTransportMethod" runat="server" /></div>
        <div class="rowx"><span>Address / Collection Point</span><asp:Label ID="lblAddress" runat="server" /></div>
        <div class="rowx"><span>Delivery / Collection</span><asp:Label ID="lblFirstTime" runat="server" /></div>
        <div class="rowx"><span>Collection / Return</span><asp:Label ID="lblSecondTime" runat="server" /></div>
        <div class="rowx"><span>Setup</span><asp:Label ID="lblSetup" runat="server" /></div>
        <div class="mt-3"><strong>Service Providers</strong><div class="mt-2"><asp:Label ID="lblProviders" runat="server" /></div></div>
        <div class="alert alert-warning mt-4 mb-0">Late / No-Show policy: R150 may be applied later if the agreed delivery, collection or return time is missed. It was not charged in this payment.</div>
    </section>

    <section class="cardx">
        <h3 class="title">Receipt Summary</h3>
        <div class="rowx"><span>Item Total</span><asp:Label ID="lblItemTotal" runat="server" /></div>
        <div class="rowx"><span>Delivery & Collection Fee</span><asp:Label ID="lblDeliveryFee" runat="server" /></div>
        <div class="rowx"><span>Setup Fee</span><asp:Label ID="lblSetupFee" runat="server" /></div>
        <div class="rowx"><span>Service Provider Fee</span><asp:Label ID="lblProviderFee" runat="server" /></div>
        <div class="rowx"><span>Late / No-Show Fee Applied</span><asp:Label ID="lblLateFee" runat="server" /></div>
        <div class="rowx total"><span>Total Paid</span><asp:Label ID="lblTotalPaid" runat="server" /></div>
    </section>

   

    <section class="cardx text-center">
    <asp:Button
        ID="Button1"
        runat="server"
        Text="Download Receipt"
        CssClass="btn-main"
        OnClick="btnDownloadReceipt_Click" />

    <a href="CustomerDashboard.aspx"
       class="btn-main d-inline-block text-decoration-none ms-2 mt-2">
        Go to My Dashboard
    </a>

    <asp:Button
        ID="Button2"
        runat="server"
        Text="Continue Shopping"
        CssClass="btn-secondaryx ms-2"
        CausesValidation="false"
        OnClick="btnCatalogue_Click" />

    <p class="muted mt-3 mb-0">
        The downloaded receipt includes booked items, quantities, prices,
        event date, delivery/collection dates and times,
        payment date/time, and total paid.
    </p>
</section>

</main>
</form>
</body>
</html>

