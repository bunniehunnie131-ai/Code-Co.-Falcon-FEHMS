<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Error403.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.Error403" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="error-page">
        <section class="error-card">

            <div class="error-art">
                <svg class="error-svg" viewBox="0 0 360 300" role="img" aria-label="A padlock with a no-entry sign">
                    <path class="ill-blob" d="M52,205 C14,150 58,66 138,74 C188,22 292,38 316,116 C348,146 340,226 290,250 C236,282 112,284 52,205 Z" />
                    <ellipse class="ill-ground" cx="180" cy="264" rx="156" ry="9" />
                    <path class="ill-shackle" d="M140,140 V112 A40,40 0 0 1 220,112 V140" />
                    <rect class="ill-blue" x="108" y="132" width="144" height="122" rx="16" />
                    <circle class="ill-navy-dark" cx="180" cy="184" r="14" />
                    <rect class="ill-navy-dark" x="175" y="190" width="10" height="30" rx="4" />
                    <circle class="ill-badge" cx="242" cy="226" r="40" />
                    <rect class="ill-white" x="220" y="219" width="44" height="14" rx="7" />
                </svg>
            </div>

            <div class="error-body">
                <div class="error-code">403</div>
                <h1 class="error-title">Access Denied</h1>
                <p class="error-text">
                    You don't have permission to access this page.<br />
                        This area is restricted to authorised users only.
                </p>

                <div class="error-actions">
                    <asp:HyperLink ID="lnkDashboard" runat="server" CssClass="btn-forte" NavigateUrl="Login.aspx"><i class="bi bi-house-door-fill"></i> Go to Dashboard</asp:HyperLink>
                        <a href="Home.aspx" class="btn-outline-forte" onclick="history.back(); return false;"><i class="bi bi-arrow-left"></i> Go Back</a>
                </div>

                <div class="error-help">
                        <h2 class="error-help-title">Need Help?</h2>
                        <ul class="error-links">
                            <li><a href="Contact.aspx"><i class="bi bi-person-fill"></i> Contact Support</a></li>
                            <li><a href="mailto:info@codeandcofalcon.co.za"><i class="bi bi-envelope-fill"></i> Email Us</a></li>
                            <li><a href="HowItWorks.aspx"><i class="bi bi-question-circle-fill"></i> View Help Centre</a></li>
                        </ul>
                    </div>
            </div>

        </section>
    </div>

</asp:Content>

