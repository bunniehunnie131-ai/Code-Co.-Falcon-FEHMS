using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class AssignedBookings : System.Web.UI.Page
    {
        private const string AssignmentFilterKey = "AssignedBookings.AssignmentFilter";

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
            string assignmentFilter = Convert.ToString(ViewState[AssignmentFilterKey]);
            if (string.Equals(assignmentFilter, "Delivery", StringComparison.OrdinalIgnoreCase))
                filtered = filtered.Where(x => string.Equals(x.AssignmentType, "Delivery", StringComparison.OrdinalIgnoreCase));
            else if (string.Equals(assignmentFilter, "Collection", StringComparison.OrdinalIgnoreCase))
                filtered = filtered.Where(x => string.Equals(x.AssignmentType, "Collection", StringComparison.OrdinalIgnoreCase));

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
            UpdateAssignmentTabs(all);
        }

        private void UpdateAssignmentTabs(List<AssignedBookingViewModel> all)
        {
            lnkAllBookings.Text = "All (" + all.Count + ")";
            lnkDeliveryBookings.Text = "Deliveries (" + all.Count(x => x.AssignmentType == "Delivery") + ")";
            lnkCollectionBookings.Text = "Collections (" + all.Count(x => x.AssignmentType == "Collection") + ")";

            string selected = Convert.ToString(ViewState[AssignmentFilterKey]);
            lnkAllBookings.CssClass = "nav-link" + (String.IsNullOrEmpty(selected) ? " active" : String.Empty);
            lnkDeliveryBookings.CssClass = "nav-link" + (selected == "Delivery" ? " active" : String.Empty);
            lnkCollectionBookings.CssClass = "nav-link" + (selected == "Collection" ? " active" : String.Empty);
        }

        private void SelectAssignment(string assignmentType)
        {
            ViewState[AssignmentFilterKey] = assignmentType;
            BindAssignedBookings();
        }

        protected void FilterAll_Click(object sender, EventArgs e)
        {
            SelectAssignment(String.Empty);
        }

        protected void FilterDelivery_Click(object sender, EventArgs e)
        {
            SelectAssignment("Delivery");
        }

        protected void FilterCollection_Click(object sender, EventArgs e)
        {
            SelectAssignment("Collection");
        }

        private static bool Contains(string value, string search)
        {
            return (value ?? string.Empty).IndexOf(search ?? string.Empty, StringComparison.OrdinalIgnoreCase) >= 0;
        }

        protected void Search_Click(object sender, EventArgs e)
        {
            BindAssignedBookings();
        }

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
    }
}
