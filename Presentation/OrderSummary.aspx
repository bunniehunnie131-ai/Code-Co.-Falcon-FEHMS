<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Presentation/SystemLayout.Master" CodeBehind="OrderSummary.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.OrderSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

   <style>
    /* ==============================
       FEHMS ORDER SUMMARY
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
        --fehms-warning: #b45309;
        --fehms-warning-bg: #fef3c7;
    }

    /* ==============================
       PAGE
       ============================== */

    .order-summary-page {
        background: var(--fehms-background);
        min-height: 100vh;
        padding: 25px 30px 45px;
    }

    /* ==============================
       PAGE HEADER
       ============================== */

    .page-header {
        background: var(--fehms-white);
        border: 1px solid var(--fehms-border);
        border-radius: 16px;
        padding: 25px 30px;
        margin-bottom: 25px;
        box-shadow: 0 4px 18px rgba(15, 23, 42, 0.06);
    }

    .page-title {
        color: var(--fehms-primary-dark);
        font-size: 29px;
        font-weight: 700;
        margin: 0 0 7px;
        letter-spacing: -0.3px;
    }

    .page-subtitle {
        color: var(--fehms-muted);
        margin: 0;
        font-size: 14px;
    }

    /* ==============================
       SUMMARY CARDS
       ============================== */

    .summary-card {
        background: var(--fehms-white);
        border: 1px solid var(--fehms-border);
        border-radius: 15px;
        padding: 26px;
        margin-bottom: 22px;
        box-shadow: 0 4px 16px rgba(15, 23, 42, 0.05);
    }

    .summary-card:hover {
        box-shadow: 0 7px 22px rgba(15, 23, 42, 0.07);
    }

    .section-title {
        display: flex;
        align-items: center;
        gap: 9px;
        color: var(--fehms-primary-dark);
        font-size: 18px;
        font-weight: 700;
        margin: 0 0 20px;
        padding-bottom: 13px;
        border-bottom: 1px solid var(--fehms-border);
    }

    .section-title::before {
        content: "";
        width: 4px;
        height: 20px;
        background: var(--fehms-primary);
        border-radius: 4px;
        display: inline-block;
    }

    /* ==============================
       INFORMATION BOXES
       ============================== */

    .order-info {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
    }

    .info-box {
        background: #f8fafc;
        border: 1px solid #edf1f5;
        padding: 16px 18px;
        border-radius: 10px;
        transition: all 0.2s ease;
    }

    .info-box:hover {
        background: #f1f5f9;
        border-color: #dbe3ee;
    }

    .info-label {
        font-size: 12px;
        color: var(--fehms-muted);
        margin-bottom: 6px;
        font-weight: 500;
    }

    .info-value {
        font-size: 14px;
        font-weight: 600;
        color: var(--fehms-text);
        word-break: break-word;
    }

    /* ==============================
       STATUS
       ============================== */

    .status {
        display: inline-flex;
        align-items: center;
        padding: 6px 12px;
        border-radius: 20px;
        background: var(--fehms-primary-light);
        color: var(--fehms-primary);
        font-size: 12px;
        font-weight: 700;
    }

    /* ==============================
       ORDER TABLE
       ============================== */

    .table-responsive {
        border-radius: 10px;
        overflow-x: auto;
    }

    .order-table {
        width: 100%;
        border-collapse: collapse;
        min-width: 700px;
    }

    .order-table th {
        background: var(--fehms-primary);
        color: #ffffff;
        padding: 14px 16px;
        text-align: left;
        font-size: 12px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.3px;
        white-space: nowrap;
    }

    .order-table th:first-child {
        border-radius: 8px 0 0 0;
    }

    .order-table th:last-child {
        border-radius: 0 8px 0 0;
    }

    .order-table td {
        padding: 15px 16px;
        border-bottom: 1px solid var(--fehms-border);
        color: #374151;
        font-size: 13px;
        background: #ffffff;
    }

    .order-table tbody tr:hover td {
        background: #f8faff;
    }

    .order-table tbody tr:last-child td {
        border-bottom: none;
    }

    /* Total Row */
    .total-row td {
        background: #f8fafc !important;
        border-top: 2px solid var(--fehms-primary-light);
        border-bottom: none;
        color: var(--fehms-primary-dark);
        font-weight: 700;
        font-size: 15px;
    }

    .total-row td:last-child {
        color: var(--fehms-primary);
        font-size: 17px;
    }

    /* ==============================
       PAYMENT SECTION
       ============================== */

    .payment-highlight {
        border-left: 4px solid var(--fehms-primary);
    }

    /* ==============================
       BUTTON
       ============================== */

    .order-actions {
        display: flex;
        justify-content: flex-end;
        margin-top: 5px;
    }

    .btn-primary-custom {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        background: var(--fehms-primary);
        border: none;
        color: #ffffff;
        padding: 11px 22px;
        min-height: 44px;
        border-radius: 9px;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        transition: all 0.2s ease;
        box-shadow: 0 3px 8px rgba(30, 58, 138, 0.18);
    }

    .btn-primary-custom:hover {
        background: var(--fehms-primary-dark);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 5px 12px rgba(30, 58, 138, 0.25);
    }

    /* ==============================
       RESPONSIVE
       ============================== */

    @media (max-width: 768px) {

        .order-summary-page {
            padding: 18px 15px 35px;
        }

        .page-header {
            padding: 22px;
        }

        .page-title {
            font-size: 25px;
        }

        .summary-card {
            padding: 20px;
        }

        .order-info {
            grid-template-columns: 1fr;
            gap: 12px;
        }

        .order-actions {
            justify-content: stretch;
        }

        .btn-primary-custom {
            width: 100%;
        }
    }

    @media (max-width: 480px) {

        .page-title {
            font-size: 22px;
        }

        .page-subtitle {
            font-size: 13px;
        }

        .summary-card {
            padding: 17px;
        }

        .section-title {
            font-size: 16px;
        }

        .info-box {
            padding: 14px;
        }
    }
</style>

    <div class="container-fluid px-4 py-4">

        <h2 class="page-title">View Order Summary</h2>
        <p class="page-subtitle">
            Review your booking details, selected items and payment information.
        </p>

        <!-- ORDER INFORMATION -->
        <div class="summary-card">

            <h4 class="section-title">Order Information</h4>

            <div class="order-info">

                <div class="info-box">
                    <div class="info-label">Order Number</div>
                    <div class="info-value">#FEH-10025</div>
                </div>

                <div class="info-box">
                    <div class="info-label">Order Date</div>
                    <div class="info-value">18 September 2026</div>
                </div>

                <div class="info-box">
                    <div class="info-label">Event Date</div>
                    <div class="info-value">25 September 2026</div>
                </div>

                <div class="info-box">
                    <div class="info-label">Order Status</div>
                    <div class="info-value">
                        <span class="status">Pending</span>
                    </div>
                </div>

            </div>

        </div>

        <!-- CUSTOMER INFORMATION -->
        <div class="summary-card">

            <h4 class="section-title">Customer Information</h4>

            <div class="order-info">

                <div class="info-box">
                    <div class="info-label">Customer Name</div>
                    <div class="info-value">Nick Huncho</div>
                </div>

                <div class="info-box">
                    <div class="info-label">Email Address</div>
                    <div class="info-value">nickhuncho@gmail.com</div>
                </div>

                <div class="info-box">
                    <div class="info-label">Contact Number</div>
                    <div class="info-value">071 234 5678</div>
                </div>

                <div class="info-box">
                    <div class="info-label">Event Location</div>
                    <div class="info-value">East London</div>
                </div>

            </div>

        </div>

        <!-- ORDER ITEMS -->
        <div class="summary-card">

            <h4 class="section-title">Order Items</h4>

            <div class="table-responsive">

                <table class="order-table">

                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>Description</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Total</th>
                        </tr>
                    </thead>

                    <tbody>

                        <tr>
                            <td>Wedding Chairs</td>
                            <td>White padded event chairs</td>
                            <td>100</td>
                            <td>R25.00</td>
                            <td>R2,500.00</td>
                        </tr>

                        <tr>
                            <td>Round Tables</td>
                            <td>6-seater round tables</td>
                            <td>10</td>
                            <td>R150.00</td>
                            <td>R1,500.00</td>
                        </tr>

                        <tr>
                            <td>Decor Package</td>
                            <td>Standard wedding decor</td>
                            <td>1</td>
                            <td>R3,000.00</td>
                            <td>R3,000.00</td>
                        </tr>

                        <tr class="total-row">
                            <td colspan="4" class="text-end">Order Total:</td>
                            <td>R7,000.00</td>
                        </tr>

                    </tbody>

                </table>

            </div>

        </div>

        <!-- PAYMENT -->
        <div class="summary-card">

            <h4 class="section-title">Payment Information</h4>

            <div class="order-info">

                <div class="info-box">
                    <div class="info-label">Payment Option</div>
                    <div class="info-value">50% Deposit</div>
                </div>

                <div class="info-box">
                    <div class="info-label">Deposit Amount</div>
                    <div class="info-value">R3,500.00</div>
                </div>

                <div class="info-box">
                    <div class="info-label">Outstanding Amount</div>
                    <div class="info-value">R3,500.00</div>
                </div>

                <div class="info-box">
                    <div class="info-label">Payment Status</div>
                    <div class="info-value">
                        <span class="status">Awaiting Payment</span>
                    </div>
                </div>

            </div>

        </div>

        <div class="text-end">
            <asp:Button ID="btnBack" runat="server"
                Text="Back to Dashboard"
                CssClass="btn-primary-custom" />
        </div>

    </div>

</asp:Content>
