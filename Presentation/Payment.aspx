<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="WebApplication2.WebForm6" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Payment - Forte Event Hire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body{background:#f5f7fa;font-family:"Segoe UI",Arial,sans-serif;color:#263238}.top{background:#1a2d5c;color:#fff;padding:22px 5%}.wrap{width:92%;max-width:1180px;margin:35px auto 70px}.cardx{background:#fff;border-radius:14px;padding:26px;box-shadow:0 4px 15px rgba(0,0,0,.07);margin-bottom:24px}.title{color:#1a2d5c;font-weight:800}.rowx{display:flex;justify-content:space-between;gap:20px;padding:9px 0;border-bottom:1px solid #eee}.total{font-size:22px;font-weight:800;color:#0052cc}.muted{color:#6c757d}.btn-main{background:#0052cc;color:#fff;border:none;border-radius:8px;padding:13px 20px;font-weight:800}.btn-back{background:#fff;color:#1a2d5c;border:1px solid #ccd3dc;border-radius:8px;padding:13px 20px;font-weight:700}.error-box{display:block;background:#fff0f0;border:1px solid #efc5c5;color:#a12626;padding:12px;border-radius:8px;margin-bottom:18px}.item{display:flex;justify-content:space-between;gap:20px;padding:10px 0;border-bottom:1px solid #eee}.chip{display:inline-block;background:#eef5ff;color:#1a2d5c;padding:5px 9px;border-radius:20px;margin:2px 4px 2px 0}@media(max-width:650px){.rowx,.item{flex-direction:column;gap:3px}}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="top"><h2 class="m-0">Payment</h2><div>Catalogue → Cart → Checkout → Delivery & Extras → <strong>Payment</strong> → Confirmation</div></div>
<main class="wrap">
    <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="error-box" />
    <div class="row g-4">
        <div class="col-lg-7">
            <section class="cardx">
                <h3 class="title">Order Summary</h3>
                <h6 class="fw-bold mt-3">Items</h6>
                <asp:Repeater ID="rptItems" runat="server"><ItemTemplate><div class="item"><div><strong><%# Eval("Name") %></strong><div class="muted"><%# Eval("Colour") %> · Qty <%# Eval("Quantity") %> · R<%# Convert.ToDecimal(Eval("UnitPrice")).ToString("N2") %> each</div></div><div>R<%# (Convert.ToDecimal(Eval("UnitPrice"))*Convert.ToInt32(Eval("Quantity"))).ToString("N2") %></div></div></ItemTemplate></asp:Repeater>

                <h6 class="fw-bold mt-4">Checkout</h6>
                <div class="rowx"><span>Event Date</span><asp:Label ID="lblEventDate" runat="server" /></div>
                <div class="rowx"><span>Event Type</span><asp:Label ID="lblEventType" runat="server" /></div>
                <div class="rowx"><span>Event Notes</span><asp:Label ID="lblEventNotes" runat="server" /></div>

                <h6 class="fw-bold mt-4">Customer & Delivery</h6>
                <div class="rowx"><span>Customer</span><asp:Label ID="lblCustomer" runat="server" /></div>
                <div class="rowx"><span>Email</span><asp:Label ID="lblEmail" runat="server" /></div>
                <div class="rowx"><span>Phone</span><asp:Label ID="lblPhone" runat="server" /></div>
                <div class="rowx"><span>Method</span><asp:Label ID="lblTransportMethod" runat="server" /></div>
                <div class="rowx"><span>Address / Collection Point</span><asp:Label ID="lblAddress" runat="server" /></div>
                <div class="rowx"><span>Delivery / Collection</span><asp:Label ID="lblFirstTime" runat="server" /></div>
                <div class="rowx"><span>Collection / Return</span><asp:Label ID="lblSecondTime" runat="server" /></div>

                <h6 class="fw-bold mt-4">Setup & Service Providers</h6>
                <div class="rowx"><span>Setup</span><asp:Label ID="lblSetup" runat="server" /></div>
                <div class="mt-2"><asp:Label ID="lblProviders" runat="server" /></div>
            </section>

            <section class="cardx">
                <h3 class="title">Price Summary</h3>
                <div class="rowx"><span>Item Total</span><asp:Label ID="lblItemTotal" runat="server" /></div>
                <div class="rowx"><span>Delivery & Collection Fee</span><asp:Label ID="lblDeliveryFee" runat="server" /></div>
                <div class="rowx"><span>Setup Fee</span><asp:Label ID="lblSetupFee" runat="server" /></div>
                <div class="rowx"><span>Service Provider Fee</span><asp:Label ID="lblProviderFee" runat="server" /></div>
                <div class="rowx"><span>Late / No-Show Fee</span><span>R0.00 at booking</span></div>
                <div class="rowx total"><span>Total Due</span><asp:Label ID="lblTotalDue" runat="server" /></div>
            </section>
        </div>

        <div class="col-lg-5">
            <section class="cardx">
                <h3 class="title">Payment Details</h3>
                <div class="alert alert-info">Demo payment form. Do not use real card information in a school/demo system.</div>
                <div class="mb-3"><label class="form-label fw-bold">Bank Name</label><asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-select"><asp:ListItem Text="Select Bank" Value=""/><asp:ListItem>ABSA</asp:ListItem><asp:ListItem>Capitec</asp:ListItem><asp:ListItem>FNB</asp:ListItem><asp:ListItem>Nedbank</asp:ListItem><asp:ListItem>Standard Bank</asp:ListItem><asp:ListItem>Other</asp:ListItem></asp:DropDownList></div>
                <div class="mb-3"><label class="form-label fw-bold">Card Holder</label><asp:TextBox ID="txtCardHolder" runat="server" CssClass="form-control" /></div>
                <div class="mb-3"><label class="form-label fw-bold">Card Number</label><asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" MaxLength="19" placeholder="1234 5678 9012 3456" /></div>
                <div class="row g-3">
                    <div class="col-6"><label class="form-label fw-bold">Expiry</label><asp:TextBox ID="txtExpiry" runat="server" CssClass="form-control" placeholder="MM/YY" MaxLength="5" /></div>
                    <div class="col-6"><label class="form-label fw-bold">CVV</label><asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" TextMode="Password" MaxLength="3" /></div>
                </div>
                <asp:Button ID="btnPay" runat="server" Text="Pay Now" CssClass="btn-main w-100 mt-4" OnClick="btnPay_Click" />
                <asp:Button ID="btnBack" runat="server" Text="← Back To Delivery & Extras" CssClass="btn-back w-100 mt-2" CausesValidation="false" OnClick="btnBack_Click" />
            </section>
        </div>
    </div>
</main>
</form>
</body>
</html>
