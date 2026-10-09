<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="about-page-wrapper">
        <div class="container">

            <!-- HERO -->
            <div class="about-hero">
                <div>
                    <div class="eyebrow">Who we are</div>
                    <h1>FORTE EVENTS HIRE & DECOR<br /><em>Your Vision. Our Craft. Unforgettable Events.</em></h1>
                    <p>Forte Events Hire & Decor brings your celebrations to life with premium equipment, elegant decor, and a team that genuinely cares about getting every detail right. From weddings to corporate functions, we handle the setup so you can focus on the moments that matter.</p>
                    <p>We believe every event tells a story, and we are here to help you tell yours,<em> elegantly.</em></p>
                    <a href="~/Presentation/OurTeam.aspx" runat="server" class="btn-our-team">
                        <i class="fas fa-people-group"></i> Our Team
                    </a>
                </div>
                <div class="about-hero-image">
                    <asp:Image ID="imgTeam" runat="server" ImageUrl="~/Images/OurTeam.jpg" AlternateText="Forte Events team" />
                </div>
            </div>

            <!-- OUR COMMITMENT -->
            <div class="commitment-section">
                <div class="eyebrow">&mdash; Our Commitment &mdash;</div>
                <h2>Quality. Reliability. Excellence.</h2>

                <div class="commitment-grid">
                    <div class="commitment-item">
                        <div class="commitment-item-icon"><i class="fas fa-award"></i></div>
                        <h4>Quality Equipment</h4>
                        <p>We offer well-maintained, modern equipment and d&eacute;cor to make your event exceptional.</p>
                    </div>

                    <div class="commitment-item">
                        <div class="commitment-item-icon"><i class="fas fa-shield-halved"></i></div>
                        <h4>Reliable Service</h4>
                        <p>Our team ensures on-time delivery, setup and collection so you can enjoy a stress-free event.</p>
                    </div>

                    <div class="commitment-item">
                        <div class="commitment-item-icon"><i class="fas fa-users"></i></div>
                        <h4>Customer Focused</h4>
                        <p>Your satisfaction is our priority. We work closely with you to bring your vision to life.</p>
                    </div>

                    <div class="commitment-item">
                        <div class="commitment-item-icon"><i class="fas fa-thumbs-up"></i></div>
                        <h4>Affordable Pricing</h4>
                        <p>High-quality event solutions at competitive prices to suit every budget.</p>
                    </div>
                </div>
            </div>

            <!-- MISSION / VISION / VALUES -->
            <div class="about-cards-grid">
                <div class="about-card">
                    <div class="about-card-icon"><i class="fas fa-bullseye"></i></div>
                    <h3>Our Mission</h3>
                    <p>To provide reliable, affordable and high-quality event hire solutions that exceed expectations and create memorable experiences.</p>
                </div>

                <div class="about-card">
                    <div class="about-card-icon"><i class="fas fa-eye"></i></div>
                    <h3>Our Vision</h3>
                    <p>To be the leading event hire company in South Africa, known for innovation, quality and outstanding customer service.</p>
                </div>

                <div class="about-card">
                    <div class="about-card-icon"><i class="fas fa-gem"></i></div>
                    <h3>Our Values</h3>
                    <ul class="values-list">
                        <li><i class="fas fa-circle-check"></i> Integrity in everything we do</li>
                        <li><i class="fas fa-circle-check"></i> Excellence in service delivery</li>
                        <li><i class="fas fa-circle-check"></i> Passion for our clients and their events</li>
                        <li><i class="fas fa-circle-check"></i> Teamwork and respect</li>
                    </ul>
                </div>
            </div>

            <!-- BANNER -->
            <div class="about-banner">
                <div class="about-banner-icon"><i class="fas fa-heart"></i></div>
                <div>
                    <h3>More Than Just Equipment</h3>
                    <p>We don't just hire out equipment &ndash; we partner with you to bring your vision to life. Our team is committed to delivering quality, on time, every time.</p>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
