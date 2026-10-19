using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class CustomerDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindDashboard();
        }

        private void BindDashboard()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string customerName = Convert.ToString(Session["UserName"]);
            lblCustomerName.Text = HttpUtility.HtmlEncode(string.IsNullOrWhiteSpace(customerName) ? "Customer" : customerName);

            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["ForteDB"];
            if (settings == null)
            {
                ShowDataError("The ForteDB connection is not configured.");
                return;
            }

            try
            {
                using (SqlConnection connection = new SqlConnection(settings.ConnectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(@"
SELECT b.BookingID AS DownloadId,
       b.BookingReference,
       CONVERT(nvarchar(20), b.EventDate, 106) AS EventDate,
       b.BookingStatus,
       ISNULL((SELECT SUM(p.Amount) FROM dbo.Payments AS p WHERE p.BookingID = b.BookingID AND p.PaymentStatus = N'Paid'), 0) AS PaymentAmount,
       ISNULL(STUFF((
           SELECT N', ' + CONVERT(nvarchar(10), bi.Quantity) + N' × ' + bi.ProductName
           FROM dbo.BookingItems AS bi
           WHERE bi.BookingID = b.BookingID
           ORDER BY bi.ProductName
           FOR XML PATH(''), TYPE).value('.', 'nvarchar(max)'), 1, 2, N''), N'No items recorded') AS ItemsSummary
FROM dbo.Bookings AS b
WHERE b.CustomerUserID = @UserID
ORDER BY b.CreatedAt DESC;", connection))
                    {
                        command.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                        DataTable bookings = new DataTable();
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command)) adapter.Fill(bookings);
                        rptBookings.DataSource = bookings;
                        rptBookings.DataBind();
                        pnlNoBookings.Visible = bookings.Rows.Count == 0;
                    }

                    lblActiveBookings.Text = ScalarCount(connection, @"
SELECT COUNT(1) FROM dbo.Bookings
WHERE CustomerUserID = @UserID AND BookingStatus IN (N'Pending', N'Confirmed');", userId).ToString();

                    decimal totalPaid = ScalarDecimal(connection, @"
SELECT ISNULL(SUM(p.Amount), 0)
FROM dbo.Payments AS p
INNER JOIN dbo.Bookings AS b ON b.BookingID = p.BookingID
WHERE b.CustomerUserID = @UserID AND p.PaymentStatus = N'Paid';", userId);
                    lblOutstandingBalance.Text = totalPaid.ToString("N2");

                    lblItemsHired.Text = ScalarCount(connection, @"
SELECT ISNULL(SUM(bi.Quantity), 0)
FROM dbo.BookingItems AS bi
INNER JOIN dbo.Bookings AS b ON b.BookingID = bi.BookingID
WHERE b.CustomerUserID = @UserID AND b.BookingStatus <> N'Cancelled';", userId).ToString();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError("FEHMS customer dashboard load error: " + ex);
                ShowDataError("Your booking information could not be loaded. Please refresh the page.");
            }
        }

        private int ScalarCount(SqlConnection connection, string sql, int userId)
        {
            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                return Convert.ToInt32(command.ExecuteScalar());
            }
        }

        private decimal ScalarDecimal(SqlConnection connection, string sql, int userId)
        {
            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                return Convert.ToDecimal(command.ExecuteScalar());
            }
        }

        private void ShowDataError(string message)
        {
            lblDashboardMessage.Text = HttpUtility.HtmlEncode(message);
            lblDashboardMessage.Visible = true;
            pnlNoBookings.Visible = false;
        }

        protected string GetStatusBadgeClass(string status)
        {
            if (string.Equals(status, "Confirmed", StringComparison.OrdinalIgnoreCase) ||
                string.Equals(status, "Completed", StringComparison.OrdinalIgnoreCase)) return "badge-success";
            if (string.Equals(status, "Cancelled", StringComparison.OrdinalIgnoreCase)) return "badge-danger";
            return "badge-warning";
        }
    }
}
