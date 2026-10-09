using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageCollection : System.Web.UI.Page
    {
        private class CollectionModel
        {
            public int OrderID { get; set; }
            public string BookingReference { get; set; }
            public string CustomerName { get; set; }
            public string Address { get; set; }
            public string ItemsSummary { get; set; }
            public DateTime DeliveryDate { get; set; }
            public DateTime CollectionDueDate { get; set; }
            public string Status { get; set; }
        }

        private static readonly DateTime staticToday =
            new DateTime(2026, 9, 10);

        private static List<CollectionModel> staticCollections =
            new List<CollectionModel>
        {
            new CollectionModel
            {
                OrderID = 482,
                BookingReference = "FORTE-2026-00482",
                CustomerName = "Thandi Mokoena",
                Address = "24 Willow Avenue, Sandton",
                ItemsSummary = "Stretch Tent, 30 Chairs",
                DeliveryDate = new DateTime(2026, 9, 11),
                CollectionDueDate = new DateTime(2026, 9, 13),
                Status = "Awaiting Collection"
            },

            new CollectionModel
            {
                OrderID = 501,
                BookingReference = "FORTE-2026-00501",
                CustomerName = "Sipho Ndlovu",
                Address = "12 Beacon Bay Drive, Beacon Bay",
                ItemsSummary = "Ambient Lights, Sound System",
                DeliveryDate = new DateTime(2026, 9, 8),
                CollectionDueDate = new DateTime(2026, 9, 9),
                Status = "Overdue"
            },

            new CollectionModel
            {
                OrderID = 397,
                BookingReference = "FORTE-2026-00397",
                CustomerName = "John Smith",
                Address = "15 Main Street, Sandton",
                ItemsSummary = "50 Chairs, 5 Tables, 1 Tent",
                DeliveryDate = new DateTime(2026, 9, 5),
                CollectionDueDate = new DateTime(2026, 9, 10),
                Status = "Collected"
            },

            new CollectionModel
            {
                OrderID = 512,
                BookingReference = "FORTE-2026-00512",
                CustomerName = "Ayanda Dlamini",
                Address = "112 Oak Road, Randburg",
                ItemsSummary = "12 Tables, 80 Crockery Sets",
                DeliveryDate = new DateTime(2026, 9, 9),
                CollectionDueDate = new DateTime(2026, 9, 11),
                Status = "Awaiting Collection"
            }
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
                BindCollections();
            }
        }

        private void LoadStats()
        {
            lblAwaitingCount.Text =
                staticCollections
                .Count(c => c.Status == "Awaiting Collection")
                .ToString();

            lblOverdueCount.Text =
                staticCollections
                .Count(c => c.Status == "Overdue")
                .ToString();

            lblCollectedTodayCount.Text =
                staticCollections
                .Count(c =>
                    c.Status == "Collected" &&
                    c.CollectionDueDate.Date == staticToday.Date)
                .ToString();
        }

        private void BindCollections()
        {
            var ordered = staticCollections
                .OrderBy(c => c.Status == "Collected")
                .ThenBy(c => c.CollectionDueDate)
                .ToList();

            if (ordered.Count > 0)
            {
                rptCollections.DataSource = ordered;
                rptCollections.DataBind();

                pnlNoCollections.Visible = false;
            }
            else
            {
                rptCollections.DataSource = null;
                rptCollections.DataBind();

                pnlNoCollections.Visible = true;
            }
        }

        protected void rptCollections_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "MarkCollected")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);

                var item = staticCollections
                    .FirstOrDefault(c => c.OrderID == orderId);

                if (item != null)
                {
                    item.Status = "Collected";

                    ShowMessage(
                        $"Order {item.BookingReference} marked as collected.");
                }
            }

            LoadStats();
            BindCollections();
        }

        private void ShowMessage(string message)
        {
            pnlMessage.Visible = true;
            lblStatusMessage.Text = message;
        }

        protected string GetStatusBadgeClass(string status)
        {
            switch (status)
            {
                case "Awaiting Collection":
                    return "status-awaiting";

                case "Overdue":
                    return "status-overdue";

                case "Collected":
                    return "status-collected";

                default:
                    return "status-awaiting";
            }
        }
    }
}