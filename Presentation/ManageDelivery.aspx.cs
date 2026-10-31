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
    public partial class ManageDelivery : System.Web.UI.Page
    {

        private const string FilterKey = "StaffDeliveryStatusFilter";

        private sealed class DeliveryRow
        {
            public long TaskID { get; set; }
            public long BookingKey { get; set; }
            public string BookingId { get; set; }
            public string EventType { get; set; }
            public string Customer { get; set; }
            public string ContactPhone { get; set; }
            public DateTime EventDate { get; set; }
            public string EventTime { get; set; }
            public DateTime ScheduledAt { get; set; }
            public string Venue { get; set; }
            public string DeliveryAddress { get; set; }
            public string DeliveryNotes { get; set; }
            public string Items { get; set; }
            public string Status { get; set; }
            public string StatusCss { get; set; }
            public string ImageUrl { get; set; }
            public bool IsPackage { get; set; }
            public string PackageName { get; set; }
            public string PackageImageUrl { get; set; }
            public List<EquipmentLine> EquipmentItems { get; set; }
        }

        private sealed class EquipmentLine
        {
            public string Name { get; set; }
            public int Quantity { get; set; }
            public string ImageUrl { get; set; }
            public string PackageName { get; set; }
            public string PackageImageUrl { get; set; }
        }

        private string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["ForteDB"].ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            /*
             * TEMPORARY LOCAL TESTING:
             * This login redirect is commented out so the page can be opened directly.
             * Uncomment it when login is required again.
             *
            if (Session["UserID"] == null ||
                String.Equals(Convert.ToString(Session["UserRole"]), "Customer",
                    StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect(
                    "Login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl),
                    false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            */

            if (!IsPostBack)
            {
                ViewState[FilterKey] = "All";
                BindDeliveries();
            }
        }

        private int CurrentStaffID
        {
            get
            {
                int userID;

                if (Session["UserID"] != null &&
                    !String.Equals(Convert.ToString(Session["UserRole"]), "Customer",
                        StringComparison.OrdinalIgnoreCase) &&
                    Int32.TryParse(Convert.ToString(Session["UserID"]), out userID))
                {
                    return userID;
                }

                // Optional local-testing override:
                // ManageDelivery.aspx?staffId=123
                int requestedStaffID;
                if (Int32.TryParse(Request.QueryString["staffId"], out requestedStaffID) &&
                    IsActiveStaff(requestedStaffID))
                {
                    return requestedStaffID;
                }

                // When there is no staff session, select an active delivery staff user.
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                using (SqlCommand command = new SqlCommand(@"
SELECT TOP (1) s.UserID
FROM dbo.Staff AS s
INNER JOIN dbo.Users AS u ON u.UserID = s.UserID
INNER JOIN dbo.Roles AS r ON r.RoleID = u.RoleID
WHERE s.IsActive = 1
  AND u.IsActive = 1
  AND r.RoleName IN (N'Delivery Staff', N'Staff')
ORDER BY CASE WHEN r.RoleName = N'Delivery Staff' THEN 0 ELSE 1 END,
         s.UserID;", connection))
                {
                    connection.Open();
                    object value = command.ExecuteScalar();

                    if (value == null || value == DBNull.Value)
                    {
                        throw new InvalidOperationException(
                            "No active delivery staff account was found in the database.");
                    }

                    return Convert.ToInt32(value);
                }
            }
        }

        private bool IsActiveStaff(int userID)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            using (SqlCommand command = new SqlCommand(@"
SELECT COUNT(1)
FROM dbo.Staff AS s
INNER JOIN dbo.Users AS u ON u.UserID = s.UserID
WHERE s.UserID = @UserID
  AND s.IsActive = 1
  AND u.IsActive = 1;", connection))
            {
                command.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                connection.Open();
                return Convert.ToInt32(command.ExecuteScalar()) == 1;
            }
        }

        private List<DeliveryRow> GetAssignedDeliveries()
        {
            const string sql = @"
SELECT
    t.TaskID,
    b.BookingID,
    b.BookingReference,
    b.EventType,
    b.CustomerFullName,
    b.CustomerPhone,
    b.EventDate,
    t.ScheduledAt,
    t.TaskLocation,
    t.Instructions,
    t.TaskStatus,
    b.DeliveryAddress,
    b.DeliveryCity,
    b.DeliveryProvince,
    b.DeliveryPostalCode
FROM dbo.BookingTasks AS t
INNER JOIN dbo.Bookings AS b ON b.BookingID = t.BookingID
WHERE t.TaskType = N'Delivery'
  AND t.AssignedStaffID = @StaffID
  AND t.TaskStatus <> N'Cancelled'
ORDER BY t.ScheduledAt, b.BookingReference;";

            List<DeliveryRow> rows = new List<DeliveryRow>();
            DataTable bookings = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            using (SqlCommand command = new SqlCommand(sql, connection))
            using (SqlDataAdapter adapter = new SqlDataAdapter(command))
            {
                command.Parameters.Add("@StaffID", SqlDbType.Int).Value = CurrentStaffID;
                adapter.Fill(bookings);
            }

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                foreach (DataRow row in bookings.Rows)
                {
                    long bookingID = Convert.ToInt64(row["BookingID"]);
                    List<EquipmentLine> items = LoadItems(connection, bookingID);

                    EquipmentLine package = items.FirstOrDefault(item =>
                        !String.IsNullOrWhiteSpace(item.PackageName));

                    DateTime scheduledAt = Convert.ToDateTime(row["ScheduledAt"]);
                    string address = JoinAddress(row);
                    string taskLocation =
                        String.IsNullOrWhiteSpace(Convert.ToString(row["TaskLocation"]))
                            ? address
                            : Convert.ToString(row["TaskLocation"]);

                    string status = Convert.ToString(row["TaskStatus"]);
                    string image = items.Count == 0
                        ? "../Images/Chairs.jpg"
                        : items[0].ImageUrl;

                    rows.Add(new DeliveryRow
                    {
                        TaskID = Convert.ToInt64(row["TaskID"]),
                        BookingKey = bookingID,
                        BookingId = Convert.ToString(row["BookingReference"]),
                        EventType = Convert.ToString(row["EventType"]),
                        Customer = Convert.ToString(row["CustomerFullName"]),
                        ContactPhone = Convert.ToString(row["CustomerPhone"]),
                        EventDate = Convert.ToDateTime(row["EventDate"]),
                        EventTime = scheduledAt.ToString("HH:mm"),
                        ScheduledAt = scheduledAt,
                        Venue = taskLocation,
                        DeliveryAddress = address,
                        DeliveryNotes = Convert.ToString(row["Instructions"]),
                        EquipmentItems = items,
                        Items = String.Join(", ", items.Select(item =>
                            item.Quantity + " × " + item.Name).ToArray()),
                        Status = status,
                        StatusCss = GetStatusCss(status),
                        ImageUrl = image,
                        IsPackage = package != null,
                        PackageName = package == null
                            ? String.Empty
                            : package.PackageName,
                        PackageImageUrl = package == null
                            ? image
                            : package.PackageImageUrl
                    });
                }
            }

            return rows;
        }

        private List<EquipmentLine> LoadItems(
            SqlConnection connection, long bookingID)
        {
            const string sql = @"
SELECT
    bi.ProductName,
    bi.Quantity,
    p.ImageUrl,
    parent.ProductName AS PackageName,
    packageProduct.ImageUrl AS PackageImageUrl
FROM dbo.BookingItems AS bi
LEFT JOIN dbo.Product AS p ON p.ProductID = bi.ProductID
LEFT JOIN dbo.BookingItems AS parent
    ON parent.BookingItemID = bi.ParentBookingItemID
LEFT JOIN dbo.Product AS packageProduct
    ON packageProduct.ProductID = parent.ProductID
WHERE bi.BookingID = @BookingID
  AND bi.IsPackageHeader = 0
ORDER BY COALESCE(bi.ParentBookingItemID, bi.BookingItemID),
         bi.BookingItemID;";

            List<EquipmentLine> items = new List<EquipmentLine>();
            bool openedHere = connection.State != ConnectionState.Open;

            if (openedHere)
                connection.Open();

            try
            {
                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.Add("@BookingID", SqlDbType.BigInt)
                        .Value = bookingID;

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            items.Add(new EquipmentLine
                            {
                                Name = Convert.ToString(reader["ProductName"]),
                                Quantity = Convert.ToInt32(reader["Quantity"]),
                                ImageUrl = ResolveImage(
                                    Convert.ToString(reader["ImageUrl"])),
                                PackageName = reader["PackageName"] == DBNull.Value
                                    ? String.Empty
                                    : Convert.ToString(reader["PackageName"]),
                                PackageImageUrl = ResolveImage(
                                    Convert.ToString(reader["PackageImageUrl"]))
                            });
                        }
                    }
                }
            }
            finally
            {
                if (openedHere && connection.State == ConnectionState.Open)
                    connection.Close();
            }

            return items;
        }

        private string ResolveImage(string image)
        {
            if (String.IsNullOrWhiteSpace(image))
                return "../Images/Chairs.jpg";

            if (image.StartsWith("~/", StringComparison.Ordinal))
                return ResolveUrl(image);

            return image;
        }

        private string JoinAddress(DataRow row)
        {
            string[] parts =
            {
                Convert.ToString(row["DeliveryAddress"]),
                Convert.ToString(row["DeliveryCity"]),
                Convert.ToString(row["DeliveryProvince"]),
                Convert.ToString(row["DeliveryPostalCode"])
            };

            return String.Join(", ",
                parts.Where(part => !String.IsNullOrWhiteSpace(part)));
        }

        private void BindDeliveries()
        {
            try
            {
                List<DeliveryRow> all = GetAssignedDeliveries();

                lnkAll.Text = "All deliveries (" + all.Count + ")";
                lnkPending.Text = "Pending (" +
                    all.Count(row =>
                        row.Status == "Pending" || row.Status == "Scheduled") + ")";
                lnkOutForDelivery.Text = "Out for delivery (" +
                    all.Count(row => row.Status == "Out for Delivery") + ")";
                lnkCompleted.Text = "Delivered (" +
                    all.Count(row =>
                        row.Status == "Delivered" || row.Status == "Completed") + ")";

                string filter = Convert.ToString(ViewState[FilterKey] ?? "All");
                string search = (txtSearch.Text ?? String.Empty).Trim();

                DateTime selectedDate;
                bool filterByDate = DateTime.TryParse(txtDate.Text, out selectedDate);
                string selectedStatus = ddlStatus.SelectedValue;

                IEnumerable<DeliveryRow> result = all;

                if (filter == "Pending")
                {
                    result = result.Where(row =>
                        row.Status == "Pending" || row.Status == "Scheduled");
                }
                else if (filter == "Out for Delivery")
                {
                    result = result.Where(row => row.Status == "Out for Delivery");
                }
                else if (filter == "Delivered")
                {
                    result = result.Where(row =>
                        row.Status == "Delivered" || row.Status == "Completed");
                }

                if (!String.IsNullOrWhiteSpace(selectedStatus))
                    result = result.Where(row => row.Status == selectedStatus);

                if (!String.IsNullOrWhiteSpace(search))
                {
                    result = result.Where(row =>
                        row.BookingId.IndexOf(search,
                            StringComparison.OrdinalIgnoreCase) >= 0 ||
                        row.Customer.IndexOf(search,
                            StringComparison.OrdinalIgnoreCase) >= 0);
                }

                if (filterByDate)
                {
                    result = result.Where(row =>
                        row.EventDate.Date == selectedDate.Date);
                }

                List<DeliveryRow> displayed = result
                    .OrderBy(row => row.EventDate)
                    .ThenBy(row => row.ScheduledAt)
                    .ToList();

                rptDeliveries.DataSource = displayed;
                rptDeliveries.DataBind();

                pnlNoDeliveries.Visible = displayed.Count == 0;
                litNoDeliveries.Text = all.Count == 0
                    ? "No delivery tasks are assigned to this staff account. Assign a Delivery task to active delivery staff."
                    : "No assigned deliveries match these filters.";

                SetActiveTab(filter);
                pnlDeliveryMessage.Visible = false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "Manage deliveries load failed: " + ex);

                rptDeliveries.DataSource = null;
                rptDeliveries.DataBind();
                pnlNoDeliveries.Visible = false;

                string message = "Deliveries could not be loaded from the database.";
                if (Request.IsLocal)
                    message += " Details: " + ex.Message;

                litDeliveryMessage.Text = HttpUtility.HtmlEncode(message);
                pnlDeliveryMessage.Visible = true;
            }
        }

        protected void rptDeliveries_ItemDataBound(
            object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem)
            {
                return;
            }

            DeliveryRow row = e.Item.DataItem as DeliveryRow;
            if (row == null)
                return;

            LinkButton startButton =
                e.Item.FindControl("btnStartDelivery") as LinkButton;
            HyperLink handoverLink =
                e.Item.FindControl("lnkOpenHandover") as HyperLink;
            PlaceHolder completed =
                e.Item.FindControl("phDeliveryComplete") as PlaceHolder;

            bool pending =
                row.Status == "Pending" || row.Status == "Scheduled";
            bool outForDelivery = row.Status == "Out for Delivery";
            bool delivered =
                row.Status == "Delivered" || row.Status == "Completed";

            if (startButton != null)
                startButton.Visible = pending;

            if (handoverLink != null)
            {
                handoverLink.Visible = outForDelivery;
                handoverLink.NavigateUrl =
                    "DeliveryHandover.aspx?bookingRef=" +
                    Server.UrlEncode(row.BookingId) +
                    "&taskId=" + row.TaskID;
            }

            if (completed != null)
                completed.Visible = delivered;
        }

        protected void rptDeliveries_ItemCommand(
            object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                string bookingReference = Convert.ToString(e.CommandArgument);

                DeliveryRow row = GetAssignedDeliveries()
                    .FirstOrDefault(item => item.BookingId == bookingReference);

                if (row != null)
                    ShowDeliveryDetails(row);

                return;
            }

            if (e.CommandName == "StartDelivery")
            {
                long taskID;
                if (!Int64.TryParse(Convert.ToString(e.CommandArgument), out taskID))
                    return;

                string message;

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                using (SqlCommand command = new SqlCommand(@"
UPDATE dbo.BookingTasks
SET TaskStatus = N'Out for Delivery',
    UpdatedAt = SYSUTCDATETIME()
WHERE TaskID = @TaskID
  AND TaskType = N'Delivery'
  AND AssignedStaffID = @StaffID
  AND TaskStatus IN (N'Pending', N'Scheduled');", connection))
                {
                    command.Parameters.Add("@TaskID", SqlDbType.BigInt).Value = taskID;
                    command.Parameters.Add("@StaffID", SqlDbType.Int).Value =
                        CurrentStaffID;

                    connection.Open();

                    message = command.ExecuteNonQuery() == 1
                        ? "Delivery started. Complete the handover form with the customer to mark it delivered."
                        : "This delivery could not be started. Refresh and check its current status.";
                }

                BindDeliveries();
                ShowDeliveryMessage(message);
            }
        }

        private void ShowDeliveryDetails(DeliveryRow row)
        {
            litDeliveryDetailBooking.Text =
                HttpUtility.HtmlEncode(row.BookingId + " · " + row.EventType);
            litDeliveryDetailCustomer.Text =
                HttpUtility.HtmlEncode(row.Customer);
            litDeliveryDetailPhone.Text =
                HttpUtility.HtmlEncode(row.ContactPhone);
            litDeliveryDetailEvent.Text =
                HttpUtility.HtmlEncode(row.EventType);
            litDeliveryDetailDate.Text =
                HttpUtility.HtmlEncode(row.EventDate.ToString("dd MMM yyyy"));
            litDeliveryDetailNeededAt.Text =
                HttpUtility.HtmlEncode(row.EventTime);
            litDeliveryDetailStatus.Text =
                HttpUtility.HtmlEncode(row.Status);
            litDeliveryDetailAddress.Text =
                HttpUtility.HtmlEncode(row.DeliveryAddress);
            litDeliveryDetailInstructions.Text =
                HttpUtility.HtmlEncode(row.DeliveryNotes);

            pnlDeliveryPackageDetail.Visible = row.IsPackage;
            imgDeliveryPackage.ImageUrl = row.PackageImageUrl;
            imgDeliveryPackage.AlternateText = row.PackageName;
            litDeliveryPackageName.Text =
                HttpUtility.HtmlEncode(row.PackageName);

            rptDeliveryPackageItems.DataSource =
                row.IsPackage ? row.EquipmentItems : null;
            rptDeliveryPackageItems.DataBind();

            rptDeliveryDetailItems.Visible = !row.IsPackage;
            rptDeliveryDetailItems.DataSource =
                row.IsPackage ? null : row.EquipmentItems;
            rptDeliveryDetailItems.DataBind();

            pnlDeliveryDetailsModal.Visible = true;

            string script =
                "window.addEventListener('load',function(){" +
                "var m=document.getElementById('pnlDeliveryDetailsModal');" +
                "if(m&&window.bootstrap){" +
                "bootstrap.Modal.getOrCreateInstance(m).show();" +
                "}});";

            Page.ClientScript.RegisterStartupScript(
                GetType(), "showDeliveryDetails", script, true);
        }

        protected void FilterAll_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedValue = String.Empty;
            SelectStatus("All");
        }

        protected void FilterPending_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedValue = String.Empty;
            SelectStatus("Pending");
        }

        protected void FilterOut_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedValue = String.Empty;
            SelectStatus("Out for Delivery");
        }

        protected void FilterCompleted_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedValue = String.Empty;
            SelectStatus("Delivered");
        }

        protected void Search_Click(object sender, EventArgs e)
        {
            ViewState[FilterKey] = "All";
            BindDeliveries();
        }

        private void SelectStatus(string status)
        {
            ViewState[FilterKey] = status;
            BindDeliveries();
        }

        private void SetActiveTab(string filter)
        {
            lnkAll.CssClass = "nav-link" +
                (filter == "All" ? " active" : String.Empty);
            lnkPending.CssClass = "nav-link" +
                (filter == "Pending" ? " active" : String.Empty);
            lnkOutForDelivery.CssClass = "nav-link" +
                (filter == "Out for Delivery" ? " active" : String.Empty);
            lnkCompleted.CssClass = "nav-link" +
                (filter == "Delivered" ? " active" : String.Empty);
        }

        private string GetStatusCss(string status)
        {
            if (status == "Delivered" || status == "Completed")
                return "bg-success";

            if (status == "Out for Delivery")
                return "bg-primary";

            if (status == "Scheduled")
                return "bg-secondary";

            return "bg-warning text-dark";
        }

        private void ShowDeliveryMessage(string message)
        {
            litDeliveryMessage.Text = HttpUtility.HtmlEncode(message);
            pnlDeliveryMessage.Visible = true;
        }

    }
}