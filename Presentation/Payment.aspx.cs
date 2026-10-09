using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable cart = Session["ShoppingCart"] as DataTable;
            if (cart == null || cart.Rows.Count == 0 || Session["GrandTotal"] == null)
            {
                Response.Redirect("Cart.aspx"); 
                return;


            }

            if (!IsPostBack)
            {
                txtCardHolder.Text = Get("CustomerFullName", "");
            }

            LoadSummary();
        }

        private string Get(string key, string fallback)
        {
            return Session[key] == null || string.IsNullOrWhiteSpace(Session[key].ToString()) ? fallback : Session[key].ToString();
        }

        private decimal Money(string key)
        {
            decimal value;
            return Session[key] != null && decimal.TryParse(Session[key].ToString(), out value) ? value : 0m;
        }

        private int Qty(string key)
        {
            int value;
            return Session[key] != null && int.TryParse(Session[key].ToString(), out value) ? value : 0;
        }

        private void LoadSummary()
        {
            DataTable cart = Session["ShoppingCart"] as DataTable;
            rptItems.DataSource = cart;
            rptItems.DataBind();

            lblEventDate.Text = Get("EventDate", "Not provided");
            lblEventType.Text = Get("EventType", "Not provided");
            lblEventNotes.Text = Get("EventNotes", "None");
            lblCustomer.Text = Get("CustomerFullName", "Not provided");
            lblEmail.Text = Get("CustomerEmail", "Not provided");
            lblPhone.Text = Get("CustomerPhone", "Not provided");

            string method = Get("TransportMethod", "Not provided");
            lblTransportMethod.Text = method;
            if (method == "Forte Delivery & Collection")
            {
                lblAddress.Text = JoinAddress();
                lblFirstTime.Text = Get("DeliveryDate", "-") + " at " + Get("DeliveryTime", "-");
                lblSecondTime.Text = Get("CollectionDate", "-") + " at " + Get("CollectionTime", "-");
            }
            else
            {
                lblAddress.Text = "Forte Event Hire collection / return point";
                lblFirstTime.Text = Get("CustomerCollectionDate", "-") + " at " + Get("CustomerCollectionTime", "-");
                lblSecondTime.Text = Get("ReturnDate", "-") + " at " + Get("ReturnTime", "-");
            }

            lblSetup.Text = Convert.ToBoolean(Session["SetupRequired"] ?? false) ? "Yes" : "No";
            lblProviders.Text = ProviderHtml();

            lblItemTotal.Text = "R" + Money("BookingTotal").ToString("N2");
            lblDeliveryFee.Text = "R" + Money("DeliveryFee").ToString("N2");
            lblSetupFee.Text = "R" + Money("SetupFee").ToString("N2");
            lblProviderFee.Text = "R" + Money("ProviderFee").ToString("N2");
            lblTotalDue.Text = "R" + Money("GrandTotal").ToString("N2");
        }

        private string JoinAddress()
        {
            string[] parts = { Get("DeliveryAddress", ""), Get("DeliveryCity", ""), Get("DeliveryProvince", ""), Get("DeliveryPostalCode", "") };
            return string.Join(", ", Array.FindAll(parts, x => !string.IsNullOrWhiteSpace(x)));
        }

        private string ProviderHtml()
        {
            StringBuilder s = new StringBuilder();
            AddProvider(s, "DJ", Qty("DJQty")); AddProvider(s, "Caterer", Qty("CatererQty")); AddProvider(s, "Bartender", Qty("BartenderQty")); AddProvider(s, "Waiter", Qty("WaiterQty")); AddProvider(s, "Clown", Qty("ClownQty")); AddProvider(s, "Photographer", Qty("PhotographerQty"));
            return s.Length == 0 ? "No service providers selected." : s.ToString();
        }

        private void AddProvider(StringBuilder s, string name, int qty)
        {
            if (qty > 0) s.Append("<span class='chip'>" + qty + " × " + name + " = R" + (qty * 100m).ToString("N2") + "</span>");
        }

        private bool ValidatePayment()
        {
            lblMessage.Visible = false;
            if (string.IsNullOrWhiteSpace(ddlBankName.SelectedValue)) return Error("Please select the bank name.");
            if (string.IsNullOrWhiteSpace(txtCardHolder.Text)) return Error("Please enter the card holder name.");

            string card = DigitsOnly(txtCardNumber.Text);
            if (card.Length != 16) return Error("Please enter a 16-digit card number.");
            if (DigitsOnly(txtCVV.Text).Length != 3) return Error("Please enter a 3-digit CVV.");

            DateTime expiry;
            if (!TryExpiry(txtExpiry.Text, out expiry)) return Error("Please enter a valid expiry date in MM/YY format.");
            if (expiry < new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1)) return Error("The card has expired.");
            return true;
        }

        private string DigitsOnly(string value)
        {
            StringBuilder b = new StringBuilder();
            foreach (char c in value ?? "") if (char.IsDigit(c)) b.Append(c);
            return b.ToString();
        }

        private bool TryExpiry(string value, out DateTime expiry)
        {
            expiry = DateTime.MinValue;
            DateTime parsed;
            if (!DateTime.TryParseExact(value, "MM/yy", CultureInfo.InvariantCulture, DateTimeStyles.None, out parsed)) return false;
            expiry = new DateTime(parsed.Year, parsed.Month, DateTime.DaysInMonth(parsed.Year, parsed.Month));
            return true;
        }

        private bool Error(string message)
        {
            lblMessage.Text = message; lblMessage.Visible = true; return false;
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            if (!ValidatePayment()) return;

            DataTable cart = Session["ShoppingCart"] as DataTable;
            Session["ConfirmedBookingItems"] = cart.Copy();
            Session["PaymentStatus"] = "Paid";
            Session["BookingStatus"] = "Confirmed";
            Session["PaymentAmount"] = Money("GrandTotal");
            Session["PaymentBank"] = ddlBankName.SelectedValue;
            string card = DigitsOnly(txtCardNumber.Text);
            Session["PaymentCardLast4"] = card.Substring(card.Length - 4);
            Session["PaymentReference"] = "PAY-" + DateTime.Now.ToString("yyyyMMddHHmmss") + "-" + Guid.NewGuid().ToString("N").Substring(0, 6).ToUpper();
            Session["PaymentDateTime"] = DateTime.Now;

            Session.Remove("ShoppingCart");
            Response.Redirect("OrderConfirmation.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeliveryandExtras.aspx");
        }
    }
}