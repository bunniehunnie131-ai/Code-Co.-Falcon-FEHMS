<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.Cart" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Your Cart - Forte Event Hire</title>

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0" />

    <!-- BOOTSTRAP CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet" />


    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;

            font-family:
                'Segoe UI',
                Arial,
                Helvetica,
                sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #16324F,
                    #1E4C74,
                    #2D89EF
                );

            min-height: 100vh;
        }


        /* ==========================================
           TOP BAR
        ========================================== */

        .top-bar {
            width: 92%;
            max-width: 1400px;

            margin: auto;

            padding: 28px 0;

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 20px;

            flex-wrap: wrap;
        }


        .brand {
            color: white;

            font-size: 26px;

            font-weight: 800;
        }


        .continue-button {
            border: none;

            background: white;

            color: #16324F;

            padding: 12px 22px;

            border-radius: 40px;

            font-size: 16px;

            font-weight: 700;

            cursor: pointer;

            box-shadow:
                0 7px 18px
                rgba(0,0,0,.16);
        }


        .continue-button:hover {
            background: #f2f5ff;

            color: #2D89EF;
        }


        /* ==========================================
           HEADING
        ========================================== */

        .hero {
            text-align: center;

            color: white;

            padding: 20px 20px 45px;
        }


        .hero h1 {
            font-size: 52px;

            font-weight: 800;

            margin-bottom: 10px;
        }


        .hero p {
            font-size: 19px;

            opacity: .9;
        }


        /* ==========================================
           CART PAGE
        ========================================== */

        .cart-container {
            width: 92%;

            max-width: 1400px;

            margin: 0 auto;

            padding-bottom: 80px;
        }


        .cart-card,
        .summary-card {
            background: white;

            border-radius: 20px;

            padding: 28px;

            box-shadow:
                0 12px 30px
                rgba(0,0,0,.18);
        }


        .cart-card h2,
        .summary-card h2 {
            color: #16324F;

            font-weight: 800;

            margin-bottom: 25px;
        }


        /* ==========================================
           CART ITEM
        ========================================== */

        .cart-item {
            display: flex;

            align-items: center;

            gap: 20px;

            padding: 20px 0;

            border-bottom:
                1px solid #ececec;
        }


        .cart-item:last-child {
            border-bottom: none;
        }


        .cart-image {
            width: 120px;

            height: 120px;

            object-fit: contain;

            border-radius: 12px;

            background: #f8f9fa;

            padding: 8px;
        }


        .cart-info {
            flex: 1;
        }


        .cart-info h4 {
            color: #16324F;

            font-size: 21px;

            font-weight: 800;

            margin-bottom: 8px;
        }


        .cart-info p {
            margin: 4px 0;

            color: #666;
        }


        .unit-price {
            color: #2D89EF;

            font-weight: 700;
        }


        /* ==========================================
           QUANTITY
        ========================================== */

        .quantity-controls {
            display: flex;

            align-items: center;

            gap: 9px;

            margin-top: 12px;
        }


        .quantity-button {
            width: 38px;

            height: 38px;

            border: none;

            border-radius: 9px;

            background: #2D89EF;

            color: white;

            font-size: 20px;

            font-weight: 800;

            cursor: pointer;
        }


        .quantity-button:hover {
            background: #16324F;
        }


        .quantity-value {
            min-width: 40px;

            text-align: center;

            font-size: 17px;

            font-weight: 800;

            color: #16324F;
        }


        /* ==========================================
           REMOVE
        ========================================== */

        .remove-button {
            margin-top: 12px;

            border: none;

            border-radius: 8px;

            background: #fff0f0;

            color: #a22727;

            padding: 8px 13px;

            font-weight: 700;

            cursor: pointer;
        }


        .remove-button:hover {
            background: #f5dada;
        }


        /* ==========================================
           SUBTOTAL
        ========================================== */

        .item-total {
            min-width: 120px;

            text-align: right;

            color: #2D89EF;

            font-size: 21px;

            font-weight: 800;
        }


        /* ==========================================
           EMPTY CART
        ========================================== */

        .empty-cart {
            text-align: center;

            padding: 55px 20px;

            color: #777;
        }


        .empty-cart-icon {
            font-size: 50px;

            margin-bottom: 10px;
        }


        .empty-cart h3 {
            color: #16324F;

            font-weight: 800;
        }


        /* ==========================================
           SUMMARY
        ========================================== */

        .summary-card {
            position: sticky;

            top: 25px;
        }


        .summary-row {
            display: flex;

            justify-content: space-between;

            align-items: center;

            margin: 18px 0;

            color: #555;

            font-size: 17px;
        }


        .summary-value {
            color: #16324F;

            font-weight: 800;
        }


        .summary-total {
            border-top:
                2px solid #eeeeee;

            padding-top: 20px;

            margin-top: 22px;

            font-size: 21px;

            font-weight: 800;

            color: #16324F;
        }


        .total-price {
            color: #2D89EF;

            font-size: 23px;

            font-weight: 800;
        }


        /* ==========================================
           CHECKOUT BUTTON
        ========================================== */

        .checkout-button {
            width: 100%;

            margin-top: 22px;

            border: none;

            border-radius: 11px;

            background: #2D89EF;

            color: white;

            padding: 15px;

            font-size: 17px;

            font-weight: 800;

            cursor: pointer;
        }


        .checkout-button:hover {
            background: #16324F;
        }


        .checkout-button:disabled {
            background: #a8b3bf;

            cursor: not-allowed;
        }


        /* ==========================================
           RESPONSIVE
        ========================================== */

        @media(max-width:768px) {

            .hero h1 {
                font-size: 38px;
            }


            .cart-item {
                flex-direction: column;

                align-items: flex-start;
            }


            .cart-image {
                width: 100%;

                height: 220px;
            }


            .item-total {
                text-align: left;
            }


            .summary-card {
                position: static;
            }

        }

    </style>

</head>


<body>

<form id="form1" runat="server">


    <!-- ==========================================
         TOP BAR
    =========================================== -->

    <div class="top-bar">


        <div class="brand">

            Forte Event Hire

        </div>


        <asp:Button
            ID="btnContinueShopping"
            runat="server"
            Text="← Continue Shopping"
            CssClass="continue-button"
            CausesValidation="false"
            OnClick="btnContinueShopping_Click" />


    </div>



    <!-- ==========================================
         HERO
    =========================================== -->

    <section class="hero">

        <h1>
            Your Cart
        </h1>

        <p>
            Review your selected hire items
            before proceeding to checkout.
        </p>

    </section>



    <!-- ==========================================
         CART CONTENT
    =========================================== -->

    <div class="cart-container">


        <div class="row g-4">


            <!-- ==================================
                 LEFT: CART PRODUCTS
            =================================== -->

            <div class="col-lg-8">


                <div class="cart-card">


                    <h2>
                        Selected Items
                    </h2>



                    <!-- EMPTY CART -->

                    <asp:Panel
                        ID="pnlEmptyCart"
                        runat="server"
                        CssClass="empty-cart">


                        <div class="empty-cart-icon">
                            🛒
                        </div>


                        <h3>
                            Your cart is empty
                        </h3>


                        <p>
                            You have not added any hire
                            products yet.
                        </p>


                        <asp:Button
                            ID="btnBrowseProducts"
                            runat="server"
                            Text="Browse Products"
                            CssClass="btn btn-primary mt-3"
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


                                <!-- IMAGE -->

                                <asp:Image
                                    ID="imgProduct"
                                    runat="server"
                                    CssClass="cart-image"
                                    ImageUrl='<%# Eval("ImageUrl") %>'
                                    AlternateText='<%# Eval("Name") %>' />



                                <!-- PRODUCT INFO -->

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

                                        R<%#
                                            Convert
                                            .ToDecimal(
                                                Eval("UnitPrice")
                                            )
                                            .ToString("N2")
                                        %>
                                        each

                                    </p>



                                    <!-- QUANTITY -->

                                    <div class="quantity-controls">


                                        <asp:Button
                                            ID="btnDecrease"
                                            runat="server"
                                            Text="−"
                                            CssClass="quantity-button"
                                            CausesValidation="false"
                                            CommandName="Decrease"
                                            CommandArgument='<%# Container.ItemIndex %>' />



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
                                            CommandArgument='<%# Container.ItemIndex %>' />


                                    </div>



                                    <!-- REMOVE -->

                                    <asp:Button
                                        ID="btnRemove"
                                        runat="server"
                                        Text="Remove"
                                        CssClass="remove-button"
                                        CausesValidation="false"
                                        CommandName="Remove"
                                        CommandArgument='<%# Container.ItemIndex %>' />


                                </div>



                                <!-- SUBTOTAL -->

                                <div class="item-total">

                                    R<%#
                                        (
                                            Convert.ToDecimal(
                                                Eval("UnitPrice")
                                            )
                                            *
                                            Convert.ToInt32(
                                                Eval("Quantity")
                                            )
                                        )
                                        .ToString("N2")
                                    %>

                                </div>


                            </div>


                        </ItemTemplate>


                    </asp:Repeater>


                </div>


            </div>



            <!-- ==================================
                 RIGHT: ORDER SUMMARY
            =================================== -->

            <div class="col-lg-4">


                <div class="summary-card">


                    <h2>
                        Order Summary
                    </h2>


                    <hr />



                    <!-- DIFFERENT PRODUCTS -->

                    <div class="summary-row">

                        <span>
                            Products
                        </span>


                        <asp:Label
                            ID="lblProductCount"
                            runat="server"
                            CssClass="summary-value"
                            Text="0">
                        </asp:Label>

                    </div>



                    <!-- TOTAL QUANTITY -->

                    <div class="summary-row">

                        <span>
                            Total Items
                        </span>


                        <asp:Label
                            ID="lblTotalItems"
                            runat="server"
                            CssClass="summary-value"
                            Text="0">
                        </asp:Label>

                    </div>



                    <!-- TOTAL PRICE -->

                    <div class="summary-row summary-total">

                        <span>
                            Estimated Total
                        </span>


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


                </div>


            </div>


        </div>


    </div>


</form>


</body>

</html>
