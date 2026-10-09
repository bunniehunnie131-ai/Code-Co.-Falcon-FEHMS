<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white text-center">
                    <h3>Payment Details</h3>
                </div>

                <div class="card-body">

                    <asp:ValidationSummary
                        ID="ValidationSummary1"
                        runat="server"
                        CssClass="alert alert-danger"
                        HeaderText="Please correct the following errors:"
                    />

                    <!-- Bank Name -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">Bank Name</label>3
                        <asp:DropDownList
                            ID="ddlBankName"
                            runat="server"
                            CssClass="form-select">
                        </asp:DropDownList>
                    </div>

                    <!-- Card Holder -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">Card Holder</label>

                        <asp:TextBox
                            ID="txtCardHolder"
                            runat="server"
                            CssClass="form-control"
                            Placeholder="Card Holder Name">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvtxtCardHolder"
                            runat="server"
                            ControlToValidate="txtCardHolder"
                            ErrorMessage="Card Holder is required."
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <!-- Account Number -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">Account Number</label>

                        <asp:TextBox
                            ID="txtAccountNumber"
                            runat="server"
                            CssClass="form-control"
                            Placeholder="Account Number">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvAccountNumber"
                            runat="server"
                            ControlToValidate="txtAccountNumber"
                            ErrorMessage="Account Number is required."
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <!-- CVV -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">CVV</label>

                        <asp:TextBox
                            ID="txtCVV"
                            runat="server"
                            CssClass="form-control"
                            Placeholder="CVV"
                            TextMode="Password"
                            MaxLength="3">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvCVV"
                            runat="server"
                            ControlToValidate="txtCVV"
                            ErrorMessage="CVV is required."
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <!-- Expiry Date -->
                    <div class="mb-4">
                        <label class="form-label fw-bold">Expiry Date</label>

                        <asp:TextBox
                            ID="txtExpiryDate"
                            runat="server"
                            CssClass="form-control"
                            Placeholder="MM/YY">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvExpiryDate"
                            runat="server"
                            ControlToValidate="txtExpiryDate"
                            ErrorMessage="Expiry Date is required."
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <!-- Buttons -->
                    <div class="row">
                        <div class="col-6">
                            <asp:Button
                                ID="btnCancel"
                                runat="server"
                                Text="Cancel"
                                CssClass="btn btn-outline-secondary w-100" />
                        </div>

                        <div class="col-6">
                            <asp:Button
                                ID="btnPay"
                                runat="server"
                                Text="Pay Now"
                                CssClass="btn btn-primary w-100" />
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>
</asp:Content>
