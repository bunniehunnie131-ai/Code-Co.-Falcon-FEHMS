using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable cart = GetCart();
            if (cart.Rows.Count == 0)
            {
                Response.Redirect("Cart.aspx");
                return;
            }

            txtEventDate.Attributes["min"] = DateTime.Today.ToString("yyyy-MM-dd");

            if (!IsPostBack)
            {
                RestoreCheckoutData();
            }

            LoadCartSummary();
        }

        private DataTable GetCart()
        {
            DataTable cart = Session["ShoppingCart"] as DataTable;
            if (cart == null)
            {
                cart = new DataTable();
                cart.Columns.Add("ProductId", typeof(int));
                cart.Columns.Add("Name", typeof(string));
                cart.Columns.Add("Colour", typeof(string));
                cart.Columns.Add("UnitPrice", typeof(decimal));
                cart.Columns.Add("Quantity", typeof(int));
                cart.Columns.Add("ImageUrl", typeof(string));
                Session["ShoppingCart"] = cart;
            }
            return cart;
        }

        private void LoadCartSummary()
        {
            DataTable cart = GetCart();
            rptCheckout.DataSource = cart;
            rptCheckout.DataBind();

            int items = 0;
            decimal subtotal = 0m;
            foreach (DataRow row in cart.Rows)
            {
                int q = Convert.ToInt32(row["Quantity"]);
                decimal p = Convert.ToDecimal(row["UnitPrice"]);
                items += q;
                subtotal += p * q;
            }
            lblTotalItems.Text = items.ToString();
            lblTotalPrice.Text = "R" + subtotal.ToString("N2");
        }

        private void RestoreCheckoutData()
        {
            if (Session["EventDate"] != null) txtEventDate.Text = Session["EventDate"].ToString();
            if (Session["EventNotes"] != null) txtEventNotes.Text = Session["EventNotes"].ToString();
            string type = Session["EventType"] == null ? "" : Session["EventType"].ToString();
            if (ddlEventType.Items.FindByValue(type) != null) ddlEventType.SelectedValue = type;
        }

        private bool ValidateCheckout()
        {
            lblMessage.Visible = false;
            DateTime eventDate;

            if (string.IsNullOrWhiteSpace(txtEventDate.Text)) return Error("Please select the event date.");
            if (!DateTime.TryParse(txtEventDate.Text, out eventDate)) return Error("Please select a valid event date.");
            if (eventDate.Date < DateTime.Today) return Error("The event date cannot be in the past.");
            if (string.IsNullOrWhiteSpace(ddlEventType.SelectedValue)) return Error("Please select the event type.");
            return true;
        }

        private bool Error(string message)
        {
            lblMessage.Text = message;
            lblMessage.Visible = true;
            return false;
        }

        private decimal CalculateSubtotal()
        {
            decimal total = 0m;
            foreach (DataRow row in GetCart().Rows)
                total += Convert.ToDecimal(row["UnitPrice"]) * Convert.ToInt32(row["Quantity"]);
            return total;
        }

        protected void btnContinueToExtras_Click(object sender, EventArgs e)
        {
            if (!ValidateCheckout()) return;

            Session["EventDate"] = txtEventDate.Text;
            Session["EventType"] = ddlEventType.SelectedValue;
            Session["EventNotes"] = txtEventNotes.Text.Trim();
            Session["BookingTotal"] = CalculateSubtotal();

            if (Session["BookingReference"] == null)
                Session["BookingReference"] = "FEH-" + DateTime.Now.ToString("yyyyMMdd") + "-" + Guid.NewGuid().ToString("N").Substring(0, 6).ToUpper();

            Response.Redirect("DeliveryandExtras.aspx");
        }

        protected void btnBackToCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }
    }
}
