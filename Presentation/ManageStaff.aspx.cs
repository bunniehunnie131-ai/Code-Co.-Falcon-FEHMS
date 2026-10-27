using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManageStaff : Page
    {
        private DataTable GetStaff()
        {
            DataTable t=Session["ManageStaffDemo"] as DataTable;
            if(t!=null)return t;
            t=new DataTable();
            t.Columns.Add("UserID",typeof(int));
            t.Columns.Add("StaffNumber",typeof(string));
            t.Columns.Add("FullName",typeof(string));
            t.Columns.Add("EmailAddress",typeof(string));
            t.Columns.Add("PhoneNumber",typeof(string));
            t.Columns.Add("JobTitle",typeof(string));
            t.Columns.Add("RoleName",typeof(string));
            t.Columns.Add("IsActive",typeof(bool));
            t.Columns.Add("Status",typeof(string));
            t.Rows.Add(201,"ST201","Thandi Nkomo","thandi.nkomo@forte.co.za","071 111 1001","Operations Manager","Manager",true,"Active");
            t.Rows.Add(202,"ST202","James Dlamini","james.dlamini@forte.co.za","071 111 1002","Delivery Coordinator","Delivery Staff",true,"Active");
            t.Rows.Add(203,"ST203","Priya Singh","priya.singh@forte.co.za","071 111 1003","Administrator","Admin Staff",true,"Active");
            t.Rows.Add(204,"ST204","Mike Adams","mike.adams@forte.co.za","071 111 1004","Collection Coordinator","Collection Staff",true,"Active");
            t.Rows.Add(205,"ST205","Sarah White","sarah.white@forte.co.za","071 111 1005","Event Hire Assistant","Staff",true,"Active");
            Session["ManageStaffDemo"]=t;return t;
        }
        protected void Page_Load(object sender,EventArgs e)
        {
            if(!IsPostBack)
            {
                BindRoles();
                BindStaff();
            }
        }
        private void BindRoles()
        {
            ddlRole.Items.Clear();
            ddlRole.Items.Add(new ListItem("Select role",""));
            ddlRole.Items.Add(new ListItem("Delivery Staff","Delivery Staff"));
            ddlRole.Items.Add(new ListItem("Collection Staff","Collection Staff"));
            ddlRole.Items.Add(new ListItem("Admin Staff","Admin Staff"));
            ddlRole.Items.Add(new ListItem("Staff","Staff"));
        }
        private void BindStaff()
        {
            gvStaff.DataSource=GetStaff();
            gvStaff.DataBind();
        }
        protected void btnShowAdd_Click(object sender,EventArgs e)
        {
            pnlForm.Visible=true;pnlMessage.Visible=false;
        }
        protected void btnCancel_Click(object sender,EventArgs e)
        {
            pnlForm.Visible=false;
        }
        protected void btnSave_Click(object sender,EventArgs e)
        {
            if(String.IsNullOrWhiteSpace(txtFirstName.Text)||String.IsNullOrWhiteSpace(txtLastName.Text)||String.IsNullOrWhiteSpace(txtEmail.Text)||String.IsNullOrWhiteSpace(ddlRole.SelectedValue))
            {
                Show("Complete the staff name, email and role fields.",false);
                return;
            }
            DataTable t=GetStaff();
            int id=200;
            foreach(DataRow r in t.Rows)id=Math.Max(id,Convert.ToInt32(r["UserID"]));
            id++;
            DataRow n=t.NewRow();
            n["UserID"]=id;
            n["StaffNumber"]="ST"+id.ToString("D3");
            n["FullName"]=txtFirstName.Text.Trim()+" "+txtLastName.Text.Trim();
            n["EmailAddress"]=txtEmail.Text.Trim();
            n["PhoneNumber"]=txtPhone.Text.Trim();
            n["JobTitle"]=txtJobTitle.Text.Trim();
            n["RoleName"]=ddlRole.SelectedValue;
            n["IsActive"]=true;n["Status"]="Active";t.Rows.Add(n);
            txtFirstName.Text=txtLastName.Text=txtEmail.Text=txtPhone.Text=txtJobTitle.Text=txtPassword.Text="";
            pnlForm.Visible=false;Show("Sample staff account added for this session.",true);BindStaff();
        }
        protected void gvStaff_RowCommand(object sender,GridViewCommandEventArgs e)
        {
            if(e.CommandName!="Toggle")return;
            int id;if(!Int32.TryParse(Convert.ToString(e.CommandArgument),out id))return;DataRow[] rows=GetStaff().Select("UserID="+id);
            if(rows.Length==0)return;bool active=!Convert.ToBoolean(rows[0]["IsActive"]);rows[0]["IsActive"]=active;rows[0]["Status"]=active?"Active":"Inactive";
            Show("Staff access updated in the session sample data.",true);
            BindStaff();
        }
        private void Show(string s,bool ok)
        {
            pnlMessage.Visible=true;pnlMessage.CssClass=ok?"alert alert-success":"alert alert-warning";
            lblMessage.Text=Server.HtmlEncode(s);
        }
    }
}

