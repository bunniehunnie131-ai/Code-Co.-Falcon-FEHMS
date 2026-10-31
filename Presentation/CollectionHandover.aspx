<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="CollectionHandover.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.CollectionHandover" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

/* Collection form refinements */
.collection-form-page {
    width: 100%;
    max-width: 1440px;
    margin: 0 auto;
}

.collection-form-page > .card,
.collection-form-page #pnlCollection > .card {
    overflow: hidden;
    border: 1px solid var(--border-color);
    border-radius: var(--radius-medium);
    box-shadow: var(--shadow-small);
}

.collection-form-page .card-header {
    padding: 14px 18px;
    background: #fff;
    border-bottom: 1px solid var(--border-color);
}

.collection-form-page .card-body {
    padding: 18px;
}

.collection-form-page .collection-inspection-table {
    min-width: 900px;
}

.collection-form-page .collection-inspection-table th {
    color: var(--secondary-color);
    background: #f5f7fa;
    font-size: .88rem;
    white-space: nowrap;
}

.collection-form-page .collection-inspection-table td {
    vertical-align: middle;
}

.collection-form-page .collection-inspection-table th:last-child,
.collection-form-page .collection-inspection-table td:last-child {
    min-width: 210px;
}

.collection-form-page .collection-quantity {
    min-width: 72px;
    text-align: center;
}

.collection-form-page .collection-acceptance {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    margin: 4px 0 18px;
}

.collection-form-page .collection-acceptance input[type="checkbox"] {
    position: static;
    float: none;
    flex: 0 0 18px;
    width: 18px;
    height: 18px;
    margin: 3px 0 0;
    accent-color: var(--primary-color);
    cursor: pointer;
}

.collection-form-page .collection-acceptance label {
    margin: 0;
    color: var(--text-color);
    line-height: 1.5;
    cursor: pointer;
}

.collection-form-page .btn-forte {
    min-height: 42px;
    padding: 9px 18px;
    font-weight: 600;
}

@media (max-width: 767.98px) {
    .collection-form-page .card-body {
        padding: 14px;
    }

    .collection-form-page .collection-inspection-table {
        min-width: 820px;
    }
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="staff-page-content container-fluid px-3 px-xl-4 py-3 collection-form-page">

        <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-4">
            <div>
                <h1 class="page-title mb-1">Collection Form</h1>
                <p class="page-subtitle mb-0">Check the returned equipment and record the customer handover.</p>
            </div>
            <asp:HyperLink ID="lnkBack" runat="server" NavigateUrl="ManageCollections.aspx"
                CssClass="btn btn-outline-secondary">Back to collections</asp:HyperLink>
        </div>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false"
            CssClass="alert alert-danger" role="alert">
            <asp:Literal ID="litMessage" runat="server" />
        </asp:Panel>

        <asp:Panel ID="pnlNoTask" runat="server" Visible="false"
            CssClass="alert alert-warning">
            No collection task was found for this booking, or it is not assigned to your staff account.
       
        </asp:Panel>

        <asp:Panel ID="pnlCollection" runat="server" Visible="false">
            <section class="card mb-4">
                <div class="card-header bg-white">
                    <h2 class="h5 mb-0">Booking
                        <asp:Literal ID="litBookingReference" runat="server" />
                    </h2>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-sm-6 col-lg-3">
                            <span class="d-block small text-muted">Customer</span>
                            <strong>
                                <asp:Literal ID="litCustomer" runat="server" /></strong>
                            <div>
                                <asp:Literal ID="litPhone" runat="server" /></div>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <span class="d-block small text-muted">Event</span>
                            <strong>
                                <asp:Literal ID="litEventType" runat="server" /></strong>
                            <div>
                                <asp:Literal ID="litEventDate" runat="server" /></div>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <span class="d-block small text-muted">Event ended</span>
                            <strong>
                                <asp:Literal ID="litEventEnd" runat="server" /></strong>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <span class="d-block small text-muted">Collection status</span>
                            <strong>
                                <asp:Literal ID="litTaskStatus" runat="server" /></strong>
                        </div>
                        <div class="col-md-6">
                            <span class="d-block small text-muted">Collection location</span>
                            <strong>
                                <asp:Literal ID="litLocation" runat="server" /></strong>
                        </div>
                        <div class="col-md-6">
                            <span class="d-block small text-muted">Collection instructions</span>
                            <asp:Literal ID="litInstructions" runat="server" />
                        </div>
                    </div>
                </div>
            </section>

            <asp:Panel ID="pnlNotReady" runat="server" Visible="false"
                CssClass="alert alert-info">
                This collection can be accepted after the event end time shown above.
           
            </asp:Panel>

            <asp:Panel ID="pnlAlreadyCollected" runat="server" Visible="false"
                CssClass="alert alert-success">
                This collection has already been accepted and marked collected.
           
            </asp:Panel>

            <asp:Panel ID="pnlInspection" runat="server" Visible="false">
                <section class="card mb-4">
                    <div class="card-header bg-white">
                        <h2 class="h5 mb-1">Equipment condition</h2>
                        <p class="small text-muted mb-0">
                            For each item, Good + Damaged + Missing must equal the booked quantity.
                            Add a note for damaged items.
                       
                        </p>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table align-middle collection-inspection-table mb-0">
                                <thead>
                                    <tr>
                                        <th>Equipment</th>
                                        <th>Booked</th>
                                        <th>Good</th>
                                        <th>Damaged</th>
                                        <th>Missing</th>
                                        <th>Condition notes</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptItems" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:HiddenField ID="hfBookingItemID" runat="server"
                                                        Value='<%# Eval("BookingItemID") %>' />
                                                    <asp:HiddenField ID="hfExpected" runat="server"
                                                        Value='<%# Eval("Expected") %>' />
                                                    <strong><%#: Eval("Name") %></strong>
                                                    <span class="d-block small text-muted"><%#: Eval("Description") %></span>
                                                </td>
                                                <td class="fw-semibold"><%#: Eval("Expected") %></td>
                                                <td>
                                                    <asp:TextBox ID="txtGood" runat="server" TextMode="Number"
                                                        min="0" Text='<%# Eval("Good") %>'
                                                        CssClass="form-control form-control-sm collection-quantity" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDamaged" runat="server" TextMode="Number"
                                                        min="0" Text='<%# Eval("Damaged") %>'
                                                        CssClass="form-control form-control-sm collection-quantity" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtMissing" runat="server" TextMode="Number"
                                                        min="0" Text='<%# Eval("Missing") %>'
                                                        CssClass="form-control form-control-sm collection-quantity" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNote" runat="server" MaxLength="1000"
                                                        Text='<%# Eval("DamageNote") %>'
                                                        CssClass="form-control form-control-sm"
                                                        placeholder="Describe damage or missing items" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>

                <section class="card mb-4">
                    <div class="card-header bg-white">
                        <h2 class="h5 mb-0">Collection sign-off</h2>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <asp:Label ID="lblStaffSignature" runat="server"
                                    AssociatedControlID="txtStaffSignature"
                                    CssClass="form-label" Text="Staff name / signature" />
                                <asp:TextBox ID="txtStaffSignature" runat="server"
                                    CssClass="form-control" MaxLength="150" />
                            </div>
                            <div class="col-md-6">
                                <asp:Label ID="lblCustomerSignature" runat="server"
                                    AssociatedControlID="txtCustomerSignature"
                                    CssClass="form-label" Text="Customer name / signature" />
                                <asp:TextBox ID="txtCustomerSignature" runat="server"
                                    CssClass="form-control" MaxLength="150" />
                            </div>
                            <div class="col-12">
                                <asp:Label ID="lblCollectionNotes" runat="server"
                                    AssociatedControlID="txtCollectionNotes"
                                    CssClass="form-label" Text="Collection notes" />
                                <asp:TextBox ID="txtCollectionNotes" runat="server"
                                    CssClass="form-control" TextMode="MultiLine" Rows="3"
                                    MaxLength="1000" />
                            </div>
                            <div class="col-12">
                                <div class="collection-acceptance">
                                    <asp:CheckBox ID="chkCustomerAccepted" runat="server" />
                                    <asp:Label ID="lblCustomerAccepted" runat="server"
                                        AssociatedControlID="chkCustomerAccepted"
                                        Text="The customer accepts this collection record and the item conditions listed above." />
                                </div>
                            </div>
                            <div class="col-12">
                                <asp:Button ID="btnAcceptCollection" runat="server"
                                    Text="Accept collection and mark collected"
                                    CssClass="btn btn-forte"
                                    OnClick="btnAcceptCollection_Click" />
                            </div>
                        </div>
                    </div>
                </section>
            </asp:Panel>
        </asp:Panel>
    </div>

</asp:Content>