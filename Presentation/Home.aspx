<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm7" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Forte.css" rel="stylesheet" />

    <!-- HERO SECTION -->
    <div class="hero-section text-white d-flex align-items-center" style="background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('../Images/Hero background.png') no-repeat center center / cover; min-height: 450px;">
        <div class="container">
            <h5 class="text-uppercase">Make Every Event</h5>
            <h1 class="display-4 fw-bold">Extraordinary
                <br />
                Events Start Here</h1>
            <p class="lead">
                Top-quality event equipment and décor for any occasion.
            </p>

            <div class="mt-4">
                <a href="Catalogue.aspx" class="btn btn-primary btn-lg me-3">Browse Catalogue</a>
                <a href="HowItWorks.aspx" class="btn btn-outline-light btn-lg">How It Works</a>
            </div>
        </div>
    </div>

    <!-- SEARCH BAR -->
    <div class="search-box container shadow">
        <div class="row g-2">
            <div class="col-md-3">

                <asp:DropDownList ID="ddlCategory" runat="server"
                    CssClass="form-select">
                    <asp:ListItem Text="All Categories" Value="" />
<asp:ListItem Text="Chairs" Value="Chairs" />
<asp:ListItem Text="Tables" Value="Tables" />
<asp:ListItem Text="Lighting" Value="Lighting" />
<asp:ListItem Text="Packages" Value="Packages" />
                </asp:DropDownList>

            </div>

            <div class="col-md-7">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search equipment..." />
            </div>

            <div class="col-md-2">
    <asp:Button ID="btnSearch" runat="server"
        Text="Search"
        CssClass="btn btn-primary w-100"
        OnClick="btnSearch_Click" />
</div>

<div class="col-md-2 mt-2">
    <asp:Button ID="btnClearSearch" runat="server"
    Text="✕ Clear Search"
    CssClass="btn btn-outline-primary w-100 clear-search-btn"
    OnClick="btnClearSearch_Click"
    Visible="false" />
</div>
        </div>
    </div>

    <!-- HOME SEARCH RESULTS -->
<asp:Panel ID="pnlHomeResults" runat="server" Visible="false"
    CssClass="container mt-4">

    <h3 class="mb-3">Search Results</h3>

    <asp:Label ID="lblHomeMessage" runat="server"
        CssClass="text-muted d-block mb-3" />

    <div class="row g-4">
        <asp:Repeater ID="rptHomeResults" runat="server">
            <ItemTemplate>
                <div class="col-md-4 col-lg-3">
                    <div class="card h-100 shadow-sm">

    <asp:Image
        ID="imgProduct"
        runat="server"
        ImageUrl='<%# ResolveUrl(Convert.ToString(Eval("ImageUrl"))) %>'
        AlternateText='<%# Eval("ProductName") %>'
        CssClass="card-img-top"
        Style="height: 200px; object-fit: cover;" />

    <div class="card-body">
                            <h5 class="card-title">
                                <%#: Eval("ProductName") %>
                            </h5>

                            <p class="card-text">
                                <%#: Eval("Description") %>
                            </p>

                            <p class="text-muted mb-2">
                                Category:
                                <%#: Eval("Category") %>
                            </p>

                            <h5 class="text-primary">
                                R<%#: Eval("Price", "{0:N2}") %>
                            </h5>
                        </div>

                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</asp:Panel>

    <!-- FEATURES -->
    <div class="container mt-5 text-center">
        <div class="row">

            <div class="col-md-3">
                <i class="bi bi-award fs-1 text-primary"></i>
                <h5>Quality Guaranteed</h5>
                <p>Premium equipment and décor</p>
            </div>

            <div class="col-md-3">
                <i class="bi bi-truck fs-1 text-primary"></i>
                <h5>Reliable Delivery</h5>
                <p>On-time delivery & collection</p>
            </div>

            <div class="col-md-3">
                <i class="bi bi-headset fs-1 text-primary"></i>
                <h5>Support</h5>
                <p>We help every step of the way</p>
            </div>

            <div class="col-md-3">
                <i class="bi bi-shield-check fs-1 text-primary"></i>
                <h5>Secure Payments</h5>
                <p>Safe online transactions</p>
            </div>

        </div>
    </div>

    <!-- CATEGORIES -->
    <div class="container mt-5">
        <h2 class="text-center mb-4">Everything You Need</h2>

        <div class="row g-4">

            <!-- CARD -->
            <div class="col-md-3">
                <div class="card category-card">
                    <img src="../Images/Tents.jpg" class="card-img-top" />
                    <div class="card-body text-center">
                        <h6>Tents & Marquees</h6>
                        <a href="Catalogue.aspx?category=Tents" class="btn btn-link">View All</a>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card category-card">
                    <img src="../Images/T&Cs.jpg" class="card-img-top" />
                    <div class="card-body text-center">
                        <h6>Tables & Chairs</h6>
                        <a href="Catalogue.aspx?category=Chairs" class="btn btn-link">View All</a>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card category-card">
                    <img src="../Images/Deccor.jpg" class="card-img-top" />
                    <div class="card-body text-center">
                        <h6>Décor</h6>
                        <a href="Catalogue.aspx?category=Packages" class="btn btn-link">View All</a>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card category-card">
                    <img src="../Images/sound.jpg" class="card-img-top" />
                    <div class="card-body text-center">
                        <h6>Sound & Audio</h6>
                        <a href="Catalogue.aspx?category=Lighting" class="btn btn-link">View All</a>
                    </div>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
