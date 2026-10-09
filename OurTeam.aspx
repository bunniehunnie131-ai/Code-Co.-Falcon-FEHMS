<%@ Page Title="Our Team" Language="C#" MasterPageFile="~/Presentation/Site1.Master" AutoEventWireup="true" CodeBehind="OurTeam.aspx.cs" Inherits="FEHMS_Code_Co_Falcon.Presentation.OurTeam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        :root {
            --ccf-navy: #0F2438;
            --ccf-blue: #2563EB;
            --ccf-white: #FFFFFF;
            --ccf-page-bg: #F7F9FC;
            --ccf-border: #E5E9F0;
            --ccf-dark-grey: #374151;
            --ccf-medium-grey: #6B7280;
            --ccf-icon-bg: #EFF6FF;
        }

        .team-page-wrapper {
            background-color: var(--ccf-page-bg);
            padding: 30px 0;
        }

        .team-header {
            margin-bottom: 40px;
        }

        .team-header .eyebrow {
            color: var(--ccf-blue);
            font-weight: 700;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .team-header h1 {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--ccf-navy);
            margin-bottom: 12px;
        }

        .team-header p {
            font-size: 1rem;
            color: var(--ccf-medium-grey);
            max-width: 560px;
            line-height: 1.6;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
        }

        @media (max-width: 1100px) {
            .team-grid { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 600px) {
            .team-grid { grid-template-columns: 1fr; }
        }

        .team-card {
            background-color: var(--ccf-white);
            border: 1px solid var(--ccf-border);
            border-radius: 10px;
            overflow: hidden;
            text-align: center;
        }

        .team-card-photo {
            width: 100%;
            aspect-ratio: 1 / 1;
            background-color: var(--ccf-icon-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--ccf-blue);
            font-size: 3rem;
            overflow: hidden;
        }

        .team-card-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .team-card-info {
            padding: 18px;
        }

        .team-card-info h3 {
            color: var(--ccf-navy);
            font-weight: 700;
            font-size: 1.05rem;
            margin: 0 0 4px 0;
        }

        .team-card-info .role {
            color: var(--ccf-blue);
            font-weight: 600;
            font-size: 0.85rem;
            margin: 0 0 10px 0;
        }

        .team-card-info .bio {
            color: var(--ccf-medium-grey);
            font-size: 0.85rem;
            line-height: 1.5;
            margin: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="team-page-wrapper">
        <div class="container">

            <div class="team-header">
                <div class="eyebrow">Meet The Team</div>
                <h1>The People Behind Code &amp; Co. Falcon</h1>
                <p>We're a small team passionate about making your events unforgettable, from planning to pack-up.</p>
            </div>

            <!--
                TEAM MEMBERS
                For each card below, edit these 4 things:
                  1. src="~/Images/Team/EDIT_ME.jpg"  -> your actual filename
                  2. alt="EDIT_ME Full Name"           -> the person's name (for accessibility)
                  3. <h3>EDIT_ME Full Name</h3>         -> the person's name (displayed)
                  4. <p class="role">EDIT_ME Role</p>   -> their role/title
                  5. <p class="bio">EDIT_ME bio</p>     -> short bio, or delete this line entirely if you don't want one

                To add MORE team members: copy an entire <div class="team-card">...</div> block and paste it
                right before the closing </div> of .team-grid, then edit as above.

                To REMOVE a team member: delete their entire <div class="team-card">...</div> block.
            -->
            <div class="team-grid">

                <div class="team-card">
                    <div class="team-card-photo">
                        <img src="/Images/Team/Fortune.jpeg" alt="Fortune Makhubela" />
                    </div>
                    <div class="team-card-info">
                        <h3>Fortune Makhubela</h3>
                        <p class="role">Events Manager</p>
                        <p class="bio">Oversees the entire event, coordinates the team, manages the budget, and ensures the event runs smoothly.</p>
                    </div>
                </div>

                <div class="team-card">
                    <div class="team-card-photo">
                        <img src="/Images/Team/Simanyene.jpeg" alt="Simanyene Bobo" />
                    </div>
                    <div class="team-card-info">
                        <h3>Simanyene Bobo</h3>
                        <p class="role">Event Coordinator</p>
                        <p class="bio">Handles event planning, scheduling, bookings and communicates with clients, suppliers and staff.</p>
                    </div>
                </div>

                <div class="team-card">
                    <div class="team-card-photo">
                        <img src="/Images/Team/Ziyanda.jpeg" alt="Ziyanda Sodiya" />
                    </div>
                    <div class="team-card-info">
                        <h3>Ziyanda Sodiya</h3>
                        <p class="role">Social Media Manager</p>
                        <p class="bio">Manages the company's social media presence, creates content, and engages with the online community.</p>
                    </div>
                </div>

                <div class="team-card">
                    <div class="team-card-photo">
                        <img src="/Images/Team/Yandisa.jpeg" alt="Yandisa Thunzana" />
                    </div>
                    <div class="team-card-info">
                        <h3>Yandisa Thunzana</h3>
                        <p class="role">Finance Director</p>
                        <p class="bio">Manages the company's finances, budgeting, and financial planning.</p>
                    </div>
                </div>

                <div class="team-card">
                    <div class="team-card-photo">
                        <img src="/Images/Team/Sihle.jpeg" alt="Sihle Maishe" />
                    </div>
                    <div class="team-card-info">
                        <h3>Sihle Maishe</h3>
                        <p class="role">Operations Manager</p>
                        <p class="bio">Oversees daily operations, ensures efficient workflow, and manages operational staff.</p>
                    </div>
                </div>

                <div class="team-card">
                    <div class="team-card-photo">
                        <img src="/Images/Team/Quinton.jpeg" alt="Quinton Chiloane" />
                    </div>
                    <div class="team-card-info">
                        <h3>Quinton Chiloane</h3>
                        <p class="role">Logistics Manager</p>
                        <p class="bio">Manages logistics, transportation, and ensures timely delivery of materials and services.</p>
                    </div>
                </div>

                <div class="team-card">
                    <div class="team-card-photo">
                        <img src="/Images/Team/Viwe.jpeg" alt="Viwe Lalala" />
                    </div>
                    <div class="team-card-info">
                        <h3>Viwe Lalala</h3>
                        <p class="role">Marketing Manager</p>
                        <p class="bio">Oversees marketing strategies, campaigns, and brand management.</p>
                    </div>
                </div>

            </div>

        </div>
    </div>
</asp:Content>

