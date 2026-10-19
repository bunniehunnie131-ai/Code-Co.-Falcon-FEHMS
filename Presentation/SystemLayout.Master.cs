using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class SystemLayout : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get the current page name and convert it to lowercase.
            string currentPage = Path.GetFileName(
                Request.AppRelativeCurrentExecutionFilePath
            );

            currentPage = (currentPage ?? "").ToLowerInvariant();

            string role = Convert.ToString(Session["UserRole"]);
            bool signedIn = Session["UserID"] != null &&
                Convert.ToBoolean(Session["LoggedIn"] ?? false);

            // Keep public pages public. Only portal pages show a sidebar.
            bool isCustomerPage =
                currentPage == "customerdashboard.aspx" ||
                currentPage == "trackorder.aspx" ||
                currentPage == "ordersummary.aspx" ||
                currentPage == "manageprofile.aspx" ||
                currentPage == "customerprofile.aspx" ||
                currentPage == "reviewsummary.aspx";

            // STAFF PAGES
            bool isStaffPage =
                currentPage == "staffdashboard.aspx" ||
                currentPage == "staffprofile.aspx" ||
                currentPage == "managedelivery.aspx" ||
                currentPage == "managedeliveries.aspx" ||
                currentPage == "managecollections.aspx" ||
                currentPage == "assignedbookings.aspx" ||
                currentPage == "managereturns.aspx" ||
                currentPage == "managecustomers.aspx";

            if (isCustomerPage && (!signedIn || !string.Equals(role, "Customer", StringComparison.OrdinalIgnoreCase)))
            {
                Response.Redirect(ResolveUrl("~/Presentation/Login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl)), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (isStaffPage && (!signedIn || !IsStaffRole(role)))
            {
                Response.Redirect(ResolveUrl("~/Presentation/Login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl)), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // DISPLAY THE CORRECT SIDEBAR
            pnlCustomerSidebar.Visible = isCustomerPage;
            pnlStaffSidebar.Visible = isStaffPage;

            if (signedIn)
            {
                btnLogin.Text = "My Dashboard";
                btnLogin.PostBackUrl = ResolveUrl(string.Equals(role, "Customer", StringComparison.OrdinalIgnoreCase)
                    ? "~/Presentation/CustomerDashboard.aspx"
                    : "~/Presentation/StaffDashBoard.aspx");
            }
            else
            {
                btnLogin.Text = "Login";
                btnLogin.PostBackUrl = ResolveUrl("~/Presentation/Login.aspx");
            }

            // APPLY THE CORRECT PAGE LAYOUT
            if (isCustomerPage)
            {
                mainContentLayout.Attributes["class"] =
                    "main-content customer-layout";

                pageContent.Attributes["class"] =
                    "customer-page-content";
            }
            else if (isStaffPage)
            {
                mainContentLayout.Attributes["class"] =
                    "main-content staff-layout";

                pageContent.Attributes["class"] =
                    "staff-page-content";
            }
            else if (currentPage == "deliveryandextras.aspx")
            {
                mainContentLayout.Attributes["class"] =
                    "main-content delivery-flow-layout";
                pageContent.Attributes["class"] =
                    "delivery-flow-content";
            }
            else
            {
                mainContentLayout.Attributes["class"] =
                    "main-content container";

                pageContent.Attributes["class"] =
                    "public-page-content";
            }
        }

        private bool IsStaffRole(string role)
        {
            return string.Equals(role, "Administrator", StringComparison.OrdinalIgnoreCase) ||
                   string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase) ||
                   string.Equals(role, "Manager", StringComparison.OrdinalIgnoreCase) ||
                   string.Equals(role, "Delivery Staff", StringComparison.OrdinalIgnoreCase) ||
                   string.Equals(role, "Collection Staff", StringComparison.OrdinalIgnoreCase) ||
                   string.Equals(role, "Staff", StringComparison.OrdinalIgnoreCase);
        }

        // CUSTOMER LOGOUT
        protected void lnkCustomerLogout_Click(
            object sender,
            EventArgs e)
        {
            LogOutUser();
        }

        // STAFF LOGOUT
        protected void lnkStaffLogout_Click(
            object sender,
            EventArgs e)
        {
            LogOutUser();
        }

        // SHARED LOGOUT FUNCTION
        private void LogOutUser()
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect(
                ResolveUrl("~/Presentation/Login.aspx"),
                false
            );

            Context.ApplicationInstance.CompleteRequest();
        }

    }
}
