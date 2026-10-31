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
    public partial class CollectionHandover : System.Web.UI.Page
    {
        private sealed class CollectionData
        {
            public long TaskID { get; set; }
            public long BookingID { get; set; }
            public string BookingReference { get; set; }
            public string Customer { get; set; }
            public string Phone { get; set; }
            public string EventType { get; set; }
            public DateTime EventDate { get; set; }
            public DateTime EventEndAt { get; set; }
            public string Location { get; set; }
            public string Instructions { get; set; }
            public string Status { get; set; }
        }

        private sealed class InspectionLine
        {
            public long BookingItemID;
            public int Expected;
            public int Good;
            public int Damaged;
            public int Missing;
            public string Note;
        }

        private string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["ForteDB"].ConnectionString;
            }
        }

        private CollectionData _collection;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            /*
             * TEMPORARY LOCAL TESTING:
             * Uncomment this login redirect block when you want to require login.
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

            string bookingReference =
                Convert.ToString(Request.QueryString["bookingRef"]);

            if (String.IsNullOrWhiteSpace(bookingReference))
            {
                pnlNoTask.Visible = true;
                return;
            }

            try
            {
                _collection = LoadCollection(bookingReference);

                if (_collection == null)
                {
                    pnlNoTask.Visible = true;
                    return;
                }

                BindCollectionPage(_collection);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "Collection form load failed: " + ex);

                ShowMessage("The collection form could not be loaded." +
                    (Request.IsLocal ? " Details: " + ex.Message : ""));
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

                // Optional local testing override:
                // CollectionHandover.aspx?bookingRef=...&staffId=123
                int requestedStaffID;
                if (Int32.TryParse(Request.QueryString["staffId"], out requestedStaffID) &&
                    IsActiveStaff(requestedStaffID))
                {
                    return requestedStaffID;
                }

                // If running without login, use the first active collection staff account.
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
                            "No active collection staff account was found.");
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

        private CollectionData LoadCollection(string bookingReference)
        {
            const string sql = @"
SELECT TOP (1)
       t.TaskID,
       b.BookingID,
       b.BookingReference,
       b.CustomerFullName,
       b.CustomerPhone,
       b.EventType,
       b.EventDate,
       COALESCE(b.EventEndAt, t.ScheduledAt) AS EventEndAt,
       COALESCE(
           NULLIF(b.DeliveryAddress, N''),
           NULLIF(t.TaskLocation, N''),
           NULLIF(b.DeliveryCity, N''),
           N'Collection location not provided'
       ) AS Location,
       COALESCE(t.Instructions, b.TransportInstructions, N'') AS Instructions,
       t.TaskStatus
FROM dbo.BookingTasks AS t
INNER JOIN dbo.Bookings AS b ON b.BookingID = t.BookingID
WHERE b.BookingReference = @BookingReference
  AND t.AssignedStaffID = @StaffID
  AND t.TaskType IN (N'Company Collection', N'Customer Collection')
  AND t.TaskStatus IN (N'Pending', N'Scheduled', N'Collected', N'Completed')
ORDER BY t.TaskID DESC;";

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.Parameters.Add("@BookingReference", SqlDbType.NVarChar, 40)
                    .Value = bookingReference.Trim();
                command.Parameters.Add("@StaffID", SqlDbType.Int).Value = CurrentStaffID;

                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (!reader.Read())
                        return null;

                    return new CollectionData
                    {
                        TaskID = Convert.ToInt64(reader["TaskID"]),
                        BookingID = Convert.ToInt64(reader["BookingID"]),
                        BookingReference = Convert.ToString(reader["BookingReference"]),
                        Customer = Convert.ToString(reader["CustomerFullName"]),
                        Phone = Convert.ToString(reader["CustomerPhone"]),
                        EventType = Convert.ToString(reader["EventType"]),
                        EventDate = Convert.ToDateTime(reader["EventDate"]),
                        EventEndAt = Convert.ToDateTime(reader["EventEndAt"]),
                        Location = Convert.ToString(reader["Location"]),
                        Instructions = Convert.ToString(reader["Instructions"]),
                        Status = Convert.ToString(reader["TaskStatus"])
                    };
                }
            }
        }

        private void BindCollectionPage(CollectionData collection)
        {
            pnlCollection.Visible = true;

            litBookingReference.Text =
                HttpUtility.HtmlEncode(collection.BookingReference);
            litCustomer.Text = HttpUtility.HtmlEncode(collection.Customer);
            litPhone.Text = HttpUtility.HtmlEncode(collection.Phone);
            litEventType.Text = HttpUtility.HtmlEncode(collection.EventType);
            litEventDate.Text =
                HttpUtility.HtmlEncode(collection.EventDate.ToString("dd MMM yyyy"));
            litEventEnd.Text =
                HttpUtility.HtmlEncode(collection.EventEndAt.ToString("dd MMM yyyy, HH:mm"));
            litTaskStatus.Text = HttpUtility.HtmlEncode(collection.Status);
            litLocation.Text = HttpUtility.HtmlEncode(collection.Location);
            litInstructions.Text = HttpUtility.HtmlEncode(collection.Instructions);

            bool collected =
                collection.Status == "Collected" ||
                collection.Status == "Completed";
            bool eventEnded = collection.EventEndAt <= DateTime.Now;

            pnlAlreadyCollected.Visible = collected;
            pnlInspection.Visible = !collected;
            pnlNotReady.Visible = !collected && !eventEnded;
            btnAcceptCollection.Enabled = !collected && eventEnded;

            DataTable items = LoadItems(collection.BookingID);
            rptItems.DataSource = items;
            rptItems.DataBind();

            if (items.Rows.Count == 0 && !collected)
            {
                ShowMessage(
                    "No equipment lines were found for this booking. " +
                    "Contact an administrator before accepting the collection.");
                btnAcceptCollection.Enabled = false;
            }
        }

        private DataTable LoadItems(long bookingID)
        {
            const string sql = @"
SELECT
    bi.BookingItemID,
    bi.ProductName AS Name,
    COALESCE(p.Description, N'') AS Description,
    bi.Quantity AS Expected,
    bi.Quantity AS Good,
    0 AS Damaged,
    0 AS Missing,
    CAST(N'' AS NVARCHAR(1000)) AS DamageNote
FROM dbo.BookingItems AS bi
LEFT JOIN dbo.Product AS p ON p.ProductID = bi.ProductID
WHERE bi.BookingID = @BookingID
  AND bi.IsPackageHeader = 0
ORDER BY COALESCE(bi.ParentBookingItemID, bi.BookingItemID),
         bi.BookingItemID;";

            DataTable items = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            using (SqlCommand command = new SqlCommand(sql, connection))
            using (SqlDataAdapter adapter = new SqlDataAdapter(command))
            {
                command.Parameters.Add("@BookingID", SqlDbType.BigInt).Value = bookingID;
                adapter.Fill(items);
            }

            return items;
        }

        protected void btnAcceptCollection_Click(object sender, EventArgs e)
        {
            if (_collection == null)
            {
                ShowMessage(
                    "The assigned collection could not be found. Return to the collections page and reopen it.");
                return;
            }

            if (_collection.Status == "Collected" ||
                _collection.Status == "Completed")
            {
                ShowMessage("This collection has already been accepted.");
                return;
            }

            if (_collection.EventEndAt > DateTime.Now)
            {
                ShowMessage("The collection can only be accepted after the event ends.");
                return;
            }

            string staffSignature =
                (txtStaffSignature.Text ?? String.Empty).Trim();
            string customerSignature =
                (txtCustomerSignature.Text ?? String.Empty).Trim();
            string collectionNotes =
                (txtCollectionNotes.Text ?? String.Empty).Trim();

            if (staffSignature.Length == 0 ||
                customerSignature.Length == 0 ||
                staffSignature.Length > 150 ||
                customerSignature.Length > 150 ||
                collectionNotes.Length > 1000 ||
                !chkCustomerAccepted.Checked)
            {
                ShowMessage(
                    "Enter both names and obtain the customer's acceptance before saving.");
                return;
            }

            List<InspectionLine> lines = new List<InspectionLine>();
            int totalGood = 0;
            int totalDamaged = 0;
            int totalMissing = 0;

            foreach (RepeaterItem row in rptItems.Items)
            {
                HiddenField idField =
                    row.FindControl("hfBookingItemID") as HiddenField;
                HiddenField expectedField =
                    row.FindControl("hfExpected") as HiddenField;
                TextBox goodField =
                    row.FindControl("txtGood") as TextBox;
                TextBox damagedField =
                    row.FindControl("txtDamaged") as TextBox;
                TextBox missingField =
                    row.FindControl("txtMissing") as TextBox;
                TextBox noteField =
                    row.FindControl("txtNote") as TextBox;

                long bookingItemID;
                int expected;
                int good;
                int damaged;
                int missing;

                if (idField == null ||
                    expectedField == null ||
                    goodField == null ||
                    damagedField == null ||
                    missingField == null ||
                    !Int64.TryParse(idField.Value, out bookingItemID) ||
                    !Int32.TryParse(expectedField.Value, out expected) ||
                    !Int32.TryParse(goodField.Text, out good) ||
                    !Int32.TryParse(damagedField.Text, out damaged) ||
                    !Int32.TryParse(missingField.Text, out missing))
                {
                    ShowMessage("Enter whole-number quantities for every item.");
                    return;
                }

                string note = noteField == null
                    ? String.Empty
                    : (noteField.Text ?? String.Empty).Trim();

                if (good < 0 ||
                    damaged < 0 ||
                    missing < 0 ||
                    good + damaged + missing != expected ||
                    (damaged > 0 && note.Length == 0) ||
                    note.Length > 1000)
                {
                    ShowMessage(
                        "For every item, Good + Damaged + Missing must equal the booked quantity. Add a note for damaged items.");
                    return;
                }

                lines.Add(new InspectionLine
                {
                    BookingItemID = bookingItemID,
                    Expected = expected,
                    Good = good,
                    Damaged = damaged,
                    Missing = missing,
                    Note = note
                });

                totalGood += good;
                totalDamaged += damaged;
                totalMissing += missing;
            }

            if (lines.Count == 0)
            {
                ShowMessage("There are no equipment items to accept for this collection.");
                return;
            }

            string overallCondition =
                GetOverallCondition(totalGood, totalDamaged, totalMissing);

            SaveCollection(
                lines,
                staffSignature,
                customerSignature,
                collectionNotes,
                overallCondition);
        }

        private string GetOverallCondition(int good, int damaged, int missing)
        {
            if (damaged == 0 && missing == 0)
                return "Good";

            if (damaged > 0 && good == 0 && missing == 0)
                return "Damaged";

            if (damaged == 0 && missing > 0)
                return "Missing Items";

            return "Partially Damaged";
        }

        private void SaveCollection(
            List<InspectionLine> lines,
            string staffSignature,
            string customerSignature,
            string collectionNotes,
            string overallCondition)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();

                using (SqlTransaction transaction = connection.BeginTransaction())
                {
                    try
                    {
                        DateTime eventEndAt;
                        string currentStatus;

                        const string checkSql = @"
SELECT t.TaskStatus,
       COALESCE(b.EventEndAt, t.ScheduledAt) AS EventEndAt
FROM dbo.BookingTasks AS t WITH (UPDLOCK, ROWLOCK)
INNER JOIN dbo.Bookings AS b ON b.BookingID = t.BookingID
WHERE t.TaskID = @TaskID
  AND t.BookingID = @BookingID
  AND t.AssignedStaffID = @StaffID
  AND t.TaskType IN (N'Company Collection', N'Customer Collection');";

                        using (SqlCommand check =
                            new SqlCommand(checkSql, connection, transaction))
                        {
                            check.Parameters.Add("@TaskID", SqlDbType.BigInt)
                                .Value = _collection.TaskID;
                            check.Parameters.Add("@BookingID", SqlDbType.BigInt)
                                .Value = _collection.BookingID;
                            check.Parameters.Add("@StaffID", SqlDbType.Int)
                                .Value = CurrentStaffID;

                            using (SqlDataReader reader = check.ExecuteReader())
                            {
                                if (!reader.Read())
                                {
                                    throw new InvalidOperationException(
                                        "This collection is not assigned to your staff account.");
                                }

                                currentStatus =
                                    Convert.ToString(reader["TaskStatus"]);
                                eventEndAt =
                                    Convert.ToDateTime(reader["EventEndAt"]);
                            }
                        }

                        if (currentStatus != "Pending" &&
                            currentStatus != "Scheduled")
                        {
                            throw new InvalidOperationException(
                                "This collection has already been completed or cancelled.");
                        }

                        if (eventEndAt > DateTime.Now)
                        {
                            throw new InvalidOperationException(
                                "The event has not ended yet.");
                        }

                        long inspectionID = InsertInspection(
                            connection,
                            transaction,
                            lines,
                            overallCondition,
                            collectionNotes);

                        InsertCollectionHandover(
                            connection,
                            transaction,
                            inspectionID,
                            staffSignature,
                            customerSignature,
                            collectionNotes);

                        using (SqlCommand update = new SqlCommand(@"
UPDATE dbo.BookingTasks
SET TaskStatus = N'Collected',
    CompletedAt = SYSUTCDATETIME(),
    UpdatedAt = SYSUTCDATETIME()
WHERE TaskID = @TaskID
  AND AssignedStaffID = @StaffID
  AND TaskStatus IN (N'Pending', N'Scheduled');",
                            connection, transaction))
                        {
                            update.Parameters.Add("@TaskID", SqlDbType.BigInt)
                                .Value = _collection.TaskID;
                            update.Parameters.Add("@StaffID", SqlDbType.Int)
                                .Value = CurrentStaffID;

                            if (update.ExecuteNonQuery() != 1)
                            {
                                throw new InvalidOperationException(
                                    "The collection status changed. Refresh and try again.");
                            }
                        }

                        transaction.Commit();

                        pnlInspection.Visible = false;
                        pnlNotReady.Visible = false;
                        pnlAlreadyCollected.Visible = true;
                        litTaskStatus.Text = "Collected";
                        btnAcceptCollection.Enabled = false;
                    }
                    catch (Exception ex)
                    {
                        try
                        {
                            transaction.Rollback();
                        }
                        catch
                        {
                            // Preserve the original save error for display/logging.
                        }

                        System.Diagnostics.Trace.TraceError(
                            "Collection handover save failed: " + ex);

                        ShowMessage(ex is InvalidOperationException
                            ? ex.Message
                            : "The collection could not be saved. Check that the collection handover table exists.");
                    }
                }
            }
        }

        private long InsertInspection(
            SqlConnection connection,
            SqlTransaction transaction,
            List<InspectionLine> lines,
            string overallCondition,
            string notes)
        {
            long inspectionID;

            using (SqlCommand insert = new SqlCommand(@"
INSERT dbo.ReturnInspections
    (BookingID, InspectedByUserID, OverallCondition, Notes)
VALUES
    (@BookingID, @StaffID, @Condition, @Notes);
SELECT CONVERT(bigint, SCOPE_IDENTITY());",
                connection, transaction))
            {
                insert.Parameters.Add("@BookingID", SqlDbType.BigInt)
                    .Value = _collection.BookingID;
                insert.Parameters.Add("@StaffID", SqlDbType.Int)
                    .Value = CurrentStaffID;
                insert.Parameters.Add("@Condition", SqlDbType.NVarChar, 30)
                    .Value = overallCondition;
                insert.Parameters.Add("@Notes", SqlDbType.NVarChar, 2000)
                    .Value = String.IsNullOrWhiteSpace(notes)
                        ? (object)DBNull.Value
                        : notes;

                inspectionID = Convert.ToInt64(insert.ExecuteScalar());
            }

            foreach (InspectionLine line in lines)
            {
                string condition = line.Damaged > 0
                    ? (line.Good > 0 || line.Missing > 0 ? "Partial" : "Damaged")
                    : (line.Missing > 0 ? "Missing" : "Good");

                using (SqlCommand insertLine = new SqlCommand(@"
INSERT dbo.ReturnInspectionItems
    (ReturnInspectionID, BookingItemID, QuantityExpected,
     QuantityReturned, QuantityDamaged, QuantityMissing,
     ConditionStatus, DamageNotes)
SELECT @InspectionID, bi.BookingItemID, @Expected,
       @Good + @Damaged, @Damaged, @Missing, @Condition, @Notes
FROM dbo.BookingItems AS bi
WHERE bi.BookingItemID = @BookingItemID
  AND bi.BookingID = @BookingID
  AND bi.Quantity = @Expected
  AND bi.IsPackageHeader = 0;",
                    connection, transaction))
                {
                    insertLine.Parameters.Add("@InspectionID", SqlDbType.BigInt)
                        .Value = inspectionID;
                    insertLine.Parameters.Add("@BookingItemID", SqlDbType.BigInt)
                        .Value = line.BookingItemID;
                    insertLine.Parameters.Add("@BookingID", SqlDbType.BigInt)
                        .Value = _collection.BookingID;
                    insertLine.Parameters.Add("@Expected", SqlDbType.Int)
                        .Value = line.Expected;
                    insertLine.Parameters.Add("@Good", SqlDbType.Int)
                        .Value = line.Good;
                    insertLine.Parameters.Add("@Damaged", SqlDbType.Int)
                        .Value = line.Damaged;
                    insertLine.Parameters.Add("@Missing", SqlDbType.Int)
                        .Value = line.Missing;
                    insertLine.Parameters.Add("@Condition", SqlDbType.NVarChar, 20)
                        .Value = condition;
                    insertLine.Parameters.Add("@Notes", SqlDbType.NVarChar, 1000)
                        .Value = String.IsNullOrWhiteSpace(line.Note)
                            ? (object)DBNull.Value
                            : line.Note;

                    if (insertLine.ExecuteNonQuery() != 1)
                    {
                        throw new InvalidOperationException(
                            "An equipment line no longer matches this booking.");
                    }
                }
            }

            return inspectionID;
        }

        private void InsertCollectionHandover(
            SqlConnection connection,
            SqlTransaction transaction,
            long inspectionID,
            string staffSignature,
            string customerSignature,
            string notes)
        {
            using (SqlCommand insert = new SqlCommand(@"
INSERT dbo.CollectionHandovers
    (BookingID, TaskID, ReturnInspectionID, StaffUserID,
     CollectionAt, StaffSignature, CustomerSignature,
     CustomerAcknowledged, Notes)
VALUES
    (@BookingID, @TaskID, @InspectionID, @StaffID,
     SYSUTCDATETIME(), @StaffSignature, @CustomerSignature,
     1, @Notes);",
                connection, transaction))
            {
                insert.Parameters.Add("@BookingID", SqlDbType.BigInt)
                    .Value = _collection.BookingID;
                insert.Parameters.Add("@TaskID", SqlDbType.BigInt)
                    .Value = _collection.TaskID;
                insert.Parameters.Add("@InspectionID", SqlDbType.BigInt)
                    .Value = inspectionID;
                insert.Parameters.Add("@StaffID", SqlDbType.Int)
                    .Value = CurrentStaffID;
                insert.Parameters.Add("@StaffSignature", SqlDbType.NVarChar, 150)
                    .Value = staffSignature;
                insert.Parameters.Add("@CustomerSignature", SqlDbType.NVarChar, 150)
                    .Value = customerSignature;
                insert.Parameters.Add("@Notes", SqlDbType.NVarChar, 1000)
                    .Value = String.IsNullOrWhiteSpace(notes)
                        ? (object)DBNull.Value
                        : notes;

                insert.ExecuteNonQuery();
            }
        }

        private void ShowMessage(string message)
        {
            litMessage.Text = HttpUtility.HtmlEncode(message);
            pnlMessage.Visible = true;
        }
    }
}