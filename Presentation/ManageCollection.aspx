<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Presentation/SystemLayout.Master"
    CodeBehind="ManageCollection.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>

        /* =====================================
           FEHMS MANAGE COLLECTION
           ===================================== */

        .page-title {
            color: #142c6b;
            font-weight: 700;
        }

        .page-subtitle {
            color: #64748b;
            margin-bottom: 25px;
        }

        /* Statistics Cards */

        .stat-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(15, 23, 42, 0.06);
            transition: 0.2s ease;
        }

        .stat-card:hover {
            box-shadow: 0 6px 20px rgba(15, 23, 42, 0.10);
        }

        /* FEHMS Colours */

        .text-navy {
            color: #142c6b !important;
        }

        .text-blue {
            color: #1e3a8a !important;
        }

        /* Table Header */

        .staff-table-head {
            background-color: #f8fafc;
            color: #142c6b;
            font-size: 14px;
            font-weight: 600;
        }

        .staff-table-head th {
            border-bottom: 1px solid #e5e7eb;
            padding: 14px 12px;
        }

        /* Table */

        .table td {
            padding: 14px 12px;
            font-size: 14px;
        }

        .table-hover tbody tr:hover {
            background-color: #f8fafc;
        }

        /* Status Badges */

        .badge-status {
            display: inline-block;
            padding: 7px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            white-space: nowrap;
        }

        .status-awaiting {
            background-color: #dbeafe;
            color: #1e3a8a;
        }

        .status-overdue {
            background-color: #fee2e2;
            color: #b91c1c;
        }

        .status-collected {
            background-color: #dcfce7;
            color: #15803d;
        }

        /* Mark Collected Button */

        .btn-save-profile {
            background-color: #1e3a8a;
            border: none;
            color: #ffffff;
            font-weight: 500;
        }

        .btn-save-profile:hover {
            background-color: #142c6b;
            color: #ffffff;
        }

        /* Success Message */

        .alert-success {
            border-radius: 10px;
        }

        /* Mobile */

        @media (max-width: 768px) {

            .table {
                min-width: 900px;
            }

            .stat-card {
                margin-bottom: 10px;
            }

        }

    </style>


    <!-- =====================================
         PAGE HEADER
         ===================================== -->

    <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">

        <div>

            <h2 class="page-title mb-1 heading-font">
                Manage Collection
            </h2>

            <p class="page-subtitle m-0">
                Equipment that has been delivered and is awaiting collection from customers.
            </p>

        </div>

    </div>


    <!-- =====================================
         SUCCESS MESSAGE
         ===================================== -->

    <asp:Panel
        ID="pnlMessage"
        runat="server"
        Visible="false"
        CssClass="alert alert-success mb-4"
        role="alert">

        <i class="bi bi-check-circle-fill me-2"></i>

        <asp:Label
            ID="lblStatusMessage"
            runat="server"
            Text="" />

    </asp:Panel>


    <!-- =====================================
         STATISTICS CARDS
         ===================================== -->

    <div class="row g-3 mb-4">

        <!-- Awaiting Collection -->

        <div class="col-md-4">

            <div class="card stat-card h-100 p-3">

                <div class="d-flex align-items-center justify-content-between">

                    <span class="text-muted small">
                        Awaiting Collection
                    </span>

                    <i class="bi bi-box-arrow-in-down text-blue"></i>

                </div>

                <h3 class="text-navy mt-2 fw-bold">

                    <asp:Label
                        ID="lblAwaitingCount"
                        runat="server"
                        Text="0" />

                </h3>

            </div>

        </div>


        <!-- Overdue -->

        <div class="col-md-4">

            <div class="card stat-card h-100 p-3">

                <div class="d-flex align-items-center justify-content-between">

                    <span class="text-muted small">
                        Overdue
                    </span>

                    <i class="bi bi-exclamation-triangle text-blue"></i>

                </div>

                <h3 class="text-navy mt-2 fw-bold">

                    <asp:Label
                        ID="lblOverdueCount"
                        runat="server"
                        Text="0" />

                </h3>

            </div>

        </div>


        <!-- Collected Today -->

        <div class="col-md-4">

            <div class="card stat-card h-100 p-3">

                <div class="d-flex align-items-center justify-content-between">

                    <span class="text-muted small">
                        Collected Today
                    </span>

                    <i class="bi bi-check2-circle text-blue"></i>

                </div>

                <h3 class="text-navy mt-2 fw-bold">

                    <asp:Label
                        ID="lblCollectedTodayCount"
                        runat="server"
                        Text="0" />

                </h3>

            </div>

        </div>

    </div>


    <!-- =====================================
         COLLECTIONS TABLE
         ===================================== -->

    <div class="card stat-card p-3">

        <div class="table-responsive">

            <table class="table table-hover align-middle mb-0">

                <thead>

                    <tr class="staff-table-head">

                        <th>
                            Order
                        </th>

                        <th>
                            Customer
                        </th>

                        <th>
                            Address
                        </th>

                        <th>
                            Items
                        </th>

                        <th>
                            Delivered
                        </th>

                        <th>
                            Collection Due
                        </th>

                        <th>
                            Status
                        </th>

                        <th class="text-end">
                            Action
                        </th>

                    </tr>

                </thead>


                <tbody>

                    <asp:Repeater
                        ID="rptCollections"
                        runat="server"
                        OnItemCommand="rptCollections_ItemCommand">

                        <ItemTemplate>

                            <tr>

                                <!-- Order -->

                                <td class="fw-bold text-blue">

                                    <%# Eval("BookingReference") %>

                                </td>


                                <!-- Customer -->

                                <td>

                                    <%# Eval("CustomerName") %>

                                </td>


                                <!-- Address -->

                                <td class="text-muted small">

                                    <%# Eval("Address") %>

                                </td>


                                <!-- Items -->

                                <td class="text-muted small">

                                    <%# Eval("ItemsSummary") %>

                                </td>


                                <!-- Delivered -->

                                <td>

                                    <%# Eval("DeliveryDate", "{0:dd MMM yyyy}") %>

                                </td>


                                <!-- Collection Due -->

                                <td>

                                    <%# Eval("CollectionDueDate", "{0:dd MMM yyyy}") %>

                                </td>


                                <!-- Status -->

                                <td>

                                    <span class='<%# "badge-status " + GetStatusBadgeClass(Eval("Status").ToString()) %>'>

                                        <%# Eval("Status") %>

                                    </span>

                                </td>


                                <!-- Action -->

                                <td class="text-end">

                                    <asp:LinkButton
                                        ID="btnMarkCollected"
                                        runat="server"
                                        CssClass="btn btn-save-profile btn-sm rounded-pill px-3"
                                        CommandName="MarkCollected"
                                        CommandArgument='<%# Eval("OrderID") %>'
                                        Visible='<%# Eval("Status").ToString() != "Collected" %>'>

                                        <i class="bi bi-check2-circle me-1"></i>
                                        Mark Collected

                                    </asp:LinkButton>


                                    <span
                                        class="text-success small fw-semibold"
                                        style='<%# Eval("Status").ToString() == "Collected" ? "" : "display:none;" %>'>

                                        <i class="bi bi-check-circle-fill me-1"></i>
                                        Done

                                    </span>

                                </td>

                            </tr>

                        </ItemTemplate>

                    </asp:Repeater>

                </tbody>

            </table>


            <!-- =====================================
                 NO COLLECTIONS MESSAGE
                 ===================================== -->

            <asp:Panel
                ID="pnlNoCollections"
                runat="server"
                Visible="false"
                CssClass="text-center text-muted py-5">

                <i class="bi bi-box-seam fs-2 d-block mb-2"></i>

                No equipment currently awaiting collection.

            </asp:Panel>

        </div>

    </div>

</asp:Content>