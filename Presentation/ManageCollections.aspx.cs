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
    public partial class ManageCollections : System.Web.UI.Page
    {

        private const string FilterKey = "CollectionListFilter";

        private sealed class CollectionRow
        {
            public string BookingReference { get; set; }
            public string EventType { get; set; }
            public string Customer { get; set; }
            public string Phone { get; set; }
            public DateTime CollectionAt { get; set; }
            public DateTime EventEndAt { get; set; }
            public string Location { get; set; }
            public string ItemsSummary { get; set; }
            public string ImageUrl { get; set; }
            public string TaskStatus { get; set; }
            public string StatusCss { get; set; }
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
             * TEMPORARY LOCAL TESTING ONLY.
             * Uncomment this block when you restore the login requirement.
             *
            if (Session["UserID"] == null ||
                String.Equals(Convert.ToString(Session["UserRole"]), "Customer",
                    StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Login.aspx?returnUrl=" +
                    Server.UrlEncode(Request.RawUrl), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            */

            if (!IsPostBack)
            {
                ViewState[FilterKey] = "All";
                BindCollections();
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

                int requestedStaffID;
                if (Int32.TryParse(Request.QueryString["staffId"], out requestedStaffID) &&
                    IsActiveStaff(requestedStaffID))
                {
                    return requestedStaffID;
                }

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                using (SqlCommand command = new SqlCommand(@"
SELECT TOP (1) s.UserID
FROM dbo.Staff AS s
INNER JOIN dbo.Users AS u ON u.UserID = s.UserID
INNER JOIN dbo.Roles AS r ON r.RoleID = u.RoleID
WHERE s.IsActive = 1
  AND u.IsActive = 1
  AND r.RoleName IN (N'Collection Staff', N'Staff')
ORDER BY CASE WHEN r.RoleName = N'Collection Staff' THEN 0 ELSE 1 END,
         s.UserID;", connection))
                {
                    connection.Open();
                    object value = command.ExecuteScalar();

                    if (value == null || value == DBNull.Value)
                    {
                        throw new InvalidOperationException(
                            "No active collection staff account exists in the database.");
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

        private List<CollectionRow> GetCollections()
        {
            const string sql = @"
SELECT
    t.TaskID,
    b.BookingReference,
    b.EventType,
    b.CustomerFullName,
    b.CustomerPhone,
    t.ScheduledAt AS CollectionAt,
    COALESCE(b.EventEndAt, t.ScheduledAt) AS EventEndAt,
    COALESCE(
        NULLIF(t.TaskLocation, N''),
        NULLIF(b.DeliveryAddress, N''),
        NULLIF(b.DeliveryCity, N''),
        N'Collection location not provided'
    ) AS Location,
    t.TaskStatus,
    COALESCE(
        STUFF((
            SELECT N', ' + CONVERT(nvarchar(10), bi.Quantity)
                   + N' × ' + bi.ProductName
            FROM dbo.BookingItems AS bi
            WHERE bi.BookingID = b.BookingID
              AND bi.IsPackageHeader = 0
            ORDER BY COALESCE(bi.ParentBookingItemID, bi.BookingItemID),
                     bi.BookingItemID
            FOR XML PATH(''), TYPE
        ).value('.', 'nvarchar(max)'), 1, 2, N''),
        N'No equipment items recorded'
    ) AS ItemsSummary,
    COALESCE((
        SELECT TOP (1) p.ImageUrl
        FROM dbo.BookingItems AS bi
        LEFT JOIN dbo.Product AS p ON p.ProductID = bi.ProductID
        WHERE bi.BookingID = b.BookingID
          AND bi.IsPackageHeader = 0
        ORDER BY bi.BookingItemID
    ), N'../Images/Chairs.jpg') AS ImageUrl
FROM dbo.BookingTasks AS t
INNER JOIN dbo.Bookings AS b ON b.BookingID = t.BookingID
WHERE t.AssignedStaffID = @StaffID
  AND t.TaskType IN (N'Company Collection', N'Customer Collection')
  AND t.TaskStatus <> N'Cancelled'
ORDER BY t.ScheduledAt, b.BookingReference;";

            List<CollectionRow> rows = new List<CollectionRow>();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.Parameters.Add("@StaffID", SqlDbType.Int).Value = CurrentStaffID;

                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    DataTable table = new DataTable();
                    adapter.Fill(table);

                    foreach (DataRow row in table.Rows)
                    {
                        string image = Convert.ToString(row["ImageUrl"]);

                        if (String.IsNullOrWhiteSpace(image))
                            image = "../Images/Chairs.jpg";
                        else if (image.StartsWith("~/", StringComparison.Ordinal))
                            image = ResolveUrl(image);

                        string status = Convert.ToString(row["TaskStatus"]);

                        rows.Add(new CollectionRow
                        {
                            BookingReference = Convert.ToString(row["BookingReference"]),
                            EventType = Convert.ToString(row["EventType"]),
                            Customer = Convert.ToString(row["CustomerFullName"]),
                            Phone = Convert.ToString(row["CustomerPhone"]),
                            CollectionAt = Convert.ToDateTime(row["CollectionAt"]),
                            EventEndAt = Convert.ToDateTime(row["EventEndAt"]),
                            Location = Convert.ToString(row["Location"]),
                            ItemsSummary = Convert.ToString(row["ItemsSummary"]),
                            ImageUrl = image,
                            TaskStatus = status,
                            StatusCss = GetStatusCss(status)
                        });
                    }
                }
            }

            return rows;
        }

        private void BindCollections()
        {
            try
            {
                List<CollectionRow> all = GetCollections();

                litAllCount.Text = all.Count.ToString();
                litPendingCount.Text = all.Count(row =>
                    row.TaskStatus == "Pending" || row.TaskStatus == "Scheduled").ToString();
                litCollectedCount.Text = all.Count(row =>
                    row.TaskStatus == "Collected" || row.TaskStatus == "Completed").ToString();

                string filter = Convert.ToString(ViewState[FilterKey] ?? "All");
                string search = (txtSearch.Text ?? String.Empty).Trim();

                DateTime selectedDate;
                bool filterByDate = DateTime.TryParse(txtDate.Text, out selectedDate);

                IEnumerable<CollectionRow> result = all;

                if (filter == "Pending")
                {
                    result = result.Where(row =>
                        row.TaskStatus == "Pending" || row.TaskStatus == "Scheduled");
                }
                else if (filter == "Collected")
                {
                    result = result.Where(row =>
                        row.TaskStatus == "Collected" || row.TaskStatus == "Completed");
                }

                if (!String.IsNullOrWhiteSpace(search))
                {
                    result = result.Where(row =>
                        row.BookingReference.IndexOf(search,
                            StringComparison.OrdinalIgnoreCase) >= 0 ||
                        row.Customer.IndexOf(search,
                            StringComparison.OrdinalIgnoreCase) >= 0 ||
                        row.EventType.IndexOf(search,
                            StringComparison.OrdinalIgnoreCase) >= 0);
                }

                if (filterByDate)
                    result = result.Where(row =>
                        row.CollectionAt.Date == selectedDate.Date);

                List<CollectionRow> displayed = result
                    .OrderBy(row => row.CollectionAt)
                    .ThenBy(row => row.BookingReference)
                    .ToList();

                rptCollections.DataSource = displayed;
                rptCollections.DataBind();

                pnlEmpty.Visible = displayed.Count == 0;
                litEmptyMessage.Text = all.Count == 0
                    ? "No collection tasks are assigned to this staff account. Assign a collection task to an active collection staff member."
                    : "No assigned collection tasks match these filters.";

                SetActiveTab(filter);
                pnlMessage.Visible = false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "Manage collections load failed: " + ex);

                rptCollections.DataSource = null;
                rptCollections.DataBind();
                pnlEmpty.Visible = false;

                string message = "Bookings could not be loaded from the database.";
                if (Request.IsLocal)
                    message += " Details: " + ex.Message;

                litMessage.Text = HttpUtility.HtmlEncode(message);
                pnlMessage.Visible = true;
            }
        }

        protected void rptCollections_ItemDataBound(
            object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem)
                return;

            CollectionRow row = e.Item.DataItem as CollectionRow;
            if (row == null)
                return;

            bool completed =
                row.TaskStatus == "Collected" || row.TaskStatus == "Completed";
            bool eventEnded = row.EventEndAt <= DateTime.Now;
            bool ready = !completed &&
                         eventEnded &&
                         (row.TaskStatus == "Pending" ||
                          row.TaskStatus == "Scheduled");

            HyperLink formLink =
                e.Item.FindControl("lnkOpenCollectionForm") as HyperLink;
            PlaceHolder waiting =
                e.Item.FindControl("phWaitingForEventEnd") as PlaceHolder;
            PlaceHolder collected =
                e.Item.FindControl("phAlreadyCollected") as PlaceHolder;

            if (formLink != null)
            {
                formLink.Visible = ready;
                formLink.NavigateUrl = "CollectionHandover.aspx?bookingRef=" +
                    Server.UrlEncode(row.BookingReference);
            }

            if (waiting != null)
                waiting.Visible = !completed && !eventEnded;

            if (collected != null)
                collected.Visible = completed;
        }

        protected void FilterAll_Click(object sender, EventArgs e)
        {
            ViewState[FilterKey] = "All";
            BindCollections();
        }

        protected void FilterPending_Click(object sender, EventArgs e)
        {
            ViewState[FilterKey] = "Pending";
            BindCollections();
        }

        protected void FilterCollected_Click(object sender, EventArgs e)
        {
            ViewState[FilterKey] = "Collected";
            BindCollections();
        }

        protected void Search_Click(object sender, EventArgs e)
        {
            BindCollections();
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = String.Empty;
            txtDate.Text = String.Empty;
            ViewState[FilterKey] = "All";
            BindCollections();
        }

        private void SetActiveTab(string filter)
        {
            lnkAll.CssClass = "nav-link" +
                (filter == "All" ? " active" : String.Empty);
            lnkPending.CssClass = "nav-link" +
                (filter == "Pending" ? " active" : String.Empty);
            lnkCollected.CssClass = "nav-link" +
                (filter == "Collected" ? " active" : String.Empty);
        }

        private string GetStatusCss(string status)
        {
            if (status == "Collected" || status == "Completed")
                return "bg-success";

            if (status == "Scheduled")
                return "bg-primary";

            return "bg-warning text-dark";
        }

    }
}