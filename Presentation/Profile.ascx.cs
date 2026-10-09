using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class Profile : System.Web.UI.UserControl
    {
       
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    LoadProfile();
                }
            }

            private void LoadProfile()
            {
                // Temporary staff information.
                // Later this will come from the logged-in staff/database.

                lblProfileName.Text = "John Smith";
                lblProfileRole.Text = "Delivery Staff";

                lblStaffID.Text = "STF00001";
                lblMemberSince.Text = "15 March 2026";

                lblFullName.Text = "John Smith";
                lblUsername.Text = "johnsmith";
                lblEmail.Text = "john@email.com";
                lblContact.Text = "0712345678";
                lblIDNumber.Text = "0001015800081";
                lblAddress.Text = "15 Oxford Street, Beacon Bay, East London";

                // Put the current information into the edit controls.
                txtFullName.Text = lblFullName.Text;
                txtUsername.Text = lblUsername.Text;
                txtEmail.Text = lblEmail.Text;
                txtContact.Text = lblContact.Text;
                txtIDNumber.Text = lblIDNumber.Text;
                txtAddress.Text = lblAddress.Text;
            }


            protected void btnSave_Click(object sender, EventArgs e)
            {
                // Check that the passwords match if a new password was entered.
                if (!string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    if (txtPassword.Text != txtConfirmPassword.Text)
                    {
                        // Keep edit panel visible.
                        pnlEdit.Style["display"] = "block";
                        return;
                    }
                }

                // Update the displayed information.
                lblProfileName.Text = txtFullName.Text;

                lblFullName.Text = txtFullName.Text;
                lblUsername.Text = txtUsername.Text;
                lblEmail.Text = txtEmail.Text;
                lblContact.Text = txtContact.Text;
                lblIDNumber.Text = txtIDNumber.Text;
                lblAddress.Text = txtAddress.Text;

                // Clear password fields.
                txtPassword.Text = "";
                txtConfirmPassword.Text = "";

                // Hide the edit section after saving.
                pnlEdit.Style["display"] = "none";

                /*
                 * Later:
                 * Add your database UPDATE code here so the changes
                 * are permanently saved.
                 */
            }
        }
    }