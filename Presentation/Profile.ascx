<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Profile.ascx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.Profile" %>


<div class="profile-page">

    <!-- PAGE HEADING -->
    <div class="page-title">
        <h2>My Profile</h2>
        <p>Manage your account information</p>
    </div>

    <!-- PROFILE CARD -->
    <div class="profile-card">

        <!-- LEFT SIDE -->
        <div class="left-card">

            <asp:Image ID="imgProfile"
                runat="server"
                ImageUrl="~/Images/default-user.png"
                CssClass="profile-image" />

            <h3>
                <asp:Label ID="lblProfileName"
                    runat="server"
                    Text="Staff Member" />
            </h3>

            <span class="role">
                <asp:Label ID="lblProfileRole"
                    runat="server"
                    Text="Delivery Staff" />
            </span>

            <div class="mini-divider"></div>

            <div class="small-info">
                <label>Staff ID</label>

                <asp:Label ID="lblStaffID"
                    runat="server"
                    Text="STF00001" />
            </div>

            <div class="small-info">
                <label>Member Since</label>

                <asp:Label ID="lblMemberSince"
                    runat="server"
                    Text="15 March 2026" />
            </div>

            <asp:Button
                ID="btnUpload"
                runat="server"
                Text="Upload Picture"
                CssClass="upload-button" />

        </div>

        <!-- RIGHT SIDE -->
        <div class="right-card">

            <h3>Personal Information</h3>

            <div class="profile-row">
                <label>Full Name</label>

                <asp:Label ID="lblFullName"
                    runat="server"
                    Text="John Smith" />
            </div>

            <div class="profile-row">
                <label>Username</label>

                <asp:Label ID="lblUsername"
                    runat="server"
                    Text="johnsmith" />
            </div>

            <div class="profile-row">
                <label>Email Address</label>

                <asp:Label ID="lblEmail"
                    runat="server"
                    Text="john@email.com" />
            </div>

            <div class="profile-row">
                <label>Contact Number</label>

                <asp:Label ID="lblContact"
                    runat="server"
                    Text="0712345678" />
            </div>

            <div class="profile-row">
                <label>ID Number</label>

                <asp:Label ID="lblIDNumber"
                    runat="server"
                    Text="0001015800081" />
            </div>

            <div class="profile-row">
                <label>Address</label>

                <asp:Label ID="lblAddress"
                    runat="server"
                    Text="15 Oxford Street, Beacon Bay, East London" />
            </div>

            <div class="button-container">

                <button type="button"
                    class="edit-button"
                    onclick="showEdit()">
                    Edit Information
                </button>

            </div>

        </div>

    </div>


    <!-- EDIT PROFILE CARD -->
    <asp:Panel ID="pnlEdit"
        runat="server"
        CssClass="edit-card"
        Style="display:none;">

        <div class="edit-header">
            <h2>Edit Personal Information</h2>

            <p>
                Update your personal details and security information.
            </p>
        </div>


        <!-- PERSONAL DETAILS -->
        <div class="section-title">
            <i class="bi bi-person-circle"></i>
            <span>Personal Details</span>
        </div>

        <div class="section-divider"></div>


        <div class="section-card">

            <div class="form-grid">

                <!-- FULL NAME -->
                <div class="form-group">

                    <label>Full Name</label>

                    <asp:TextBox
                        ID="txtFullName"
                        runat="server"
                        CssClass="form-control" />

                </div>


                <!-- USERNAME -->
                <div class="form-group">

                    <label>Username</label>

                    <asp:TextBox
                        ID="txtUsername"
                        runat="server"
                        CssClass="form-control" />

                </div>


                <!-- EMAIL -->
                <div class="form-group">

                    <label>Email Address</label>

                    <asp:TextBox
                        ID="txtEmail"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Email" />

                </div>


                <!-- CONTACT -->
                <div class="form-group">

                    <label>Contact Number</label>

                    <asp:TextBox
                        ID="txtContact"
                        runat="server"
                        CssClass="form-control" />

                </div>


                <!-- ID NUMBER -->
                <div class="form-group">

                    <label>ID Number</label>

                    <asp:TextBox
                        ID="txtIDNumber"
                        runat="server"
                        CssClass="form-control" />

                </div>

            </div>


            <!-- ADDRESS -->
            <div class="form-group address-group">

                <label>Address</label>

                <asp:TextBox
                    ID="txtAddress"
                    runat="server"
                    CssClass="form-control"
                    Rows="4"
                    TextMode="MultiLine" />

            </div>

        </div>


        <!-- SECURITY -->
        <div class="section-title">
            <i class="bi bi-shield-lock-fill"></i>
            <span>Security</span>
        </div>

        <div class="section-divider"></div>


        <div class="section-card">

            <p class="security-note">
                Leave these fields blank if you do not wish to change your password.
            </p>

            <div class="form-grid">

                <div class="form-group">

                    <label>New Password</label>

                    <asp:TextBox
                        ID="txtPassword"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Password" />

                </div>


                <div class="form-group">

                    <label>Confirm Password</label>

                    <asp:TextBox
                        ID="txtConfirmPassword"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Password" />

                </div>

            </div>

        </div>


        <!-- BUTTONS -->
        <div class="button-container">

            <asp:Button
                ID="btnSave"
                runat="server"
                Text="Save Changes"
                CssClass="save-button"
                OnClick="btnSave_Click" />

            <button
                type="button"
                class="cancel-button"
                onclick="hideEdit()">
                Cancel
            </button>

        </div>

    </asp:Panel>


    <script type="text/javascript">

        function showEdit() {
            document.getElementById('<%= pnlEdit.ClientID %>').style.display = "block";
        }

        function hideEdit() {
            document.getElementById('<%= pnlEdit.ClientID %>').style.display = "none";
        }

    </script>

</div>