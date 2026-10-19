using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class WebForm9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Login details
            string customerEmail = "yandisathunzana@gmail.com";
            string customerPassword = "NickHuncho@031212";

            string adminEmail = "siphokhumalo@gmail.com";
            string adminPassword = "SiphoKhumalo@11";

            // Details entered by the user
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            // Admin login
            if (email.Equals(adminEmail, StringComparison.OrdinalIgnoreCase) &&
                password == adminPassword)
            {
                Session["LoggedIn"] = true;
                Session["UserEmail"] = email;
                Session["UserRole"] = "Admin";

                // Redirect admin to the Staff Dashboard
                Response.Redirect("~/Presentation/StaffDashboard.aspx", false);
                Context.ApplicationInstance.CompleteRequest();

                return;
            }

            // Customer login
            if (email.Equals(customerEmail, StringComparison.OrdinalIgnoreCase) &&
                password == customerPassword)
            {
                Session["LoggedIn"] = true;
                Session["UserEmail"] = email;
                Session["UserRole"] = "Customer";

                // Redirect customer to the Customer Dashboard
                Response.Redirect("~/Presentation/CustomerDashboard.aspx", false);
                Context.ApplicationInstance.CompleteRequest();

                return;
            }

            // Incorrect login details
            lblMessage.Text = "Invalid email or password.";
        }
    }
}