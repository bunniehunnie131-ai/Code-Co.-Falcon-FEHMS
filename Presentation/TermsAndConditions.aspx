<%@ Page Title="Terms and Conditions"
    Language="C#"
    MasterPageFile="~/Presentation/SystemLayout.Master"
    AutoEventWireup="true"
    CodeBehind="TermsAndConditions.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm1" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <style>

        /* ==========================================
           TERMS PAGE
           ========================================== */

        .terms-container {
            max-width: 850px;
            margin: 50px auto;
            padding: 0 15px;
        }


        .terms-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }


        /* ==========================================
           HEADER
           ========================================== */

        .terms-header {
            background: #142c6b;
            color: #ffffff;
            padding: 35px;
            text-align: center;
        }


        .terms-header i {
            font-size: 45px;
            margin-bottom: 12px;
        }


        .terms-header h2 {
            margin-bottom: 8px;
            font-weight: 600;
        }


        .terms-header p {
            margin: 0;
            opacity: 0.9;
            font-size: 14px;
        }


        /* ==========================================
           PROGRESS
           ========================================== */

        .progress-area {
            padding: 20px 35px 0 35px;
        }


        .progress-text {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            color: #6c757d;
            margin-bottom: 8px;
        }


        .progress {
            height: 8px;
            border-radius: 10px;
            background-color: #e9ecef;
        }


        .progress-bar {
            background-color: #142c6b;
            border-radius: 10px;
        }


        /* ==========================================
           CONTENT
           ========================================== */

        .terms-content {
            padding: 35px;
        }


        .terms-section {
            display: none;
        }


        .terms-section.active {
            display: block;
        }


        .terms-section h3 {
            color: #142c6b;
            font-size: 23px;
            font-weight: 600;
            margin-bottom: 18px;
        }


        .terms-section h4 {
            color: #142c6b;
            font-size: 17px;
            margin-top: 20px;
            margin-bottom: 10px;
        }


        .terms-section p {
            color: #495057;
            line-height: 1.7;
            font-size: 14px;
        }


        .terms-section ul {
            color: #495057;
            line-height: 1.8;
            font-size: 14px;
            padding-left: 22px;
        }


        /* ==========================================
           FINAL AGREEMENT
           ========================================== */

        .final-agreement {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 20px;
            margin-top: 25px;
        }


        .final-agreement label {
            font-weight: 500;
            color: #343a40;
            cursor: pointer;
        }


        /* ==========================================
           BUTTONS
           ========================================== */

        .terms-buttons {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            padding: 0 35px 35px 35px;
        }


        .btn-back {
            border: 1px solid #6c757d;
            color: #495057;
            background: #ffffff;
            border-radius: 10px;
            padding: 11px 28px;
            font-weight: 500;
        }


        .btn-back:hover {
            background: #f1f3f5;
        }


        .btn-next,
        .btn-accept {
            background-color: #142c6b;
            color: #ffffff;
            border: none;
            border-radius: 10px;
            padding: 11px 28px;
            font-weight: 500;
        }


        .btn-next:hover,
        .btn-accept:hover {
            background-color: #0f2255;
            color: #ffffff;
        }


        .btn-accept:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }


        /* ==========================================
           MOBILE
           ========================================== */

        @media (max-width: 576px) {

            .terms-container {
                margin: 25px auto;
            }


            .terms-header {
                padding: 25px 20px;
            }


            .terms-content {
                padding: 25px 20px;
            }


            .progress-area {
                padding: 20px 20px 0 20px;
            }


            .terms-buttons {
                padding: 0 20px 25px 20px;
            }


            .btn-back,
            .btn-next,
            .btn-accept {
                width: 100%;
            }


            .terms-buttons {
                flex-direction: column;
            }

        }

    </style>

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <link href="Content/Forte.css" rel="stylesheet" />


    <div class="terms-container">

        <div class="terms-card">


            <!-- ======================================
                 HEADER
                 ====================================== -->

            <div class="terms-header">

                <i class="bi bi-file-earmark-text"></i>

                <h2>
                    Terms &amp; Conditions
                </h2>

                <p>
                    Please review all sections before creating your account.
                </p>

            </div>


            <!-- ======================================
                 PROGRESS
                 ====================================== -->

            <div class="progress-area">

                <div class="progress-text">

                    <span id="sectionTitle">
                        Section 1 of 10
                    </span>

                    <span id="sectionPercentage">
                        10%
                    </span>

                </div>


                <div class="progress">

                    <div id="termsProgress"
                         class="progress-bar"
                         role="progressbar"
                         style="width: 10%;">

                    </div>

                </div>

            </div>


            <!-- ======================================
                 TERMS CONTENT
                 ====================================== -->

            <div class="terms-content">


                <!-- ==================================
                     SECTION 1
                     ================================== -->

                <div class="terms-section active"
                     id="section1">

                    <h3>
                        1. Introduction
                    </h3>

                    <p>
                        Welcome to Forte Events Catering &amp; Decor Hire.
                        These Terms and Conditions explain the rules and
                        responsibilities that apply when using our platform
                        and services.
                    </p>

                    <p>
                        By creating an account, browsing our services or
                        making a booking, you acknowledge that you have read
                        and understood these Terms and Conditions.
                    </p>

                    <h4>
                        Purpose
                    </h4>

                    <p>
                        Forte Events Catering &amp; Decor Hire provides
                        customers with access to event catering, décor,
                        equipment hire and related event services.
                    </p>

                </div>


                <!-- ==================================
                     SECTION 2
                     ================================== -->

                <div class="terms-section"
                     id="section2">

                    <h3>
                        2. User Registration
                    </h3>

                    <p>
                        Customers must provide accurate and complete
                        information when creating an account.
                    </p>

                    <ul>

                        <li>
                            Your personal information must be accurate.
                        </li>

                        <li>
                            You are responsible for keeping your account
                            information up to date.
                        </li>

                        <li>
                            You must keep your login details confidential.
                        </li>

                        <li>
                            You should not share your password with other
                            people.
                        </li>

                    </ul>

                    <p>
                        Forte Events reserves the right to restrict or
                        terminate accounts where false, misleading or
                        inappropriate information has been provided.
                    </p>

                </div>


                <!-- ==================================
                     SECTION 3
                     ================================== -->

                <div class="terms-section"
                     id="section3">

                    <h3>
                        3. Bookings and Services
                    </h3>

                    <p>
                        Customers may browse available products and services
                        and submit bookings through the system.
                    </p>

                    <p>
                        A booking is subject to availability and confirmation
                        by Forte Events Catering &amp; Decor Hire.
                    </p>

                    <ul>

                        <li>
                            Customers should provide correct event details.
                        </li>

                        <li>
                            Booking dates and times must be accurate.
                        </li>

                        <li>
                            Customers should review their booking before
                            submitting it.
                        </li>

                        <li>
                            Services are subject to availability.
                        </li>

                    </ul>

                </div>


                <!-- ==================================
                     SECTION 4
                     ================================== -->

                <div class="terms-section"
                     id="section4">

                    <h3>
                        4. Payments
                    </h3>

                    <p>
                        Where payment is required, customers are responsible
                        for making the required payment according to the
                        booking arrangements.
                    </p>

                    <p>
                        Customers should ensure that payment information is
                        entered correctly and that sufficient funds are
                        available where applicable.
                    </p>

                    <p>
                        Payment confirmation may be required before a booking
                        can be considered fully confirmed.
                    </p>

                </div>


                <!-- ==================================
                     SECTION 5
                     ================================== -->

                <div class="terms-section"
                     id="section5">

                    <h3>
                        5. Cancellation and Changes
                    </h3>

                    <p>
                        Customers should contact Forte Events as soon as
                        possible if they need to change or cancel a booking.
                    </p>

                    <p>
                        Cancellation and modification arrangements may depend
                        on the type of service booked and how close the
                        cancellation is to the event date.
                    </p>

                    <p>
                        Customers are encouraged to review the applicable
                        booking information before confirming their event.
                    </p>

                </div>


                <!-- ==================================
                     SECTION 6
                     ================================== -->

                <div class="terms-section"
                     id="section6">

                    <h3>
                        6. Customer Responsibilities
                    </h3>

                    <p>
                        Customers are responsible for providing accurate event
                        information and ensuring that the venue is suitable
                        for the requested services.
                    </p>

                    <ul>

                        <li>
                            Provide accurate event information.
                        </li>

                        <li>
                            Provide suitable access to the event venue.
                        </li>

                        <li>
                            Treat hired equipment responsibly.
                        </li>

                        <li>
                            Report problems or damages as soon as possible.
                        </li>

                    </ul>

                </div>


                <!-- ==================================
                     SECTION 7
                     ================================== -->

                <div class="terms-section"
                     id="section7">

                    <h3>
                        7. Equipment and Property
                    </h3>

                    <p>
                        Any equipment, décor items, tables, chairs or other
                        property supplied by Forte Events remains the property
                        of the company unless otherwise agreed.
                    </p>

                    <p>
                        Customers are expected to take reasonable care of
                        hired items during the booking period.
                    </p>

                    <p>
                        Customers may be responsible for costs resulting from
                        loss or damage caused by negligence or misuse.
                    </p>

                </div>


                <!-- ==================================
                     SECTION 8
                     ================================== -->

                <div class="terms-section"
                     id="section8">

                    <h3>
                        8. Privacy and Personal Information
                    </h3>

                    <p>
                        Forte Events may collect personal information required
                        to provide its services and manage customer accounts.
                    </p>

                    <p>
                        Personal information should be handled responsibly and
                        in accordance with applicable privacy requirements.
                    </p>

                    <p>
                        Customers should review the Privacy Policy for
                        additional information about how personal information
                        is handled.
                    </p>

                </div>


                <!-- ==================================
                     SECTION 9
                     ================================== -->

                <div class="terms-section"
                     id="section9">

                    <h3>
                        9. Acceptable Use
                    </h3>

                    <p>
                        Customers must use the Forte Events platform
                        responsibly and only for legitimate purposes.
                    </p>

                    <ul>

                        <li>
                            Do not provide intentionally false information.
                        </li>

                        <li>
                            Do not attempt to gain unauthorised access.
                        </li>

                        <li>
                            Do not interfere with the operation of the system.
                        </li>

                        <li>
                            Do not misuse another customer's account.
                        </li>

                    </ul>

                    <p>
                        Misuse of the system may result in access being
                        restricted or an account being suspended.
                    </p>

                </div>


                <!-- ==================================
                     SECTION 10
                     ================================== -->

                <div class="terms-section"
                     id="section10">

                    <h3>
                        10. Final Agreement
                    </h3>

                    <p>
                        You have reached the final section of the Terms and
                        Conditions.
                    </p>

                    <p>
                        Please confirm that you have reviewed all ten sections
                        and understand the responsibilities associated with
                        creating and using a Forte Events account.
                    </p>
                    </div>

            </div>


            <!-- ======================================
                 BUTTONS
                 ====================================== -->

            <div class="terms-buttons">


                <!-- BACK BUTTON -->

                <button type="button"
                        id="btnBack"
                        class="btn btn-back"
                        onclick="previousSection();">

                    <i class="bi bi-arrow-left"></i>

                    Back

                </button>


                <!-- NEXT BUTTON -->

                <button type="button"
                        id="btnNext"
                        class="btn btn-next"
                        onclick="nextSection();">

                    Next

                    <i class="bi bi-arrow-right"></i>

                </button>


                <!-- ACCEPT BUTTON -->

                <button type="button"
                        id="btnAccept"
                        class="btn btn-accept"
                        onclick="acceptTerms();"
                        style="display: none;">

                    Accept Terms &amp; Continue

                    <i class="bi bi-check-circle"></i>

                </button>

            </div>

        </div>

    </div>


    <!-- ==========================================
         JAVASCRIPT
         ========================================== -->

    <script>

        let currentSection = 1;

        const totalSections = 10;


        /* ==========================================
           SHOW SECTION
           ========================================== */

        function showSection(sectionNumber) {

            /*
             * Hide all sections.
             */

            for (let i = 1; i <= totalSections; i++) {

                const section =
                    document.getElementById(
                        "section" + i
                    );


                if (section) {

                    section.classList.remove(
                        "active"
                    );

                }

            }


            /*
             * Show selected section.
             */

            const current =
                document.getElementById(
                    "section" + sectionNumber
                );


            if (current) {

                current.classList.add(
                    "active"
                );

            }


            /*
             * Update progress.
             */

            const percentage =
                sectionNumber * 10;


            document.getElementById(
                "sectionTitle"
            ).innerText =
                "Section " +
                sectionNumber +
                " of 10";


            document.getElementById(
                "sectionPercentage"
            ).innerText =
                percentage + "%";


            document.getElementById(
                "termsProgress"
            ).style.width =
                percentage + "%";


            /*
             * Back button.
             *
             * Hide it on Section 1.
             */

            const backButton =
                document.getElementById(
                    "btnBack"
                );


            if (sectionNumber === 1) {

                backButton.style.display =
                    "none";

            }

            else {

                backButton.style.display =
                    "inline-block";

            }


            /*
             * Next button.
             *
             * Hide it on final section.
             */

            const nextButton =
                document.getElementById(
                    "btnNext"
                );


            /*
             * Accept button.
             *
             * Only appears on Section 10.
             */

            const acceptButton =
                document.getElementById(
                    "btnAccept"
                );


            if (sectionNumber === totalSections) {

                nextButton.style.display =
                    "none";

                acceptButton.style.display =
                    "inline-block";

            }

            else {

                nextButton.style.display =
                    "inline-block";

                acceptButton.style.display =
                    "none";

            }

        }


        /* ==========================================
           NEXT SECTION
           ========================================== */

        function nextSection() {

            if (currentSection < totalSections) {

                currentSection++;

                showSection(
                    currentSection
                );

            }

        }


        /* ==========================================
           PREVIOUS SECTION
           ========================================== */

        function previousSection() {

            if (currentSection > 1) {

                currentSection--;

                showSection(
                    currentSection
                );

            }

        }


        /* ==========================================
           ACCEPT TERMS
           ========================================== */

        function acceptTerms() {

            const finalAgreement =
                document.getElementById(
                    "finalAgreement"
                );


            /*
             * Save acceptance.
             */

            sessionStorage.setItem(
                "termsAccepted",
                "true"
            );


            /*
             * Remember that the customer
             * came from Registration.
             */

            sessionStorage.setItem(
                "returnToRegistration",
                "true"
            );


            /*
             * Return to Registration.
             */

            window.location.href =
                "Registration.aspx";

        }


        /* ==========================================
           PAGE LOAD
           ========================================== */

        window.addEventListener(
            "load",
            function () {

                /*
                 * Start at Section 1.
                 */

                currentSection = 1;

                showSection(
                    currentSection
                );

            }
        );

    </script>

</asp:Content>