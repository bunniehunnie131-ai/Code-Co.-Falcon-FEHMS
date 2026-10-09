using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private DataTable GetCart()
        {
            if (Session["ShoppingCart"] == null)
            {
                DataTable cart = new DataTable();

                cart.Columns.Add("ProductId", typeof(int));
                cart.Columns.Add("Name", typeof(string));
                cart.Columns.Add("Colour", typeof(string));
                cart.Columns.Add("UnitPrice", typeof(decimal));
                cart.Columns.Add("Quantity", typeof(int));
                cart.Columns.Add("ImageUrl", typeof(string));

                Session["ShoppingCart"] = cart;
            }

            return (DataTable)Session["ShoppingCart"];
        }

        private void LoadCart()
        {
            DataTable cart = GetCart();

            rptCart.DataSource = cart;
            rptCart.DataBind();

            int productCount = cart.Rows.Count;
            int totalItems = 0;
            decimal totalPrice = 0m;

            foreach (DataRow row in cart.Rows)
            {
                int quantity = Convert.ToInt32(row["Quantity"]);
                decimal unitPrice = Convert.ToDecimal(row["UnitPrice"]);

                totalItems += quantity;
                totalPrice += unitPrice * quantity;
            }

            lblProductCount.Text = productCount.ToString();
            lblTotalItems.Text = totalItems.ToString();
            lblTotalPrice.Text = "R" + totalPrice.ToString("N2");

            pnlEmptyCart.Visible = cart.Rows.Count == 0;
            rptCart.Visible = cart.Rows.Count > 0;
            btnCheckout.Enabled = cart.Rows.Count > 0;
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int index;

            if (!int.TryParse(e.CommandArgument.ToString(), out index))
            {
                return;
            }

            DataTable cart = GetCart();

            if (index < 0 || index >= cart.Rows.Count)
            {
                return;
            }

            if (e.CommandName == "Increase")
            {
                int quantity = Convert.ToInt32(cart.Rows[index]["Quantity"]);
                cart.Rows[index]["Quantity"] = quantity + 1;
            }
            else if (e.CommandName == "Decrease")
            {
                int quantity = Convert.ToInt32(cart.Rows[index]["Quantity"]);

                if (quantity > 1)
                {
                    cart.Rows[index]["Quantity"] = quantity - 1;
                }
                else
                {
                    cart.Rows.RemoveAt(index);
                }
            }
            else if (e.CommandName == "Remove")
            {
                cart.Rows.RemoveAt(index);
            }

            Session["ShoppingCart"] = cart;
            LoadCart();
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("Catelogue.aspx");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            DataTable cart = GetCart();

            if (cart.Rows.Count == 0)
            {
                LoadCart();
                return;
            }

            Response.Redirect("Checkout.aspx");
        }
    }
}