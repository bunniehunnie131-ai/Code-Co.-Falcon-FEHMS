using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class SystemLayout : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentPage = Path.GetFileName(
                Request.AppRelativeCurrentExecutionFilePath
            );

            currentPage = (currentPage ?? "").ToLowerInvariant();

            // Customer pages
            bool isCustomerPage =
                currentPage == "customerdashboard.aspx" ||
                currentPage == "trackorder.aspx" ||
                currentPage == "ordersummary.aspx" ||
                currentPage == "manageprofile.aspx";

            // Staff pages
            bool isStaffPage =
                currentPage == "staffdashboard.aspx" ||
                currentPage == "staffprofile.aspx" ||
                currentPage == "managedelivery.aspx" ||
                currentPage == "managecollection.aspx";

            // Show only the correct sidebar
            pnlCustomerSidebar.Visible = isCustomerPage;
            pnlStaffSidebar.Visible = isStaffPage;

            // Apply the correct layout
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

        protected void lnkCustomerLogout_Click(
            object sender,
            EventArgs e)
        {
            LogOutUser();
        }

        protected void lnkStaffLogout_Click(
            object sender,
            EventArgs e)
        {
            LogOutUser();
        }

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
