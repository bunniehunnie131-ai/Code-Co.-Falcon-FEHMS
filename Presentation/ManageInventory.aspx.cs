using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageInventory : Page
    {
        private string ConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["ForteDB"].ConnectionString; }
        }

        private string CategoryFilter
        {
            get { return Convert.ToString(ViewState["InventoryCategory"] ?? String.Empty); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            txtPrice.Attributes["step"] = "0.01";
            if (!IsPostBack) BindItems();
        }

        protected void btnShowForm_Click(object sender, EventArgs e)
        {
            ClearForm();
            pnlForm.Visible = true;
            pnlMessage.Visible = false;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
            ClearForm();
        }

        protected void Category_Click(object sender, EventArgs e)
        {
            LinkButton button = sender as LinkButton;
            if (button == null) return;
            ViewState["InventoryCategory"] = button.CommandArgument;
            BindItems();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindItems();
        }

        private void BindItems()
        {
            const string sql = @"SELECT ProductID,ProductName,Category,Colour,Price,QuantityAvailable,ImageUrl,IsAvailable
                FROM dbo.Product
                WHERE (@Category=N'' OR Category LIKE N'%'+@Category+N'%')
                  AND (@Status IS NULL OR IsAvailable=@Status)
                  AND (@Search=N'' OR ProductName LIKE N'%'+@Search+N'%' OR Category LIKE N'%'+@Search+N'%')
                ORDER BY ProductName;";
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.Add("@Category", SqlDbType.NVarChar, 80).Value = CategoryFilter;
                    command.Parameters.Add("@Status", SqlDbType.Bit).Value = String.IsNullOrEmpty(ddlStatus.SelectedValue)
                        ? (object)DBNull.Value : ddlStatus.SelectedValue == "1";
                    command.Parameters.Add("@Search", SqlDbType.NVarChar, 150).Value = (txtSearch.Text ?? String.Empty).Trim();
                    DataTable table = new DataTable();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command)) adapter.Fill(table);
                    rptItems.DataSource = table;
                    rptItems.DataBind();
                    pnlEmpty.Visible = table.Rows.Count == 0;
                    UpdateTabs();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError("Inventory page load failed: " + ex);
                Show("Inventory could not be loaded from ForteDB." + (Request.IsLocal ? " " + ex.Message : String.Empty), false);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            decimal price;
            int quantity;
            int productId;
            bool editing = Int32.TryParse(hfProductID.Value, out productId);
            if (String.IsNullOrWhiteSpace(txtName.Text) || String.IsNullOrWhiteSpace(txtCategory.Text) ||
                !Decimal.TryParse(txtPrice.Text, NumberStyles.Number, CultureInfo.InvariantCulture, out price) || price < 0 ||
                !Int32.TryParse(txtQuantity.Text, out quantity) || quantity < 0)
            {
                Show("Enter an item name, category, non-negative price and non-negative quantity.", false);
                return;
            }

            string sql = editing
                ? @"UPDATE dbo.Product SET ProductName=@Name,Category=@Category,Colour=@Colour,Price=@Price,
                    QuantityAvailable=@Quantity,ImageUrl=@Image,IsAvailable=@Available,UpdatedAt=SYSUTCDATETIME()
                    WHERE ProductID=@ID;"
                : @"INSERT dbo.Product(ProductName,Description,Category,Colour,Price,QuantityAvailable,ImageUrl,IsAvailable)
                    VALUES(@Name,NULL,@Category,@Colour,@Price,@Quantity,@Image,@Available);";
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    AddParameters(command, price, quantity);
                    if (editing) command.Parameters.Add("@ID", SqlDbType.Int).Value = productId;
                    connection.Open();
                    command.ExecuteNonQuery();
                }
                pnlForm.Visible = false;
                ClearForm();
                BindItems();
                Show(editing ? "Inventory item updated." : "Inventory item added.", true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError("Inventory save failed: " + ex);
                Show("The item could not be saved." + (Request.IsLocal ? " " + ex.Message : String.Empty), false);
            }
        }

        private void AddParameters(SqlCommand command, decimal price, int quantity)
        {
            command.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtName.Text.Trim();
            command.Parameters.Add("@Category", SqlDbType.NVarChar, 80).Value = txtCategory.Text.Trim();
            command.Parameters.Add("@Colour", SqlDbType.NVarChar, 200).Value = String.IsNullOrWhiteSpace(txtColour.Text) ? "Various" : txtColour.Text.Trim();
            SqlParameter priceParameter = command.Parameters.Add("@Price", SqlDbType.Decimal);
            priceParameter.Precision = 12;
            priceParameter.Scale = 2;
            priceParameter.Value = price;
            command.Parameters.Add("@Quantity", SqlDbType.Int).Value = quantity;
            command.Parameters.Add("@Image", SqlDbType.NVarChar, 500).Value = String.IsNullOrWhiteSpace(txtImageUrl.Text)
                ? "../Images/Chairs.jpg?item=" + Guid.NewGuid().ToString("N") : txtImageUrl.Text.Trim();
            command.Parameters.Add("@Available", SqlDbType.Bit).Value = chkAvailable.Checked;
        }

        protected void rptItems_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            int productId;
            if (!Int32.TryParse(Convert.ToString(e.CommandArgument), out productId)) return;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    connection.Open();
                    if (e.CommandName == "ToggleItem")
                    {
                        using (SqlCommand command = new SqlCommand("UPDATE dbo.Product SET IsAvailable=CASE WHEN IsAvailable=1 THEN 0 ELSE 1 END,UpdatedAt=SYSUTCDATETIME() WHERE ProductID=@ID;", connection))
                        {
                            command.Parameters.Add("@ID", SqlDbType.Int).Value = productId;
                            command.ExecuteNonQuery();
                        }
                    }
                    else if (e.CommandName == "EditItem")
                    {
                        const string sql = "SELECT ProductName,Category,Colour,Price,QuantityAvailable,ImageUrl,IsAvailable FROM dbo.Product WHERE ProductID=@ID;";
                        using (SqlCommand command = new SqlCommand(sql, connection))
                        {
                            command.Parameters.Add("@ID", SqlDbType.Int).Value = productId;
                            using (SqlDataReader reader = command.ExecuteReader())
                            {
                                if (!reader.Read()) return;
                                hfProductID.Value = productId.ToString(CultureInfo.InvariantCulture);
                                txtName.Text = Convert.ToString(reader["ProductName"]);
                                txtCategory.Text = Convert.ToString(reader["Category"]);
                                txtColour.Text = Convert.ToString(reader["Colour"]);
                                txtPrice.Text = Convert.ToDecimal(reader["Price"]).ToString(CultureInfo.InvariantCulture);
                                txtQuantity.Text = Convert.ToString(reader["QuantityAvailable"]);
                                txtImageUrl.Text = Convert.ToString(reader["ImageUrl"]);
                                chkAvailable.Checked = Convert.ToBoolean(reader["IsAvailable"]);
                                litFormTitle.Text = "Edit Inventory Item";
                                btnSave.Text = "Save Changes";
                                pnlForm.Visible = true;
                            }
                        }
                    }
                }
                BindItems();
                if (e.CommandName == "ToggleItem") Show("Item availability updated.", true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError("Inventory update failed: " + ex);
                Show("Could not update the inventory item." + (Request.IsLocal ? " " + ex.Message : String.Empty), false);
            }
        }

        private void UpdateTabs()
        {
            lnkAll.CssClass = "admin-filter-tab" + (CategoryFilter == String.Empty ? " active" : String.Empty);
            lnkTables.CssClass = "admin-filter-tab" + (CategoryFilter == "Tables" ? " active" : String.Empty);
            lnkChairs.CssClass = "admin-filter-tab" + (CategoryFilter == "Chairs" ? " active" : String.Empty);
            lnkTents.CssClass = "admin-filter-tab" + (CategoryFilter == "Tents" ? " active" : String.Empty);
            lnkDecor.CssClass = "admin-filter-tab" + (CategoryFilter == "Décor" ? " active" : String.Empty);
            lnkCatering.CssClass = "admin-filter-tab" + (CategoryFilter == "Catering" ? " active" : String.Empty);
        }

        public string FormatRands(object value)
        {
            decimal amount;
            return Decimal.TryParse(Convert.ToString(value), out amount)
                ? "R" + amount.ToString("N2", CultureInfo.GetCultureInfo("en-ZA"))
                : "R0.00";
        }

        private void ClearForm()
        {
            hfProductID.Value = String.Empty;
            txtName.Text = txtCategory.Text = txtColour.Text = txtPrice.Text = txtQuantity.Text = txtImageUrl.Text = String.Empty;
            chkAvailable.Checked = true;
            litFormTitle.Text = "Add Inventory Item";
            btnSave.Text = "Save Item";
        }

        private void Show(string message, bool success)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = success ? "alert alert-success" : "alert alert-danger";
            lblMessage.Text = Server.HtmlEncode(message);
        }
    }
}

