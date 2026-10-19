using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web;
using System.Web.UI.WebControls;
using FEHMS_FortEventHireManagementSystem;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class DeliveryandExtras : System.Web.UI.Page
    {
        private const decimal DeliveryRate = 0.07m;
        private const decimal SetupRate = 0.03m;
        private const decimal LateNoShowFee = 150m;
        private Dictionary<string, ServiceRate> serviceRates;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!HasCheckoutData())
            {
                Response.Redirect("Cart.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsCustomerSignedIn())
            {
                Response.Redirect("Login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!LoadServiceRates()) return;

            SetDateMinimums();
            if (!IsPostBack)
            {
                rbCompanyTransport.Checked = true;
                rbSetupNo.Checked = true;
                RestoreData();
                LoadRegisteredCustomer();
            }

            LoadCheckoutInformation();
            UpdateTransportPanels();
            UpdatePriceSummary();
        }

        private bool HasCheckoutData()
        {
            DataTable cart = Session["ShoppingCart"] as DataTable;
            return cart != null && cart.Rows.Count > 0 && Session["EventDate"] != null;
        }

        private bool IsCustomerSignedIn()
        {
            return Convert.ToBoolean(Session["LoggedIn"] ?? false) &&
                   Session["UserID"] != null &&
                   string.Equals(Convert.ToString(Session["UserRole"]), "Customer", StringComparison.OrdinalIgnoreCase);
        }

        private void SetDateMinimums()
        {
            string minimum = DateTime.Today.ToString("yyyy-MM-dd");
            txtDeliveryDate.Attributes["min"] = minimum;
            txtCompanyCollectionDate.Attributes["min"] = minimum;
            txtCustomerCollectionDate.Attributes["min"] = minimum;
            txtReturnDate.Attributes["min"] = minimum;
        }

        private decimal ItemTotal()
        {
            decimal saved;
            if (Session["BookingTotal"] != null && decimal.TryParse(Convert.ToString(Session["BookingTotal"]), out saved))
                return saved;

            decimal total = 0m;
            DataTable cart = Session["ShoppingCart"] as DataTable;
            if (cart != null)
            {
                foreach (DataRow row in cart.Rows)
                    total += Convert.ToDecimal(row["UnitPrice"]) * Convert.ToInt32(row["Quantity"]);
            }
            return total;
        }

        private void LoadCheckoutInformation()
        {
            lblEventDate.Text = Text("EventDate", "Not provided");
            lblEventType.Text = Text("EventType", "Not provided");
            lblItemTotalTop.Text = MoneyText(ItemTotal());
        }

        private string Text(string key, string fallback)
        {
            string value = Convert.ToString(Session[key]);
            return string.IsNullOrWhiteSpace(value) ? fallback : value;
        }

        private string MoneyText(decimal value)
        {
            return "R" + value.ToString("N2");
        }

        private void RestoreData()
        {
            RestoreText(txtFullName, "CustomerFullName");
            RestoreText(txtEmail, "CustomerEmail");
            RestoreText(txtPhone, "CustomerPhone");

            if (Text("TransportMethod", "") == "Customer Collection & Return")
            {
                rbCompanyTransport.Checked = false;
                rbCustomerTransport.Checked = true;
            }

            RestoreText(txtDeliveryAddress, "DeliveryAddress");
            RestoreText(txtCity, "DeliveryCity");
            RestoreText(txtPostalCode, "DeliveryPostalCode");
            RestoreText(txtDeliveryDate, "DeliveryDate");
            RestoreText(txtDeliveryTime, "DeliveryTime");
            RestoreText(txtCompanyCollectionDate, "CollectionDate");
            RestoreText(txtCompanyCollectionTime, "CollectionTime");
            RestoreText(txtTransportInstructions, "TransportInstructions");
            RestoreText(txtCustomerCollectionDate, "CustomerCollectionDate");
            RestoreText(txtCustomerCollectionTime, "CustomerCollectionTime");
            RestoreText(txtReturnDate, "ReturnDate");
            RestoreText(txtReturnTime, "ReturnTime");

            string province = Text("DeliveryProvince", "");
            if (ddlProvince.Items.FindByValue(province) != null) ddlProvince.SelectedValue = province;

            if (Convert.ToBoolean(Session["SetupRequired"] ?? false))
            {
                rbSetupYes.Checked = true;
                rbSetupNo.Checked = false;
            }

            RestoreProvider(chkDJ, txtDJQty, txtDJHours, "DJQty", "DJHours", MinimumHours("DJ"));
            RestoreProvider(chkCaterer, txtCatererQty, txtCatererHours, "CatererQty", "CatererHours", MinimumHours("Caterer"));
            RestoreProvider(chkBartender, txtBartenderQty, txtBartenderHours, "BartenderQty", "BartenderHours", MinimumHours("Bartender"));
            RestoreProvider(chkWaiter, txtWaiterQty, txtWaiterHours, "WaiterQty", "WaiterHours", MinimumHours("Waiter"));
            RestoreProvider(chkClown, txtClownQty, txtClownHours, "ClownQty", "ClownHours", MinimumHours("Clown"));
            RestoreProvider(chkPhotographer, txtPhotographerQty, txtPhotographerHours, "PhotographerQty", "PhotographerHours", MinimumHours("Photographer"));
        }

        private void RestoreText(TextBox control, string key)
        {
            if (Session[key] != null) control.Text = Convert.ToString(Session[key]);
        }

        private void LoadRegisteredCustomer()
        {
            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["ForteDB"];
            if (settings == null) return;

            using (SqlConnection connection = new SqlConnection(settings.ConnectionString))
            using (SqlCommand command = connection.CreateCommand())
            {
                command.CommandText = @"
SELECT COALESCE(NULLIF(u.FullName, N''), LTRIM(RTRIM(CONCAT(u.FirstName, N' ', u.LastName)))) AS FullName,
       COALESCE(NULLIF(u.Email, N''), u.EmailAddress) AS Email,
       c.Phone
FROM dbo.Users AS u
LEFT JOIN dbo.Customer AS c ON c.UserID = u.UserID
WHERE u.UserID = @UserID AND u.IsActive = 1;";
                command.Parameters.Add("@UserID", SqlDbType.Int).Value = Convert.ToInt32(Session["UserID"]);
                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader(CommandBehavior.SingleRow))
                {
                    if (!reader.Read()) return;
                    if (string.IsNullOrWhiteSpace(txtFullName.Text)) txtFullName.Text = Convert.ToString(reader["FullName"]);
                    if (string.IsNullOrWhiteSpace(txtEmail.Text)) txtEmail.Text = Convert.ToString(reader["Email"]);
                    if (reader["Phone"] != DBNull.Value && string.IsNullOrWhiteSpace(txtPhone.Text)) txtPhone.Text = Convert.ToString(reader["Phone"]);
                }
            }
        }

        private bool LoadServiceRates()
        {
            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["ForteDB"];
            if (settings == null)
            {
                Error("Service prices are unavailable because the ForteDB connection is not configured.");
                btnContinueToPayment.Enabled = false;
                return false;
            }

            try
            {
                serviceRates = ServicePricingRepository.Load(settings.ConnectionString);
                BindServiceRate("DJ", lblDJRate, lblDJMinimumHours, txtDJHours);
                BindServiceRate("Caterer", lblCatererRate, lblCatererMinimumHours, txtCatererHours);
                BindServiceRate("Bartender", lblBartenderRate, lblBartenderMinimumHours, txtBartenderHours);
                BindServiceRate("Waiter", lblWaiterRate, lblWaiterMinimumHours, txtWaiterHours);
                BindServiceRate("Clown", lblClownRate, lblClownMinimumHours, txtClownHours);
                BindServiceRate("Photographer", lblPhotographerRate, lblPhotographerMinimumHours, txtPhotographerHours);
                btnContinueToPayment.Enabled = true;
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError("FEHMS service rate load error: " + ex);
                Error("Service prices could not be loaded. Please try again later.");
                btnContinueToPayment.Enabled = false;
                return false;
            }
        }

        private void BindServiceRate(string provider, Label rateLabel, Label minimumLabel, TextBox hoursBox)
        {
            ServiceRate rate = GetRate(provider);
            rateLabel.Text = "R" + rate.HourlyRate.ToString("N2");
            minimumLabel.Text = rate.MinimumHours.ToString();
            hoursBox.Attributes["min"] = rate.MinimumHours.ToString();
        }

        private ServiceRate GetRate(string provider)
        {
            ServiceRate rate;
            if (serviceRates == null || !serviceRates.TryGetValue(provider, out rate))
                throw new InvalidOperationException("No active rate is configured for " + provider + ".");
            return rate;
        }

        private int MinimumHours(string provider)
        {
            return GetRate(provider).MinimumHours;
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

        private int SafeQty(string value, int fallback)
        {
            int quantity;
            if (!int.TryParse(value, out quantity) || quantity < 0) return fallback;
            return Math.Min(quantity, 100);
        }

        private int SelectedQty(CheckBox check, TextBox quantity)
        {
            if (!check.Checked) return 0;
            return Math.Max(1, SafeQty(quantity.Text, 1));
        }

        private int SafeHours(string value, int minimum)
        {
            int hours;
            if (!int.TryParse(value, out hours)) return minimum;
            return Math.Max(minimum, Math.Min(hours, 24));
        }

        private decimal ProviderAmount(CheckBox check, TextBox quantity, TextBox hours, decimal hourlyRate, int minimumHours)
        {
            return check.Checked ? SelectedQty(check, quantity) * SafeHours(hours.Text, minimumHours) * hourlyRate : 0m;
        }

        private decimal DeliveryFee() { return rbCompanyTransport.Checked ? ItemTotal() * DeliveryRate : 0m; }
        private decimal SetupFee() { return rbSetupYes.Checked ? ItemTotal() * SetupRate : 0m; }

        private decimal ProviderFee()
        {
            return ProviderAmount(chkDJ, txtDJQty, txtDJHours, GetRate("DJ").HourlyRate, MinimumHours("DJ")) +
                   ProviderAmount(chkCaterer, txtCatererQty, txtCatererHours, GetRate("Caterer").HourlyRate, MinimumHours("Caterer")) +
                   ProviderAmount(chkBartender, txtBartenderQty, txtBartenderHours, GetRate("Bartender").HourlyRate, MinimumHours("Bartender")) +
                   ProviderAmount(chkWaiter, txtWaiterQty, txtWaiterHours, GetRate("Waiter").HourlyRate, MinimumHours("Waiter")) +
                   ProviderAmount(chkClown, txtClownQty, txtClownHours, GetRate("Clown").HourlyRate, MinimumHours("Clown")) +
                   ProviderAmount(chkPhotographer, txtPhotographerQty, txtPhotographerHours, GetRate("Photographer").HourlyRate, MinimumHours("Photographer"));
        }

        private decimal GrandTotal() { return ItemTotal() + DeliveryFee() + SetupFee() + ProviderFee(); }

        private void UpdatePriceSummary()
        {
            lblItemTotal.Text = MoneyText(ItemTotal());
            lblDeliveryFee.Text = MoneyText(DeliveryFee());
            lblSetupFee.Text = MoneyText(SetupFee());
            lblProviderFee.Text = MoneyText(ProviderFee());
            lblGrandTotal.Text = MoneyText(GrandTotal());
        }

        private bool ValidatePage()
        {
            lblMessage.Visible = false;
            if (string.IsNullOrWhiteSpace(txtFullName.Text)) return Error("Please enter the customer's full name.");
            if (string.IsNullOrWhiteSpace(txtEmail.Text)) return Error("Please enter the customer's email address.");
            try { new MailAddress(txtEmail.Text.Trim()); } catch { return Error("Please enter a valid email address."); }
            if (string.IsNullOrWhiteSpace(txtPhone.Text)) return Error("Please enter the customer's phone number.");
            if (!rbCompanyTransport.Checked && !rbCustomerTransport.Checked) return Error("Please choose a delivery or collection option.");

            if (rbCompanyTransport.Checked)
            {
                if (string.IsNullOrWhiteSpace(txtDeliveryAddress.Text)) return Error("Please enter the delivery address.");
                if (string.IsNullOrWhiteSpace(txtCity.Text)) return Error("Please enter the city or town.");
                if (string.IsNullOrWhiteSpace(ddlProvince.SelectedValue)) return Error("Please select the province.");
                if (string.IsNullOrWhiteSpace(txtPostalCode.Text)) return Error("Please enter the postal code.");
                if (!ValidDateTime(txtDeliveryDate.Text, txtDeliveryTime.Text)) return Error("Please enter a valid future delivery date and time.");
                if (!ValidDateTime(txtCompanyCollectionDate.Text, txtCompanyCollectionTime.Text)) return Error("Please enter a valid future collection date and time.");
                if (Combine(txtCompanyCollectionDate.Text, txtCompanyCollectionTime.Text) <= Combine(txtDeliveryDate.Text, txtDeliveryTime.Text)) return Error("Collection must be after delivery.");
            }
            else
            {
                if (!ValidDateTime(txtCustomerCollectionDate.Text, txtCustomerCollectionTime.Text)) return Error("Please enter a valid future collection date and time.");
                if (!ValidDateTime(txtReturnDate.Text, txtReturnTime.Text)) return Error("Please enter a valid future return date and time.");
                if (Combine(txtReturnDate.Text, txtReturnTime.Text) <= Combine(txtCustomerCollectionDate.Text, txtCustomerCollectionTime.Text)) return Error("Return must be after collection.");
            }

            if (!rbSetupYes.Checked && !rbSetupNo.Checked) return Error("Please choose whether setup is required.");
            return ValidateProvider(chkDJ, txtDJQty, txtDJHours, "DJ", MinimumHours("DJ")) &&
                   ValidateProvider(chkCaterer, txtCatererQty, txtCatererHours, "Caterer", MinimumHours("Caterer")) &&
                   ValidateProvider(chkBartender, txtBartenderQty, txtBartenderHours, "Bartender", MinimumHours("Bartender")) &&
                   ValidateProvider(chkWaiter, txtWaiterQty, txtWaiterHours, "Waiter", MinimumHours("Waiter")) &&
                   ValidateProvider(chkClown, txtClownQty, txtClownHours, "children's entertainer", MinimumHours("Clown")) &&
                   ValidateProvider(chkPhotographer, txtPhotographerQty, txtPhotographerHours, "Photographer", MinimumHours("Photographer"));
        }

        private bool ValidDateTime(string date, string time)
        {
            DateTime result;
            return DateTime.TryParse(date, out result) && DateTime.TryParse(time, out result) && Combine(date, time) >= DateTime.Now;
        }

        private DateTime Combine(string date, string time)
        {
            DateTime parsedDate = DateTime.Parse(date);
            TimeSpan parsedTime = TimeSpan.Parse(time);
            return parsedDate.Date.Add(parsedTime);
        }

        private bool ValidateProvider(CheckBox check, TextBox quantity, TextBox hours, string name, int minimumHours)
        {
            if (!check.Checked) return true;
            int number;
            if (!int.TryParse(quantity.Text, out number) || number < 1 || number > 20)
                return Error("Enter a quantity between 1 and 20 for " + name + ".");
            int duration;
            if (!int.TryParse(hours.Text, out duration) || duration < minimumHours || duration > 24)
                return Error("Enter at least " + minimumHours + " booking hours for " + name + ".");
            return true;
        }

        private bool Error(string message)
        {
            lblMessage.Text = HttpUtility.HtmlEncode(message);
            lblMessage.Visible = true;
            UpdateTransportPanels();
            return false;
        }

        private void SaveCustomerContact()
        {
            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["ForteDB"];
            if (settings == null) throw new InvalidOperationException("ForteDB connection string is missing.");
            using (SqlConnection connection = new SqlConnection(settings.ConnectionString))
            using (SqlCommand command = connection.CreateCommand())
            {
                command.CommandText = @"
UPDATE dbo.Customer
SET Phone = @Phone,
    Address = CASE WHEN @Address IS NULL THEN Address ELSE @Address END,
    UpdatedAt = SYSUTCDATETIME()
WHERE UserID = @UserID;";
                command.Parameters.Add("@Phone", SqlDbType.NVarChar, 30).Value = txtPhone.Text.Trim();
                string address = rbCompanyTransport.Checked ? txtDeliveryAddress.Text.Trim() : null;
                command.Parameters.Add("@Address", SqlDbType.NVarChar, 500).Value = (object)address ?? DBNull.Value;
                command.Parameters.Add("@UserID", SqlDbType.Int).Value = Convert.ToInt32(Session["UserID"]);
                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        protected void btnContinueToPayment_Click(object sender, EventArgs e)
        {
            if (!ValidatePage()) return;

            try { SaveCustomerContact(); }
            catch (SqlException ex)
            {
                System.Diagnostics.Trace.TraceError("FEHMS customer contact update SQL error: " + ex);
                Error("We could not save your contact details. Please try again.");
                return;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError("FEHMS customer contact update error: " + ex);
                Error("We could not save your contact details. Please try again.");
                return;
            }

            Session["CustomerFullName"] = txtFullName.Text.Trim();
            Session["CustomerEmail"] = txtEmail.Text.Trim().ToLowerInvariant();
            Session["CustomerPhone"] = txtPhone.Text.Trim();
            Session["TransportMethod"] = rbCompanyTransport.Checked ? "Forte Delivery & Collection" : "Customer Collection & Return";

            if (rbCompanyTransport.Checked)
            {
                Session["DeliveryAddress"] = txtDeliveryAddress.Text.Trim();
                Session["DeliveryCity"] = txtCity.Text.Trim();
                Session["DeliveryProvince"] = ddlProvince.SelectedValue;
                Session["DeliveryPostalCode"] = txtPostalCode.Text.Trim();
                Session["DeliveryDate"] = txtDeliveryDate.Text;
                Session["DeliveryTime"] = txtDeliveryTime.Text;
                Session["CollectionDate"] = txtCompanyCollectionDate.Text;
                Session["CollectionTime"] = txtCompanyCollectionTime.Text;
                Session["TransportInstructions"] = txtTransportInstructions.Text.Trim();
                Session.Remove("CustomerCollectionDate"); Session.Remove("CustomerCollectionTime");
                Session.Remove("ReturnDate"); Session.Remove("ReturnTime");
            }
            else
            {
                Session["CustomerCollectionDate"] = txtCustomerCollectionDate.Text;
                Session["CustomerCollectionTime"] = txtCustomerCollectionTime.Text;
                Session["ReturnDate"] = txtReturnDate.Text;
                Session["ReturnTime"] = txtReturnTime.Text;
                Session.Remove("DeliveryAddress"); Session.Remove("DeliveryCity"); Session.Remove("DeliveryProvince");
                Session.Remove("DeliveryPostalCode"); Session.Remove("DeliveryDate"); Session.Remove("DeliveryTime");
                Session.Remove("CollectionDate"); Session.Remove("CollectionTime"); Session.Remove("TransportInstructions");
            }

            Session["SetupRequired"] = rbSetupYes.Checked;
            SaveProviderSession(chkDJ, txtDJQty, txtDJHours, "DJQty", "DJHours", MinimumHours("DJ"));
            SaveProviderSession(chkCaterer, txtCatererQty, txtCatererHours, "CatererQty", "CatererHours", MinimumHours("Caterer"));
            SaveProviderSession(chkBartender, txtBartenderQty, txtBartenderHours, "BartenderQty", "BartenderHours", MinimumHours("Bartender"));
            SaveProviderSession(chkWaiter, txtWaiterQty, txtWaiterHours, "WaiterQty", "WaiterHours", MinimumHours("Waiter"));
            SaveProviderSession(chkClown, txtClownQty, txtClownHours, "ClownQty", "ClownHours", MinimumHours("Clown"));
            SaveProviderSession(chkPhotographer, txtPhotographerQty, txtPhotographerHours, "PhotographerQty", "PhotographerHours", MinimumHours("Photographer"));

            Session["DeliveryFee"] = DeliveryFee();
            Session["SetupFee"] = SetupFee();
            Session["ProviderFee"] = ProviderFee();
            Session["LateNoShowFeePolicy"] = LateNoShowFee;
            Session["LateNoShowFeeApplied"] = 0m;
            Session["GrandTotal"] = GrandTotal();

            Response.Redirect("Payment.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void SaveProviderSession(CheckBox check, TextBox quantity, TextBox hours, string quantityKey, string hoursKey, int minimumHours)
        {
            Session[quantityKey] = SelectedQty(check, quantity);
            Session[hoursKey] = SafeHours(hours.Text, minimumHours);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Checkout.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
