<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManageDelivery.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageDelivery" %>
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
        .delivery-status-badge{
            color: #111 !important;
        }
        .delivery-thumb{
            display:block;
            width:200px;
            height:150px;
            object-fit:cover;
        }
        .delivery-detail-thumb {
    display: block;
    width: 100px;
    height: 75px;
    object-fit: cover;
}

.delivery-package-image {
    display: block;
    width: 100%;
    max-width: 220px;
    height: 140px;
    object-fit: cover;
}
    </style>

      <div class="staff-page-content container-fluid px-3 px-xl-4 py-3">
     <div class="page-header">
         <h1 class="page-title">My Deliveries</h1>
         <p class="page-subtitle mb-0">View and update your assigned deliveries.</p>
     </div>

     <div class="card mb-3">
         <div class="card-body">
             <ul class="nav nav-tabs delivery-tabs mb-3">
                 <li class="nav-item"><asp:LinkButton ID="lnkAll" runat="server" CssClass="nav-link active" OnClick="FilterAll_Click" /></li>
                 <li class="nav-item"><asp:LinkButton ID="lnkPending" runat="server" CssClass="nav-link" OnClick="FilterPending_Click" /></li>
                 <li class="nav-item"><asp:LinkButton ID="lnkOutForDelivery" runat="server" CssClass="nav-link" OnClick="FilterOut_Click" /></li>
                 <li class="nav-item"><asp:LinkButton ID="lnkCompleted" runat="server" CssClass="nav-link" OnClick="FilterCompleted_Click" /></li>
             </ul>
             <div class="row g-2 align-items-center">
                 <div class="col-sm-6 col-lg-2"><asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="form-control" /></div>
                 <div class="col-sm-6 col-lg-2">
                     <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                         <asp:ListItem Text="All Statuses" Value="" />
                         <asp:ListItem Text="Pending" Value="Pending" />
                         <asp:ListItem Text="Out for Delivery" Value="Out for Delivery" />
                         <asp:ListItem Text="Scheduled" Value="Scheduled" />
                         <asp:ListItem Text="Completed" Value="Completed" />
                     </asp:DropDownList>
                 </div>
                 <div class="col-sm-8 col-lg-6"><asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by booking ID or customer..." /></div>
                 <div class="col-sm-4 col-lg-2"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-forte w-100" OnClick="Search_Click" /></div>
             </div>
         </div>
     </div>

     <asp:Panel ID="pnlDeliveryMessage" runat="server" Visible="false" CssClass="alert alert-info" role="status">
         <asp:Literal ID="litDeliveryMessage" runat="server" />
     </asp:Panel>

     <asp:Repeater ID="rptDeliveries" runat="server" OnItemCommand="rptDeliveries_ItemCommand">
         <ItemTemplate>
             <div class="card mb-3">
                 <div class="row g-0 align-items-center">
                     <div class="col-auto p-3">
                         <img src='<%#: Eval("ImageUrl") %>' alt="Event setup" class="img-fluid rounded delivery-thumb" />
                     </div>
                     <div class="col">
                         <div class="card-body ps-0">
                             <div class="d-flex flex-wrap justify-content-between align-items-start gap-2">
                                 <div>
                                     <div class="fw-bold"><%#: Eval("BookingId") %> – <%#: Eval("EventType") %></div>
                                     <div><%#: Eval("Customer") %></div>
                                     <div class="small text-muted mt-1"><i class="bi bi-calendar3 me-1"></i><%#: Eval("EventDate", "{0:dd MMM yyyy}") %> | <%#: Eval("EventTime") %></div>
                                     <div class="small text-muted"><i class="bi bi-geo-alt me-1"></i><%#: Eval("Venue") %></div>
                                     <div class="small text-muted mt-1"><%#: Eval("Items") %></div>
                                 </div>
                                 <span class='badge delivery-status-badge <%# StatusBadge(Eval("Status")) %>'><%#: Eval("Status") %></span>
                             </div>
                         </div>
                     </div>
                     <div class="col-12 col-md-auto px-3 pb-3 pt-md-3">
                         <div class="d-flex flex-row flex-md-column gap-2">
                             <asp:LinkButton ID="lnkViewDetails" runat="server" CssClass="btn btn-sm btn-outline-primary" CausesValidation="false" CommandName="ViewDetails" CommandArgument='<%#: Eval("BookingId") %>'>View</asp:LinkButton>
                             <asp:DropDownList ID="ddlDeliveryStatus" runat="server" CssClass="form-select form-select-sm" SelectedValue='<%# Eval("Status") %>'>
                                 <asp:ListItem Text="Pending" Value="Pending" />
                                 <asp:ListItem Text="Out for Delivery" Value="Out for Delivery" />
                                 <asp:ListItem Text="Delivered" Value="Delivered" />
                             </asp:DropDownList>
                             <asp:LinkButton ID="lnkUpdateStatus" runat="server" CssClass="btn btn-sm btn-forte" CausesValidation="false" CommandName="UpdateStatus" CommandArgument='<%#: Eval("BookingId") %>' OnClientClick="return confirm('Update this delivery status?');">Update</asp:LinkButton>
                         </div>
                     </div>
                 </div>
             </div>
         </ItemTemplate>
     </asp:Repeater>

     <asp:Panel ID="pnlDeliveryDetailsModal" runat="server" ClientIDMode="Static" CssClass="modal fade" TabIndex="-1" role="dialog" aria-labelledby="deliveryDetailsTitle" aria-hidden="true">
         <div class="modal-dialog modal-xl modal-dialog-scrollable">
             <div class="modal-content">
                 <div class="modal-header">
                     <div><h2 class="modal-title h5" id="deliveryDetailsTitle">Delivery details</h2><div class="small text-muted"><asp:Literal ID="litDeliveryDetailBooking" runat="server" /></div></div>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                 </div>
                 <div class="modal-body">
                     <div class="card mb-4">
                         <div class="card-header fw-semibold">Customer and delivery information</div>
                         <div class="card-body"><div class="row g-3">
                             <div class="col-sm-6 col-lg-3"><div class="small text-muted">Customer</div><strong><asp:Literal ID="litDeliveryDetailCustomer" runat="server" /></strong><div><asp:Literal ID="litDeliveryDetailPhone" runat="server" /></div></div>
                             <div class="col-sm-6 col-lg-3"><div class="small text-muted">Event</div><strong><asp:Literal ID="litDeliveryDetailEvent" runat="server" /></strong><div><asp:Literal ID="litDeliveryDetailDate" runat="server" /></div></div>
                             <div class="col-sm-6 col-lg-3"><div class="small text-muted">Equipment needed</div><strong><asp:Literal ID="litDeliveryDetailNeededAt" runat="server" /></strong></div>
                             <div class="col-sm-6 col-lg-3"><div class="small text-muted">Status</div><strong><asp:Literal ID="litDeliveryDetailStatus" runat="server" /></strong></div>
                             <div class="col-md-6"><div class="small text-muted">Delivery address</div><strong><asp:Literal ID="litDeliveryDetailAddress" runat="server" /></strong></div>
                             <div class="col-md-6"><div class="small text-muted">Delivery instructions</div><asp:Literal ID="litDeliveryDetailInstructions" runat="server" /></div>
                         </div></div>
                     </div>
                     <h3 class="h6 mb-3">Equipment for delivery</h3>
                     <asp:Panel ID="pnlDeliveryPackageDetail" runat="server" Visible="false" CssClass="card">
                         <div class="row g-0 align-items-center">
                             <div class="col-md-4 p-3"><asp:Image ID="imgDeliveryPackage" runat="server" CssClass="img-fluid rounded" /></div>
                             <div class="col-md-8 p-3"><div class="fw-semibold mb-2"><asp:Literal ID="litDeliveryPackageName" runat="server" /></div>
                                 <asp:Repeater ID="rptDeliveryPackageItems" runat="server"><ItemTemplate><div class="d-flex justify-content-between border-bottom py-2"><span><%#: Eval("Name") %></span><strong>Qty <%#: Eval("Quantity") %></strong></div></ItemTemplate></asp:Repeater>
                             </div>
                         </div>
                     </asp:Panel>
                     <asp:Repeater ID="rptDeliveryDetailItems" runat="server">
                         <ItemTemplate>
                             <div class="card mb-2"><div class="row g-0 align-items-center">
                                 <div class="col-auto p-3"><img src='<%#: Eval("ImageUrl") %>' alt='<%#: Eval("Name") %>' class="img-fluid rounded delivery-detail-thumb" /></div>
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
     <asp:Panel ID="pnlNoDeliveries" runat="server" Visible="false" CssClass="card p-4 text-center text-muted">No deliveries match your search.</asp:Panel>
 </div>

</asp:Content>

