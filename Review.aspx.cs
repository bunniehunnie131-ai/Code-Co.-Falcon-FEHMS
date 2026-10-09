using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem
{
    public partial class Review : System.Web.UI.Page
    {
        // Static list to store reviews 
        public static List<ReviewItem> reviews = new List<ReviewItem>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        // Bind GridView
        private void BindGrid()
        {
            gvReviews.DataSource = reviews;
            gvReviews.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            ReviewItem newReview = new ReviewItem
            {
                Name = "Customer", // or Session["UserName"]
                Rating = ddlRating.SelectedValue,
                Comment = txtComment.Text.Trim(),
                Date = DateTime.Now.ToString("yyyy-MM-dd HH:mm")
            };

            // Add to list
            reviews.Add(newReview);

            // Show message
            lblMessage.Text = "✅ Thank you! Your review has been submitted.";
            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Visible = true;

            // Clear form
            ddlRating.SelectedIndex = 0;
            txtComment.Text = "";

            // Refresh Grid
            BindGrid();

        }
    }
}
// Review Model Class
public class ReviewItem
{
    public string Name { get; set; }
    public string Rating { get; set; }
    public string Comment { get; set; }
    public string Date { get; set; }
}