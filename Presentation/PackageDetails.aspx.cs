using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class PackageDetails : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings[
                "ForteHirePackagesDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPackageDetails();
            }
        }

        private void LoadPackageDetails()
        {
            int packageId;

            if (!int.TryParse(Request.QueryString["id"], out packageId)
                || packageId <= 0)
            {
                ShowNotFound();
                return;
            }

            string query = @"
                SELECT PackageID, PackageName, Category,
                       Description, Price, ImageUrl, IsAvailable
                FROM dbo.Packages
                WHERE PackageID = @PackageID";

            using (SqlConnection connection =
                   new SqlConnection(connectionString))
            using (SqlCommand command =
                   new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue(
                    "@PackageID", packageId);

                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (!reader.Read())
                    {
                        ShowNotFound();
                        return;
                    }

                    lblPackageName.Text =
                        Convert.ToString(reader["PackageName"]);

                    lblCategory.Text =
                        Convert.ToString(reader["Category"]);

                    lblDescription.Text =
                        Convert.ToString(reader["Description"]);

                    decimal price =
                        Convert.ToDecimal(reader["Price"]);

                    lblPrice.Text = "R " + price.ToString("N2");

                    bool isAvailable =
                        Convert.ToBoolean(reader["IsAvailable"]);

                    if (isAvailable)
                    {
                        lblAvailability.Text = "Available";
                        lblAvailability.CssClass =
                            "details-status status-available";
                    }
                    else
                    {
                        lblAvailability.Text = "Currently unavailable";
                        lblAvailability.CssClass =
                            "details-status status-unavailable";
                    }

                    string imageUrl = reader["ImageUrl"] == DBNull.Value
                        ? ""
                        : Convert.ToString(reader["ImageUrl"]);

                    if (!string.IsNullOrWhiteSpace(imageUrl))
                    {
                        imgPackage.ImageUrl = ResolveUrl(imageUrl);
                        imgPackage.Visible = true;
                    }
                    else
                    {
                        imgPackage.Visible = false;
                    }

                    pnlDetails.Visible = true;
                    pnlNotFound.Visible = false;
                }
            }
        }

        private void ShowNotFound()
        {
            pnlDetails.Visible = false;
            pnlNotFound.Visible = true;
        }

        protected void btnAddPackageToCart_Click(object sender, EventArgs e)
        {
            int packageId;

            if (!int.TryParse(Request.QueryString["id"], out packageId)
                || packageId <= 0)
            {
                ShowNotFound();
                return;
            }

            string query = @"
        SELECT PackageID, PackageName, Price, ImageUrl
        FROM dbo.Packages
        WHERE PackageID = @PackageID
          AND IsAvailable = 1";

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.Add("@PackageID", SqlDbType.Int).Value = packageId;
                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (!reader.Read())
                    {
                        lblAvailability.Text = "Currently unavailable";
                        lblAvailability.CssClass =
                            "details-status status-unavailable";
                        return;
                    }

                    string packageName = Convert.ToString(reader["PackageName"]);
                    decimal price = Convert.ToDecimal(reader["Price"]);

                    string imageUrl = reader["ImageUrl"] == DBNull.Value
                        ? ""
                        : ResolveUrl(Convert.ToString(reader["ImageUrl"]));

                    DataTable cart = Session["ShoppingCart"] as DataTable;

                    if (cart == null)
                    {
                        cart = new DataTable();
                        cart.Columns.Add("ProductId", typeof(int));
                        cart.Columns.Add("Name", typeof(string));
                        cart.Columns.Add("Colour", typeof(string));
                        cart.Columns.Add("UnitPrice", typeof(decimal));
                        cart.Columns.Add("Quantity", typeof(int));
                        cart.Columns.Add("ImageUrl", typeof(string));
                    }

                    // Use negative IDs for packages because ordinary catalogue
                    // product IDs are normally positive identity values.
                    int cartId = -packageId;

                    DataRow existingPackage = null;

                    foreach (DataRow row in cart.Rows)
                    {
                        if (Convert.ToInt32(row["ProductId"]) == cartId)
                        {
                            existingPackage = row;
                            break;
                        }
                    }

                    if (existingPackage != null)
                    {
                        existingPackage["Quantity"] =
                            Convert.ToInt32(existingPackage["Quantity"]) + 1;
                    }
                    else
                    {
                        DataRow newRow = cart.NewRow();
                        newRow["ProductId"] = cartId;
                        newRow["Name"] = packageName;
                        newRow["Colour"] = "Event Hire Package";
                        newRow["UnitPrice"] = price;
                        newRow["Quantity"] = 1;
                        newRow["ImageUrl"] = imageUrl;

                        cart.Rows.Add(newRow);
                    }

                    Session["ShoppingCart"] = cart;
                }
            }

            Response.Redirect("Cart.aspx");
        }

    }
}