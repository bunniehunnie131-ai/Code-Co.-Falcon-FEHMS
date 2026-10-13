<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Forte.css" rel="stylesheet" />

      <div class="how-page">

        <!-- ================= INTRO ================= -->
        <section class="how-hero">
            <div class="how-eyebrow">How it works</div>
            <h1>Hiring with Forte Events, step by step</h1>
            <p>
                Create an account, choose what you need, place your order and pay to confirm it.
                We deliver, set up and collect &mdash; you enjoy your event.
            </p>
            <div class="how-actions">
                <a href="Registration.aspx" class="btn-forte"><i class="bi bi-person-plus"></i> Create an account</a>
                <a href="Login.aspx" class="btn-outline-forte"><i class="bi bi-box-arrow-in-right"></i> Log in</a>
            </div>
        </section>


        <!-- ================= STEPS ================= -->
        <section class="how-section">
            <div class="how-section-head">
                <h2>Five simple steps</h2>
            </div>

            <div class="how-steps">

                <div class="how-step">
                    <div class="how-step-marker"><div class="how-step-num">1</div></div>
                    <div class="how-step-body">
                        <h3 class="how-step-title">Create your account</h3>
                        <p>Register with your correct details and accept our Terms &amp; Conditions. You only need to do this once.</p>
                        <a href="Registration.aspx" class="how-step-link">Register <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>

                <div class="how-step">
                    <div class="how-step-marker"><div class="how-step-num">2</div></div>
                    <div class="how-step-body">
                        <h3 class="how-step-title">Log in</h3>
                        <p>Sign in with your email address and password to start a booking and to follow your orders.</p>
                        <a href="Login.aspx" class="how-step-link">Log in <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>

                <div class="how-step">
                    <div class="how-step-marker"><div class="how-step-num">3</div></div>
                    <div class="how-step-body">
                        <h3 class="how-step-title">Choose your items and place your order</h3>
                        <p>Browse the catalogue, add what you need to your cart, then enter your event date and location. Check your order summary and submit it.</p>
                        <a href="Catalogue.aspx" class="how-step-link">Browse the catalogue <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>

                <div class="how-step how-step-key">
                    <div class="how-step-marker"><div class="how-step-num">4</div></div>
                    <div class="how-step-body">
                        <h3 class="how-step-title">Pay to confirm your booking <span class="how-tag">Important</span></h3>
                        <p>Your order is only counted once it has been paid. Until then it stays <span class="how-pill how-pill-pending">Pending</span> and we cannot guarantee your items or your event date. When your payment is received, the status changes to <span class="how-pill how-pill-confirmed">Confirmed</span></p>
                        <p class="how-note">Payments, changes and cancellations are covered in our <a href="TermsAndConditions.aspx">Terms &amp; Conditions</a>.</p>
                    </div>
                </div>

                <div class="how-step">
                    <div class="how-step-marker"><div class="how-step-num">5</div></div>
                    <div class="how-step-body">
                        <h3 class="how-step-title">We deliver, you celebrate, we collect</h3>
                        <p>On your event date we deliver and set up your items, and we collect them again afterwards. You can follow your order at any time.</p>
                        <a href="TrackOrder.aspx" class="how-step-link">Track my order <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>

            </div>
        </section>


        <!-- ================= SERVICES ================= -->
        <section class="how-section">
            <div class="how-section-head">
                <h2>What you can hire</h2>
                <p>Everything for your event, from one supplier.</p>
            </div>

            <div class="how-card-grid">

                <div class="how-card">
                    <div class="how-card-icon"><i class="fa-solid fa-tent"></i></div>
                    <h3>Tents &amp; Marquees</h3>
                    <p>Frame tents and marquees for any weather.</p>
                </div>

                <div class="how-card">
                    <div class="how-card-icon"><i class="fa-solid fa-chair"></i></div>
                    <h3>Tables &amp; Chairs</h3>
                    <p>Banquet tables and chairs for every guest.</p>
                </div>

                <div class="how-card">
                    <div class="how-card-icon"><i class="fa-solid fa-wand-magic-sparkles"></i></div>
                    <h3>D&eacute;cor &amp; Lighting</h3>
                    <p>Centrepieces, backdrops and lighting for your theme.</p>
                </div>

                <div class="how-card">
                    <div class="how-card-icon"><i class="fa-solid fa-music"></i></div>
                    <h3>Sound, Audio &amp; DJ</h3>
                    <p>Sound systems, microphones and DJ entertainment.</p>
                </div>

                <div class="how-card">
                    <div class="how-card-icon"><i class="fa-solid fa-utensils"></i></div>
                    <h3>Catering Equipment</h3>
                    <p>Everything you need to serve your guests.</p>
                </div>

                <div class="how-card">
                    <div class="how-card-icon"><i class="fa-solid fa-truck"></i></div>
                    <h3>Delivery &amp; Set-up</h3>
                    <p>On-time delivery, set-up and collection.</p>
                </div>

            </div>
        </section>


        <!-- ================= CLOSING ================= -->
        <section class="how-section">
            <div class="how-cta">
                <h2>Ready to get started?</h2>
                <p>Create your account and book your event today. Questions? We are happy to help.</p>
                <div class="how-actions">
                    <a href="Registration.aspx" class="btn-forte"><i class="bi bi-person-plus"></i> Create an account</a>
                    <a href="Contact.aspx" class="btn-outline-forte"><i class="bi bi-envelope"></i> Contact us</a>
                </div>
            </div>
        </section>

    </div>

</asp:Content>
