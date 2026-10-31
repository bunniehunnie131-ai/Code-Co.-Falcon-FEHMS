<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManageDelivery.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageDelivery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
    <style>
        .delivery-workspace .delivery-card {
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-small);
        }

        .delivery-workspace .delivery-thumb {
            display: block;
            width: 128px;
            height: 96px;
            object-fit: cover;
            border-radius: 8px;
        }

        .delivery-workspace .delivery-detail-thumb {
            display: block;
            width: 76px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
        }

        .delivery-workspace .delivery-package-image {
            display: block;
            width: 140px;
            height: 100px;
            object-fit: cover;
        }

        .delivery-workspace .delivery-status {
            color: #172033;
            white-space: nowrap;
        }

        .delivery-workspace .delivery-tabs .nav-link {
            color: #17365d;
            font-weight: 600;
        }

        .delivery-workspace .delivery-tabs .nav-link.active {
            color: var(--primary-color);
            border-bottom: 3px solid var(--primary-color);
        }

        @media (max-width: 575.98px) {
            .delivery-workspace .delivery-thumb {
                width: 88px;
                height: 72px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="staff-page-content container-fluid px-3 px-xl-4 py-3 delivery-workspace">

        <div class="page-header">
            <h1 class="page-title">My Deliveries</h1>
            <p class="page-subtitle mb-0">
                View assigned deliveries, start a delivery and record customer handover.
            </p>
        </div>

        <asp:Panel ID="pnlDeliveryMessage" runat="server" Visible="false"
            CssClass="alert alert-info" role="status">
            <asp:Literal ID="litDeliveryMessage" runat="server" />
        </asp:Panel>

        <section class="card mb-3">
            <div class="card-body">
                <ul class="nav nav-tabs delivery-tabs mb-3" aria-label="Delivery status filters">
                    <li class="nav-item">
                        <asp:LinkButton ID="lnkAll" runat="server"
                            CssClass="nav-link active" OnClick="FilterAll_Click"
                            CausesValidation="false" />
                    </li>
                    <li class="nav-item">
                        <asp:LinkButton ID="lnkPending" runat="server"
                            CssClass="nav-link" OnClick="FilterPending_Click"
                            CausesValidation="false" />
                    </li>
                    <li class="nav-item">
                        <asp:LinkButton ID="lnkOutForDelivery" runat="server"
                            CssClass="nav-link" OnClick="FilterOut_Click"
                            CausesValidation="false" />
                    </li>
                    <li class="nav-item">
                        <asp:LinkButton ID="lnkCompleted" runat="server"
                            CssClass="nav-link" OnClick="FilterCompleted_Click"
                            CausesValidation="false" />
                    </li>
                </ul>

                <div class="row g-2 align-items-end">
                    <div class="col-sm-6 col-lg-2">
                        <asp:Label ID="lblDate" runat="server" AssociatedControlID="txtDate"
                            CssClass="form-label" Text="Event date" />
                        <asp:TextBox ID="txtDate" runat="server"
                            TextMode="Date" CssClass="form-control" />
                    </div>

                    <div class="col-sm-6 col-lg-2">
                        <asp:Label ID="lblStatus" runat="server" AssociatedControlID="ddlStatus"
                            CssClass="form-label" Text="Status" />
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                            <asp:ListItem Text="All statuses" Value="" />
                            <asp:ListItem Text="Pending" Value="Pending" />
                            <asp:ListItem Text="Scheduled" Value="Scheduled" />
                            <asp:ListItem Text="Out for delivery" Value="Out for Delivery" />
                            <asp:ListItem Text="Delivered" Value="Delivered" />
                        </asp:DropDownList>
                    </div>

                    <div class="col-sm-8 col-lg-6">
                        <asp:Label ID="lblSearch" runat="server" AssociatedControlID="txtSearch"
                            CssClass="form-label" Text="Search deliveries" />
                        <asp:TextBox ID="txtSearch" runat="server"
                            CssClass="form-control"
                            placeholder="Booking reference or customer" />
                    </div>

                    <div class="col-sm-4 col-lg-2">
                        <asp:Button ID="btnSearch" runat="server" Text="Search"
                            CssClass="btn btn-forte w-100"
                            OnClick="Search_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>
        </section>

        <asp:Repeater ID="rptDeliveries" runat="server"
            OnItemCommand="rptDeliveries_ItemCommand"
            OnItemDataBound="rptDeliveries_ItemDataBound">
            <ItemTemplate>
                <article class="card delivery-card mb-3">
                    <div class="row g-0 align-items-center">
                        <div class="col-auto p-3">
                            <img src='<%#: Eval("ImageUrl") %>'
                                alt="Equipment for <%#: Eval("EventType") %>"
                                class="img-fluid delivery-thumb" />
                        </div>

                        <div class="col">
                            <div class="card-body ps-0">
                                <div class="d-flex flex-wrap justify-content-between align-items-start gap-2">
                                    <div>
                                        <strong><%#: Eval("BookingId") %> · <%#: Eval("EventType") %></strong>
                                        <div><%#: Eval("Customer") %></div>
                                        <div class="small text-muted">
                                            <%#: Eval("EventDate", "{0:dd MMM yyyy}") %>
                                            · Delivery at <%#: Eval("EventTime") %>
                                        </div>
                                        <div class="small text-muted">
                                            Location: <%#: Eval("Venue") %>
                                        </div>
                                    </div>

                                    <span class='badge delivery-status <%# Eval("StatusCss") %>'>
                                        <%#: Eval("Status") %>
                                    </span>
                                </div>

                                <p class="small text-muted mt-2 mb-0">
                                    <%#: Eval("Items") %>
                                </p>
                            </div>
                        </div>

                        <div class="col-12 col-md-auto px-3 pb-3 pt-md-3">
                            <div class="d-flex flex-row flex-md-column gap-2">
                                <asp:LinkButton ID="lnkViewDetails" runat="server"
                                    CssClass="btn btn-sm btn-outline-primary"
                                    CausesValidation="false"
                                    CommandName="ViewDetails"
                                    CommandArgument='<%# Eval("BookingId") %>'>
                                    View details
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnStartDelivery" runat="server"
                                    CssClass="btn btn-sm btn-forte"
                                    CausesValidation="false"
                                    CommandName="StartDelivery"
                                    CommandArgument='<%# Eval("TaskID") %>'>
                                    Start delivery
                                </asp:LinkButton>

                                <asp:HyperLink ID="lnkOpenHandover" runat="server"
                                    CssClass="btn btn-sm btn-forte"
                                    Visible="false">
                                    Open handover form
                                </asp:HyperLink>

                                <asp:PlaceHolder ID="phDeliveryComplete" runat="server"
                                    Visible="false">
                                    <span class="small text-success align-self-center">
                                        Handover completed
                                    </span>
                                </asp:PlaceHolder>
                            </div>
                        </div>
                    </div>
                </article>
            </ItemTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlNoDeliveries" runat="server" Visible="false"
            CssClass="card p-4 text-center text-muted">
            <strong class="d-block mb-1">No deliveries found</strong>
            <asp:Literal ID="litNoDeliveries" runat="server" />
        </asp:Panel>

        <asp:Panel ID="pnlDeliveryDetailsModal" runat="server"
            ClientIDMode="Static" Visible="false" CssClass="modal fade"
            TabIndex="-1" role="dialog" aria-labelledby="deliveryDetailsTitle"
            aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <div>
                            <h2 class="modal-title h5" id="deliveryDetailsTitle">
                                Delivery details
                            </h2>
                            <div class="small text-muted">
                                <asp:Literal ID="litDeliveryDetailBooking" runat="server" />
                            </div>
                        </div>
                        <button type="button" class="btn-close"
                            data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">
                        <section class="card mb-4">
                            <div class="card-header fw-semibold">
                                Customer and delivery information
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-sm-6 col-lg-3">
                                        <div class="small text-muted">Customer</div>
                                        <strong><asp:Literal ID="litDeliveryDetailCustomer" runat="server" /></strong>
                                        <div><asp:Literal ID="litDeliveryDetailPhone" runat="server" /></div>
                                    </div>
                                    <div class="col-sm-6 col-lg-3">
                                        <div class="small text-muted">Event</div>
                                        <strong><asp:Literal ID="litDeliveryDetailEvent" runat="server" /></strong>
                                        <div><asp:Literal ID="litDeliveryDetailDate" runat="server" /></div>
                                    </div>
                                    <div class="col-sm-6 col-lg-3">
                                        <div class="small text-muted">Equipment needed at</div>
                                        <strong><asp:Literal ID="litDeliveryDetailNeededAt" runat="server" /></strong>
                                    </div>
                                    <div class="col-sm-6 col-lg-3">
                                        <div class="small text-muted">Delivery status</div>
                                        <strong><asp:Literal ID="litDeliveryDetailStatus" runat="server" /></strong>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="small text-muted">Delivery address</div>
                                        <strong><asp:Literal ID="litDeliveryDetailAddress" runat="server" /></strong>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="small text-muted">Delivery instructions</div>
                                        <asp:Literal ID="litDeliveryDetailInstructions" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </section>

                        <h3 class="h6 mb-3">Equipment for delivery</h3>

                        <asp:Panel ID="pnlDeliveryPackageDetail" runat="server"
                            Visible="false" CssClass="card mb-3">
                            <div class="row g-0 align-items-center">
                                <div class="col-auto p-3">
                                    <asp:Image ID="imgDeliveryPackage" runat="server"
                                        CssClass="img-fluid rounded delivery-package-image" />
                                </div>
                                <div class="col p-3">
                                    <div class="fw-semibold mb-2">
                                        <asp:Literal ID="litDeliveryPackageName" runat="server" />
                                    </div>
                                    <asp:Repeater ID="rptDeliveryPackageItems" runat="server">
                                        <ItemTemplate>
                                            <div class="d-flex justify-content-between border-bottom py-2">
                                                <span><%#: Eval("Name") %></span>
                                                <strong>Qty <%#: Eval("Quantity") %></strong>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Repeater ID="rptDeliveryDetailItems" runat="server">
                            <ItemTemplate>
                                <div class="card mb-2">
                                    <div class="row g-0 align-items-center">
                                        <div class="col-auto p-3">
                                            <img src='<%#: Eval("ImageUrl") %>'
                                                alt='<%#: Eval("Name") %>'
                                                class="img-fluid delivery-detail-thumb" />
                                        </div>
                                        <div class="col px-2">
                                            <strong><%#: Eval("Name") %></strong>
                                            <div class="small text-muted">Booking item</div>
                                        </div>
                                        <div class="col-auto px-4">
                                            <span class="small text-muted">Quantity</span>
                                            <div class="fw-semibold text-center">
                                                <%#: Eval("Quantity") %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary"
                            data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>