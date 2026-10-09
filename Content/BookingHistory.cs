using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    [Serializable]
    public sealed class CompletedBooking
    {
        public string Owner { get; set; }
        public string DownloadId { get; set; }
        public DateTime SavedAtUtc { get; set; }
        public Dictionary<string, string> Values { get; set; }
        public DataTable Items { get; set; }
        public string ReceiptHtml { get; set; }

        public string Get(string key)
        {
            string value;
            return Values.TryGetValue(key, out value) && !string.IsNullOrWhiteSpace(value) ? value : "-";
        }

        private decimal Money(string key)
        {
            decimal value;
            return decimal.TryParse(Get(key), NumberStyles.Number, CultureInfo.InvariantCulture, out value) ? value : 0m;
        }
        public string BookingReference { get { return Get("BookingReference"); } }
        public string PaymentReference { get { return Get("PaymentReference"); } }
        public string BookingStatus { get { return Get("BookingStatus"); } }
        public string PaymentStatus { get { return Get("PaymentStatus"); } }
        public string CustomerFullName { get { return Get("CustomerFullName"); } }
        public string CustomerEmail { get { return Get("CustomerEmail"); } }
        public string CustomerPhone { get { return Get("CustomerPhone"); } }
        public string EventDate { get { return Get("EventDate"); } }
        public string EventType { get { return Get("EventType"); } }
        public string TransportMethod { get { return Get("TransportMethod"); } }
        public string DeliveryAddress { get { return Get("DeliveryAddress"); } }
        public string DeliveryCity { get { return Get("DeliveryCity"); } }
        public string DeliveryProvince { get { return Get("DeliveryProvince"); } }
        public string DeliveryPostalCode { get { return Get("DeliveryPostalCode"); } }
        public string DeliveryDate { get { return Get("DeliveryDate"); } }
        public string DeliveryTime { get { return Get("DeliveryTime"); } }
        public string CollectionDate { get { return Get("CollectionDate"); } }
        public string CollectionTime { get { return Get("CollectionTime"); } }
        public string CustomerCollectionDate { get { return Get("CustomerCollectionDate"); } }
        public string CustomerCollectionTime { get { return Get("CustomerCollectionTime"); } }
        public string ReturnDate { get { return Get("ReturnDate"); } }
        public string ReturnTime { get { return Get("ReturnTime"); } }
        public string SetupRequired { get { return Get("SetupRequired"); } }
        public string PaymentDateTime { get { return Get("PaymentDateTime"); } }
        public string DJQty { get { return Get("DJQty"); } }
        public string CatererQty { get { return Get("CatererQty"); } }
        public string BartenderQty { get { return Get("BartenderQty"); } }
        public string WaiterQty { get { return Get("WaiterQty"); } }
        public string ClownQty { get { return Get("ClownQty"); } }
        public string PhotographerQty { get { return Get("PhotographerQty"); } }
        public decimal BookingTotal { get { return Money("BookingTotal"); } }
        public decimal DeliveryFee { get { return Money("DeliveryFee"); } }
        public decimal SetupFee { get { return Money("SetupFee"); } }
        public decimal ProviderFee { get { return Money("ProviderFee"); } }
        public decimal LateNoShowFeeApplied { get { return Money("LateNoShowFeeApplied"); } }
        public decimal PaymentAmount { get { return Money("PaymentAmount"); } }
        public string Address
        {
            get
            {
                return TransportMethod == "Forte Delivery & Collection"
                    ? string.Join(", ", new[] { DeliveryAddress, DeliveryCity, DeliveryProvince, DeliveryPostalCode }.Where(p => p != "-"))
                    : "Forte Event Hire collection / return point";
            }
        }
        public string FirstTime { get { return TransportMethod == "Forte Delivery & Collection" ? DeliveryDate + " at " + DeliveryTime : CustomerCollectionDate + " at " + CustomerCollectionTime; } }
        public string SecondTime { get { return TransportMethod == "Forte Delivery & Collection" ? CollectionDate + " at " + CollectionTime : ReturnDate + " at " + ReturnTime; } }
        public string Setup { get { bool required; return bool.TryParse(SetupRequired, out required) && required ? "Yes" : "No"; } }
        public string PaidAt
        {
            get { DateTime value; return DateTime.TryParse(PaymentDateTime, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out value) ? value.ToString("dd MMMM yyyy HH:mm", CultureInfo.GetCultureInfo("en-ZA")) : PaymentDateTime; }
        }
        public string Providers
        {
            get
            {
                var providers = new List<string>();
                foreach (string name in new[] { "DJ", "Caterer", "Bartender", "Waiter", "Clown", "Photographer" })
                {
                    int quantity;
                    if (int.TryParse(Get(name + "Qty"), out quantity) && quantity > 0)
                        providers.Add(quantity + " × " + name + " = R" + (quantity * 100m).ToString("N2", CultureInfo.GetCultureInfo("en-ZA")));
                }
                return providers.Count == 0 ? "No service providers selected." : string.Join("; ", providers);
            }
        }
        public int TotalQuantity { get { return Items.Rows.Cast<DataRow>().Sum(r => Convert.ToInt32(r["Quantity"])); } }
        public bool IsActive { get { return new[] { "Pending", "Confirmed", "Out for Delivery" }.Contains(BookingStatus); } }
    }

    public static class BookingHistory
    {
        private const string SessionKey = "ForteCompletedBookingHistory";
        private static readonly string[] Keys = { "BookingReference", "PaymentReference", "BookingStatus", "PaymentStatus", "CustomerFullName", "CustomerEmail", "CustomerPhone", "EventDate", "EventType", "TransportMethod", "DeliveryAddress", "DeliveryCity", "DeliveryProvince", "DeliveryPostalCode", "DeliveryDate", "DeliveryTime", "CollectionDate", "CollectionTime", "CustomerCollectionDate", "CustomerCollectionTime", "ReturnDate", "ReturnTime", "SetupRequired", "PaymentDateTime", "DJQty", "CatererQty", "BartenderQty", "WaiterQty", "ClownQty", "PhotographerQty", "BookingTotal", "DeliveryFee", "SetupFee", "ProviderFee", "LateNoShowFeeApplied", "PaymentAmount" };

        private static string Owner(HttpContext context)
        {
            // Use the authenticated identity when the application supplies one.
            // Guest/test checkouts remain isolated to their browser session.
            return context.User != null && context.User.Identity != null && context.User.Identity.IsAuthenticated
                ? "user:" + context.User.Identity.Name : "session:" + context.Session.SessionID;
        }

        public static List<CompletedBooking> GetBookings(HttpContext context)
        {
            var history = context.Session[SessionKey] as List<CompletedBooking> ?? new List<CompletedBooking>();
            string owner = Owner(context);
            return history.Where(b => b.Owner == owner).OrderByDescending(b => b.SavedAtUtc).ToList();
        }

        public static void Save(HttpContext context, string receiptHtml)
        {
            var session = context.Session;
            var items = session["ConfirmedBookingItems"] as DataTable;
            if (items == null || items.Rows.Count == 0 || Convert.ToString(session["PaymentStatus"]) != "Paid") return;
            string reference = Convert.ToString(session["BookingReference"]);
            string paymentReference = Convert.ToString(session["PaymentReference"]);
            if (string.IsNullOrWhiteSpace(reference) || string.IsNullOrWhiteSpace(paymentReference))
                throw new InvalidOperationException("A paid booking needs booking and payment references before it can be saved.");

            var history = session[SessionKey] as List<CompletedBooking> ?? new List<CompletedBooking>();
            string owner = Owner(context);
            // Never overwrite a saved receipt with details from a later checkout.
            if (history.Any(b => b.Owner == owner && b.BookingReference == reference)) return;

            var values = new Dictionary<string, string>();
            foreach (string key in Keys)
            {
                object value = session[key];
                values[key] = Convert.ToString(value);
            }
            if (string.IsNullOrWhiteSpace(values["BookingStatus"])) values["BookingStatus"] = "Confirmed";
            // Match the existing receipt's number parsing, then store an invariant value.
            foreach (string key in new[] { "BookingTotal", "DeliveryFee", "SetupFee", "ProviderFee", "LateNoShowFeeApplied", "PaymentAmount" })
            {
                decimal amount;
                values[key] = (decimal.TryParse(Convert.ToString(session[key]), out amount) ? amount : 0m).ToString(CultureInfo.InvariantCulture);
            }
            DateTime paidAt;
            if (DateTime.TryParse(Convert.ToString(session["PaymentDateTime"]), out paidAt))
                values["PaymentDateTime"] = paidAt.ToString("o", CultureInfo.InvariantCulture);

            DataTable savedItems = items.Copy();
            if (!savedItems.Columns.Contains("DashboardLineTotal")) savedItems.Columns.Add("DashboardLineTotal", typeof(decimal));
            foreach (DataRow row in savedItems.Rows)
                row["DashboardLineTotal"] = Convert.ToDecimal(row["UnitPrice"]) * Convert.ToInt32(row["Quantity"]);
            history.Add(new CompletedBooking { Owner = owner, DownloadId = Guid.NewGuid().ToString("N"), SavedAtUtc = DateTime.UtcNow, Values = values, Items = savedItems, ReceiptHtml = receiptHtml });
            // Reassign to support out-of-process ASP.NET session providers too.
            session[SessionKey] = history;
        }

        public static void Download(HttpResponse response, string html)
        {
            response.Clear();
            response.ContentType = "text/html";
            response.ContentEncoding = Encoding.UTF8;
            response.AddHeader("Content-Disposition", "attachment; filename=Forte_Receipt.html");
            response.Cache.SetCacheability(HttpCacheability.NoCache);
            response.Cache.SetNoStore();
            response.Write(html);
            response.End();
        }
    }
}
