using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageReturns : System.Web.UI.Page
    {

        // Demo-only in-memory records. Replace this repository with SQL access later.
        private static readonly List<Booking> Bookings = SeedBookings();
        private string Filter { get { return ViewState["Filter"] as string ?? "Pending"; } set { ViewState["Filter"] = value; } }
        private string SelectedId { get { return ViewState["SelectedId"] as string; } set { ViewState["SelectedId"] = value; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { Filter = "Pending"; BindList(); }
        }

        protected void lnkPending_Click(object sender, EventArgs e) { Filter = "Pending"; pnlDetails.Visible = false; pnlList.Visible = true; pnlMessage.Visible = false; BindList(); }
        protected void lnkCompleted_Click(object sender, EventArgs e) { Filter = "Completed"; pnlDetails.Visible = false; pnlList.Visible = true; pnlMessage.Visible = false; BindList(); }
        protected void btnSearch_Click(object sender, EventArgs e) { BindList(); }

        protected void rptReturns_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Open") return;
            SelectedId = Convert.ToString(e.CommandArgument);
            pnlList.Visible = false;
            pnlDetails.Visible = true;
            pnlError.Visible = false;
            BindSelected();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            pnlDetails.Visible = false;
            pnlList.Visible = true;
            pnlError.Visible = false;
            BindList();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Booking booking = Bookings.FirstOrDefault(b => b.Id == SelectedId);
            if (booking == null) { Error("This booking could not be found."); return; }
            var updated = new List<ReturnItem>();
            foreach (RepeaterItem row in rptItems.Items)
            {
                ReturnItem old = booking.Items[row.ItemIndex];
                int good, damaged, missing;
                if (!ReadNumber(row, "txtGood", out good) || !ReadNumber(row, "txtDamaged", out damaged) || !ReadNumber(row, "txtMissing", out missing))
                { Error("Enter whole numbers of zero or more for all quantities."); return; }
                if (good + damaged + missing != old.Expected)
                { Error(old.Name + ": Good, damaged, and missing must add up to " + old.Expected + "."); return; }
                TextBox noteBox = row.FindControl("txtNote") as TextBox;
                string note = noteBox == null ? "" : noteBox.Text.Trim();
                if (damaged > 0 && String.IsNullOrWhiteSpace(note)) { Error("Add a damage note for " + old.Name + "."); return; }
                updated.Add(new ReturnItem { Name = old.Name, Description = old.Description, Expected = old.Expected, Good = good, Damaged = damaged, Missing = missing, DamageNote = damaged == 0 ? "" : note });
            }
            booking.Items = updated;
            booking.Recorded = true;
            booking.Condition = OverallCondition(updated);
            booking.Notes = Summary(updated);
            Filter = "Completed";
            BindList();
            BindSelected();
            pnlError.Visible = false;
            pnlMessage.Visible = true;
            lblMessage.Text = "Return recorded for " + booking.Id + ". Condition: " + booking.Condition + ".";
        }

        private void BindList()
        {
            lblPendingCount.Text = Bookings.Count(b => b.CollectionComplete && !b.Recorded).ToString();
            lblCompletedCount.Text = Bookings.Count(b => b.CollectionComplete && b.Recorded).ToString();
            lnkPending.CssClass = Filter == "Pending" ? "nav-link active" : "nav-link";
            lnkCompleted.CssClass = Filter == "Completed" ? "nav-link active" : "nav-link";
            string term = (txtSearch.Text ?? "").Trim();
            string condition = ddlCondition.SelectedValue;
            IEnumerable<Booking> q = Bookings.Where(b => b.CollectionComplete && (Filter == "Pending" ? !b.Recorded : b.Recorded));
            if (term.Length > 0) q = q.Where(b => b.Id.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0 || b.Customer.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0);
            if (condition.Length > 0) q = q.Where(b => b.Condition == condition);
            var rows = q.OrderBy(b => b.ReturnDate).ToList();
            rptReturns.DataSource = rows;
            rptReturns.DataBind();
            pnlEmpty.Visible = rows.Count == 0;
        }

        private void BindSelected()
        {
            Booking b = Bookings.FirstOrDefault(x => x.Id == SelectedId);
            if (b == null) return;
            lblBooking.Text = b.Id + " · " + b.Event;
            lblCustomer.Text = b.Customer;
            lblDates.Text = b.EventEnd.ToString("dd MMM yyyy HH:mm") + " · " + b.ReturnDate.ToString("dd MMM yyyy");
            lblLocation.Text = b.Location;
            lblInstructions.Text = b.Instructions;
            lblOverall.Text = OverallCondition(b.Items);
            rptItems.DataSource = b.Items;
            rptItems.DataBind();
        }

        private static bool ReadNumber(RepeaterItem row, string id, out int value)
        {
            value = 0;
            TextBox box = row.FindControl(id) as TextBox;
            return box != null && Int32.TryParse(box.Text, out value) && value >= 0;
        }

        private void Error(string message) { pnlError.Visible = true; lblError.Text = message; }
        protected string GetBadgeClass(string condition)
        {
            if (condition == "Good") return "badge rounded-pill text-bg-success";
            if (condition == "Partially Damaged") return "badge rounded-pill text-bg-warning";
            if (condition == "Damaged" || condition == "Missing Items") return "badge rounded-pill text-bg-danger";
            return "badge rounded-pill text-bg-secondary";
        }

        private static string OverallCondition(IList<ReturnItem> items)
        {
            if (items.All(i => i.Damaged == 0 && i.Missing == 0)) return "Good";
            if (items.Any(i => i.Damaged > 0) && items.Any(i => i.Good > 0 || i.Missing > 0)) return "Partially Damaged";
            if (items.Any(i => i.Damaged > 0)) return "Damaged";
            return "Missing Items";
        }
        private static string Summary(IList<ReturnItem> items)
        {
            var notes = items.Where(i => i.Damaged > 0).Select(i => i.Damaged + " " + i.Name + " damaged: " + i.DamageNote).ToList();
            int missing = items.Sum(i => i.Missing);
            if (missing > 0) notes.Add(missing + " item(s) missing");
            return notes.Count == 0 ? "No damage or missing items" : String.Join("; ", notes);
        }
        private static List<Booking> SeedBookings()
        {
            return new List<Booking>
            {
                new Booking { Id="BK002", Customer="Lerato Tau", Event="Wedding", ReturnDate=new DateTime(2026,10,14), EventEnd=new DateTime(2026,10,13,22,0,0), Location="Montecassino, Sandton", Instructions="Collect all hired equipment from the venue entrance. Contact the event coordinator on arrival.", CollectionComplete=true, Recorded=false, Condition="Awaiting Inspection", Notes="—", Items=new List<ReturnItem> {
                    new ReturnItem { Name="Round chairs", Description="Standard white chair", Expected=20, Good=17, Damaged=2, Missing=1, DamageNote="Two cracked legs; unsafe to reuse" },
                    new ReturnItem { Name="Banquet tables", Description="6-foot folding table", Expected=5, Good=5, Damaged=0, Missing=0, DamageNote="" } } },
                new Booking { Id="BK004", Customer="Nandini Pillay", Event="Engagement", ReturnDate=new DateTime(2026,10,15), EventEnd=new DateTime(2026,10,14,23,0,0), Location="Sandton Convention Centre", Instructions="Items are by the loading bay. Ask for the event manager.", CollectionComplete=true, Recorded=false, Condition="Awaiting Inspection", Notes="—", Items=new List<ReturnItem> {
                    new ReturnItem { Name="White chairs", Description="Folding chair", Expected=40, Good=40, Damaged=0, Missing=0, DamageNote="" },
                    new ReturnItem { Name="Round tables", Description="1.8 metre table", Expected=6, Good=6, Damaged=0, Missing=0, DamageNote="" } } },
                new Booking { Id="BK006", Customer="School XYZ", Event="School Gala", ReturnDate=new DateTime(2026,10,13), EventEnd=new DateTime(2026,10,12,20,0,0), Location="Parktown, Johannesburg", Instructions="The school caretaker has the return checklist.", CollectionComplete=true, Recorded=true, Condition="Partially Damaged", Notes="2 chairs damaged", Items=new List<ReturnItem> {
                    new ReturnItem { Name="Event chairs", Description="Black banquet chair", Expected=25, Good=23, Damaged=2, Missing=0, DamageNote="Broken backrest and bent leg" },
                    new ReturnItem { Name="Trestle tables", Description="6-foot folding table", Expected=10, Good=10, Damaged=0, Missing=0, DamageNote="" } } },
                new Booking { Id="BK009", Customer="ABC Corp", Event="Corporate Event", ReturnDate=new DateTime(2026,10,12), EventEnd=new DateTime(2026,10,11,21,0,0), Location="Sandton Convention Centre", Instructions="Coordinate access with venue security.", CollectionComplete=true, Recorded=true, Condition="Good", Notes="No damage or missing items", Items=new List<ReturnItem> {
                    new ReturnItem { Name="Banquet chairs", Description="Padded navy chair", Expected=60, Good=60, Damaged=0, Missing=0, DamageNote="" },
                    new ReturnItem { Name="Cocktail tables", Description="High bar table", Expected=8, Good=8, Damaged=0, Missing=0, DamageNote="" } } },
                new Booking { Id="BK011", Customer="Grace Chuma", Event="Birthday Celebration", ReturnDate=new DateTime(2026,10,10), EventEnd=new DateTime(2026,10,9,22,0,0), Location="Parktown", Instructions="Items returned to the venue loading area.", CollectionComplete=true, Recorded=true, Condition="Missing Items", Notes="3 item(s) missing", Items=new List<ReturnItem> {
                    new ReturnItem { Name="White chairs", Description="Folding chair", Expected=30, Good=27, Damaged=0, Missing=3, DamageNote="" },
                    new ReturnItem { Name="Round tables", Description="1.8 metre table", Expected=5, Good=5, Damaged=0, Missing=0, DamageNote="" } } }
            };
        }
        private class Booking
        {
            public string Id { get; set; }
            public string Customer { get; set; }
            public string Event { get; set; }
            public DateTime ReturnDate { get; set; }
            public DateTime EventEnd { get; set; }
            public string Location { get; set; }
            public string Instructions { get; set; }
            public bool CollectionComplete { get; set; }
            public bool Recorded { get; set; }
            public string Condition { get; set; }
            public string Notes { get; set; }
            public List<ReturnItem> Items { get; set; }
            public string ItemsSummary { get { return String.Join(", ", Items.Select(i => i.Expected + " × " + i.Name)); } }
        }
        private class ReturnItem
        {
            public string Name { get; set; }
            public string Description { get; set; }
            public int Expected { get; set; }
            public int Good { get; set; }
            public int Damaged { get; set; }
            public int Missing { get; set; }
            public string DamageNote { get; set; }
        }
    }
}