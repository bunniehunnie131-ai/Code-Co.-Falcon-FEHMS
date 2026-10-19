<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Error404.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.Error404" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div class="error-page">
        <section class="error-card">

            <div class="error-art">
                <svg class="error-svg" viewBox="0 0 360 300" role="img" aria-label="A signpost showing 404">
                    <path class="ill-blob" d="M52,205 C14,150 58,66 138,74 C188,22 292,38 316,116 C348,146 340,226 290,250 C236,282 112,284 52,205 Z" />
                    <ellipse class="ill-ground" cx="180" cy="264" rx="156" ry="9" />
                    <path class="ill-pale" d="M70,262 C52,226 60,196 78,178 C86,206 90,236 84,262 Z" />
                    <path class="ill-sky" d="M84,262 C88,230 104,206 126,196 C124,226 112,248 96,262 Z" />
                    <path class="ill-pale" d="M296,262 C288,238 296,214 312,204 C318,226 314,246 306,262 Z" />
                    <path class="ill-sky" d="M284,262 C268,242 266,224 274,208 C288,222 292,242 292,262 Z" />
                    <rect class="ill-navy-dark" x="168" y="98" width="16" height="166" rx="3" />
                    <polygon class="ill-blue" points="92,100 246,100 282,130 246,160 92,160" />
                    <text class="ill-text" x="172" y="141">404</text>
                </svg>
            </div>

            <div class="error-body">
                <div class="error-code">404</div>
                <h1 class="error-title">Page Not Found</h1>
                <p class="error-text">
                    The page you're looking for could not be found.<br />
                        It may have been moved, renamed or no longer exists.
                </p>

                <div class="error-actions">
                    <a href="Home.aspx" class="btn-forte"><i class="bi bi-house-door-fill"></i> Go to Home Page</a>
                        <a href="Home.aspx" class="btn-outline-forte" onclick="history.back(); return false;"><i class="bi bi-arrow-left"></i> Go Back</a>
                </div>

                <div class="error-help">
                        <h2 class="error-help-title">Helpful Links</h2>
                        <ul class="error-links">
                            <li><a href="Home.aspx"><i class="bi bi-house-door-fill"></i> Home</a></li>
                            <li><a href="Catalogue.aspx"><i class="bi bi-grid-fill"></i> Catalogue</a></li>
                            <li><a href="HirePackages.aspx"><i class="bi bi-calendar-check-fill"></i> Hire Packages</a></li>
                            <li><a href="Contact.aspx"><i class="bi bi-telephone-fill"></i> Contact</a></li>
                        </ul>
                    </div>
            </div>

        </section>
    </div>

</asp:Content>
