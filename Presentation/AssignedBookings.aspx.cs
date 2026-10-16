using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class AssignedBookings : System.Web.UI.Page
    {
        public string AssignmentFilterKey { get; private set; }

        private sealed class AssignedBookingViewModel
        {
            public string BookingId { get; set; }
            public string Customer { get; set; }
            public string EventType { get; set; }
            public DateTime EventDate { get; set; }
            public string Venue { get; set; }
            public string AssignmentType { get; set; }
            public string Status { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindAssignedBookings();
        }

        private List<AssignedBookingViewModel> GetDemoAssignedBookings()
        {
            DateTime eventDate = DateTime.Today;
            return new List<AssignedBookingViewModel>
            {
                new AssignedBookingViewModel { BookingId = "BK001", Customer = "Sipho Mthembu", EventType = "Wedding", EventDate = eventDate, Venue = "Montecasino", AssignmentType = "Delivery", Status = "Pending" },
                new AssignedBookingViewModel { BookingId = "BK002", Customer = "Lerato Tau", EventType = "Birthday Party", EventDate = eventDate, Venue = "Midrand", AssignmentType = "Collection", Status = "Pending" },
                new AssignedBookingViewModel { BookingId = "BK004", Customer = "Nandini Pillay", EventType = "Engagement", EventDate = eventDate, Venue = "Sandton", AssignmentType = "Delivery", Status = "Out for Delivery" },
                new AssignedBookingViewModel { BookingId = "BK007", Customer = "School XYZ", EventType = "School Gala", EventDate = eventDate, Venue = "Parktown", AssignmentType = "Collection", Status = "Pending" }
            };
        }

        private void BindAssignedBookings()
        {
            List<AssignedBookingViewModel> all = GetDemoAssignedBookings();
            string search = (txtSearch.Text ?? string.Empty).Trim();
            string status = ddlStatus.SelectedValue;
            DateTime eventDate;
            bool filterByDate = DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out eventDate);

            IEnumerable<AssignedBookingViewModel> filtered = all;
            if (!string.IsNullOrEmpty(search))
                filtered = filtered.Where(x => Contains(x.BookingId, search) || Contains(x.Customer, search) || Contains(x.Venue, search));
            if (!string.IsNullOrEmpty(status))
                filtered = filtered.Where(x => x.Status == status || (status == "Completed" && (x.Status == "Delivered" || x.Status == "Collected")));
            if (filterByDate)
                filtered = filtered.Where(x => x.EventDate.Date == eventDate.Date);

            List<AssignedBookingViewModel> results = filtered.OrderBy(x => x.EventDate).ThenBy(x => x.BookingId).ToList();
            rptAssignedBookings.DataSource = results;
            rptAssignedBookings.DataBind();
            pnlNoAssignedBookings.Visible = results.Count == 0;
        }

        private static bool Contains(string value, string search)
        {
            return (value ?? string.Empty).IndexOf(search ?? string.Empty, StringComparison.OrdinalIgnoreCase) >= 0;
        }

        protected void Search_Click(object sender, EventArgs e)
        {
            BindAssignedBookings();
        }

        protected void FilterAll_Click(object sender, EventArgs e) { SelectAssignment(string.Empty); }

        private void SelectAssignment(string assignmentType)
        {
            ViewState[AssignmentFilterKey] = assignmentType;
            BindAssignedBookings();
        }

        protected void FilterDelivery_Click(object sender, EventArgs e) { SelectAssignment("Delivery"); }
        protected void FilterCollection_Click(object sender, EventArgs e) { SelectAssignment("Collection"); }

        protected string ResolveAssignmentUrl(object assignmentType, object bookingId)
        {
            string type = Convert.ToString(assignmentType);
            string id = Convert.ToString(bookingId);
            string page;

            if (string.IsNullOrWhiteSpace(id)) return "#";
            if (string.Equals(type, "Delivery", StringComparison.OrdinalIgnoreCase))
                page = "ManageDeliveries.aspx";
            else if (string.Equals(type, "Collection", StringComparison.OrdinalIgnoreCase))
                page = "ManageCollection.aspx";
            else
                return "#";

            return ResolveUrl("~/Presentation/" + page) + "?bookingId=" + HttpUtility.UrlEncode(id);
        }

        protected string StatusBadge(object value)
        {
            string status = Convert.ToString(value);
            if (status == "Delivered" || status == "Collected" || status == "Completed") return "bg-success-subtle text-dark border";
            if (status == "Out for Delivery") return "bg-primary-subtle text-dark border";
            if (status == "Scheduled") return "bg-secondary-subtle text-dark border";
            return "bg-warning-subtle text-dark border";
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
