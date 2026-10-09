using System;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtFullName.Text) ||
                string.IsNullOrWhiteSpace(txtEmailAddress.Text) ||
                string.IsNullOrWhiteSpace(txtDateOfBirth.Text) ||
                string.IsNullOrWhiteSpace(txtIDNumber.Text) ||
                string.IsNullOrWhiteSpace(txtPassword.Text) ||
                string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                ShowMessage("Please complete all registration fields.");
                return;
            }

            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                ShowMessage("Passwords do not match.");
                return;
            }

            if (!cbUserAgreement.Checked)
            {
                ShowMessage("Please accept the Terms and Conditions.");
                return;
            }
            Response.Redirect("Login.aspx");
          
        }

        private void ShowMessage(string message)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "registrationMessage",
                "alert('" + message.Replace("'", "\\'") + "');",
                true);
        }
    }
}