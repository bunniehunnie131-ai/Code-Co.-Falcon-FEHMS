using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class OrderConfirmation : System.Web.UI.Page
    {

            protected void Page_Load(object sender, EventArgs e)
            {
                DataTable items =
                    Session["ConfirmedBookingItems"] as DataTable;

                if (items == null ||
                    items.Rows.Count == 0 ||
                    Get("PaymentStatus", "") != "Paid")
                {
                    Response.Redirect("WebForm1.aspx");
                    return;
                }

                // Save a copy for the dashboard before another checkout
                // changes the current session values.
                // BookingHistory prevents duplicate booking references.
                BookingHistory.Save(Context, BuildReceiptHtml());

                // Keep the confirmation page visible.
                if (!IsPostBack)
                {
                    LoadConfirmation();
                }
            }

            private string Get(string key, string fallback)
            {
                string value = Convert.ToString(Session[key]);

                return string.IsNullOrWhiteSpace(value)
                    ? fallback
                    : value;
            }

            private decimal Money(string key)
            {
                decimal amount;

                return decimal.TryParse(
                    Convert.ToString(Session[key]), out amount)
                    ? amount
                    : 0m;
            }

            private int Qty(string key)
            {
                int quantity;

                return int.TryParse(
                    Convert.ToString(Session[key]), out quantity)
                    ? quantity
                    : 0;
            }

            private bool SetupIsRequired()
            {
                bool required;

                return bool.TryParse(
                    Convert.ToString(Session["SetupRequired"]),
                    out required) && required;
            }

            private string PaymentTime()
            {
                DateTime paidAt;

                return DateTime.TryParse(
                    Get("PaymentDateTime", ""), out paidAt)
                    ? paidAt.ToString("dd MMMM yyyy HH:mm")
                    : "-";
            }

            private string JoinAddress()
            {
                string[] parts =
                {
                Get("DeliveryAddress", ""),
                Get("DeliveryCity", ""),
                Get("DeliveryProvince", ""),
                Get("DeliveryPostalCode", "")
            };

                return string.Join(
                    ", ",
                    Array.FindAll(
                        parts,
                        value => !string.IsNullOrWhiteSpace(value)));
            }

            private string FirstTime()
            {
                if (Get("TransportMethod", "") ==
                    "Forte Delivery & Collection")
                {
                    return Get("DeliveryDate", "-") +
                           " at " + Get("DeliveryTime", "-");
                }

                return Get("CustomerCollectionDate", "-") +
                       " at " + Get("CustomerCollectionTime", "-");
            }

            private string SecondTime()
            {
                if (Get("TransportMethod", "") ==
                    "Forte Delivery & Collection")
                {
                    return Get("CollectionDate", "-") +
                           " at " + Get("CollectionTime", "-");
                }

                return Get("ReturnDate", "-") +
                       " at " + Get("ReturnTime", "-");
            }

            private string BookingAddress()
            {
                return Get("TransportMethod", "") ==
                       "Forte Delivery & Collection"
                    ? JoinAddress()
                    : "Forte Event Hire collection / return point";
            }

            private void SetText(Label label, string value)
            {
                label.Text = E(value);
            }

            private void LoadConfirmation()
            {
                SetText(lblCustomerName,
                    Get("CustomerFullName", "Customer"));

                SetText(lblBookingReference,
                    Get("BookingReference", "-"));

                SetText(lblPaymentReference,
                    Get("PaymentReference", "-"));

                SetText(lblBookingStatus,
                    "Booking: " + Get("BookingStatus", "Confirmed"));

                SetText(lblPaymentStatus,
                    "Payment: " + Get("PaymentStatus", "Paid"));

                SetText(lblCustomer, Get("CustomerFullName", "-"));
                SetText(lblEmail, Get("CustomerEmail", "-"));
                SetText(lblPhone, Get("CustomerPhone", "-"));
                SetText(lblEventDate, Get("EventDate", "-"));
                SetText(lblEventType, Get("EventType", "-"));
                SetText(lblPaymentDateTime, PaymentTime());

                rptItems.DataSource =
                    Session["ConfirmedBookingItems"] as DataTable;

                rptItems.DataBind();

                SetText(lblTransportMethod,
                    Get("TransportMethod", "-"));

                SetText(lblAddress, BookingAddress());
                SetText(lblFirstTime, FirstTime());
                SetText(lblSecondTime, SecondTime());
                SetText(lblSetup, SetupIsRequired() ? "Yes" : "No");

                lblProviders.Text = ProviderHtml();

                SetText(lblItemTotal, Rand(Money("BookingTotal")));
                SetText(lblDeliveryFee, Rand(Money("DeliveryFee")));
                SetText(lblSetupFee, Rand(Money("SetupFee")));
                SetText(lblProviderFee, Rand(Money("ProviderFee")));
                SetText(lblLateFee, Rand(Money("LateNoShowFeeApplied")));
                SetText(lblTotalPaid, Rand(Money("PaymentAmount")));
            }

            private string ProviderHtml()
            {
                StringBuilder html = new StringBuilder();

                string[] providers =
                {
                "DJ",
                "Caterer",
                "Bartender",
                "Waiter",
                "Clown",
                "Photographer"
            };

                foreach (string provider in providers)
                {
                    int quantity = Qty(provider + "Qty");

                    if (quantity > 0)
                    {
                        html.Append(
                            "<span class='chip'>" +
                            quantity + " × " + E(provider) +
                            " = " + Rand(quantity * 100m) +
                            "</span>");
                    }
                }

                return html.Length == 0
                    ? "No service providers selected."
                    : html.ToString();
            }

            private string BuildReceiptHtml()
            {
                StringBuilder html = new StringBuilder();

                html.Append(
                    "<!DOCTYPE html><html><head>" +
                    "<meta charset='utf-8'>" +
                    "<title>Forte Event Hire Receipt</title>" +
                    "<style>" +
                    "body{font-family:Arial,sans-serif;color:#222;" +
                    "max-width:850px;margin:30px auto;padding:20px}" +
                    "h1,h2{color:#1a2d5c}" +
                    "table{width:100%;border-collapse:collapse;" +
                    "margin:15px 0}" +
                    "th,td{border:1px solid #ddd;padding:8px;" +
                    "text-align:left}" +
                    "th{background:#f2f5f8}" +
                    ".total{font-size:20px;font-weight:bold}" +
                    "</style></head><body>");

                html.Append(
                    "<h1>FORTE EVENT HIRE - BOOKING RECEIPT</h1>");

                html.Append("<h2>Booking Details</h2><table>");

                AddReceiptRow(html, "Booking Reference",
                    Get("BookingReference", "-"));

                AddReceiptRow(html, "Booking Status",
                    Get("BookingStatus", "Confirmed"));

                AddReceiptRow(html, "Customer",
                    Get("CustomerFullName", "-"));

                AddReceiptRow(html, "Email",
                    Get("CustomerEmail", "-"));

                AddReceiptRow(html, "Phone",
                    Get("CustomerPhone", "-"));

                AddReceiptRow(html, "Event Date",
                    Get("EventDate", "-"));

                AddReceiptRow(html, "Event Type",
                    Get("EventType", "-"));

                html.Append("</table>");

                html.Append(
                    "<h2>Booked Items</h2><table>" +
                    "<tr><th>Item</th><th>Style/Colour</th>" +
                    "<th>Quantity</th><th>Unit Price</th>" +
                    "<th>Line Total</th></tr>");

                DataTable items =
                    Session["ConfirmedBookingItems"] as DataTable;

                if (items != null)
                {
                    foreach (DataRow row in items.Rows)
                    {
                        decimal unitPrice =
                            Convert.ToDecimal(row["UnitPrice"]);

                        int quantity =
                            Convert.ToInt32(row["Quantity"]);

                        html.Append(
                            "<tr><td>" +
                            E(Convert.ToString(row["Name"])) +
                            "</td><td>" +
                            E(Convert.ToString(row["Colour"])) +
                            "</td><td>" + quantity +
                            "</td><td>" + Rand(unitPrice) +
                            "</td><td>" +
                            Rand(unitPrice * quantity) +
                            "</td></tr>");
                    }
                }

                html.Append("</table>");

                html.Append("<h2>Delivery &amp; Extras</h2><table>");

                AddReceiptRow(html, "Transport Method",
                    Get("TransportMethod", "-"));

                AddReceiptRow(html, "Address / Collection Point",
                    BookingAddress());

                AddReceiptRow(html, "Delivery / Collection",
                    FirstTime());

                AddReceiptRow(html, "Collection / Return",
                    SecondTime());

                AddReceiptRow(html, "Setup",
                    SetupIsRequired() ? "Yes" : "No");

                html.Append("</table>");

                html.Append(
                    "<h2>Service Providers</h2><table>" +
                    "<tr><th>Provider</th><th>Quantity</th>" +
                    "<th>Fee</th></tr>");

                bool hasProviders = false;

                foreach (string provider in new[]
                {
                "DJ", "Caterer", "Bartender",
                "Waiter", "Clown", "Photographer"
            })
                {
                    int quantity = Qty(provider + "Qty");

                    if (quantity > 0)
                    {
                        hasProviders = true;

                        html.Append(
                            "<tr><td>" + E(provider) +
                            "</td><td>" + quantity +
                            "</td><td>" +
                            Rand(quantity * 100m) +
                            "</td></tr>");
                    }
                }

                if (!hasProviders)
                {
                    html.Append(
                        "<tr><td colspan='3'>" +
                        "No service providers selected." +
                        "</td></tr>");
                }

                html.Append("</table>");

                html.Append("<h2>Payment Summary</h2><table>");

                AddReceiptRow(html, "Payment Reference",
                    Get("PaymentReference", "-"));

                AddReceiptRow(html, "Payment Date & Time",
                    PaymentTime());

                AddReceiptRow(html, "Payment Status",
                    Get("PaymentStatus", "Paid"));

                AddReceiptRow(html, "Item Total",
                    Rand(Money("BookingTotal")));

                AddReceiptRow(html, "Delivery & Collection Fee",
                    Rand(Money("DeliveryFee")));

                AddReceiptRow(html, "Setup Fee",
                    Rand(Money("SetupFee")));

                AddReceiptRow(html, "Service Provider Fee",
                    Rand(Money("ProviderFee")));

                AddReceiptRow(html, "Late / No-Show Fee Applied",
                    Rand(Money("LateNoShowFeeApplied")));

                AddReceiptRow(html, "Total Paid",
                    Rand(Money("PaymentAmount")));

                html.Append("</table>");

                html.Append(
                    "<p><em>Late / No-Show policy: R150 may be " +
                    "applied later if an agreed delivery, collection " +
                    "or return time is missed.</em></p>" +
                    "</body></html>");

                return html.ToString();
            }

            private void AddReceiptRow(
                StringBuilder html,
                string title,
                string value)
            {
                html.Append(
                    "<tr><td>" + E(title) +
                    "</td><td>" + E(value) +
                    "</td></tr>");
            }

            private string E(string value)
            {
                return HttpUtility.HtmlEncode(value ?? "");
            }

            private string Rand(decimal amount)
            {
                return "R " + amount.ToString("N2");
            }

            protected void btnDownloadReceipt_Click(
                object sender,
                EventArgs e)
            {
                BookingHistory.Download(
                    Response,
                    BuildReceiptHtml());
            }

            protected void btnCatalogue_Click(
                object sender,
                EventArgs e)
            {
                // The completed booking is already saved separately.
                ClearCompletedBooking();

                // Retains the filename from your uploaded code.
                Response.Redirect("Catelogue.aspx");
            }

            private void ClearCompletedBooking()
            {
                string[] keys =
                {
                "ConfirmedBookingItems", "BookingReference",
                "EventDate", "EventType", "EventNotes",
                "BookingTotal", "CustomerFullName",
                "CustomerEmail", "CustomerPhone",
                "TransportMethod", "DeliveryAddress",
                "DeliveryCity", "DeliveryProvince",
                "DeliveryPostalCode", "DeliveryDate",
                "DeliveryTime", "CollectionDate",
                "CollectionTime", "TransportInstructions",
                "CustomerCollectionDate", "CustomerCollectionTime",
                "ReturnDate", "ReturnTime", "SetupRequired",
                "DJQty", "CatererQty", "BartenderQty",
                "WaiterQty", "ClownQty", "PhotographerQty",
                "DeliveryFee", "SetupFee", "ProviderFee",
                "LateNoShowFeePolicy", "LateNoShowFeeApplied",
                "GrandTotal", "PaymentStatus", "BookingStatus",
                "PaymentAmount", "PaymentBank",
                "PaymentCardLast4", "PaymentReference",
                "PaymentDateTime"
            };

                foreach (string key in keys)
                {
                    Session.Remove(key);
                }

                // Do not clear ForteCompletedBookingHistory.
            }
        }
    }