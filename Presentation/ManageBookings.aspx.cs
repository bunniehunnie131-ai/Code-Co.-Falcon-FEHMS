using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageBookings : System.Web.UI.Page
    {
        private string StatusFilter
        {
            get { return Convert.ToString(ViewState["StatusFilter"] ?? ""); }
            set { ViewState["StatusFilter"] = value; } 
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindBookings();
        }
        protected void Filter_Click(object sender, EventArgs e)
        {
            LinkButton b = sender as LinkButton; 
            if (b != null) 
            {
                StatusFilter = b.CommandArgument ?? ""; BindBookings(); 
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DateTime f, t;
            if (TryDate(txtFrom.Text, out f) && TryDate(txtTo.Text, out t) && f.Date > t.Date)
            {
                Show("The start date must be on or before the end date.", false); return; 
            }
            BindBookings();
        }
        private DataTable GetBookings()
        {
            DataTable t = Session["ManageBookingsDemo"] as DataTable;
            if (t != null) return t;
            t = new DataTable();
            t.Columns.Add("BookingID", typeof(int));
            t.Columns.Add("BookingReference", typeof(string));
            t.Columns.Add("CustomerFullName", typeof(string));
            t.Columns.Add("CustomerEmail", typeof(string));
            t.Columns.Add("EventType", typeof(string));
            t.Columns.Add("EventDate", typeof(DateTime));
            t.Columns.Add("GrandTotal", typeof(decimal));
            t.Columns.Add("BookingStatus", typeof(string));
            t.Columns.Add("StatusCss", typeof(string));
            Add(t, 1, "FEH-20261031-WED01", "Fortune Makhubela", "fortune.makhubela@example.test", "Wedding", new DateTime(2026, 10, 31), 51750m, "Confirmed");
            Add(t, 2, "FEH-20261103-BDY02", "Amina Jacobs", "amina.jacobs@example.test", "Birthday", new DateTime(2026, 11, 3), 12800m, "Pending"); 
            Add(t, 3, "FEH-20261108-COR03", "Lwazi Mbeki", "lwazi.mbeki@example.test", "Corporate Event", new DateTime(2026, 11, 8), 38400m, "Confirmed"); 
            Add(t, 4, "FEH-20261114-GAL04", "Thandi Nkomo", "thandi.nkomo@example.test", "School Gala", new DateTime(2026, 11, 14), 22650m, "Pending");
            Add(t, 5, "FEH-20261120-ENG05", "Priya Singh", "priya.singh@example.test", "Engagement", new DateTime(2026, 11, 20), 31900m, "Draft");
            Add(t, 6, "FEH-20261205-WED06", "James Dlamini", "james.dlamini@example.test", "Wedding", new DateTime(2026, 12, 5), 62400m, "Confirmed");
            Add(t, 7, "FEH-20261212-BDY07", "Sarah White", "sarah.white@example.test", "Birthday", new DateTime(2026, 12, 12), 9650m, "Cancelled");
            Add(t, 8, "FEH-20261219-COR08", "Mike Adams", "mike.adams@example.test", "Corporate Event", new DateTime(2026, 12, 19), 45800m, "Pending");
            Session["ManageBookingsDemo"] = t; return t; }
        private void Add(DataTable t, int id, string reference, string name, string email, string type, DateTime date, decimal total, string status) 
        {
            t.Rows.Add(id, reference, name, email, type, date, total, status, StatusCss(status));
        }
        private string StatusCss(string s)
        {
            return s == "Confirmed" ? "badge text-bg-success" : s == "Pending" ? "badge text-bg-warning" : s == "Cancelled" ? "badge text-bg-danger" : "badge text-bg-primary"; 
        }
        private void BindBookings()
        {
            DataTable all = GetBookings(), rows = all.Clone();
            string term = (txtSearch.Text ?? "").Trim();
            DateTime from, to; bool hf = TryDate(txtFrom.Text, out from), ht = TryDate(txtTo.Text, out to);
            foreach (DataRow r in all.Rows)
            { string st = Convert.ToString(r["BookingStatus"]);
                DateTime d = Convert.ToDateTime(r["EventDate"]); 
                if (StatusFilter != "" && st != StatusFilter) continue;
                if (hf && d.Date < from.Date) continue; if (ht && d.Date > to.Date) continue;
                if (term != "" && Convert.ToString(r["BookingReference"]).IndexOf(term, StringComparison.OrdinalIgnoreCase) < 0 && Convert.ToString(r["CustomerFullName"]).IndexOf(term, StringComparison.OrdinalIgnoreCase) < 0 && Convert.ToString(r["EventType"]).IndexOf(term, StringComparison.OrdinalIgnoreCase) < 0) continue; rows.ImportRow(r);
            }
            litAllCount.Text = all.Rows.Count.ToString(); 
            litPendingCount.Text = all.Select("BookingStatus='Pending'").Length.ToString();
            litConfirmedCount.Text = all.Select("BookingStatus='Confirmed'").Length.ToString();
            litCancelledCount.Text = all.Select("BookingStatus='Cancelled'").Length.ToString();
            lnkAll.CssClass = "admin-filter-tab"; lnkPending.CssClass = "admin-filter-tab";
            lnkConfirmed.CssClass = "admin-filter-tab"; lnkCancelled.CssClass = "admin-filter-tab"; 
            if (StatusFilter == "Pending") lnkPending.CssClass += " active"; 
            else if (StatusFilter == "Confirmed") lnkConfirmed.CssClass += " active"; 
            else if (StatusFilter == "Cancelled") lnkCancelled.CssClass += " active";
            else lnkAll.CssClass += " active"; rptBookings.DataSource = rows; rptBookings.DataBind();
            pnlEmpty.Visible = rows.Rows.Count == 0;
        }
        protected void rptBookings_ItemCommand(object source, RepeaterCommandEventArgs e)
        { if (e.CommandName != "UpdateStatus") return; int id;
            if (!Int32.TryParse(Convert.ToString(e.CommandArgument), out id)) return;
            DropDownList d = e.Item.FindControl("ddlRowStatus") as DropDownList;
            DataRow[] rows = GetBookings().Select("BookingID=" + id); 
            if (d == null || rows.Length == 0) return; rows[0]["BookingStatus"] = d.SelectedValue; rows[0]["StatusCss"] = StatusCss(d.SelectedValue); Show("Booking status updated in this session.", true);
            BindBookings();
        }
        protected string FormatRands(object value)
        {
            decimal n = value == null || value == DBNull.Value ? 0m : Convert.ToDecimal(value); return "R " + n.ToString("N2", CultureInfo.GetCultureInfo("en-ZA"));
        }
        private static bool TryDate(string s, out DateTime d)
        {
            return DateTime.TryParseExact(s, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out d); 
        }
        private void Show(string text, bool success)
        {
            pnlMessage.Visible = true; pnlMessage.CssClass = success ? "alert alert-success" : "alert alert-warning"; lblMessage.Text = Server.HtmlEncode(text);
        }
    }

}