using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.SessionState;

namespace FEHMS_FortEventHireManagementSystem
{
    public sealed class BookingPersistenceResult
    {
        public long BookingID { get; set; }
        public string BookingReference { get; set; }
        public string PaymentReference { get; set; }
        public decimal Total { get; set; }
        public DataTable Items { get; set; }
    }

    public static class BookingPersistenceService
    {
        public static BookingPersistenceResult Save(HttpSessionState session, DataTable cart, string bank, string cardLast4)
        {
            if (session == null || cart == null || cart.Rows.Count == 0)
                throw new InvalidOperationException("The cart is empty.");

            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["ForteDB"];
            if (settings == null) throw new InvalidOperationException("The ForteDB connection string is missing.");
            Dictionary<string, ServiceRate> rates = ServicePricingRepository.Load(settings.ConnectionString);

            DateTime eventDate = DateTime.Parse(Get(session, "EventDate", ""));
            bool companyTransport = Get(session, "TransportMethod", "") == "Forte Delivery & Collection";
            DateTime startAt = BookingDateTime(session, companyTransport ? "DeliveryDate" : "CustomerCollectionDate", companyTransport ? "DeliveryTime" : "CustomerCollectionTime", eventDate);
            DateTime endAt = BookingDateTime(session, companyTransport ? "CollectionDate" : "ReturnDate", companyTransport ? "CollectionTime" : "ReturnTime", eventDate.AddDays(1));
            if (endAt <= startAt) throw new InvalidOperationException("The selected transport times are not valid.");

            DataTable currentCart = cart.Clone();
            decimal subtotal = 0m;
            decimal providerFee = CalculateProviderFee(session, rates);
            decimal deliveryFee;
            decimal setupFee;
            decimal total;
            string bookingReference = Get(session, "BookingReference", "FEH-" + DateTime.Now.ToString("yyyyMMdd") + "-" + Guid.NewGuid().ToString("N").Substring(0, 6).ToUpperInvariant());
            string paymentReference = "PAY-" + DateTime.Now.ToString("yyyyMMddHHmmss") + "-" + Guid.NewGuid().ToString("N").Substring(0, 6).ToUpperInvariant();

            using (SqlConnection connection = new SqlConnection(settings.ConnectionString))
            {
                connection.Open();
                using (SqlTransaction transaction = connection.BeginTransaction(IsolationLevel.Serializable))
                {
                    try
                    {
                        foreach (DataRow item in cart.Rows)
                        {
                            int productId = Convert.ToInt32(item["ProductId"]);
                            int quantity = Convert.ToInt32(item["Quantity"]);
                            using (SqlCommand command = new SqlCommand(@"
SELECT p.ProductName, p.Colour, p.Price,
       p.QuantityAvailable - ISNULL((
           SELECT SUM(bi.Quantity)
           FROM dbo.BookingItems AS bi
           INNER JOIN dbo.Bookings AS b ON b.BookingID = bi.BookingID
           WHERE bi.ProductID = p.ProductID
             AND b.BookingStatus IN (N'Pending', N'Confirmed')
             AND COALESCE(b.DeliveryDateTime, b.CustomerCollectionAt, CONVERT(datetime2(0), b.EventDate)) < @EndAt
             AND COALESCE(b.CompanyCollectionAt, b.ReturnAt, DATEADD(day, 1, CONVERT(datetime2(0), b.EventDate))) > @StartAt
       ), 0) AS AvailableForDates
FROM dbo.Product AS p WITH (UPDLOCK, HOLDLOCK)
WHERE p.ProductID = @ProductID AND p.IsAvailable = 1;", connection, transaction))
                            {
                                command.Parameters.Add("@ProductID", SqlDbType.Int).Value = productId;
                                command.Parameters.Add("@StartAt", SqlDbType.DateTime2).Value = startAt;
                                command.Parameters.Add("@EndAt", SqlDbType.DateTime2).Value = endAt;
                                using (SqlDataReader reader = command.ExecuteReader(CommandBehavior.SingleRow))
                                {
                                    if (!reader.Read()) throw new InvalidOperationException("A product in your cart is no longer available.");
                                    int available = Convert.ToInt32(reader["AvailableForDates"]);
                                    if (quantity > available)
                                        throw new InvalidOperationException("Only " + Math.Max(0, available) + " of " + Convert.ToString(reader["ProductName"]) + " are available for those event dates.");

                                    DataRow snapshot = currentCart.NewRow();
                                    snapshot["ProductId"] = productId;
                                    snapshot["Name"] = Convert.ToString(reader["ProductName"]);
                                    snapshot["Colour"] = Convert.ToString(reader["Colour"]);
                                    snapshot["UnitPrice"] = Convert.ToDecimal(reader["Price"]);
                                    snapshot["Quantity"] = quantity;
                                    snapshot["ImageUrl"] = item["ImageUrl"];
                                    currentCart.Rows.Add(snapshot);
                                    subtotal += Convert.ToDecimal(reader["Price"]) * quantity;
                                }
                            }
                        }

                        deliveryFee = companyTransport ? decimal.Round(subtotal * 0.07m, 2) : 0m;
                        setupFee = Convert.ToBoolean(session["SetupRequired"] ?? false) ? decimal.Round(subtotal * 0.03m, 2) : 0m;
                        total = subtotal + deliveryFee + setupFee + providerFee;

                        long bookingId = InsertBooking(connection, transaction, session, bookingReference, eventDate, startAt, endAt, subtotal, deliveryFee, setupFee, providerFee, total, companyTransport);
                        InsertBookingItems(connection, transaction, bookingId, currentCart);
                        InsertServiceProviders(connection, transaction, bookingId, session, rates);
                        InsertTasks(connection, transaction, bookingId, startAt, endAt, companyTransport, session);
                        InsertPayment(connection, transaction, bookingId, paymentReference, total, bank, cardLast4);
                        transaction.Commit();

                        session["BookingID"] = bookingId;
                        session["BookingReference"] = bookingReference;
                        session["PaymentReference"] = paymentReference;
                        session["PaymentAmount"] = total;
                        session["ConfirmedBookingItems"] = currentCart.Copy();
                        session["BookingTotal"] = subtotal;
                        session["DeliveryFee"] = deliveryFee;
                        session["SetupFee"] = setupFee;
                        session["ProviderFee"] = providerFee;
                        session["GrandTotal"] = total;

                        return new BookingPersistenceResult
                        {
                            BookingID = bookingId,
                            BookingReference = bookingReference,
                            PaymentReference = paymentReference,
                            Total = total,
                            Items = currentCart.Copy()
                        };
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }

        private static long InsertBooking(SqlConnection connection, SqlTransaction transaction, HttpSessionState session, string reference, DateTime eventDate, DateTime startAt, DateTime endAt, decimal subtotal, decimal deliveryFee, decimal setupFee, decimal providerFee, decimal total, bool companyTransport)
        {
            const string sql = @"
INSERT dbo.Bookings
(BookingReference, CustomerUserID, CustomerFullName, CustomerEmail, CustomerPhone, EventDate, EventType, EventNotes,
 BookingStatus, TransportMethod, DeliveryAddress, DeliveryCity, DeliveryProvince, DeliveryPostalCode,
 DeliveryDateTime, CompanyCollectionAt, CustomerCollectionAt, ReturnAt, TransportInstructions, SetupRequired,
 ItemSubtotal, DeliveryFee, SetupFee, ProviderFee, LateNoShowFeePolicy, LateNoShowFeeApplied, GrandTotal)
OUTPUT INSERTED.BookingID
VALUES
(@Reference, @UserID, @FullName, @Email, @Phone, @EventDate, @EventType, @EventNotes, N'Confirmed', @TransportMethod,
 @Address, @City, @Province, @PostalCode, @DeliveryAt, @CompanyCollectionAt, @CustomerCollectionAt,
 @ReturnAt, @Instructions, @Setup, @Subtotal, @DeliveryFee, @SetupFee, @ProviderFee, @LatePolicy, 0, @Total);";
            using (SqlCommand command = new SqlCommand(sql, connection, transaction))
            {
                command.Parameters.Add("@Reference", SqlDbType.NVarChar, 40).Value = reference;
                command.Parameters.Add("@UserID", SqlDbType.Int).Value = Convert.ToInt32(session["UserID"]);
                command.Parameters.Add("@FullName", SqlDbType.NVarChar, 150).Value = Get(session, "CustomerFullName", "");
                command.Parameters.Add("@Email", SqlDbType.NVarChar, 254).Value = Get(session, "CustomerEmail", "");
                command.Parameters.Add("@Phone", SqlDbType.NVarChar, 30).Value = Get(session, "CustomerPhone", "");
                command.Parameters.Add("@EventDate", SqlDbType.Date).Value = eventDate.Date;
                command.Parameters.Add("@EventType", SqlDbType.NVarChar, 80).Value = Get(session, "EventType", "Other");
                command.Parameters.Add("@EventNotes", SqlDbType.NVarChar, 1000).Value = DbValue(Get(session, "EventNotes", ""));
                command.Parameters.Add("@TransportMethod", SqlDbType.NVarChar, 60).Value = Get(session, "TransportMethod", "");
                command.Parameters.Add("@Address", SqlDbType.NVarChar, 250).Value = DbValue(Get(session, "DeliveryAddress", ""));
                command.Parameters.Add("@City", SqlDbType.NVarChar, 100).Value = DbValue(Get(session, "DeliveryCity", ""));
                command.Parameters.Add("@Province", SqlDbType.NVarChar, 60).Value = DbValue(Get(session, "DeliveryProvince", ""));
                command.Parameters.Add("@PostalCode", SqlDbType.NVarChar, 20).Value = DbValue(Get(session, "DeliveryPostalCode", ""));
                command.Parameters.Add("@DeliveryAt", SqlDbType.DateTime2).Value = companyTransport ? (object)startAt : DBNull.Value;
                command.Parameters.Add("@CompanyCollectionAt", SqlDbType.DateTime2).Value = companyTransport ? (object)endAt : DBNull.Value;
                command.Parameters.Add("@CustomerCollectionAt", SqlDbType.DateTime2).Value = companyTransport ? (object)DBNull.Value : startAt;
                command.Parameters.Add("@ReturnAt", SqlDbType.DateTime2).Value = companyTransport ? (object)DBNull.Value : endAt;
                command.Parameters.Add("@Instructions", SqlDbType.NVarChar, 1000).Value = DbValue(Get(session, "TransportInstructions", ""));
                command.Parameters.Add("@Setup", SqlDbType.Bit).Value = Convert.ToBoolean(session["SetupRequired"] ?? false);
                AddMoney(command, "@Subtotal", subtotal);
                AddMoney(command, "@DeliveryFee", deliveryFee);
                AddMoney(command, "@SetupFee", setupFee);
                AddMoney(command, "@ProviderFee", providerFee);
                AddMoney(command, "@LatePolicy", Money(session, "LateNoShowFeePolicy"));
                AddMoney(command, "@Total", total);
                return Convert.ToInt64(command.ExecuteScalar());
            }
        }

        private static void InsertBookingItems(SqlConnection connection, SqlTransaction transaction, long bookingId, DataTable cart)
        {
            const string sql = "INSERT dbo.BookingItems (BookingID, ProductID, ProductName, Colour, Quantity, UnitPrice) VALUES (@BookingID, @ProductID, @Name, @Colour, @Quantity, @Price);";
            foreach (DataRow row in cart.Rows)
            {
                using (SqlCommand command = new SqlCommand(sql, connection, transaction))
                {
                    command.Parameters.Add("@BookingID", SqlDbType.BigInt).Value = bookingId;
                    command.Parameters.Add("@ProductID", SqlDbType.Int).Value = row["ProductId"];
                    command.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = row["Name"];
                    command.Parameters.Add("@Colour", SqlDbType.NVarChar, 200).Value = row["Colour"];
                    command.Parameters.Add("@Quantity", SqlDbType.Int).Value = row["Quantity"];
                    AddMoney(command, "@Price", Convert.ToDecimal(row["UnitPrice"]));
                    command.ExecuteNonQuery();
                }
            }
        }

        private static void InsertServiceProviders(SqlConnection connection, SqlTransaction transaction, long bookingId, HttpSessionState session, Dictionary<string, ServiceRate> rates)
        {
            AddProvider(connection, transaction, bookingId, session, rates, "DJ", "DJQty", "DJHours");
            AddProvider(connection, transaction, bookingId, session, rates, "Caterer", "CatererQty", "CatererHours");
            AddProvider(connection, transaction, bookingId, session, rates, "Bartender", "BartenderQty", "BartenderHours");
            AddProvider(connection, transaction, bookingId, session, rates, "Waiter", "WaiterQty", "WaiterHours");
            AddProvider(connection, transaction, bookingId, session, rates, "Clown", "ClownQty", "ClownHours");
            AddProvider(connection, transaction, bookingId, session, rates, "Photographer", "PhotographerQty", "PhotographerHours");
        }

        private static void AddProvider(SqlConnection connection, SqlTransaction transaction, long bookingId, HttpSessionState session, Dictionary<string, ServiceRate> rates, string type, string quantityKey, string hoursKey)
        {
            int quantity = Integer(session, quantityKey);
            if (quantity < 1) return;
            ServiceRate rate = GetRate(rates, type);
            int hours = Math.Max(rate.MinimumHours, Integer(session, hoursKey));
            using (SqlCommand command = new SqlCommand(@"INSERT dbo.BookingServiceProviders (BookingID, ProviderType, Quantity, UnitFee, DurationHours)
VALUES (@BookingID, @Type, @Quantity, @Rate, @Hours);", connection, transaction))
            {
                command.Parameters.Add("@BookingID", SqlDbType.BigInt).Value = bookingId;
                command.Parameters.Add("@Type", SqlDbType.NVarChar, 40).Value = type;
                command.Parameters.Add("@Quantity", SqlDbType.Int).Value = quantity;
                AddMoney(command, "@Rate", rate.HourlyRate);
                SqlParameter duration = command.Parameters.Add("@Hours", SqlDbType.Decimal);
                duration.Precision = 5; duration.Scale = 2; duration.Value = hours;
                command.ExecuteNonQuery();
            }
        }

        private static void InsertTasks(SqlConnection connection, SqlTransaction transaction, long bookingId, DateTime startAt, DateTime endAt, bool companyTransport, HttpSessionState session)
        {
            string location = companyTransport
                ? string.Join(", ", new[] { Get(session, "DeliveryAddress", ""), Get(session, "DeliveryCity", ""), Get(session, "DeliveryProvince", ""), Get(session, "DeliveryPostalCode", "") })
                : "Forte Event Hire collection point";
            AddTask(connection, transaction, bookingId, companyTransport ? "Delivery" : "Customer Collection", startAt, location, Get(session, "TransportInstructions", ""));
            AddTask(connection, transaction, bookingId, companyTransport ? "Company Collection" : "Return", endAt, location, Get(session, "TransportInstructions", ""));
        }

        private static void AddTask(SqlConnection connection, SqlTransaction transaction, long bookingId, string type, DateTime time, string location, string instructions)
        {
            using (SqlCommand command = new SqlCommand(@"INSERT dbo.BookingTasks (BookingID, TaskType, ScheduledAt, TaskLocation, Instructions, TaskStatus)
VALUES (@BookingID, @Type, @Time, @Location, @Instructions, N'Pending');", connection, transaction))
            {
                command.Parameters.Add("@BookingID", SqlDbType.BigInt).Value = bookingId;
                command.Parameters.Add("@Type", SqlDbType.NVarChar, 30).Value = type;
                command.Parameters.Add("@Time", SqlDbType.DateTime2).Value = time;
                command.Parameters.Add("@Location", SqlDbType.NVarChar, 500).Value = DbValue(location);
                command.Parameters.Add("@Instructions", SqlDbType.NVarChar, 1000).Value = DbValue(instructions);
                command.ExecuteNonQuery();
            }
        }

        private static void InsertPayment(SqlConnection connection, SqlTransaction transaction, long bookingId, string reference, decimal amount, string bank, string cardLast4)
        {
            using (SqlCommand command = new SqlCommand(@"INSERT dbo.Payments (BookingID, PaymentReference, Amount, PaymentStatus, PaymentBank, CardLast4, PaidAt)
VALUES (@BookingID, @Reference, @Amount, N'Paid', @Bank, @CardLast4, SYSDATETIME());", connection, transaction))
            {
                command.Parameters.Add("@BookingID", SqlDbType.BigInt).Value = bookingId;
                command.Parameters.Add("@Reference", SqlDbType.NVarChar, 60).Value = reference;
                AddMoney(command, "@Amount", amount);
                command.Parameters.Add("@Bank", SqlDbType.NVarChar, 80).Value = DbValue(bank);
                command.Parameters.Add("@CardLast4", SqlDbType.Char, 4).Value = cardLast4;
                command.ExecuteNonQuery();
            }
        }

        private static DateTime BookingDateTime(HttpSessionState session, string dateKey, string timeKey, DateTime fallback)
        {
            DateTime date;
            TimeSpan time;
            return DateTime.TryParse(Get(session, dateKey, ""), out date) && TimeSpan.TryParse(Get(session, timeKey, ""), out time)
                ? date.Date.Add(time)
                : fallback;
        }

        private static decimal CalculateProviderFee(HttpSessionState session, Dictionary<string, ServiceRate> rates)
        {
            decimal total = 0m;
            foreach (ServiceRate rate in rates.Values)
            {
                int quantity = Integer(session, rate.ProviderType + "Qty");
                int hours = Math.Max(rate.MinimumHours, Integer(session, rate.ProviderType + "Hours"));
                total += quantity * hours * rate.HourlyRate;
            }
            return total;
        }

        private static ServiceRate GetRate(Dictionary<string, ServiceRate> rates, string provider)
        {
            ServiceRate rate;
            if (rates == null || !rates.TryGetValue(provider, out rate))
                throw new InvalidOperationException("No active rate is configured for " + provider + ".");
            return rate;
        }

        private static void AddMoney(SqlCommand command, string name, decimal value)
        {
            SqlParameter parameter = command.Parameters.Add(name, SqlDbType.Decimal);
            parameter.Precision = 12; parameter.Scale = 2; parameter.Value = value;
        }

        private static decimal Money(HttpSessionState session, string key)
        {
            decimal value;
            return decimal.TryParse(Convert.ToString(session[key]), out value) ? value : 0m;
        }

        private static int Integer(HttpSessionState session, string key)
        {
            int value;
            return int.TryParse(Convert.ToString(session[key]), out value) ? value : 0;
        }

        private static string Get(HttpSessionState session, string key, string fallback)
        {
            string value = Convert.ToString(session[key]);
            return string.IsNullOrWhiteSpace(value) ? fallback : value.Trim();
        }

        private static object DbValue(string value)
        {
            return string.IsNullOrWhiteSpace(value) ? (object)DBNull.Value : value.Trim();
        }
    }
}
