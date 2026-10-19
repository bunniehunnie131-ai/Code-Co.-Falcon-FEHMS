<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="HowItWorks.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.HowItWorks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Stylesheet/Forte.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <div class="container">
        <section class="page-header">
            <span class="badge badge-forte mb-2">FORTE EVENTS · CUSTOMER GUIDE</span>
            <h1 class="page-title">How It Works</h1>
            <p class="page-subtitle mb-3">Browse event hire as a visitor, then register or log in when you are ready to place an order. Follow the steps below to plan your booking.</p>
            <div class="d-flex flex-wrap gap-2">
                <a class="btn btn-forte" href="Catalogue.aspx"><i class="bi bi-grid me-1" aria-hidden="true"></i> Browse the Catalogue</a>
                <a class="btn btn-outline-forte" href="Registration.aspx"><i class="bi bi-person-plus me-1" aria-hidden="true"></i> Create an Account</a>
                <a class="btn btn-outline-forte" href="Login.aspx"><i class="bi bi-box-arrow-in-right me-1" aria-hidden="true"></i> Log In</a>
            </div>
            <div class="alert alert-info mt-3 mb-0" role="note">
                <i class="bi bi-info-circle me-1" aria-hidden="true"></i>
                You can view the catalogue without an account. You must register and log in before making an order.
            </div>
        </section>

        <section class="section pt-2" aria-labelledby="journey-title">
            <h2 id="journey-title" class="section-title">Your booking journey</h2>
            <p class="section-subtitle">Here is what you will need at each stage, from opening an account to receiving your confirmation.</p>

            <article class="card">
                <div class="d-flex align-items-start gap-3">
                    <span class="icon-circle flex-shrink-0"><i class="bi bi-search" aria-hidden="true"></i></span>
                    <div>
                        <h3 class="h5">1. Browse the catalogue</h3>
                        <p class="mb-2">Explore the hire catalogue as a visitor. You can look through the available products and categories before registering.</p>
                        <p class="mb-0"><strong>To place an order:</strong> create an account and log in first. Browsing as a visitor does not give access to ordering and checkout.</p>
                    </div>
                </div>
            </article>

            <article class="card">
                <div class="d-flex align-items-start gap-3">
                    <span class="icon-circle flex-shrink-0"><i class="bi bi-person-plus" aria-hidden="true"></i></span>
                    <div>
                        <h3 class="h5">2. Register your customer account</h3>
                        <p>Complete the registration form with the following information:</p>
                        <ul class="mb-2">
                            <li>Full name</li>
                            <li>Email address</li>
                            <li>Date of birth</li>
                            <li>ID number</li>
                            <li>Password and password confirmation</li>
                            <li>Read and accept the Terms &amp; Conditions</li>
                        </ul>
                        <p class="mb-0">After registering, continue to the login page and sign in with your email address and password.</p>
                        <a href="Registration.aspx" class="btn btn-forte mt-3">Register</a>
                    </div>
                </div>
            </article>

            <article class="card">
                <div class="d-flex align-items-start gap-3">
                    <span class="icon-circle flex-shrink-0"><i class="bi bi-box-arrow-in-right" aria-hidden="true"></i></span>
                    <div>
                        <h3 class="h5">3. Log in</h3>
                        <p class="mb-2">Use the account details you registered with:</p>
                        <ul class="mb-2">
                            <li>Email address</li>
                            <li>Password</li>
                        </ul>
                        <p class="mb-0">Once logged in as a customer, continue to the catalogue to choose items for your event.</p>
                        <a href="Login.aspx" class="btn btn-outline-forte mt-3">Log In</a>
                    </div>
                </div>
            </article>

            <article class="card">
                <div class="d-flex align-items-start gap-3">
                    <span class="icon-circle flex-shrink-0"><i class="bi bi-cart3" aria-hidden="true"></i></span>
                    <div>
                        <h3 class="h5">4. Choose items and review your cart</h3>
                        <p class="mb-2">Browse the catalogue while logged in, select the hire items and quantities you need, and add them to your cart.</p>
                        <p class="mb-0">Review your cart before continuing. Check product names, quantities and prices; update quantities or remove items if needed.</p>
                    </div>
                </div>
            </article>

            <article class="card">
                <div class="d-flex align-items-start gap-3">
                    <span class="icon-circle flex-shrink-0"><i class="bi bi-calendar-event" aria-hidden="true"></i></span>
                    <div>
                        <h3 class="h5">5. Enter your event details</h3>
                        <p>On Checkout, provide:</p>
                        <ul class="mb-2">
                            <li>Event date</li>
                            <li>Event type</li>
                            <li>Optional event notes</li>
                        </ul>
                        <p class="mb-0">The event date must be today or a future date. Check your selections and item total before continuing to delivery and extras.</p>
                    </div>
                </div>
            </article>

            <article class="card">
                <div class="d-flex align-items-start gap-3">
                    <span class="icon-circle flex-shrink-0"><i class="bi bi-truck" aria-hidden="true"></i></span>
                    <div>
                        <h3 class="h5">6. Choose delivery or collection and add extras</h3>
                        <p>First provide the customer contact information:</p>
                        <ul>
                            <li>Full name</li>
                            <li>Email address</li>
                            <li>Phone number</li>
                        </ul>
                        <p class="mb-2"><strong>Then choose one transport option:</strong></p>
                        <ul>
                            <li><strong>Forte delivery and collection:</strong> delivery address, city or town, province, postal code, delivery date and time, collection date and time, and any transport instructions.</li>
                            <li><strong>Customer collection and return:</strong> collection date and time, and return date and time.</li>
                        </ul>
                        <p class="mb-2">Also indicate whether you require setup. You can optionally select service providers and quantities: DJ, caterer, bartender, waiter, clown or photographer.</p>
                        <p class="mb-0">Review the item total, delivery fee (if applicable), setup fee (if selected), provider fees and grand total before continuing to payment.</p>
                    </div>
                </div>
            </article>

            <article class="card">
                <div class="d-flex align-items-start gap-3">
                    <span class="icon-circle flex-shrink-0"><i class="bi bi-credit-card" aria-hidden="true"></i></span>
                    <div>
                        <h3 class="h5">7. Enter payment details</h3>
                        <p>Review the booking summary and total, then complete the payment form with:</p>
                        <ul class="mb-2">
                            <li>Bank name</li>
                            <li>Cardholder name</li>
                            <li>Card number</li>
                            <li>Card expiry date</li>
                            <li>CVV</li>
                        </ul>
                        <p class="mb-0">Check the details you entered and submit payment to complete the booking.</p>
                    </div>
                </div>
            </article>

            <article class="card">
                <div class="d-flex align-items-start gap-3">
                    <span class="icon-circle flex-shrink-0"><i class="bi bi-receipt" aria-hidden="true"></i></span>
                    <div>
                        <h3 class="h5">8. View your confirmation and receipt</h3>
                        <p class="mb-2">After payment, the Order Confirmation page displays your booking information and receipt, including your booking reference, event details, selected items, transport choice and payment summary.</p>
                        <p class="mb-0">Keep your booking reference for your records and use the site's booking or order tracking page to review the booking information available to you.</p>
                    </div>
                </div>
            </article>
        </section>

    </div>
    <section class="section" aria-labelledby="booking-status-title">
    <div class="page-header">
        <h2 id="booking-status-title" class="page-title">When is my booking registered?</h2>
        <p class="page-subtitle mb-0">
            Your booking is recorded after you submit payment. The Order Confirmation page
            displays your booking reference, booking status, payment status, event details,
            selected hire items and receipt. Keep your booking reference for your records.
        </p>
    </div>
</section>

<section class="section pt-2" aria-labelledby="faq-title">
    <h2 id="faq-title" class="section-title">Frequently Asked Questions</h2>
    <p class="section-subtitle">Quick answers about accounts, orders and delivery.</p>

    <div class="accordion" id="bookingFaq">
        <div class="accordion-item">
            <h3 class="accordion-header" id="faq-heading-one">
                <button class="accordion-button" type="button"
                        data-bs-toggle="collapse" data-bs-target="#faq-one"
                        aria-expanded="true" aria-controls="faq-one">
                    Can I browse without registering?
                </button>
            </h3>
            <div id="faq-one" class="accordion-collapse collapse show"
                 aria-labelledby="faq-heading-one" data-bs-parent="#bookingFaq">
                <div class="accordion-body">
                    Yes. You can view the catalogue as a visitor. You need to register
                    and log in before placing an order.
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h3 class="accordion-header" id="faq-heading-two">
                <button class="accordion-button collapsed" type="button"
                        data-bs-toggle="collapse" data-bs-target="#faq-two"
                        aria-expanded="false" aria-controls="faq-two">
                    When is my booking considered confirmed?
                </button>
            </h3>
            <div id="faq-two" class="accordion-collapse collapse"
                 aria-labelledby="faq-heading-two" data-bs-parent="#bookingFaq">
                <div class="accordion-body">
                    After you submit payment, the system records the booking and takes
                    you to the Order Confirmation page. Check that page for your booking
                    reference, booking status and payment status.
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h3 class="accordion-header" id="faq-heading-three">
                <button class="accordion-button collapsed" type="button"
                        data-bs-toggle="collapse" data-bs-target="#faq-three"
                        aria-expanded="false" aria-controls="faq-three">
                    Where do I choose delivery or collection?
                </button>
            </h3>
            <div id="faq-three" class="accordion-collapse collapse"
                 aria-labelledby="faq-heading-three" data-bs-parent="#bookingFaq">
                <div class="accordion-body">
                    On the Delivery &amp; Extras page, choose Forte delivery and collection
                    or customer collection and return. Enter the dates, times and other
                    details requested for your selected option.
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h3 class="accordion-header" id="faq-heading-four">
                <button class="accordion-button collapsed" type="button"
                        data-bs-toggle="collapse" data-bs-target="#faq-four"
                        aria-expanded="false" aria-controls="faq-four">
                    Where can I find my receipt and booking reference?
                </button>
            </h3>
            <div id="faq-four" class="accordion-collapse collapse"
                 aria-labelledby="faq-heading-four" data-bs-parent="#bookingFaq">
                <div class="accordion-body">
                    Your booking reference and receipt are shown on the Order Confirmation
                    page after payment. Keep the reference so you can identify your booking.
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h3 class="accordion-header" id="faq-heading-five">
                <button class="accordion-button collapsed" type="button"
                        data-bs-toggle="collapse" data-bs-target="#faq-five"
                        aria-expanded="false" aria-controls="faq-five">
                    What information do I need to complete a booking?
                </button>
            </h3>
            <div id="faq-five" class="accordion-collapse collapse"
                 aria-labelledby="faq-heading-five" data-bs-parent="#bookingFaq">
                <div class="accordion-body">
                    Have your event date and type, customer contact details, delivery or
                    collection information, and payment details ready. You can also add
                    event notes, request setup and select optional service providers.
                </div>
            </div>
        </div>
    </div>
</section>
</asp:Content>

