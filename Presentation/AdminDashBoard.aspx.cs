using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class AdminDashBoard : System.Web.UI.Page
    {
        private static readonly CultureInfo SouthAfricanCulture =
            CultureInfo.GetCultureInfo("en-ZA");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDashboard();
            }
        }

        private void BindDashboard()
        {
            litAdminName.Text = Server.HtmlEncode(
                Convert.ToString(Session["UserName"] ?? "Administrator"));

            litToday.Text = DateTime.Today.ToString(
                "dddd, dd MMMM yyyy", SouthAfricanCulture);

            pnlMessage.Visible = false;

            // Static sample metrics for checking the dashboard layout.
            litTotalBookings.Text = "125";
            litPendingBookings.Text = "18";
            litUpcoming.Text = "12";
            litActiveStaff.Text = "10";
            litRentalItems.Text = "320";
            litRevenue.Text = FormatRands(84500m, 0);
            litPendingPayments.Text = FormatRands(22000m, 0);
            litUnassignedTasks.Text = "5";

            BindUpcomingEvents();
            BindRevenue();
            BindOperations();
            BindLowInventory();
        }

        private void BindUpcomingEvents()
        {
            DataTable rows = new DataTable();
            rows.Columns.Add("EventDate", typeof(DateTime));
            rows.Columns.Add("EventType", typeof(string));
            rows.Columns.Add("CustomerFullName", typeof(string));
            rows.Columns.Add("BookingStatus", typeof(string));
            rows.Columns.Add("StatusCss", typeof(string));

            AddEvent(rows, DateTime.Today.AddDays(1),
                "Wedding", "Amina Dlamini", "Confirmed");
            AddEvent(rows, DateTime.Today.AddDays(3),
                "Birthday Party", "Kabelo Mokoena", "Pending");
            AddEvent(rows, DateTime.Today.AddDays(6),
                "Engagement", "Lerato Nkosi", "Confirmed");
            AddEvent(rows, DateTime.Today.AddDays(10),
                "Corporate Event", "Sipho Mthembu", "Pending");

            rptUpcoming.DataSource = rows;
            rptUpcoming.DataBind();
            pnlNoUpcoming.Visible = rows.Rows.Count == 0;
        }

        private static void AddEvent(
            DataTable rows,
            DateTime date,
            string eventType,
            string customer,
            string status)
        {
            rows.Rows.Add(date, eventType, customer, status, StatusCss(status));
        }

        private void BindRevenue()
        {
            string[] months =
                { "May", "June", "July", "August", "September", "October" };

            decimal[] amounts =
                { 11200m, 16800m, 21900m, 25750m, 30100m, 84500m };

            decimal maxAmount = 0m;

            foreach (decimal amount in amounts)
            {
                if (amount > maxAmount)
                {
                    maxAmount = amount;
                }
            }

            DataTable rows = new DataTable();
            rows.Columns.Add("MonthLabel", typeof(string));
            rows.Columns.Add("AmountLabel", typeof(string));
            rows.Columns.Add("BarHeight", typeof(int));

            for (int i = 0; i < months.Length; i++)
            {
                int barHeight = maxAmount == 0m
                    ? 0
                    : Math.Max(5, (int)Math.Round(amounts[i] / maxAmount * 100m));

                rows.Rows.Add(
                    months[i],
                    FormatRands(amounts[i], 0),
                    barHeight);
            }

            rptRevenue.DataSource = rows;
            rptRevenue.DataBind();
        }

        private void BindOperations()
        {
            DataTable rows = new DataTable();
            rows.Columns.Add("BookingReference", typeof(string));
            rows.Columns.Add("CustomerFullName", typeof(string));
            rows.Columns.Add("TaskType", typeof(string));
            rows.Columns.Add("ScheduledAt", typeof(DateTime));
            rows.Columns.Add("StaffName", typeof(string));

            rows.Rows.Add(
                "FEH-DEMO-001", "Amina Dlamini", "Delivery",
                DateTime.Today.AddDays(1).AddHours(7), "Thando Nkosi");

            rows.Rows.Add(
                "FEH-DEMO-002", "Kabelo Mokoena", "Company Collection",
                DateTime.Today.AddDays(2).AddHours(18), "Zwelethu Makhubela");

            rows.Rows.Add(
                "FEH-DEMO-003", "Lerato Nkosi", "Delivery",
                DateTime.Today.AddDays(3).AddHours(8), "Unassigned");

            rptOperations.DataSource = rows;
            rptOperations.DataBind();
            pnlNoOperations.Visible = rows.Rows.Count == 0;
        }

        private void BindLowInventory()
        {
            DataTable rows = new DataTable();
            rows.Columns.Add("ProductName", typeof(string));
            rows.Columns.Add("Category", typeof(string));
            rows.Columns.Add("QuantityAvailable", typeof(int));
            rows.Columns.Add("Price", typeof(decimal));

            rows.Rows.Add("Round table", "Tables", 4, 650m);
            rows.Rows.Add("White marquee", "Tents", 2, 15000m);
            rows.Rows.Add("Gold centrepiece", "Décor", 5, 850m);

            rptLowStock.DataSource = rows;
            rptLowStock.DataBind();
            pnlNoLowStock.Visible = rows.Rows.Count == 0;
        }

        public string FormatRands(object value)
        {
            decimal amount;

            if (value == null ||
                value == DBNull.Value ||
                !Decimal.TryParse(Convert.ToString(value), out amount))
            {
                amount = 0m;
            }

            return FormatRands(amount, 2);
        }

        private static string FormatRands(decimal amount, int decimalPlaces)
        {
            return "R " + amount.ToString(
                decimalPlaces == 0 ? "N0" : "N2",
                SouthAfricanCulture);
        }

        private static string StatusCss(string status)
        {
            if (status == "Confirmed") return "badge text-bg-success";
            if (status == "Pending") return "badge text-bg-warning";
            if (status == "Cancelled") return "badge text-bg-secondary";

            return "badge text-bg-primary";
        }
    }
}