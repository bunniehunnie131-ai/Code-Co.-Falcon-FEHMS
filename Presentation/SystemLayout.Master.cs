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

            // CUSTOMER PAGES
            bool isCustomerPage =
                currentPage == "customerdashboard.aspx" ||
                currentPage == "trackorder.aspx" ||
                currentPage == "ordersummary.aspx" ||
                currentPage == "manageprofile.aspx" ||
                currentPage == "reviews.aspx" ||
                currentPage == "reviewsummary.aspx" ||
                currentPage == "about.aspx" ||
                currentPage == "contact.aspx" ||
                currentPage == "viewtermsandconditions.aspx";

            // STAFF PAGES
            bool isStaffPage =
                currentPage == "staffdashboard.aspx" ||
                currentPage == "staffdashbord.aspx" ||
                currentPage == "staffprofile.aspx" ||
                currentPage == "managedelivery.aspx" ||
                currentPage == "managecollection.aspx" ||
                currentPage == "assignedbookings.aspx" ||
                currentPage == "managereturns.aspx";

            // DISPLAY THE CORRECT SIDEBAR
            pnlCustomerSidebar.Visible = isCustomerPage;
            pnlStaffSidebar.Visible = isStaffPage;

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
            else
            {
                mainContentLayout.Attributes["class"] =
                    "main-content container";

                pageContent.Attributes["class"] =
                    "public-page-content";
            }
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