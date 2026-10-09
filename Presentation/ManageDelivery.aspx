<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Presentation/SystemLayout.Master" CodeBehind="ManageDelivery.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageDelivery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
    /* ==============================
       FEHMS MANAGE DELIVERY
       ============================== */

    :root {
        --fehms-primary: #1e3a8a;
        --fehms-primary-dark: #142c6b;
        --fehms-primary-light: #dbeafe;
        --fehms-accent: #3b82f6;
        --fehms-background: #f4f6f9;
        --fehms-white: #ffffff;
        --fehms-text: #1f2937;
        --fehms-muted: #64748b;
        --fehms-border: #e5e7eb;
        --fehms-success: #15803d;
        --fehms-success-bg: #dcfce7;
        --fehms-danger: #b91c1c;
        --fehms-danger-bg: #fee2e2;
    }

    /* Page */
    .delivery-page {
        background: var(--fehms-background);
        min-height: 100vh;
        padding: 10px 5px 40px;
    }

    /* Header */
    .delivery-header {
        background: var(--fehms-white);
        border-radius: 16px;
        padding: 28px 32px;
        margin-bottom: 24px;
        border: 1px solid var(--fehms-border);
        box-shadow: 0 4px 18px rgba(15, 23, 42, 0.06);
    }

    .delivery-header h1 {
        margin: 0 0 7px;
        color: var(--fehms-primary-dark);
        font-size: 30px;
        font-weight: 700;
        letter-spacing: -0.3px;
    }

    .delivery-header p {
        margin: 0;
        color: var(--fehms-muted);
        font-size: 15px;
    }

    /* ==============================
       STAT CARDS
       ============================== */

    .delivery-stats {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 18px;
        margin-bottom: 24px;
    }

    .delivery-stat-card {
        background: var(--fehms-white);
        border: 1px solid var(--fehms-border);
        border-radius: 14px;
        padding: 21px;
        display: flex;
        align-items: center;
        gap: 16px;
        box-shadow: 0 4px 15px rgba(15, 23, 42, 0.05);
        transition: all 0.2s ease;
    }

    .delivery-stat-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 22px rgba(15, 23, 42, 0.09);
    }

    .delivery-stat-icon {
        width: 50px;
        height: 50px;
        min-width: 50px;
        border-radius: 12px;
        background: var(--fehms-primary-light);
        color: var(--fehms-primary);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 22px;
    }

    .delivery-stat-label {
        display: block;
        color: var(--fehms-muted);
        font-size: 13px;
        font-weight: 500;
        margin-bottom: 3px;
    }

    .delivery-stat-card h3 {
        margin: 0;
        color: var(--fehms-text);
        font-size: 25px;
        font-weight: 700;
    }

    /* ==============================
       FILTER CARD
       ============================== */

    .delivery-filter-card {
        background: var(--fehms-white);
        border: 1px solid var(--fehms-border);
        border-radius: 14px;
        padding: 23px;
        margin-bottom: 24px;
        display: grid;
        grid-template-columns: 2fr 1fr auto;
        gap: 18px;
        align-items: end;
        box-shadow: 0 4px 15px rgba(15, 23, 42, 0.05);
    }

    .delivery-search label,
    .delivery-status-filter label {
        display: block;
        color: var(--fehms-text);
        font-size: 13px;
        font-weight: 600;
        margin-bottom: 8px;
    }

    .form-control,
    .form-select {
        border: 1px solid #d1d5db;
        border-radius: 9px;
        padding: 11px 13px;
        min-height: 44px;
        color: var(--fehms-text);
        background-color: #ffffff;
        font-size: 14px;
    }

    .form-control:focus,
    .form-select:focus {
        border-color: var(--fehms-primary);
        box-shadow: 0 0 0 3px rgba(30, 58, 138, 0.12);
        outline: none;
    }

    .form-control::placeholder {
        color: #9ca3af;
    }

    /* Filter Buttons */
    .delivery-filter-buttons {
        display: flex;
        gap: 9px;
    }

    .delivery-search-button,
    .delivery-clear-button {
        min-height: 44px;
        padding: 10px 20px;
        border-radius: 9px;
        font-size: 14px;
        font-weight: 600;
        border: none;
    }

    .delivery-search-button {
        background: var(--fehms-primary);
        color: #ffffff;
    }

    .delivery-search-button:hover {
        background: var(--fehms-primary-dark);
        color: #ffffff;
    }

    .delivery-clear-button {
        background: #e5e7eb;
        color: #374151;
    }

    .delivery-clear-button:hover {
        background: #d1d5db;
        color: #1f2937;
    }

    /* ==============================
       TABLE CARD
       ============================== */

    .delivery-table-card {
        background: var(--fehms-white);
        border: 1px solid var(--fehms-border);
        border-radius: 14px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(15, 23, 42, 0.05);
    }

    .delivery-table-header {
        padding: 22px 25px;
        border-bottom: 1px solid var(--fehms-border);
        background: #ffffff;
    }

    .delivery-table-header h2 {
        margin: 0 0 5px;
        color: var(--fehms-primary-dark);
        font-size: 19px;
        font-weight: 700;
    }

    .delivery-table-header p {
        margin: 0;
        color: var(--fehms-muted);
        font-size: 13px;
    }

    /* Table */
    .delivery-table {
        margin: 0;
        width: 100%;
        color: var(--fehms-text);
        vertical-align: middle;
    }

    .delivery-table thead th {
        background: #f8fafc;
        color: #475569;
        border-bottom: 1px solid var(--fehms-border);
        padding: 14px 16px;
        font-size: 12px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.3px;
        white-space: nowrap;
    }

    .delivery-table tbody td {
        padding: 16px;
        border-bottom: 1px solid #eef2f7;
        color: #374151;
        font-size: 13px;
        vertical-align: middle;
    }

    .delivery-table tbody tr {
        transition: background-color 0.15s ease;
    }

    .delivery-table tbody tr:hover {
        background-color: #f8faff;
    }

    .delivery-table tbody tr:last-child td {
        border-bottom: none;
    }

    /* Delivery Address */
    .delivery-address {
        line-height: 1.6;
        color: #4b5563;
    }

    /* ==============================
       STATUS BADGES
       ============================== */

    .status-badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 6px 11px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 700;
        white-space: nowrap;
    }

    .status-scheduled {
        background: #dbeafe;
        color: #1e3a8a;
    }

    .status-delivered {
        background: var(--fehms-success-bg);
        color: var(--fehms-success);
    }

    .status-overdue {
        background: var(--fehms-danger-bg);
        color: var(--fehms-danger);
    }

    .status-default {
        background: #e5e7eb;
        color: #374151;
    }

    /* ==============================
       VIEW BUTTON
       ============================== */

    .view-delivery-button {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: #eff6ff;
        color: var(--fehms-primary);
        border: 1px solid #bfdbfe;
        padding: 7px 12px;
        border-radius: 7px;
        font-size: 12px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .view-delivery-button:hover {
        background: var(--fehms-primary);
        border-color: var(--fehms-primary);
        color: #ffffff;
        text-decoration: none;
    }

    /* ==============================
       PAGING
       ============================== */

    .delivery-table tr:last-child td {
        border-bottom: none;
    }

    .delivery-table-card table > tbody > tr:last-child {
        border-bottom: none;
    }

    /* ==============================
       RESPONSIVE
       ============================== */

    @media (max-width: 1100px) {
        .delivery-stats {
            grid-template-columns: repeat(2, 1fr);
        }

        .delivery-filter-card {
            grid-template-columns: 1fr 1fr;
        }

        .delivery-filter-buttons {
            grid-column: 1 / -1;
        }
    }

    @media (max-width: 700px) {
        .delivery-page {
            padding: 5px 0 30px;
        }

        .delivery-header {
            padding: 22px;
        }

        .delivery-header h1 {
            font-size: 25px;
        }

        .delivery-stats {
            grid-template-columns: 1fr;
        }

        .delivery-filter-card {
            grid-template-columns: 1fr;
            padding: 18px;
        }

        .delivery-filter-buttons {
            grid-column: auto;
        }

        .delivery-search-button,
        .delivery-clear-button {
            flex: 1;
        }

        .delivery-table-header {
            padding: 18px;
        }

        .table-responsive {
            overflow-x: auto;
        }
    }
</style>
    
    <div class="delivery-page">

    <!-- Page Header -->
    <div class="delivery-header">
        <div>
            <h1>Manage Deliveries</h1>
            <p>View and monitor all scheduled and completed deliveries.</p>
        </div>
    </div>

    <!-- Delivery Summary -->
    <div class="delivery-stats">

        <div class="delivery-stat-card">
            <div class="delivery-stat-icon">
                <i class="bi bi-truck"></i>
            </div>
            <div>
                <span class="delivery-stat-label">Scheduled</span>
                <h3>12</h3>
            </div>
        </div>

        <div class="delivery-stat-card">
            <div class="delivery-stat-icon">
                <i class="bi bi-check-circle"></i>
            </div>
            <div>
                <span class="delivery-stat-label">Delivered</span>
                <h3>28</h3>
            </div>
        </div>

        <div class="delivery-stat-card">
            <div class="delivery-stat-icon">
                <i class="bi bi-exclamation-circle"></i>
            </div>
            <div>
                <span class="delivery-stat-label">Overdue</span>
                <h3>3</h3>
            </div>
        </div>

        <div class="delivery-stat-card">
            <div class="delivery-stat-icon">
                <i class="bi bi-box-seam"></i>
            </div>
            <div>
                <span class="delivery-stat-label">Total Deliveries</span>
                <h3>43</h3>
            </div>
        </div>

    </div>

    <!-- Search and Filter -->
    <div class="delivery-filter-card">

        <div class="delivery-search">
            <label for="txtSearch">Search Deliveries</label>
            <asp:TextBox 
                ID="txtSearch" 
                runat="server"
                CssClass="form-control"
                placeholder="Search by booking reference or customer name">
            </asp:TextBox>
        </div>

        <div class="delivery-status-filter">
            <label for="ddlStatus">Delivery Status</label>

            <asp:DropDownList 
                ID="ddlStatus" 
                runat="server"
                CssClass="form-select">

                <asp:ListItem Text="All Deliveries" Value=""></asp:ListItem>
                <asp:ListItem Text="Scheduled" Value="Scheduled"></asp:ListItem>
                <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                <asp:ListItem Text="Overdue" Value="Overdue"></asp:ListItem>

            </asp:DropDownList>
        </div>

        <div class="delivery-filter-buttons">

            <asp:Button 
                ID="btnSearch"
                runat="server"
                Text="Search"
                CssClass="btn btn-primary delivery-search-button" />

            <asp:Button 
                ID="btnClear"
                runat="server"
                Text="Clear"
                CssClass="btn btn-secondary delivery-clear-button" />

        </div>

    </div>

    <!-- Deliveries Table -->
    <div class="delivery-table-card">

        <div class="delivery-table-header">
            <div>
                <h2>Delivery Records</h2>
                <p>Scheduled and completed deliveries</p>
            </div>
        </div>

        <div class="table-responsive">

            <asp:GridView 
                ID="gvDeliveries"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="table delivery-table"
                GridLines="None"
                EmptyDataText="No delivery records found."
                AllowPaging="True"
                PageSize="10" OnSelectedIndexChanged="gvDeliveries_SelectedIndexChanged">

                <Columns>

                    <asp:BoundField 
                        DataField="DeliveryID"
                        HeaderText="Delivery ID" />

                    <asp:BoundField 
                        DataField="BookingReference"
                        HeaderText="Booking Reference" />

                    <asp:BoundField 
                        DataField="CustomerName"
                        HeaderText="Customer" />

                    <asp:BoundField 
                        DataField="Phone"
                        HeaderText="Contact Number" />

                    <asp:BoundField 
                        DataField="ScheduledDate"
                        HeaderText="Delivery Date"
                        DataFormatString="{0:dd MMM yyyy}" />

                    <asp:TemplateField HeaderText="Delivery Address">

                        <ItemTemplate>

                            <div class="delivery-address">
                                <%# Eval("StreetAddress") %><br />
                                <%# Eval("Suburb") %>,
                                <%# Eval("City") %><br />
                                <%# Eval("PostalCode") %>
                            </div>

                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:BoundField 
                        DataField="StaffName"
                        HeaderText="Assigned Staff" />

                    <asp:TemplateField HeaderText="Status">

                        <ItemTemplate>

                            <span class='status-badge <%# GetStatusClass(Eval("DeliveryStatus").ToString()) %>'>
                                <%# Eval("DeliveryStatus") %>
                            </span>

                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>

                            <asp:LinkButton

                                ID="btnView"
                                runat="server"
                                CommandName="ViewDelivery"
                                CommandArgument='<%# Eval("DeliveryID") %>'
                                CssClass="view-delivery-button">
                                <i class="bi bi-eye"></i>
                                View

                            </asp:LinkButton>

                        </ItemTemplate>

                    </asp:TemplateField>

                </Columns>

            </asp:GridView>

        </div>
    </div>
</div>

</asp:Content>
