
<%@ Page Title="Home"
    Language="C#"
    MasterPageFile="~/Presentation/SystemLayout.master"
    AutoEventWireup="true"
    CodeBehind="Home.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.Home" %>

<asp:Content ID="HeadContent"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Content/Forte.css"
          rel="stylesheet" />

    <style>
        /* HOME PAGE ONLY */

        .fehms-home .hero-section {
            background-image:
                linear-gradient(
                    rgba(0, 0, 0, 0.55),
                    rgba(0, 0, 0, 0.55)
                ),
                url('../Images/Hero background.png');

            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            min-height: 450px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            padding: 55px 35px;
        }

        .fehms-home .hero-section h1,
        .fehms-home .hero-section h5,
        .fehms-home .hero-section p {
            color: #ffffff;
        }

        .fehms-home .hero-section h1 {
            font-weight: 700;
            font-size: clamp(2rem, 4vw, 3.5rem);
        }

        .fehms-home .hero-section p {
            max-width: 600px;
        }

        .fehms-home .search-box {
            position: relative;
            margin: -35px auto 0;
            padding: 25px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
            max-width: 1050px;
        }

        .fehms-home .search-box .form-control,
        .fehms-home .search-box .form-select {
            margin: 0;
            min-height: 45px;
        }

        .fehms-home .search-box .btn {
            min-height: 45px;
            width: 100%;
        }

        .fehms-home .feature-section {
            margin-top: 65px;
        }

        .fehms-home .feature-item {
            text-align: center;
            padding: 25px 15px;
        }

        .fehms-home .feature-item i {
            font-size: 38px;
            color: #2457d6;
        }

        .fehms-home .feature-item h5 {
            margin-top: 15px;
            font-weight: 700;
        }

        .fehms-home .feature-item p {
            color: #64748b;
        }

        .fehms-home .category-section {
            margin-top: 55px;
            margin-bottom: 45px;
        }

        .fehms-home .category-card {
            height: 100%;
            padding: 0;
            margin-top: 0;
            overflow: hidden;
            border-radius: 14px;
            background: #ffffff;
            transition: transform 0.25s ease,
                        box-shadow 0.25s ease;
        }

        .fehms-home .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.12);
        }

        .fehms-home .category-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .fehms-home .category-card .card-body {
            padding: 20px;
        }

        .fehms-home .category-card h6 {
            font-weight: 700;
            margin-bottom: 12px;
        }

        .fehms-home .category-card .btn-link {
            background: transparent;
            border: none;
            box-shadow: none;
            color: #2457d6;
            padding: 5px;
            text-decoration: none;
        }

        .fehms-home .category-card .btn-link:hover {
            color: #1e3a8a;
            transform: none;
        }

        @media (max-width: 768px) {
            .fehms-home .hero-section {
                min-height: 370px;
                padding: 35px 20px;
            }

            .fehms-home .search-box {
                margin-top: 20px;
                padding: 20px;
            }

            .fehms-home .feature-section {
                margin-top: 35px;
            }

            .fehms-home .category-section {
                margin-top: 35px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="MainPageContent"
    ContentPlaceHolderID="MainContent"
    runat="server">

<div class="fehms-home">

    <!-- HERO SECTION -->

    <section class="hero-section text-white">

        <div class="container">

            <h5 class="text-uppercase">
                Make Every Event
            </h5>

            <h1 class="display-4 fw-bold">
                Extraordinary
                <br />
                Events Start Here
            </h1>

            <p class="lead">
                Top-quality event equipment and décor
                for any occasion.
            </p>

            <div class="mt-4">

                <a href="Catalogue.aspx"
                   class="btn btn-primary btn-lg me-3">
                    Browse Catalogue
                </a>

                <a href="HowItWorks.aspx"
                   class="btn btn-outline-light btn-lg">
                    How It Works
                </a>

            </div>

        </div>

    </section>


    <!-- SEARCH BAR -->

    <section class="search-box">

        <div class="row g-3 align-items-center">

            <div class="col-md-3">

                <asp:DropDownList
                    ID="ddlCategory"
                    runat="server"
                    CssClass="form-select">

                    <asp:ListItem
                        Text="All Categories"
                        Value="" />

                    <asp:ListItem
                        Text="Tents"
                        Value="Tents" />

                    <asp:ListItem
                        Text="Chairs"
                        Value="Chairs" />

                    <asp:ListItem
                        Text="Lighting"
                        Value="Lighting" />

                </asp:DropDownList>

            </div>

            <div class="col-md-7">

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Search equipment..." />

            </div>

            <div class="col-md-2">

                <asp:Button
                    ID="btnSearch"
                    runat="server"
                    Text="Search"
                    CssClass="btn btn-primary"
                    OnClick="btnSearch_Click" />

            </div>

        </div>

    </section>


    <!-- FEATURES -->

    <section class="feature-section">

        <div class="row g-4">

            <div class="col-md-3 col-sm-6">

                <div class="feature-item">

                    <i class="bi bi-award"></i>

                    <h5>Quality Guaranteed</h5>

                    <p>
                        Premium equipment and décor
                    </p>

                </div>

            </div>

            <div class="col-md-3 col-sm-6">

                <div class="feature-item">

                    <i class="bi bi-truck"></i>

                    <h5>Reliable Delivery</h5>

                    <p>
                        On-time delivery and collection
                    </p>

                </div>

            </div>

            <div class="col-md-3 col-sm-6">

                <div class="feature-item">

                    <i class="bi bi-headset"></i>

                    <h5>Support</h5>

                    <p>
                        We help every step of the way
                    </p>

                </div>

            </div>

            <div class="col-md-3 col-sm-6">

                <div class="feature-item">

                    <i class="bi bi-shield-check"></i>

                    <h5>Secure Payments</h5>

                    <p>
                        Safe online transactions
                    </p>

                </div>

            </div>

        </div>

    </section>


    <!-- CATEGORIES -->

    <section class="category-section">

        <h2 class="text-center mb-4">
            Everything You Need
        </h2>

        <div class="row g-4">

            <!-- TENTS -->

            <div class="col-lg-3 col-md-6">

                <div class="card category-card">

                    <img src="../Images/Tents.jpg"
                         alt="Tents and Marquees"
                         class="card-img-top" />

                    <div class="card-body text-center">

                        <h6>Tents &amp; Marquees</h6>

                        <a href="Login.aspx"
                           class="btn btn-link">
                            View All
                        </a>

                    </div>

                </div>

            </div>


            <!-- TABLES AND CHAIRS -->

            <div class="col-lg-3 col-md-6">

                <div class="card category-card">

                    <img src="../Images/T&amp;Cs.jpg"
                         alt="Tables and Chairs"
                         class="card-img-top" />

                    <div class="card-body text-center">

                        <h6>Tables &amp; Chairs</h6>

                        <a href="Login.aspx"
                           class="btn btn-link">
                            View All
                        </a>

                    </div>

                </div>

            </div>


            <!-- DECOR -->

            <div class="col-lg-3 col-md-6">

                <div class="card category-card">

                    <img src="../Images/Deccor.jpg"
                         alt="Event Decor"
                         class="card-img-top" />

                    <div class="card-body text-center">

                        <h6>Décor</h6>

                        <a href="Catalogue.aspx"
                           class="btn btn-link">
                            View All
                        </a>

                    </div>

                </div>

            </div>


            <!-- SOUND -->

            <div class="col-lg-3 col-md-6">

                <div class="card category-card">

                    <img src="../Images/sound.jpg"
                         alt="Sound and Audio"
                         class="card-img-top" />

                    <div class="card-body text-center">

                        <h6>Sound &amp; Audio</h6>

                        <a href="Login.aspx"
                           class="btn btn-link">
                            View All
                        </a>

                    </div>

                </div>

            </div>

        </div>

    </section>

</div>

</asp:Content>
