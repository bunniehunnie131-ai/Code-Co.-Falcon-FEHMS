using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class BookingCalender : System.Web.UI.Page
    {
        private readonly Dictionary<DateTime, List<CalendarEvent>> _events = new Dictionary<DateTime, List<CalendarEvent>>();
        private DataTable GetBookings() 
        { 
            DataTable t = Session["BookingCalendarDemo"] as DataTable;
            if (t != null) return t;
            t = new DataTable();
            t.Columns.Add("BookingID", typeof(int));
            t.Columns.Add("BookingReference", typeof(string));
            t.Columns.Add("CustomerFullName", typeof(string));
            t.Columns.Add("CustomerEmail", typeof(string));
            t.Columns.Add("EventType", typeof(string));
            t.Columns.Add("EventDate", typeof(DateTime));
            t.Columns.Add("GrandTotal", typeof(decimal));
            t.Columns.Add("BookingStatus", typeof(string));
            t.Columns.Add("StatusCss", typeof(string)); 
            Add(t, 1, "FEH-20261031-WED01", "Fortune Makhubela", "Wedding", new DateTime(2026, 10, 31), "Confirmed");
            Add(t, 2, "FEH-20261103-BDY02", "Amina Jacobs", "Birthday", new DateTime(2026, 11, 3), "Pending");
            Add(t, 3, "FEH-20261108-COR03", "Lwazi Mbeki", "Corporate Event", new DateTime(2026, 11, 8), "Confirmed");
            Add(t, 4, "FEH-20261114-GAL04", "Thandi Nkomo", "School Gala", new DateTime(2026, 11, 14), "Pending"); 
            Add(t, 5, "FEH-20261120-ENG05", "Priya Singh", "Engagement", new DateTime(2026, 11, 20), "Cancelled");
            Add(t, 6, "FEH-20261205-WED06", "James Dlamini", "Wedding", new DateTime(2026, 12, 5), "Confirmed"); 
            Session["BookingCalendarDemo"] = t; 
            return t;
        }

        private void Add(DataTable t, int id, string reference, string customer, string type, DateTime date, string status)
        {
            t.Rows.Add(id, reference, customer, "", type, date, 0m, status, StatusCss(status));
        }

        private string StatusCss(string s)
        { 
            return s == "Confirmed" ? "badge text-bg-success" : s == "Pending" ? "badge text-bg-warning" : s == "Cancelled" ? "badge text-bg-secondary" : "badge text-bg-primary"; 
        }

        protected void Page_Load(object sender, EventArgs e)
        { BindMonth(calBookings.VisibleDate == DateTime.MinValue ? DateTime.Today : calBookings.VisibleDate); 
        }

        protected void calBookings_VisibleMonthChanged(object sender, MonthChangedEventArgs e) 
        {
            BindMonth(e.NewDate); 
        }

        private void BindMonth(DateTime month)
        {
            DateTime first = new DateTime(month.Year, month.Month, 1); 
            litMonthTitle.Text = first.ToString("MMMM yyyy"); _events.Clear();
            DataTable bookings = GetBookings(), events = bookings.Clone(); 
            foreach (DataRow b in bookings.Rows) 
            { 
                DateTime d = Convert.ToDateTime(b["EventDate"]).Date; string status = Convert.ToString(b["BookingStatus"]); 
                if (d.Year != first.Year || d.Month != first.Month || status == "Completed") continue; events.ImportRow(b);
                List<CalendarEvent> list; if (!_events.TryGetValue(d, out list))
                { 
                    list = new List<CalendarEvent>(); _events[d] = list;
                } 
                list.Add(new CalendarEvent { BookingReference = Convert.ToString(b["BookingReference"]), EventType = Convert.ToString(b["EventType"]), Customer = Convert.ToString(b["CustomerFullName"]), Status = status }
                ); } 
            if (!events.Columns.Contains("DeliveryCity")) events.Columns.Add("DeliveryCity", typeof(string)); if (!events.Columns.Contains("StatusCss")) events.Columns.Add("StatusCss", typeof(string)); 
            foreach (DataRow r in events.Rows)
            {
                r["DeliveryCity"] = CityFor(Convert.ToString(r["BookingReference"]));
                r["StatusCss"] = StatusCss(Convert.ToString(r["BookingStatus"]));
            }
            rptMonthEvents.DataSource = events; rptMonthEvents.DataBind();
            pnlNoEvents.Visible = events.Rows.Count == 0; pnlMessage.Visible = false;
        }
        protected void calBookings_DayRender(object sender, DayRenderEventArgs e)
        {
            List<CalendarEvent> list; if (!_events.TryGetValue(e.Day.Date.Date, out list)) return; 
            e.Cell.CssClass = (e.Cell.CssClass + " admin-calendar-booked").Trim();
            foreach (CalendarEvent item in list)
            {
                string css = item.Status == "Confirmed" ? "confirmed" : item.Status == "Pending" ? "pending" : item.Status == "Cancelled" ? "cancelled" : "other"; Literal l = new Literal();
                l.Text = "<div class=\"calendar-event " + css + "\" title=\"" + Server.HtmlEncode(item.BookingReference + " - " + item.Customer) + "\">" + Server.HtmlEncode(item.EventType) + "</div>";
                e.Cell.Controls.Add(l); 
            }
        }
        private string CityFor(string reference) 
        {
            return reference.IndexOf("WED", StringComparison.Ordinal) >= 0 ? "Berea" : reference.IndexOf("BDY", StringComparison.Ordinal) >= 0 ? "East London" : reference.IndexOf("COR", StringComparison.Ordinal) >= 0 ? "Mthatha" : "Gqeberha";
        }
        private sealed class CalendarEvent
        {
            public string BookingReference, EventType, Customer, Status;
        }

    }
}