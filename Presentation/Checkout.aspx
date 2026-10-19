<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.Checkout" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Checkout - Forte Event Hire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body{background:#f5f7fa;font-family:"Segoe UI",Arial,sans-serif;color:#263238}.top{background:#1a2d5c;color:#fff;padding:22px 5%}.wrap{width:92%;max-width:1100px;margin:35px auto 70px}.cardx{background:#fff;border-radius:14px;padding:28px;box-shadow:0 4px 15px rgba(0,0,0,.07);margin-bottom:24px}.title{color:#1a2d5c;font-weight:800}.summary-row{display:flex;justify-content:space-between;gap:20px;padding:10px 0;border-bottom:1px solid #eee}.total{font-size:20px;font-weight:800;color:#0052cc}.error-box{display:block;background:#fff0f0;border:1px solid #efc5c5;color:#a12626;padding:12px;border-radius:8px;margin-bottom:18px}.btn-main{background:#0052cc;color:#fff;border:none;border-radius:8px;padding:12px 20px;font-weight:800}.btn-back{background:#fff;color:#1a2d5c;border:1px solid #ccd3dc;border-radius:8px;padding:12px 20px;font-weight:700}.item{display:flex;justify-content:space-between;gap:20px;padding:12px 0;border-bottom:1px solid #eee}.muted{color:#6c757d}@media(max-width:650px){.item,.summary-row{flex-direction:column;gap:4px}}
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="top"><h2 class="m-0">Checkout</h2><div>Catalogue → Cart → <strong>Checkout</strong> → Delivery & Extras → Payment → Confirmation</div></div>
    <main class="wrap">
        <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="error-box" />

        <section class="cardx">
            <h3 class="title">1. Event Information</h3>
            <p class="muted">Enter only the event information here. Delivery and customer delivery details are entered on the next page.</p>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Event Date</label>
                    <asp:TextBox ID="txtEventDate" runat="server" TextMode="Date" CssClass="form-control" />
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Event Type</label>
                    <asp:DropDownList ID="ddlEventType" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Select Event Type" Value="" />
                        <asp:ListItem Text="Wedding" Value="Wedding" />
                        <asp:ListItem Text="Birthday Party" Value="Birthday Party" />
                        <asp:ListItem Text="Corporate Event" Value="Corporate Event" />
                        <asp:ListItem Text="Graduation" Value="Graduation" />
                        <asp:ListItem Text="Baby Shower" Value="Baby Shower" />
                        <asp:ListItem Text="Other" Value="Other" />
                    </asp:DropDownList>
                </div>
                <div class="col-12">
                    <label class="form-label fw-bold">Event Notes <span class="text-muted fw-normal">(optional)</span></label>
                    <asp:TextBox ID="txtEventNotes" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" />
                </div>
            </div>
        </section>

        <section class="cardx">
            <h3 class="title">2. Cart Summary</h3>
            <asp:Repeater ID="rptCheckout" runat="server">
                <ItemTemplate>
                    <div class="item">
                        <div><strong><%# Eval("Name") %></strong><div class="muted"><%# Eval("Colour") %> · Qty <%# Eval("Quantity") %></div></div>
                        <div>R<%# (Convert.ToDecimal(Eval("UnitPrice"))*Convert.ToInt32(Eval("Quantity"))).ToString("N2") %></div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="summary-row mt-3"><span>Total Items</span><asp:Label ID="lblTotalItems" runat="server" /></div>
            <div class="summary-row total"><span>Item Total</span><asp:Label ID="lblTotalPrice" runat="server" /></div>
        </section>

        <div class="d-flex justify-content-between flex-wrap gap-3">
            <asp:Button ID="btnBackToCart" runat="server" Text="← Back To Cart" CssClass="btn-back" CausesValidation="false" OnClick="btnBackToCart_Click" />
            <asp:Button ID="btnContinueToExtras" runat="server" Text="Continue To Delivery & Extras →" CssClass="btn-main" OnClick="btnContinueToExtras_Click" />
        </div>
    </main>
</form>
</body>
</html>

