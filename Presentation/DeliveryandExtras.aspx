<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeliveryandExtras.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.DeliveryandExtras" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Delivery & Extras - Forte Event Hire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body{background:#f5f7fa;font-family:"Segoe UI",Arial,sans-serif;color:#263238}.top{background:#1a2d5c;color:#fff;padding:22px 5%}.wrap{width:92%;max-width:1150px;margin:35px auto 70px}.cardx{background:#fff;border-radius:14px;padding:28px;box-shadow:0 4px 15px rgba(0,0,0,.07);margin-bottom:24px}.title{color:#1a2d5c;font-weight:800}.choice{border:2px solid #e1e6ec;border-radius:10px;padding:17px;background:#fafbfd}.info{background:#eef5ff;border-left:4px solid #0052cc;padding:15px;border-radius:8px}.fee{display:flex;justify-content:space-between;padding:9px 0;border-bottom:1px solid #eee}.grand{font-size:20px;font-weight:800;color:#0052cc}.error-box{display:block;background:#fff0f0;border:1px solid #efc5c5;color:#a12626;padding:12px;border-radius:8px;margin-bottom:18px}.btn-main{background:#0052cc;color:#fff;border:none;border-radius:8px;padding:12px 20px;font-weight:800}.btn-back{background:#fff;color:#1a2d5c;border:1px solid #ccd3dc;border-radius:8px;padding:12px 20px;font-weight:700}.provider{display:grid;grid-template-columns:minmax(160px,1fr) 130px 120px;gap:12px;align-items:center;padding:12px 0;border-bottom:1px solid #eee}.muted{color:#6c757d}@media(max-width:700px){.provider{grid-template-columns:1fr}.fee{gap:15px}.choice{margin-bottom:10px}}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="top"><h2 class="m-0">Delivery & Extras</h2><div>Catalogue → Cart → Checkout → <strong>Delivery & Extras</strong> → Payment → Confirmation</div></div>
<main class="wrap">
    <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="error-box" />

    <section class="cardx">
        <h3 class="title">Checkout Information</h3>
        <p class="muted">This information comes from Checkout and is shown here only for reference.</p>
        <div class="row g-3">
            <div class="col-md-4"><strong>Event Date</strong><br/><asp:Label ID="lblEventDate" runat="server" /></div>
            <div class="col-md-4"><strong>Event Type</strong><br/><asp:Label ID="lblEventType" runat="server" /></div>
            <div class="col-md-4"><strong>Item Total</strong><br/><asp:Label ID="lblItemTotalTop" runat="server" /></div>
        </div>
    </section>

    <section class="cardx">
        <h3 class="title">1. Customer Details</h3>
        <div class="row g-3">
            <div class="col-md-4"><label class="form-label fw-bold">Full Name</label><asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" /></div>
            <div class="col-md-4"><label class="form-label fw-bold">Email</label><asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" /></div>
            <div class="col-md-4"><label class="form-label fw-bold">Phone Number</label><asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" /></div>
        </div>
    </section>

    <section class="cardx">
        <h3 class="title">2. Delivery / Collection</h3>
        <p>Choose who will handle transport of the equipment.</p>
        <div class="row g-3 mb-4">
            <div class="col-md-6"><div class="choice"><asp:RadioButton ID="rbCompanyTransport" runat="server" GroupName="Transport" Text=" Forte Event Hire will deliver and collect" AutoPostBack="true" OnCheckedChanged="Transport_CheckedChanged" /><div class="muted mt-1">A delivery & collection fee of 7% of the item total applies.</div></div></div>
            <div class="col-md-6"><div class="choice"><asp:RadioButton ID="rbCustomerTransport" runat="server" GroupName="Transport" Text=" I will collect and return the equipment" AutoPostBack="true" OnCheckedChanged="Transport_CheckedChanged" /><div class="muted mt-1">No 7% transport fee is charged.</div></div></div>
        </div>

        <asp:Panel ID="pnlCompanyTransport" runat="server">
            <h5 class="fw-bold">Forte Delivery & Collection Details</h5>
            <div class="row g-3">
                <div class="col-md-8"><label class="form-label fw-bold">Delivery Address</label><asp:TextBox ID="txtDeliveryAddress" runat="server" CssClass="form-control" /></div>
                <div class="col-md-4"><label class="form-label fw-bold">City / Town</label><asp:TextBox ID="txtCity" runat="server" CssClass="form-control" /></div>
                <div class="col-md-4"><label class="form-label fw-bold">Province</label><asp:DropDownList ID="ddlProvince" runat="server" CssClass="form-select"><asp:ListItem Text="Select Province" Value=""/><asp:ListItem>Eastern Cape</asp:ListItem><asp:ListItem>Free State</asp:ListItem><asp:ListItem>Gauteng</asp:ListItem><asp:ListItem>KwaZulu-Natal</asp:ListItem><asp:ListItem>Limpopo</asp:ListItem><asp:ListItem>Mpumalanga</asp:ListItem><asp:ListItem>North West</asp:ListItem><asp:ListItem>Northern Cape</asp:ListItem><asp:ListItem>Western Cape</asp:ListItem></asp:DropDownList></div>
                <div class="col-md-4"><label class="form-label fw-bold">Postal Code</label><asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control" /></div>
                <div class="col-md-4"><label class="form-label fw-bold">Delivery Date</label><asp:TextBox ID="txtDeliveryDate" runat="server" TextMode="Date" CssClass="form-control" /></div>
                <div class="col-md-4"><label class="form-label fw-bold">Delivery Time</label><asp:TextBox ID="txtDeliveryTime" runat="server" TextMode="Time" CssClass="form-control" /></div>
                <div class="col-md-4"><label class="form-label fw-bold">Collection Date</label><asp:TextBox ID="txtCompanyCollectionDate" runat="server" TextMode="Date" CssClass="form-control" /></div>
                <div class="col-md-4"><label class="form-label fw-bold">Collection Time</label><asp:TextBox ID="txtCompanyCollectionTime" runat="server" TextMode="Time" CssClass="form-control" /></div>
                <div class="col-12"><label class="form-label fw-bold">Delivery / Collection Instructions <span class="text-muted fw-normal">(optional)</span></label><asp:TextBox ID="txtTransportInstructions" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" /></div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlCustomerTransport" runat="server" Visible="false">
            <div class="info mb-3"><strong>Forte Event Hire Collection / Return Point</strong><br/><asp:Label ID="lblCompanyAddress" runat="server" Text="Add Forte Event Hire's actual collection address here."/><br/>Telephone: 010 123 4567<br/>Email: info@forteventhire.co.za</div>
            <div class="row g-3">
                <div class="col-md-3"><label class="form-label fw-bold">Collection Date</label><asp:TextBox ID="txtCustomerCollectionDate" runat="server" TextMode="Date" CssClass="form-control" /></div>
                <div class="col-md-3"><label class="form-label fw-bold">Collection Time</label><asp:TextBox ID="txtCustomerCollectionTime" runat="server" TextMode="Time" CssClass="form-control" /></div>
                <div class="col-md-3"><label class="form-label fw-bold">Return Date</label><asp:TextBox ID="txtReturnDate" runat="server" TextMode="Date" CssClass="form-control" /></div>
                <div class="col-md-3"><label class="form-label fw-bold">Return Time</label><asp:TextBox ID="txtReturnTime" runat="server" TextMode="Time" CssClass="form-control" /></div>
            </div>
        </asp:Panel>

        <div class="alert alert-warning mt-4 mb-0"><strong>Late / No-Show Policy:</strong> A R150 fee may be applied if the customer is late or does not arrive for the agreed delivery, collection or return time. This fee is not charged during the original booking.</div>
    </section>

    <section class="cardx">
        <h3 class="title">3. Setup</h3>
        <p>Would you like Forte Event Hire to set up the hired items?</p>
        <asp:RadioButton ID="rbSetupYes" runat="server" GroupName="Setup" Text=" Yes" AutoPostBack="true" OnCheckedChanged="ExtrasChanged" />
        <asp:RadioButton ID="rbSetupNo" runat="server" GroupName="Setup" Text=" No" AutoPostBack="true" OnCheckedChanged="ExtrasChanged" CssClass="ms-4" />
        <div class="muted mt-2">If Yes, the setup fee is 3% of the item total.</div>
    </section>

    <section class="cardx">
        <h3 class="title">4. Service Providers</h3>
        <p>Each provider costs <strong>R100 per person/provider selected</strong>. Choose the provider and enter how many you need.</p>
        <div class="provider"><asp:CheckBox ID="chkDJ" runat="server" Text=" DJ" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtDJQty" runat="server" Text="1" TextMode="Number" CssClass="form-control" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span>R100 each</span></div>
        <div class="provider"><asp:CheckBox ID="chkCaterer" runat="server" Text=" Caterer" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtCatererQty" runat="server" Text="1" TextMode="Number" CssClass="form-control" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span>R100 each</span></div>
        <div class="provider"><asp:CheckBox ID="chkBartender" runat="server" Text=" Bartender" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtBartenderQty" runat="server" Text="1" TextMode="Number" CssClass="form-control" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span>R100 each</span></div>
        <div class="provider"><asp:CheckBox ID="chkWaiter" runat="server" Text=" Waiter" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtWaiterQty" runat="server" Text="1" TextMode="Number" CssClass="form-control" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span>R100 each</span></div>
        <div class="provider"><asp:CheckBox ID="chkClown" runat="server" Text=" Clown" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtClownQty" runat="server" Text="1" TextMode="Number" CssClass="form-control" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span>R100 each</span></div>
        <div class="provider"><asp:CheckBox ID="chkPhotographer" runat="server" Text=" Photographer" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtPhotographerQty" runat="server" Text="1" TextMode="Number" CssClass="form-control" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span>R100 each</span></div>
    </section>

    <section class="cardx">
        <h3 class="title">Price Summary</h3>
        <div class="fee"><span>Item Total</span><asp:Label ID="lblItemTotal" runat="server" /></div>
        <div class="fee"><span>Delivery & Collection Fee (7%)</span><asp:Label ID="lblDeliveryFee" runat="server" /></div>
        <div class="fee"><span>Setup Fee (3%)</span><asp:Label ID="lblSetupFee" runat="server" /></div>
        <div class="fee"><span>Service Providers</span><asp:Label ID="lblProviderFee" runat="server" /></div>
        <div class="fee"><span>Late / No-Show Fee</span><span>R0.00 at booking</span></div>
        <div class="fee grand"><span>Total Due</span><asp:Label ID="lblGrandTotal" runat="server" /></div>
    </section>

    <div class="d-flex justify-content-between flex-wrap gap-3">
        <asp:Button ID="btnBack" runat="server" Text="← Back To Checkout" CssClass="btn-back" CausesValidation="false" OnClick="btnBack_Click" />
        <asp:Button ID="btnContinueToPayment" runat="server" Text="Continue To Payment →" CssClass="btn-main" OnClick="btnContinueToPayment_Click" />
    </div>
</main>
</form>
</body>
</html>
