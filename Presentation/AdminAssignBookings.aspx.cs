using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class AdminAssignBookings : System.Web.UI.Page
    {
        private DataTable GetTasks()
        {
            DataTable t = Session["AssignBookingsDemo"] as DataTable;
            if (t != null) return t;
            t = new DataTable();
            t.Columns.Add("TaskID", typeof(int));
            t.Columns.Add("BookingReference", typeof(string));
            t.Columns.Add("CustomerFullName", typeof(string));
            t.Columns.Add("EventType", typeof(string));
            t.Columns.Add("TaskType", typeof(string));
            t.Columns.Add("ScheduledAt", typeof(DateTime));
            t.Columns.Add("TaskLocation", typeof(string));
            t.Columns.Add("TaskStatus", typeof(string));
            t.Columns.Add("AssignedStaffID", typeof(string));
            t.Rows.Add(501, "FEH-20261031-WED01", "Fortune Makhubela", "Wedding", "Delivery", new DateTime(2026, 10, 31, 7, 0, 0), "Berea, Eastern Cape", "Scheduled", "");
            t.Rows.Add(502, "FEH-20261031-WED01", "Fortune Makhubela", "Wedding", "Company Collection", new DateTime(2026, 10, 31, 18, 30, 0), "Berea, Eastern Cape", "Scheduled", "");
            t.Rows.Add(503, "FEH-20261103-BDY02", "Amina Jacobs", "Birthday", "Delivery", new DateTime(2026, 11, 3, 9, 0, 0), "East London, Eastern Cape", "Pending", "");
            t.Rows.Add(504, "FEH-20261103-BDY02", "Amina Jacobs", "Birthday", "Company Collection", new DateTime(2026, 11, 3, 22, 0, 0), "East London, Eastern Cape", "Scheduled", "");
            t.Rows.Add(505, "FEH-20261108-COR03", "Lwazi Mbeki", "Corporate Event", "Delivery", new DateTime(2026, 11, 8, 8, 0, 0), "Mthatha, Eastern Cape", "Scheduled", "");
            Session["AssignBookingsDemo"] = t;
            return t;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindTasks();
        }
        private void BindTasks()
        {
            gvTasks.DataSource = GetTasks();
            gvTasks.DataBind();
        }
        protected void gvTasks_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;
            DropDownList d = e.Row.FindControl("ddlStaff") as DropDownList;
            if (d == null) return; string type = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TaskType"));
            d.Items.Add(new ListItem("Select staff", ""));
            if (type == "Delivery")
            {
                d.Items.Add(new ListItem("James Dlamini — Delivery Staff", "202"));
                d.Items.Add(new ListItem("Sarah White — Staff", "205"));
            }
            else
            {
                d.Items.Add(new ListItem("Mike Adams — Collection Staff", "204"));
                d.Items.Add(new ListItem("Sarah White — Staff", "205"));
            }
            string selected = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "AssignedStaffID"));
            if (selected != "" && d.Items.FindByValue(selected) != null) d.SelectedValue = selected;
        }
        protected void gvTasks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Assign") return; int id;
            if (!Int32.TryParse(Convert.ToString(e.CommandArgument), out id)) return;
            GridViewRow row = ((Control)e.CommandSource).NamingContainer as GridViewRow;
            DropDownList d = row == null ? null : row.FindControl("ddlStaff") as DropDownList;
            if (d == null || d.SelectedValue == "")
            {
                Message("Select an available staff member first.", false); return;
            }
            DataRow[] rows = GetTasks().Select("TaskID=" + id);
            if (rows.Length == 0) return; rows[0]["AssignedStaffID"] = d.SelectedValue;
            Message("Booking task assigned to " + d.SelectedItem.Text + " for this session.", true);
            BindTasks();
        }
        private void Message(string value, bool ok)
        {
            pnlMessage.Visible = true; pnlMessage.CssClass = ok ? "alert alert-success" : "alert alert-warning";
            lblMessage.Text = Server.HtmlEncode(value);
        }

    }
}