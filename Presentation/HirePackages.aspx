<%@ Page Title="Hire Packages"
    Language="C#"
    MasterPageFile="~/Presentation/SystemLayout.Master"
    AutoEventWireup="true"
    CodeBehind="HirePackages.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.HirePackages" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <style>
        /* HIRE PACKAGES PAGE */

        .hire-packages-page {
            padding-top: 0;
        }

        /* Hero banner */

        .packages-hero {
            min-height: 320px;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
            border-radius: 16px;
            margin-bottom: 35px;
            padding: 45px;
            color: #ffffff;

            background:
                linear-gradient(
                    rgba(7, 24, 39, 0.78),
                    rgba(7, 24, 39, 0.70)
                ),
                url('../Images/Hero background.jpg');

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;

            box-shadow: 0 15px 45px rgba(7, 24, 39, 0.16);
        }

        /* Blue accent at bottom of banner */

        .packages-hero::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 4px;

            background: linear-gradient(
                90deg,
                transparent,
                #2457d6,
                transparent
            );
        }

        .packages-hero-content {
            position: relative;
            z-index: 1;
            max-width: 700px;
        }

        .packages-hero-label {
            color: #8fb0ff;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .packages-hero h1 {
            color: #ffffff;
            font-size: clamp(32px, 4vw, 48px);
            font-weight: 700;
            line-height: 1.15;
            margin-bottom: 18px;
        }

        .packages-hero p {
            color: #e2e8f0;
            font-size: 17px;
            max-width: 570px;
            margin-bottom: 0;
        }

        /* Space before the package catalogue */

        .packages-catalogue {
            padding-bottom: 20px;
        }

        @media (max-width: 576px) {
            .packages-hero {
                min-height: 300px;
                padding: 28px 22px;
                border-radius: 12px;
            }

            .packages-hero p {
                font-size: 15px;
            }
        }

/* PACKAGE CATALOGUE LAYOUT */

.packages-catalogue {
    padding: 10px 0 35px;
}

.catalogue-heading {
    margin-bottom: 25px;
}

.catalogue-heading h2 {
    color: #071827;
    font-weight: 700;
    margin-bottom: 8px;
}

.catalogue-layout {
    display: grid;
    grid-template-columns: 250px minmax(0, 1fr);
    gap: 28px;
    align-items: start;
}

/* LEFT FILTER SIDEBAR */

.package-sidebar {
    background: #ffffff;
    border: 1px solid #e5eaf1;
    border-radius: 14px;
    padding: 22px;
    box-shadow: 0 5px 20px rgba(7, 24, 39, 0.05);
}

.package-sidebar h3 {
    color: #071827;
    font-size: 19px;
    font-weight: 700;
    margin-bottom: 22px;
}

.filter-group {
    margin-bottom: 23px;
}

.filter-group label {
    display: block;
    color: #26364a;
    font-size: 14px;
    font-weight: 600;
    margin-bottom: 9px;
}

.filter-control {
    width: 100%;
    min-height: 42px;
    border: 1px solid #d9e1eb;
    border-radius: 8px;
    padding: 9px 11px;
    background: #ffffff;
    color: #26364a;
    font-size: 14px;
}

.filter-button {
    width: 100%;
    border: none;
    border-radius: 8px;
    background: #2457d6;
    color: #ffffff;
    padding: 11px;
    font-weight: 600;
}

.filter-button:hover {
    background: #173da3;
}

/* PACKAGE GRID */

.package-results {
    min-width: 0;
}

.package-grid {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 22px;
}

.package-card {
    min-width: 0;
    overflow: hidden;
    background: #ffffff;
    border: 1px solid #e5eaf1;
    border-radius: 14px;
    box-shadow: 0 5px 20px rgba(7, 24, 39, 0.06);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.package-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 28px rgba(7, 24, 39, 0.12);
}

.package-image {
    width: 100%;
    height: 185px;
    object-fit: cover;
    display: block;
    background: #edf1f6;
}

.package-card-body {
    padding: 18px;
}

.package-card h3 {
    color: #071827;
    font-size: 17px;
    font-weight: 700;
    margin-bottom: 10px;
}

.package-description {
    color: #64748b;
    font-size: 13px;
    line-height: 1.6;
    min-height: 42px;
    margin-bottom: 15px;
}

.package-price {
    color: #2457d6;
    font-size: 20px;
    font-weight: 700;
    margin-bottom: 16px;
}

.package-price small {
    color: #64748b;
    font-size: 12px;
    font-weight: 400;
}

.package-action {
    display: block;
    width: 100%;
    text-align: center;
    text-decoration: none;
    border-radius: 8px;
    padding: 11px;
    background: #071827;
    color: #ffffff;
    font-size: 14px;
    font-weight: 600;
}

.package-action:hover {
    background: #2457d6;
    color: #ffffff;
}

.package-empty {
    padding: 35px 20px;
    background: #ffffff;
    border: 1px dashed #cbd5e1;
    border-radius: 12px;
    text-align: center;
    color: #64748b;
}

@media (max-width: 1100px) {
    .package-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}

@media (max-width: 768px) {
    .catalogue-layout {
        grid-template-columns: 1fr;
    }

    .package-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 15px;
    }
}

@media (max-width: 480px) {
    .package-grid {
        grid-template-columns: 1fr;
    }

    .package-image {
        height: 210px;
    }
}
.package-card-actions {
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin-top: 16px;
}

.package-add-cart {
    width: 100%;
    padding: 11px 16px;
    border: none;
    border-radius: 8px;
    background: #2457d6;
    color: white;
    font-weight: 700;
    cursor: pointer;
}

.package-add-cart:hover {
    background: #173da3;
}

    </style>

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="hire-packages-page">

        <!-- HERO SECTION -->

        <section class="packages-hero">

            <div class="packages-hero-content">

                <div class="packages-hero-label">
                    Forte Event Hire
                </div>

                <h1>
                    Hire Packages
                </h1>

                <p>
                    Discover complete event hire packages for weddings,
                    birthdays, graduations and special occasions.
                    Choose the package that makes your event extraordinary.
                </p>

            </div>

        </section>

        <!-- PACKAGE CATALOGUE WILL BE ADDED NEXT -->

        
<section class="packages-catalogue">

    <div class="catalogue-heading">
        <h2>Explore Our Packages</h2>
        <p class="text-muted">
            Find the right package for your next event.
        </p>
    </div>

    <div class="catalogue-layout">

        <!-- LEFT SIDEBAR -->

        <aside class="package-sidebar">

            <h3>Find Your Package</h3>

            <div class="filter-group">
                <label for="txtSearch">Search packages</label>
                <asp:TextBox ID="txtSearch"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="filter-control"
                    placeholder="Search by name..." />
            </div>

            <div class="filter-group">
                <label for="ddlCategory">Category</label>
                <asp:DropDownList ID="ddlCategory"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="filter-control">
                    <asp:ListItem Text="All Categories" Value="" />
                    <asp:ListItem Text="Wedding" Value="Wedding" />
                    <asp:ListItem Text="Birthday" Value="Birthday" />
                    <asp:ListItem Text="Graduation" Value="Graduation" />
                    <asp:ListItem Text="Corporate" Value="Corporate" />
                    <asp:ListItem Text="Special Occasion"
                        Value="Special Occasion" />
                </asp:DropDownList>
            </div>

            <div class="filter-group">
                <label for="txtMinPrice">Minimum price (R)</label>
                <asp:TextBox ID="txtMinPrice"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="filter-control"
                    TextMode="Number"
                    placeholder="0" />
            </div>

            <div class="filter-group">
                <label for="txtMaxPrice">Maximum price (R)</label>
                <asp:TextBox ID="txtMaxPrice"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="filter-control"
                    TextMode="Number"
                    placeholder="No limit" />
            </div>

            <asp:Button ID="btnFilter"
                runat="server"
                Text="Apply Filters"
                CssClass="filter-button"
                OnClick="btnFilter_Click" />

            <asp:Button ID="btnReset"
                runat="server"
                Text="Reset Filters"
                CssClass="filter-button"
                Style="margin-top: 10px; background: #64748b;"
                OnClick="btnReset_Click" />

        </aside>

        <!-- PACKAGE CARDS -->

        <div class="package-results">

            <asp:Label ID="lblPackageCount"
                runat="server"
                CssClass="text-muted"
                Style="display:block; margin-bottom:15px;" />

            <asp:Panel ID="pnlNoPackages"
                runat="server"
                CssClass="package-empty"
                Visible="false">
                No packages match your filters.
                Try changing your search or price range.
            </asp:Panel>

            <asp:Repeater ID="rptPackages" runat="server">

                <HeaderTemplate>
                    <div class="package-grid">
                </HeaderTemplate>

                <ItemTemplate>

                    <article class="package-card">

                        <asp:Image ID="imgPackage"
                            runat="server"
                            CssClass="package-image"
                            ImageUrl='<%# ResolveUrl(Convert.ToString(Eval("ImageUrl"))) %>'
                            AlternateText='<%# Eval("PackageName") %>' />

                        <div class="package-card-body">

                            <h3>
                                <%#: Eval("PackageName") %>
                            </h3>

                            <p class="package-description">
                                <%#: Eval("Description") %>
                            </p>

                            <div class="package-price">
                                <%# "R " + Convert.ToDecimal(Eval("Price")).ToString("N2") %>
                                <small> / package</small>
                            </div>

                            
<div class="package-card-actions">

    <asp:HyperLink
        ID="lnkPackage"
        runat="server"
        CssClass="package-action"
        NavigateUrl='<%# "PackageDetails.aspx?id=" + Eval("PackageID") %>'
        Text="View Package" />

    <asp:Button
        ID="btnAddPackageToCart"
        runat="server"
        Text="Add to Cart"
        CssClass="package-add-cart"
        CommandName="AddPackage"
        CommandArgument='<%# Eval("PackageID") %>'
        CausesValidation="false"
        OnCommand="btnAddPackageToCart_Command" />

</div>


                        </div>

                    </article>

                </ItemTemplate>

                <FooterTemplate>
                    </div>
                </FooterTemplate>

            </asp:Repeater>

        </div>

    </div>

</section>


    </div>

</asp:Content>
