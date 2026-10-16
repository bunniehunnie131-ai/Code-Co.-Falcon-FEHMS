using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageCollections : System.Web.UI.Page
    {

        // Demo data contract for the page. A SQL repository can return this same model later.
        private sealed class CollectionViewModel
        {
            public string BookingId { get; set; }
            public string EventType { get; set; }
            public string Customer { get; set; }
            public DateTime CollectionDate { get; set; }
            public string CollectionTime { get; set; }
            public string Venue { get; set; }
            public string Items { get; set; }
            public string Status { get; set; }
            public string ImageUrl { get; set; }
            public DateTime EventEndAt { get; set; }
            public string ContactPhone { get; set; }
            public string CollectionAddress { get; set; }
            public string CollectionNotes { get; set; }
            public bool IsPackage { get; set; }
            public string PackageName { get; set; }
            public string PackageImageUrl { get; set; }
            public List<EquipmentLineViewModel> EquipmentItems { get; set; }
        }

        private sealed class EquipmentLineViewModel
        {
            public string Name { get; set; }
            public int Quantity { get; set; }
            public string ImageUrl { get; set; }
        }

        private const string StatusViewStateKey = "StaffCollectionStatusFilter";
        private const string StatusSessionKey = "StaffCollectionDemoStatuses";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState[StatusViewStateKey] = string.Empty;
                string requestedBookingId = Request.QueryString["bookingId"];
                if (!string.IsNullOrEmpty(requestedBookingId)) txtSearch.Text = requestedBookingId;
                BindCollections();
                if (!string.IsNullOrEmpty(requestedBookingId))
                {
                    CollectionViewModel requestedCollection = GetDemoCollections().FirstOrDefault(x => x.BookingId == requestedBookingId);
                    Dictionary<string, string> statuses = Session[StatusSessionKey] as Dictionary<string, string>;
                    string savedStatus;
                    if (requestedCollection != null && statuses != null && statuses.TryGetValue(requestedBookingId, out savedStatus)) requestedCollection.Status = savedStatus;
                    if (requestedCollection != null) ShowCollectionDetails(requestedCollection);
                }
            }
        }

        private List<CollectionViewModel> GetDemoCollections()
        {
            DateTime today = DateTime.Today;
            return new List<CollectionViewModel>
            {
                // Demo event ended one hour ago so the Mark as Collected button is visible immediately.
                new CollectionViewModel { BookingId = "BK002", EventType = "Birthday Party", Customer = "Lerato Tau", ContactPhone = "072 456 7890", CollectionDate = today, CollectionTime = "18:00", EventEndAt = DateTime.Now.AddHours(-1), Venue = "Midrand", CollectionAddress = "Midrand", CollectionNotes = "Collect the tables and chairs from the venue service area.", Items = "20 × Chairs, 5 × Tables", Status = "Pending", ImageUrl = "../Images/Chairs.jpg", EquipmentItems = new List<EquipmentLineViewModel> { new EquipmentLineViewModel { Name = "Chairs", Quantity = 20, ImageUrl = "../Images/Chairs.jpg" }, new EquipmentLineViewModel { Name = "Tables", Quantity = 5, ImageUrl = "../Images/Hero%20background.png" } } },
                new CollectionViewModel { BookingId = "BK007", EventType = "School Gala", Customer = "School XYZ", ContactPhone = "011 555 0130", CollectionDate = today.AddDays(1), CollectionTime = "17:00", EventEndAt = today.AddDays(1).AddHours(15), Venue = "Parktown", CollectionAddress = "Parktown", CollectionNotes = "Coordinate collection with the school event contact.", Items = "Décor Items, 10 × Tables, 50 × Chairs", Status = "Pending", ImageUrl = "../Images/Hero%20background.png", IsPackage = true, PackageName = "School Gala Hire Package", PackageImageUrl = "../Images/Hero%20background.png", EquipmentItems = new List<EquipmentLineViewModel> { new EquipmentLineViewModel { Name = "Décor Items", Quantity = 1 }, new EquipmentLineViewModel { Name = "Tables", Quantity = 10 }, new EquipmentLineViewModel { Name = "Chairs", Quantity = 50 } } },
                new CollectionViewModel { BookingId = "BK006", EventType = "Corporate Event", Customer = "ABC Corp", ContactPhone = "011 555 0199", CollectionDate = today.AddDays(-1), CollectionTime = "12:00", EventEndAt = today.AddDays(-1).AddHours(11), Venue = "Sandton Convention Centre", CollectionAddress = "Sandton Convention Centre", CollectionNotes = "Collection completed at the loading bay.", Items = "12 × Tables, 80 × Chairs", Status = "Collected", ImageUrl = "../Images/Chairs.jpg", EquipmentItems = new List<EquipmentLineViewModel> { new EquipmentLineViewModel { Name = "Tables", Quantity = 12, ImageUrl = "../Images/Hero%20background.png" }, new EquipmentLineViewModel { Name = "Chairs", Quantity = 80, ImageUrl = "../Images/Chairs.jpg" } } }
            };
        }

        private void BindCollections()
        {
            List<CollectionViewModel> all = GetDemoCollections();
            Dictionary<string, string> savedStatuses = Session[StatusSessionKey] as Dictionary<string, string>;
            if (savedStatuses != null)
            {
                foreach (CollectionViewModel collection in all)
                    if (savedStatuses.ContainsKey(collection.BookingId)) collection.Status = savedStatuses[collection.BookingId];
            }

            string status = Convert.ToString(ViewState[StatusViewStateKey]);
            string search = (txtSearch.Text ?? string.Empty).Trim();
            DateTime selectedDate;
            bool useDate = DateTime.TryParse(txtDate.Text, out selectedDate);

            IEnumerable<CollectionViewModel> filtered = all;
            if (!string.IsNullOrEmpty(status))
                filtered = filtered.Where(x => status == "Completed" ? x.Status == "Completed" || x.Status == "Collected" : x.Status == status);
            if (!string.IsNullOrEmpty(search))
                filtered = filtered.Where(x => Contains(x.BookingId, search) || Contains(x.Customer, search) || Contains(x.EventType, search));
            if (useDate) filtered = filtered.Where(x => x.CollectionDate.Date == selectedDate.Date);

            List<CollectionViewModel> result = filtered.OrderBy(x => x.CollectionDate).ThenBy(x => x.CollectionTime).ToList();
            rptCollections.DataSource = result;
            rptCollections.DataBind();
            pnlNoCollections.Visible = result.Count == 0;
            pnlCollectionMessage.Visible = !string.IsNullOrEmpty(Convert.ToString(ViewState["CollectionUpdateMessage"]));
            litCollectionMessage.Text = Convert.ToString(ViewState["CollectionUpdateMessage"]);
            SetActiveTab(status);
        }

        private static bool Contains(string value, string search)
        {
            return (value ?? string.Empty).IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0;
        }

        private void SelectStatus(string status)
        {
            ViewState[StatusViewStateKey] = status;
            BindCollections();
        }

        protected void FilterAll_Click(object sender, EventArgs e) { SelectStatus(string.Empty); }
        protected void FilterPending_Click(object sender, EventArgs e) { SelectStatus("Pending"); }
        protected void FilterCompleted_Click(object sender, EventArgs e) { SelectStatus("Completed"); }
        protected void Search_Click(object sender, EventArgs e) { BindCollections(); }

        protected void rptCollections_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string bookingId = Convert.ToString(e.CommandArgument);
            ViewState["CollectionUpdateMessage"] = string.Empty;
            if (e.CommandName == "ViewDetails")
            {
                Dictionary<string, string> statuses = Session[StatusSessionKey] as Dictionary<string, string>;
                CollectionViewModel collection = GetDemoCollections().FirstOrDefault(x => x.BookingId == bookingId);
                string savedStatus;
                if (collection != null && statuses != null && statuses.TryGetValue(bookingId, out savedStatus)) collection.Status = savedStatus;
                if (collection != null) ShowCollectionDetails(collection);
            }
            else if (e.CommandName == "MarkCollected")
            {
                CollectionViewModel collection = GetDemoCollections().FirstOrDefault(x => x.BookingId == bookingId);
                Dictionary<string, string> statuses = Session[StatusSessionKey] as Dictionary<string, string>;
                if (statuses == null) statuses = new Dictionary<string, string>();
                string currentStatus = collection == null ? string.Empty : collection.Status;
                string savedStatus;
                if (collection != null && statuses.TryGetValue(bookingId, out savedStatus)) currentStatus = savedStatus;

                if (collection != null && currentStatus == "Pending" && collection.EventEndAt <= DateTime.Now)
                {
                    statuses[bookingId] = "Collected";
                    Session[StatusSessionKey] = statuses;
                    ViewState["CollectionUpdateMessage"] = bookingId + " has been marked as collected.";
                }
                else if (collection != null && currentStatus == "Pending")
                {
                    ViewState["CollectionUpdateMessage"] = "This collection can be completed after the event ends at " + collection.EventEndAt.ToString("dd MMM yyyy, HH:mm") + ".";
                }
            }
            BindCollections();
        }

        private void ShowCollectionDetails(CollectionViewModel collection)
        {
            litCollectionDetailBooking.Text = HttpUtility.HtmlEncode(collection.BookingId + " · " + collection.EventType);
            litCollectionDetailCustomer.Text = HttpUtility.HtmlEncode(collection.Customer);
            litCollectionDetailPhone.Text = HttpUtility.HtmlEncode(collection.ContactPhone);
            litCollectionDetailEvent.Text = HttpUtility.HtmlEncode(collection.EventType);
            litCollectionDetailEnd.Text = HttpUtility.HtmlEncode(collection.EventEndAt.ToString("dd MMM yyyy, HH:mm"));
            litCollectionDetailPickup.Text = HttpUtility.HtmlEncode(collection.CollectionDate.ToString("dd MMM yyyy") + " · " + collection.CollectionTime);
            litCollectionDetailStatus.Text = HttpUtility.HtmlEncode(collection.Status);
            litCollectionDetailAddress.Text = HttpUtility.HtmlEncode(collection.CollectionAddress);
            litCollectionDetailInstructions.Text = HttpUtility.HtmlEncode(collection.CollectionNotes);
            pnlCollectionPackageDetail.Visible = collection.IsPackage;
            imgCollectionPackage.ImageUrl = collection.PackageImageUrl;
            imgCollectionPackage.AlternateText = collection.PackageName;
            litCollectionPackageName.Text = HttpUtility.HtmlEncode(collection.PackageName);
            rptCollectionPackageItems.DataSource = collection.IsPackage ? collection.EquipmentItems : null;
            rptCollectionPackageItems.DataBind();
            rptCollectionDetailItems.Visible = !collection.IsPackage;
            rptCollectionDetailItems.DataSource = collection.IsPackage ? null : collection.EquipmentItems;
            rptCollectionDetailItems.DataBind();

            Page.ClientScript.RegisterStartupScript(GetType(), "showCollectionDetails",
                "window.addEventListener('load',function(){var m=document.getElementById('pnlCollectionDetailsModal');if(m&&window.bootstrap){bootstrap.Modal.getOrCreateInstance(m).show();}});", true);
        }

        protected bool CanMarkCollected(object value, object eventEndAt)
        {
            DateTime eventEnd;
            return Convert.ToString(value) == "Pending" && DateTime.TryParse(Convert.ToString(eventEndAt), out eventEnd) && eventEnd <= DateTime.Now;
        }

        protected bool IsAwaitingEventEnd(object value, object eventEndAt)
        {
            DateTime eventEnd;
            return Convert.ToString(value) == "Pending" && DateTime.TryParse(Convert.ToString(eventEndAt), out eventEnd) && eventEnd > DateTime.Now;
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            txtDate.Text = string.Empty;
            ViewState[StatusViewStateKey] = string.Empty;
            BindCollections();
        }

        private void SetActiveTab(string status)
        {
            lnkAll.CssClass = "nav-link" + (string.IsNullOrEmpty(status) ? " active" : string.Empty);
            lnkPending.CssClass = "nav-link" + (status == "Pending" ? " active" : string.Empty);
            lnkCompleted.CssClass = "nav-link" + (status == "Completed" ? " active" : string.Empty);
        }

        protected string StatusBadge(object value)
        {
            string status = Convert.ToString(value);
            if (status == "Completed" || status == "Collected") return "badge-success";
            if (status == "Overdue") return "badge-danger";
            return "badge-warning";
        }

    }
}