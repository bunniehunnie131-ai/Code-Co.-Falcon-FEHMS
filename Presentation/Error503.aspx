<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Error503.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.Error503" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div class="error-page">
        <section class="error-card">

            <div class="error-art">
                <svg class="error-svg" viewBox="0 0 360 300" role="img" aria-label="A gear behind a roadworks barrier">
                    <defs>
                        <pattern id="barrierStripes" width="26" height="26" patternUnits="userSpaceOnUse" patternTransform="rotate(45)">
                            <rect class="ill-blue" width="13" height="26" />
                            <rect class="ill-white" x="13" width="13" height="26" />
                        </pattern>
                    </defs>
                    <path class="ill-blob" d="M52,205 C14,150 58,66 138,74 C188,22 292,38 316,116 C348,146 340,226 290,250 C236,282 112,284 52,205 Z" />
                    <ellipse class="ill-ground" cx="180" cy="264" rx="156" ry="9" />
                    <g class="ill-steel">
                        <rect x="153" y="38" width="34" height="40" rx="6" />
                        <rect x="153" y="38" width="34" height="40" rx="6" transform="rotate(45 170 128)" />
                        <rect x="153" y="38" width="34" height="40" rx="6" transform="rotate(90 170 128)" />
                        <rect x="153" y="38" width="34" height="40" rx="6" transform="rotate(135 170 128)" />
                        <rect x="153" y="38" width="34" height="40" rx="6" transform="rotate(180 170 128)" />
                        <rect x="153" y="38" width="34" height="40" rx="6" transform="rotate(225 170 128)" />
                        <rect x="153" y="38" width="34" height="40" rx="6" transform="rotate(270 170 128)" />
                        <rect x="153" y="38" width="34" height="40" rx="6" transform="rotate(315 170 128)" />
                        <circle cx="170" cy="128" r="64" />
                    </g>
                    <circle class="ill-pale" cx="170" cy="128" r="36" />
                    <circle class="ill-blob" cx="170" cy="128" r="22" />
                    <rect class="ill-navy-dark" x="78" y="200" width="18" height="64" rx="3" />
                    <rect class="ill-navy-dark" x="244" y="200" width="18" height="64" rx="3" />
                    <rect class="ill-outline" x="62" y="208" width="216" height="34" rx="4" fill="url(#barrierStripes)" />
                    <polygon class="ill-orange" points="292,262 304,178 324,178 336,262" />
                    <polygon class="ill-white" points="299,207 329,207 331,220 297,220" />
                    <rect class="ill-navy-dark" x="282" y="258" width="64" height="10" rx="3" />
                </svg>
            </div>

            <div class="error-body">
                <div class="error-code">503</div>
                <h1 class="error-title">Service Unavailable</h1>
                <p class="error-text">
                    FEHMS is temporarily unavailable.<br />
                        We are performing maintenance to improve<br />
                        your experience. Please try again later.
                </p>

                <div class="error-actions">
                    <asp:HyperLink ID="lnkTryAgain" runat="server" CssClass="btn-forte" NavigateUrl="Home.aspx"><i class="bi bi-clock"></i> Try Again Later</asp:HyperLink>
                        <a href="Home.aspx" class="btn-outline-forte"><i class="bi bi-house-door-fill"></i> Go to Home Page</a>
                </div>

                <div class="error-notice">
                        <span class="error-notice-icon"><i class="bi bi-info-lg"></i></span>
                        <div>
                            <strong>Estimated Downtime</strong>
                            <span>We'll be back shortly. Thank you for your patience.</span>
                        </div>
                    </div>
            </div>

        </section>
    </div>

</asp:Content>

