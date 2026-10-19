<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Catalogue.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.Catalogue" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Catalogue - Forte Event Hire</title>

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0" />


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
                "Segoe UI",
                Arial,
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


        /* HEADER */

        .top-bar {
            width: 92%;
            max-width: 1400px;

            margin: auto;

            padding: 25px 0;

            display: flex;
            justify-content: space-between;
            align-items: center;

            flex-wrap: wrap;

            gap: 20px;
        }


        .brand {
            color: white;

            font-size: 27px;

            font-weight: 800;
        }


        .cart-button {
            border: none;

            background: white;

            color: #16324F;

            padding: 12px 22px;

            border-radius: 40px;

            font-weight: 800;
        }


        /* HERO */

        .hero {
            text-align: center;

            color: white;

            padding: 30px 20px 40px;
        }


        .hero h1 {
            font-size: 50px;

            font-weight: 800;
        }


        .hero p {
            font-size: 18px;

            opacity: .9;
        }


        /* CATEGORIES */

        .category-area {
            width: 92%;

            margin: 0 auto 35px;
        }


        .category-buttons {
            display: flex;

            justify-content: center;

            gap: 12px;

            flex-wrap: wrap;
        }


        .category-button {
            border: none;

            background: white;

            color: #16324F;

            padding: 11px 20px;

            border-radius: 25px;

            font-weight: 700;
        }


        .category-button:hover {
            background: #16324F;

            color: white;
        }


        /* MESSAGE */

        .message {
            display: block;

            width: 92%;
            max-width: 800px;

            margin: 0 auto 25px;

            padding: 14px;

            border-radius: 8px;

            background: white;

            color: #16324F;

            text-align: center;

            font-weight: 700;
        }


        /* PRODUCT CONTAINER */

        .products-container {
            width: 92%;

            max-width: 1400px;

            margin: auto;

            padding-bottom: 70px;
        }


        .product-card {
            background: white;

            border-radius: 20px;

            overflow: hidden;

            height: 100%;

            display: flex;

            flex-direction: column;

            box-shadow:
                0 12px 30px
                rgba(0,0,0,.18);
        }


        .product-image {
            width: 100%;

            height: 270px;

            object-fit: contain;

            padding: 15px;

            background: #f8f9fa;
        }


        .product-body {
            padding: 24px;

            display: flex;

            flex-direction: column;

            flex: 1;
        }


        .product-category {
            color: #2D89EF;

            font-size: 13px;

            font-weight: 800;

            text-transform: uppercase;
        }


        .product-body h3 {
            color: #16324F;

            font-size: 22px;

            font-weight: 800;

            margin-top: 6px;
        }


        .description {
            color: #68717a;

            margin: 10px 0;

            flex: 1;
        }


        .colour {
            color: #555;

            margin-bottom: 8px;
        }


        .stock {
            color: #24843e;

            font-size: 14px;

            font-weight: 700;

            margin-bottom: 8px;
        }


        .price {
            color: #2D89EF;

            font-size: 22px;

            font-weight: 800;

            margin-bottom: 15px;
        }


        .field-label {
            display: block;

            color: #16324F;

            font-weight: 700;

            margin-bottom: 6px;
        }


        .quantity-input {
            width: 100%;

            padding: 10px;

            border:
                1px solid #ddd;

            border-radius: 8px;

            text-align: center;
        }


        .add-button {
            width: 100%;

            margin-top: 15px;

            padding: 13px;

            border: none;

            border-radius: 9px;

            background: #2D89EF;

            color: white;

            font-weight: 800;
        }


        .add-button:hover {
            background: #16324F;
        }


        .empty-products {
            background: white;

            padding: 40px;

            border-radius: 15px;

            text-align: center;

            color: #68717a;
        }


        @media(max-width:768px) {

            .hero h1 {
                font-size: 38px;
            }

        }

    </style>

</head>


<body>

<form id="form1" runat="server">


    <!-- HEADER -->

    <div class="top-bar">


        <div class="brand">

            Forte Event Hire

        </div>


        <asp:Button
            ID="btnViewCart"
            runat="server"
            CssClass="cart-button"
            CausesValidation="false"
            OnClick="btnViewCart_Click" />


    </div>



    <!-- HERO -->

    <section class="hero">

        <h1>
            Our Catalogue
        </h1>

        <p>
            Browse equipment and packages
            available for hire.
        </p>

    </section>



    <!-- FILTER BUTTONS -->

    <div class="category-area">

        <div class="category-buttons">


            <asp:Button
                ID="btnAll"
                runat="server"
                Text="All Products"
                CssClass="category-button"
                CausesValidation="false"
                OnClick="btnAll_Click" />


            <asp:Button
                ID="btnChairs"
                runat="server"
                Text="Chairs"
                CssClass="category-button"
                CausesValidation="false"
                OnClick="btnChairs_Click" />


            <asp:Button
                ID="btnTables"
                runat="server"
                Text="Tables"
                CssClass="category-button"
                CausesValidation="false"
                OnClick="btnTables_Click" />


            <asp:Button
                ID="btnLighting"
                runat="server"
                Text="Lighting"
                CssClass="category-button"
                CausesValidation="false"
                OnClick="btnLighting_Click" />


            <asp:Button
                ID="btnPackages"
                runat="server"
                Text="Packages"
                CssClass="category-button"
                CausesValidation="false"
                OnClick="btnPackages_Click" />


        </div>

    </div>



    <!-- MESSAGE -->

    <asp:Label
        ID="lblMessage"
        runat="server"
        CssClass="message"
        Visible="false">
    </asp:Label>



    <!-- PRODUCTS -->

    <div class="products-container">

        <div class="row g-4">


            <asp:Repeater
                ID="rptProducts"
                runat="server"
                OnItemCommand="rptProducts_ItemCommand">


                <ItemTemplate>


                    <div class="col-xl-4 col-lg-4 col-md-6">


                        <div class="product-card">


                            <!-- PICTURE -->

                            <asp:Image
                                ID="imgProduct"
                                runat="server"
                                CssClass="product-image"
                                ImageUrl='<%# Eval("ImageUrl") %>'
                                AlternateText='<%# Eval("ProductName") %>' />



                            <div class="product-body">


                                <!-- CATEGORY -->

                                <span class="product-category">

                                    <%# Eval("Category") %>

                                </span>



                                <!-- PRODUCT NAME -->

                                <h3>

                                    <%# Eval("ProductName") %>

                                </h3>



                                <!-- DESCRIPTION -->

                                <p class="description">

                                    <%# Eval("Description") %>

                                </p>



                                <!-- COLOUR -->

                                <div class="colour">

                                    Colour / Style:

                                    <strong>

                                        <%# Eval("Colour") %>

                                    </strong>

                                </div>



                                <!-- AVAILABLE STOCK -->

                                <div class="stock">

                                    Available:
                                    <%# Eval("QuantityAvailable") %>

                                </div>



                                <!-- PRICE -->

                                <div class="price">

                                    R<%#
                                        Convert.ToDecimal(
                                            Eval("Price")
                                        ).ToString("N2")
                                    %>

                                </div>



                                <!-- QUANTITY -->

                                <label class="field-label">

                                    Quantity

                                </label>


                                <asp:TextBox
                                    ID="txtQuantity"
                                    runat="server"
                                    Text="1"
                                    TextMode="Number"
                                    CssClass="quantity-input">
                                </asp:TextBox>



                                <!-- ADD TO CART -->

                                <asp:Button
                                    ID="btnAddToCart"
                                    runat="server"
                                    Text="🛒 Add To Cart"
                                    CssClass="add-button"
                                    CausesValidation="false"
                                    CommandName="AddToCart"
                                    CommandArgument='<%# Eval("ProductID") %>' />


                            </div>


                        </div>


                    </div>


                </ItemTemplate>


            </asp:Repeater>


        </div>



        <asp:Panel
            ID="pnlNoProducts"
            runat="server"
            CssClass="empty-products"
            Visible="false">


            <h4>
                No products are currently available.
            </h4>


        </asp:Panel>


    </div>


</form>

</body>

</html>
