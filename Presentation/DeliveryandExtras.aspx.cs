using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class DeliveryandExtras : System.Web.UI.Page
    {
        private const decimal DeliveryRate = 0.07m;
        private const decimal SetupRate = 0.03m;
        private const decimal ProviderUnitFee = 100.00m;
        private const decimal LateNoShowFee = 150.00m;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ShoppingCart"] == null || Session["EventDate"] == null)
            {
                Response.Redirect("WebForm2.aspx");
                return;
            }

            SetDateMinimums();

            if (!IsPostBack)
            {
                rbCompanyTransport.Checked = true;
                rbCustomerTransport.Checked = false;
                rbSetupNo.Checked = true;
                RestoreData();
            }

            LoadCheckoutInformation();
            UpdateTransportPanels();
            UpdatePriceSummary();
        }

        private void SetDateMinimums()
        {
            string min = DateTime.Today.ToString("yyyy-MM-dd");
            txtDeliveryDate.Attributes["min"] = min;
            txtCompanyCollectionDate.Attributes["min"] = min;
            txtCustomerCollectionDate.Attributes["min"] = min;
            txtReturnDate.Attributes["min"] = min;
        }

        private decimal ItemTotal()
        {
            if (Session["BookingTotal"] != null)
            {
                decimal saved;
                if (decimal.TryParse(Session["BookingTotal"].ToString(), out saved)) return saved;
            }

            DataTable cart = Session["ShoppingCart"] as DataTable;
            decimal total = 0m;
            if (cart != null)
                foreach (DataRow row in cart.Rows)
                    total += Convert.ToDecimal(row["UnitPrice"]) * Convert.ToInt32(row["Quantity"]);
            return total;
        }

        private void LoadCheckoutInformation()
        {
            lblEventDate.Text = Text("EventDate", "Not provided");
            lblEventType.Text = Text("EventType", "Not provided");
            lblItemTotalTop.Text = "R" + ItemTotal().ToString("N2");
        }

        private string Text(string key, string fallback)
        {
            return Session[key] == null || string.IsNullOrWhiteSpace(Session[key].ToString()) ? fallback : Session[key].ToString();
        }

        private void RestoreData()
        {
            if (Session["CustomerFullName"] != null) txtFullName.Text = Session["CustomerFullName"].ToString();
            if (Session["CustomerEmail"] != null) txtEmail.Text = Session["CustomerEmail"].ToString();
            if (Session["CustomerPhone"] != null) txtPhone.Text = Session["CustomerPhone"].ToString();

            string method = Text("TransportMethod", "");
            if (method == "Customer Collection & Return") { rbCompanyTransport.Checked = false; rbCustomerTransport.Checked = true; }

            SetBox(txtDeliveryAddress, "DeliveryAddress"); SetBox(txtCity, "DeliveryCity"); SetBox(txtPostalCode, "DeliveryPostalCode");
            SetBox(txtDeliveryDate, "DeliveryDate"); SetBox(txtDeliveryTime, "DeliveryTime"); SetBox(txtCompanyCollectionDate, "CollectionDate"); SetBox(txtCompanyCollectionTime, "CollectionTime");
            SetBox(txtTransportInstructions, "TransportInstructions"); SetBox(txtCustomerCollectionDate, "CustomerCollectionDate"); SetBox(txtCustomerCollectionTime, "CustomerCollectionTime"); SetBox(txtReturnDate, "ReturnDate"); SetBox(txtReturnTime, "ReturnTime");

            string province = Text("DeliveryProvince", "");
            if (ddlProvince.Items.FindByValue(province) != null) ddlProvince.SelectedValue = province;

            if (Session["SetupRequired"] != null && Convert.ToBoolean(Session["SetupRequired"])) { rbSetupYes.Checked = true; rbSetupNo.Checked = false; }
            RestoreProvider(chkDJ, txtDJQty, "DJQty"); RestoreProvider(chkCaterer, txtCatererQty, "CatererQty"); RestoreProvider(chkBartender, txtBartenderQty, "BartenderQty"); RestoreProvider(chkWaiter, txtWaiterQty, "WaiterQty"); RestoreProvider(chkClown, txtClownQty, "ClownQty"); RestoreProvider(chkPhotographer, txtPhotographerQty, "PhotographerQty");
        }

        private void SetBox(System.Web.UI.WebControls.TextBox box, string key)
        {
            if (Session[key] != null) box.Text = Session[key].ToString();
        }

        private void RestoreProvider(System.Web.UI.WebControls.CheckBox check, System.Web.UI.WebControls.TextBox qty, string key)
        {
            int value = Session[key] == null ? 0 : SafeQty(Session[key].ToString(), 0);
            check.Checked = value > 0;
            qty.Text = value > 0 ? value.ToString() : "1";
        }

        protected void Transport_CheckedChanged(object sender, EventArgs e)
        {
            UpdateTransportPanels();
            UpdatePriceSummary();
        }

        protected void ExtrasChanged(object sender, EventArgs e)
        {
            UpdatePriceSummary();
        }

        protected void ProviderQtyChanged(object sender, EventArgs e)
        {
            UpdatePriceSummary();
        }

        private void UpdateTransportPanels()
        {
            pnlCompanyTransport.Visible = rbCompanyTransport.Checked;
            pnlCustomerTransport.Visible = rbCustomerTransport.Checked;
        }

        private int SafeQty(string value, int defaultValue)
        {
            int q;
            if (!int.TryParse(value, out q) || q < 0) q = defaultValue;
            if (q > 100) q = 100;
            return q;
        }

        private int SelectedQty(System.Web.UI.WebControls.CheckBox check, System.Web.UI.WebControls.TextBox box)
        {
            if (!check.Checked) return 0;
            int q = SafeQty(box.Text, 1);
            return q < 1 ? 1 : q;
        }

        private int ProviderCount()
        {
            return SelectedQty(chkDJ, txtDJQty) + SelectedQty(chkCaterer, txtCatererQty) + SelectedQty(chkBartender, txtBartenderQty) + SelectedQty(chkWaiter, txtWaiterQty) + SelectedQty(chkClown, txtClownQty) + SelectedQty(chkPhotographer, txtPhotographerQty);
        }

        private decimal DeliveryFee() { return rbCompanyTransport.Checked ? ItemTotal() * DeliveryRate : 0m; }
        private decimal SetupFee() { return rbSetupYes.Checked ? ItemTotal() * SetupRate : 0m; }
        private decimal ProviderFee() { return ProviderCount() * ProviderUnitFee; }
        private decimal GrandTotal() { return ItemTotal() + DeliveryFee() + SetupFee() + ProviderFee(); }

        private void UpdatePriceSummary()
        {
            lblItemTotal.Text = "R" + ItemTotal().ToString("N2");
            lblDeliveryFee.Text = "R" + DeliveryFee().ToString("N2");
            lblSetupFee.Text = "R" + SetupFee().ToString("N2");
            lblProviderFee.Text = "R" + ProviderFee().ToString("N2");
            lblGrandTotal.Text = "R" + GrandTotal().ToString("N2");
        }

        private bool ValidatePage()
        {
            lblMessage.Visible = false;
            if (string.IsNullOrWhiteSpace(txtFullName.Text)) return Error("Please enter the customer's full name.");
            if (string.IsNullOrWhiteSpace(txtEmail.Text)) return Error("Please enter the customer's email address.");
            try { new MailAddress(txtEmail.Text.Trim()); } catch { return Error("Please enter a valid email address."); }
            if (string.IsNullOrWhiteSpace(txtPhone.Text)) return Error("Please enter the customer's phone number.");
            if (!rbCompanyTransport.Checked && !rbCustomerTransport.Checked) return Error("Please choose a delivery / collection option.");

            if (rbCompanyTransport.Checked)
            {
                if (string.IsNullOrWhiteSpace(txtDeliveryAddress.Text)) return Error("Please enter the delivery address.");
                if (string.IsNullOrWhiteSpace(txtCity.Text)) return Error("Please enter the city or town.");
                if (string.IsNullOrWhiteSpace(ddlProvince.SelectedValue)) return Error("Please select the province.");
                if (string.IsNullOrWhiteSpace(txtPostalCode.Text)) return Error("Please enter the postal code.");
                if (!ValidDateTime(txtDeliveryDate.Text, txtDeliveryTime.Text)) return Error("Please enter a valid delivery date and delivery time.");
                if (!ValidDateTime(txtCompanyCollectionDate.Text, txtCompanyCollectionTime.Text)) return Error("Please enter a valid collection date and collection time.");
                if (Combine(txtCompanyCollectionDate.Text, txtCompanyCollectionTime.Text) <= Combine(txtDeliveryDate.Text, txtDeliveryTime.Text)) return Error("Collection must be after delivery.");
            }
            else
            {
                if (!ValidDateTime(txtCustomerCollectionDate.Text, txtCustomerCollectionTime.Text)) return Error("Please enter a valid collection date and collection time.");
                if (!ValidDateTime(txtReturnDate.Text, txtReturnTime.Text)) return Error("Please enter a valid return date and return time.");
                if (Combine(txtReturnDate.Text, txtReturnTime.Text) <= Combine(txtCustomerCollectionDate.Text, txtCustomerCollectionTime.Text)) return Error("Return must be after collection.");
            }

            if (!rbSetupYes.Checked && !rbSetupNo.Checked) return Error("Please select whether setup is required.");
            if (!ValidateProvider(chkDJ, txtDJQty, "DJ")) return false;
            if (!ValidateProvider(chkCaterer, txtCatererQty, "Caterer")) return false;
            if (!ValidateProvider(chkBartender, txtBartenderQty, "Bartender")) return false;
            if (!ValidateProvider(chkWaiter, txtWaiterQty, "Waiter")) return false;
            if (!ValidateProvider(chkClown, txtClownQty, "Clown")) return false;
            if (!ValidateProvider(chkPhotographer, txtPhotographerQty, "Photographer")) return false;
            return true;
        }

        private bool ValidDateTime(string date, string time)
        {
            DateTime d, t;
            return DateTime.TryParse(date, out d) && DateTime.TryParse(time, out t) && Combine(date, time) >= DateTime.Now;
        }

        private DateTime Combine(string date, string time)
        {
            DateTime d = DateTime.Parse(date); TimeSpan t = DateTime.Parse(time).TimeOfDay; return d.Date.Add(t);
        }

        private bool ValidateProvider(System.Web.UI.WebControls.CheckBox check, System.Web.UI.WebControls.TextBox box, string name)
        {
            if (!check.Checked) return true;
            int q;
            if (!int.TryParse(box.Text, out q) || q < 1 || q > 100) return Error("Please enter a quantity between 1 and 100 for " + name + ".");
            return true;
        }

        private bool Error(string message)
        {
            lblMessage.Text = message; lblMessage.Visible = true; UpdateTransportPanels(); return false;
        }

        protected void btnContinueToPayment_Click(object sender, EventArgs e)
        {
            if (!ValidatePage()) return;

            Session["CustomerFullName"] = txtFullName.Text.Trim();
            Session["CustomerEmail"] = txtEmail.Text.Trim();
            Session["CustomerPhone"] = txtPhone.Text.Trim();
            Session["TransportMethod"] = rbCompanyTransport.Checked ? "Forte Delivery & Collection" : "Customer Collection & Return";

            if (rbCompanyTransport.Checked)
            {
                Session["DeliveryAddress"] = txtDeliveryAddress.Text.Trim(); Session["DeliveryCity"] = txtCity.Text.Trim(); Session["DeliveryProvince"] = ddlProvince.SelectedValue; Session["DeliveryPostalCode"] = txtPostalCode.Text.Trim();
                Session["DeliveryDate"] = txtDeliveryDate.Text; Session["DeliveryTime"] = txtDeliveryTime.Text; Session["CollectionDate"] = txtCompanyCollectionDate.Text; Session["CollectionTime"] = txtCompanyCollectionTime.Text; Session["TransportInstructions"] = txtTransportInstructions.Text.Trim();
                Session.Remove("CustomerCollectionDate"); Session.Remove("CustomerCollectionTime"); Session.Remove("ReturnDate"); Session.Remove("ReturnTime");
            }
            else
            {
                Session["CustomerCollectionDate"] = txtCustomerCollectionDate.Text; Session["CustomerCollectionTime"] = txtCustomerCollectionTime.Text; Session["ReturnDate"] = txtReturnDate.Text; Session["ReturnTime"] = txtReturnTime.Text;
                Session.Remove("DeliveryAddress"); Session.Remove("DeliveryCity"); Session.Remove("DeliveryProvince"); Session.Remove("DeliveryPostalCode"); Session.Remove("DeliveryDate"); Session.Remove("DeliveryTime"); Session.Remove("CollectionDate"); Session.Remove("CollectionTime"); Session.Remove("TransportInstructions");
            }

            Session["SetupRequired"] = rbSetupYes.Checked;
            Session["DJQty"] = SelectedQty(chkDJ, txtDJQty); Session["CatererQty"] = SelectedQty(chkCaterer, txtCatererQty); Session["BartenderQty"] = SelectedQty(chkBartender, txtBartenderQty); Session["WaiterQty"] = SelectedQty(chkWaiter, txtWaiterQty); Session["ClownQty"] = SelectedQty(chkClown, txtClownQty); Session["PhotographerQty"] = SelectedQty(chkPhotographer, txtPhotographerQty);
            Session["DeliveryFee"] = DeliveryFee(); Session["SetupFee"] = SetupFee(); Session["ProviderFee"] = ProviderFee(); Session["LateNoShowFeePolicy"] = LateNoShowFee; Session["LateNoShowFeeApplied"] = 0.00m; Session["GrandTotal"] = GrandTotal();

            Response.Redirect("Payment.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("WebForm2.aspx");
        }
    }
}
