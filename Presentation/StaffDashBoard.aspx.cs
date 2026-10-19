using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class StaffDashBoard : System.Web.UI.Page
    {

        // Demo records have the same simple shape a SQL repository can return later.
        private sealed class ScheduleItem
        {
            public string Time { get; set; }
            public string Type { get; set; }
            public string BookingId { get; set; }
            public string Customer { get; set; }
            public string Venue { get; set; }
            public string Status { get; set; }
        }

        private sealed class ActivityItem
        {
            public string Icon { get; set; }
            public string Message { get; set; }
            public string When { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindDashboard();
        }

        private void BindDashboard()
        {
            DateTime today = DateTime.Today;
            List<ScheduleItem> schedule = GetDemoSchedule();
            litStaffName.Text = "Thando Ndlovu";
            litStaffRole.Text = "Delivery Staff";
            litDeliveryCount.Text = schedule.Count(x => x.Type == "Delivery").ToString();
            litCollectionCount.Text = schedule.Count(x => x.Type == "Collection").ToString();
            litReturnsCount.Text = "1";
            litAssignedCount.Text = schedule.Count.ToString();
            litScheduleDate.Text = today.ToString("dddd, d MMMM yyyy");

            rptSchedule.DataSource = schedule.OrderBy(x => x.Time).ToList();
            rptSchedule.DataBind();
            pnlNoSchedule.Visible = schedule.Count == 0;

            rptActivity.DataSource = GetDemoActivity();
            rptActivity.DataBind();
        }

        // Replace this method with a repository call when the SQL schema is ready.
        // Keep the returned properties aligned with the ScheduleItem model and the UI stays unchanged.
        private List<ScheduleItem> GetDemoSchedule()
        {
            return new List<ScheduleItem>
            {
                new ScheduleItem { Time = "08:00", Type = "Delivery", BookingId = "BK001", Customer = "Sipho Mthembu", Venue = "Montecasino", Status = "Pending" },
                new ScheduleItem { Time = "11:00", Type = "Delivery", BookingId = "BK004", Customer = "Nandini Pillay", Venue = "Sandton", Status = "Out for Delivery" },
                new ScheduleItem { Time = "14:00", Type = "Collection", BookingId = "BK002", Customer = "Lerato Tau", Venue = "Midrand", Status = "Pending" },
                new ScheduleItem { Time = "16:00", Type = "Collection", BookingId = "BK007", Customer = "Grace Chuma", Venue = "Parktown", Status = "Scheduled" }
            };
        }

        private List<ActivityItem> GetDemoActivity()
        {
            return new List<ActivityItem>
            {
                new ActivityItem { Icon = "bi-check-circle-fill", Message = "BK006 was marked as collected", When = "20 minutes ago" },
                new ActivityItem { Icon = "bi-truck", Message = "BK004 is out for delivery", When = "1 hour ago" },
                new ActivityItem { Icon = "bi-calendar-plus", Message = "A new booking was assigned", When = "3 hours ago" }
            };
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
