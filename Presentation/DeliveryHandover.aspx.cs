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
    public partial class DeliveryHandover : System.Web.UI.Page
    {
        private long _taskId;
        private long _bookingId;
        private int _assignedStaffId;
        private string _taskStatus;
        private bool _pageLoaded;

        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["ForteDB"]
                    .ConnectionString;
            }
        }

        private sealed class EquipmentItem
        {
            public long BookingItemID { get; set; }
            public string ProductName { get; set; }
            public int Quantity { get; set; }
            public string ImageUrl { get; set; }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            /*
            // Turn this back on when staff login should be required.
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

            LoadHandoverPage();
        }

        private void LoadHandoverPage()
        {
            long taskId;
            if (!Int64.TryParse(Request.QueryString["taskId"], out taskId) || taskId <= 0)
            {
                ShowMessage("A valid delivery task was not supplied.", "alert-warning");
                return;
            }

            const string bookingSql = @"
SELECT TOP (1)
       t.TaskID,
       t.BookingID,
       t.AssignedStaffID,
       t.TaskStatus,
       t.ScheduledAt,
       t.TaskLocation,
       t.Instructions,
       b.BookingReference,
       b.CustomerFullName,
       b.CustomerPhone,
       b.EventType,
       b.EventDate,
       b.DeliveryAddress,
       b.DeliveryCity,
       b.DeliveryProvince,
       b.DeliveryPostalCode,
       h.DeliveryHandoverID
FROM dbo.BookingTasks AS t
INNER JOIN dbo.Bookings AS b ON b.BookingID = t.BookingID
LEFT JOIN dbo.DeliveryHandovers AS h ON h.TaskID = t.TaskID
WHERE t.TaskID = @TaskID
  AND t.TaskType = N'Delivery'
  AND t.TaskStatus <> N'Cancelled';";

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            using (SqlCommand command = new SqlCommand(bookingSql, connection))
            {
                command.Parameters.Add("@TaskID", SqlDbType.BigInt).Value = taskId;
                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (!reader.Read())
                    {
                        ShowMessage("This delivery task could not be found.", "alert-warning");
                        return;
                    }

                    _taskId = Convert.ToInt64(reader["TaskID"]);
                    _bookingId = Convert.ToInt64(reader["BookingID"]);
                    _assignedStaffId = reader["AssignedStaffID"] == DBNull.Value
                        ? 0
                        : Convert.ToInt32(reader["AssignedStaffID"]);
                    _taskStatus = Convert.ToString(reader["TaskStatus"]);

                    // If a staff session exists, make sure this task belongs to that staff member.
                    if (Session["UserID"] != null &&
                        Convert.ToInt32(Session["UserID"]) != _assignedStaffId)
                    {
                        ShowMessage("This delivery task is not assigned to your staff account.",
                            "alert-danger");
                        return;
                    }

                    litBookingReference.Text = HttpUtility.HtmlEncode(
                        "Booking " + Convert.ToString(reader["BookingReference"]));
                    litCustomerName.Text = HttpUtility.HtmlEncode(
                        Convert.ToString(reader["CustomerFullName"]));
                    litCustomerPhone.Text = HttpUtility.HtmlEncode(
                        Convert.ToString(reader["CustomerPhone"]));
                    litEventType.Text = HttpUtility.HtmlEncode(
                        Convert.ToString(reader["EventType"]));
                    litEventDate.Text = Convert.ToDateTime(reader["EventDate"])
                        .ToString("dd MMM yyyy");
                    litScheduledAt.Text = Convert.ToDateTime(reader["ScheduledAt"])
                        .ToString("dd MMM yyyy, HH:mm");
                    litTaskStatus.Text = HttpUtility.HtmlEncode(_taskStatus);
                    litInstructions.Text = HttpUtility.HtmlEncode(
                        Convert.ToString(reader["Instructions"]));

                    string address = String.Join(", ", new[]
                    {
                        Convert.ToString(reader["DeliveryAddress"]),
                        Convert.ToString(reader["DeliveryCity"]),
                        Convert.ToString(reader["DeliveryProvince"]),
                        Convert.ToString(reader["DeliveryPostalCode"])
                    }.Where(value => !String.IsNullOrWhiteSpace(value)));

                    if (String.IsNullOrWhiteSpace(address))
                        address = Convert.ToString(reader["TaskLocation"]);

                    litAddress.Text = HttpUtility.HtmlEncode(address);

                    bool alreadyRecorded = reader["DeliveryHandoverID"] != DBNull.Value;
                    pnlBooking.Visible = true;
                    pnlComplete.Visible = alreadyRecorded;
                    btnSubmitHandover.Visible = !alreadyRecorded;

                    if (!alreadyRecorded && _taskStatus != "Out for Delivery")
                    {
                        btnSubmitHandover.Visible = false;
                        ShowMessage(
                            "Start the delivery from the Manage Delivery page before submitting the handover.",
                            "alert-warning");
                    }

                    _pageLoaded = true;
                }
            }

            if (!_pageLoaded)
                return;

            List<EquipmentItem> items = LoadEquipmentItems(_bookingId);
            rptEquipment.DataSource = items;
            rptEquipment.DataBind();
            pnlNoItems.Visible = items.Count == 0;

            if (items.Count == 0)
                btnSubmitHandover.Visible = false;

            lnkBackToDeliveries.NavigateUrl = ResolveUrl(
                "~/Presentation/ManageDelivery.aspx?bookingId=" +
                HttpUtility.UrlEncode(GetBookingReference(_bookingId)));
        }

        private List<EquipmentItem> LoadEquipmentItems(long bookingId)
        {
            const string sql = @"
SELECT bi.BookingItemID,
       bi.ProductName,
       bi.Quantity,
       p.ImageUrl
FROM dbo.BookingItems AS bi
LEFT JOIN dbo.Product AS p ON p.ProductID = bi.ProductID
WHERE bi.BookingID = @BookingID
  AND bi.IsPackageHeader = 0
ORDER BY COALESCE(bi.ParentBookingItemID, bi.BookingItemID),
         bi.BookingItemID;";

            var items = new List<EquipmentItem>();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.Parameters.Add("@BookingID", SqlDbType.BigInt).Value = bookingId;
                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string image = Convert.ToString(reader["ImageUrl"]);

                        if (String.IsNullOrWhiteSpace(image))
                            image = ResolveUrl("~/Images/Chairs.jpg");
                        else if (image.StartsWith("~/", StringComparison.Ordinal))
                            image = ResolveUrl(image);

                        items.Add(new EquipmentItem
                        {
                            BookingItemID = Convert.ToInt64(reader["BookingItemID"]),
                            ProductName = Convert.ToString(reader["ProductName"]),
                            Quantity = Convert.ToInt32(reader["Quantity"]),
                            ImageUrl = image
                        });
                    }
                }
            }

            return items;
        }

        protected void btnSubmitHandover_Click(object sender, EventArgs e)
        {
            if (!_pageLoaded || _taskId <= 0 || _bookingId <= 0)
            {
                ShowMessage("The delivery details could not be loaded. Reopen the handover from Manage Delivery.",
                    "alert-danger");
                return;
            }

            string staffSignature = txtStaffSignature.Text.Trim();
            string customerSignature = txtCustomerSignature.Text.Trim();

            if (String.IsNullOrWhiteSpace(staffSignature) ||
                String.IsNullOrWhiteSpace(customerSignature))
            {
                ShowMessage("Enter both the staff name and the customer name to confirm the handover.",
                    "alert-warning");
                return;
            }

            if (!chkCustomerAccepted.Checked)
            {
                ShowMessage("The customer must accept the handover record before it can be submitted.",
                    "alert-warning");
                return;
            }

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();

                using (SqlTransaction transaction = connection.BeginTransaction())
                {
                    try
                    {
                        Dictionary<long, int> expectedItems =
                            LoadExpectedItems(connection, transaction, _bookingId);

                        var enteredItems = new List<EquipmentItemEntry>();

                        foreach (System.Web.UI.WebControls.RepeaterItem row in rptEquipment.Items)
                        {
                            var idControl = row.FindControl("hfBookingItemID")
                                as System.Web.UI.WebControls.HiddenField;
                            var goodControl = row.FindControl("txtGood")
                                as System.Web.UI.WebControls.TextBox;
                            var damagedControl = row.FindControl("txtDamaged")
                                as System.Web.UI.WebControls.TextBox;
                            var missingControl = row.FindControl("txtMissing")
                                as System.Web.UI.WebControls.TextBox;
                            var notesControl = row.FindControl("txtItemNotes")
                                as System.Web.UI.WebControls.TextBox;

                            long bookingItemId;
                            int good;
                            int damaged;
                            int missing;

                            if (idControl == null ||
                                !Int64.TryParse(idControl.Value, out bookingItemId) ||
                                !expectedItems.ContainsKey(bookingItemId))
                            {
                                throw new InvalidOperationException(
                                    "An equipment row is invalid. Refresh the page and try again.");
                            }

                            if (!Int32.TryParse(goodControl.Text, out good) ||
                                !Int32.TryParse(damagedControl.Text, out damaged) ||
                                !Int32.TryParse(missingControl.Text, out missing) ||
                                good < 0 || damaged < 0 || missing < 0)
                            {
                                throw new InvalidOperationException(
                                    "Enter zero or a positive whole number for each quantity.");
                            }

                            int expected = expectedItems[bookingItemId];

                            if (good + damaged + missing != expected)
                            {
                                throw new InvalidOperationException(
                                    "For every equipment item, Good + Damaged + Missing must equal its booked quantity.");
                            }

                            string notes = notesControl.Text.Trim();

                            if ((damaged > 0 || missing > 0) &&
                                String.IsNullOrWhiteSpace(notes))
                            {
                                throw new InvalidOperationException(
                                    "Add a note for every item recorded as damaged or missing.");
                            }

                            enteredItems.Add(new EquipmentItemEntry
                            {
                                BookingItemID = bookingItemId,
                                Expected = expected,
                                Good = good,
                                Damaged = damaged,
                                Missing = missing,
                                Notes = notes
                            });
                        }

                        if (enteredItems.Count != expectedItems.Count)
                        {
                            throw new InvalidOperationException(
                                "The equipment list changed. Refresh the page and check every item again.");
                        }

                        long handoverId = InsertHandover(
                            connection,
                            transaction,
                            staffSignature,
                            customerSignature,
                            txtHandoverNotes.Text.Trim());

                        foreach (EquipmentItemEntry item in enteredItems)
                        {
                            InsertHandoverItem(connection, transaction, handoverId, item);
                        }

                        using (SqlCommand updateTask = new SqlCommand(@"
UPDATE dbo.BookingTasks
SET TaskStatus = N'Delivered',
    CompletedAt = SYSUTCDATETIME(),
    UpdatedAt = SYSUTCDATETIME()
WHERE TaskID = @TaskID
  AND BookingID = @BookingID
  AND TaskType = N'Delivery'
  AND AssignedStaffID = @StaffID
  AND TaskStatus = N'Out for Delivery';",
                            connection, transaction))
                        {
                            updateTask.Parameters.Add("@TaskID", SqlDbType.BigInt).Value = _taskId;
                            updateTask.Parameters.Add("@BookingID", SqlDbType.BigInt).Value = _bookingId;
                            updateTask.Parameters.Add("@StaffID", SqlDbType.Int).Value = _assignedStaffId;

                            if (updateTask.ExecuteNonQuery() != 1)
                            {
                                throw new InvalidOperationException(
                                    "The delivery status changed before the handover was saved. Refresh and try again.");
                            }
                        }

                        transaction.Commit();
                        Response.Redirect(
                            "EquipmentHandover.aspx?taskId=" + _taskId,
                            false);
                        Context.ApplicationInstance.CompleteRequest();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        ShowMessage(
                            "The handover could not be saved. " +
                            HttpUtility.HtmlEncode(ex.Message),
                            "alert-danger");
                    }
                }
            }
        }

        private Dictionary<long, int> LoadExpectedItems(
            SqlConnection connection,
            SqlTransaction transaction,
            long bookingId)
        {
            const string sql = @"
SELECT BookingItemID, Quantity
FROM dbo.BookingItems
WHERE BookingID = @BookingID
  AND IsPackageHeader = 0;";

            var items = new Dictionary<long, int>();

            using (SqlCommand command = new SqlCommand(sql, connection, transaction))
            {
                command.Parameters.Add("@BookingID", SqlDbType.BigInt).Value = bookingId;

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        items.Add(
                            Convert.ToInt64(reader["BookingItemID"]),
                            Convert.ToInt32(reader["Quantity"]));
                    }
                }
            }

            return items;
        }

        private long InsertHandover(
            SqlConnection connection,
            SqlTransaction transaction,
            string staffSignature,
            string customerSignature,
            string notes)
        {
            const string sql = @"
INSERT dbo.DeliveryHandovers
(
    BookingID,
    TaskID,
    StaffUserID,
    StaffSignature,
    CustomerSignature,
    CustomerAcknowledged,
    Notes
)
VALUES
(
    @BookingID,
    @TaskID,
    @StaffUserID,
    @StaffSignature,
    @CustomerSignature,
    1,
    @Notes
);
SELECT CAST(SCOPE_IDENTITY() AS BIGINT);";

            using (SqlCommand command = new SqlCommand(sql, connection, transaction))
            {
                command.Parameters.Add("@BookingID", SqlDbType.BigInt).Value = _bookingId;
                command.Parameters.Add("@TaskID", SqlDbType.BigInt).Value = _taskId;
                command.Parameters.Add("@StaffUserID", SqlDbType.Int).Value = _assignedStaffId;
                command.Parameters.Add("@StaffSignature", SqlDbType.NVarChar, 150).Value = staffSignature;
                command.Parameters.Add("@CustomerSignature", SqlDbType.NVarChar, 150).Value = customerSignature;
                command.Parameters.Add("@Notes", SqlDbType.NVarChar, 1000).Value =
                    String.IsNullOrWhiteSpace(notes) ? (object)DBNull.Value : notes;

                return Convert.ToInt64(command.ExecuteScalar());
            }
        }

        private void InsertHandoverItem(
            SqlConnection connection,
            SqlTransaction transaction,
            long handoverId,
            EquipmentItemEntry item)
        {
            string condition;

            if (item.Missing == item.Expected)
                condition = "Missing";
            else if (item.Missing > 0)
                condition = "Partly Missing";
            else if (item.Damaged == item.Expected)
                condition = "Damaged";
            else
                condition = "Good";

            string quantityNotes =
                "Good: " + item.Good +
                "; Damaged: " + item.Damaged +
                "; Missing: " + item.Missing;

            string notes = String.IsNullOrWhiteSpace(item.Notes)
                ? quantityNotes
                : quantityNotes + ". " + item.Notes;

            const string sql = @"
INSERT dbo.DeliveryHandoverItems
(
    DeliveryHandoverID,
    BookingItemID,
    QuantityExpected,
    QuantityDelivered,
    ConditionStatus,
    Notes
)
VALUES
(
    @HandoverID,
    @BookingItemID,
    @Expected,
    @Delivered,
    @ConditionStatus,
    @Notes
);";

            using (SqlCommand command = new SqlCommand(sql, connection, transaction))
            {
                command.Parameters.Add("@HandoverID", SqlDbType.BigInt).Value = handoverId;
                command.Parameters.Add("@BookingItemID", SqlDbType.BigInt).Value = item.BookingItemID;
                command.Parameters.Add("@Expected", SqlDbType.Int).Value = item.Expected;
                command.Parameters.Add("@Delivered", SqlDbType.Int).Value = item.Good + item.Damaged;
                command.Parameters.Add("@ConditionStatus", SqlDbType.NVarChar, 30).Value = condition;
                command.Parameters.Add("@Notes", SqlDbType.NVarChar, 500).Value =
                    notes.Length > 500 ? notes.Substring(0, 500) : notes;

                command.ExecuteNonQuery();
            }
        }

        private string GetBookingReference(long bookingId)
        {
            const string sql =
                "SELECT BookingReference FROM dbo.Bookings WHERE BookingID = @BookingID;";

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.Parameters.Add("@BookingID", SqlDbType.BigInt).Value = bookingId;
                connection.Open();
                return Convert.ToString(command.ExecuteScalar());
            }
        }

        private void ShowMessage(string message, string cssClass)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = "alert handover-message " + cssClass;
            litMessage.Text = message;
        }

        private sealed class EquipmentItemEntry
        {
            public long BookingItemID { get; set; }
            public int Expected { get; set; }
            public int Good { get; set; }
            public int Damaged { get; set; }
            public int Missing { get; set; }
            public string Notes { get; set; }
        }
    }
}