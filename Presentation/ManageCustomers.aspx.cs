using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageCustomers : System.Web.UI.Page
    {
        private DataTable GetCustomers()
        {
            DataTable t = Session["ManageCustomersDemo"] as DataTable;
            if (t != null) return t;
            t = new DataTable();
            t.Columns.Add("CustomerID", typeof(string));
            t.Columns.Add("UserID", typeof(int));
            t.Columns.Add("FirstName", typeof(string));
            t.Columns.Add("LastName", typeof(string));
            t.Columns.Add("FullName", typeof(string));
            t.Columns.Add("EmailAddress", typeof(string));
            t.Columns.Add("PhoneNumber", typeof(string));
            t.Columns.Add("DateOfBirth", typeof(DateTime));
            t.Columns.Add("IDNumber", typeof(string));
            t.Columns.Add("BookingCount", typeof(int));
            t.Columns.Add("IsActive", typeof(bool));
            t.Columns.Add("Status", typeof(string));
            AddCustomer(t, 101, "Fortune", "Makhubela", "fortune.makhubela@example.test", "060 896 7709", 3, true);
            AddCustomer(t, 102, "Sipho", "Mthembu", "sipho.mthembu@example.test", "072 123 4567", 2, true);
            AddCustomer(t, 103, "Lerato", "Tau", "lerato.tau@example.test", "082 456 7890", 1, true);
            AddCustomer(t, 104, "Grace", "Chuma", "grace.chuma@example.test", "083 555 1212", 2, true);
            AddCustomer(t, 105, "Amina", "Jacobs", "amina.jacobs@example.test", "071 555 0184", 1, false);
            Session["ManageCustomersDemo"] = t;
            return t;
        }
        private void AddCustomer(DataTable t, int id, string first, string last, string email, string phone, int count, bool active)
        {
            t.Rows.Add("CUS" + id.ToString("D3"), id, first, last, first + " " + last, email, phone, new DateTime(1998, 5, 23), "", count, active, active ? "Active" : "Inactive");
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindCustomers();
        }
        protected void btnShowAdd_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblFormHeading.Text = "Add Customer";
            btnSaveCustomer.Text = "Add Customer";
            customerPasswordRow.Visible = true;
            customerTermsRow.Visible = true;
            pnlCustomerForm.Visible = true;
            pnlMessage.Visible = false;
        }
        protected void btnCancelForm_Click(object sender, EventArgs e)
        {
            pnlCustomerForm.Visible = false;
            ClearForm();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindCustomers();
        }
        protected void btnSaveCustomer_Click(object sender, EventArgs e)
        {
            Page.Validate("CustomerForm");
            if (!Page.IsValid) return; string email = (txtEmailAddress.Text ?? "").Trim();
            if (email.IndexOf('@') < 1) { ShowMessage("Enter a valid email address.", false); return; }
            bool isNew = String.IsNullOrEmpty(hfCustomerUserId.Value);
            if (isNew)
            {
                if ((txtCustomerPassword.Text ?? "").Length < 12)
                {
                    ShowMessage("The temporary password must be at least 12 characters.", false); return;
                }
                if (txtCustomerPassword.Text != txtConfirmPassword.Text)
                {
                    ShowMessage("The password and confirmation do not match.", false); return;
                }
                if (!chkTermsAccepted.Checked)
                {
                    ShowMessage("The customer must accept the Terms and Conditions.", false);
                    return;
                }
            }
            DataTable t = GetCustomers();
            int id; DataRow r;
            if (Int32.TryParse(hfCustomerUserId.Value, out id) && t.Select("UserID=" + id).Length > 0) r = t.Select("UserID=" + id)[0];
            else
            {
                id = 100;
                foreach (DataRow row in t.Rows) id = Math.Max(id, Convert.ToInt32(row["UserID"]));
                id++; r = t.NewRow(); r["CustomerID"] = "CUS" + id.ToString("D3");
                r["UserID"] = id; r["BookingCount"] = 0; t.Rows.Add(r);
            }
            r["FirstName"] = txtFirstName.Text.Trim();
            r["LastName"] = txtLastName.Text.Trim();
            r["FullName"] = txtFirstName.Text.Trim() + " " + txtLastName.Text.Trim(); r["EmailAddress"] = email;
            r["PhoneNumber"] = txtPhoneNumber.Text.Trim(); DateTime dob;
            r["DateOfBirth"] = DateTime.TryParseExact(txtDateOfBirth.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out dob) ? (object)dob : DBNull.Value;
            r["IDNumber"] = txtIDNumber.Text.Trim();
            r["IsActive"] = chkActive.Checked;
            r["Status"] = chkActive.Checked ? "Active" : "Inactive";
            pnlCustomerForm.Visible = false; ClearForm();
            ShowMessage("Customer saved in the session sample data.", true);
            BindCustomers();
        }
        protected void rptCustomers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id; if (!Int32.TryParse(Convert.ToString(e.CommandArgument), out id)) return; DataRow[] rows = GetCustomers().Select("UserID=" + id);
            if (rows.Length == 0) return;
            DataRow r = rows[0];
            if (e.CommandName == "ToggleStatus")
            {
                bool active = !Convert.ToBoolean(r["IsActive"]);
                r["IsActive"] = active; r["Status"] = active ? "Active" : "Inactive"; ShowMessage("Customer account status updated.", true);
            }
            else if (e.CommandName == "EditCustomer")
            {
                hfCustomerUserId.Value = Convert.ToString(r["UserID"]); txtFirstName.Text = Convert.ToString(r["FirstName"]);
                txtLastName.Text = Convert.ToString(r["LastName"]);
                txtEmailAddress.Text = Convert.ToString(r["EmailAddress"]);
                txtPhoneNumber.Text = Convert.ToString(r["PhoneNumber"]);
                txtIDNumber.Text = Convert.ToString(r["IDNumber"]);
                DateTime d; if (DateTime.TryParse(Convert.ToString(r["DateOfBirth"]), out d)) txtDateOfBirth.Text = d.ToString("yyyy-MM-dd");
                chkActive.Checked = Convert.ToBoolean(r["IsActive"]);
                lblFormHeading.Text = "Edit Customer"; btnSaveCustomer.Text = "Save Changes";
                customerPasswordRow.Visible = false; customerTermsRow.Visible = false;
                pnlCustomerForm.Visible = true;
            }
            BindCustomers();
        }
        private void BindCustomers()
        {
            DataTable all = GetCustomers(), rows = all.Clone();
            string q = (txtSearch.Text ?? "").Trim();
            foreach (DataRow r in all.Rows)
            {
                if (ddlStatus.SelectedValue != "" && Convert.ToBoolean(r["IsActive"]) != (ddlStatus.SelectedValue == "1")) continue;
                if (q != "" && Convert.ToString(r["FullName"]).
                    IndexOf(q, StringComparison.OrdinalIgnoreCase) < 0 && Convert.ToString(r["EmailAddress"]).
                    IndexOf(q, StringComparison.OrdinalIgnoreCase) < 0 && Convert.ToString(r["PhoneNumber"]).
                    IndexOf(q, StringComparison.OrdinalIgnoreCase) < 0) continue; rows.ImportRow(r);
            }
            rptCustomers.DataSource = rows;
            rptCustomers.DataBind();
            pnlNoCustomers.Visible = rows.Rows.Count == 0;
        }
        private void ClearForm()
        {
            hfCustomerUserId.Value = ""; txtFirstName.Text = txtLastName.Text = txtEmailAddress.Text = txtDateOfBirth.Text = txtIDNumber.Text = txtPhoneNumber.Text = txtCustomerPassword.Text = txtConfirmPassword.Text = "";
            chkTermsAccepted.Checked = false; chkActive.Checked = true;
        }
        private void ShowMessage(string s, bool ok)
        {
            pnlMessage.Visible = true; pnlMessage.CssClass = ok ? "alert alert-success" : "alert alert-warning"; lblMessage.Text = Server.HtmlEncode(s);
        }
    }
}