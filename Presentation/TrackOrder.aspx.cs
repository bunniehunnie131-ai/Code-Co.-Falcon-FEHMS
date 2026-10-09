using System;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    
        public partial class TrackOrder : System.Web.UI.Page
        {
            protected void Page_Load(object sender, EventArgs e)
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetNoStore();

                LoadBookings();

                string bookingId = Request.QueryString["booking"];

                if (!string.IsNullOrWhiteSpace(bookingId))
                {
                    ShowBooking(bookingId);
                }
            }

            private void LoadBookings()
            {
                var bookings = BookingHistory.GetBookings(Context);

                rptTrackableOrders.DataSource = bookings;
                rptTrackableOrders.DataBind();

                pnlNoTrackableOrders.Visible = bookings.Count == 0;

                pnlListView.Visible = true;
                pnlDetailView.Visible = false;
                pnlMessage.Visible = false;
            }

            protected void rptTrackableOrders_ItemCommand(
                object source,
                RepeaterCommandEventArgs e)
            {
                if (e.CommandName != "ViewDetails")
                {
                    return;
                }

                string bookingId = Convert.ToString(e.CommandArgument);

                Response.Redirect(
                    "TrackOrder.aspx?booking=" +
                    HttpUtility.UrlEncode(bookingId),
                    false);

                Context.ApplicationInstance.CompleteRequest();
            }

            protected void btnBackToList_Click(
                object sender,
                EventArgs e)
            {
                Response.Redirect("TrackOrder.aspx", false);

                Context.ApplicationInstance.CompleteRequest();
            }

            private void ShowBooking(string bookingId)
            {
                // Never use a URL reference to fetch another customer's data.
                var booking = BookingHistory.GetBookings(Context)
                    .FirstOrDefault(b => b.DownloadId == bookingId);

                if (booking == null)
                {
                    Response.StatusCode = 404;
                    Response.TrySkipIisCustomErrors = true;

                    pnlMessage.Visible = true;

                    lblStatusMessage.Text =
                        "This booking is unavailable in your current session.";

                    return;
                }

                pnlListView.Visible = false;
                pnlDetailView.Visible = true;

                SetText(lblDetailReference, booking.BookingReference);
                SetText(lblDetailCustomerName, booking.CustomerFullName);
                SetText(lblDetailPaymentStatus, booking.PaymentStatus);
                SetText(lblDetailCurrentStatus, booking.BookingStatus);
                SetText(lblProgressHeadline, booking.BookingStatus);

                SetText(lblEstimatedDelivery, booking.FirstTime);

                SetText(
                    lblLastUpdated,
                    "Status recorded at booking confirmation.");

                SetText(lblEventDate, booking.EventDate);
                SetText(lblEventType, booking.EventType);
                SetText(lblTransportMethod, booking.TransportMethod);
                SetText(lblDeliveryAddress, booking.Address);
                SetText(lblDeliveryDate, booking.FirstTime);
                SetText(lblEstimatedTime, booking.SecondTime);

                SetText(lblCustomerContact, booking.CustomerPhone);
                SetText(lblCustomerEmail, booking.CustomerEmail);
                SetText(lblSetupRequired, booking.Setup);
                SetText(lblServiceProviders, booking.Providers);
                SetText(lblPaidAt, booking.PaidAt);

                SetText(lblSubtotal, Rand(booking.BookingTotal));
                SetText(lblDeliveryFee, Rand(booking.DeliveryFee));
                SetText(lblSetupFee, Rand(booking.SetupFee));
                SetText(lblProviderFee, Rand(booking.ProviderFee));

                SetText(
                    lblLateFee,
                    Rand(booking.LateNoShowFeeApplied));

                decimal bookingTotal =
                    booking.BookingTotal +
                    booking.DeliveryFee +
                    booking.SetupFee +
                    booking.ProviderFee +
                    booking.LateNoShowFeeApplied;

                SetText(lblGrandTotal, Rand(bookingTotal));

                // Existing control ID retained; the heading is Payment Reference.
                SetText(lblPaymentMethod, booking.PaymentReference);

                SetText(lblPaymentStatusRow, booking.PaymentStatus);
                SetText(lblAmountPaid, Rand(booking.PaymentAmount));

                lnkRefresh.NavigateUrl =
                    "TrackOrder.aspx?booking=" +
                    HttpUtility.UrlEncode(booking.DownloadId);

                lnkReceipt.NavigateUrl =
                    "CustomerDashboard.aspx?receipt=" +
                    HttpUtility.UrlEncode(booking.DownloadId);

                rptBookingItems.DataSource =
                    booking.Items.Rows.Cast<DataRow>().Select(row => new
                    {
                        Name = Convert.ToString(row["Name"]),

                        SubLabel =
                            Convert.ToString(row["Colour"]) +
                            " · " +
                            Rand(Convert.ToDecimal(row["UnitPrice"])) +
                            " each",

                        Quantity = Convert.ToInt32(row["Quantity"]),

                        LineTotal =
                            Convert.ToDecimal(row["UnitPrice"]) *
                            Convert.ToInt32(row["Quantity"])
                    }).ToList();

                rptBookingItems.DataBind();

                LoadProgress(booking);
            }

            private void LoadProgress(CompletedBooking booking)
            {
                bool usesDelivery =
                    booking.TransportMethod ==
                    "Forte Delivery & Collection";

                string[] stages = usesDelivery
                    ? new[]
                    {
                    "Confirmed",
                    "Preparing",
                    "Out for Delivery",
                    "Delivered",
                    "Completed"
                    }
                    : new[]
                    {
                    "Confirmed",
                    "Preparing",
                    "Ready for Collection",
                    "Collected",
                    "Completed"
                    };

                string currentStatus = booking.BookingStatus.Trim();

                bool recognisedStatus = stages.Any(
                    stage => string.Equals(
                        stage,
                        currentStatus,
                        StringComparison.OrdinalIgnoreCase));

                // Show cancellations, pending orders and other statuses as-is.
                if (!recognisedStatus)
                {
                    stages = new[] { currentStatus };
                }

                // Highlight only the recorded current status.
                // Do not invent completed milestones or delivery timestamps.
                rptSteps.DataSource = stages.Select((stage, index) => new
                {
                    StepNumber = index + 1,
                    Label = stage,

                    StateCss = string.Equals(
                        stage,
                        currentStatus,
                        StringComparison.OrdinalIgnoreCase)
                        ? "is-current"
                        : "",

                    DateText = string.Equals(
                        stage,
                        currentStatus,
                        StringComparison.OrdinalIgnoreCase)
                        ? "Recorded status"
                        : ""
                }).ToList();

                rptSteps.DataBind();
            }

            protected string GetStatusBadgeClass(object value)
            {
                string status =
                    Convert.ToString(value).Trim().ToLowerInvariant();

                switch (status)
                {
                    case "cancelled":
                        return "status-cancelled";

                    case "completed":
                    case "returned":
                        return "status-completed";

                    case "out for delivery":
                    case "ready for collection":
                        return "status-moving";

                    default:
                        return "status-default";
                }
            }

            private void SetText(Label label, string value)
            {
                label.Text = Server.HtmlEncode(value ?? "-");
            }

            private string Rand(decimal amount)
            {
                return "R " + amount.ToString("N2");
            }
        }
    }