using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class WebForm7 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlHomeResults.Visible = false;
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string category = ddlCategory.SelectedValue;
            string searchText = txtSearch.Text.Trim();

            string connectionString =
                ConfigurationManager.ConnectionStrings["FortEventHireDB"].ConnectionString;

            string query = @"
                SELECT ProductID, ProductName, Description,
                       Category, Colour, Price, QuantityAvailable, ImageUrl
                FROM Product
                WHERE IsAvailable = 1
                  AND QuantityAvailable > 0
                  AND (@Category = '' OR Category = @Category)
                  AND (
                      @SearchText = ''
                      OR ProductName LIKE @SearchPattern
                      OR Description LIKE @SearchPattern
                      OR Category LIKE @SearchPattern
                  )
                ORDER BY ProductName";

            using (SqlConnection connection =
                new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.Add("@Category", SqlDbType.NVarChar, 100)
                    .Value = category;

                command.Parameters.Add("@SearchText", SqlDbType.NVarChar, 200)
                    .Value = searchText;

                command.Parameters.Add("@SearchPattern", SqlDbType.NVarChar, 202)
                    .Value = "%" + searchText + "%";

                DataTable products = new DataTable();

                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(products);
                }

                pnlHomeResults.Visible = true;
                btnClearSearch.Visible = true;
                rptHomeResults.DataSource = products;
                rptHomeResults.DataBind();

                if (products.Rows.Count > 0)
                {
                    lblHomeMessage.Text =
                        products.Rows.Count + " product(s) found.";
                }
                else
                {
                    lblHomeMessage.Text =
                        "No products found. Try another search or category.";
                }
            }
        }
        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlCategory.SelectedIndex = 0;

            rptHomeResults.DataSource = null;
            rptHomeResults.DataBind();

            lblHomeMessage.Text = "";
            pnlHomeResults.Visible = false;
            btnClearSearch.Visible = false;
        }
    }
}
