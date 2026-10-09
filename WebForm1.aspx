<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Terms and Conditions</title>

    <style>
        :root {
            --tc-navy: #142c6b;
            --tc-navy-dark: #0f2255;
            --tc-blue-link: #1a4fa3;
            --tc-blue-tint: #eef3fc;
            --tc-border: #e5e8ee;
            --tc-text: #333c4d;
            --tc-text-muted: #6b7280;
            --tc-green: #198754;
            --tc-red: #a33a3a;
        }

        * { box-sizing: border-box; }

        body {
            margin: 0;
            background: #fff;
            font-family: -apple-system, "Segoe UI", Arial, sans-serif;
            color: var(--tc-text);
        }

        .tc-hero {
            padding: 32px 0 8px;
        }

        .tc-hero__inner {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 24px;
        }

        .tc-hero h1 {
            margin: 0 0 8px;
            color: var(--tc-navy);
            font-size: 30px;
            font-weight: 700;
        }

        .tc-breadcrumb {
            font-size: 13px;
            color: var(--tc-text-muted);
        }

        .tc-breadcrumb a {
            color: var(--tc-blue-link);
            text-decoration: none;
        }

        .tc-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 16px 24px 60px;
        }

        .tc-card {
            border: 1px solid var(--tc-border);
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 4px 18px rgba(20, 44, 107, 0.06);
            overflow: hidden;
        }

        .tc-progress {
            padding: 22px 28px 18px;
            background: #f8fafd;
            border-bottom: 1px solid var(--tc-border);
        }

        .tc-progress-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 12px;
        }

        .tc-step {
            color: var(--tc-navy);
            font-size: 15px;
            font-weight: 700;
        }

        .tc-step-title {
            color: var(--tc-text-muted);
            font-size: 13px;
        }

        .tc-progress-bar {
            width: 100%;
            height: 8px;
            background: #e4e8f0;
            border-radius: 20px;
            overflow: hidden;
        }

        .tc-progress-fill {
            height: 100%;
            width: 10%;
            background: var(--tc-navy);
            border-radius: 20px;
            transition: width .25s ease;
        }

        .tc-content {
            padding: 34px 38px;
            min-height: 570px;
        }

        .tc-section {
            display: none;
        }

        .tc-section.active {
            display: block;
            animation: fadeIn .2s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(4px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .tc-section h2 {
            color: var(--tc-navy);
            font-size: 24px;
            margin: 0 0 18px;
        }

        .tc-section h3 {
            color: var(--tc-navy);
            font-size: 16px;
            margin: 24px 0 8px;
        }

        .tc-section p,
        .tc-section li {
            font-size: 14px;
            line-height: 1.7;
        }

        .tc-section ul {
            padding-left: 22px;
        }

        .tc-notice {
            margin: 20px 0;
            padding: 15px 17px;
            background: var(--tc-blue-tint);
            border-left: 4px solid var(--tc-navy);
            border-radius: 6px;
        }

        .tc-agreement {
            margin-top: 30px;
            padding: 18px;
            background: #f8fafd;
            border: 1px solid var(--tc-border);
            border-radius: 8px;
        }

        .tc-checkbox {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            font-size: 14px;
            line-height: 1.5;
        }

        .tc-checkbox input {
            width: 18px;
            height: 18px;
            margin-top: 2px;
            accent-color: var(--tc-green);
            cursor: pointer;
        }

        .tc-actions {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            padding: 20px 28px;
            border-top: 1px solid var(--tc-border);
            background: #fafbfc;
        }

        .tc-actions-left,
        .tc-actions-right {
            display: flex;
            gap: 10px;
        }

        .terms-btn {
            padding: 11px 20px;
            border-radius: 7px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: .2s ease;
        }

        .terms-btn-back {
            background: white;
            color: var(--tc-navy);
            border: 1px solid var(--tc-navy);
        }

        .terms-btn-back:hover {
            background: var(--tc-blue-tint);
        }

        .terms-btn-next {
            background: var(--tc-navy);
            color: white;
            border: 1px solid var(--tc-navy);
        }

        .terms-btn-accept {
            background: var(--tc-green);
            color: white;
            border: 1px solid var(--tc-green);
        }

        .terms-btn-next:hover {
            background: var(--tc-navy-dark);
        }

        .terms-btn-accept:hover {
            background: #146c43;
            border-color: #146c43;
        }

        .terms-btn-decline {
            background: white;
            color: var(--tc-red);
            border: 1px solid var(--tc-red);
        }

        .terms-btn-decline:hover {
            background: #fff4f4;
        }

        .tc-final-agreement {
            margin-top: 30px;
            padding: 18px;
            background: #f8fafd;
            border: 1px solid var(--tc-border);
            border-radius: 8px;
        }

        .terms-btn-accepted {
            background: var(--tc-green);
            color: white;
            border: 1px solid var(--tc-green);
        }


        .tc-modal-backdrop {
            display: none;
            position: fixed;
            inset: 0;
            z-index: 9999;
            background: rgba(15, 34, 85, 0.42);
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .tc-modal {
            width: min(430px, 100%);
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 18px 55px rgba(0,0,0,.22);
            overflow: hidden;
        }

        .tc-modal-header {
            padding: 18px 22px;
            color: #fff;
            background: var(--tc-navy);
            font-size: 17px;
            font-weight: 700;
        }

        .tc-modal-body {
            padding: 22px;
            color: var(--tc-text);
            font-size: 14px;
            line-height: 1.6;
        }

        .tc-modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            padding: 0 22px 20px;
        }

        .tc-modal-btn {
            padding: 10px 18px;
            border-radius: 7px;
            border: 1px solid var(--tc-navy);
            background: var(--tc-navy);
            color: #fff;
            font-weight: 600;
            cursor: pointer;
        }

        .tc-modal-btn:hover {
            background: var(--tc-navy-dark);
        }

        .tc-modal-btn-secondary {
            background: #fff;
            color: var(--tc-navy);
        }

        .tc-modal-btn-secondary:hover {
            background: var(--tc-blue-tint);
        }

        .tc-footer-note {
            margin-top: 18px;
            color: var(--tc-text-muted);
            font-size: 12px;
            text-align: center;
        }

        @media (max-width: 700px) {
            .tc-content {
                padding: 25px 20px;
            }

            .tc-actions {
                flex-direction: column;
            }

            .tc-actions-left,
            .tc-actions-right {
                width: 100%;
            }

            .terms-btn {
                flex: 1;
            }

            .tc-progress-top {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <section class="tc-hero">
        <div class="tc-hero__inner">
            <h1>Terms and Conditions</h1>
            <div class="tc-breadcrumb">
                <a href="Home.aspx">Home</a>
                <span> / </span>
                <span>Terms and Conditions</span>
            </div>
        </div>
    </section>

    <div class="tc-container">

        <div class="tc-card">

            <!-- PROGRESS -->
            <div class="tc-progress">
                <div class="tc-progress-top">
                    <span id="stepText" class="tc-step">Section 1 of 10</span>
                    <span id="stepTitle" class="tc-step-title">Introduction</span>
                </div>

                <div class="tc-progress-bar">
                    <div id="progressFill" class="tc-progress-fill"></div>
                </div>
            </div>

            <!-- CONTENT -->
            <main class="tc-content">

                <!-- 1 -->
                <section class="tc-section active" data-section="1">
                    <h2>1. Introduction</h2>

                    <p>
                        These Terms and Conditions govern your use of the FEMHS Code &amp; Co Falcon
                        website and the hiring, booking, delivery, collection and return of event
                        equipment and related services.
                    </p>

                    <p>
                        By accessing the website, creating an account, browsing available products,
                        requesting a booking, making a payment or hiring equipment, you acknowledge
                        that you have read, understood and agreed to these Terms and Conditions.
                    </p>

                    <p>
                        If you do not agree with these Terms and Conditions, you should not continue
                        with a booking or use services provided through the platform.
                    </p>

                    <h3>Information Provided by Customers</h3>
                    <p>
                        Customers must provide complete, accurate and current information when
                        registering, making a booking, providing event details, selecting delivery
                        or collection, and making payments. Incorrect information may affect the
                        availability, delivery or successful completion of a booking.
                    </p>

                    <h3>Changes to These Terms</h3>
                    <p>
                        We may update these Terms and Conditions when necessary. Changes will be
                        displayed on the website. Customers should review the latest version before
                        making a new booking.
                    </p>

                    <div class="tc-notice">
                        These Terms apply to the use of the platform and to bookings for event
                        equipment and related services.
                    </div>
                </section>

                <!-- 2 -->
                <section class="tc-section" data-section="2">
                    <h2>2. Company Policy</h2>

                    <p>
                        Our company aims to provide reliable, professional and quality event
                        equipment and services. Equipment shown on the platform will be described
                        as accurately as reasonably possible and is subject to availability.
                    </p>

                    <h3>Our Responsibilities</h3>
                    <ul>
                        <li>Provide equipment and services that reasonably correspond with the confirmed booking.</li>
                        <li>Provide accurate information about equipment, packages, prices and available services.</li>
                        <li>Inform customers if an item becomes unavailable after a booking has been made.</li>
                        <li>Maintain reasonable standards of cleanliness and functionality.</li>
                        <li>Provide relevant booking and payment information.</li>
                        <li>Handle customer information according to applicable privacy requirements.</li>
                        <li>Make reasonable efforts to complete agreed delivery and collection arrangements.</li>
                        <li>Provide booking confirmation where applicable.</li>
                    </ul>

                    <h3>Customer Responsibilities</h3>
                    <ul>
                        <li>Provide correct personal and contact information.</li>
                        <li>Provide accurate event dates, times, locations and quantities.</li>
                        <li>Provide accurate delivery or collection information.</li>
                        <li>Make required payments within the required period.</li>
                        <li>Use hired equipment responsibly and only for its intended purpose.</li>
                        <li>Return equipment in the condition in which it was received, excluding reasonable wear and tear.</li>
                        <li>Report problems with equipment or bookings as soon as possible.</li>
                    </ul>

                    <p>
                        Our ability to provide a specific item or service may depend on availability,
                        weather, location, equipment condition and circumstances outside our
                        reasonable control.
                    </p>
                </section>

                <!-- 3 -->
                <section class="tc-section" data-section="3">
                    <h2>3. Privacy Policy</h2>

                    <p>
                        We collect and process customer information when customers use the website,
                        create an account, make a booking, submit an enquiry or make a payment.
                    </p>

                    <h3>Information We May Collect</h3>
                    <ul>
                        <li>Full name</li>
                        <li>Contact number</li>
                        <li>Email address</li>
                        <li>Delivery address</li>
                        <li>Booking and event information</li>
                        <li>Payment-related information</li>
                        <li>Communications between the customer and the company</li>
                    </ul>

                    <h3>How Information Is Used</h3>
                    <ul>
                        <li>Create and manage customer accounts.</li>
                        <li>Process and confirm bookings.</li>
                        <li>Process payments and deposits.</li>
                        <li>Arrange delivery and collection.</li>
                        <li>Communicate with customers and provide support.</li>
                        <li>Improve the website and services.</li>
                        <li>Maintain booking and transaction records.</li>
                        <li>Prevent fraudulent or unauthorised activity.</li>
                    </ul>

                    <p>
                        We take reasonable steps to protect customer information from unauthorised
                        access, loss, misuse or disclosure. Information will not intentionally be
                        sold to third parties. It may be shared with service providers where
                        necessary to process payments, provide delivery, maintain the platform or
                        fulfil a booking, or where required by law.
                    </p>

                    <div class="tc-notice">
                        Customers are responsible for ensuring that information supplied to the
                        platform remains accurate and up to date.
                    </div>
                </section>

                <!-- 4 -->
                <section class="tc-section" data-section="4">
                    <h2>4. Cookie Policy</h2>

                    <p>
                        The website may use cookies and similar technologies to improve functionality,
                        performance and the browsing experience.
                    </p>

                    <h3>Purpose of Cookies</h3>
                    <ul>
                        <li>Remember user preferences.</li>
                        <li>Maintain login or session information.</li>
                        <li>Keep items in a customer's basket.</li>
                        <li>Improve website functionality.</li>
                        <li>Understand how customers use the website.</li>
                        <li>Improve website performance.</li>
                        <li>Provide a more convenient browsing experience.</li>
                    </ul>

                    <p>
                        Some cookies may be necessary for the website to operate correctly. For
                        example, session-related information may be required while a customer moves
                        between pages or during a booking process.
                    </p>

                    <p>
                        Customers may configure their browser to block or delete cookies. However,
                        disabling necessary cookies may cause certain website features to stop
                        functioning correctly.
                    </p>

                    <p>
                        By continuing to use the website, customers acknowledge that cookies and
                        similar technologies may be used as described in this policy.
                    </p>
                </section>

                <!-- 5 -->
                <section class="tc-section" data-section="5">
                    <h2>5. Returns and Refunds</h2>

                    <p>
                        Customers must return hired equipment at the agreed time and in substantially
                        the same condition in which it was provided, excluding reasonable wear and tear.
                    </p>

                    <h3>Returned Equipment</h3>
                    <p>
                        Equipment must be returned complete with all accessories, components and
                        related items supplied as part of the booking.
                    </p>

                    <h3>Damaged or Missing Equipment</h3>
                    <p>
                        A customer may be responsible for equipment that is lost, stolen, broken,
                        damaged through misuse, damaged beyond reasonable wear and tear, or returned
                        with missing components or accessories. Where applicable, the customer may
                        be charged the reasonable repair or replacement cost.
                    </p>

                    <h3>Cancellation</h3>
                    <p>
                        Customers wishing to cancel should contact the company as soon as possible.
                        Refund eligibility may depend on the cancellation date, whether equipment
                        has already been prepared, whether delivery has been arranged, whether the
                        booking has started and the applicable deposit or cancellation conditions.
                    </p>

                    <h3>Refund Processing</h3>
                    <p>
                        Approved refunds will normally be processed using the applicable payment
                        method or another agreed method. The time required for a refund to appear
                        may depend on the payment provider or financial institution.
                    </p>
                </section>

                <!-- 6 -->
                <section class="tc-section" data-section="6">
                    <h2>6. Booking Policy</h2>

                    <p>
                        A booking is considered confirmed only after the required booking information
                        has been submitted and the applicable payment, deposit or confirmation
                        requirements have been completed.
                    </p>

                    <h3>Required Booking Information</h3>
                    <ul>
                        <li>Customer name</li>
                        <li>Contact details</li>
                        <li>Event date</li>
                        <li>Event time</li>
                        <li>Event location</li>
                        <li>Equipment required</li>
                        <li>Quantity required</li>
                        <li>Delivery or collection preference</li>
                        <li>Additional services required</li>
                    </ul>

                    <h3>Availability</h3>
                    <p>
                        All equipment and services are subject to availability. Submitting a booking
                        request does not necessarily guarantee availability until the booking is
                        confirmed by the system or company.
                    </p>

                    <h3>Double Bookings</h3>
                    <p>
                        The system is designed to help prevent double-booking of equipment. If an
                        availability error or technical problem occurs, the company will make
                        reasonable efforts to provide an alternative item, alternative booking
                        arrangement or another appropriate resolution.
                    </p>

                    <p>
                        Customers must carefully review the booking confirmation and report incorrect
                        information as soon as possible. Changes after confirmation may depend on
                        availability and may not always be possible.
                    </p>
                </section>

                <!-- 7 -->
                <section class="tc-section" data-section="7">
                    <h2>7. Payment and Pricing Policy</h2>

                    <p>
                        Prices displayed on the website may change. Unless otherwise stated, the
                        applicable price will generally be the price presented to the customer when
                        the booking is made and confirmed.
                    </p>

                    <h3>Deposits and Payments</h3>
                    <p>
                        Customers may be required to pay a deposit or the full booking amount before
                        a booking can be confirmed, depending on the booking requirements.
                    </p>

                    <h3>When a Booking May Not Be Confirmed</h3>
                    <ul>
                        <li>Payment has not been received.</li>
                        <li>The required deposit has not been paid.</li>
                        <li>Payment has failed.</li>
                        <li>Payment information is invalid.</li>
                        <li>Required booking information has not been completed.</li>
                    </ul>

                    <p>
                        Customers should not assume that equipment has been successfully booked until
                        a booking confirmation has been received.
                    </p>

                    <p>
                        If a displayed price contains an obvious technical or system error, the
                        company reserves the right to correct the error and communicate the correct
                        price to the customer.
                    </p>

                    <p>
                        Additional charges, such as delivery fees, additional services or damage
                        charges, may apply where applicable and may be communicated separately.
                    </p>
                </section>

                <!-- 8 -->
                <section class="tc-section" data-section="8">
                    <h2>8. Delivery and Collection</h2>

                    <p>
                        Customers may choose between delivery and collection where these options are
                        available for the booking.
                    </p>

                    <h3>Delivery</h3>
                    <p>Where delivery is selected, the customer must provide:</p>
                    <ul>
                        <li>A complete and accurate delivery address.</li>
                        <li>Contact details.</li>
                        <li>The required delivery date.</li>
                        <li>Relevant access information.</li>
                        <li>Any information necessary for successful delivery.</li>
                    </ul>

                    <p>
                        Customers must ensure that the delivery location can reasonably be accessed
                        by the delivery team and that someone is available to receive equipment where
                        required.
                    </p>

                    <h3>Collection</h3>
                    <p>
                        Where collection is selected, customers are responsible for collecting the
                        equipment at the agreed time and location and returning it by the agreed
                        return time.
                    </p>

                    <p>
                        Late returns may affect other customers' bookings and may result in additional
                        charges where applicable.
                    </p>

                    <h3>Delivery Delays</h3>
                    <p>
                        Reasonable efforts will be made to meet agreed delivery times. Delays may
                        occur because of traffic, weather, road conditions, incorrect addresses,
                        access restrictions, equipment availability, unexpected operational problems
                        or events outside our reasonable control.
                    </p>
                </section>

                <!-- 9 -->
                <section class="tc-section" data-section="9">
                    <h2>9. Damage and Liability</h2>

                    <p>
                        Customers are responsible for taking reasonable care of all hired equipment
                        while it is in their possession.
                    </p>

                    <p>
                        Customers must not intentionally misuse, modify, sell, transfer, sub-hire or
                        otherwise interfere with hired equipment without permission.
                    </p>

                    <h3>Damage and Loss</h3>
                    <p>
                        Customers may be responsible for reasonable repair or replacement costs where
                        equipment is damaged, lost or stolen while under their responsibility, except
                        where the damage results from normal wear and tear or circumstances for which
                        the customer is not reasonably responsible.
                    </p>

                    <ul>
                        <li>Broken chairs or tables.</li>
                        <li>Torn tents or decorations.</li>
                        <li>Missing equipment or accessories.</li>
                        <li>Damaged electronic equipment.</li>
                        <li>Stained or heavily damaged items.</li>
                        <li>Damage caused by improper use.</li>
                    </ul>

                    <h3>Loss or Theft</h3>
                    <p>
                        Customers must take reasonable precautions to prevent hired equipment from
                        being lost or stolen. Where equipment is lost or stolen while under the
                        customer's responsibility, reasonable replacement costs may be charged.
                    </p>

                    <h3>Limitation of Liability</h3>
                    <p>
                        We will make reasonable efforts to provide reliable equipment and services.
                        However, we cannot be held responsible for circumstances outside our reasonable
                        control, including severe weather, natural disasters, road closures, technical
                        failures or other events that could not reasonably have been prevented.
                    </p>

                    <p>
                        Customers are also responsible for ensuring that hired equipment is suitable
                        for their intended event and use.
                    </p>
                </section>

                <!-- 10 -->
                <section class="tc-section" data-section="10">
                    <h2>10. Governing Law</h2>

                    <p>
                        These Terms and Conditions are governed by the laws of the Republic of South
                        Africa.
                    </p>

                    <h3>Dispute Resolution</h3>
                    <p>
                        Any dispute relating to the website, bookings, payments, hired equipment or
                        services should first be raised directly with the company so that the parties
                        can attempt to resolve the matter through communication.
                    </p>

                    <p>
                        If the matter cannot be resolved through communication, the parties may use
                        the appropriate legal or dispute-resolution processes available under
                        South African law.
                    </p>

                    <h3>Compliance with the Law</h3>
                    <p>
                        Customers agree to comply with applicable South African laws when using the
                        website and purchasing or hiring equipment and services through the platform.
                    </p>

                    <h3>Severability</h3>
                    <p>
                        If any provision of these Terms and Conditions is found to be invalid or
                        unenforceable, the remaining provisions will continue to apply to the extent
                        permitted by law.
                    </p>
                
                    <div class="tc-notice">
                        You have reached the final section. Please make sure you have read all
                        ten sections before completing the final acceptance.
                    </div>

                    <div class="tc-final-agreement">
                        <label class="tc-checkbox">
                            <input type="checkbox" id="finalAgreement" />
                            <span>
                                I confirm that I have read, understood and agree to all 10 sections
                                of these Terms and Conditions.
                            </span>
                        </label>
                    </div>
</section>

            </main>

            <!-- BUTTONS -->
            <div class="tc-actions">

                <div class="tc-actions-left">
                    <button type="button"
                            class="terms-btn terms-btn-decline"
                            onclick="declineCurrentSection()">
                        Decline
                    </button>

                    <button type="button"
                            id="backButton"
                            class="terms-btn terms-btn-back"
                            onclick="goBack()">
                        Back
                    </button>
                </div>

                <div class="tc-actions-right">
                    <button type="button"
                            id="acceptSectionButton"
                            class="terms-btn terms-btn-accept"
                            onclick="acceptCurrentSection()">
                        Accept
                    </button>

                    <button type="button"
                            id="nextButton"
                            class="terms-btn terms-btn-next"
                            onclick="goNext()">
                        Next
                    </button>

                    <button type="button"
                            id="finishButton"
                            class="terms-btn terms-btn-accept"
                            onclick="acceptTerms()"
                            style="display:none;">
                        Accept Terms &amp; Continue
                    </button>
                </div>

            </div>

        </div>

    </div>


    <div id="tcModalBackdrop" class="tc-modal-backdrop" role="dialog" aria-modal="true">
        <div class="tc-modal">
            <div id="tcModalTitle" class="tc-modal-header">Terms and Conditions</div>
            <div id="tcModalMessage" class="tc-modal-body"></div>
            <div class="tc-modal-actions">
                <button type="button" id="tcModalCancel" class="tc-modal-btn tc-modal-btn-secondary" style="display:none;">Cancel</button>
                <button type="button" id="tcModalOk" class="tc-modal-btn">OK</button>
            </div>
        </div>
    </div>

</form>

<script>
    let currentSection = 1;
    const totalSections = 10;

    const sectionAccepted = {
        1: false, 2: false, 3: false, 4: false, 5: false,
        6: false, 7: false, 8: false, 9: false, 10: false
    };

    const sectionTitles = {
        1: "Introduction", 2: "Company Policy", 3: "Privacy Policy",
        4: "Cookie Policy", 5: "Returns and Refunds", 6: "Booking Policy",
        7: "Payment and Pricing Policy", 8: "Delivery and Collection",
        9: "Damage and Liability", 10: "Governing Law"
    };

    let modalOkAction = null;
    let modalCancelAction = null;

    function showPopup(title, message, okAction, cancelAction) {
        document.getElementById("tcModalTitle").textContent = title;
        document.getElementById("tcModalMessage").textContent = message;

        const cancel = document.getElementById("tcModalCancel");
        if (cancelAction) {
            cancel.style.display = "inline-block";
            modalCancelAction = cancelAction;
        } else {
            cancel.style.display = "none";
            modalCancelAction = null;
        }

        modalOkAction = okAction || null;
        document.getElementById("tcModalBackdrop").style.display = "flex";
    }

    function closePopup() {
        document.getElementById("tcModalBackdrop").style.display = "none";
        modalOkAction = null;
        modalCancelAction = null;
    }

    function showSection(number) {
        document.querySelectorAll(".tc-section").forEach(function (section) {
            section.classList.remove("active");
        });

        const selected = document.querySelector('.tc-section[data-section="' + number + '"]');
        if (selected) selected.classList.add("active");

        currentSection = number;
        document.getElementById("stepText").textContent =
            "Section " + number + " of " + totalSections;
        document.getElementById("stepTitle").textContent =
            sectionTitles[number];
        document.getElementById("progressFill").style.width =
            ((number / totalSections) * 100) + "%";

        document.getElementById("backButton").style.visibility =
            number === 1 ? "hidden" : "visible";

        const acceptButton = document.getElementById("acceptSectionButton");
        const nextButton = document.getElementById("nextButton");
        const finishButton = document.getElementById("finishButton");

        if (number === totalSections) {
            acceptButton.style.display = "none";
            nextButton.style.display = "none";
            finishButton.style.display = "inline-block";
        } else {
            acceptButton.style.display = "inline-block";
            nextButton.style.display = "inline-block";
            finishButton.style.display = "none";

            if (sectionAccepted[number]) {
                acceptButton.textContent = "Accepted ✓";
                acceptButton.classList.add("terms-btn-accepted");
            } else {
                acceptButton.textContent = "Accept";
                acceptButton.classList.remove("terms-btn-accepted");
            }
        }

        window.scrollTo({ top: 0, behavior: "smooth" });
    }

    function acceptCurrentSection() {
        sectionAccepted[currentSection] = true;

        if (currentSection < totalSections) {
            showSection(currentSection + 1);
        }
    }

    function declineCurrentSection() {
        showPopup(
            "Decline Terms",
            "You have declined this section. You cannot continue with the booking unless you accept the Terms and Conditions. Do you want to leave this page?",
            function () { window.location.href = "Home.aspx"; },
            function () { }
        );
    }

    function goNext() {
        if (!sectionAccepted[currentSection]) {
            showPopup(
                "Section Not Accepted",
                "Please click Accept before continuing to the next section.",
                null
            );
            return;
        }

        if (currentSection < totalSections) {
            showSection(currentSection + 1);
        }
    }

    function goBack() {
        if (currentSection > 1) showSection(currentSection - 1);
    }

    function acceptTerms() {
        const finalAgreement = document.getElementById("finalAgreement");

        if (!finalAgreement || !finalAgreement.checked) {
            showPopup(
                "Final Confirmation Required",
                "Please tick the final checkbox to confirm that you have read, understood and agree to all 10 sections.",
                null
            );
            return;
        }

        for (let i = 1; i <= 9; i++) {
            if (!sectionAccepted[i]) {
                showPopup(
                    "Section Not Accepted",
                    "Section " + i + " has not been accepted. Please go back and accept all sections before continuing.",
                    function () { showSection(i); }
                );
                return;
            }
        }

        sectionAccepted[10] = true;

        showPopup(
            "Terms Accepted",
            "You have completed all 10 sections and confirmed your agreement. Continue to checkout?",
            function () { window.location.href = "Checkout.aspx"; },
            function () { }
        );
    }

    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("tcModalOk").addEventListener("click", function () {
            const action = modalOkAction;
            closePopup();
            if (action) action();
        });

        document.getElementById("tcModalCancel").addEventListener("click", function () {
            const action = modalCancelAction;
            closePopup();
            if (action) action();
        });

        document.getElementById("tcModalBackdrop").addEventListener("click", function (e) {
            if (e.target === this) closePopup();
        });

        showSection(1);
    });
</script>

</body>
</html>
