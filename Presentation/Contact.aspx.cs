using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                /*successMessage.Visible = false;*/
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            /* ContactMessage message = new ContactMessage
            {
                FullName = txtFullName.Text.Trim(),
                Email = txtEmail.Text.Trim(),
                Phone = txtPhone.Text.Trim(),
                Subject = txtSubject.Text.Trim(),
                Message = txtMessage.Text.Trim(),
                PreferredContactMethod = ddlPreferredContact.SelectedValue,
                BestTimeToContact = txtBestTime.Text.Trim(),
                SubmittedAtUtc = DateTime.UtcNow
            };

            contactForm.Visible = false;
            successMessage.Visible = true;*/
        }
    }
}