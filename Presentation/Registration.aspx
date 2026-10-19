
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
            width: 100%;
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

            <h3>Create Your Account</h3>

            <p>Join Forte Events Catering &amp; Decor Hire</p>

            <!-- FULL NAME -->
            <div class="mb-3">

                <asp:TextBox
                    ID="txtFullName"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Full Name"
                    MaxLength="150">
                </asp:TextBox>

            </div>

            <!-- EMAIL ADDRESS -->
            <div class="mb-3">

                <asp:TextBox
                    ID="txtEmailAddress"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Email Address"
                    TextMode="Email"
                    MaxLength="254">
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

            <!-- SOUTH AFRICAN ID NUMBER -->
            <div class="mb-3">

                <asp:TextBox
                    ID="txtIDNumber"
                    runat="server"
                    CssClass="form-control"
                    placeholder="ID Number"
                    MaxLength="13">
                </asp:TextBox>

            </div>

            <!-- PASSWORD -->
            <div class="mb-3">

                <asp:TextBox
                    ID="txtPassword"
                    runat="server"
                    TextMode="Password"
                    CssClass="form-control"
                    placeholder="Password (minimum 12 characters)">
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
                           onclick="openTermsPage(); return false;">
                            Terms &amp; Conditions
                        </a>

                        and

                        <a href="PrivacyPolicy.aspx">
                            Privacy Policy
                        </a>

                    </label>

                </div>

                <div class="terms-info">
                    You must review and accept the Terms &amp;
                    Conditions before registering.
                </div>

                <div id="termsStatus" class="terms-status">
                    &#10003; Terms and Conditions accepted
                </div>

            </div>

            <!-- REGISTER BUTTON -->
            <div class="d-grid">

                <asp:Button
                    ID="btnRegister"
                    runat="server"
                    Text="Register"
                    CssClass="btn btn-register"
                    OnClick="btnRegister_Click"
                    OnClientClick="return checkTermsBeforeRegister();" />

            </div>

            <!-- LOGIN LINK -->
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


    <script type="text/javascript">

        // Save only non-sensitive details before opening Terms.
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
        }


        // Open Terms when the checkbox is selected.
        function openTermsAndConditions(checkbox) {

            if (checkbox.checked) {

                checkbox.checked = false;

                saveRegistrationDetails();

                sessionStorage.setItem(
                    "returnToRegistration",
                    "true"
                );

                sessionStorage.removeItem("termsAccepted");

                window.location.href = "WebForm1.aspx";
            }
            else {

                sessionStorage.removeItem("termsAccepted");

                var status = document.getElementById("termsStatus");

                if (status) {
                    status.style.display = "none";
                }
            }
        }


        // Open Terms when the text link is clicked.
        function openTermsPage() {

            saveRegistrationDetails();

            sessionStorage.setItem(
                "returnToRegistration",
                "true"
            );

            sessionStorage.removeItem("termsAccepted");

            window.location.href = "WebForm1.aspx";
        }


        // Restore safe registration information.
        function restoreRegistrationDetails() {

            var fullName =
                sessionStorage.getItem("registrationFullName");

            var email =
                sessionStorage.getItem("registrationEmail");

            var dob =
                sessionStorage.getItem("registrationDOB");

            if (fullName !== null) {

                document.getElementById(
                    "<%= txtFullName.ClientID %>"
                ).value = fullName;
            }

            if (email !== null) {

                document.getElementById(
                    "<%= txtEmailAddress.ClientID %>"
                ).value = email;
            }

            if (dob !== null) {

                document.getElementById(
                    "<%= txtDateOfBirth.ClientID %>"
                ).value = dob;
            }
        }


        // Restore acceptance after returning from Terms.
        function restoreTermsAcceptance() {

            var accepted =
                sessionStorage.getItem("termsAccepted");

            var checkbox = document.getElementById(
                "<%= cbUserAgreement.ClientID %>"
            );

            var status =
                document.getElementById("termsStatus");

            if (accepted === "true") {

                if (checkbox) {
                    checkbox.checked = true;
                }

                if (status) {
                    status.style.display = "block";
                }
            }
            else {

                if (checkbox) {
                    checkbox.checked = false;
                }

                if (status) {
                    status.style.display = "none";
                }
            }
        }


        // Check acceptance before submitting registration.
        function checkTermsBeforeRegister() {

            var accepted =
                sessionStorage.getItem("termsAccepted");

            var checkbox = document.getElementById(
                "<%= cbUserAgreement.ClientID %>"
            );

            if (accepted !== "true" ||
                !checkbox ||
                !checkbox.checked) {

                alert(
                    "Please read and accept the Terms and Conditions before registering."
                );

                return false;
            }

            return true;
        }


        // Restore information when the page opens.
        window.addEventListener("load", function () {

            // Clear sensitive values saved by the old version.
            sessionStorage.removeItem("registrationID");
            sessionStorage.removeItem("registrationPassword");
            sessionStorage.removeItem("registrationConfirmPassword");

            restoreRegistrationDetails();
            restoreTermsAcceptance();
        });

    </script>

</asp:Content>
