<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>
        /* =========================================
           FEHMS - FORTE EVENTS ABOUT PAGE
           ========================================= */

        .about-page-wrapper {
            --forte-navy: #071827;
            --forte-dark: #0b1c2c;
            --forte-blue: #2457d6;
            --forte-blue-light: #3b6ff0;
            --forte-bg: #f5f7fb;
            --forte-border: #e2e8f0;
            --forte-text: #334155;
            --forte-muted: #64748b;
            --forte-white: #ffffff;

            background: var(--forte-bg);
            color: var(--forte-text);
            padding: 36px 0 55px;
            min-height: 100vh;
            font-family: 'Inter', Arial, sans-serif;
        }

        .about-page-wrapper,
        .about-page-wrapper * {
            box-sizing: border-box;
        }

        .about-page-wrapper .container {
            width: 100%;
            max-width: 1320px;
            margin: 0 auto;
            padding: 0 24px;
        }

        /* =========================================
           HERO SECTION
           ========================================= */

        .about-hero {
            position: relative;
            display: grid;
            grid-template-columns: minmax(0, 1.1fr) minmax(0, 0.9fr);
            align-items: center;
            gap: 42px;
            overflow: hidden;
            padding: 45px;
            margin-bottom: 30px;
            background: linear-gradient(
                120deg,
                var(--forte-navy) 0%,
                #102d4c 65%,
                var(--forte-blue) 100%
            );
            border-radius: 20px;
            box-shadow: 0 12px 30px rgba(7, 24, 39, 0.12);
        }

        .about-hero > div:first-child {
            position: relative;
            z-index: 1;
            min-width: 0;
        }

        .about-hero .eyebrow {
            display: inline-flex;
            align-items: center;
            padding: 8px 14px;
            margin-bottom: 19px;
            border: 1px solid rgba(255, 255, 255, 0.16);
            border-radius: 30px;
            background: rgba(255, 255, 255, 0.10);
            color: #c9d9ff;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

        .about-hero h1 {
            margin: 0 0 22px;
            color: var(--forte-white);
            font-family: 'Space Grotesk', 'Inter', Arial, sans-serif;
            font-size: clamp(30px, 3.4vw, 44px);
            font-weight: 800;
            line-height: 1.2;
            letter-spacing: -1.1px;
        }

        .about-hero h1 em {
            display: inline-block;
            margin-top: 12px;
            color: #b9ceff;
            font-family: 'Inter', Arial, sans-serif;
            font-size: 0.55em;
            font-style: normal;
            font-weight: 600;
            line-height: 1.6;
            letter-spacing: 0;
        }

        .about-hero p {
            margin: 0 0 15px;
            color: #dbe6f5;
            font-size: 14px;
            line-height: 1.95;
        }

        .about-hero p em {
            color: #ffffff;
            font-weight: 700;
        }

        /* Our Team button */

        .about-hero .btn-our-team {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            min-height: 46px;
            margin-top: 13px;
            padding: 13px 22px;
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 10px;
            background: #ffffff;
            color: var(--forte-navy);
            font-size: 13px;
            font-weight: 800;
            text-decoration: none;
            transition: background 0.2s ease,
                        color 0.2s ease,
                        transform 0.2s ease;
        }

        .about-hero .btn-our-team:hover {
            background: #dce7ff;
            color: var(--forte-navy);
            transform: translateY(-2px);
        }

        /* Hero image */

        .about-hero-image {
            position: relative;
            z-index: 1;
            width: 100%;
            min-width: 0;
            padding: 8px;
            border: 1px solid rgba(255, 255, 255, 0.18);
            border-radius: 19px;
            background: rgba(255, 255, 255, 0.10);
        }

        .about-hero-image img {
            display: block;
            width: 100%;
            height: 350px;
            object-fit: cover;
            object-position: center;
            border-radius: 13px;
            background: #e2e8f0;
        }

        /* =========================================
           OUR COMMITMENT
           ========================================= */

        .commitment-section {
            padding: 36px 32px;
            margin-bottom: 28px;
            border: 1px solid var(--forte-border);
            border-radius: 18px;
            background: #ffffff;
            text-align: center;
            box-shadow: 0 5px 18px rgba(15, 23, 42, 0.035);
        }

        .commitment-section > .eyebrow {
            margin-bottom: 12px;
            color: var(--forte-blue);
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .commitment-section > h2 {
            margin: 0 0 30px;
            color: var(--forte-navy);
            font-family: 'Space Grotesk', 'Inter', Arial, sans-serif;
            font-size: clamp(25px, 3vw, 32px);
            font-weight: 800;
            line-height: 1.3;
            letter-spacing: -0.6px;
        }

        .commitment-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 18px;
        }

        .commitment-item {
            min-width: 0;
            padding: 24px 18px;
            border: 1px solid #e8edf5;
            border-radius: 14px;
            background: #f9fbff;
            transition: border-color 0.2s ease,
                        box-shadow 0.2s ease,
                        transform 0.2s ease;
        }

        .commitment-item:hover {
            border-color: #c5d5ff;
            box-shadow: 0 8px 20px rgba(36, 87, 214, 0.07);
            transform: translateY(-3px);
        }

        .commitment-item-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 54px;
            height: 54px;
            margin: 0 auto 17px;
            border-radius: 15px;
            background: #eaf0ff;
            color: var(--forte-blue);
            font-size: 22px;
        }

        .commitment-item h4 {
            margin: 0 0 11px;
            color: var(--forte-navy);
            font-size: 14px;
            font-weight: 800;
            line-height: 1.5;
        }

        .commitment-item p {
            margin: 0;
            color: var(--forte-muted);
            font-size: 12px;
            line-height: 1.9;
        }

        /* =========================================
           MISSION, VISION AND VALUES
           ========================================= */

        .about-cards-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            align-items: stretch;
            gap: 22px;
            margin-bottom: 28px;
        }

        .about-card {
            position: relative;
            min-width: 0;
            padding: 30px 26px;
            overflow: hidden;
            border: 1px solid var(--forte-border);
            border-radius: 17px;
            background: #ffffff;
            box-shadow: 0 5px 18px rgba(15, 23, 42, 0.035);
            transition: border-color 0.2s ease,
                        box-shadow 0.2s ease,
                        transform 0.2s ease;
        }

        .about-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(
                90deg,
                var(--forte-blue),
                var(--forte-blue-light)
            );
        }

        .about-card:hover {
            border-color: #cbd8f5;
            box-shadow: 0 10px 25px rgba(15, 23, 42, 0.07);
            transform: translateY(-3px);
        }

        .about-card-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 54px;
            height: 54px;
            margin-bottom: 20px;
            border-radius: 15px;
            background: #edf3ff;
            color: var(--forte-blue);
            font-size: 23px;
        }

        .about-card h3 {
            margin: 0 0 14px;
            color: var(--forte-navy);
            font-family: 'Space Grotesk', 'Inter', Arial, sans-serif;
            font-size: 20px;
            font-weight: 800;
        }

        .about-card p {
            margin: 0;
            color: var(--forte-muted);
            font-size: 13px;
            line-height: 2;
        }

        /* Values list */

        .values-list {
            display: flex;
            flex-direction: column;
            gap: 13px;
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .values-list li {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            color: var(--forte-muted);
            font-size: 12px;
            line-height: 1.8;
        }

        .values-list li i {
            flex-shrink: 0;
            margin-top: 4px;
            color: var(--forte-blue);
            font-size: 14px;
        }

        /* =========================================
           BOTTOM BANNER
           ========================================= */

        .about-banner {
            display: flex;
            align-items: center;
            gap: 22px;
            padding: 30px 34px;
            border: 1px solid #dbe5fa;
            border-radius: 17px;
            background: linear-gradient(
                110deg,
                #edf3ff 0%,
                #f8faff 100%
            );
        }

        .about-banner-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            width: 60px;
            height: 60px;
            border-radius: 17px;
            background: var(--forte-blue);
            color: #ffffff;
            font-size: 24px;
            box-shadow: 0 7px 15px rgba(36, 87, 214, 0.18);
        }

        .about-banner h3 {
            margin: 0 0 9px;
            color: var(--forte-navy);
            font-family: 'Space Grotesk', 'Inter', Arial, sans-serif;
            font-size: 20px;
            font-weight: 800;
        }

        .about-banner p {
            margin: 0;
            color: var(--forte-muted);
            font-size: 13px;
            line-height: 1.9;
        }

        /* =========================================
           TABLET
           ========================================= */

        @media (max-width: 1050px) {
            .about-hero {
                grid-template-columns: minmax(0, 1fr) minmax(0, 0.8fr);
                gap: 25px;
                padding: 32px;
            }

            .about-hero-image img {
                height: 310px;
            }

            .commitment-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .about-cards-grid {
                gap: 15px;
            }

            .about-card {
                padding: 26px 20px;
            }
        }

        /* =========================================
           MOBILE
           ========================================= */

        @media (max-width: 700px) {
            .about-page-wrapper {
                padding: 20px 0 35px;
            }

            .about-page-wrapper .container {
                padding: 0 14px;
            }

            .about-hero {
                grid-template-columns: minmax(0, 1fr);
                gap: 25px;
                padding: 25px 21px;
                border-radius: 15px;
                margin-bottom: 20px;
            }

            .about-hero h1 {
                font-size: 31px;
                letter-spacing: -0.7px;
            }

            .about-hero h1 em {
                font-size: 0.57em;
            }

            .about-hero p {
                font-size: 13px;
                line-height: 1.85;
            }

            .about-hero-image img {
                height: 260px;
            }

            .commitment-section {
                padding: 28px 17px;
                margin-bottom: 20px;
                border-radius: 15px;
            }

            .commitment-section > h2 {
                font-size: 25px;
                margin-bottom: 23px;
            }

            .commitment-grid {
                grid-template-columns: minmax(0, 1fr);
                gap: 13px;
            }

            .commitment-item {
                padding: 22px 18px;
            }

            .commitment-item p {
                max-width: 360px;
                margin: 0 auto;
            }

            .about-cards-grid {
                grid-template-columns: minmax(0, 1fr);
                gap: 17px;
                margin-bottom: 20px;
            }

            .about-card {
                padding: 27px 22px;
                border-radius: 15px;
            }

            .about-banner {
                align-items: flex-start;
                gap: 15px;
                padding: 23px 19px;
                border-radius: 15px;
            }

            .about-banner-icon {
                width: 47px;
                height: 47px;
                border-radius: 13px;
                font-size: 19px;
            }

            .about-banner h3 {
                font-size: 17px;
                line-height: 1.5;
            }

            .about-banner p {
                font-size: 12px;
            }
        }

        @media (max-width: 380px) {
            .about-hero h1 {
                font-size: 27px;
            }

            .about-hero {
                padding: 23px 17px;
            }

            .about-banner {
                flex-direction: column;
            }
        }

        /* Reduced motion accessibility */

        @media (prefers-reduced-motion: reduce) {
            .about-page-wrapper *,
            .about-page-wrapper *::before,
            .about-page-wrapper *::after {
                transition: none !important;
                animation: none !important;
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Forte.css" rel="stylesheet" />

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
