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
    public partial class Catalogue : System.Web.UI.Page
    {
        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(
    object sender,
    EventArgs e)
        {
            if (!IsPostBack)
            {
                string category = Request.QueryString["category"];

                if (string.IsNullOrEmpty(category))
                {
                    LoadProducts();
                }
                else
                {
                    switch (category.ToLower())
                    {
                        case "chairs":
                            LoadProductsByCategory("Chairs");
                            break;

                        case "tables":
                            LoadProductsByCategory("Tables");
                            break;

                        case "lighting":
                            LoadProductsByCategory("Lighting");
                            break;

                        case "packages":
                            LoadProductsByCategory("Packages");
                            break;

                        default:
                            LoadProducts();
                            break;
                    }
                }

                UpdateCartCount();
            }
        }



        // =========================================================
        // CONNECTION STRING
        // =========================================================

        private string GetConnectionString()
        {
            return
                ConfigurationManager
                .ConnectionStrings["FortEventHireDB"]
                .ConnectionString;
        }



        // =========================================================
        // LOAD ALL PRODUCTS
        // =========================================================

        private void LoadProducts()
        {
            string query =
                @"SELECT
                    ProductID,
                    ProductName,
                    Description,
                    Category,
                    Colour,
                    Price,
                    QuantityAvailable,
                    ImageUrl
                  FROM Product
                  WHERE IsAvailable = 1
                  AND QuantityAvailable > 0
                  ORDER BY ProductName";


            DataTable products =
                new DataTable();


            using (
                SqlConnection connection =
                    new SqlConnection(
                        GetConnectionString()
                    )
            )
            {
                SqlDataAdapter adapter =
                    new SqlDataAdapter(
                        query,
                        connection
                    );


                adapter.Fill(
                    products
                );
            }


            rptProducts.DataSource =
                products;


            rptProducts.DataBind();


            pnlNoProducts.Visible =
                products.Rows.Count == 0;
        }



        // =========================================================
        // LOAD PRODUCTS BY CATEGORY
        // =========================================================

        private void LoadProductsByCategory(
            string category)
        {
            string query =
                @"SELECT
                    ProductID,
                    ProductName,
                    Description,
                    Category,
                    Colour,
                    Price,
                    QuantityAvailable,
                    ImageUrl
                  FROM Product
                  WHERE IsAvailable = 1
                  AND QuantityAvailable > 0
                  AND Category = @Category
                  ORDER BY ProductName";


            DataTable products =
                new DataTable();


            using (
                SqlConnection connection =
                    new SqlConnection(
                        GetConnectionString()
                    )
            )
            {
                SqlCommand command =
                    new SqlCommand(
                        query,
                        connection
                    );


                command.Parameters.AddWithValue(
                    "@Category",
                    category
                );


                SqlDataAdapter adapter =
                    new SqlDataAdapter(
                        command
                    );


                adapter.Fill(
                    products
                );
            }


            rptProducts.DataSource =
                products;


            rptProducts.DataBind();


            pnlNoProducts.Visible =
                products.Rows.Count == 0;
        }



        // =========================================================
        // CATEGORY BUTTONS
        // =========================================================

        protected void btnAll_Click(
            object sender,
            EventArgs e)
        {
            lblMessage.Visible =
                false;


            LoadProducts();
        }


        protected void btnChairs_Click(
            object sender,
            EventArgs e)
        {
            lblMessage.Visible =
                false;


            LoadProductsByCategory(
                "Chairs"
            );
        }


        protected void btnTables_Click(
            object sender,
            EventArgs e)
        {
            lblMessage.Visible =
                false;


            LoadProductsByCategory(
                "Tables"
            );
        }


        protected void btnLighting_Click(
            object sender,
            EventArgs e)
        {
            lblMessage.Visible =
                false;


            LoadProductsByCategory(
                "Lighting"
            );
        }


        protected void btnPackages_Click(
            object sender,
            EventArgs e)
        {
            lblMessage.Visible =
                false;


            LoadProductsByCategory(
                "Packages"
            );
        }



        // =========================================================
        // REPEATER ADD TO CART
        // =========================================================

        protected void rptProducts_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (
                e.CommandName
                !=
                "AddToCart"
            )
            {
                return;
            }


            int productId =
                Convert.ToInt32(
                    e.CommandArgument
                );


            TextBox txtQuantity =
                (TextBox)
                e.Item.FindControl(
                    "txtQuantity"
                );


            int quantity;


            if (
                txtQuantity == null
                ||
                !int.TryParse(
                    txtQuantity.Text,
                    out quantity
                )
                ||
                quantity <= 0
            )
            {
                ShowMessage(
                    "Please enter a valid quantity."
                );


                return;
            }


            AddProductToCart(
                productId,
                quantity
            );
        }



        // =========================================================
        // GET PRODUCT FROM DATABASE AND ADD TO CART
        // =========================================================

        private void AddProductToCart(
            int productId,
            int quantity)
        {
            string query =
                @"SELECT
                    ProductID,
                    ProductName,
                    Colour,
                    Price,
                    ImageUrl,
                    QuantityAvailable
                  FROM Product
                  WHERE ProductID = @ProductID
                  AND IsAvailable = 1";


            using (
                SqlConnection connection =
                    new SqlConnection(
                        GetConnectionString()
                    )
            )
            {
                SqlCommand command =
                    new SqlCommand(
                        query,
                        connection
                    );


                command.Parameters.AddWithValue(
                    "@ProductID",
                    productId
                );


                connection.Open();


                SqlDataReader reader =
                    command.ExecuteReader();


                if (!reader.Read())
                {
                    reader.Close();


                    ShowMessage(
                        "The selected product could not be found."
                    );


                    return;
                }


                string productName =
                    reader["ProductName"]
                    .ToString();


                string colour =
                    reader["Colour"]
                    .ToString();


                decimal price =
                    Convert.ToDecimal(
                        reader["Price"]
                    );


                string imageUrl =
                    reader["ImageUrl"]
                    .ToString();


                int available =
                    Convert.ToInt32(
                        reader["QuantityAvailable"]
                    );


                reader.Close();



                // Check requested quantity

                if (quantity > available)
                {
                    ShowMessage(
                        "Only "
                        +
                        available
                        +
                        " "
                        +
                        productName
                        +
                        " item(s) are currently available."
                    );


                    return;
                }



                DataTable cart =
                    GetCart();



                DataRow existingItem =
                    null;



                foreach (
                    DataRow row
                    in cart.Rows
                )
                {
                    if (
                        Convert.ToInt32(
                            row["ProductId"]
                        )
                        ==
                        productId
                    )
                    {
                        existingItem =
                            row;


                        break;
                    }
                }



                // Product already in cart

                if (existingItem != null)
                {
                    int existingQuantity =
                        Convert.ToInt32(
                            existingItem["Quantity"]
                        );


                    int newQuantity =
                        existingQuantity
                        +
                        quantity;



                    if (newQuantity > available)
                    {
                        ShowMessage(
                            "You cannot add more than "
                            +
                            available
                            +
                            " "
                            +
                            productName
                            +
                            " item(s)."
                        );


                        return;
                    }


                    existingItem["Quantity"] =
                        newQuantity;
                }


                // New product

                else
                {
                    DataRow row =
                        cart.NewRow();


                    row["ProductId"] =
                        productId;


                    row["Name"] =
                        productName;


                    row["Colour"] =
                        colour;


                    row["ImageUrl"] =
                        imageUrl;


                    row["UnitPrice"] =
                        price;


                    row["Quantity"] =
                        quantity;


                    cart.Rows.Add(
                        row
                    );
                }



                Session["ShoppingCart"] =
                    cart;



                UpdateCartCount();



                ShowMessage(
                    quantity
                    +
                    " x "
                    +
                    productName
                    +
                    " added to your cart."
                );
            }
        }



        // =========================================================
        // CREATE / GET CART DATATABLE
        // =========================================================

        private DataTable GetCart()
        {
            if (
                Session["ShoppingCart"]
                ==
                null
            )
            {
                DataTable cart =
                    new DataTable();


                cart.Columns.Add(
                    "ProductId",
                    typeof(int)
                );


                cart.Columns.Add(
                    "Name",
                    typeof(string)
                );


                cart.Columns.Add(
                    "Colour",
                    typeof(string)
                );


                cart.Columns.Add(
                    "ImageUrl",
                    typeof(string)
                );


                cart.Columns.Add(
                    "UnitPrice",
                    typeof(decimal)
                );


                cart.Columns.Add(
                    "Quantity",
                    typeof(int)
                );


                Session["ShoppingCart"] =
                    cart;
            }


            return
                (DataTable)
                Session["ShoppingCart"];
        }



        // =========================================================
        // CART COUNT
        // =========================================================

        private void UpdateCartCount()
        {
            DataTable cart =
                GetCart();


            int totalItems =
                0;


            foreach (
                DataRow row
                in cart.Rows
            )
            {
                totalItems +=
                    Convert.ToInt32(
                        row["Quantity"]
                    );
            }


            btnViewCart.Text =
                "🛒 Cart ("
                +
                totalItems
                +
                ")";
        }



        // =========================================================
        // MESSAGE
        // =========================================================

        private void ShowMessage(
            string message)
        {
            lblMessage.Text =
                message;


            lblMessage.Visible =
                true;
        }



        // =========================================================
        // CART PAGE
        // =========================================================

        protected void btnViewCart_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
               "Cart.aspx"
            );
        }

    }
}