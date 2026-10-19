<%@ Page Title="Delivery and Extras" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="DeliveryandExtras.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.DeliveryandExtras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="delivery-extras-page">
        <header class="delivery-page-heading">
            <div>
                <h1>Delivery and Extras</h1>
                <p>Choose how the equipment will be transported and add any event services.</p>
            </div>
            <div class="checkout-progress" aria-label="Checkout progress">
                <span>Catalogue</span><span>Cart</span><span>Checkout</span><strong>Delivery and Extras</strong><span>Payment</span><span>Confirmation</span>
            </div>
        </header>

        <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-danger d-block delivery-message" />

        <section class="delivery-card">
            <div class="delivery-section-heading">
                <div><span class="delivery-step">Booking</span><h2>Checkout information</h2></div>
                <p>From the details you entered on the previous step.</p>
            </div>
            <div class="row g-3">
                <div class="col-md-4"><span class="delivery-summary-label">Event date</span><strong><asp:Label ID="lblEventDate" runat="server" /></strong></div>
                <div class="col-md-4"><span class="delivery-summary-label">Event type</span><strong><asp:Label ID="lblEventType" runat="server" /></strong></div>
                <div class="col-md-4"><span class="delivery-summary-label">Equipment subtotal</span><strong><asp:Label ID="lblItemTotalTop" runat="server" /></strong></div>
            </div>
        </section>

        <section class="delivery-card">
            <div class="delivery-section-heading">
                <div><span class="delivery-step">01</span><h2>Customer details</h2></div>
                <p>Confirm the contact person for this booking.</p>
            </div>
            <div class="row g-3">
                <div class="col-md-4"><asp:Label ID="lblFullName" runat="server" AssociatedControlID="txtFullName" CssClass="form-label" Text="Full name" /><asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" MaxLength="150" /></div>
                <div class="col-md-4"><asp:Label ID="lblEmailAddress" runat="server" AssociatedControlID="txtEmail" CssClass="form-label" Text="Email address" /><asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" MaxLength="254" /></div>
                <div class="col-md-4"><asp:Label ID="lblPhoneNumber" runat="server" AssociatedControlID="txtPhone" CssClass="form-label" Text="Phone number" /><asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" MaxLength="30" /></div>
            </div>
        </section>

        <section class="delivery-card">
            <div class="delivery-section-heading">
                <div><span class="delivery-step">02</span><h2>Delivery or collection</h2></div>
                <p>Choose who will transport the equipment.</p>
            </div>
            <div class="row g-3 mb-4">
                <div class="col-lg-6"><div class="transport-choice"><asp:RadioButton ID="rbCompanyTransport" runat="server" GroupName="Transport" Text="Forte Event Hire will deliver and collect" CssClass="delivery-choice-control" AutoPostBack="true" OnCheckedChanged="Transport_CheckedChanged" /><span>Delivery and collection fee is calculated as 7% of the equipment subtotal.</span></div></div>
                <div class="col-lg-6"><div class="transport-choice"><asp:RadioButton ID="rbCustomerTransport" runat="server" GroupName="Transport" Text="I will collect and return the equipment" CssClass="delivery-choice-control" AutoPostBack="true" OnCheckedChanged="Transport_CheckedChanged" /><span>No delivery fee applies.</span></div></div>
            </div>

            <asp:Panel ID="pnlCompanyTransport" runat="server" CssClass="transport-fields">
                <h3>Delivery and collection details</h3>
                <div class="row g-3">
                    <div class="col-md-8"><label class="form-label" for="txtDeliveryAddress">Delivery address</label><asp:TextBox ID="txtDeliveryAddress" runat="server" CssClass="form-control" MaxLength="250" /></div>
                    <div class="col-md-4"><label class="form-label" for="txtCity">City or town</label><asp:TextBox ID="txtCity" runat="server" CssClass="form-control" MaxLength="100" /></div>
                    <div class="col-md-4"><label class="form-label" for="ddlProvince">Province</label><asp:DropDownList ID="ddlProvince" runat="server" CssClass="form-select"><asp:ListItem Text="Select province" Value=""/><asp:ListItem>Eastern Cape</asp:ListItem><asp:ListItem>Free State</asp:ListItem><asp:ListItem>Gauteng</asp:ListItem><asp:ListItem>KwaZulu-Natal</asp:ListItem><asp:ListItem>Limpopo</asp:ListItem><asp:ListItem>Mpumalanga</asp:ListItem><asp:ListItem>North West</asp:ListItem><asp:ListItem>Northern Cape</asp:ListItem><asp:ListItem>Western Cape</asp:ListItem></asp:DropDownList></div>
                    <div class="col-md-4"><label class="form-label" for="txtPostalCode">Postal code</label><asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control" MaxLength="20" /></div>
                    <div class="col-md-4"><label class="form-label" for="txtDeliveryDate">Delivery date</label><asp:TextBox ID="txtDeliveryDate" runat="server" TextMode="Date" CssClass="form-control" /></div>
                    <div class="col-md-4"><label class="form-label" for="txtDeliveryTime">Delivery time</label><asp:TextBox ID="txtDeliveryTime" runat="server" TextMode="Time" CssClass="form-control" /></div>
                    <div class="col-md-4"><label class="form-label" for="txtCompanyCollectionDate">Collection date</label><asp:TextBox ID="txtCompanyCollectionDate" runat="server" TextMode="Date" CssClass="form-control" /></div>
                    <div class="col-md-4"><label class="form-label" for="txtCompanyCollectionTime">Collection time</label><asp:TextBox ID="txtCompanyCollectionTime" runat="server" TextMode="Time" CssClass="form-control" /></div>
                    <div class="col-12"><label class="form-label" for="txtTransportInstructions">Delivery or collection instructions <span class="optional-label">Optional</span></label><asp:TextBox ID="txtTransportInstructions" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" MaxLength="1000" /></div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlCustomerTransport" runat="server" Visible="false" CssClass="transport-fields">
                <div class="collection-point-note"><strong>Forte Event Hire collection point</strong><p><asp:Label ID="lblCompanyAddress" runat="server" Text="Contact Forte Event Hire to confirm the collection address." /></p></div>
                <div class="row g-3">
                    <div class="col-md-3"><label class="form-label" for="txtCustomerCollectionDate">Collection date</label><asp:TextBox ID="txtCustomerCollectionDate" runat="server" TextMode="Date" CssClass="form-control" /></div>
                    <div class="col-md-3"><label class="form-label" for="txtCustomerCollectionTime">Collection time</label><asp:TextBox ID="txtCustomerCollectionTime" runat="server" TextMode="Time" CssClass="form-control" /></div>
                    <div class="col-md-3"><label class="form-label" for="txtReturnDate">Return date</label><asp:TextBox ID="txtReturnDate" runat="server" TextMode="Date" CssClass="form-control" /></div>
                    <div class="col-md-3"><label class="form-label" for="txtReturnTime">Return time</label><asp:TextBox ID="txtReturnTime" runat="server" TextMode="Time" CssClass="form-control" /></div>
                </div>
            </asp:Panel>

            <div class="delivery-policy"><strong>Late or missed appointment:</strong> A R150 fee may be applied if the customer is late or does not arrive at the agreed time. It is not charged during the original booking.</div>
        </section>

        <section class="delivery-card">
            <div class="delivery-section-heading">
                <div><span class="delivery-step">03</span><h2>Setup</h2></div>
                <p>Choose whether Forte Event Hire should set up the hired equipment.</p>
            </div>
            <div class="setup-options">
                <asp:RadioButton ID="rbSetupYes" runat="server" GroupName="Setup" Text="Yes, setup is required" CssClass="delivery-choice-control" AutoPostBack="true" OnCheckedChanged="ExtrasChanged" />
                <asp:RadioButton ID="rbSetupNo" runat="server" GroupName="Setup" Text="No setup required" CssClass="delivery-choice-control" AutoPostBack="true" OnCheckedChanged="ExtrasChanged" />
            </div>
            <p class="delivery-help">Setup is charged at 3% of the equipment subtotal.</p>
        </section>

        <section class="delivery-card">
            <div class="delivery-section-heading">
                <div><span class="delivery-step">04</span><h2>Service providers</h2></div>
                <p>Choose any event services. Minimum booking hours are shown with each rate.</p>
            </div>
            <div class="provider-grid-heading"><span>Service</span><span>Quantity</span><span>Hours</span><span>Rate</span></div>
            <div class="provider-row"><asp:CheckBox ID="chkDJ" runat="server" Text="DJ" CssClass="provider-check" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtDJQty" runat="server" Text="1" TextMode="Number" CssClass="form-control provider-number" min="1" max="20" aria-label="Number of DJs" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><asp:TextBox ID="txtDJHours" runat="server" Text="4" TextMode="Number" CssClass="form-control provider-number" min="4" max="24" aria-label="DJ booking hours" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span class="provider-rate"><asp:Label ID="lblDJRate" runat="server" /> per person / hour<br /><small>Minimum <asp:Label ID="lblDJMinimumHours" runat="server" /> hours</small></span></div>
            <div class="provider-row"><asp:CheckBox ID="chkCaterer" runat="server" Text="Caterer" CssClass="provider-check" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtCatererQty" runat="server" Text="1" TextMode="Number" CssClass="form-control provider-number" min="1" max="20" aria-label="Number of caterers" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><asp:TextBox ID="txtCatererHours" runat="server" Text="7" TextMode="Number" CssClass="form-control provider-number" min="7" max="24" aria-label="Caterer booking hours" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span class="provider-rate"><asp:Label ID="lblCatererRate" runat="server" /> per person / hour<br /><small>Minimum <asp:Label ID="lblCatererMinimumHours" runat="server" /> hours</small></span></div>
            <div class="provider-row"><asp:CheckBox ID="chkBartender" runat="server" Text="Bartender" CssClass="provider-check" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtBartenderQty" runat="server" Text="1" TextMode="Number" CssClass="form-control provider-number" min="1" max="20" aria-label="Number of bartenders" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><asp:TextBox ID="txtBartenderHours" runat="server" Text="7" TextMode="Number" CssClass="form-control provider-number" min="7" max="24" aria-label="Bartender booking hours" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span class="provider-rate"><asp:Label ID="lblBartenderRate" runat="server" /> per person / hour<br /><small>Minimum <asp:Label ID="lblBartenderMinimumHours" runat="server" /> hours</small></span></div>
            <div class="provider-row"><asp:CheckBox ID="chkWaiter" runat="server" Text="Waiter" CssClass="provider-check" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtWaiterQty" runat="server" Text="1" TextMode="Number" CssClass="form-control provider-number" min="1" max="20" aria-label="Number of waiters" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><asp:TextBox ID="txtWaiterHours" runat="server" Text="7" TextMode="Number" CssClass="form-control provider-number" min="7" max="24" aria-label="Waiter booking hours" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span class="provider-rate"><asp:Label ID="lblWaiterRate" runat="server" /> per person / hour<br /><small>Minimum <asp:Label ID="lblWaiterMinimumHours" runat="server" /> hours</small></span></div>
            <div class="provider-row"><asp:CheckBox ID="chkClown" runat="server" Text="Children’s entertainer" CssClass="provider-check" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtClownQty" runat="server" Text="1" TextMode="Number" CssClass="form-control provider-number" min="1" max="20" aria-label="Number of entertainers" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><asp:TextBox ID="txtClownHours" runat="server" Text="2" TextMode="Number" CssClass="form-control provider-number" min="2" max="12" aria-label="Entertainer booking hours" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span class="provider-rate"><asp:Label ID="lblClownRate" runat="server" /> per person / hour<br /><small>Minimum <asp:Label ID="lblClownMinimumHours" runat="server" /> hours</small></span></div>
            <div class="provider-row"><asp:CheckBox ID="chkPhotographer" runat="server" Text="Photographer" CssClass="provider-check" AutoPostBack="true" OnCheckedChanged="ExtrasChanged"/><asp:TextBox ID="txtPhotographerQty" runat="server" Text="1" TextMode="Number" CssClass="form-control provider-number" min="1" max="20" aria-label="Number of photographers" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><asp:TextBox ID="txtPhotographerHours" runat="server" Text="2" TextMode="Number" CssClass="form-control provider-number" min="2" max="12" aria-label="Photographer booking hours" AutoPostBack="true" OnTextChanged="ProviderQtyChanged"/><span class="provider-rate"><asp:Label ID="lblPhotographerRate" runat="server" /> per person / hour<br /><small>Minimum <asp:Label ID="lblPhotographerMinimumHours" runat="server" /> hours</small></span></div>
            <p class="delivery-help mt-3">Indicative South African market rates for planning. Confirm final provider quotes before accepting a booking.</p>
        </section>

        <section class="delivery-card price-summary-card">
            <div class="delivery-section-heading"><div><span class="delivery-step">Summary</span><h2>Price summary</h2></div><p>Late or missed appointment fees are not included in today’s total.</p></div>
            <div class="fee-row"><span>Equipment subtotal</span><asp:Label ID="lblItemTotal" runat="server" /></div>
            <div class="fee-row"><span>Delivery and collection (7%)</span><asp:Label ID="lblDeliveryFee" runat="server" /></div>
            <div class="fee-row"><span>Setup (3%)</span><asp:Label ID="lblSetupFee" runat="server" /></div>
            <div class="fee-row"><span>Service providers</span><asp:Label ID="lblProviderFee" runat="server" /></div>
            <div class="fee-row"><span>Late or missed appointment fee</span><span>R0.00 at booking</span></div>
            <div class="fee-row fee-total"><span>Total due</span><asp:Label ID="lblGrandTotal" runat="server" /></div>
        </section>

        <div class="delivery-actions">
            <asp:Button ID="btnBack" runat="server" Text="Back to checkout" CssClass="btn btn-outline-secondary" CausesValidation="false" OnClick="btnBack_Click" />
            <asp:Button ID="btnContinueToPayment" runat="server" Text="Continue to payment" CssClass="btn btn-forte" OnClick="btnContinueToPayment_Click" />
        </div>
    </div>
</asp:Content>
