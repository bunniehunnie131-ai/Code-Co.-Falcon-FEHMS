using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManagePackages : Page
    {
        private DataTable GetPackages() 
        {
            DataTable t = Session["ManagePackagesDemo"] as DataTable;
            if (t != null) return t;
            t = new DataTable();
            t.Columns.Add("ProductID", typeof(int));
            t.Columns.Add("ProductName", typeof(string)); 
            t.Columns.Add("Category", typeof(string)); 
            t.Columns.Add("Colour", typeof(string));
            t.Columns.Add("Price", typeof(decimal));
            t.Columns.Add("QuantityAvailable", typeof(int));
            t.Columns.Add("ImageUrl", typeof(string));
            t.Columns.Add("IsAvailable", typeof(bool));
            t.Columns.Add("Description", typeof(string));
            t.Rows.Add(1, "Basic Décor Package", "Packages", "White", 2500m, 12, "../Images/package-basic.jpg", true, "Table runners, centrepieces and matching décor.");
            t.Rows.Add(2, "Premium Décor Package", "Packages", "Gold", 5200m, 8, "../Images/package-premium.jpg", true, "Premium styling and ceremony décor."); 
            t.Rows.Add(3, "Catering Pack 1", "Combined", "Various", 4500m, 10, "../Images/package-catering.jpg", true, "Catering setup for up to 50 guests.");
            t.Rows.Add(4, "Full Event Package", "Combined", "Various", 12000m, 5, "../Images/package-event.jpg", true, "Décor, tables and seating for an event."); 
            Session["ManagePackagesDemo"] = t;
            return t; }
        protected void Page_Load(object sender, EventArgs e) 
        {
            txtPrice.Attributes["step"] = "0.01"; 
            if (!IsPostBack) BindPackages();
        }
        protected void btnAddPackage_Click(object sender, EventArgs e)
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
        protected void btnSearch_Click(object sender, EventArgs e) 
        {
            BindPackages();
        }
        private void BindPackages() 
        {
            DataTable all = GetPackages(), rows = all.Clone();
            string q = (txtSearch.Text ?? "").Trim(); 
            foreach (DataRow r in all.Rows) 
            {
                string cat = Convert.ToString(r["Category"]), name = Convert.ToString(r["ProductName"]);
                if (cat.IndexOf("Package", StringComparison.OrdinalIgnoreCase) < 0 && name.IndexOf("Package", StringComparison.OrdinalIgnoreCase) < 0 && cat != "Combined") continue;
                if (q != "" && name.IndexOf(q, StringComparison.OrdinalIgnoreCase) < 0 && cat.IndexOf(q, StringComparison.OrdinalIgnoreCase) < 0) continue; rows.ImportRow(r);
            }
            rptPackages.DataSource = rows;
            rptPackages.DataBind();
            pnlEmpty.Visible = rows.Rows.Count == 0;
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            decimal price; int qty;
            if (String.IsNullOrWhiteSpace(txtName.Text) || !Decimal.TryParse(txtPrice.Text, NumberStyles.Number, CultureInfo.InvariantCulture, out price) || price < 0 || !Int32.TryParse(txtQuantity.Text, out qty) || qty < 0) 
            {
                Show("Enter a package name, valid price and non-negative quantity.", false); return;
            }
            DataTable t = GetPackages(); 
            int id; 
            DataRow r;
            if (Int32.TryParse(hfProductID.Value, out id) && t.Select("ProductID=" + id).Length > 0) r = t.Select("ProductID=" + id)[0];
            else 
            {
                id = 1; foreach (DataRow row in t.Rows) id = Math.Max(id, Convert.ToInt32(row["ProductID"]) + 1);
                r = t.NewRow(); r["ProductID"] = id; t.Rows.Add(r);
            }
            r["ProductName"] = txtName.Text.Trim(); 
            r["Category"] = String.IsNullOrWhiteSpace(txtCategory.Text) ? "Packages" : txtCategory.Text.Trim(); 
            r["Description"] = txtDescription.Text.Trim();
            r["Price"] = price; r["QuantityAvailable"] = qty;
            r["Colour"] = txtColour.Text.Trim();
            r["ImageUrl"] = String.IsNullOrWhiteSpace(txtImage.Text) ? "../Images/package.jpg" : txtImage.Text.Trim();
            r["IsAvailable"] = true; pnlForm.Visible = false; 
            Show("Package saved in the session sample data.", true); 
            ClearForm();
            BindPackages();
        }
        protected void rptPackages_ItemCommand(object sender, RepeaterCommandEventArgs e) 
        {
            int id; 
            if (!Int32.TryParse(Convert.ToString(e.CommandArgument), out id)) return; DataRow[] rows = GetPackages().Select("ProductID=" + id);
            if (rows.Length == 0) return; DataRow r = rows[0];
            if (e.CommandName == "TogglePackage") { r["IsAvailable"] = !Convert.ToBoolean(r["IsAvailable"]); 
                Show("Package availability updated in the session sample data.", true);
            } 
            else if (e.CommandName == "EditPackage") 
            {
                hfProductID.Value = id.ToString();
                txtName.Text = Convert.ToString(r["ProductName"]);
                txtCategory.Text = Convert.ToString(r["Category"]);
                txtDescription.Text = Convert.ToString(r["Description"]); 
                txtPrice.Text = Convert.ToDecimal(r["Price"]).ToString(CultureInfo.InvariantCulture); 
                txtQuantity.Text = Convert.ToString(r["QuantityAvailable"]);
                txtColour.Text = Convert.ToString(r["Colour"]); 
                txtImage.Text = Convert.ToString(r["ImageUrl"]); 
                litFormTitle.Text = "Edit package"; pnlForm.Visible = true;
            }
            BindPackages(); 
        }
        public string FormatDollars(object v) 
        {
            decimal n = v == null || v == DBNull.Value ? 0m : Convert.ToDecimal(v); return "R " + n.ToString("N2", CultureInfo.GetCultureInfo("en-ZA")); 
        }
        private void ClearForm() 
        {
            hfProductID.Value = "";
            txtName.Text = txtDescription.Text = txtPrice.Text = txtQuantity.Text = txtColour.Text = txtImage.Text = "";
            txtCategory.Text = "Packages"; 
            litFormTitle.Text = "Add package";
        }
        private void Show(string s, bool ok) 
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = ok ? "alert alert-success" : "alert alert-warning"; 
            lblMessage.Text = Server.HtmlEncode(s);
        }
    }
}

