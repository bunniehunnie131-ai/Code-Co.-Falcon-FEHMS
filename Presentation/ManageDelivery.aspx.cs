using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageDelivery : System.Web.UI.Page
    {

        // Replace this view model's demo list with a repository result from ForteDB later.
        // Keep the property names stable and the ASPX template will not need to change.
        private sealed class DeliveryViewModel
        {
            public string BookingId { get; set; }
            public string EventType { get; set; }
            public string Customer { get; set; }
            public DateTime EventDate { get; set; }
            public string EventTime { get; set; }
            public string Venue { get; set; }
            public string Items { get; set; }
            public string Status { get; set; }
            public string ImageUrl { get; set; }
            public string ContactPhone { get; set; }
            public string DeliveryAddress { get; set; }
            public string DeliveryNotes { get; set; }
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

        private const string StatusViewStateKey = "StaffDeliveryStatusFilter";
        private const string StatusSessionKey = "StaffDeliveryDemoStatuses";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState[StatusViewStateKey] = string.Empty;
                string requestedBookingId = Request.QueryString["bookingId"];
                if (!string.IsNullOrEmpty(requestedBookingId)) txtSearch.Text = requestedBookingId;
                BindDeliveries();
                if (!string.IsNullOrEmpty(requestedBookingId))
                {
                    DeliveryViewModel requestedDelivery = GetDemoDeliveries().FirstOrDefault(x => x.BookingId == requestedBookingId);
                    Dictionary<string, string> statuses = Session[StatusSessionKey] as Dictionary<string, string>;
                    string savedStatus;
                    if (requestedDelivery != null && statuses != null && statuses.TryGetValue(requestedBookingId, out savedStatus)) requestedDelivery.Status = savedStatus;
                    if (requestedDelivery != null) ShowDeliveryDetails(requestedDelivery);
                }
            }
        }

        private List<DeliveryViewModel> GetDemoDeliveries()
        {
            DateTime today = DateTime.Today;
            return new List<DeliveryViewModel>
            {
                new DeliveryViewModel { BookingId = "BK001", EventType = "Wedding", Customer = "Sipho Mthembu", ContactPhone = "072 456 7890", EventDate = today, EventTime = "08:00", Venue = "Montecasino, Sandton", DeliveryAddress = "Montecasino, Sandton, Johannesburg", DeliveryNotes = "Use the west service entrance.", Items = "10 × Round Tables, 50 × Chairs, 1 × Décor Package", Status = "Pending", ImageUrl = "../Images/Hero%20background.png", EquipmentItems = new List<EquipmentLineViewModel> { new EquipmentLineViewModel { Name = "Round Tables", Quantity = 10, ImageUrl = "../Images/Hero%20background.png" }, new EquipmentLineViewModel { Name = "Chairs", Quantity = 50, ImageUrl = "../Images/Chairs.jpg" }, new EquipmentLineViewModel { Name = "Décor Package", Quantity = 1, ImageUrl = "../Images/Hero%20background.png" } } },
                new DeliveryViewModel { BookingId = "BK004", EventType = "Engagement", Customer = "Nandini Pillay", ContactPhone = "082 555 0144", EventDate = today, EventTime = "11:00", Venue = "Sandton", DeliveryAddress = "Sandton, Johannesburg", DeliveryNotes = "Call the event contact on arrival.", Items = "1 × Marquee, 8 × Tables, 40 × Chairs", Status = "Out for Delivery", ImageUrl = "../Images/Chairs.jpg", IsPackage = true, PackageName = "Engagement Marquee Package", PackageImageUrl = "../Images/Hero%20background.png", EquipmentItems = new List<EquipmentLineViewModel> { new EquipmentLineViewModel { Name = "Marquee", Quantity = 1 }, new EquipmentLineViewModel { Name = "Tables", Quantity = 8 }, new EquipmentLineViewModel { Name = "Chairs", Quantity = 40 } } },
                new DeliveryViewModel { BookingId = "BK009", EventType = "Corporate Event", Customer = "ABC Corp", ContactPhone = "011 555 0199", EventDate = today, EventTime = "16:00", Venue = "Sandton Convention Centre", DeliveryAddress = "Sandton Convention Centre, Johannesburg", DeliveryNotes = "Deliver to the loading bay.", Items = "Stage, PA System, 100 × Chairs", Status = "Pending", ImageUrl = "../Images/Hero%20background.png", EquipmentItems = new List<EquipmentLineViewModel> { new EquipmentLineViewModel { Name = "Stage", Quantity = 1, ImageUrl = "../Images/Hero%20background.png" }, new EquipmentLineViewModel { Name = "PA System", Quantity = 1, ImageUrl = "../Images/Hero%20background.png" }, new EquipmentLineViewModel { Name = "Chairs", Quantity = 100, ImageUrl = "../Images/Chairs.jpg" } } }
            };
        }

        private void BindDeliveries()
        {
            List<DeliveryViewModel> all = GetDemoDeliveries();
            Dictionary<string, string> savedStatuses = Session[StatusSessionKey] as Dictionary<string, string>;
            if (savedStatuses != null)
            {
                foreach (DeliveryViewModel delivery in all)
                    if (savedStatuses.ContainsKey(delivery.BookingId)) delivery.Status = savedStatuses[delivery.BookingId];
            }
            lnkAll.Text = "All Deliveries (" + all.Count + ")";
            lnkPending.Text = "Pending (" + all.Count(x => x.Status == "Pending") + ")";
            lnkOutForDelivery.Text = "Out for Delivery (" + all.Count(x => x.Status == "Out for Delivery") + ")";
            lnkCompleted.Text = "Completed (" + all.Count(x => x.Status == "Completed" || x.Status == "Delivered") + ")";
            string status = Convert.ToString(ViewState[StatusViewStateKey]);
            string search = (txtSearch.Text ?? string.Empty).Trim();
            DateTime selectedDate;
            bool useDate = DateTime.TryParse(txtDate.Text, out selectedDate);

            IEnumerable<DeliveryViewModel> filtered = all;
            if (!string.IsNullOrEmpty(status))
                filtered = filtered.Where(x => status == "Completed" ? x.Status == "Completed" || x.Status == "Delivered" : x.Status == status);
            string selectedStatus = ddlStatus.SelectedValue;
            if (string.IsNullOrEmpty(status) && !string.IsNullOrEmpty(selectedStatus))
                filtered = filtered.Where(x => x.Status == selectedStatus);
            if (!string.IsNullOrEmpty(search))
                filtered = filtered.Where(x => Contains(x.BookingId, search) || Contains(x.Customer, search));
            if (useDate) filtered = filtered.Where(x => x.EventDate.Date == selectedDate.Date);

            List<DeliveryViewModel> result = filtered.OrderBy(x => x.EventDate).ThenBy(x => x.EventTime).ToList();
            rptDeliveries.DataSource = result;
            rptDeliveries.DataBind();
            pnlNoDeliveries.Visible = result.Count == 0;
            pnlDeliveryMessage.Visible = !string.IsNullOrEmpty(Convert.ToString(ViewState["DeliveryUpdateMessage"]));
            litDeliveryMessage.Text = Convert.ToString(ViewState["DeliveryUpdateMessage"]);
            SetActiveTab(status);
        }

        private static bool Contains(string value, string search)
        {
            return (value ?? string.Empty).IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0;
        }

        private void SelectStatus(string status)
        {
            ViewState[StatusViewStateKey] = status;
            ddlStatus.SelectedValue = status;
            BindDeliveries();
        }

        protected void FilterAll_Click(object sender, EventArgs e) { SelectStatus(string.Empty); }
        protected void FilterPending_Click(object sender, EventArgs e) { SelectStatus("Pending"); }
        protected void FilterOut_Click(object sender, EventArgs e) { SelectStatus("Out for Delivery"); }
        protected void FilterCompleted_Click(object sender, EventArgs e) { SelectStatus("Completed"); }
        protected void Search_Click(object sender, EventArgs e)
        {
            ViewState[StatusViewStateKey] = string.Empty;
            BindDeliveries();
        }

        protected void rptDeliveries_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string bookingId = Convert.ToString(e.CommandArgument);
            ViewState["DeliveryUpdateMessage"] = string.Empty;
            if (e.CommandName == "ViewDetails")
            {
                Dictionary<string, string> statuses = Session[StatusSessionKey] as Dictionary<string, string>;
                DeliveryViewModel delivery = GetDemoDeliveries().FirstOrDefault(x => x.BookingId == bookingId);
                string savedStatus;
                if (delivery != null && statuses != null && statuses.TryGetValue(bookingId, out savedStatus)) delivery.Status = savedStatus;
                if (delivery != null) ShowDeliveryDetails(delivery);
            }
            else if (e.CommandName == "UpdateStatus")
            {
                Dictionary<string, string> statuses = Session[StatusSessionKey] as Dictionary<string, string>;
                if (statuses == null) statuses = new Dictionary<string, string>();
                DeliveryViewModel delivery = GetDemoDeliveries().FirstOrDefault(x => x.BookingId == bookingId);
                if (delivery != null)
                {
                    string savedStatus;
                    if (statuses.TryGetValue(bookingId, out savedStatus)) delivery.Status = savedStatus;
                    DropDownList statusList = e.Item.FindControl("ddlDeliveryStatus") as DropDownList;
                    string requestedStatus = delivery.Status;
                    if (statusList != null)
                    {
                        string postedStatus = Request.Form[statusList.UniqueID];
                        if (!string.IsNullOrEmpty(postedStatus) && statusList.Items.FindByValue(postedStatus) != null)
                            statusList.SelectedValue = postedStatus;
                        requestedStatus = statusList.SelectedValue;
                    }
                    bool validNextStatus = (delivery.Status == "Pending" && requestedStatus == "Out for Delivery") ||
                                           (delivery.Status == "Out for Delivery" && requestedStatus == "Delivered");
                    if (validNextStatus)
                    {
                        statuses[bookingId] = requestedStatus;
                        Session[StatusSessionKey] = statuses;
                        ViewState["DeliveryUpdateMessage"] = bookingId + " status updated to " + requestedStatus + ".";
                    }
                    else
                    {
                        ViewState["DeliveryUpdateMessage"] = "Choose the next delivery status in order: Pending, Out for Delivery, then Delivered.";
                    }
                }
            }
            BindDeliveries();
        }

        private void ShowDeliveryDetails(DeliveryViewModel delivery)
        {
            litDeliveryDetailBooking.Text = HttpUtility.HtmlEncode(delivery.BookingId + " · " + delivery.EventType);
            litDeliveryDetailCustomer.Text = HttpUtility.HtmlEncode(delivery.Customer);
            litDeliveryDetailPhone.Text = HttpUtility.HtmlEncode(delivery.ContactPhone);
            litDeliveryDetailEvent.Text = HttpUtility.HtmlEncode(delivery.EventType);
            litDeliveryDetailDate.Text = HttpUtility.HtmlEncode(delivery.EventDate.ToString("dd MMM yyyy"));
            litDeliveryDetailNeededAt.Text = HttpUtility.HtmlEncode(delivery.EventTime);
            litDeliveryDetailStatus.Text = HttpUtility.HtmlEncode(delivery.Status);
            litDeliveryDetailAddress.Text = HttpUtility.HtmlEncode(delivery.DeliveryAddress);
            litDeliveryDetailInstructions.Text = HttpUtility.HtmlEncode(delivery.DeliveryNotes);
            pnlDeliveryPackageDetail.Visible = delivery.IsPackage;
            imgDeliveryPackage.ImageUrl = delivery.PackageImageUrl;
            imgDeliveryPackage.AlternateText = delivery.PackageName;
            litDeliveryPackageName.Text = HttpUtility.HtmlEncode(delivery.PackageName);
            rptDeliveryPackageItems.DataSource = delivery.IsPackage ? delivery.EquipmentItems : null;
            rptDeliveryPackageItems.DataBind();
            rptDeliveryDetailItems.Visible = !delivery.IsPackage;
            rptDeliveryDetailItems.DataSource = delivery.IsPackage ? null : delivery.EquipmentItems;
            rptDeliveryDetailItems.DataBind();

            Page.ClientScript.RegisterStartupScript(GetType(), "showDeliveryDetails",
                "window.addEventListener('load',function(){var m=document.getElementById('pnlDeliveryDetailsModal');if(m&&window.bootstrap){bootstrap.Modal.getOrCreateInstance(m).show();}});", true);
        }

        private void SetActiveTab(string status)
        {
            lnkAll.CssClass = "nav-link" + (string.IsNullOrEmpty(status) ? " active" : string.Empty);
            lnkPending.CssClass = "nav-link" + (status == "Pending" ? " active" : string.Empty);
            lnkOutForDelivery.CssClass = "nav-link" + (status == "Out for Delivery" ? " active" : string.Empty);
            lnkCompleted.CssClass = "nav-link" + (status == "Completed" ? " active" : string.Empty);
        }

        protected string StatusBadge(object value)
        {
            string status = Convert.ToString(value);
            if (status == "Completed" || status == "Delivered") return "bg-success-subtle border border-success-subtle";
            if (status == "Out for Delivery") return "bg-primary-subtle border border-primary-subtle";
            if (status == "Scheduled") return "bg-secondary-subtle border border-secondary-subtle";
            return "bg-warning-subtle border border-warning-subtle";
        }

    }
}