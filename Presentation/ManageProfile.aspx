<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Presentation/SystemLayout.Master" CodeBehind="ManageProfile.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>

        /* ==============================
           FEHMS ROYAL BLUE COLOUR THEME
           ============================== */

        .profile-page {
            background-color: #0b1c2c;
            min-height: calc(100vh - 70px);
            padding: 35px;
        }

        .page-title {
            color: #ffffff;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .page-subtitle {
            color: #e8efff;
            margin-bottom: 30px;
        }

        /* ==============================
           PROFILE CARD
           ============================== */

        .profile-card {
            background-color: #ffffff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            max-width: 950px;
            margin: 0 auto;
        }

        /* ==============================
           PROFILE HEADER
           ============================== */

        .profile-header {
            display: flex;
            align-items: center;
            gap: 18px;
            margin-bottom: 30px;
        }

        .profile-icon {
            width: 65px;
            height: 65px;
            background-color: #e8f1ff;
            color: #1554C0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }

        .section-title {
            color: #062B63;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .profile-description {
            color: #6b7280;
            margin-bottom: 0;
        }

        /* ==============================
           FORM
           ============================== */

        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 7px;
        }

        .form-control {
            border: 1px solid #d1d5db;
            border-radius: 7px;
            padding: 11px 12px;
            min-height: 45px;
        }

        .form-control:focus {
            border-color: #1554C0;
            box-shadow: 0 0 0 0.15rem rgba(21, 84, 192, 0.18);
        }

        /* ==============================
           BUTTONS
           ============================== */

        .btn-save {
            background-color: #0b1c2c;
            border: none;
            color: #ffffff;
            padding: 11px 25px;
            border-radius: 7px;
            font-weight: 600;
        }

        .btn-save:hover {
            background-color: #062B63;
            color: #ffffff;
        }

        .btn-cancel {
            background-color: #e5e7eb;
            border: none;
            color: #374151;
            padding: 11px 25px;
            border-radius: 7px;
            font-weight: 600;
        }

        .btn-cancel:hover {
            background-color: #d1d5db;
            color: #1f2937;
        }

        /* ==============================
           DIVIDER
           ============================== */

        .profile-divider {
            border: 0;
            border-top: 1px solid #e5e7eb;
            margin: 30px 0;
        }

        /* ==============================
           RESPONSIVE DESIGN
           ============================== */

        @media (max-width: 768px) {

            .profile-page {
                padding: 20px;
            }

            .profile-card {
                padding: 20px;
            }

            .profile-header {
                align-items: flex-start;
            }

        }

    </style>


    <!-- ==========================================
         MANAGE PROFILE PAGE
         ========================================== -->

    <div class="profile-page">

        <!-- PAGE HEADING -->

        <div class="container-fluid">

            <h2 class="page-title">
                Manage Profile
            </h2>

            <p class="page-subtitle">
                Update your personal information and account details.
            </p>


            <!-- ==================================
                 PROFILE CARD
                 ================================== -->

            <div class="profile-card">

                <!-- PROFILE HEADER -->

                <div class="profile-header">

                    <div class="profile-icon">

                        <i class="bi bi-person"></i>

                    </div>

                    <div>

                        <h4 class="section-title">
                            Personal Information
                        </h4>

                        <p class="profile-description">
                            Keep your profile information up to date.
                        </p>

                    </div>

                </div>


                <!-- ==================================
                     PROFILE FORM
                     ================================== -->

                <div class="row g-4">

                    <!-- FIRST NAME -->

                    <div class="col-md-6">

                        <label class="form-label">
                            First Name
                        </label>

                        <asp:TextBox
                            ID="txtFirstName"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter first name">
                        </asp:TextBox>

                    </div>


                    <!-- SURNAME -->

                    <div class="col-md-6">

                        <label class="form-label">
                            Surname
                        </label>

                        <asp:TextBox
                            ID="txtSurname"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter surname">
                        </asp:TextBox>

                    </div>


                    <!-- EMAIL -->

                    <div class="col-md-6">

                        <label class="form-label">
                            Email Address
                        </label>

                        <asp:TextBox
                            ID="txtEmail"
                            runat="server"
                            TextMode="Email"
                            CssClass="form-control"
                            placeholder="Enter email address">
                        </asp:TextBox>

                    </div>


                    <!-- CONTACT NUMBER -->

                    <div class="col-md-6">

                        <label class="form-label">
                            Contact Number
                        </label>

                        <asp:TextBox
                            ID="txtContactNumber"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter contact number">
                        </asp:TextBox>

                    </div>


                    <!-- ADDRESS -->

                    <div class="col-12">

                        <label class="form-label">
                            Address
                        </label>

                        <asp:TextBox
                            ID="txtAddress"
                            runat="server"
                            CssClass="form-control"
                            TextMode="MultiLine"
                            Rows="3"
                            placeholder="Enter your address">
                        </asp:TextBox>

                    </div>


                    <!-- CITY -->

                    <div class="col-md-6">

                        <label class="form-label">
                            City
                        </label>

                        <asp:TextBox
                            ID="txtCity"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter city">
                        </asp:TextBox>

                    </div>


                    <!-- POSTAL CODE -->

                    <div class="col-md-6">

                        <label class="form-label">
                            Postal Code
                        </label>

                        <asp:TextBox
                            ID="txtPostalCode"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter postal code">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- ==================================
                     DIVIDER
                     ================================== -->

                <hr class="profile-divider" />


                <!-- ==================================
                     ACTION BUTTONS
                     ================================== -->

                <div class="d-flex justify-content-end gap-2">

                    <asp:Button
                        ID="btnCancel"
                        runat="server"
                        Text="Cancel"
                        CssClass="btn-cancel" />

                    <asp:Button
                        ID="btnSave"
                        runat="server"
                        Text="Save Changes"
                        CssClass="btn-save" OnClick="btnSave_Click" />

                </div>

            </div>

        </div>

    </div>

</asp:Content>
