using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class AssignedBookings : System.Web.UI.Page
    {
        private class AssignedBooking
        {
            public string BookingId { get; set; }
            public string Customer { get; set; }
            public string EventType { get; set; }
            public DateTime EventDate { get; set; }
            public string Venue { get; set; }
            public string AssignmentType { get; set; }
            public string Status { get; set; }
        }

        private List<AssignedBooking> GetAssignedBookings()
        {
            // Sample data for testing.
            // Replace this list with your existing database retrieval logic.

            return new List<AssignedBooking>
            {
                new AssignedBooking
                {
                    BookingId = "BK001",
                    Customer = "John Smith",
                    EventType = "Wedding",
                    EventDate = new DateTime(2026, 11, 15),
                    Venue = "East London",
                    AssignmentType = "Delivery",
                    Status = "Pending"
                },

                new AssignedBooking
                {
                    BookingId = "BK002",
                    Customer = "Sarah Williams",
                    EventType = "Birthday",
                    EventDate = new DateTime(2026, 11, 20),
                    Venue = "King William's Town",
                    AssignmentType = "Collection",
                    Status = "Scheduled"
                },

                new AssignedBooking
                {
                    BookingId = "BK003",
                    Customer = "Michael Brown",
                    EventType = "Corporate Event",
                    EventDate = new DateTime(2026, 12, 5),
                    Venue = "East London",
                    AssignmentType = "Delivery",
                    Status = "Out for Delivery"
                }
            };
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAssignedBookings();
            }
        }

        protected string StatusBadge(object status)
        {
            string bookingStatus = Convert.ToString(status);

            switch (bookingStatus)
            {
                case "Pending":
                    return "bg-warning text-dark";

                case "Out for Delivery":
                    return "bg-primary";

                case "Scheduled":
                    return "bg-info text-dark";

                case "Completed":
                case "Collected":
                    return "bg-success";

                default:
                    return "bg-secondary";
            }
        }

        protected string ResolveAssignmentUrl(
            object assignmentType,
            object bookingId)
        {
            string type = Convert.ToString(assignmentType);
            string id = Convert.ToString(bookingId);

            if (type.Equals(
                "Delivery",
                StringComparison.OrdinalIgnoreCase))
            {
                return ResolveUrl(
                    "~/Presentation/ManageDelivery.aspx")
                    + "?BookingId=" + Server.UrlEncode(id);
            }

            if (type.Equals(
                "Collection",
                StringComparison.OrdinalIgnoreCase))
            {
                return ResolveUrl(
                    "~/Presentation/ManageCollection.aspx")
                    + "?BookingId=" + Server.UrlEncode(id);
            }

            return "#";
        }

        protected void FilterBookings(object sender, EventArgs e)
        {
            BindAssignedBookings();
        }

        private void BindAssignedBookings()
        {
            List<AssignedBooking> bookings = GetAssignedBookings();

            string searchText = txtSearch.Text.Trim();
            string selectedStatus = ddlStatus.SelectedValue;
            string selectedDate = txtDate.Text;

            if (!string.IsNullOrWhiteSpace(searchText))
            {
                bookings = bookings.Where(b =>
                    b.BookingId.IndexOf(
                        searchText,
                        StringComparison.OrdinalIgnoreCase) >= 0 ||

                    b.Customer.IndexOf(
                        searchText,
                        StringComparison.OrdinalIgnoreCase) >= 0 ||

                    b.Venue.IndexOf(
                        searchText,
                        StringComparison.OrdinalIgnoreCase) >= 0
                ).ToList();
            }

            if (!string.IsNullOrWhiteSpace(selectedStatus))
            {
                bookings = bookings.Where(b =>
                    b.Status.Equals(
                        selectedStatus,
                        StringComparison.OrdinalIgnoreCase)
                ).ToList();
            }

            DateTime eventDate;

            if (DateTime.TryParse(selectedDate, out eventDate))
            {
                bookings = bookings.Where(b =>
                    b.EventDate.Date == eventDate.Date
                ).ToList();
            }

            rptAssignedBookings.DataSource = bookings;
            rptAssignedBookings.DataBind();

            pnlNoAssignedBookings.Visible = bookings.Count == 0;
        }
    }
}
