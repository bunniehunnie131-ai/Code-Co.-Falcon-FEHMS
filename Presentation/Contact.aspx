<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

 <style>
     /* =========================================
        FEHMS - FORTE EVENTS CONTACT PAGE
        ========================================= */

     .contact-page-wrapper {
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

     .contact-page-wrapper,
     .contact-page-wrapper * {
         box-sizing: border-box;
     }

     .contact-page-wrapper .container {
         width: 100%;
         max-width: 1320px;
         margin: 0 auto;
         padding: 0 24px;
     }

     /* Page heading */

     .contact-header {
         position: relative;
         overflow: hidden;
         background: linear-gradient(
             120deg,
             var(--forte-navy) 0%,
             #102d4c 65%,
             var(--forte-blue) 100%
         );
         border-radius: 20px;
         padding: 48px 46px;
         margin-bottom: 30px;
         box-shadow: 0 12px 30px rgba(7, 24, 39, 0.12);
     }

     .contact-header::after {
         content: "";
         position: absolute;
         width: 260px;
         height: 260px;
         right: -65px;
         top: -100px;
         border: 40px solid rgba(255, 255, 255, 0.06);
         border-radius: 50%;
         pointer-events: none;
     }

     .contact-header .eyebrow {
         display: inline-flex;
         align-items: center;
         gap: 8px;
         color: #c9d9ff;
         background: rgba(255, 255, 255, 0.10);
         border: 1px solid rgba(255, 255, 255, 0.15);
         padding: 8px 14px;
         border-radius: 30px;
         font-size: 12px;
         font-weight: 800;
         text-transform: uppercase;
         letter-spacing: 1.5px;
         margin-bottom: 17px;
     }

     .contact-header h1 {
         color: #ffffff;
         font-family: 'Space Grotesk', 'Inter', Arial, sans-serif;
         font-size: clamp(32px, 4vw, 48px);
         font-weight: 800;
         line-height: 1.12;
         letter-spacing: -1.2px;
         margin: 0 0 18px;
         position: relative;
         z-index: 1;
     }

     .contact-header p {
         color: #dbe6f5;
         max-width: 690px;
         font-size: 15px;
         line-height: 1.9;
         margin: 0;
         position: relative;
         z-index: 1;
     }

     /* Main contact layout */

     .contact-content {
         display: grid;
         grid-template-columns: minmax(0, 0.88fr) minmax(0, 1.35fr);
         align-items: start;
         gap: 26px;
     }

     .contact-info-section,
     .contact-form-container {
         min-width: 0;
         background: var(--forte-white);
         border: 1px solid var(--forte-border);
         border-radius: 18px;
         padding: 28px;
         box-shadow: 0 5px 18px rgba(15, 23, 42, 0.035);
     }

     /* Contact information */

     .contact-info-section {
         display: flex;
         flex-direction: column;
         gap: 0;
     }

     .contact-info-item {
         display: flex;
         align-items: flex-start;
         gap: 15px;
         padding: 19px 0;
         border-bottom: 1px solid #edf1f6;
     }

     .contact-info-item:first-child {
         padding-top: 4px;
     }

     .contact-info-item-icon {
         width: 46px;
         height: 46px;
         min-width: 46px;
         display: flex;
         align-items: center;
         justify-content: center;
         background: #edf3ff;
         color: var(--forte-blue);
         border-radius: 13px;
         font-size: 18px;
     }

     .contact-info-item-content {
         min-width: 0;
         padding-top: 2px;
     }

     .contact-info-item-label {
         color: var(--forte-navy);
         font-size: 14px;
         font-weight: 800;
         margin-bottom: 7px;
     }

     .contact-info-item-value {
         color: var(--forte-muted);
         font-size: 13px;
         line-height: 1.9;
         overflow-wrap: anywhere;
     }

     .contact-info-item-value a {
         display: block;
         width: fit-content;
         max-width: 100%;
         color: var(--forte-blue);
         text-decoration: none;
         transition: color 0.2s ease;
     }

     .contact-info-item-value a:hover {
         color: var(--forte-navy);
         text-decoration: underline;
     }

     /* Immediate assistance */

     .emergency-box {
         display: flex;
         align-items: flex-start;
         gap: 14px;
         margin-top: 23px;
         padding: 20px;
         background: #f0f5ff;
         border: 1px solid #d9e5ff;
         border-radius: 14px;
     }

     .emergency-box-icon {
         width: 42px;
         height: 42px;
         min-width: 42px;
         display: flex;
         align-items: center;
         justify-content: center;
         color: #ffffff;
         background: var(--forte-blue);
         border-radius: 12px;
         font-size: 17px;
     }

     .emergency-box h4 {
         color: var(--forte-navy);
         font-size: 14px;
         font-weight: 800;
         margin: 1px 0 8px;
     }

     .emergency-box p {
         color: var(--forte-muted);
         font-size: 12px;
         line-height: 1.8;
         margin: 0 0 13px;
     }

     .btn-call-now {
         display: inline-flex;
         align-items: center;
         justify-content: center;
         padding: 9px 15px;
         color: #ffffff !important;
         background: var(--forte-blue);
         border-radius: 8px;
         font-size: 12px;
         font-weight: 800;
         text-decoration: none !important;
         transition: background 0.2s ease, transform 0.2s ease;
     }

     .btn-call-now:hover {
         background: var(--forte-navy);
         color: #ffffff !important;
         transform: translateY(-1px);
     }

     /* Social links */

     .connect-heading {
         color: var(--forte-navy);
         font-size: 14px;
         font-weight: 800;
         margin: 26px 0 14px;
     }

     .social-icons-row {
         display: flex;
         flex-wrap: wrap;
         gap: 10px;
     }

     .social-icon-circle {
         width: 42px;
         height: 42px;
         display: inline-flex;
         align-items: center;
         justify-content: center;
         border: 1px solid var(--forte-border);
         border-radius: 12px;
         background: #ffffff;
         color: var(--forte-navy);
         font-size: 17px;
         text-decoration: none;
         transition: all 0.2s ease;
     }

     .social-icon-circle:hover {
         background: var(--forte-blue);
         color: #ffffff;
         border-color: var(--forte-blue);
         transform: translateY(-2px);
     }

     /* Message form */

     .contact-form-container h2 {
         color: var(--forte-navy);
         font-family: 'Space Grotesk', 'Inter', Arial, sans-serif;
         font-size: 25px;
         font-weight: 800;
         letter-spacing: -0.5px;
         margin: 0 0 9px;
     }

     .form-subtitle {
         color: var(--forte-muted);
         font-size: 13px;
         line-height: 1.8;
         margin-bottom: 27px;
     }

     .contact-form-container .form-row {
         display: grid;
         grid-template-columns: repeat(2, minmax(0, 1fr));
         gap: 18px;
     }

     .contact-form-container .form-group {
         display: flex;
         flex-direction: column;
         min-width: 0;
         margin-bottom: 19px;
     }

     .contact-form-container .form-group label {
         display: block;
         color: var(--forte-navy);
         font-size: 12px;
         font-weight: 800;
         margin-bottom: 9px;
     }

     .contact-form-container .required {
         color: #dc2626;
         margin-left: 2px;
     }

     .contact-form-container .input-icon-wrap {
         position: relative;
         width: 100%;
     }

     .contact-form-container .input-icon-wrap > i {
         position: absolute;
         top: 15px;
         left: 14px;
         color: #8291a7;
         font-size: 14px;
         pointer-events: none;
     }

     .contact-form-container .input-icon-wrap.textarea-icon > i {
         top: 17px;
     }

     .contact-form-container input[type="text"],
     .contact-form-container input[type="email"],
     .contact-form-container input[type="tel"],
     .contact-form-container input[type="number"],
     .contact-form-container input[type="search"],
     .contact-form-container input:not([type]),
     .contact-form-container textarea,
     .contact-form-container select {
         display: block;
         width: 100%;
         max-width: 100%;
         min-height: 46px;
         padding: 12px 14px;
         border: 1px solid #dce3ed;
         border-radius: 10px;
         outline: none;
         background: #fbfcfe;
         color: var(--forte-navy);
         font-family: inherit;
         font-size: 13px;
         line-height: 1.5;
         box-shadow: none;
         transition: border-color 0.2s ease,
                     box-shadow 0.2s ease,
                     background 0.2s ease;
     }

     .contact-form-container .input-icon-wrap input {
         padding-left: 40px;
     }

     .contact-form-container textarea {
         min-height: 145px;
         resize: vertical;
     }

     .contact-form-container .input-icon-wrap textarea {
         padding-left: 40px;
     }

     .contact-form-container select {
         cursor: pointer;
     }

     .contact-form-container input:focus,
     .contact-form-container textarea:focus,
     .contact-form-container select:focus {
         border-color: var(--forte-blue);
         background: #ffffff;
         box-shadow: 0 0 0 4px rgba(36, 87, 214, 0.10);
     }

     .contact-form-container input::placeholder,
     .contact-form-container textarea::placeholder {
         color: #9aa7b8;
         opacity: 1;
     }

     /* Submit button */

     .contact-form-container .btn-submit {
         display: inline-flex;
         align-items: center;
         justify-content: center;
         gap: 10px;
         width: 100%;
         min-height: 49px;
         margin-top: 2px;
         padding: 13px 20px;
         border: 0;
         border-radius: 10px;
         background: linear-gradient(
             100deg,
             var(--forte-blue),
             var(--forte-blue-light)
         );
         color: #ffffff !important;
         font-family: inherit;
         font-size: 13px;
         font-weight: 800;
         text-align: center;
         text-decoration: none !important;
         cursor: pointer;
         box-shadow: 0 5px 12px rgba(36, 87, 214, 0.16);
         transition: all 0.2s ease;
     }

     .contact-form-container .btn-submit:hover {
         background: var(--forte-navy);
         box-shadow: 0 7px 17px rgba(7, 24, 39, 0.16);
         transform: translateY(-1px);
     }

     .form-security-note {
         display: flex;
         justify-content: center;
         align-items: center;
         gap: 7px;
         margin-top: 17px;
         color: #7b8798;
         font-size: 11px;
         text-align: center;
     }

     .form-security-note i {
         color: #16a34a;
     }

     /* Success message */

     .success-message {
         padding: 24px;
         background: #f0fdf4;
         border: 1px solid #bbf7d0;
         border-radius: 13px;
     }

     .success-message h4 {
         color: #166534;
         font-size: 17px;
         font-weight: 800;
         margin: 0 0 12px;
     }

     .success-message h4 i {
         margin-right: 6px;
     }

     .success-message p {
         color: #166534;
         font-size: 13px;
         line-height: 1.9;
         margin: 0;
     }

     .success-message a {
         overflow-wrap: anywhere;
     }

     /* Department contacts */

     .department-contacts,
     .additional-info-section {
         margin-top: 28px;
         padding: 30px;
         background: #ffffff;
         border: 1px solid var(--forte-border);
         border-radius: 18px;
         box-shadow: 0 5px 18px rgba(15, 23, 42, 0.035);
     }

     .department-contacts > h3,
     .additional-info-section > h3 {
         display: flex;
         align-items: center;
         gap: 10px;
         color: var(--forte-navy);
         font-family: 'Space Grotesk', 'Inter', Arial, sans-serif;
         font-size: 21px;
         font-weight: 800;
         margin: 0 0 12px;
     }

     .department-contacts > h3 i,
     .additional-info-section > h3 i {
         color: var(--forte-blue);
     }

     .department-contacts > p {
         color: var(--forte-muted) !important;
         font-size: 13px;
         line-height: 1.8;
         margin: 0 0 23px !important;
     }

     .departments-grid {
         display: grid;
         grid-template-columns: repeat(3, minmax(0, 1fr));
         gap: 15px;
     }

     .department-card {
         min-width: 0;
         padding: 20px;
         background: #f9fbff;
         border: 1px solid #e5ebf5;
         border-radius: 13px;
         transition: border-color 0.2s ease,
                     transform 0.2s ease,
                     box-shadow 0.2s ease;
     }

     .department-card:hover {
         border-color: #b8ccff;
         box-shadow: 0 7px 17px rgba(36, 87, 214, 0.07);
         transform: translateY(-2px);
     }

     .department-card h4 {
         display: flex;
         align-items: center;
         gap: 9px;
         color: var(--forte-navy);
         font-size: 13px;
         font-weight: 800;
         line-height: 1.6;
         margin: 0 0 12px;
     }

     .department-card h4 i {
         color: var(--forte-blue);
         font-size: 15px;
     }

     .department-card a {
         color: var(--forte-blue);
         font-size: 12px;
         line-height: 1.8;
         overflow-wrap: anywhere;
         text-decoration: none;
     }

     .department-card a:hover {
         color: var(--forte-navy);
         text-decoration: underline;
     }

     /* Additional information */

     .additional-info-section {
         margin-top: 28px;
     }

     .info-box {
         padding: 19px 21px;
         margin-top: 14px;
         background: #f8faff;
         border: 1px solid #e5ebf5;
         border-left: 4px solid var(--forte-blue);
         border-radius: 10px;
     }

     .info-box h4 {
         color: var(--forte-navy);
         font-size: 14px;
         font-weight: 800;
         margin: 0 0 9px;
     }

     .info-box h4 i {
         color: var(--forte-blue);
         margin-right: 7px;
     }

     .info-box p {
         color: var(--forte-muted);
         font-size: 13px;
         line-height: 1.9;
         margin: 0;
     }

     .info-box p a {
         color: var(--forte-blue);
         font-weight: 700;
         text-decoration: none;
     }

     .info-box p a:hover {
         text-decoration: underline;
     }

     /* Tablet layout */

     @media (max-width: 1000px) {
         .contact-content {
             grid-template-columns: minmax(0, 1fr);
         }

         .departments-grid {
             grid-template-columns: repeat(2, minmax(0, 1fr));
         }

         .contact-info-section {
             display: grid;
             grid-template-columns: repeat(2, minmax(0, 1fr));
             column-gap: 24px;
             align-items: start;
         }

         .contact-info-item {
             min-width: 0;
         }

         .emergency-box,
         .connect-heading,
         .social-icons-row {
             grid-column: 1 / -1;
         }
     }

     /* Mobile layout */

     @media (max-width: 600px) {
         .contact-page-wrapper {
             padding: 20px 0 35px;
         }

         .contact-page-wrapper .container {
             padding: 0 14px;
         }

         .contact-header {
             padding: 31px 23px;
             border-radius: 15px;
             margin-bottom: 18px;
         }

         .contact-header h1 {
             font-size: 34px;
             letter-spacing: -0.7px;
         }

         .contact-header p {
             font-size: 13px;
             line-height: 1.8;
         }

         .contact-info-section,
         .contact-form-container {
             padding: 21px 17px;
             border-radius: 14px;
         }

         .contact-info-section {
             display: flex;
         }

         .contact-info-item {
             gap: 12px;
         }

         .contact-info-item-icon {
             width: 41px;
             height: 41px;
             min-width: 41px;
         }

         .contact-form-container h2 {
             font-size: 22px;
         }

         .contact-form-container .form-row {
             grid-template-columns: minmax(0, 1fr);
             gap: 0;
         }

         .departments-grid {
             grid-template-columns: minmax(0, 1fr);
         }

         .department-contacts,
         .additional-info-section {
             padding: 22px 17px;
             border-radius: 14px;
         }

         .department-contacts > h3,
         .additional-info-section > h3 {
             font-size: 18px;
             line-height: 1.5;
         }

         .department-card {
             padding: 17px;
         }

         .info-box {
             padding: 17px;
         }
     }

     /* Respect reduced-motion preferences */

     @media (prefers-reduced-motion: reduce) {
         .contact-page-wrapper *,
         .contact-page-wrapper *::before,
         .contact-page-wrapper *::after {
             transition: none !important;
             animation: none !important;
             scroll-behavior: auto !important;
         }
     }
 </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Forte.css" rel="stylesheet" />

    <div class="contact-page-wrapper">
        <div class="container">

            <div class="contact-header">
                <div class="eyebrow">Get in Touch</div>
                <h1>We'd love to hear<br />from you!</h1>
                <p>Have a question, need a quote, or want to discuss your next event? Our team is here to help you every step of the way.</p>
            </div>

            <div class="contact-content">

                <div class="contact-info-section">

                    <div class="contact-info-item">
                        <div class="contact-info-item-icon"><i class="fas fa-phone"></i></div>
                        <div class="contact-info-item-content">
                            <div class="contact-info-item-label">Phone</div>
                            <div class="contact-info-item-value">
                                <a href="tel:+27685773269">+27 (68) 577-3269</a>
                            </div>
                        </div>
                    </div>

                    <div class="contact-info-item">
                        <div class="contact-info-item-icon"><i class="fas fa-envelope"></i></div>
                        <div class="contact-info-item-content">
                            <div class="contact-info-item-label">Email</div>
                            <div class="contact-info-item-value">
                                <a href="mailto:forteevents@gmail.com">forteevents@gmail.com</a>
                                <a href="mailto:bookings@forteevents.co.za">bookings@forteevents.co.za</a>
                            </div>
                        </div>
                    </div>

                    <div class="contact-info-item">
                        <div class="contact-info-item-icon"><i class="fas fa-map-marker-alt"></i></div>
                        <div class="contact-info-item-content">
                            <div class="contact-info-item-label">Address</div>
                            <div class="contact-info-item-value">
                                East London, Eastern Cape<br />South Africa
                            </div>
                        </div>
                    </div>

                    <div class="contact-info-item">
                        <div class="contact-info-item-icon"><i class="fas fa-clock"></i></div>
                        <div class="contact-info-item-content">
                            <div class="contact-info-item-label">Business Hours</div>
                            <div class="contact-info-item-value">
                                Monday - Friday: 8:30 AM - 4:30 PM<br />
                                Saturday - Sunday: Closed<br />
                                Public Holidays: Closed
                            </div>
                        </div>
                    </div>

                    <div class="emergency-box">
                        <div class="emergency-box-icon"><i class="fas fa-headset"></i></div>
                        <div>
                            <h4>Need Immediate Assistance?</h4>
                            <p>For urgent bookings or support, give us a call during business hours.</p>
                            <a href="tel:+27685773269" class="btn-call-now">Call Now</a>
                        </div>
                    </div>

                    <div class="connect-heading">Connect With Us</div>
                    <div class="social-icons-row">
                        <a href="https://www.facebook.com/ForteEvents" target="_blank" class="social-icon-circle facebook"><i class="fab fa-facebook-f"></i></a>
                        <a href="https://www.instagram.com/ForteEvents" target="_blank" class="social-icon-circle instagram"><i class="fab fa-instagram"></i></a>
                        <a href="https://wa.me/27685773269" target="_blank" class="social-icon-circle whatsapp"><i class="fab fa-whatsapp"></i></a>
                    </div>
                </div>

                <div class="contact-form-container">
                    <h2>Send Us a Message</h2>
                    <div class="form-subtitle">Fill in the form below and we will get back to you as soon as possible.</div>

                    <asp:Panel ID="contactForm" runat="server">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="txtFullName">Full Name <span class="required">*</span></label>
                                <div class="input-icon-wrap">
                                    <i class="fas fa-user"></i>
                                    <asp:TextBox ID="txtFullName" runat="server" placeholder="Your Name"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="txtEmail">Email <span class="required">*</span></label>
                                <div class="input-icon-wrap">
                                    <i class="fas fa-envelope"></i>
                                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Email Address"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="txtPhone">Phone <span class="required">*</span></label>
                                <div class="input-icon-wrap">
                                    <i class="fas fa-phone"></i>
                                    <asp:TextBox ID="txtPhone" runat="server" TextMode="Phone" placeholder="Phone Number"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="txtSubject">Subject <span class="required">*</span></label>
                                <div class="input-icon-wrap">
                                    <i class="fas fa-tag"></i>
                                    <asp:TextBox ID="txtSubject" runat="server" placeholder="Subject"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="txtMessage">Message <span class="required">*</span></label>
                            <div class="input-icon-wrap textarea-icon">
                                <i class="fas fa-pen"></i>
                                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" placeholder="Your Message"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="ddlPreferredContact">Preferred Contact Method <span class="required">*</span></label>
                                <asp:DropDownList ID="ddlPreferredContact" runat="server">
                                    <asp:ListItem Value="">-- Select preferred method --</asp:ListItem>
                                    <asp:ListItem Value="Email">Email</asp:ListItem>
                                    <asp:ListItem Value="Phone">Phone</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label for="txtBestTime">Best Time to Contact (Optional)</label>
                                <asp:TextBox ID="txtBestTime" runat="server" placeholder="e.g., Weekday mornings or weekends"></asp:TextBox>
                            </div>
                        </div>

                        <asp:LinkButton ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" CssClass="btn-submit">
                            <i class="fas fa-paper-plane"></i> Send Message
                        </asp:LinkButton>
                        <div class="form-security-note"><i class="fas fa-lock"></i> Your information is safe and will never be shared.</div>
                    </asp:Panel>

                    <asp:Panel ID="successMessage" runat="server" Visible="false">
                        <div class="success-message">
                            <h4><i class="fas fa-check-circle"></i> Message Sent Successfully!</h4>
                            <p>Thank you for reaching out! We've received your message and will get back to you within 2 business days. If your matter is urgent, please call us at <a href="tel:+27685773269" style="color: inherit; text-decoration: none; font-weight: 700;">+27 (68) 577-3269</a></p>
                        </div>
                    </asp:Panel>
                </div>
            </div>

            <div class="department-contacts">
                <h3><i class="fas fa-sitemap"></i> Department Contacts</h3>
                <p style="color: var(--ccf-medium-grey); margin-bottom: 25px;">For specific enquiries, you can reach the relevant department directly:</p>
                <div class="departments-grid">
                    <div class="department-card">
                        <h4><i class="fas fa-calendar"></i> Bookings Enquiry</h4>
                        <a href="mailto:bookings@forteevents.co.za">bookings@forteevents.co.za</a>
                    </div>
                    <div class="department-card">
                        <h4><i class="fas fa-truck"></i> Delivery/Collection</h4>
                        <a href="mailto:delivery@forteevents.co.za">delivery@forteevents.co.za</a>
                    </div>
                    <div class="department-card">
                        <h4><i class="fas fa-credit-card"></i> Payment Questions</h4>
                        <a href="mailto:payments@forteevents.co.za">payments@forteevents.co.za</a>
                    </div>
                    <div class="department-card">
                        <h4><i class="fas fa-tools"></i> Damage Claims</h4>
                        <a href="mailto:claims@forteevents.co.za">claims@forteevents.co.za</a>
                    </div>
                    <div class="department-card">
                        <h4><i class="fas fa-headset"></i> Technical Support</h4>
                        <a href="mailto:support@forteevents.co.za">support@forteevents.co.za</a>
                    </div>
                </div>
            </div>

            
            </div>


            <div class="additional-info-section">
                <h3><i class="fas fa-circle-info"></i> Additional Information</h3>

                <div class="info-box">
                    <h4><i class="fas fa-question-circle"></i> Have a Quick Question?</h4>
                    <p>Check our <a href="~/Presentation/FAQ.aspx" runat="server">Frequently Asked Questions</a> page first - you might find the answer you're looking for!</p>
                </div>

                <div class="info-box">
                    <h4><i class="fas fa-universal-access"></i> Accessibility</h4>
                    <p>We're committed to serving all customers. If you have any accessibility needs or require alternative contact methods, please <strong>don't hesitate to reach out</strong>. We're here to help and will make special arrangements if needed.</p>
                </div>

                <div class="info-box">
                    <h4><i class="fas fa-lock"></i> Privacy & Security</h4>
                    <p>Your information is safe with us. We take data privacy seriously and will never share your details without your consent. For more information, please see our <a href="~/Presentation/Privacy.aspx" runat="server">Privacy Policy</a>.</p>
                </div>
            </div>

        
    </div>
</asp:Content>
