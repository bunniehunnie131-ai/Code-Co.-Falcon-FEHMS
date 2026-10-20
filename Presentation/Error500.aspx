<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Error500.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.Error500" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="error-page">
        <section class="error-card">

            <div class="error-art">
                <svg class="error-svg" viewBox="0 0 360 300" role="img" aria-label="A server with a warning sign">
                    <path class="ill-blob" d="M52,205 C14,150 58,66 138,74 C188,22 292,38 316,116 C348,146 340,226 290,250 C236,282 112,284 52,205 Z" />
                    <ellipse class="ill-ground" cx="180" cy="264" rx="156" ry="9" />
                    <rect class="ill-navy" x="64" y="82" width="180" height="54" rx="10" />
                    <rect class="ill-navy" x="64" y="142" width="180" height="54" rx="10" />
                    <rect class="ill-navy" x="64" y="202" width="180" height="54" rx="10" />
                    <circle class="ill-sky" cx="88" cy="109" r="5" /><circle class="ill-orange" cx="106" cy="109" r="5" />
                    <circle class="ill-sky" cx="88" cy="169" r="5" /><circle class="ill-orange" cx="106" cy="169" r="5" />
                    <circle class="ill-sky" cx="88" cy="229" r="5" /><circle class="ill-orange" cx="106" cy="229" r="5" />
                    <rect class="ill-navy-dark" x="140" y="106" width="84" height="7" rx="3" />
                    <rect class="ill-navy-dark" x="140" y="166" width="84" height="7" rx="3" />
                    <rect class="ill-navy-dark" x="140" y="226" width="84" height="7" rx="3" />
                    <polygon class="ill-warning" points="254,170 308,254 200,254" />
                    <rect class="ill-white" x="248" y="196" width="12" height="32" rx="6" />
                    <circle class="ill-white" cx="254" cy="240" r="6" />
                </svg>
            </div>

            <div class="error-body">
                <div class="error-code">500</div>
                <h1 class="error-title">Something Went Wrong</h1>
                <p class="error-text">
                    An unexpected error occurred on our server.<br />
                        Please try again later. If the problem persists,<br />
                        contact our support team.
                </p>

                <div class="error-actions">
                    <asp:HyperLink ID="lnkTryAgain" runat="server" CssClass="btn-forte" NavigateUrl="Home.aspx"><i class="bi bi-arrow-clockwise"></i> Try Again</asp:HyperLink>
                        <a href="Home.aspx" class="btn-outline-forte"><i class="bi bi-house-door-fill"></i> Go to Home Page</a>
                </div>

                <div class="error-help">
                        <h2 class="error-help-title">You can also</h2>
                        <ul class="error-links">
                            <li><a href="Home.aspx"><i class="bi bi-house-door-fill"></i> Return to Home</a></li>
                            <li><a href="Contact.aspx"><i class="bi bi-person-fill"></i> Contact Support</a></li>
                            <li><a href="mailto:info@codeandcofalcon.co.za"><i class="bi bi-envelope-fill"></i> Email Us</a></li>
                            <li><a href="HowItWorks.aspx"><i class="bi bi-question-circle-fill"></i> View Help Centre</a></li>
                        </ul>
                    </div>
            </div>

        </section>
    </div>

</asp:Content>
