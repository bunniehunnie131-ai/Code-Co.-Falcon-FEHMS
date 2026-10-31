<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="DeliveryHandover.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.DeliveryHandover" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <style>
        .handover-page {
            width: 100%;
            max-width: 1440px;
            margin: 0 auto;
            padding: 1.5rem;
        }

        .handover-heading {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .handover-card {
            margin-bottom: 1.25rem;
            overflow: hidden;
            border: 1px solid #dce3ed;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 5px 18px rgba(20, 40, 70, 0.06);
        }

        .handover-card-header {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #e1e6ee;
            background: #f8fafc;
        }

        .handover-card-body {
            padding: 1.25rem;
        }

        .handover-info-label {
            margin-bottom: .25rem;
            color: #68778b;
            font-size: .85rem;
        }

        .handover-info-value {
            color: #142b45;
            font-weight: 600;
            overflow-wrap: anywhere;
        }

        .handover-item {
            display: grid;
            grid-template-columns: minmax(220px, 1.5fr) repeat(3, minmax(90px, .55fr)) minmax(220px, 1.2fr);
            gap: 1rem;
            align-items: end;
            padding: 1rem 0;
            border-bottom: 1px solid #e5eaf1;
        }

        .handover-item:last-child {
            border-bottom: 0;
        }

        .handover-item-name {
            color: #142b45;
            font-weight: 600;
        }

        .handover-item-image {
            width: 74px;
            height: 64px;
            object-fit: cover;
            border: 1px solid #dce3ed;
            border-radius: 8px;
            background: #f4f6f9;
        }

        .handover-item-product {
            display: flex;
            align-items: center;
            gap: .75rem;
            min-width: 0;
        }

        .handover-quantity {
            min-width: 0;
        }

        .handover-quantity .form-control {
            text-align: center;
        }

        .handover-signoff {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 1rem;
        }

        .handover-message {
            margin-bottom: 1rem;
        }

        .handover-checkbox {
            display: flex;
            align-items: flex-start;
            gap: .65rem;
            margin: 1rem 0;
        }

        .handover-checkbox input {
            flex: 0 0 auto;
            margin-top: .25rem;
        }

        .handover-help {
            color: #68778b;
            font-size: .9rem;
        }

        @media (max-width: 900px) {
            .handover-item {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }

            .handover-item-product,
            .handover-item-notes {
                grid-column: 1 / -1;
            }
        }

        @media (max-width: 600px) {
            .handover-page {
                padding: 1rem;
            }

            .handover-heading {
                flex-direction: column;
            }

            .handover-item,
            .handover-signoff {
                grid-template-columns: 1fr;
            }

            .handover-item-product,
            .handover-item-notes {
                grid-column: auto;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="handover-page">
        <div class="handover-heading">
            <div>
                <h1 class="h2 text-navy mb-1">Equipment Handover</h1>
                <p class="text-muted mb-0">
                    Check the delivered equipment, record any issues, and confirm the handover with the customer.
                </p>
            </div>

            <asp:HyperLink ID="lnkBackToDeliveries" runat="server"
                NavigateUrl="ManageDelivery.aspx"
                CssClass="btn btn-outline-secondary">
                Back to deliveries
            </asp:HyperLink>
        </div>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false"
            CssClass="alert handover-message">
            <asp:Literal ID="litMessage" runat="server" />
        </asp:Panel>

        <asp:Panel ID="pnlBooking" runat="server" Visible="false">
            <section class="handover-card">
                <div class="handover-card-header">
                    <h2 class="h5 mb-0">
                        <asp:Literal ID="litBookingReference" runat="server" />
                    </h2>
                </div>

                <div class="handover-card-body">
                    <div class="row g-4">
                        <div class="col-sm-6 col-lg-3">
                            <div class="handover-info-label">Customer</div>
                            <div class="handover-info-value">
                                <asp:Literal ID="litCustomerName" runat="server" />
                            </div>
                            <div><asp:Literal ID="litCustomerPhone" runat="server" /></div>
                        </div>

                        <div class="col-sm-6 col-lg-3">
                            <div class="handover-info-label">Event</div>
                            <div class="handover-info-value">
                                <asp:Literal ID="litEventType" runat="server" />
                            </div>
                            <div><asp:Literal ID="litEventDate" runat="server" /></div>
                        </div>

                        <div class="col-sm-6 col-lg-3">
                            <div class="handover-info-label">Scheduled delivery</div>
                            <div class="handover-info-value">
                                <asp:Literal ID="litScheduledAt" runat="server" />
                            </div>
                        </div>

                        <div class="col-sm-6 col-lg-3">
                            <div class="handover-info-label">Delivery status</div>
                            <div class="handover-info-value">
                                <asp:Literal ID="litTaskStatus" runat="server" />
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="handover-info-label">Delivery address</div>
                            <div class="handover-info-value">
                                <asp:Literal ID="litAddress" runat="server" />
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="handover-info-label">Delivery instructions</div>
                            <div><asp:Literal ID="litInstructions" runat="server" /></div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="handover-card">
                <div class="handover-card-header">
                    <h2 class="h5 mb-1">Equipment condition</h2>
                    <p class="handover-help mb-0">
                        For every item, Good + Damaged + Missing must equal the booked quantity.
                        Add a note for damaged or missing items.
                    </p>
                </div>

                <div class="handover-card-body">
                    <asp:Panel ID="pnlNoItems" runat="server" Visible="false"
                        CssClass="alert alert-warning mb-0">
                        No equipment items were found for this booking.
                    </asp:Panel>

                    <asp:Repeater ID="rptEquipment" runat="server">
                        <ItemTemplate>
                            <div class="handover-item">
                                <div class="handover-item-product">
                                    <img src='<%#: Eval("ImageUrl") %>'
                                         alt='<%#: Eval("ProductName") %>'
                                         class="handover-item-image" />
                                    <div>
                                        <div class="handover-item-name"><%#: Eval("ProductName") %></div>
                                        <div class="handover-help">
                                            Booked quantity:
                                            <strong><%#: Eval("Quantity") %></strong>
                                        </div>
                                    </div>
                                </div>

                                <asp:HiddenField ID="hfBookingItemID" runat="server"
                                    Value='<%# Eval("BookingItemID") %>' />

                                <div class="handover-quantity">
                                    <asp:Label ID="lblGood" runat="server"
                                        AssociatedControlID="txtGood"
                                        CssClass="form-label"
                                        Text="Good" />
                                    <asp:TextBox ID="txtGood" runat="server"
                                        TextMode="Number"
                                        Text='<%# Eval("Quantity") %>'
                                        CssClass="form-control"
                                        min="0" />
                                </div>

                                <div class="handover-quantity">
                                    <asp:Label ID="lblDamaged" runat="server"
                                        AssociatedControlID="txtDamaged"
                                        CssClass="form-label"
                                        Text="Damaged" />
                                    <asp:TextBox ID="txtDamaged" runat="server"
                                        TextMode="Number"
                                        Text="0"
                                        CssClass="form-control"
                                        min="0" />
                                </div>

                                <div class="handover-quantity">
                                    <asp:Label ID="lblMissing" runat="server"
                                        AssociatedControlID="txtMissing"
                                        CssClass="form-label"
                                        Text="Missing" />
                                    <asp:TextBox ID="txtMissing" runat="server"
                                        TextMode="Number"
                                        Text="0"
                                        CssClass="form-control"
                                        min="0" />
                                </div>

                                <div class="handover-item-notes">
                                    <asp:Label ID="lblItemNotes" runat="server"
                                        AssociatedControlID="txtItemNotes"
                                        CssClass="form-label"
                                        Text="Issue notes" />
                                    <asp:TextBox ID="txtItemNotes" runat="server"
                                        CssClass="form-control"
                                        MaxLength="500"
                                        placeholder="Describe any damage or missing items" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </section>

            <section class="handover-card">
                <div class="handover-card-header">
                    <h2 class="h5 mb-0">Handover sign-off</h2>
                </div>

                <div class="handover-card-body">
                    <div class="handover-signoff">
                        <div>
                            <asp:Label ID="lblStaffSignature" runat="server"
                                AssociatedControlID="txtStaffSignature"
                                CssClass="form-label"
                                Text="Staff name / signature" />
                            <asp:TextBox ID="txtStaffSignature" runat="server"
                                CssClass="form-control"
                                MaxLength="150" />
                        </div>

                        <div>
                            <asp:Label ID="lblCustomerSignature" runat="server"
                                AssociatedControlID="txtCustomerSignature"
                                CssClass="form-label"
                                Text="Customer name / signature" />
                            <asp:TextBox ID="txtCustomerSignature" runat="server"
                                CssClass="form-control"
                                MaxLength="150" />
                        </div>

                        <div class="col-12">
                            <asp:Label ID="lblHandoverNotes" runat="server"
                                AssociatedControlID="txtHandoverNotes"
                                CssClass="form-label"
                                Text="Handover notes" />
                            <asp:TextBox ID="txtHandoverNotes" runat="server"
                                CssClass="form-control"
                                TextMode="MultiLine"
                                Rows="3"
                                MaxLength="1000"
                                placeholder="Add any extra delivery or handover notes" />
                        </div>
                    </div>

                    <div class="handover-checkbox">
                        <asp:CheckBox ID="chkCustomerAccepted" runat="server" />
                        <label for="<%= chkCustomerAccepted.ClientID %>">
                            The customer accepts this handover record and the equipment condition listed above.
                        </label>
                    </div>

                    <asp:Button ID="btnSubmitHandover" runat="server"
                        Text="Accept handover and mark delivered"
                        CssClass="btn btn-primary"
                        OnClick="btnSubmitHandover_Click" />
                </div>
            </section>
        </asp:Panel>

        <asp:Panel ID="pnlComplete" runat="server" Visible="false"
            CssClass="alert alert-success">
            This delivery handover has been recorded and the task is marked delivered.
        </asp:Panel>
    </main>
</asp:Content>
