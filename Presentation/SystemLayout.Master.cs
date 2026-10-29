using System;
using System.IO;
using System.Web;
using System.Web.UI;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class SystemLayout : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentPage = Path.GetFileName(
                Request.AppRelativeCurrentExecutionFilePath);

            currentPage = (currentPage ?? "").ToLowerInvariant();

            string userRole = Convert.ToString(Session["UserRole"]);
            userRole = (userRole ?? "").Trim();

            bool isCustomerPage =
                currentPage == "customerdashboard.aspx" ||
                currentPage == "trackorder.aspx" ||
                currentPage == "ordersummary.aspx" ||
                currentPage == "manageprofile.aspx" ||
                currentPage == "reviews.aspx" ||
                currentPage == "about.aspx" ||
                currentPage == "contact.aspx" ||
                currentPage == "viewtermsandconditions.aspx";

            bool isStaffPage =
                currentPage == "staffdashboard.aspx" ||
                currentPage == "staffdashbord.aspx" ||
                currentPage == "staffprofile.aspx" ||
                currentPage == "managedelivery.aspx" ||
                currentPage == "managecollection.aspx" ||
                currentPage == "assignedbookings.aspx" ||
                currentPage == "managereturns.aspx";

            bool isAdminPage =
                currentPage == "admindashboard.aspx" ||
                currentPage == "managebookings.aspx" ||
                currentPage == "manageinventory.aspx" ||
                currentPage == "managecustomers.aspx" ||
                currentPage == "managestaff.aspx" ||
                currentPage == "managepayments.aspx" ||
                currentPage == "managepackage.aspx" ||
                currentPage == "bookingcalander.aspx" ||
                currentPage == "reports.aspx" ||
                currentPage == "manageevents.aspx" ||
                currentPage == "assignbookings.aspx";

            // ManageReturns is used by staff and administrators.
            if (currentPage == "managereturns.aspx")
            {
                if (string.Equals(
                    userRole, "Admin",
                    StringComparison.OrdinalIgnoreCase))
                {
                    isAdminPage = true;
                    isStaffPage = false;
                }
            }

            pnlCustomerSidebar.Visible = isCustomerPage;
            pnlStaffSidebar.Visible = isStaffPage;
            pnlAdminSidebar.Visible = isAdminPage;

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
            else if (isAdminPage)
            {
                mainContentLayout.Attributes["class"] =
                    "main-content admin-layout";

                pageContent.Attributes["class"] =
                    "admin-page-content";
            }
            else
            {
                mainContentLayout.Attributes["class"] =
                    "main-content container";

                pageContent.Attributes["class"] =
                    "public-page-content";
            }
        }

        protected void lnkCustomerLogout_Click(
            object sender, EventArgs e)
        {
            LogOutUser();
        }

        protected void lnkStaffLogout_Click(
            object sender, EventArgs e)
        {
            LogOutUser();
        }

        protected void lnkAdminLogout_Click(
            object sender, EventArgs e)
        {
            LogOutUser();
        }

        private void LogOutUser()
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect(
                ResolveUrl("~/Presentation/Login.aspx"),
                false);

            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
