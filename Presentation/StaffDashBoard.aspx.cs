using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class StaffDashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindDashboard();
        }

        private void BindDashboard()
        {
            litStaffName.Text = HttpUtility.HtmlEncode(Convert.ToString(Session["UserName"]));
            litStaffRole.Text = HttpUtility.HtmlEncode(Convert.ToString(Session["UserRole"]));
            litScheduleDate.Text = DateTime.Today.ToString("dddd, d MMMM yyyy");

            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["ForteDB"];
            if (settings == null)
            {
                BindEmptyDashboard();
                return;
            }

            try
            {
                using (SqlConnection connection = new SqlConnection(settings.ConnectionString))
                {
                    connection.Open();
                    DateTime today = DateTime.Today;
                    DateTime tomorrow = today.AddDays(1);
                    DataTable schedule = new DataTable();

                    using (SqlCommand command = new SqlCommand(@"
SELECT CONVERT(nvarchar(5), t.ScheduledAt, 108) AS [Time],
       CASE WHEN t.TaskType = N'Delivery' THEN N'Delivery' ELSE N'Collection' END AS [Type],
       b.BookingReference AS BookingId,
       b.CustomerFullName AS Customer,
       COALESCE(NULLIF(t.TaskLocation, N''), b.DeliveryCity, b.DeliveryAddress, N'Address to be confirmed') AS Venue,
       t.TaskStatus AS [Status]
FROM dbo.BookingTasks AS t
INNER JOIN dbo.Bookings AS b ON b.BookingID = t.BookingID
WHERE t.ScheduledAt >= @Today AND t.ScheduledAt < @Tomorrow
  AND t.TaskStatus <> N'Cancelled'
ORDER BY t.ScheduledAt, b.BookingReference;", connection))
                    {
                        command.Parameters.Add("@Today", SqlDbType.DateTime2).Value = today;
                        command.Parameters.Add("@Tomorrow", SqlDbType.DateTime2).Value = tomorrow;
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command)) adapter.Fill(schedule);
                    }

                    litDeliveryCount.Text = CountTasks(connection, today, tomorrow, "Delivery").ToString();
                    litCollectionCount.Text = CountTasks(connection, today, tomorrow, "Company Collection", "Customer Collection").ToString();
                    litReturnsCount.Text = CountTasks(connection, today, tomorrow, "Return").ToString();
                    litAssignedCount.Text = CountTasks(connection, today, tomorrow).ToString();

                    rptSchedule.DataSource = schedule;
                    rptSchedule.DataBind();
                    pnlNoSchedule.Visible = schedule.Rows.Count == 0;

                    DataTable activity = LoadRecentActivity(connection);
                    rptActivity.DataSource = activity;
                    rptActivity.DataBind();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError("FEHMS staff dashboard load error: " + ex);
                BindEmptyDashboard();
            }
        }

        private int CountTasks(SqlConnection connection, DateTime from, DateTime to, params string[] taskTypes)
        {
            string typeClause = taskTypes.Length == 0 ? string.Empty : " AND TaskType IN (" + BuildTypeParameters(taskTypes.Length) + ")";
            using (SqlCommand command = new SqlCommand(@"
SELECT COUNT(DISTINCT BookingID)
FROM dbo.BookingTasks
WHERE ScheduledAt >= @From AND ScheduledAt < @To
  AND TaskStatus <> N'Cancelled'" + typeClause + ";", connection))
            {
                command.Parameters.Add("@From", SqlDbType.DateTime2).Value = from;
                command.Parameters.Add("@To", SqlDbType.DateTime2).Value = to;
                for (int index = 0; index < taskTypes.Length; index++)
                    command.Parameters.Add("@Type" + index, SqlDbType.NVarChar, 30).Value = taskTypes[index];
                return Convert.ToInt32(command.ExecuteScalar());
            }
        }

        private string BuildTypeParameters(int count)
        {
            string[] parameters = new string[count];
            for (int index = 0; index < count; index++) parameters[index] = "@Type" + index;
            return string.Join(",", parameters);
        }

        private DataTable LoadRecentActivity(SqlConnection connection)
        {
            using (SqlCommand command = new SqlCommand(@"
SELECT TOP (5)
       CASE WHEN t.TaskType IN (N'Company Collection', N'Customer Collection', N'Return') THEN N'bi-check-circle-fill' ELSE N'bi-truck' END AS Icon,
       CONCAT(b.BookingReference, N' was marked ', LOWER(t.TaskStatus)) AS Message,
       CASE
           WHEN DATEDIFF(minute, COALESCE(t.CompletedAt, t.UpdatedAt, t.CreatedAt), SYSDATETIME()) < 60
               THEN CONCAT(DATEDIFF(minute, COALESCE(t.CompletedAt, t.UpdatedAt, t.CreatedAt), SYSDATETIME()), N' minutes ago')
           WHEN DATEDIFF(hour, COALESCE(t.CompletedAt, t.UpdatedAt, t.CreatedAt), SYSDATETIME()) < 24
               THEN CONCAT(DATEDIFF(hour, COALESCE(t.CompletedAt, t.UpdatedAt, t.CreatedAt), SYSDATETIME()), N' hours ago')
           ELSE CONVERT(nvarchar(20), COALESCE(t.CompletedAt, t.UpdatedAt, t.CreatedAt), 106)
       END AS [When]
FROM dbo.BookingTasks AS t
INNER JOIN dbo.Bookings AS b ON b.BookingID = t.BookingID
WHERE t.TaskStatus IN (N'Delivered', N'Collected', N'Completed')
ORDER BY COALESCE(t.CompletedAt, t.UpdatedAt, t.CreatedAt) DESC;", connection))
            {
                DataTable activity = new DataTable();
                using (SqlDataAdapter adapter = new SqlDataAdapter(command)) adapter.Fill(activity);
                return activity;
            }
        }

        private void BindEmptyDashboard()
        {
            litDeliveryCount.Text = "0";
            litCollectionCount.Text = "0";
            litReturnsCount.Text = "0";
            litAssignedCount.Text = "0";
            rptSchedule.DataSource = new DataTable();
            rptSchedule.DataBind();
            rptActivity.DataSource = new DataTable();
            rptActivity.DataBind();
            pnlNoSchedule.Visible = true;
        }

        protected string StatusBadge(object status)
        {
            string value = Convert.ToString(status);
            if (value == "Completed" || value == "Delivered" || value == "Collected") return "badge-success";
            if (value == "Out for Delivery") return "badge-forte";
            if (value == "Overdue") return "badge-danger";
            return "badge-warning";
        }
    }
}
