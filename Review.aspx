<%@ Page Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Review.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Review" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Forte.css" rel="stylesheet" />
<div class="review-container">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-xl-7">

                <div class="review-card">

                    <!-- Header -->
                    <div class="review-header text-center">
                        <i class="bi bi-star-fill display-4 mb-3"></i>
                        <h2 class="mb-2">How was your experience?</h2>
                        <p class="mb-0 opacity-90">Your feedback helps improve our platform.</p>
                    </div>

                    <!-- Form -->
                    <div class="p-5">

                        <asp:HiddenField ID="hfRequestID" runat="server" />
                        <asp:HiddenField ID="hfProviderID" runat="server" />

                        <!-- Rating Display -->
                        <div class="mb-4">
                            <label class="form-label">Rate our services</label>
                            <div class="form-control-plaintext fw-bold fs-5">
                                <asp:Label ID="lblRate" runat="server" />
                            </div>
                        </div>

                        <!-- Dropdown -->
                        <div class="mb-4">
                            <label class="form-label">How would you rate this service?</label>
                            <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-select form-select-lg">
                                <asp:ListItem Text="-- Select Rating --" Value=""></asp:ListItem>
                                <asp:ListItem Value="5">★★★★★ Excellent (5)</asp:ListItem>
                                <asp:ListItem Value="4">★★★★☆ Good (4)</asp:ListItem>
                                <asp:ListItem Value="3">★★★☆☆ Average (3)</asp:ListItem>
                                <asp:ListItem Value="2">★★☆☆☆ Poor (2)</asp:ListItem>
                                <asp:ListItem Value="1">★☆☆☆☆ Terrible (1)</asp:ListItem>
                            </asp:DropDownList>

                            <asp:RequiredFieldValidator ID="rfvRating" runat="server"
                                ControlToValidate="ddlRating"
                                InitialValue=""
                                ErrorMessage="Please select a rating."
                                ValidationGroup="Review"
                                Display="Dynamic"
                                ForeColor="Red" />
                        </div>

                        <!-- Comment -->
                        <div class="mb-4">
                            <label class="form-label">Share your experience (Optional)</label>
                            <asp:TextBox ID="txtComment" runat="server"
                                CssClass="form-control"
                                TextMode="MultiLine"
                                Rows="5"
                                placeholder="What did you like or dislike?" />
                        </div>

                        <!-- Validation -->
                        <asp:ValidationSummary ID="vsReview" runat="server"
                            ValidationGroup="Review"
                            CssClass="alert alert-danger" />

                        <asp:Label ID="lblMessage" runat="server"
                            CssClass="d-block mt-3 fw-bold"
                            Visible="false" />

                        <!-- Reviews -->
                        <h3>All Reviews</h3>

                        <asp:GridView ID="gvReviews" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered">
                            <Columns>
                                <asp:BoundField DataField="Name" HeaderText="Name" />
                                <asp:BoundField DataField="Rating" HeaderText="Rating" />
                                <asp:BoundField DataField="Comment" HeaderText="Comment" />
                                <asp:BoundField DataField="Date" HeaderText="Date" />
                            </Columns>
                        </asp:GridView>

                        <!-- Buttons -->
                        <div class="d-flex gap-3 mt-4">
                            <asp:Button ID="btnSubmit" runat="server"
                                Text="Submit Review"
                                CssClass="btn btn-primary flex-grow-1"
                                ValidationGroup="Review"
                                OnClick="btnSubmit_Click" />

                            <a href="MyOrders.aspx" class="btn btn-outline-secondary px-5">Cancel</a>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

</asp:Content>