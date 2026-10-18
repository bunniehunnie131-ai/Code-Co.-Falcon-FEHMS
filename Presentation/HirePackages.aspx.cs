using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class HirePackages : System.Web.UI.Page
    {
        private string connectionString =
            ConfigurationManager.ConnectionStrings["ForteHirePackagesDB"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPackages();
            }
        }

        private void LoadPackages()
        {
            using (SqlConnection connection =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT PackageID, PackageName, Category,
                           Description, Price, ImageUrl
                    FROM dbo.Packages
                    WHERE IsAvailable = 1
                    AND (@Search = ''
                         OR PackageName LIKE @SearchPattern)
                    AND (@Category = ''
                         OR Category = @Category)
                    AND (@MinPrice IS NULL
                         OR Price >= @MinPrice)
                    AND (@MaxPrice IS NULL
                         OR Price <= @MaxPrice)
                    ORDER BY PackageID";

                using (SqlCommand command =
                       new SqlCommand(query, connection))
                {
                    string search = txtSearch.Text.Trim();
                    string category = ddlCategory.SelectedValue;

                    decimal minPrice;
                    decimal maxPrice;

                    bool hasMinPrice = decimal.TryParse(
                        txtMinPrice.Text.Trim(),
                        NumberStyles.Number,
                        CultureInfo.InvariantCulture,
                        out minPrice);

                    bool hasMaxPrice = decimal.TryParse(
                        txtMaxPrice.Text.Trim(),
                        NumberStyles.Number,
                        CultureInfo.InvariantCulture,
                        out maxPrice);

                    command.Parameters.AddWithValue("@Search", search);
                    command.Parameters.AddWithValue(
                        "@SearchPattern", "%" + search + "%");
                    command.Parameters.AddWithValue("@Category", category);

                    command.Parameters.Add(
                        "@MinPrice", SqlDbType.Decimal).Value =
                        hasMinPrice ? (object)minPrice : DBNull.Value;

                    command.Parameters["@MinPrice"].Precision = 10;
                    command.Parameters["@MinPrice"].Scale = 2;

                    command.Parameters.Add(
                        "@MaxPrice", SqlDbType.Decimal).Value =
                        hasMaxPrice ? (object)maxPrice : DBNull.Value;

                    command.Parameters["@MaxPrice"].Precision = 10;
                    command.Parameters["@MaxPrice"].Scale = 2;

                    using (SqlDataAdapter adapter =
                           new SqlDataAdapter(command))
                    {
                        DataTable packages = new DataTable();
                        adapter.Fill(packages);

                        rptPackages.DataSource = packages;
                        rptPackages.DataBind();

                        lblPackageCount.Text =
                            packages.Rows.Count == 1
                            ? "1 package found"
                            : packages.Rows.Count + " packages found";

                        pnlNoPackages.Visible =
                            packages.Rows.Count == 0;
                    }
                }
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadPackages();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlCategory.SelectedIndex = 0;
            txtMinPrice.Text = "";
            txtMaxPrice.Text = "";

            LoadPackages();
        }

        protected void btnAddPackageToCart_Command(
            object sender, CommandEventArgs e)
        {
            int packageId;

            if (!int.TryParse(
                Convert.ToString(e.CommandArgument), out packageId)
                || packageId <= 0)
            {
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings[
                    "ForteHirePackagesDB"].ConnectionString;

            string query = @"
        SELECT PackageID, PackageName, Price, ImageUrl
        FROM dbo.Packages
        WHERE PackageID = @PackageID
          AND IsAvailable = 1";

            using (SqlConnection connection =
                   new SqlConnection(connectionString))
            using (SqlCommand command =
                   new SqlCommand(query, connection))
            {
                command.Parameters.Add(
                    "@PackageID", SqlDbType.Int).Value = packageId;

                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (!reader.Read())
                    {
                        return;
                    }

                    string packageName =
                        Convert.ToString(reader["PackageName"]);

                    decimal price =
                        Convert.ToDecimal(reader["Price"]);

                    string imageUrl =
                        reader["ImageUrl"] == DBNull.Value
                        ? ""
                        : ResolveUrl(Convert.ToString(reader["ImageUrl"]));

                    DataTable cart =
                        Session["ShoppingCart"] as DataTable;

                    if (cart == null)
                    {
                        cart = new DataTable();
                        cart.Columns.Add("ProductId", typeof(int));
                        cart.Columns.Add("Name", typeof(string));
                        cart.Columns.Add("Colour", typeof(string));
                        cart.Columns.Add("ImageUrl", typeof(string));
                        cart.Columns.Add("UnitPrice", typeof(decimal));
                        cart.Columns.Add("Quantity", typeof(int));

                        Session["ShoppingCart"] = cart;
                    }

                    // Track package IDs separately from the cart table.
                    System.Collections.Generic.HashSet<int> packageIds =
                        Session["HirePackageIDs"]
                        as System.Collections.Generic.HashSet<int>;

                    if (packageIds == null)
                    {
                        packageIds =
                            new System.Collections.Generic.HashSet<int>();

                        Session["HirePackageIDs"] = packageIds;
                    }

                    DataRow existingPackage = null;

                    foreach (DataRow row in cart.Rows)
                    {
                        int rowId = Convert.ToInt32(row["ProductId"]);

                        if (packageIds.Contains(rowId)
                            && rowId == packageId)
                        {
                            existingPackage = row;
                            break;
                        }
                    }

                    if (existingPackage != null)
                    {
                        existingPackage["Quantity"] =
                            Convert.ToInt32(
                                existingPackage["Quantity"]) + 1;
                    }
                    else
                    {
                        // Find an unused ID so a package cannot collide
                        // with an existing product in the shared cart.
                        int cartId = packageId;

                        while (cart.AsEnumerable().Any(
                            row => Convert.ToInt32(row["ProductId"]) == cartId))
                        {
                            cartId = cartId == int.MaxValue
                                ? 1
                                : cartId + 1;
                        }

                        DataRow newRow = cart.NewRow();

                        newRow["ProductId"] = cartId;
                        newRow["Name"] = packageName;
                        newRow["Colour"] = "Event Hire Package";
                        newRow["ImageUrl"] = imageUrl;
                        newRow["UnitPrice"] = price;
                        newRow["Quantity"] = 1;

                        cart.Rows.Add(newRow);
                        packageIds.Add(cartId);
                    }

                    Session["ShoppingCart"] = cart;
                    Session["HirePackageIDs"] = packageIds;
                }
            }

            Response.Redirect("Cart.aspx");
        }

    }
}