<%@ Page Title="Package Details"
    Language="C#"
    MasterPageFile="~/Presentation/SystemLayout.Master"
    AutoEventWireup="true"
    CodeBehind="PackageDetails.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.PackageDetails" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <style>
        .package-details-page {
            padding: 20px 0 45px;
        }

        .details-back {
            display: inline-block;
            margin-bottom: 22px;
            color: #2457d6;
            text-decoration: none;
            font-weight: 600;
        }

        .details-back:hover {
            color: #173da3;
        }

        .details-card {
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
            gap: 35px;
            background: #ffffff;
            border: 1px solid #e5eaf1;
            border-radius: 18px;
            padding: 30px;
            box-shadow: 0 12px 35px rgba(7, 24, 39, 0.08);
        }

        .details-image {
            width: 100%;
            height: 420px;
            object-fit: cover;
            border-radius: 13px;
            background: #edf1f6;
        }

        .details-info {
            padding: 10px 0;
        }

        .details-label {
            display: inline-block;
            background: #eaf0ff;
            color: #2457d6;
            border-radius: 20px;
            padding: 7px 13px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 18px;
        }

        .details-title {
            color: #071827;
            font-size: 34px;
            font-weight: 750;
            line-height: 1.2;
            margin-bottom: 18px;
        }

        .details-description {
            color: #64748b;
            font-size: 16px;
            line-height: 1.8;
            margin-bottom: 25px;
        }

        .details-price-label {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .details-price {
            display: block;
            color: #2457d6;
            font-size: 32px;
            font-weight: 750;
            margin-bottom: 20px;
        }

        .details-status {
            display: block;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .status-available {
            color: #15803d;
        }

        .status-unavailable {
            color: #b91c1c;
        }

        .details-button {
            display: inline-block;
            background: #2457d6;
            color: #ffffff;
            text-decoration: none;
            text-align: center;
            padding: 13px 24px;
            border-radius: 9px;
            font-weight: 600;
            border: none;
        }

        .details-button:hover {
            background: #173da3;
            color: #ffffff;
        }

        .details-message {
            padding: 25px;
            background: #ffffff;
            border: 1px solid #e5eaf1;
            border-radius: 12px;
            color: #64748b;
        }

        @media (max-width: 768px) {
            .details-card {
                grid-template-columns: 1fr;
                padding: 18px;
                gap: 22px;
            }

            .details-image {
                height: 280px;
            }

            .details-title {
                font-size: 27px;
            }
        }

.details-actions {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    margin-top: 10px;
}

.details-add-cart {
    cursor: pointer;
}

.details-add-cart:hover {
    background: #173da3;
}

    </style>

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="package-details-page">

        <a href="HirePackages.aspx" class="details-back">
            &#8592; Back to Hire Packages
        </a>

        <asp:Panel ID="pnlDetails"
            runat="server"
            Visible="false">

            <div class="details-card">

                <div>
                    <asp:Image ID="imgPackage"
                        runat="server"
                        CssClass="details-image"
                        AlternateText="Event hire package" />
                </div>

                <div class="details-info">

                    <asp:Label ID="lblCategory"
                        runat="server"
                        CssClass="details-label" />

                    <h1 class="details-title">
                        <asp:Label ID="lblPackageName"
                            runat="server" />
                    </h1>

                    <p class="details-description">
                        <asp:Label ID="lblDescription"
                            runat="server" />
                    </p>

                    <div class="details-price-label">
                        Package price
                    </div>

                    <asp:Label ID="lblPrice"
                        runat="server"
                        CssClass="details-price" />

                    <asp:Label ID="lblAvailability"
                        runat="server"
                        CssClass="details-status" />

                    
<div class="details-actions">
    <a href="HirePackages.aspx"
        class="details-button">
        Browse More Packages
    </a>

    <asp:Button
        ID="btnAddPackageToCart"
        runat="server"
        Text="Add to Cart"
        CssClass="details-button details-add-cart"
        OnClick="btnAddPackageToCart_Click"
        CausesValidation="false" />
</div>


                </div>

            </div>

        </asp:Panel>

        <asp:Panel ID="pnlNotFound"
            runat="server"
            CssClass="details-message"
            Visible="false">

            <h2>Package Not Found</h2>

            <p>
                We could not find that package. It may have been
                removed or the package link may be incorrect.
            </p>

            <a href="HirePackages.aspx"
                class="details-button">
                Return to Hire Packages
            </a>

        </asp:Panel>

    </div>

</asp:Content>
