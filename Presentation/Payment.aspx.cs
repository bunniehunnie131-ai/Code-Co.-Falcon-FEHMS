using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Configuration;
using System.Text;
using System.Web;
using System.Web.UI;

namespace WebApplication2
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["ForteDB"].ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable cart = Session["ShoppingCart"] as DataTable;

            if (cart == null || cart.Rows.Count == 0 ||
                Session["GrandTotal"] == null)
            {
                Response.Redirect("Cart.aspx");
                return;
            }

            if (!IsPostBack)
            {
                Session.Remove("CompletedOrderID");
                Session.Remove("CurrentPaymentReference");

                txtCardHolder.Text = Get("CustomerFullName", "");
            }

            LoadSummary();
        }

        private string Get(string key, string fallback)
        {
            return Session[key] == null ||
                   string.IsNullOrWhiteSpace(Session[key].ToString())
                ? fallback
                : Session[key].ToString();
        }

        private decimal Money(string key)
        {
            decimal value;

            return Session[key] != null &&
                   decimal.TryParse(
                       Session[key].ToString(),
                       out value)
                ? value
                : 0m;
        }

        private int Qty(string key)
        {
            int value;

            return Session[key] != null &&
                   int.TryParse(Session[key].ToString(), out value)
                ? value
                : 0;
        }

        private void LoadSummary()
        {
            DataTable cart = Session["ShoppingCart"] as DataTable;

            if (cart != null)
            {
                rptItems.DataSource = cart;
                rptItems.DataBind();
            }

            lblEventDate.Text = Get("EventDate", "Not provided");
            lblEventType.Text = Get("EventType", "Not provided");
            lblEventNotes.Text = Get("EventNotes", "None");
            lblCustomer.Text = Get("CustomerFullName", "Not provided");
            lblEmail.Text = Get("CustomerEmail", "Not provided");
            lblPhone.Text = Get("CustomerPhone", "Not provided");

            string method = Get("TransportMethod", "SelfCollection");
            lblTransportMethod.Text = method;

            if (method.Equals(
                "Forte Delivery & Collection",
                StringComparison.OrdinalIgnoreCase))
            {
                lblAddress.Text = JoinAddress();

                lblFirstTime.Text =
                    Get("DeliveryDate", "-") +
                    " at " + Get("DeliveryTime", "-");

                lblSecondTime.Text =
                    Get("CollectionDate", "-") +
                    " at " + Get("CollectionTime", "-");
            }
            else
            {
                lblAddress.Text =
                    "Forte Event Hire collection / return point";

                lblFirstTime.Text =
                    Get("CustomerCollectionDate", "-") +
                    " at " + Get("CustomerCollectionTime", "-");

                lblSecondTime.Text =
                    Get("ReturnDate", "-") +
                    " at " + Get("ReturnTime", "-");
            }

            lblSetup.Text =
                Convert.ToBoolean(Session["SetupRequired"] ?? false)
                    ? "Yes"
                    : "No";

            lblProviders.Text = ProviderHtml();

            lblItemTotal.Text =
                "R" + Money("BookingTotal").ToString("N2");

            lblDeliveryFee.Text =
                "R" + Money("DeliveryFee").ToString("N2");

            lblSetupFee.Text =
                "R" + Money("SetupFee").ToString("N2");

            lblProviderFee.Text =
                "R" + Money("ProviderFee").ToString("N2");

            lblTotalDue.Text =
                "R" + Money("GrandTotal").ToString("N2");
        }

        private string JoinAddress()
        {
            string[] parts =
            {
                Get("DeliveryAddress", ""),
                Get("DeliveryCity", ""),
                Get("DeliveryProvince", ""),
                Get("DeliveryPostalCode", "")
            };

            return string.Join(", ", parts)
                .Replace(", ,", ",")
                .Trim(' ', ',');
        }

        private string ProviderHtml()
        {
            StringBuilder s = new StringBuilder();

            AddProvider(s, "DJ", Qty("DJQty"));
            AddProvider(s, "Caterer", Qty("CatererQty"));
            AddProvider(s, "Bartender", Qty("BartenderQty"));
            AddProvider(s, "Waiter", Qty("WaiterQty"));
            AddProvider(s, "Clown", Qty("ClownQty"));
            AddProvider(s, "Photographer", Qty("PhotographerQty"));

            return s.Length == 0
                ? "No service providers selected."
                : s.ToString();
        }

        private void AddProvider(
            StringBuilder s, string name, int qty)
        {
            if (qty > 0)
            {
                s.Append("<span class='chip'>");
                s.Append(qty);
                s.Append(" × ");
                s.Append(HttpUtility.HtmlEncode(name));
                s.Append(" = R");
                s.Append((qty * 100m).ToString("N2"));
                s.Append("</span>");
            }
        }

        private bool ValidatePayment()
        {
            lblMessage.Visible = false;

            if (string.IsNullOrWhiteSpace(ddlBankName.SelectedValue))
                return Error("Please select the bank name.");

            if (string.IsNullOrWhiteSpace(txtCardHolder.Text))
                return Error("Please enter the card holder name.");

            string card = DigitsOnly(txtCardNumber.Text);

            if (card.Length != 16)
                return Error("Please enter a 16-digit card number.");

            if (DigitsOnly(txtCVV.Text).Length != 3)
                return Error("Please enter a 3-digit CVV.");

            DateTime expiry;

            if (!TryExpiry(txtExpiry.Text, out expiry))
                return Error(
                    "Please enter a valid expiry date in MM/YY format.");

            if (expiry < new DateTime(
                DateTime.Today.Year, DateTime.Today.Month, 1))
            {
                return Error("The card has expired.");
            }

            return true;
        }

        private string DigitsOnly(string value)
        {
            StringBuilder b = new StringBuilder();

            foreach (char c in value ?? "")
            {
                if (char.IsDigit(c))
                    b.Append(c);
            }

            return b.ToString();
        }

        private bool TryExpiry(string value, out DateTime expiry)
        {
            expiry = DateTime.MinValue;

            DateTime parsed;

            if (!DateTime.TryParseExact(
                value,
                "MM/yy",
                CultureInfo.InvariantCulture,
                DateTimeStyles.None,
                out parsed))
            {
                return false;
            }

            expiry = new DateTime(
                parsed.Year,
                parsed.Month,
                DateTime.DaysInMonth(parsed.Year, parsed.Month));

            return true;
        }

        private bool Error(string message)
        {
            lblMessage.Text = message;
            lblMessage.Visible = true;
            return false;
        }

        private object DateValue(string sessionKey)
        {
            DateTime date;

            if (DateTime.TryParse(
                Get(sessionKey, ""),
                CultureInfo.CurrentCulture,
                DateTimeStyles.None,
                out date))
            {
                return date.Date;
            }

            return DBNull.Value;
        }

        private object OptionalText(string sessionKey)
        {
            string value = Get(sessionKey, "");

            return string.IsNullOrWhiteSpace(value)
                ? (object)DBNull.Value
                : value;
        }

        private int GetCustomerID(
            SqlConnection connection,
            SqlTransaction transaction)
        {
            if (Session["UserID"] == null)
            {
                throw new Exception(
                    "Your login session has expired. Please sign in again.");
            }

            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlCommand cmd = new SqlCommand(
                @"SELECT CustomerID
                  FROM dbo.Customer
                  WHERE UserID = @UserID",
                connection, transaction))
            {
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value =
                    userID;

                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                {
                    throw new Exception(
                        "No customer profile was found for your account. " +
                        "Please contact the system administrator.");
                }

                return Convert.ToInt32(result);
            }
        }

        // Database constraint permits only Delivery or SelfCollection.
        private string GetFulfilmentMethod()
        {
            string transportMethod =
                Get("TransportMethod", "SelfCollection").Trim();

            if (transportMethod.Equals(
                    "Delivery",
                    StringComparison.OrdinalIgnoreCase) ||
                transportMethod.Equals(
                    "Forte Delivery & Collection",
                    StringComparison.OrdinalIgnoreCase))
            {
                return "Delivery";
            }

            return "SelfCollection";
        }

        private int SaveBooking(
            DataTable cart,
            string paymentReference,
            string cardLastFour)
        {
            using (SqlConnection connection =
                   new SqlConnection(ConnectionString))
            {
                connection.Open();

                using (SqlTransaction transaction =
                       connection.BeginTransaction())
                {
                    try
                    {
                        int customerID =
                            GetCustomerID(connection, transaction);

                        string venue = Get(
                            "EventVenue",
                            Get("DeliveryAddress", ""));

                        string fulfilment = GetFulfilmentMethod();

                        int orderID;

                        string orderSql = @"
                            INSERT INTO dbo.[Order]
                            (
                                CustomerID,
                                EventName,
                                EventType,
                                EventVenue,
                                EventDate,
                                HireStartDate,
                                HireEndDate,
                                OrderDate,
                                Status,
                                FulfilmentMethod,
                                TotalAmount
                            )
                            VALUES
                            (
                                @CustomerID,
                                @EventName,
                                @EventType,
                                @EventVenue,
                                @EventDate,
                                @HireStartDate,
                                @HireEndDate,
                                @OrderDate,
                                @Status,
                                @FulfilmentMethod,
                                @TotalAmount
                            );

                            SELECT CAST(SCOPE_IDENTITY() AS INT);";

                        using (SqlCommand cmd = new SqlCommand(
                            orderSql, connection, transaction))
                        {
                            cmd.Parameters.Add(
                                "@CustomerID", SqlDbType.Int).Value =
                                customerID;

                            cmd.Parameters.Add(
                                "@EventName", SqlDbType.NVarChar, 200).Value =
                                Get("EventName", Get("EventType", "Event hire"));

                            cmd.Parameters.Add(
                                "@EventType", SqlDbType.NVarChar, 100).Value =
                                Get("EventType", "Not specified");

                            cmd.Parameters.Add(
                                "@EventVenue", SqlDbType.NVarChar, 300).Value =
                                string.IsNullOrWhiteSpace(venue)
                                    ? (object)DBNull.Value
                                    : venue;

                            cmd.Parameters.Add(
                                "@EventDate", SqlDbType.Date).Value =
                                DateValue("EventDate");

                            object hireStart = DateValue("HireStartDate");

                            if (hireStart == DBNull.Value)
                                hireStart = DateValue("EventDate");

                            cmd.Parameters.Add(
                                "@HireStartDate", SqlDbType.Date).Value =
                                hireStart;

                            object hireEnd = DateValue("HireEndDate");

                            if (hireEnd == DBNull.Value)
                                hireEnd = DateValue("CollectionDate");

                            if (hireEnd == DBNull.Value)
                                hireEnd = DateValue("ReturnDate");

                            cmd.Parameters.Add(
                                "@HireEndDate", SqlDbType.Date).Value =
                                hireEnd;

                            cmd.Parameters.Add(
                                "@OrderDate", SqlDbType.DateTime).Value =
                                DateTime.Now;

                            cmd.Parameters.Add(
                                "@Status", SqlDbType.NVarChar, 50).Value =
                                "Confirmed";

                            cmd.Parameters.Add(
                                "@FulfilmentMethod",
                                SqlDbType.NVarChar, 100).Value =
                                fulfilment;

                            SqlParameter totalParameter =
                                cmd.Parameters.Add(
                                    "@TotalAmount", SqlDbType.Decimal);

                            totalParameter.Precision = 18;
                            totalParameter.Scale = 2;
                            totalParameter.Value = Money("GrandTotal");

                            orderID = Convert.ToInt32(cmd.ExecuteScalar());
                        }

                        // Save cart products for this order.
                        string itemSql = @"
                            INSERT INTO dbo.OrderItem
                            (
                                OrderID,
                                ProductID,
                                PackageID,
                                ItemNameSnapshot,
                                Quantity,
                                UnitPrice
                            )
                            VALUES
                            (
                                @OrderID,
                                @ProductID,
                                NULL,
                                @ItemNameSnapshot,
                                @Quantity,
                                @UnitPrice
                            )";

                        foreach (DataRow row in cart.Rows)
                        {
                            if (row["ProductId"] == DBNull.Value)
                            {
                                throw new Exception(
                                    "A cart item is missing its product ID.");
                            }

                            using (SqlCommand cmd = new SqlCommand(
                                itemSql, connection, transaction))
                            {
                                cmd.Parameters.Add(
                                    "@OrderID", SqlDbType.Int).Value =
                                    orderID;

                                cmd.Parameters.Add(
                                    "@ProductID", SqlDbType.Int).Value =
                                    Convert.ToInt32(row["ProductId"]);

                                cmd.Parameters.Add(
                                    "@ItemNameSnapshot",
                                    SqlDbType.NVarChar, 200).Value =
                                    Convert.ToString(row["Name"]);

                                cmd.Parameters.Add(
                                    "@Quantity", SqlDbType.Int).Value =
                                    Convert.ToInt32(row["Quantity"]);

                                SqlParameter price = cmd.Parameters.Add(
                                    "@UnitPrice", SqlDbType.Decimal);

                                price.Precision = 18;
                                price.Scale = 2;
                                price.Value =
                                    Convert.ToDecimal(row["UnitPrice"]);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        // Save the payment record.
                        string paymentSql = @"
                            INSERT INTO dbo.Payment
                            (
                                OrderID,
                                Amount,
                                PaymentType,
                                PaymentMethod,
                                PaymentDate,
                                Status,
                                PaymentReference
                            )
                            VALUES
                            (
                                @OrderID,
                                @Amount,
                                @PaymentType,
                                @PaymentMethod,
                                @PaymentDate,
                                @Status,
                                @PaymentReference
                            )";

                        using (SqlCommand cmd = new SqlCommand(
                            paymentSql, connection, transaction))
                        {
                            cmd.Parameters.Add(
                                "@OrderID", SqlDbType.Int).Value = orderID;

                            SqlParameter amount = cmd.Parameters.Add(
                                "@Amount", SqlDbType.Decimal);

                            amount.Precision = 18;
                            amount.Scale = 2;
                            amount.Value = Money("GrandTotal");

                            // FIX: database allows Full, not Full Payment.
                            cmd.Parameters.Add(
                                "@PaymentType",
                                SqlDbType.NVarChar, 50).Value = "Full";

                            cmd.Parameters.Add(
                                "@PaymentMethod",
                                SqlDbType.NVarChar, 100).Value =
                                ddlBankName.SelectedValue +
                                " (Card ending " + cardLastFour + ")";

                            cmd.Parameters.Add(
                                "@PaymentDate", SqlDbType.DateTime).Value =
                                DateTime.Now;

                            cmd.Parameters.Add(
                                "@Status", SqlDbType.NVarChar, 50).Value =
                                "Paid";

                            cmd.Parameters.Add(
                                "@PaymentReference",
                                SqlDbType.NVarChar, 100).Value =
                                paymentReference;

                            cmd.ExecuteNonQuery();
                        }

                        transaction.Commit();
                        return orderID;
                    }
                    catch
                    {
                        try
                        {
                            transaction.Rollback();
                        }
                        catch
                        {
                            // Keep the original error.
                        }

                        throw;
                    }
                }
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            if (!ValidatePayment())
                return;

            if (Session["CompletedOrderID"] != null)
            {
                Response.Redirect("OrderConfirmation.aspx");
                return;
            }

            DataTable cart = Session["ShoppingCart"] as DataTable;

            if (cart == null || cart.Rows.Count == 0)
            {
                Error("Your cart is empty. Please add items before paying.");
                return;
            }

            string card = DigitsOnly(txtCardNumber.Text);

            string paymentReference =
                "PAY-" + DateTime.Now.ToString("yyyyMMddHHmmss") + "-" +
                Guid.NewGuid().ToString("N").Substring(0, 6).ToUpper();

            try
            {
                int orderID = SaveBooking(
                    cart,
                    paymentReference,
                    card.Substring(card.Length - 4));

                Session["CompletedOrderID"] = orderID;
                Session["BookingReference"] = "ORD-" + orderID;
                Session["ConfirmedBookingItems"] = cart.Copy();
                Session["PaymentStatus"] = "Paid";
                Session["BookingStatus"] = "Confirmed";
                Session["PaymentAmount"] = Money("GrandTotal");
                Session["PaymentBank"] = ddlBankName.SelectedValue;
                Session["PaymentCardLast4"] =
                    card.Substring(card.Length - 4);
                Session["PaymentReference"] = paymentReference;
                Session["PaymentDateTime"] = DateTime.Now;

                Session.Remove("ShoppingCart");

                Response.Redirect("OrderConfirmation.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "FEHMS booking save failed: " + ex.ToString());

                Error("Booking save failed: " + ex.Message);
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeliveryandExtras.aspx");
        }
    }
}
