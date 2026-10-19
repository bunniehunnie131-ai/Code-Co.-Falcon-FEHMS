<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="HirePackages.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.HirePackages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>

        * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI',sans-serif;
    background: linear-gradient( 135deg, #16324F, #1E4C74, #2D89EF);
    min-height: 100vh;
}

.container {
    max-width: 1300px;
}

.cartContainer {
    width: 100%;
    padding: 30px 50px;
    display: flex;
    justify-content: flex-end;
}

#btnCart,
#btnProductsCart,
#btnCombosCart {
    border: none;
    background: white;
    padding: 15px 28px;
    border-radius: 50px;
    font-size: 22px;
    font-weight: bold;
    cursor: pointer;
    box-shadow: 0 10px 20px rgba(0,0,0,.18);
}

#cartCount {
    margin-left: 10px;
    background: #2D89EF;
    color: white;
    border-radius: 50%;
    padding: 4px 10px;
}

.cartButton {
    border: none;
    background: white;
    padding: 15px 28px;
    border-radius: 50px;
    font-size: 22px;
    font-weight: bold;
    cursor: pointer;
    box-shadow: 0 10px 20px rgba(0,0,0,.18);
}

    .cartButton:hover {
        background: #1c70d8;
    }

.hero {
    text-align: center;
    color: white;
    margin-top: 20px;
    margin-bottom: 60px;
}

    .hero h1 {
        font-size: 70px;
        font-weight: 800;
        margin-bottom: 15px;
    }

    .hero p {
        font-size: 28px;
        color: rgba(255,255,255,.9);
    }

.packageCard {
    background: white;
    border-radius: 25px;
    overflow: hidden;
    box-shadow: 0 15px 35px rgba(0,0,0,.20);
    transition: .3s;
}

    .packageCard:hover {
        transform: translateY(-8px);
    }

.packageImage {
    height: 270px;
    overflow: hidden;
}

    .packageImage img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

.packageBody {
    padding: 30px;
}

    .packageBody h2 {
        font-size: 40px;
        font-weight: bold;
        color: #16324F;
        margin-bottom: 15px;
    }

    .packageBody p {
        font-size: 20px;
        color: #555;
        margin-bottom: 30px;
    }

.mainButton {
    width: 100%;
    border: none;
    border-radius: 12px;
    padding: 16px;
    background: #2D89EF;
    color: white;
    font-size: 20px;
    font-weight: bold;
    cursor: pointer;
    transition: .3s;
}

    .mainButton:hover {
        background: #1E4C74;
    }

.productsTopBar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 30px 50px;
}

.backButton {
    border: none;
    background: white;
    color: #16324F;
    padding: 12px 24px;
    border-radius: 40px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    box-shadow: 0 8px 18px rgba(0,0,0,.18);
}

    .backButton:hover {
        background: #f5f5f5;
    }

#btnProductsCart {
    border: none;
    background: white;
    padding: 15px 28px;
    border-radius: 50px;
    font-size: 22px;
    font-weight: bold;
    cursor: pointer;
    box-shadow: 0 10px 20px rgba(0,0,0,.18);
}

#productsCartCount {
    margin-left: 10px;
    background: #2D89EF;
    color: white;
    border-radius: 50%;
    padding: 4px 10px;
}

#productsSection {
    padding-top: 40px;
}

.categoryTabs {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;
    margin-bottom: 50px;
}

.categoryButton {
    border: none;
    background: white;
    color: #16324F;
    padding: 14px 26px;
    border-radius: 35px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: .3s;
    box-shadow: 0 8px 18px rgba(0,0,0,.15);
}

    .categoryButton:hover {
        background: #2D89EF;
        color: white;
    }

.activeCategory {
    background: #2D89EF;
    color: white;
}

#productsGrid {
    margin-bottom: 60px;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
}

.productCard {
    background: white;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 10px 25px rgba(0,0,0,.18);
    height: 100%;
    display: flex;
    flex-direction: column;
}

.productImage {
    width: 100%;
    height: 280px;
    object-fit: cover;
    object-position: center;
    display: block;
}

.productBody {
    padding: 25px;
    flex: 1;
    display: flex;
    flex-direction: column;
}
    .productBody h3 {
        color: #16324F;
        font-weight: bold;
    }

    .productBody p {
        color: #666;
        margin: 15px 0;
    }

    .productBody h4 {
        color: #2D89EF;
        font-weight: bold;
    }

.colourOptions {
    display: flex;
    gap: 12px;
    margin: 20px 0;
}

.colour {
    width: 22px;
    height: 22px;
    border-radius: 50%;
    cursor: pointer;
    border: 2px solid #ddd;
    display: inline-block;
}

.black {
    background: #000;
}

.white {
    background: #fff;
}

.silver {
    background: #c0c0c0;
}

.gold {
    background: #FFD700;
}

.pink {
    background: #ffb6c1;
}

.blue {
    background: #4169E1;
}

.colour.white {
    background: #ffffff;
    border: 2px solid #cfcfcf;
}

.colour.black {
    background: #000000;
}

.colour.red {
    background: #e53935;
}

.colour.blue {
    background: #2d89ef;
}

.colour.green {
    background: #2e7d32;
}

.colour.yellow {
    background: #fbc02d;
}

.colour.clear {
    background: rgba(255,255,255,0.35);
    border: 2px solid #9e9e9e;
}

.colour.champagne {
    background: #F7E7CE;
}

.quantityBox {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 14px;
    margin: 20px 0;
}

    .quantityBox button {
        width: 42px;
        height: 42px;
        border: none;
        border-radius: 10px;
        background: #2D89EF;
        color: white;
        font-size: 22px;
        font-weight: bold;
        cursor: pointer;
        display: flex;
        justify-content: center;
        align-items: center;
        transition: 0.2s;
    }

        .quantityBox button:hover {
            background: #1E4C74;
            transform: translateY(-2px);
        }

    .quantityBox span {
        min-width: 35px;
        text-align: center;
        font-size: 20px;
        font-weight: bold;
        color: #16324F;
    }

.addCartButton {
    width: 100%;
    margin-top: 20px;
    padding: 14px;
    border: none;
    border-radius: 12px;
    background: #2D89EF;
    color: white;
    font-size: 18px;
    font-weight: bold;
    transition: .3s;
}

    .addCartButton:hover {
        background: #1f6fd1;
    }

.addCartButton {
    width: 100%;
    margin-top: 20px;
    padding: 15px;
    border: none;
    border-radius: 12px;
    background: #2D89EF;
    color: white;
    font-size: 18px;
    font-weight: 700;
    cursor: pointer;
    transition: .3s;
}

    .addCartButton:hover {
        background: #1b6fd4;
    }

.cartPage {
    display: flex;
    gap: 40px;
    align-items: flex-start;
    margin: 50px 0;
}

.cartItems {
    flex: 2;
    background: #fff;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 10px 30px rgba(0,0,0,.15);
}

.cartSummary {
    flex: 1;
    background: #fff;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 10px 30px rgba(0,0,0,.15);
    position: sticky;
    top: 30px;
}

    .cartItems h2,
    .cartSummary h2 {
        color: #16324F;
        font-weight: 700;
        margin-bottom: 20px;
    }

.summaryRow {
    display: flex;
    justify-content: space-between;
    margin: 18px 0;
    font-size: 18px;
}

.checkoutButton {
    width: 100%;
    margin-top: 25px;
    padding: 16px;
    border: none;
    border-radius: 12px;
    background: #2D89EF;
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: .3s;
}

    .checkoutButton:hover {
        background: #1d6fd1;
        transform: translateY(-2px);
    }


.cartItem {
    background: white;
    border-radius: 15px;
    padding: 20px;
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 20px;
    box-shadow: 0 5px 15px rgba(0,0,0,.12);
}

.cartItemImage {
    width: 100px;
    height: 100px;
    object-fit: contain;
    border-radius: 10px;
    background: #f8f9fa;
    padding: 10px;
}

.cartItemInfo {
    flex: 1;
}

    .cartItemInfo h4 {
        color: #16324F;
        margin-bottom: 8px;
        font-weight: bold;
    }

    .cartItemInfo p {
        margin: 4px 0;
        color: #555;
    }

.cartItemTotal {
    font-size: 22px;
    font-weight: bold;
    color: #2D89EF;
}

.checkoutPage {
    display: flex;
    gap: 40px;
    align-items: flex-start;
    margin: 60px 0;
}

.checkoutCard {
    flex: 1;
    background: white;
    border-radius: 20px;
    padding: 35px;
    box-shadow: 0 10px 30px rgba(0,0,0,.15);
}

    .checkoutCard h2 {
        color: #16324F;
        margin-bottom: 25px;
    }

.checkoutInput {
    width: 100%;
    padding: 15px;
    margin-bottom: 18px;
    border: 1px solid #ddd;
    border-radius: 12px;
    font-size: 16px;
}

    .checkoutInput:focus {
        outline: none;
        border-color: #2D89EF;
    }

.productsGridContainer {
    width: 90%;
    max-width: 1400px;
    margin: 40px auto 80px;
}

#homeProductsGrid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
    width: 100%;
}

    #homeProductsGrid .productItem {
        width: auto;
    }

    #homeProductsGrid .productCard {
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    #homeProductsGrid .productImage {
        width: 100%;
        height: 260px;
        object-fit: contain;
        object-position: center;
        display: block;
    }

    #homeProductsGrid .productBody {
        flex: 1;
        display: flex;
        flex-direction: column;
    }

    #homeProductsGrid .addCartButton {
        margin-top: auto;
    }

.productCard .productImage {
    width: 100% !important;
    height: 280px !important;
    max-width: none !important;
    margin: 0 !important;
    padding: 0 !important;
    display: block !important;
    object-fit: cover !important;
    object-position: center !important;
}

     </style>
      
<html xmlns="http://www.w3.org/1999/xhtml">

<body>

        <!-- HOME -->

        <section id="homeSection">

            <div class="cartContainer">

                <button
                    type="button"
                    id="btnCart"
                    class="cartButton"
                    onclick="showCart()">
                    🛒 Cart

            <span id="cartCount">0

            </span>
                   
                </button>

            </div>

            <%--

            <div class="hero">

                <h1>Choose Your Event Hire Option

                </h1>

                <p>
                    Hire individual items or complete event packages
        for weddings, birthdays, graduations and more.

                </p>

            </div>

            <div class="container">

                <div class="row g-4">

                    <!-- Singles -->

                    <div class="col-lg-6">

                        <div class="packageCard">

                            <div class="packageImage">

                                <img src="Images/singles-home.jpg" alt="Singles" />

                            </div>

                            <div class="packageBody">

                                <h2>Singles

                                </h2>

                                <p>
                                    Hire chairs, tables, tents, décor,
                        lighting and more.

                                </p>

                                <button
                                    type="button"
                                    class="mainButton"
                                    onclick="showProducts()">
                                    Browse Singles

                                </button>

                            </div>

                        </div>

                    </div>

                    <!-- Combos -->

                    <div class="col-lg-6">

                        <div class="packageCard">

                            <div class="packageImage">

                                <img src="Images/combos-home.jpg" alt="Combos" />

                            </div>

                            <div class="packageBody">

                                <h2>Combos

                                </h2>

                                <p>
                                    Complete event packages for every
                        special occasion.

                                </p>

                                <button
                                    type="button"
                                    class="mainButton"
                                    onclick="showCombos()">
                                    Browse Combos

                                </button>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

            --%>

            <div class="hero">

    <h1>Browse Our Products</h1>

    <p>
        Chairs, Tables, Packages and much more.
    </p>

</div>

<div class="container">

    <div class="categoryTabs">

        <button type="button"
            class="categoryButton activeCategory"
            onclick="filterProducts('all', this)">
            All Products
        </button>

        <button type="button"
            class="categoryButton"
            onclick="filterProducts('chairs', this)">
            Chairs
        </button>

        <button type="button"
            class="categoryButton"
            onclick="filterProducts('tables', this)">
            Tables
        </button>

        <button type="button"
            class="categoryButton"
            onclick="filterProducts('packages', this)">
            Packages
        </button>

    </div>

</div>

<div class="productsGridContainer">

    <div id="homeProductsGrid" class="row g-4">

                            <!-- Steel Chair -->

                    <div class="col-lg-4 productItem" data-category="chairs">

                        <div class="productCard">

                            <img
                                id="steelChairImage"
                                src="Images/steel-black.png"
                                class="productImage"
                                alt="Steel Chair" />

                            <div class="productBody">

                                <h3>Steel Banquet Chair</h3>

                                <p>
                                    Strong and elegant steel banquet chair
                suitable for weddings, parties and
                corporate events.
                                </p>

                                <div class="colourOptions">

                                    <span class="colour black"
                                        onclick="changeSteelChair('Images/steel-black.png')"></span>

                                    <span class="colour white"
                                        onclick="changeSteelChair('Images/steel-white.png')"></span>

                                    <span class="colour silver"
                                        onclick="changeSteelChair('Images/steel-silver.png')"></span>

                                    <span class="colour gold"
                                        onclick="changeSteelChair('Images/steel-gold.png')"></span>

                                    <span class="colour pink"
                                        onclick="changeSteelChair('Images/steel-pink.png')"></span>

                                    <span class="colour blue"
                                        onclick="changeSteelChair('Images/steel-blue.png')"></span>

                                </div>

                                <h4 class="price">R25.00 Each

                                </h4>

                                <div class="quantityBox">

                                    <button
                                        type="button"
                                        onclick="decreaseSteelChair()">
                                        −

                                    </button>

                                    <span id="steelChairQty">0

                                    </span>

                                    <button
                                        type="button"
                                        onclick="increaseSteelChair()">
                                        +

                                    </button>

                                </div>

                                <button
                                    type="button"
                                    class="addCartButton"
                                    onclick="addSteelChairToCart()">
                                    Add To Cart

                                </button>


                            </div>

                        </div>
                    </div>

                    <!-- Plastic Chair -->

                    <div class="col-lg-4 productItem" data-category="chairs">

                        <div class="productCard">

                            <img
                                id="plasticChairImage"
                                src="Images/plastic-black.png"
                                class="productImage"
                                alt="Plastic Chair" />

                            <div class="productBody">

                                <h3>Plastic Chair</h3>

                                <p>
                                    Durable plastic chair suitable for indoor and outdoor events.
                                </p>


                                <div class="colourOptions">

                                    <span class="colour black"
                                        onclick="changePlasticChair('Images/plastic-black.png')"></span>

                                    <span class="colour white"
                                        onclick="changePlasticChair('Images/plastic-white.png')"></span>

                                    <span class="colour blue"
                                        onclick="changePlasticChair('Images/plastic-blue.png')"></span>

                                    <span class="colour red"
                                        onclick="changePlasticChair('Images/plastic-red.png')"></span>

                                    <span class="colour green"
                                        onclick="changePlasticChair('Images/plastic-green.png')"></span>

                                    <span class="colour yellow"
                                        onclick="changePlasticChair('Images/plastic-yellow.png')"></span>

                                </div>

                                <h4 class="price">R20.00 Each

                                </h4>

                                <div class="quantityBox">

                                    <button
                                        type="button"
                                        onclick="decreasePlasticChair()">
                                        −

                                    </button>

                                    <span id="plasticChairQty">0

                                    </span>

                                    <button
                                        type="button"
                                        onclick="increasePlasticChair()">
                                        +

                                    </button>

                                </div>

                                <button
                                    type="button"
                                    class="addCartButton"
                                    onclick="addPlasticChairToCart()">
                                    Add To Cart

                                </button>


                            </div>

                        </div>

                    </div>

                    <!-- Tiffany Chair -->

                    <div class="col-lg-4 productItem" data-category="chairs">

                        <div class="productCard">

                            <img
                                id="tiffanyChairImage"
                                src="Images/tiffany-clear.png"
                                class="productImage"
                                alt="Tiffany Chair" />

                            <div class="productBody">

                                <h3>Tiffany Chair</h3>

                                <p>
                                    Elegant Tiffany chair perfect for weddings,
banquets and premium events.
                                </p>

                                <div class="colourOptions">

                                    <span class="colour clear"
                                        onclick="changeTiffanyChair('Images/tiffany-clear.png')"></span>

                                    <span class="colour gold"
                                        onclick="changeTiffanyChair('Images/tiffany-gold.png')"></span>

                                    <span class="colour silver"
                                        onclick="changeTiffanyChair('Images/tiffany-silver.png')"></span>

                                    <span class="colour white"
                                        onclick="changeTiffanyChair('Images/tiffany-white.png')"></span>

                                    <span class="colour black"
                                        onclick="changeTiffanyChair('Images/tiffany-black.png')"></span>

                                    <span class="colour champagne"
                                        onclick="changeTiffanyChair('Images/tiffany-champagne.png')"></span>

                                </div>

                                <h4 class="price">R40.00 Each

                                </h4>

                                <div class="quantityBox">

                                    <button
                                        type="button"
                                        onclick="decreaseTiffanyChair()">
                                        −

                                    </button>

                                    <span id="tiffanyChairQty">0

                                    </span>

                                    <button
                                        type="button"
                                        onclick="increaseTiffanyChair()">
                                        +

                                    </button>

                                </div>

                                <button
                                    type="button"
                                    class="addCartButton"
                                    onclick="addTiffanyChairToCart()">
                                    Add To Cart

                                </button>


                            </div>
                        </div>
                    </div>


                    <!-- Round Table -->

                    <div class="col-lg-4 productItem" data-category="tables">

                        <div class="productCard">

                            <img
                                id="roundTableImage"
                                src="Images/round-table-silver.png"
                                class="productImage"
                                alt="Round Table" />

                            <div class="productBody">

                                <h3>Round Table</h3>

                                <p>
                                    Heavy-duty round table suitable for weddings,
                conferences and parties.
                                </p>

                                <div class="colourOptions">

                                    <span class="colour white"
                                        onclick="changeRoundTable('Images/round-table-white.png')"
                                        title="4ft"></span>

                                    <span class="colour silver"
                                        onclick="changeRoundTable('Images/round-table-silver.png')"
                                        title="5ft"></span>

                                    <span class="colour blue"
                                        onclick="changeRoundTable('Images/round-table-blue.png')"
                                        title="6ft"></span>

                                </div>

                                <h4 class="price">R150.00 Each

                                </h4>

                                <div class="quantityBox">

                                    <button
                                        type="button"
                                        onclick="decreaseRoundTable()">
                                        −

                                    </button>

                                    <span id="roundTableQty">0

                                    </span>

                                    <button
                                        type="button"
                                        onclick="increaseRoundTable()">
                                        +

                                    </button>

                                </div>

                                <button
                                    type="button"
                                    class="addCartButton"
                                    onclick="addRoundTableToCart()">
                                    Add To Cart

                                </button>

                        </div>

                    </div>

                </div>

        <!-- LIGHTS PRODUCTS -->

<div class="col-lg-4 col-md-6 productItem" data-category="Lighting">

    <div class="productCard">

        <img src="Images/fairy-lights.jpg"
     class="productImage"
     alt="Fairy Lights" />

        <div class="productBody">

            <h3>Fairy Lights</h3>

            <p>
                Warm decorative fairy lights suitable for weddings,
                parties and special events.
            </p>

            <h4>R50.00 Each</h4>

            <div class="quantityControl">

                <div class="quantityBox">
    <button type="button" onclick="decreaseQuantity('fairyLightsQty')">−</button>

    <span id="fairyLightsQty">0</span>

    <button type="button" onclick="increaseQuantity('fairyLightsQty')">+</button>
</div>

            </div>

            <button type="button"
                    class="addCartButton"
                    onclick="addToCart('Fairy Lights', 50, this)">

                🛒 Add To Cart

            </button>

        </div>

    </div>

</div>


<div class="col-lg-4 col-md-6 productItem" data-category="Lighting">

    <div class="productCard">

        <img src="Images/led-uplights.jpg"
     class="productImage"
     alt="LED Uplights" />

        <div class="productBody">

            <h3>LED Uplights</h3>

            <p>
                Bright LED uplighting for creating an attractive
                atmosphere at any event.
            </p>

            <h4>R80.00 Each</h4>

            <div class="quantityControl">

                <div class="quantityBox">
    <button type="button" onclick="decreaseQuantity('ledUplightsQty')">−</button>

    <span id="ledUplightsQty">0</span>

    <button type="button" onclick="increaseQuantity('ledUplightsQty')">+</button>
</div>

            </div>

            <button type="button"
                    class="addCartButton"
                    onclick="addToCart('LED Uplights', 80, this)">

                🛒 Add To Cart

            </button>

        </div>

    </div>

</div>


<div class="col-lg-4 col-md-6 productItem" data-category="Lighting">

    <div class="productCard">

        <img src="Images/string-lights.jpg"
     class="productImage"
     alt="String Lights" />

        <div class="productBody">

            <h3>String Lights</h3>

            <p>
                Elegant string lights perfect for decorating
                tents, tables and outdoor spaces.
            </p>

            <h4>R60.00 Each</h4>

            <div class="quantityControl">

                <div class="quantityBox">
    <button type="button" onclick="decreaseQuantity('stringLightsQty')">−</button>

    <span id="stringlightsQty">0</span>

    <button type="button" onclick="increaseQuantity('stringlightsQty')">+</button>
</div>

            </div>

            <button type="button"
                    class="addCartButton"
                    onclick="addToCart('String Lights', 60, this)">

                🛒 Add To Cart

            </button>

        </div>

    </div>

</div>


<div class="col-lg-4 col-md-6 productItem" data-category="Lighting">

    <div class="productCard">

        <img src="Images/hanging-lights.jpg"
     class="productImage"
     alt="Hanging Lights" />

        <div class="productBody">

            <h3>Hanging Lights</h3>

            <p>
                Decorative hanging lights suitable for wedding
                receptions and formal events.
            </p>

            <h4>R100.00 Each</h4>

            <div class="quantityControl">

               <div class="quantityBox">
    <button type="button" onclick="decreaseQuantity('hanginglightsQty')">−</button>

    <span id="hanginglightsQty">0</span>

    <button type="button" onclick="increaseQuantity('hanginglightsQty')">+</button>
</div>

            </div>

            <button type="button"
                    class="addCartButton"
                    onclick="addToCart('Hanging Lights', 100, this)">

                🛒 Add To Cart

            </button>

        </div>

    </div>

</div>



                        <!-- Wedding Package -->

                    <div class="col-lg-4 productItem" data-category="packages">

                        <div class="productCard">

                            <img
                                id="weddingPackageImage"
                                src="Images/wedding-gold.jpg"
                                class="productImage"
                                alt="Wedding Package" />

                            <div class="productBody">

                                <h3>Wedding Package</h3>

                                <p>
                                    Elegant setup perfect for your special day.
                                </p>

                                <strong>Choose Theme / Colour</strong>

                                <div class="colourOptions">

                                    <span
                                        class="colour gold"
                                        onclick="changeWeddingPackage('Images/wedding-gold.jpg')">
                                    </span>

                                    <span
                                        class="colour white"
                                        onclick="changeWeddingPackage('Images/wedding-white.jpg')">
                                    </span>

                                    <span
                                        class="colour silver"
                                        onclick="changeWeddingPackage('Images/wedding-silver.jpg')">
                                    </span>

                                    <span
                                        class="colour blue"
                                        onclick="changeWeddingPackage('Images/wedding-blue.jpg')">
                                    </span>

                                </div>

                                <strong>Package Includes</strong>

                                <ul>

                                    <li>550 Tiffany Chairs</li>

                                    <li>100 Round Tables</li>

                                    <li>2 Marquee Tent</li>

                                    <li>Table Linen</li>

                                    <li>Décor</li>

                                    <li>Lighting</li>

                                </ul>

                                <h4 class="price">
                                    R48 500.00 / Package
                                </h4>

                                <button
                                    class="addCartButton"
                                    type="button"
                                    onclick="addWeddingPackageToCart()">

                                    Add Package To Cart

                                </button>

                            </div>

                        </div>

                    </div>

        <!-- BIRTHDAY PACKAGE -->
    <div class="col-lg-4 productItem" data-category="packages">

    <div class="productCard">

        <img src="Images/birthday-package.jpg"
             class="productImage"
             alt="Birthday Package"/>

        <div class="productBody">

            <h3>Birthday Package</h3>

            <p>
                A fun and stylish package perfect for birthday celebrations.
            </p>

            <strong>Choose Theme / Colour</strong>

<div class="colourOptions">

    <span
        class="colour pink"
        onclick="changeBirthdayPackage('Images/birthday-pink.jpg')">
    </span>

    <span
        class="colour white"
        onclick="changeBirthdayPackage('Images/birthday-white.jpg')">
    </span>

    <span
        class="colour silver"
        onclick="changeBirthdayPackage('Images/birthday-silver.jpg')">
    </span>

    <span
        class="colour blue"
        onclick="changeBirthdayPackage('Images/birthday-blue.jpg')">
    </span>

</div>

<strong>Package Includes</strong>

<ul>

    <li>20 Tiffany Chairs</li>

    <li>5 Round Tables</li>

    <li>1 Marquee Tent</li>

    <li>Table Linen</li>

    <li>Décor</li>

    <li>Balloons</li>

    <li>Flowers</li>

    <li>Lighting</li>

</ul>

            <h4>R5 500.00 / Package</h4>

            <button type="button"
                    class="addCartButton">

                🛒 Add To Cart

            </button>

        </div>

    </div>
</div>


<!-- GRADUATION PACKAGE -->
<div class="productItem">
    <div class="productCard">

        <img src="Images/graduation-package.jpg"
             class="productImage"
             alt="Graduation Package"/>

        <div class="productBody">

            <h3>Graduation Package</h3>

            <p>
                Celebrate your achievement with a stylish graduation setup.
            </p>

            <h4>R6 000.00 / Package</h4>

            <div class="quantityBox">

                <button type="button">−</button>

                <span>0</span>

                <button type="button">+</button>

            </div>

            <button type="button"
                    class="addCartButton">

                🛒 Add To Cart

            </button>

        </div>

    </div>
</div>


<!-- ANNIVERSARY PACKAGE -->
<div class="productItem">
    <div class="productCard">

        <img src="/anniversary-package.jpg"
             class="productImage"
             alt="Anniversary Package"/>

        <div class="productBody">

            <h3>Anniversary Package</h3>

            <p>
                An elegant setup designed for memorable anniversary celebrations.
            </p>

            <h4>R6 500.00 / Package</h4>

            <div class="quantityBox">

                <button type="button">−</button>

                <span>0</span>

                <button type="button">+</button>

            </div>

            <button type="button"
                    class="addCartButton">

                🛒 Add To Cart

            </button>

        </div>

    </div>
</div>

                    </div>
                    </div>


        </section>

        <!--PRODUCTS-->

        <section id="productsSection" style="display: none;">

            <div class="productsTopBar">

                <button
                    type="button"
                    class="backButton"
                    onclick="goHome()">
                    ← Back

                </button>

                <button
                    type="button"
                    id="btnProductsCart"
                    class="cartButton"
                    onclick="showCart()">
                    🛒 Cart

            <span id="productsCartCount">0

            </span>

                </button>

            </div>

            <div class="hero">

                <h1>Hire Single Items

                </h1>

                <p>
                    Select a category to browse our products.

                </p>

            </div>

            <!-- Categories -->

            <div class="container">

                <div class="categoryTabs">

                    <button
                        type="button"
                        class="categoryButton activeCategory"
                        onclick="filterProducts('all', this)">
                        All Products

                    </button>

                    <button
                        type="button"
                        class="categoryButton"
                        onclick="filterProducts('chairs', this)">
                        Chairs

                    </button>

                    <button
                        type="button"
                        class="categoryButton"
                        onclick="filterProducts('tables', this)">
                        Tables

                    </button>

                    <button
                        type="button"
                        class="categoryButton"
                        onclick="filterProducts('tents', this)">
                        Tents

                    </button>

                    <button
                        type="button"
                        class="categoryButton"
                        onclick="filterProducts('decor', this)">
                        Décor

                    </button>

                    <button
                        type="button"
                        class="categoryButton"
                        onclick="filterProducts('linen', this)">
                        Linen

                    </button>

                    <button
                        type="button"
                        class="categoryButton"
                        onclick="filterProducts('crockery', this)">
                        Crockery

                    </button>

                    <button
                        type="button"
                        class="categoryButton"
                        onclick="filterProducts('lighting', this)">
                        Lighting

                    </button>

                    <button
                        type="button"
                        class="categoryButton"
                        onclick="filterProducts('other', this)">
                        Other

                    </button>

                </div>

            </div>

            <div class="container">

                <div
                    id="productsGrid"
                    class="row g-4">

                    

            </div>
            </div>

        </section>

        <!--COMBOS-->

        <section id="combosSection" style="display: none;">

            <div class="productsTopBar">

                <button
                    type="button"
                    class="backButton"
                    onclick="goHome()">
                    ← Back

                </button>

            </div>

            <div class="cartContainer">

                <button
                    type="button"
                    id="btnCombosCart"
                    class="cartButton"
                    onclick="showCart()">
                    🛒 Cart

        <span id="combosCartCount">0</span>

                </button>

            </div>

            <div class="hero">

                <h1>Event Packages</h1>

                <p>
                    Ready-made packages for every occasion.
                </p>

            </div>

            <div class="container">

                <div class="categoryTabs">

                    <button type="button" class="categoryButton activeCategory">
                        All Packages
                    </button>

                    <button type="button" class="categoryButton">
                        Wedding
                    </button>

                    <button type="button" class="categoryButton">
                        Birthday
                    </button>

                    <button type="button" class="categoryButton">
                        Graduation
                    </button>

                    <button type="button" class="categoryButton">
                        Anniversary
                    </button>

                    <button type="button" class="categoryButton">
                        Corporate
                    </button>

                    <button type="button" class="categoryButton">
                        Other
                    </button>

                </div>

            </div>

            <!-- Packages -->

            <div class="container">

                <div id="combosGrid" class="row g-4">

                    

                    </div>

            </div>

        </section>

        <!--Cart-->

        <section id="cartSection" style="display: none;">

            <div class="productsTopBar">

                <button
                    type="button"
                    class="backButton"
                    onclick="continueShopping()">
                    ← Continue Shopping

                </button>

            </div>

            <div class="hero">

                <h1>Your Cart

                </h1>

                <p>
                    Review your selected hire items before checkout.

                </p>

            </div>

            <div class="container">

                <div class="cartPage">

                    <div class="cartItems">

                        <h2>Selected Items</h2>

                        <div id="cartItemsContainer">

                            <p>No items added yet.</p>

                        </div>

                    </div>

                    <div class="cartSummary">

                        <h2>Order Summary</h2>

                        <hr />

                        <div class="summaryRow">

                            <span>Total Items</span>

                            <span id="summaryItems">0</span>

                        </div>

                        <div class="summaryRow">

                            <span>Total Price</span>

                            <span id="summaryPrice">R0.00</span>

                        </div>

                        <button
                            type="button"
                            class="checkoutButton"
                            onclick="showCheckout()">
                            Proceed To Checkout

                        </button>

                    </div>

                </div>

            </div>

        </section>

        <!--Checkout-->

        <section id="checkoutSection" style="display: none;">

            <div class="productsTopBar">

                <button
                    type="button"
                    class="backButton"
                    onclick="showCart()">
                    ← Back To Cart

                </button>

            </div>

            <div class="hero">

                <h1>Checkout

                </h1>

                <p>
                    Complete your booking details.

                </p>

            </div>

            <div class="container">

                <div class="checkoutPage">

                    <div class="checkoutCard">

                        <h2>Customer Information</h2>

<input
    type="text"
    placeholder="Full Name"
    class="checkoutInput" />

<input
    type="email"
    placeholder="Email Address"
    class="checkoutInput" />

<input
    type="text"
    placeholder="Phone Number"
    class="checkoutInput" />

<input
    type="date"
    class="checkoutInput" />

<!-- Address -->

<input
    type="text"
    placeholder="Street Address"
    class="checkoutInput" />

<input
    type="text"
    placeholder="Suburb"
    class="checkoutInput" />

<div class="row">

    <div class="col-6">

        <input
            type="text"
            placeholder="City"
            class="checkoutInput" />

    </div>

    <div class="col-6">

        <input
            type="text"
            placeholder="Postal Code"
            class="checkoutInput" />

    </div>

</div>

<textarea
    class="checkoutInput"
    rows="3"
    placeholder="Additional Delivery Notes (Optional)">
</textarea>

                    </div>

                    <div class="checkoutCard">

                        <h2>Order Summary</h2>

                        <div id="checkoutSummary">
                            No items yet.

                        </div>

                        <hr />

                        <div class="summaryRow">

                            <span>Total Items</span>

                            <span id="checkoutItems">0</span>

                        </div>

                        <div class="summaryRow">

                            <span>Total Amount</span>

                            <span id="checkoutTotal">R0.00

                            </span>

                        </div>

                        <button
                            type="button"
                            class="checkoutButton"
                            onclick="confirmBooking()">
                            Confirm Booking

                        </button>

                    </div>

                </div>

            </div>

        </section>

  <script src="../Content/script.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>

</asp:Content>


