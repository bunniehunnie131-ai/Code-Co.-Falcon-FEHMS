using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class BookingCalender : System.Web.UI.Page
    {
        private readonly Dictionary<DateTime, List<CalendarEvent>> eventsByDate =
            new Dictionary<DateTime, List<CalendarEvent>>();

        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["ForteDB"]
                    .ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime month = calBookings.VisibleDate == DateTime.MinValue
                ? DateTime.Today
                : calBookings.VisibleDate;

            BindMonth(month);
        }

        protected void calBookings_VisibleMonthChanged(
            object sender,
            MonthChangedEventArgs e)
        {
            BindMonth(e.NewDate);
        }

        private void BindMonth(DateTime month)
        {
            DateTime monthStart = new DateTime(month.Year, month.Month, 1);
            DateTime nextMonth = monthStart.AddMonths(1);

            eventsByDate.Clear();
            litMonthTitle.Text = monthStart.ToString("MMMM yyyy");
            pnlMessage.Visible = false;

            const string sql = @"
                SELECT BookingReference,
                       EventType,
                       CustomerFullName,
                       DeliveryCity,
                       EventDate,
                       BookingStatus
                FROM dbo.Bookings
                WHERE EventDate >= @MonthStart
                  AND EventDate < @NextMonth
                  AND BookingStatus IN
                      (N'Pending', N'Confirmed', N'Cancelled')
                ORDER BY EventDate, BookingReference;";

            try
            {
                DataTable bookings = new DataTable();

                using (SqlConnection connection =
                    new SqlConnection(ConnectionString))
                using (SqlCommand command =
                    new SqlCommand(sql, connection))
                using (SqlDataAdapter adapter =
                    new SqlDataAdapter(command))
                {
                    command.Parameters.Add("@MonthStart", SqlDbType.Date)
                        .Value = monthStart.Date;

                    command.Parameters.Add("@NextMonth", SqlDbType.Date)
                        .Value = nextMonth.Date;

                    connection.Open();
                    adapter.Fill(bookings);
                }

                foreach (DataRow row in bookings.Rows)
                {
                    DateTime eventDate =
                        Convert.ToDateTime(row["EventDate"]).Date;

                    CalendarEvent calendarEvent = new CalendarEvent
                    {
                        BookingReference =
                            Convert.ToString(row["BookingReference"]),
                        EventType =
                            Convert.ToString(row["EventType"]),
                        CustomerFullName =
                            Convert.ToString(row["CustomerFullName"]),
                        BookingStatus =
                            Convert.ToString(row["BookingStatus"])
                    };

                    if (!eventsByDate.ContainsKey(eventDate))
                    {
                        eventsByDate[eventDate] =
                            new List<CalendarEvent>();
                    }

                    eventsByDate[eventDate].Add(calendarEvent);
                }

                bookings.Columns.Add("StatusCss", typeof(string));

                foreach (DataRow row in bookings.Rows)
                {
                    row["StatusCss"] =
                        GetStatusCss(Convert.ToString(row["BookingStatus"]));
                }

                rptMonthEvents.DataSource = bookings;
                rptMonthEvents.DataBind();

                pnlNoEvents.Visible = bookings.Rows.Count == 0;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "Booking calendar load failed: " + ex);

                pnlMessage.Visible = true;
                lblMessage.Text =
                    "Calendar information could not be loaded from ForteDB.";

                if (Request.IsLocal)
                {
                    lblMessage.Text += " " +
                        Server.HtmlEncode(ex.Message);
                }

                rptMonthEvents.DataSource = null;
                rptMonthEvents.DataBind();
                pnlNoEvents.Visible = true;
            }
        }

        protected void calBookings_DayRender(
            object sender,
            DayRenderEventArgs e)
        {
            List<CalendarEvent> dayEvents;

            if (!eventsByDate.TryGetValue(e.Day.Date.Date, out dayEvents))
            {
                return;
            }

            e.Cell.CssClass =
                (e.Cell.CssClass + " admin-calendar-booked").Trim();

            foreach (CalendarEvent calendarEvent in dayEvents)
            {
                string statusClass =
                    GetCalendarStatusClass(calendarEvent.BookingStatus);

                Literal eventLabel = new Literal();

                eventLabel.Text =
                    "<div class=\"calendar-event " + statusClass + "\"" +
                    " title=\"" +
                    Server.HtmlEncode(
                        calendarEvent.BookingReference + " · " +
                        calendarEvent.CustomerFullName) +
                    "\">" +
                    Server.HtmlEncode(calendarEvent.EventType) +
                    "</div>";

                e.Cell.Controls.Add(eventLabel);
            }
        }

        private static string GetStatusCss(string status)
        {
            switch ((status ?? String.Empty).Trim().ToLowerInvariant())
            {
                case "confirmed":
                    return "badge text-bg-success";

                case "pending":
                    return "badge text-bg-warning";

                case "cancelled":
                    return "badge text-bg-danger";

                default:
                    return "badge text-bg-secondary";
            }
        }

        private static string GetCalendarStatusClass(string status)
        {
            switch ((status ?? String.Empty).Trim().ToLowerInvariant())
            {
                case "confirmed":
                    return "confirmed";

                case "pending":
                    return "pending";

                case "cancelled":
                    return "cancelled";

                default:
                    return "other";
            }
        }

        private sealed class CalendarEvent
        {
            public string BookingReference { get; set; }
            public string EventType { get; set; }
            public string CustomerFullName { get; set; }
            public string BookingStatus { get; set; }
        }

    }
}