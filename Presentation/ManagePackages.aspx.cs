using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ManagePackages : Page
    {
        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["ForteDB"]
                    .ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            txtPrice.Attributes["step"] = "0.01";

            if (!IsPostBack)
            {
                BindPackages();
            }
        }

        protected void btnAddPackage_Click(object sender, EventArgs e)
        {
            ClearForm();
            pnlForm.Visible = true;
            pnlMessage.Visible = false;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
            ClearForm();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindPackages();
        }

        private void BindPackages()
        {
            const string sql = @"
                SELECT ProductID,
                       ProductName,
                       Description,
                       Price,
                       Category,
                       ImageUrl,
                       QuantityAvailable,
                       Colour,
                       IsAvailable
                FROM dbo.Product
                WHERE
                    (
                        Category LIKE N'%Package%'
                        OR ProductName LIKE N'%Package%'
                        OR Category = N'Combined'
                    )
                    AND
                    (
                        @Search = N''
                        OR ProductName LIKE N'%' + @Search + N'%'
                        OR Category LIKE N'%' + @Search + N'%'
                    )
                ORDER BY ProductName;";

            try
            {
                using (SqlConnection connection =
                    new SqlConnection(ConnectionString))
                using (SqlCommand command =
                    new SqlCommand(sql, connection))
                {
                    command.Parameters.Add(
                        "@Search",
                        SqlDbType.NVarChar,
                        150
                    ).Value = (txtSearch.Text ?? String.Empty).Trim();

                    DataTable table = new DataTable();

                    using (SqlDataAdapter adapter =
                        new SqlDataAdapter(command))
                    {
                        adapter.Fill(table);
                    }

                    rptPackages.DataSource = table;
                    rptPackages.DataBind();
                    pnlEmpty.Visible = table.Rows.Count == 0;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "Manage packages load failed: " + ex);

                Show(
                    "Packages could not be loaded from ForteDB." +
                    (Request.IsLocal ? " " + ex.Message : String.Empty),
                    false
                );
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            decimal price;
            int quantity;
            int productId;

            bool editing = Int32.TryParse(
                hfProductID.Value,
                out productId
            );

            if (String.IsNullOrWhiteSpace(txtName.Text) ||
                !Decimal.TryParse(
                    txtPrice.Text,
                    NumberStyles.Number,
                    CultureInfo.InvariantCulture,
                    out price
                ) ||
                price < 0 ||
                !Int32.TryParse(txtQuantity.Text, out quantity) ||
                quantity < 0)
            {
                Show(
                    "Enter a package name, valid non-negative price and quantity.",
                    false
                );
                return;
            }

            string sql = editing
                ? @"
                    UPDATE dbo.Product
                    SET ProductName = @Name,
                        Description = @Description,
                        Category = @Category,
                        Colour = @Colour,
                        Price = @Price,
                        QuantityAvailable = @Quantity,
                        ImageUrl = @Image,
                        UpdatedAt = SYSUTCDATETIME()
                    WHERE ProductID = @ID;"
                : @"
                    INSERT dbo.Product
                        (ProductName, Description, Category, Colour,
                         Price, QuantityAvailable, ImageUrl, IsAvailable)
                    VALUES
                        (@Name, @Description, @Category, @Colour,
                         @Price, @Quantity, @Image, 1);";

            try
            {
                using (SqlConnection connection =
                    new SqlConnection(ConnectionString))
                using (SqlCommand command =
                    new SqlCommand(sql, connection))
                {
                    command.Parameters.Add(
                        "@Name",
                        SqlDbType.NVarChar,
                        150
                    ).Value = txtName.Text.Trim();

                    command.Parameters.Add(
                        "@Description",
                        SqlDbType.NVarChar,
                        1000
                    ).Value = (txtDescription.Text ?? String.Empty).Trim();

                    command.Parameters.Add(
                        "@Category",
                        SqlDbType.NVarChar,
                        80
                    ).Value = String.IsNullOrWhiteSpace(txtCategory.Text)
                        ? "Packages"
                        : txtCategory.Text.Trim();

                    command.Parameters.Add(
                        "@Colour",
                        SqlDbType.NVarChar,
                        200
                    ).Value = String.IsNullOrWhiteSpace(txtColour.Text)
                        ? "Various"
                        : txtColour.Text.Trim();

                    SqlParameter priceParameter =
                        command.Parameters.Add("@Price", SqlDbType.Decimal);

                    priceParameter.Precision = 12;
                    priceParameter.Scale = 2;
                    priceParameter.Value = price;

                    command.Parameters.Add(
                        "@Quantity",
                        SqlDbType.Int
                    ).Value = quantity;

                    command.Parameters.Add(
                        "@Image",
                        SqlDbType.NVarChar,
                        500
                    ).Value = String.IsNullOrWhiteSpace(txtImage.Text)
                        ? "../Images/birthday-package.jpg?package=" +
                          Guid.NewGuid().ToString("N")
                        : txtImage.Text.Trim();

                    if (editing)
                    {
                        command.Parameters.Add(
                            "@ID",
                            SqlDbType.Int
                        ).Value = productId;
                    }

                    connection.Open();
                    command.ExecuteNonQuery();
                }

                pnlForm.Visible = false;
                ClearForm();
                BindPackages();

                Show(
                    editing ? "Package updated." : "Package added.",
                    true
                );
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "Package save failed: " + ex);

                Show(
                    "Package could not be saved." +
                    (Request.IsLocal ? " " + ex.Message : String.Empty),
                    false
                );
            }
        }

        protected void rptPackages_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            int productId;

            if (!Int32.TryParse(
                Convert.ToString(e.CommandArgument),
                out productId))
            {
                return;
            }

            try
            {
                using (SqlConnection connection =
                    new SqlConnection(ConnectionString))
                {
                    connection.Open();

                    if (e.CommandName == "TogglePackage")
                    {
                        const string sql = @"
                            UPDATE dbo.Product
                            SET IsAvailable =
                                    CASE WHEN IsAvailable = 1 THEN 0 ELSE 1 END,
                                UpdatedAt = SYSUTCDATETIME()
                            WHERE ProductID = @ID;";

                        using (SqlCommand command =
                            new SqlCommand(sql, connection))
                        {
                            command.Parameters.Add(
                                "@ID",
                                SqlDbType.Int
                            ).Value = productId;

                            command.ExecuteNonQuery();
                        }
                    }
                    else if (e.CommandName == "EditPackage")
                    {
                        const string sql = @"
                            SELECT ProductName,
                                   Description,
                                   Category,
                                   Colour,
                                   Price,
                                   QuantityAvailable,
                                   ImageUrl
                            FROM dbo.Product
                            WHERE ProductID = @ID;";

                        using (SqlCommand command =
                            new SqlCommand(sql, connection))
                        {
                            command.Parameters.Add(
                                "@ID",
                                SqlDbType.Int
                            ).Value = productId;

                            using (SqlDataReader reader =
                                command.ExecuteReader())
                            {
                                if (!reader.Read())
                                {
                                    return;
                                }

                                hfProductID.Value =
                                    productId.ToString(
                                        CultureInfo.InvariantCulture
                                    );

                                txtName.Text =
                                    Convert.ToString(reader["ProductName"]);

                                txtDescription.Text =
                                    Convert.ToString(reader["Description"]);

                                txtCategory.Text =
                                    Convert.ToString(reader["Category"]);

                                txtColour.Text =
                                    Convert.ToString(reader["Colour"]);

                                txtPrice.Text =
                                    Convert.ToDecimal(reader["Price"])
                                        .ToString(
                                            CultureInfo.InvariantCulture
                                        );

                                txtQuantity.Text =
                                    Convert.ToString(
                                        reader["QuantityAvailable"]
                                    );

                                txtImage.Text =
                                    Convert.ToString(reader["ImageUrl"]);

                                litFormTitle.Text = "Edit Package";
                                btnSave.Text = "Save Changes";
                                pnlForm.Visible = true;
                            }
                        }
                    }
                }

                BindPackages();

                if (e.CommandName == "TogglePackage")
                {
                    Show("Package availability updated.", true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError(
                    "Package update failed: " + ex);

                Show(
                    "Package could not be updated." +
                    (Request.IsLocal ? " " + ex.Message : String.Empty),
                    false
                );
            }
        }

        public string FormatRands(object value)
        {
            decimal amount;

            return Decimal.TryParse(Convert.ToString(value), out amount)
                ? "R" + amount.ToString(
                    "N2",
                    CultureInfo.GetCultureInfo("en-ZA")
                  )
                : "R0.00";
        }

        private void ClearForm()
        {
            hfProductID.Value = String.Empty;

            txtName.Text = String.Empty;
            txtDescription.Text = String.Empty;
            txtPrice.Text = String.Empty;
            txtQuantity.Text = String.Empty;
            txtImage.Text = String.Empty;

            txtCategory.Text = "Packages";
            txtColour.Text = "Various";

            litFormTitle.Text = "Add Package";
            btnSave.Text = "Save Package";
        }

        private void Show(string message, bool success)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = success
                ? "alert alert-success"
                : "alert alert-danger";

            lblMessage.Text = Server.HtmlEncode(message);
        }
    }
}

