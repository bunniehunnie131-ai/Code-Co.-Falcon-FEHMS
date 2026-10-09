using System;
using System.Data;
using System.Linq;
using System.Web;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class CustomerDashboard : System.Web.UI.Page
    {
      
            protected void Page_Load(object sender, EventArgs e)
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetNoStore();

                var bookings = BookingHistory.GetBookings(Context);

                string receiptId = Request.QueryString["receipt"];

                if (!string.IsNullOrWhiteSpace(receiptId))
                {
                    // Only search bookings belonging to this session/identity.
                    var booking = bookings.FirstOrDefault(
                        b => b.DownloadId == receiptId);

                    if (booking == null)
                    {
                        throw new HttpException(
                            404,
                            "Receipt unavailable in this session.");
                    }

                    BookingHistory.Download(
                        Response,
                        booking.ReceiptHtml);

                    return;
                }

                if (!IsPostBack)
                {
                    string customerName = bookings.Count > 0
                        ? bookings[0].CustomerFullName
                        : Convert.ToString(Session["UserName"]);

                    if (string.IsNullOrWhiteSpace(customerName) ||
                        customerName == "-")
                    {
                        customerName = "Customer";
                    }

                    lblCustomerName.Text =
                        Server.HtmlEncode(customerName);

                    string[] activeStatuses =
                    {
                    "Pending",
                    "Confirmed",
                    "Preparing",
                    "Out for Delivery",
                    "Delivered",
                    "Ready for Collection",
                    "Collected"
                };

                    lblActiveBookings.Text = bookings.Count(
                        b => activeStatuses.Contains(
                            b.BookingStatus,
                            StringComparer.OrdinalIgnoreCase))
                        .ToString();

                    // Existing designer ID retained; the heading is Total Paid.
                    lblOutstandingBalance.Text = bookings
                        .Sum(b => b.PaymentAmount)
                        .ToString("N2");

                    lblItemsHired.Text = bookings
                        .Sum(b => b.TotalQuantity)
                        .ToString();

                    rptBookings.DataSource = bookings.Select(b => new
                    {
                        b.BookingReference,
                        b.EventDate,
                        b.BookingStatus,
                        b.PaymentAmount,
                        b.DownloadId,

                        ItemsSummary = string.Join(
                            ", ",
                            b.Items.Rows.Cast<DataRow>().Select(
                                row =>
                                    Convert.ToString(row["Quantity"]) +
                                    " × " +
                                    Convert.ToString(row["Name"])))
                    }).ToList();

                    rptBookings.DataBind();

                    pnlNoBookings.Visible = bookings.Count == 0;
                }
            }

            protected string GetStatusBadgeClass(string status)
            {
                switch ((status ?? "").Trim().ToLowerInvariant())
                {
                    case "pending":
                    case "preparing":
                        return "bg-warning text-dark";

                    case "confirmed":
                        return "bg-primary";

                    case "out for delivery":
                    case "ready for collection":
                    case "delivered":
                    case "collected":
                        return "bg-info text-dark";

                    case "completed":
                    case "returned":
                        return "bg-success";

                    case "cancelled":
                        return "bg-danger";

                    default:
                        return "bg-secondary";
                }
            }
        }
    }