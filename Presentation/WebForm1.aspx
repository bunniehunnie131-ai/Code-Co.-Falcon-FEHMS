%@ Page Title="Terms and Conditions"
    Language="C#"
    AutoEventWireup="true"
    CodeBehind="TermsAndConditions.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Terms and Conditions</title>


    <style>

        :root {

            --royal-blue: #142c6b;

            --royal-blue-dark: #0f2255;

            --light-blue: #eef3fc;

            --border: #e5e8ee;

            --text: #333c4d;

            --muted: #6b7280;

            --green: #198754;

        }


        * {

            box-sizing: border-box;

        }


        body {

            margin: 0;

            background: #f5f7fb;

            font-family: "Segoe UI", Arial, sans-serif;

            color: var(--text);

        }


        .terms-wrapper {

            max-width: 1000px;

            margin: 40px auto;

            padding: 0 20px 50px;

        }


        .page-title {

            margin-bottom: 20px;

        }


        .page-title h1 {

            color: var(--royal-blue);

            margin: 0 0 6px;

            font-size: 30px;

        }


        .page-title p {

            color: var(--muted);

            margin: 0;

        }


        .terms-card {

            background: white;

            border: 1px solid var(--border);

            border-radius: 14px;

            overflow: hidden;

            box-shadow: 0 5px 20px rgba(0,0,0,.06);

        }


        /* =====================================================
           PROGRESS
           ===================================================== */

        .progress-area {

            padding: 22px 30px;

            background: #f8fafd;

            border-bottom: 1px solid var(--border);

        }


        .progress-header {

            display: flex;

            justify-content: space-between;

            margin-bottom: 12px;

        }


        .progress-title {

            font-weight: 700;

            color: var(--royal-blue);

        }


        .progress-name {

            color: var(--muted);

            font-size: 14px;

        }


        .progress-bar {

            height: 8px;

            background: #e4e8f0;

            border-radius: 20px;

            overflow: hidden;

        }


        .progress-fill {

            height: 100%;

            width: 10%;

            background: var(--royal-blue);

            border-radius: 20px;

            transition: width .3s ease;

        }


        /* =====================================================
           CONTENT
           ===================================================== */

        .terms-content {

            padding: 35px;

            min-height: 520px;

        }


        .terms-section {

            display: none;

        }


        .terms-section.active {

            display: block;

            animation: fadeIn .2s ease;

        }


        @keyframes fadeIn {

            from {

                opacity: 0;

                transform: translateY(5px);

            }

            to {

                opacity: 1;

                transform: translateY(0);

            }

        }


        .terms-section h2 {

            color: var(--royal-blue);

            margin-top: 0;

            margin-bottom: 20px;

        }


        .terms-section h3 {

            color: var(--royal-blue);

            margin-top: 25px;

            margin-bottom: 8px;

            font-size: 17px;

        }


        .terms-section p,

        .terms-section li {

            font-size: 14px;

            line-height: 1.7;

        }


        .terms-section ul {

            padding-left: 25px;

        }


        .notice {

            margin-top: 25px;

            padding: 15px 18px;

            background: var(--light-blue);

            border-left: 4px solid var(--royal-blue);

            border-radius: 6px;

        }


        /* =====================================================
           FINAL CHECKBOX
           ===================================================== */

        .final-agreement {

            margin-top: 30px;

            padding: 20px;

            background: #f8fafd;

            border: 1px solid var(--border);

            border-radius: 8px;

        }


        .final-agreement label {

            display: flex;

            gap: 10px;

            align-items: flex-start;

            font-size: 14px;

            line-height: 1.5;

            cursor: pointer;

        }


        .final-agreement input {

            width: 18px;

            height: 18px;

            margin-top: 2px;

            cursor: pointer;

            accent-color: var(--green);

        }


        /* =====================================================
           BUTTONS
           ===================================================== */

        .button-area {

            display: flex;

            justify-content: space-between;

            align-items: center;

            padding: 20px 30px;

            background: #fafbfc;

            border-top: 1px solid var(--border);

        }


        .button-group {

            display: flex;

            gap: 10px;

        }


        .terms-button {

            border-radius: 8px;

            padding: 11px 22px;

            font-size: 14px;

            font-weight: 600;

            cursor: pointer;

            transition: .2s ease;

        }


        .back-button {

            background: white;

            color: var(--royal-blue);

            border: 1px solid var(--royal-blue);

        }


        .back-button:hover {

            background: var(--light-blue);

        }


        .next-button {

            background: var(--royal-blue);

            color: white;

            border: 1px solid var(--royal-blue);

        }


        .next-button:hover {

            background: var(--royal-blue-dark);

        }


        .accept-button {

            background: var(--green);

            color: white;

            border: 1px solid var(--green);

        }


        .accept-button:hover {

            background: #146c43;

        }


        .hidden {

            visibility: hidden;

        }


        /* =====================================================
           MOBILE
           ===================================================== */

        @media (max-width: 700px) {

            .terms-content {

                padding: 25px 20px;

            }


            .button-area {

                flex-direction: column;

                gap: 10px;

            }


            .button-group {

                width: 100%;

            }


            .terms-button {

                flex: 1;

            }


            .progress-header {

                flex-direction: column;

                gap: 5px;

            }

        }

    </style>

</head>


<body>


<form id="form1" runat="server">


    <div class="terms-wrapper">


        <!-- =====================================================
             TITLE
             ===================================================== -->

        <div class="page-title">

            <h1>
                Terms and Conditions
            </h1>

            <p>
                Please read each section carefully before accepting.
            </p>

        </div>


        <div class="terms-card">


            <!-- =====================================================
                 PROGRESS
                 ===================================================== -->

            <div class="progress-area">

                <div class="progress-header">

                    <span id="stepText"
                          class="progress-title">

                        Section 1 of 10

                    </span>


                    <span id="stepTitle"
                          class="progress-name">

                        Introduction

                    </span>

                </div>


                <div class="progress-bar">

                    <div id="progressFill"
                         class="progress-fill">
                    </div>

                </div>

            </div>


            <!-- =====================================================
                 TERMS CONTENT
                 ===================================================== -->

            <div class="terms-content">


                <!-- ==================== SECTION 1 ==================== -->

                <section class="terms-section active"
                         data-section="1">

                    <h2>
                        1. Introduction
                    </h2>

                    <p>
                        These Terms and Conditions govern your use of the
                        Forte Events Catering &amp; Decor Hire website and
                        the hiring, booking, delivery, collection and return
                        of event equipment and related services.
                    </p>

                    <p>
                        By accessing the website, creating an account,
                        browsing available products, requesting a booking,
                        making a payment or hiring equipment, you acknowledge
                        that you have read, understood and agreed to these
                        Terms and Conditions.
                    </p>

                    <p>
                        If you do not agree with these Terms and Conditions,
                        you should not continue with a booking or use services
                        provided through the platform.
                    </p>

                    <h3>
                        Information Provided by Customers
                    </h3>

                    <p>
                        Customers must provide complete, accurate and current
                        information when registering, making a booking,
                        providing event details, selecting delivery or
                        collection and making payments.
                    </p>

                    <h3>
                        Changes to These Terms
                    </h3>

                    <p>
                        We may update these Terms and Conditions when necessary.
                        Changes will be displayed on the website.
                    </p>

                </section>


                <!-- ==================== SECTION 2 ==================== -->

                <section class="terms-section"
                         data-section="2">

                    <h2>
                        2. Company Policy
                    </h2>

                    <p>
                        Our company aims to provide reliable, professional
                        and quality event equipment and services.
                    </p>

                    <h3>
                        Our Responsibilities
                    </h3>

                    <ul>

                        <li>
                            Provide equipment corresponding with the confirmed booking.
                        </li>

                        <li>
                            Provide accurate information about equipment and services.
                        </li>

                        <li>
                            Inform customers if an item becomes unavailable.
                        </li>

                        <li>
                            Maintain reasonable standards of cleanliness and functionality.
                        </li>

                        <li>
                            Provide relevant booking and payment information.
                        </li>

                        <li>
                            Handle customer information according to applicable privacy requirements.
                        </li>

                    </ul>


                    <h3>
                        Customer Responsibilities
                    </h3>

                    <ul>

                        <li>
                            Provide correct personal and contact information.
                        </li>

                        <li>
                            Provide accurate event dates, times and locations.
                        </li>

                        <li>
                            Make required payments within the required period.
                        </li>

                        <li>
                            Use hired equipment responsibly.
                        </li>

                        <li>
                            Return equipment in the condition in which it was received.
                        </li>

                        <li>
                            Report problems with equipment as soon as possible.
                        </li>

                    </ul>

                </section>


                <!-- ==================== SECTION 3 ==================== -->

                <section class="terms-section"
                         data-section="3">

                    <h2>
                        3. Privacy Policy
                    </h2>

                    <p>
                        We collect and process customer information when
                        customers use the website, create an account,
                        make a booking, submit an enquiry or make a payment.
                    </p>

                    <h3>
                        Information We May Collect
                    </h3>

                    <ul>

                        <li>Full name</li>

                        <li>Contact number</li>

                        <li>Email address</li>

                        <li>Delivery address</li>

                        <li>Booking and event information</li>

                        <li>Payment-related information</li>

                        <li>Communications between the customer and the company</li>

                    </ul>


                    <h3>
                        How Information Is Used
                    </h3>

                    <ul>

                        <li>Create and manage customer accounts.</li>

                        <li>Process and confirm bookings.</li>

                        <li>Process payments and deposits.</li>

                        <li>Arrange delivery and collection.</li>

                        <li>Communicate with customers.</li>

                        <li>Improve the website and services.</li>

                    </ul>

                </section>


                <!-- ==================== SECTION 4 ==================== -->

                <section class="terms-section"
                         data-section="4">

                    <h2>
                        4. Cookie Policy
                    </h2>

                    <p>
                        The website may use cookies and similar technologies
                        to improve functionality, performance and the
                        browsing experience.
                    </p>

                    <h3>
                        Purpose of Cookies
                    </h3>

                    <ul>

                        <li>Remember user preferences.</li>

                        <li>Maintain login or session information.</li>

                        <li>Keep items in a customer's basket.</li>

                        <li>Improve website functionality.</li>

                        <li>Understand how customers use the website.</li>

                        <li>Improve website performance.</li>

                    </ul>

                    <p>
                        Customers may configure their browser to block or
                        delete cookies. However, disabling necessary cookies
                        may cause certain website features to stop functioning.
                    </p>

                </section>


                <!-- ==================== SECTION 5 ==================== -->

                <section class="terms-section"
                         data-section="5">

                    <h2>
                        5. Returns and Refunds
                    </h2>

                    <p>
                        Customers must return hired equipment at the agreed
                        time and in substantially the same condition in which
                        it was provided, excluding reasonable wear and tear.
                    </p>

                    <h3>
                        Returned Equipment
                    </h3>

                    <p>
                        Equipment must be returned complete with all
                        accessories, components and related items supplied
                        as part of the booking.
                    </p>

                    <h3>
                        Damaged or Missing Equipment
                    </h3>

                    <p>
                        A customer may be responsible for equipment that is
                        lost, stolen, broken or damaged through misuse.
                    </p>

                    <h3>
                        Cancellation
                    </h3>

                    <p>
                        Customers wishing to cancel should contact the company
                        as soon as possible.
                    </p>

                </section>


                <!-- ==================== SECTION 6 ==================== -->

                <section class="terms-section"
                         data-section="6">

                    <h2>
                        6. Booking Policy
                    </h2>

                    <p>
                        A booking is considered confirmed only after the
                        required booking information has been submitted and
                        the applicable payment, deposit or confirmation
                        requirements have been completed.
                    </p>

                    <h3>
                        Required Booking Information
                    </h3>

                    <ul>

                        <li>Customer name</li>

                        <li>Contact details</li>

                        <li>Event date</li>

                        <li>Event time</li>

                        <li>Event location</li>

                        <li>Equipment required</li>

                        <li>Quantity required</li>

                        <li>Delivery or collection preference</li>

                    </ul>

                    <h3>
                        Availability
                    </h3>

                    <p>
                        All equipment and services are subject to availability.
                    </p>

                </section>


                <!-- ==================== SECTION 7 ==================== -->

                <section class="terms-section"
                         data-section="7">

                    <h2>
                        7. Payment and Pricing Policy
                    </h2>

                    <p>
                        Prices displayed on the website may change. Unless
                        otherwise stated, the applicable price will generally
                        be the price presented to the customer when the booking
                        is made and confirmed.
                    </p>

                    <h3>
                        Deposits and Payments
                    </h3>

                    <p>
                        Customers may be required to pay a deposit or the full
                        booking amount before a booking can be confirmed.
                    </p>

                    <h3>
                        When a Booking May Not Be Confirmed
                    </h3>

                    <ul>

                        <li>Payment has not been received.</li>

                        <li>The required deposit has not been paid.</li>

                        <li>Payment has failed.</li>

                        <li>Payment information is invalid.</li>

                        <li>Required booking information is incomplete.</li>

                    </ul>

                </section>


                <!-- ==================== SECTION 8 ==================== -->

                <section class="terms-section"
                         data-section="8">

                    <h2>
                        8. Delivery and Collection
                    </h2>

                    <p>
                        Customers may choose between delivery and collection
                        where these options are available for the booking.
                    </p>

                    <h3>
                        Delivery
                    </h3>

                    <ul>

                        <li>A complete and accurate delivery address.</li>

                        <li>Contact details.</li>

                        <li>The required delivery date.</li>

                        <li>Relevant access information.</li>

                    </ul>

                    <h3>
                        Collection
                    </h3>

                    <p>
                        Where collection is selected, customers are responsible
                        for collecting the equipment at the agreed time and
                        returning it by the agreed return time.
                    </p>

                    <h3>
                        Delivery Delays
                    </h3>

                    <p>
                        Reasonable efforts will be made to meet agreed delivery
                        times. Delays may occur because of traffic, weather,
                        road conditions or unexpected operational problems.
                    </p>

                </section>


                <!-- ==================== SECTION 9 ==================== -->

                <section class="terms-section"
                         data-section="9">

                    <h2>
                        9. Damage and Liability
                    </h2>

                    <p>
                        Customers are responsible for taking reasonable care
                        of all hired equipment while it is in their possession.
                    </p>

                    <p>
                        Customers must not intentionally misuse, modify, sell,
                        transfer or sub-hire hired equipment without permission.
                    </p>

                    <h3>
                        Damage and Loss
                    </h3>

                    <p>
                        Customers may be responsible for reasonable repair or
                        replacement costs where equipment is damaged, lost or
                        stolen while under their responsibility.
                    </p>

                    <h3>
                        Limitation of Liability
                    </h3>

                    <p>
                        We will make reasonable efforts to provide reliable
                        equipment and services. However, we cannot be held
                        responsible for circumstances outside our reasonable
                        control.
                    </p>

                </section>


                <!-- ==================== SECTION 10 ==================== -->

                <section class="terms-section"
                         data-section="10">

                    <h2>
                        10. Governing Law
                    </h2>

                    <p>
                        These Terms and Conditions are governed by the laws
                        of the Republic of South Africa.
                    </p>

                    <h3>
                        Dispute Resolution
                    </h3>

                    <p>
                        Any dispute relating to the website, bookings,
                        payments, hired equipment or services should first
                        be raised directly with the company.
                    </p>

                    <h3>
                        Compliance with the Law
                    </h3>

                    <p>
                        Customers agree to comply with applicable South African
                        laws when using the website and hiring equipment and
                        services through the platform.
                    </p>


                    <div class="notice">

                        You have reached the final section.

                        Please confirm that you have read and understood
                        all ten sections before accepting.

                    </div>


                    <!-- =================================================
                         THIS WAS MISSING FROM YOUR ORIGINAL WEBFORM1
                         ================================================= -->

                    <div class="final-agreement">

                        <label>

                            <input type="checkbox"
                                   id="finalAgreement" />

                            <span>

                                I confirm that I have read, understood and
                                agree to all 10 sections of the Terms and
                                Conditions.

                            </span>

                        </label>

                    </div>

                </section>


            </div>


            <!-- =====================================================
                 NAVIGATION BUTTONS
                 ===================================================== -->

            <div class="button-area">


                <!-- BACK -->

                <div class="button-group">

                    <button type="button"
                            id="backButton"
                            class="terms-button back-button"
                            onclick="goBack()">

                        Back

                    </button>

                </div>


                <!-- NEXT / ACCEPT -->

                <div class="button-group">

                    <button type="button"
                            id="nextButton"
                            class="terms-button next-button"
                            onclick="goNext()">

                        Next

                    </button>


                    <button type="button"
                            id="acceptButton"
                            class="terms-button accept-button"
                            onclick="acceptTerms()"
                            style="display:none;">

                        Accept Terms and Conditions &amp; Continue

                    </button>

                </div>

            </div>


        </div>

    </div>


</form>


<script>

    /* =====================================================
       VARIABLES
       ===================================================== */

    let currentSection = 1;

    const totalSections = 10;


    /* =====================================================
       SECTION NAMES
       ===================================================== */

    const sectionTitles = {

        1: "Introduction",

        2: "Company Policy",

        3: "Privacy Policy",

        4: "Cookie Policy",

        5: "Returns and Refunds",

        6: "Booking Policy",

        7: "Payment and Pricing Policy",

        8: "Delivery and Collection",

        9: "Damage and Liability",

        10: "Governing Law"

    };


    /* =====================================================
       SHOW SECTION
       ===================================================== */

    function showSection(sectionNumber) {


        /*
         * Hide every section.
         */

        document
            .querySelectorAll(".terms-section")
            .forEach(function (section) {

                section.classList.remove("active");

            });


        /*
         * Find selected section.
         */

        const selectedSection =
            document.querySelector(
                '.terms-section[data-section="' +
                sectionNumber +
                '"]'
            );


        /*
         * Show selected section.
         */

        if (selectedSection) {

            selectedSection.classList.add("active");

        }


        currentSection = sectionNumber;


        /*
         * Update section number.
         */

        document.getElementById(
            "stepText"
        ).textContent =
            "Section " +
            sectionNumber +
            " of " +
            totalSections;


        /*
         * Update section name.
         */

        document.getElementById(
            "stepTitle"
        ).textContent =
            sectionTitles[sectionNumber];


        /*
         * Update progress bar.
         */

        document.getElementById(
            "progressFill"
        ).style.width =
            ((sectionNumber / totalSections) * 100) +
            "%";


        /*
         * BACK BUTTON
         *
         * Hidden on Section 1.
         */

        if (sectionNumber === 1) {

            document.getElementById(
                "backButton"
            ).classList.add("hidden");

        }
        else {

            document.getElementById(
                "backButton"
            ).classList.remove("hidden");

        }


        /*
         * NEXT / ACCEPT BUTTONS
         */

        if (sectionNumber === totalSections) {

            /*
             * Section 10:
             * Hide Next.
             */

            document.getElementById(
                "nextButton"
            ).style.display = "none";


            /*
             * Section 10:
             * Show Accept.
             */

            document.getElementById(
                "acceptButton"
            ).style.display = "inline-block";

        }
        else {

            /*
             * Sections 1-9:
             * Show Next.
             */

            document.getElementById(
                "nextButton"
            ).style.display = "inline-block";


            /*
             * Sections 1-9:
             * Hide Accept.
             */

            document.getElementById(
                "acceptButton"
            ).style.display = "none";

        }


        /*
         * Scroll to top.
         */

        window.scrollTo({

            top: 0,

            behavior: "smooth"

        });

    }


    /* =====================================================
       NEXT BUTTON
       ===================================================== */

    function goNext() {

        if (currentSection < totalSections) {

            showSection(
                currentSection + 1
            );

        }

    }


    /* =====================================================
       BACK BUTTON
       ===================================================== */

    function goBack() {

        if (currentSection > 1) {

            showSection(
                currentSection - 1
            );

        }

    }


    /* =====================================================
       ACCEPT TERMS
       ===================================================== */

    function acceptTerms() {


        /*
         * Get the Section 10 checkbox.
         */

        const finalAgreement =
            document.getElementById(
                "finalAgreement"
            );


        /*
         * Make sure it exists.
         */

        if (!finalAgreement) {

            alert(
                "The final agreement checkbox could not be found."
            );

            return;

        }


       


        /*
         * =================================================
         * THIS IS THE IMPORTANT PART
         * =================================================
         *
         * Save the acceptance.
         */

        sessionStorage.setItem(
            "termsAccepted",
            "true"
        );


        /*
         * Tell Registration that the
         * customer came from Terms.
         */

        sessionStorage.setItem(
            "returnToRegistration",
            "true"
        );


        /*
         * Redirect back to Registration.
         */

        window.location.href =
            "Registration.aspx";

    }


    /* =====================================================
       PAGE LOAD
       ===================================================== */

    document.addEventListener(
        "DOMContentLoaded",
        function () {

            showSection(1);

        }
    );

</script>


</body>

</html>
