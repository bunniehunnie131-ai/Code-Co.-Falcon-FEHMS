<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManageCollections.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageCollections" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <style>
        .collection-workspace .collection-card {
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-small);
        }

        .collection-workspace .collection-thumb {
            display: block;
            width: 128px;
            height: 96px;
            object-fit: cover;
            border-radius: 8px;
        }

        .collection-workspace .collection-status {
            color: #172033;
            white-space: nowrap;
        }

        .collection-workspace .nav-tabs .nav-link {
            color: #17365d;
            font-weight: 600;
        }

        .collection-workspace .nav-tabs .nav-link.active {
            color: var(--primary-color);
            border-bottom: 3px solid var(--primary-color);
        }

        @media (max-width: 575.98px) {
            .collection-workspace .collection-thumb {
                width: 88px;
                height: 72px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="staff-page-content container-fluid px-3 px-xl-4 py-3 collection-workspace">

        <div class="page-header">
            <h1 class="page-title">My Collections</h1>
            <p class="page-subtitle mb-0">
                View collection tasks assigned to you and record equipment after the event.
            </p>
        </div>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false"
            CssClass="alert alert-warning" role="alert">
            <asp:Literal ID="litMessage" runat="server" />
        </asp:Panel>

        <section class="card mb-3">
            <div class="card-body">
                <ul class="nav nav-tabs mb-3" aria-label="Collection status filters">
                    <li class="nav-item">
                        <asp:LinkButton ID="lnkAll" runat="server"
                            CssClass="nav-link active" OnClick="FilterAll_Click"
                            CausesValidation="false">
                            All collections (<asp:Literal ID="litAllCount" runat="server" />)
                        </asp:LinkButton></li><li class="nav-item">
                        <asp:LinkButton ID="lnkPending" runat="server"
                            CssClass="nav-link" OnClick="FilterPending_Click"
                            CausesValidation="false">
                            Awaiting collection (<asp:Literal ID="litPendingCount" runat="server" />)
                        </asp:LinkButton></li><li class="nav-item">
                        <asp:LinkButton ID="lnkCollected" runat="server"
                            CssClass="nav-link" OnClick="FilterCollected_Click"
                            CausesValidation="false">
                            Collected (<asp:Literal ID="litCollectedCount" runat="server" />)
                        </asp:LinkButton></li></ul><div class="row g-2 align-items-end">
                    <div class="col-lg-6">
                        <asp:Label ID="lblSearch" runat="server"
                            AssociatedControlID="txtSearch"
                            CssClass="form-label" Text="Search collections" />
                        <asp:TextBox ID="txtSearch" runat="server"
                            CssClass="form-control"
                            placeholder="Booking reference, customer or event" />
                    </div>

                    <div class="col-sm-6 col-lg-3">
                        <asp:Label ID="lblDate" runat="server"
                            AssociatedControlID="txtDate"
                            CssClass="form-label" Text="Collection date" />
                        <asp:TextBox ID="txtDate" runat="server"
                            TextMode="Date" CssClass="form-control" />
                    </div>

                    <div class="col-sm-6 col-lg-3 d-flex gap-2">
                        <asp:Button ID="btnSearch" runat="server" Text="Search"
                            CssClass="btn btn-forte flex-fill"
                            OnClick="Search_Click" CausesValidation="false" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear"
                            CssClass="btn btn-outline-secondary"
                            OnClick="Clear_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>
        </section>

        <asp:Repeater ID="rptCollections" runat="server"
            OnItemDataBound="rptCollections_ItemDataBound">
            <ItemTemplate>
                <article class="card collection-card mb-3">
                    <div class="row g-0 align-items-center">
                        <div class="col-auto p-3">
                            <img src='<%#: Eval("ImageUrl") %>'
                                alt="Equipment for <%#: Eval("EventType") %>"
                                class="img-fluid collection-thumb" />
                        </div>

                        <div class="col">
                            <div class="card-body ps-0">
                                <div class="d-flex flex-wrap justify-content-between align-items-start gap-2">
                                    <div>
                                        <strong>
                                            <%#: Eval("BookingReference") %> · <%#: Eval("EventType") %></strong><div><%#: Eval("Customer") %></div>
                                        <div class="small text-muted"><%#: Eval("Phone") %></div>
                                    </div>

                                    <span class='badge collection-status <%# Eval("StatusCss") %>'>
                                        <%#: Eval("TaskStatus") %>
                                    </span>
                                </div>

                                <div class="row g-2 small text-muted mt-1">
                                    <div class="col-sm-6">
                                        Collection: <%#: Eval("CollectionAt", "{0:dd MMM yyyy, HH:mm}") %></div><div class="col-sm-6">
                                        Event ends: <%#: Eval("EventEndAt", "{0:dd MMM yyyy, HH:mm}") %></div><div class="col-12">
                                        Location: <%#: Eval("Location") %></div></div><p class="small mt-2 mb-0"><%#: Eval("ItemsSummary") %></p>
                            </div>
                        </div>

                        <div class="col-12 col-md-auto px-3 pb-3 pt-md-3">
                            <asp:HyperLink ID="lnkOpenCollectionForm" runat="server"
                                CssClass="btn btn-sm btn-forte">
                                Open collection form
                            </asp:HyperLink><asp:PlaceHolder ID="phWaitingForEventEnd" runat="server"
                                Visible="false">
                                <span class="small text-muted d-block mt-2">
                                    Available after the event ends </span></asp:PlaceHolder><asp:PlaceHolder ID="phAlreadyCollected" runat="server"
                                Visible="false">
                                <span class="small text-success d-block mt-2">
                                    Collection recorded </span></asp:PlaceHolder></div></div></article></ItemTemplate></asp:Repeater><asp:Panel ID="pnlEmpty" runat="server" Visible="false"
            CssClass="card p-4 text-center text-muted">
            <strong class="d-block mb-1">No collection tasks found</strong> <asp:Literal ID="litEmptyMessage" runat="server" />
        </asp:Panel>
    </div>
</asp:Content>
