using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class CustomerDashboard : Page
    {
        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["ForteDB"].ConnectionString;
            }
        }

        private class DashboardBooking
        {
            public int OrderID { get; set; }
            public string BookingReference { get; set; }
            public string EventDate { get; set; }
            public string BookingStatus { get; set; }
            public decimal PaymentAmount { get; set; }
            public int TotalQuantity { get; set; }
            public string ItemsSummary { get; set; }
            public string DownloadId { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                try
                {
                    List<DashboardBooking> bookings = GetCustomerBookings();

                    string customerName = GetCustomerName();

                    lblCustomerName.Text =
                        Server.HtmlEncode(customerName);

                    string[] activeStatuses =
                    {
                        "Pending",
                        "Confirmed",
                        "Preparing",
                        "Out for Delivery",
                        "Delivered",
                        "Ready for Collection",
                        "Collected"
                    };

                    lblActiveBookings.Text = bookings.Count(
                        b => activeStatuses.Contains(
                            b.BookingStatus,
                            StringComparer.OrdinalIgnoreCase))
                        .ToString();

                    // Total amount recorded as paid for the customer's orders.
                    lblOutstandingBalance.Text = bookings
                        .Sum(b => b.PaymentAmount)
                        .ToString("N2");

                    lblItemsHired.Text = bookings
                        .Sum(b => b.TotalQuantity)
                        .ToString();

                    rptBookings.DataSource = bookings;
                    rptBookings.DataBind();

                    pnlNoBookings.Visible = bookings.Count == 0;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Trace.TraceError(
                        "Customer dashboard error: " + ex);

                    pnlNoBookings.Visible = true;
                }
            }
        }

        private string GetCustomerName()
        {
            string name = Convert.ToString(Session["UserName"]);

            if (!string.IsNullOrWhiteSpace(name))
                return name;

            using (SqlConnection connection =
                   new SqlConnection(ConnectionString))
            {
                string sql = @"
                    SELECT TOP 1 u.FullName
                    FROM dbo.Users u
                    INNER JOIN dbo.Customer c
                        ON c.UserID = u.UserID
                    WHERE u.UserID = @UserID";

                using (SqlCommand command =
                       new SqlCommand(sql, connection))
                {
                    command.Parameters.Add("@UserID", SqlDbType.Int)
                        .Value = Convert.ToInt32(Session["UserID"]);

                    connection.Open();

                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                        return Convert.ToString(result);
                }
            }

            return "Customer";
        }

        private List<DashboardBooking> GetCustomerBookings()
        {
            List<DashboardBooking> bookings =
                new List<DashboardBooking>();

            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection connection =
                   new SqlConnection(ConnectionString))
            {
                connection.Open();

                string orderSql = @"
                    SELECT
                        o.OrderID,
                        o.EventDate,
                        o.Status,
                        o.TotalAmount,
                        ISNULL(p.PaidAmount, 0) AS PaidAmount
                    FROM dbo.[Order] o
                    INNER JOIN dbo.Customer c
                        ON c.CustomerID = o.CustomerID
                    LEFT JOIN
                    (
                        SELECT
                            OrderID,
                            SUM(Amount) AS PaidAmount
                        FROM dbo.Payment
                        WHERE Status = 'Paid'
                        GROUP BY OrderID
                    ) p ON p.OrderID = o.OrderID
                    WHERE c.UserID = @UserID
                    ORDER BY o.OrderDate DESC, o.OrderID DESC";

                using (SqlCommand command =
                       new SqlCommand(orderSql, connection))
                {
                    command.Parameters.Add("@UserID", SqlDbType.Int)
                        .Value = userID;

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int orderID =
                                Convert.ToInt32(reader["OrderID"]);

                            string eventDate = "Not provided";

                            if (reader["EventDate"] != DBNull.Value)
                            {
                                eventDate = Convert.ToDateTime(
                                    reader["EventDate"]).ToString("dd MMM yyyy");
                            }

                            bookings.Add(new DashboardBooking
                            {
                                OrderID = orderID,
                                BookingReference = "ORD-" + orderID,
                                EventDate = eventDate,
                                BookingStatus =
                                    Convert.ToString(reader["Status"]),
                                PaymentAmount =
                                    Convert.ToDecimal(reader["PaidAmount"]),
                                TotalQuantity = 0,
                                ItemsSummary = "",
                                DownloadId = orderID.ToString()
                            });
                        }
                    }
                }

                // Load the products belonging to each order.
                string itemsSql = @"
                    SELECT
                        oi.OrderID,
                        oi.ItemNameSnapshot,
                        oi.Quantity
                    FROM dbo.OrderItem oi
                    INNER JOIN dbo.[Order] o
                        ON o.OrderID = oi.OrderID
                    INNER JOIN dbo.Customer c
                        ON c.CustomerID = o.CustomerID
                    WHERE c.UserID = @UserID
                    ORDER BY oi.OrderID DESC, oi.OrderItemID";

                using (SqlCommand command =
                       new SqlCommand(itemsSql, connection))
                {
                    command.Parameters.Add("@UserID", SqlDbType.Int)
                        .Value = userID;

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int orderID =
                                Convert.ToInt32(reader["OrderID"]);

                            DashboardBooking booking = bookings
                                .FirstOrDefault(b => b.OrderID == orderID);

                            if (booking == null)
                                continue;

                            int quantity = Convert.ToInt32(
                                reader["Quantity"]);

                            string itemName = Convert.ToString(
                                reader["ItemNameSnapshot"]);

                            booking.TotalQuantity += quantity;

                            if (string.IsNullOrWhiteSpace(booking.ItemsSummary))
                            {
                                booking.ItemsSummary =
                                    quantity + " × " + itemName;
                            }
                            else
                            {
                                booking.ItemsSummary += ", " +
                                    quantity + " × " + itemName;
                            }
                        }
                    }
                }
            }

            return bookings;
        }

        protected string GetStatusBadgeClass(string status)
        {
            switch ((status ?? "").Trim().ToLowerInvariant())
            {
                case "pending":
                case "preparing":
                    return "bg-warning text-dark";

                case "confirmed":
                    return "bg-primary";

                case "out for delivery":
                case "ready for collection":
                case "delivered":
                case "collected":
                    return "bg-info text-dark";

                case "completed":
                case "returned":
                    return "bg-success";

                case "cancelled":
                    return "bg-danger";

                default:
                    return "bg-secondary";
            }
        }
    }
}
