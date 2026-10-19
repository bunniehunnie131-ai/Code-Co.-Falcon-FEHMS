<%@ Page Title="Your Cart - Forte Events"
    Language="C#"
    MasterPageFile="~/Presentation/SystemLayout.Master"
    AutoEventWireup="true"
    CodeBehind="Cart.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        /* =========================================
           FEHMS - FORTE EVENTS CART PAGE
           ========================================= */

        .fehms-cart {
            --forte-navy: #071827;
            --forte-dark: #0b1c2c;
            --forte-blue: #2457d6;
            --forte-blue-light: #3b6ff0;
            --forte-bg: #f5f7fb;
            --forte-border: #e2e8f0;
            --forte-text: #334155;
            --forte-muted: #64748b;
            --forte-white: #ffffff;

            min-height: 100vh;
            padding: 30px 0 50px;
            background: var(--forte-bg);
            color: var(--forte-text);
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
        }

        .fehms-cart,
        .fehms-cart * {
            box-sizing: border-box;
        }

        .fehms-cart .cart-container {
            width: 100%;
            max-width: 1320px;
            margin: 0 auto;
            padding: 0 24px;
        }

        /* Page heading */

        .fehms-cart .cart-hero {
            position: relative;
            overflow: hidden;
            padding: 38px 40px;
            margin-bottom: 28px;
            border-radius: 18px;
            background: linear-gradient(
                120deg,
                var(--forte-navy),
                #102d4c 65%,
                var(--forte-blue)
            );
            box-shadow: 0 10px 25px rgba(7, 24, 39, 0.10);
        }

        .fehms-cart .cart-hero::after {
            content: "";
            position: absolute;
            top: -100px;
            right: -50px;
            width: 250px;
            height: 250px;
            border: 35px solid rgba(255, 255, 255, 0.06);
            border-radius: 50%;
            pointer-events: none;
        }

        .fehms-cart .cart-eyebrow {
            display: inline-block;
            margin-bottom: 12px;
            padding: 7px 13px;
            border: 1px solid rgba(255, 255, 255, 0.17);
            border-radius: 30px;
            background: rgba(255, 255, 255, 0.10);
            color: #c9d9ff;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .fehms-cart .cart-hero h1 {
            margin: 0 0 12px;
            color: #ffffff;
            font-family: 'Space Grotesk', 'Inter', Arial, sans-serif;
            font-size: clamp(30px, 4vw, 42px);
            font-weight: 800;
            letter-spacing: -1px;
        }

        .fehms-cart .cart-hero p {
            max-width: 650px;
            margin: 0;
            color: #dbe6f5;
            font-size: 14px;
            line-height: 1.9;
        }

        .fehms-cart .cart-hero-actions {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            flex-wrap: wrap;
        }

        .fehms-cart .continue-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 9px;
            min-height: 43px;
            padding: 11px 17px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 9px;
            background: #ffffff;
            color: var(--forte-navy);
            font-family: inherit;
            font-size: 12px;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .fehms-cart .continue-button:hover {
            background: #eaf0ff;
            color: var(--forte-blue);
            transform: translateY(-1px);
        }

        /* Main grid */

        .fehms-cart .cart-layout {
            display: grid;
            grid-template-columns: minmax(0, 1.8fr) minmax(290px, 0.9fr);
            align-items: start;
            gap: 24px;
        }

        .fehms-cart .cart-card,
        .fehms-cart .summary-card {
            min-width: 0;
            padding: 27px;
            border: 1px solid var(--forte-border);
            border-radius: 16px;
            background: #ffffff;
            box-shadow: 0 5px 18px rgba(15, 23, 42, 0.035);
        }

        .fehms-cart .section-heading {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 0 0 24px;
            color: var(--forte-navy);
            font-family: 'Space Grotesk', 'Inter', Arial, sans-serif;
            font-size: 21px;
            font-weight: 800;
        }

        .fehms-cart .section-heading-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 42px;
            height: 42px;
            flex-shrink: 0;
            border-radius: 11px;
            background: #edf3ff;
            color: var(--forte-blue);
            font-size: 17px;
        }

        /* Empty cart */

        .fehms-cart .empty-cart {
            padding: 45px 20px;
            border: 1px dashed #cbd5e1;
            border-radius: 13px;
            background: #f9fbff;
            text-align: center;
        }

        .fehms-cart .empty-cart-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 76px;
            height: 76px;
            margin: 0 auto 18px;
            border-radius: 50%;
            background: #edf3ff;
            color: var(--forte-blue);
            font-size: 32px;
        }

        .fehms-cart .empty-cart h3 {
            margin: 0 0 10px;
            color: var(--forte-navy);
            font-size: 20px;
            font-weight: 800;
        }

        .fehms-cart .empty-cart p {
            margin: 0;
            color: var(--forte-muted);
            font-size: 13px;
            line-height: 1.8;
        }

        .fehms-cart .browse-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 43px;
            margin-top: 20px;
            padding: 11px 18px;
            border: 0;
            border-radius: 9px;
            background: var(--forte-blue);
            color: #ffffff;
            font-family: inherit;
            font-size: 12px;
            font-weight: 800;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .fehms-cart .browse-button:hover {
            background: var(--forte-navy);
        }

        /* Product item */

        .fehms-cart .cart-item {
            display: grid;
            grid-template-columns: 112px minmax(0, 1fr) auto;
            align-items: center;
            gap: 20px;
            padding: 22px 0;
            border-bottom: 1px solid #edf1f6;
        }

        .fehms-cart .cart-item:first-child {
            padding-top: 0;
        }

        .fehms-cart .cart-item:last-child {
            padding-bottom: 0;
            border-bottom: none;
        }

        .fehms-cart .cart-image {
            display: block;
            width: 112px;
            height: 112px;
            padding: 8px;
            border: 1px solid #edf1f6;
            border-radius: 12px;
            background: #f8fafc;
            object-fit: contain;
        }

        .fehms-cart .cart-info {
            min-width: 0;
        }

        .fehms-cart .cart-info h4 {
            margin: 0 0 10px;
            color: var(--forte-navy);
            font-size: 16px;
            font-weight: 800;
            line-height: 1.5;
            overflow-wrap: anywhere;
        }

        .fehms-cart .cart-info p {
            margin: 5px 0;
            color: var(--forte-muted);
            font-size: 12px;
            line-height: 1.7;
            overflow-wrap: anywhere;
        }

        .fehms-cart .cart-info p strong {
            color: var(--forte-text);
        }

        .fehms-cart .unit-price {
            color: var(--forte-blue) !important;
            font-weight: 800;
        }

        .fehms-cart .item-total {
            min-width: 95px;
            color: var(--forte-blue);
            font-size: 17px;
            font-weight: 800;
            text-align: right;
            overflow-wrap: anywhere;
        }

        /* Quantity controls */

        .fehms-cart .quantity-controls {
            display: flex;
            align-items: center;
            gap: 9px;
            margin-top: 13px;
        }

        .fehms-cart .quantity-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 33px;
            height: 33px;
            padding: 0;
            border: 1px solid #dce5f5;
            border-radius: 8px;
            background: #edf3ff;
            color: var(--forte-blue);
            font-family: inherit;
            font-size: 20px;
            font-weight: 800;
            line-height: 1;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .fehms-cart .quantity-button:hover {
            border-color: var(--forte-blue);
            background: var(--forte-blue);
            color: #ffffff;
        }

        .fehms-cart .quantity-value {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 30px;
            color: var(--forte-navy);
            font-size: 14px;
            font-weight: 800;
            text-align: center;
        }

        /* Remove item */

        .fehms-cart .remove-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            min-height: 32px;
            margin-top: 10px;
            padding: 7px 10px;
            border: 1px solid #fecaca;
            border-radius: 8px;
            background: #fff5f5;
            color: #b42318;
            font-family: inherit;
            font-size: 11px;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .fehms-cart .remove-button:hover {
            border-color: #ef4444;
            background: #fee2e2;
        }

        /* Order summary */

        .fehms-cart .summary-card {
            position: sticky;
            top: 25px;
        }

        .fehms-cart .summary-card .section-heading {
            margin-bottom: 20px;
        }

        .fehms-cart .summary-description {
            margin: 0 0 22px;
            color: var(--forte-muted);
            font-size: 12px;
            line-height: 1.8;
        }

        .fehms-cart .summary-divider {
            height: 1px;
            margin: 18px 0;
            border: 0;
            background: var(--forte-border);
        }

        .fehms-cart .summary-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 14px;
            margin: 18px 0;
            color: var(--forte-muted);
            font-size: 13px;
        }

        .fehms-cart .summary-value {
            color: var(--forte-navy);
            font-weight: 800;
            text-align: right;
        }

        .fehms-cart .summary-total {
            align-items: flex-start;
            padding-top: 20px;
            margin-top: 22px;
            border-top: 1px solid var(--forte-border);
            color: var(--forte-navy);
            font-size: 14px;
            font-weight: 800;
        }

        .fehms-cart .total-price {
            color: var(--forte-blue);
            font-size: 21px;
            font-weight: 800;
            text-align: right;
            overflow-wrap: anywhere;
        }

        .fehms-cart .checkout-button {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            min-height: 48px;
            margin-top: 24px;
            padding: 13px 16px;
            border: 0;
            border-radius: 10px;
            background: linear-gradient(
                100deg,
                var(--forte-blue),
                var(--forte-blue-light)
            );
            color: #ffffff;
            font-family: inherit;
            font-size: 13px;
            font-weight: 800;
            cursor: pointer;
            box-shadow: 0 5px 12px rgba(36, 87, 214, 0.15);
            transition: all 0.2s ease;
        }

        .fehms-cart .checkout-button:hover {
            background: var(--forte-navy);
            box-shadow: 0 7px 16px rgba(7, 24, 39, 0.14);
            transform: translateY(-1px);
        }

        .fehms-cart .checkout-button:disabled {
            background: #a8b3bf;
            box-shadow: none;
            cursor: not-allowed;
            transform: none;
        }

        .fehms-cart .checkout-note {
            display: flex;
            align-items: flex-start;
            justify-content: center;
            gap: 7px;
            margin-top: 15px;
            color: #7b8798;
            font-size: 10px;
            line-height: 1.7;
            text-align: center;
        }

        .fehms-cart .checkout-note i {
            margin-top: 2px;
            color: #16a34a;
        }

        /* Tablet */

        @media (max-width: 1000px) {
            .fehms-cart .cart-layout {
                grid-template-columns: minmax(0, 1fr);
            }

            .fehms-cart .summary-card {
                position: static;
            }
        }

        /* Mobile */

        @media (max-width: 600px) {
            .fehms-cart {
                padding: 20px 0 35px;
            }

            .fehms-cart .cart-container {
                padding: 0 14px;
            }

            .fehms-cart .cart-hero {
                padding: 25px 21px;
                margin-bottom: 18px;
                border-radius: 15px;
            }

            .fehms-cart .cart-hero-actions {
                align-items: flex-start;
                flex-direction: column;
                gap: 18px;
            }

            .fehms-cart .cart-hero h1 {
                font-size: 32px;
            }

            .fehms-cart .cart-hero p {
                font-size: 13px;
            }

            .fehms-cart .cart-card,
            .fehms-cart .summary-card {
                padding: 20px 16px;
                border-radius: 14px;
            }

            .fehms-cart .section-heading {
                font-size: 19px;
            }

            .fehms-cart .cart-item {
                grid-template-columns: 78px minmax(0, 1fr);
                gap: 13px;
                padding: 20px 0;
            }

            .fehms-cart .cart-image {
                width: 78px;
                height: 88px;
            }

            .fehms-cart .cart-info h4 {
                font-size: 14px;
            }

            .fehms-cart .item-total {
                grid-column: 2;
                min-width: 0;
                text-align: left;
                font-size: 16px;
            }

            .fehms-cart .empty-cart {
                padding: 35px 15px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            .fehms-cart *,
            .fehms-cart *::before,
            .fehms-cart *::after {
                transition: none !important;
                animation: none !important;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="fehms-cart">
        <div class="cart-container">

            <!-- PAGE HEADER -->

            <section class="cart-hero">

                <div class="cart-hero-actions">

                    <div>
                        <div class="cart-eyebrow">Forte Events Hire &amp; Decor</div>

                        <h1>Your Cart</h1>

                        <p>
                            Review your selected hire items before proceeding
                            to checkout.
                        </p>
                    </div>

                    <asp:Button
                        ID="btnContinueShopping"
                        runat="server"
                        Text="&#8592; Continue Shopping"
                        CssClass="continue-button"
                        CausesValidation="false"
                        OnClick="btnContinueShopping_Click" />

                </div>

            </section>

            <!-- CART CONTENT -->

            <div class="cart-layout">

                <!-- SELECTED PRODUCTS -->

                <div class="cart-card">

                    <h2 class="section-heading">
                        <span class="section-heading-icon">
                            <i class="fas fa-shopping-cart"></i>
                        </span>
                        Selected Items
                    </h2>

                    <!-- EMPTY CART -->

                    <asp:Panel
                        ID="pnlEmptyCart"
                        runat="server"
                        CssClass="empty-cart">

                        <div class="empty-cart-icon">
                            <i class="fas fa-shopping-basket"></i>
                        </div>

                        <h3>Your cart is empty</h3>

                        <p>
                            You have not added any hire products yet.
                            Browse our catalogue to find items for your event.
                        </p>

                        <asp:Button
                            ID="btnBrowseProducts"
                            runat="server"
                            Text="Browse Products"
                            CssClass="browse-button"
                            CausesValidation="false"
                            OnClick="btnContinueShopping_Click" />

                    </asp:Panel>

                    <!-- CART PRODUCTS -->

                    <asp:Repeater
                        ID="rptCart"
                        runat="server"
                        OnItemCommand="rptCart_ItemCommand">

                        <ItemTemplate>

                            <div class="cart-item">

                                <!-- PRODUCT IMAGE -->

                                <asp:Image
                                    ID="imgProduct"
                                    runat="server"
                                    CssClass="cart-image"
                                    ImageUrl='<%# Eval("ImageUrl") %>'
                                    AlternateText='<%# Eval("Name") %>' />

                                <!-- PRODUCT INFORMATION -->

                                <div class="cart-info">

                                    <h4>
                                        <%# Eval("Name") %>
                                    </h4>

                                    <p>
                                        Colour / Style:
                                        <strong>
                                            <%# Eval("Colour") %>
                                        </strong>
                                    </p>

                                    <p class="unit-price">
                                        R<%# Convert.ToDecimal(Eval("UnitPrice")).ToString("N2") %>
                                        each
                                    </p>

                                    <!-- QUANTITY CONTROLS -->

                                    <div class="quantity-controls">

                                        <asp:Button
                                            ID="btnDecrease"
                                            runat="server"
                                            Text="−"
                                            CssClass="quantity-button"
                                            CausesValidation="false"
                                            CommandName="Decrease"
                                            CommandArgument='<%# Container.ItemIndex %>'
                                            ToolTip="Decrease quantity" />

                                        <span class="quantity-value">
                                            <%# Eval("Quantity") %>
                                        </span>

                                        <asp:Button
                                            ID="btnIncrease"
                                            runat="server"
                                            Text="+"
                                            CssClass="quantity-button"
                                            CausesValidation="false"
                                            CommandName="Increase"
                                            CommandArgument='<%# Container.ItemIndex %>'
                                            ToolTip="Increase quantity" />

                                    </div>

                                    <!-- REMOVE PRODUCT -->

                                    <asp:Button
                                        ID="btnRemove"
                                        runat="server"
                                        Text="Remove"
                                        CssClass="remove-button"
                                        CausesValidation="false"
                                        CommandName="Remove"
                                        CommandArgument='<%# Container.ItemIndex %>' />

                                </div>

                                <!-- ITEM SUBTOTAL -->

                                <div class="item-total">

                                    R<%# (Convert.ToDecimal(Eval("UnitPrice")) * Convert.ToInt32(Eval("Quantity"))).ToString("N2") %>

                                </div>

                            </div>

                        </ItemTemplate>

                    </asp:Repeater>

                </div>

                <!-- ORDER SUMMARY -->

                <div class="summary-card">

                    <h2 class="section-heading">
                        <span class="section-heading-icon">
                            <i class="fas fa-receipt"></i>
                        </span>
                        Order Summary
                    </h2>

                    <p class="summary-description">
                        Check the number of products and estimated cost
                        before continuing to checkout.
                    </p>

                    <hr class="summary-divider" />

                    <!-- PRODUCT COUNT -->

                    <div class="summary-row">

                        <span>Products</span>

                        <asp:Label
                            ID="lblProductCount"
                            runat="server"
                            CssClass="summary-value"
                            Text="0">
                        </asp:Label>

                    </div>

                    <!-- TOTAL QUANTITY -->

                    <div class="summary-row">

                        <span>Total Items</span>

                        <asp:Label
                            ID="lblTotalItems"
                            runat="server"
                            CssClass="summary-value"
                            Text="0">
                        </asp:Label>

                    </div>

                    <!-- ESTIMATED TOTAL -->

                    <div class="summary-row summary-total">

                        <span>Estimated Total</span>

                        <asp:Label
                            ID="lblTotalPrice"
                            runat="server"
                            CssClass="total-price"
                            Text="R0.00">
                        </asp:Label>

                    </div>

                    <!-- CHECKOUT -->

                    <asp:Button
                        ID="btnCheckout"
                        runat="server"
                        Text="Proceed To Checkout"
                        CssClass="checkout-button"
                        OnClick="btnCheckout_Click" />

                    <div class="checkout-note">
                        <i class="fas fa-lock"></i>
                        <span>
                            Please review your selected items before proceeding.
                        </span>
                    </div>

                </div>

            </div>

        </div>
    </div>

</asp:Content>
