using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

            protected void btnSearch_Click(object sender, EventArgs e)
            {
                string category = ddlCategory.SelectedValue;
                string searchText = txtSearch.Text.Trim();

                string url = "Catalogue.aspx";

                string query = "";

                if (!string.IsNullOrWhiteSpace(category))
                {
                    query = "category=" +
                        Server.UrlEncode(category);
                }

                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    if (query != "")
                    {
                        query += "&";
                    }

                    query += "search=" +
                        Server.UrlEncode(searchText);
                }

                if (query != "")
                {
                    url += "?" + query;
                }

                Response.Redirect(url);
            }
        }
    }
