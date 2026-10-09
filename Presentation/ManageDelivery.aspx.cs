using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageDelivery : System.Web.UI.Page
    {
        private class DeliveryModel
        {
            public int DeliveryID { get; set; }
            public string BookingReference { get; set; }
            public string CustomerName { get; set; }
            public string Phone { get; set; }
            public DateTime ScheduledDate { get; set; }
            public string StreetAddress { get; set; }
            public string Suburb { get; set; }
            public string City { get; set; }
            public string PostalCode { get; set; }
            public string StaffName { get; set; }
            public string DeliveryStatus { get; set; }
        }

        private static List<DeliveryModel> deliveries =
            new List<DeliveryModel>
        {
        new DeliveryModel
        {
            DeliveryID = 1001,
            BookingReference = "FORTE-2026-00482",
            CustomerName = "Thandi Mokoena",
            Phone = "071 234 5678",
            ScheduledDate = new DateTime(2026, 9, 11),
            StreetAddress = "24 Willow Avenue",
            Suburb = "Sandton",
            City = "Johannesburg",
            PostalCode = "2196",
            StaffName = "Lebo Nkosi",
            DeliveryStatus = "Scheduled"
        },

        new DeliveryModel
        {
            DeliveryID = 1002,
            BookingReference = "FORTE-2026-00501",
            CustomerName = "Sipho Ndlovu",
            Phone = "082 345 6789",
            ScheduledDate = new DateTime(2026, 9, 8),
            StreetAddress = "12 Beacon Bay Drive",
            Suburb = "Beacon Bay",
            City = "East London",
            PostalCode = "5241",
            StaffName = "Mandla Dube",
            DeliveryStatus = "Delivered"
        },

        new DeliveryModel
        {
            DeliveryID = 1003,
            BookingReference = "FORTE-2026-00397",
            CustomerName = "John Smith",
            Phone = "083 456 7890",
            ScheduledDate = new DateTime(2026, 9, 5),
            StreetAddress = "15 Main Street",
            Suburb = "Sandton",
            City = "Johannesburg",
            PostalCode = "2196",
            StaffName = "Lebo Nkosi",
            DeliveryStatus = "Delivered"
        },

        new DeliveryModel
        {
            DeliveryID = 1004,
            BookingReference = "FORTE-2026-00512",
            CustomerName = "Ayanda Dlamini",
            Phone = "072 567 8901",
            ScheduledDate = new DateTime(2026, 9, 11),
            StreetAddress = "112 Oak Road",
            Suburb = "Randburg",
            City = "Johannesburg",
            PostalCode = "2194",
            StaffName = "Sibusiso Maseko",
            DeliveryStatus = "Scheduled"
        },

        new DeliveryModel
        {
            DeliveryID = 1005,
            BookingReference = "FORTE-2026-00425",
            CustomerName = "Nomsa Khumalo",
            Phone = "076 678 9012",
            ScheduledDate = new DateTime(2026, 9, 7),
            StreetAddress = "45 Main Road",
            Suburb = "Umhlanga",
            City = "Durban",
            PostalCode = "4319",
            StaffName = "Thabo Mokoena",
            DeliveryStatus = "Overdue"
        }
        };


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDeliveries();
            }
        }


        private void BindDeliveries()
        {
            var filteredDeliveries = deliveries.AsEnumerable();

            string searchText = txtSearch.Text.Trim();
            string selectedStatus = ddlStatus.SelectedValue;

            if (!string.IsNullOrEmpty(searchText))
            {
                filteredDeliveries = filteredDeliveries.Where(d =>
                    d.BookingReference
                        .IndexOf(searchText, StringComparison.OrdinalIgnoreCase) >= 0
                    ||
                    d.CustomerName
                        .IndexOf(searchText, StringComparison.OrdinalIgnoreCase) >= 0
                );
            }

            if (!string.IsNullOrEmpty(selectedStatus))
            {
                filteredDeliveries = filteredDeliveries.Where(d =>
                    d.DeliveryStatus == selectedStatus
                );
            }

            gvDeliveries.DataSource = filteredDeliveries.ToList();
            gvDeliveries.DataBind();
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvDeliveries.PageIndex = 0;
            BindDeliveries();
        }


        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlStatus.SelectedIndex = 0;

            gvDeliveries.PageIndex = 0;

            BindDeliveries();
        }


        protected void gvDeliveries_PageIndexChanging(
            object sender,
            GridViewPageEventArgs e)
        {
            gvDeliveries.PageIndex = e.NewPageIndex;

            BindDeliveries();
        }


        protected void gvDeliveries_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            BindDeliveries();
        }

        protected string GetStatusClass(string status)
        {
            switch (status) { case "Scheduled": return "status-scheduled"; case "Delivered": return "status-delivered"; case "Overdue": return "status-overdue"; default: return "status-default"; }
        }
    }
}