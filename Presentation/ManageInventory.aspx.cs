using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageInventory : Page
    {
        private string Category
        {
            get { return Convert.ToString(ViewState["InventoryCategory"] ?? ""); }
            set { ViewState["InventoryCategory"] = value; }
        }
        private DataTable GetItems()
        {
            DataTable t = Session["ManageInventoryDemo"] as DataTable;
            if (t != null) return t;
            t = new DataTable();
            t.Columns.Add("ProductID", typeof(int));
            t.Columns.Add("ProductName", typeof(string));
            t.Columns.Add("Category", typeof(string));
            t.Columns.Add("Colour", typeof(string)); t.Columns.Add("Price", typeof(decimal)); t.Columns.Add("QuantityAvailable", typeof(int)); t.Columns.Add("ImageUrl", typeof(string)); t.Columns.Add("IsAvailable", typeof(bool)); t.Columns.Add("Description", typeof(string)); t.Rows.Add(1, "Round Table (6 seat)", "Tables", "White", 120m, 35, "../Images/table-round.jpg", true, "Round event table."); t.Rows.Add(2, "Chiavari Chair", "Chairs", "Gold", 25m, 200, "../Images/chair-chiavari.jpg", true, "Classic event chair."); t.Rows.Add(3, "10 x 10 m Marquee", "Tents", "White", 1500m, 5, "../Images/marquee.jpg", true, "White event marquee."); t.Rows.Add(4, "Aisle Decorations", "Décor", "White & Green", 350m, 4, "../Images/aisle-decor.jpg", true, "Ceremony decoration set."); t.Rows.Add(5, "Dinner Set", "Catering", "White", 15m, 300, "../Images/dinner-set.jpg", true, "Dinner plate and cutlery set."); t.Rows.Add(6, "LED Uplighter", "Lighting", "Warm White", 180m, 0, "../Images/uplighter.jpg", false, "Warm white LED light."); Session["ManageInventoryDemo"] = t; return t;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            txtPrice.Attributes["step"] = "0.01";
            if (!IsPostBack) BindItems();
        }
        protected void btnShowForm_Click(object sender, EventArgs e)
        {
            ClearForm(); pnlForm.Visible = true; pnlMessage.Visible = false;
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false; ClearForm();
        }
        protected void Category_Click(object sender, EventArgs e)
        {
            LinkButton b = sender as LinkButton;
            if (b != null)
            {
                Category = b.CommandArgument ?? ""; BindItems();
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindItems();
        }
        private void BindItems()
        {
            DataTable all = GetItems(), outTable = all.Clone();
            string search = (txtSearch.Text ?? "").Trim();
            foreach (DataRow r in all.Rows)
            {
                if (Category != "" && !String.Equals(Convert.ToString(r["Category"]), Category, StringComparison.OrdinalIgnoreCase)) continue;
                if (ddlStatus.SelectedValue != "" && Convert.ToBoolean(r["IsAvailable"]) != (ddlStatus.SelectedValue == "1")) continue;
                if (search != "" && Convert.ToString(r["ProductName"]).IndexOf(search, StringComparison.OrdinalIgnoreCase) < 0 && Convert.ToString(r["Category"]).IndexOf(search, StringComparison.OrdinalIgnoreCase) < 0) continue; outTable.ImportRow(r);
            }
            rptItems.DataSource = outTable; rptItems.DataBind(); pnlEmpty.Visible = outTable.Rows.Count == 0;
            UpdateTabs();
        }
        private void UpdateTabs()
        {
            LinkButton[] b = { lnkAll, lnkTables, lnkChairs, lnkTents, lnkDecor, lnkCatering };
            string[] v = { "", "Tables", "Chairs", "Tents", "Décor", "Catering" };
            for (int i = 0; i < b.Length; i++) b[i].CssClass = "admin-filter-tab" + (Category == v[i] ? " active" : "");
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            decimal price; int qty;
            if (String.IsNullOrWhiteSpace(txtName.Text) || !Decimal.TryParse(txtPrice.Text, NumberStyles.Number, CultureInfo.InvariantCulture, out price) || price < 0 || !Int32.TryParse(txtQuantity.Text, out qty) || qty < 0)
            {
                Show("Enter an item name, a valid price and a non-negative quantity.", false); return;
            }
            DataTable t = GetItems();
            int id; DataRow r;
            if (Int32.TryParse(hfProductID.Value, out id) && t.Select("ProductID=" + id).Length > 0) r = t.Select("ProductID=" + id)[0];
            else
            {
                id = 1; foreach (DataRow row in t.Rows) id = Math.Max(id, Convert.ToInt32(row["ProductID"]) + 1); r = t.NewRow(); r["ProductID"] = id; t.Rows.Add(r);
            }
            r["ProductName"] = txtName.Text.Trim();
            r["Category"] = txtCategory.Text.Trim();
            r["Colour"] = txtColour.Text.Trim();
            r["Price"] = price;
            r["QuantityAvailable"] = qty; 
            r["ImageUrl"] = String.IsNullOrWhiteSpace(txtImageUrl.Text) ? "../Images/item.jpg" : txtImageUrl.Text.Trim();
            r["IsAvailable"] = chkAvailable.Checked; r["Description"] = "Sample inventory item."; 
            pnlForm.Visible = false; Show("Inventory item saved in the session sample data.", true);
            ClearForm();
            BindItems();
        }
        protected void rptItems_ItemCommand(object sender, RepeaterCommandEventArgs e) 
        {
            int id; if (!Int32.TryParse(Convert.ToString(e.CommandArgument), out id)) return; DataTable t = GetItems();
            DataRow[] found = t.Select("ProductID=" + id);
            if (found.Length == 0) return; 
            DataRow r = found[0]; if (e.CommandName == "ToggleItem")
            {
                r["IsAvailable"] = !Convert.ToBoolean(r["IsAvailable"]); Show("Item availability updated in the session sample data.", true);
            }
            else if (e.CommandName == "EditItem")
            {
                hfProductID.Value = id.ToString(); 
                txtName.Text = Convert.ToString(r["ProductName"]);
                txtCategory.Text = Convert.ToString(r["Category"]);
                txtColour.Text = Convert.ToString(r["Colour"]);
                txtPrice.Text = Convert.ToDecimal(r["Price"]).ToString(CultureInfo.InvariantCulture);
                txtQuantity.Text = Convert.ToString(r["QuantityAvailable"]); txtImageUrl.Text = Convert.ToString(r["ImageUrl"]); 
                chkAvailable.Checked = Convert.ToBoolean(r["IsAvailable"]); litFormTitle.Text = "Edit Inventory Item"; pnlForm.Visible = true;
            }
            BindItems();
        }
        public string FormatRands(object v) 
        {
            decimal n = v == null || v == DBNull.Value ? 0m : Convert.ToDecimal(v); return "R " + n.ToString("N2", CultureInfo.GetCultureInfo("en-ZA"));
        }
        private void ClearForm()
        {
            hfProductID.Value = ""; txtName.Text = txtCategory.Text = txtColour.Text = txtPrice.Text = txtQuantity.Text = txtImageUrl.Text = "";
            chkAvailable.Checked = true; litFormTitle.Text = "Add Inventory Item";
        }
        private void Show(string s, bool ok) 
        {
            pnlMessage.Visible = true; pnlMessage.CssClass = ok ? "alert alert-success" : "alert alert-warning"; lblMessage.Text = Server.HtmlEncode(s);
        }
    }
}

