<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManageCollections.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageCollections" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .nav-tabs .nav-link {
            color: #17365d;
            font-weight: 600;
        }
        .nav-tabs .nav-link.active {
            color: #0d6efd;
            font-weight: 700;
            border-bottom: 3px solid #0d6efd;
        }
        .collection-status-badge{
            color: #111 !important;
        }
        .collection-detail-thumb {
    display: block;
    width: 100px;
    height: 75px;
    object-fit: cover;
}

.collection-package-image {
    display: block;
    width: 100%;
    max-width: 220px;
    height: 140px;
    object-fit: cover;
}.collection-thumb{
            display:block;
            width:200px;
            height:150px;
            object-fit:cover;
        }
        .delivery-detail-thumb .collection-detail-thumb {
            display: block;
            width: 100px;
            height: 75px;
            object-fit: cover;
            border-radius: 6px;

        }
    </style>

      <div class="staff-page-content container-fluid px-3 px-xl-4 py-3">
     <div class="page-header d-flex flex-wrap justify-content-between align-items-center gap-3">
         <div><h1 class="page-title">My Collections</h1><p class="page-subtitle mb-0">View and update your assigned collections.</p></div>
     </div>

     <div class="card mb-3">
         <div class="card-body">
             <ul class="nav nav-tabs mb-3">
                 <li class="nav-item"><asp:LinkButton ID="lnkAll" runat="server" CssClass="nav-link active" OnClick="FilterAll_Click">All Collections</asp:LinkButton></li>
                 <li class="nav-item"><asp:LinkButton ID="lnkPending" runat="server" CssClass="nav-link" OnClick="FilterPending_Click">Pending</asp:LinkButton></li>
                 <li class="nav-item"><asp:LinkButton ID="lnkCompleted" runat="server" CssClass="nav-link" OnClick="FilterCompleted_Click">Completed</asp:LinkButton></li>
             </ul>
             <div class="row g-2 align-items-end">
                 <div class="col-lg-5"><label class="form-label" for="<%= txtSearch.ClientID %>">Search collections</label><asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Booking ID, customer or event" /></div>
                 <div class="col-sm-6 col-lg-3"><label class="form-label" for="<%= txtDate.ClientID %>">Collection date</label><asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="form-control" /></div>
                 <div class="col-sm-6 col-lg-4 d-flex gap-2"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-forte" OnClick="Search_Click" /><asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary" CausesValidation="false" OnClick="Clear_Click" /></div>
             </div>
         </div>
     </div>

     <asp:Panel ID="pnlCollectionMessage" runat="server" Visible="false" CssClass="alert alert-info" role="status">
         <asp:Literal ID="litCollectionMessage" runat="server" />
     </asp:Panel>

     <asp:Repeater ID="rptCollections" runat="server" OnItemCommand="rptCollections_ItemCommand">
         <ItemTemplate>
             <div class="card mb-3">
                 <div class="row g-0 align-items-center">
                     <div class="col-auto p-3"><img src='<%#: Eval("ImageUrl") %>' alt="Event hire setup" class="img-fluid rounded collection-thumb" /></div>
                     <div class="col"><div class="card-body ps-0">
                         <div class="d-flex flex-wrap justify-content-between align-items-start gap-2">
                             <div><span class="fw-bold"><%#: Eval("BookingId") %> – <%#: Eval("EventType") %></span><div><%#: Eval("Customer") %></div></div>
                             <span class='badge collection-status-badge <%# StatusBadge(Eval("Status")) %>'><%#: Eval("Status") %></span>
                         </div>
                         <div class="row mt-2 g-2 small text-muted">
                             <div class="col-sm-6"><i class="bi bi-calendar3 me-1"></i>Collection: <%#: Eval("CollectionDate", "{0:dd MMM yyyy}") %> | <%#: Eval("CollectionTime") %></div>
                             <div class="col-sm-6"><i class="bi bi-clock me-1"></i>Event ends: <%#: Eval("EventEndAt", "{0:dd MMM yyyy, HH:mm}") %></div>
                             <div class="col-12"><i class="bi bi-geo-alt me-1"></i><%#: Eval("Venue") %></div>
                         </div>
                         <p class="small mt-2 mb-0"><%#: Eval("Items") %></p>
                     </div></div>
                     <div class="col-12 col-md-auto px-3 pb-3 pt-md-3">
                         <div class="d-flex flex-row flex-md-column gap-2">
                             <asp:LinkButton ID="lnkCollectionDetails" runat="server" CssClass="btn btn-sm btn-outline-primary" CausesValidation="false" CommandName="ViewDetails" CommandArgument='<%#: Eval("BookingId") %>'>View</asp:LinkButton>
                             <asp:LinkButton ID="lnkMarkCollected" runat="server" CssClass="btn btn-sm btn-forte" CausesValidation="false" CommandName="MarkCollected" CommandArgument='<%#: Eval("BookingId") %>' Visible='<%# CanMarkCollected(Eval("Status"), Eval("EventEndAt")) %>' OnClientClick="return confirm('Confirm that these hire items have been collected?');">Mark as Collected</asp:LinkButton>
                             <asp:PlaceHolder ID="phAwaitingEventEnd" runat="server" Visible='<%# IsAwaitingEventEnd(Eval("Status"), Eval("EventEndAt")) %>'><span class="small text-muted align-self-center">Available after event ends</span></asp:PlaceHolder>
                         </div>
                     </div>
                 </div>
             </div>
         </ItemTemplate>
     </asp:Repeater>
     <asp:Panel ID="pnlCollectionDetailsModal" runat="server" ClientIDMode="Static" CssClass="modal fade" TabIndex="-1" role="dialog" aria-labelledby="collectionDetailsTitle" aria-hidden="true">
         <div class="modal-dialog modal-xl modal-dialog-scrollable">
             <div class="modal-content">
                 <div class="modal-header">
                     <div><h2 class="modal-title h5" id="collectionDetailsTitle">Collection details</h2><div class="small text-muted"><asp:Literal ID="litCollectionDetailBooking" runat="server" /></div></div>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                 </div>
                 <div class="modal-body">
                     <div class="card mb-4">
                         <div class="card-header fw-semibold">Customer and collection information</div>
                         <div class="card-body"><div class="row g-3">
                             <div class="col-sm-6 col-lg-3"><div class="small text-muted">Customer</div><strong><asp:Literal ID="litCollectionDetailCustomer" runat="server" /></strong><div><asp:Literal ID="litCollectionDetailPhone" runat="server" /></div></div>
                             <div class="col-sm-6 col-lg-3"><div class="small text-muted">Event</div><strong><asp:Literal ID="litCollectionDetailEvent" runat="server" /></strong><div><asp:Literal ID="litCollectionDetailEnd" runat="server" /></div></div>
                             <div class="col-sm-6 col-lg-3"><div class="small text-muted">Collection time</div><strong><asp:Literal ID="litCollectionDetailPickup" runat="server" /></strong></div>
                             <div class="col-sm-6 col-lg-3"><div class="small text-muted">Status</div><strong><asp:Literal ID="litCollectionDetailStatus" runat="server" /></strong></div>
                             <div class="col-md-6"><div class="small text-muted">Collection location</div><strong><asp:Literal ID="litCollectionDetailAddress" runat="server" /></strong></div>
                             <div class="col-md-6"><div class="small text-muted">Collection instructions</div><asp:Literal ID="litCollectionDetailInstructions" runat="server" /></div>
                         </div></div>
                     </div>
                     <h3 class="h6 mb-3">Equipment to collect</h3>
                     <asp:Panel ID="pnlCollectionPackageDetail" runat="server" Visible="false" CssClass="card">
                         <div class="row g-0 align-items-center">
                             <div class="col-md-4 p-3"><asp:Image ID="imgCollectionPackage" runat="server" CssClass="img-fluid rounded" /></div>
                             <div class="col-md-8 p-3"><div class="fw-semibold mb-2"><asp:Literal ID="litCollectionPackageName" runat="server" /></div>
                                 <asp:Repeater ID="rptCollectionPackageItems" runat="server"><ItemTemplate><div class="d-flex justify-content-between border-bottom py-2"><span><%#: Eval("Name") %></span><strong>Qty <%#: Eval("Quantity") %></strong></div></ItemTemplate></asp:Repeater>
                             </div>
                         </div>
                     </asp:Panel>
                     <asp:Repeater ID="rptCollectionDetailItems" runat="server">
                         <ItemTemplate>
                             <div class="card mb-2"><div class="row g-0 align-items-center">
                                 <div class="col-auto p-3"><img src='<%#: Eval("ImageUrl") %>' alt='<%#: Eval("Name") %>' class="img-fluid rounded collection-detail-thumb" /></div>
                                 <div class="col px-2"><strong><%#: Eval("Name") %></strong><div class="small text-muted">Booking item</div></div>
                                 <div class="col-auto px-4"><span class="small text-muted">Quantity</span><div class="fw-semibold text-center"><%#: Eval("Quantity") %></div></div>
                             </div></div>
                         </ItemTemplate>
                     </asp:Repeater>
                 </div>
                 <div class="modal-footer"><button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button></div>
             </div>
         </div>
     </asp:Panel>
     <asp:Panel ID="pnlNoCollections" runat="server" Visible="false" CssClass="card p-4 text-center text-muted">No collections match your search.</asp:Panel>
 </div>

</asp:Content>

