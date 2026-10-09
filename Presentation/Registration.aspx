<%@ Page Title="Registration"
    Language="C#"
    MasterPageFile="~/Presentation/SystemLayout.Master"
    AutoEventWireup="true"
    CodeBehind="Registration.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm8" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <style>

        .register-container {
            max-width: 500px;
            margin: 60px auto;
        }

        .register-card {
            background: #ffffff;
            padding: 35px;
            border-radius: 14px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.08);
        }

        .register-card h3 {
            text-align: center;
            font-weight: 600;
            color: #142c6b;
            margin-bottom: 8px;
        }

        .register-card p {
            text-align: center;
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 25px;
        }

        .form-control,
        .form-select {
            border-radius: 10px;
            padding: 12px;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #142c6b;
            box-shadow: 0 0 0 0.15rem rgba(20, 44, 107, 0.15);
        }

        .btn-register {
            background-color: #142c6b;
            border: none;
            color: #ffffff;
            border-radius: 10px;
            padding: 12px;
            font-weight: 500;
        }

        .btn-register:hover {
            background-color: #0f2255;
            color: #ffffff;
        }

        .terms {
            font-size: 13px;
        }

        .terms a {
            color: #0d6efd;
            text-decoration: none;
            cursor: pointer;
        }

        .terms a:hover {
            text-decoration: underline;
        }

        .bottom-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .bottom-link a {
            color: #0d6efd;
            text-decoration: none;
        }

        .bottom-link a:hover {
            text-decoration: underline;
        }

        .terms-status {
            display: none;
            margin-top: 8px;
            color: #198754;
            font-size: 13px;
            font-weight: 500;
        }

        .terms-info {
            margin-top: 5px;
            color: #6c757d;
            font-size: 12px;
        }

    </style>

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <link href="Content/Forte.css" rel="stylesheet" />


    <div class="register-container">

        <div class="register-card">

            <h3>
                Create Your Account
            </h3>

            <p>
                Join Forte Events Catering &amp; Decor Hire
            </p>


            <!-- FULL NAME -->

            <div class="mb-3">

                <asp:TextBox
                    ID="txtFullName"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Full Name">
                </asp:TextBox>

            </div>


            <!-- EMAIL -->

            <div class="mb-3">

                <asp:TextBox
                    ID="txtEmailAddress"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Email Address"
                    TextMode="Email">
                </asp:TextBox>

            </div>


            <!-- DATE OF BIRTH -->

            <div class="mb-3">

                <asp:TextBox
                    ID="txtDateOfBirth"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Date">
                </asp:TextBox>

            </div>


            <!-- ID NUMBER -->

            <div class="mb-3">

                <asp:TextBox
                    ID="txtIDNumber"
                    runat="server"
                    CssClass="form-control"
                    placeholder="ID Number">
                </asp:TextBox>

            </div>


            <!-- PASSWORD -->

            <div class="mb-3">

                <asp:TextBox
                    ID="txtPassword"
                    runat="server"
                    TextMode="Password"
                    CssClass="form-control"
                    placeholder="Password">
                </asp:TextBox>

            </div>


            <!-- CONFIRM PASSWORD -->

            <div class="mb-3">

                <asp:TextBox
                    ID="txtConfirmPassword"
                    runat="server"
                    TextMode="Password"
                    CssClass="form-control"
                    placeholder="Confirm Password">
                </asp:TextBox>

            </div>


            <!-- TERMS AND CONDITIONS -->

            <div class="terms mb-3">

                <div class="form-check">

                    <asp:CheckBox
                        ID="cbUserAgreement"
                        runat="server"
                        CssClass="form-check-input"
                        onclick="openTermsAndConditions(this);" />

                    <label class="form-check-label">

                        I agree to the

                        <a href="javascript:void(0);"
                           onclick="openTermsPage();">

                            Terms &amp; Conditions

                        </a>

                        and

                        <a href="PrivacyPolicy.aspx">

                            Privacy Policy

                        </a>

                    </label>

                </div>


                <div class="terms-info">

                    You must review and accept the Terms &amp; Conditions
                    before registering.

                </div>


                <!-- ACCEPTED MESSAGE -->

                <div id="termsStatus"
                     class="terms-status">

                    ✓ Terms and Conditions accepted

                </div>

            </div>


            <!-- REGISTER BUTTON -->

            <div class="d-grid">

                <asp:Button
                    ID="btnRegister"
                    runat="server"
                    Text="Register"
                    CssClass="btn btn-register"
                    OnClientClick="return checkTermsBeforeRegister();"
                   
                    />

            </div>


            <!-- LOGIN -->

            <div class="bottom-link">

                Already have an account?

                <asp:HyperLink
                    ID="hlLoginHere"
                    runat="server"
                    NavigateUrl="Login.aspx">

                    Login here

                </asp:HyperLink>

            </div>

        </div>

    </div>


     <script>
         

        /* =====================================================
           SAVE REGISTRATION INFORMATION
           ===================================================== */

        function saveRegistrationDetails() {

            sessionStorage.setItem(
                "registrationFullName",
                document.getElementById(
                    "<%= txtFullName.ClientID %>"
                ).value
            );


            sessionStorage.setItem(
                "registrationEmail",
                document.getElementById(
                    "<%= txtEmailAddress.ClientID %>"
                ).value
            );


            sessionStorage.setItem(
                "registrationDOB",
                document.getElementById(
                    "<%= txtDateOfBirth.ClientID %>"
                ).value
            );


            sessionStorage.setItem(
                "registrationID",
                document.getElementById(
                    "<%= txtIDNumber.ClientID %>"
                ).value
            );


            sessionStorage.setItem(
                "registrationPassword",
                document.getElementById(
                    "<%= txtPassword.ClientID %>"
                ).value
            );


            sessionStorage.setItem(
                "registrationConfirmPassword",
                document.getElementById(
                    "<%= txtConfirmPassword.ClientID %>"
                ).value
            );

        }


        /* =====================================================
           OPEN TERMS WHEN REGISTRATION CHECKBOX IS CLICKED
           ===================================================== */

        function openTermsAndConditions(checkbox) {

            /*
             * Only redirect when the customer
             * is trying to check the box.
             */

            if (checkbox.checked) {

                /*
                 * Save registration details.
                 */

                saveRegistrationDetails();


                /*
                 * Tell WebForm1 that we came
                 * from Registration.
                 */

                sessionStorage.setItem(
                    "returnToRegistration",
                    "true"
                );


                /*
                 * Remove any old acceptance.
                 */

                sessionStorage.removeItem(
                    "termsAccepted"
                );


                /*
                 * Open Terms and Conditions.
                 */

                window.location.href =
                    "WebForm1.aspx";

            }

            else {

                /*
                 * Customer manually unchecked
                 * the checkbox.
                 */

                sessionStorage.removeItem(
                    "termsAccepted"
                );


                const status =
                    document.getElementById(
                        "termsStatus"
                    );


                if (status) {

                    status.style.display =
                        "none";

                }

            }

        }


        /* =====================================================
           OPEN TERMS USING TEXT LINK
           ===================================================== */

        function openTermsPage() {

            /*
             * Save registration information
             * before leaving the page.
             */

            saveRegistrationDetails();


            sessionStorage.setItem(
                "returnToRegistration",
                "true"
            );


            /*
             * Open WebForm1.
             */

            window.location.href =
                "WebForm1.aspx";

        }


        /* =====================================================
           RESTORE REGISTRATION INFORMATION
           ===================================================== */

        function restoreRegistrationDetails() {

            const fullName =
                sessionStorage.getItem(
                    "registrationFullName"
                );


            const email =
                sessionStorage.getItem(
                    "registrationEmail"
                );


            const dob =
                sessionStorage.getItem(
                    "registrationDOB"
                );


            const idNumber =
                sessionStorage.getItem(
                    "registrationID"
                );


            const password =
                sessionStorage.getItem(
                    "registrationPassword"
                );


            const confirmPassword =
                sessionStorage.getItem(
                    "registrationConfirmPassword"
                );


            /*
             * Restore Full Name
             */

            if (fullName !== null) {

                document.getElementById(
                    "<%= txtFullName.ClientID %>"
                ).value = fullName;

            }


            /*
             * Restore Email
             */

            if (email !== null) {

                document.getElementById(
                    "<%= txtEmailAddress.ClientID %>"
                ).value = email;

            }


            /*
             * Restore Date of Birth
             */

            if (dob !== null) {

                document.getElementById(
                    "<%= txtDateOfBirth.ClientID %>"
                ).value = dob;

            }


            /*
             * Restore ID Number
             */

            if (idNumber !== null) {

                document.getElementById(
                    "<%= txtIDNumber.ClientID %>"
                ).value = idNumber;

            }


            /*
             * Restore Password
             */

            if (password !== null) {

                document.getElementById(
                    "<%= txtPassword.ClientID %>"
                ).value = password;

            }


            /*
             * Restore Confirm Password
             */

            if (confirmPassword !== null) {

                document.getElementById(
                    "<%= txtConfirmPassword.ClientID %>"
                ).value = confirmPassword;

            }

        }


        /* =====================================================
           RESTORE TERMS ACCEPTANCE
           ===================================================== */

        function restoreTermsAcceptance() {

            const termsAccepted =
                sessionStorage.getItem(
                    "termsAccepted"
                );


            if (termsAccepted === "true") {

                const checkbox =
                    document.getElementById(
                        "<%= cbUserAgreement.ClientID %>"
                    );


                if (checkbox) {

                    /*
                     * THIS IS WHAT TICKS THE
                     * REGISTRATION CHECKBOX.
                     */

                    checkbox.checked = true;

                }


                const status =
                    document.getElementById(
                        "termsStatus"
                    );


                if (status) {

                    status.style.display =
                        "block";

                }

            }

        }


        /* =====================================================
           PREVENT REGISTERING WITHOUT ACCEPTING TERMS
           ===================================================== */

        function checkTermsBeforeRegister() {

            const termsAccepted =
                sessionStorage.getItem(
                    "termsAccepted"
                );


            if (termsAccepted !== "true") {

                alert(
                    "Please read and accept the Terms and Conditions before registering."
                );

                return false;

            }


            return true;

        }


        /* =====================================================
           PAGE LOAD
           ===================================================== */

        window.addEventListener(
            "load",
            function () {

                /*
                 * Restore information entered
                 * before opening WebForm1.
                 */

                restoreRegistrationDetails();


                /*
                 * Restore accepted Terms.
                 * This automatically ticks
                 * the checkbox.
                 */

                restoreTermsAcceptance();

            }
        ); 

    </script>

</asp:Content>