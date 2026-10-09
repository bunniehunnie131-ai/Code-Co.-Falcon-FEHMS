<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
