using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class ReviewSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadReviews();
            }
        }

        private void LoadReviews()
        {
            // Get reviews submitted through Reviews.aspx.
            List<ReviewItem> reviewList =
                WebForm6.reviews.ToList();

            // Display sample reviews if no customer reviews exist.
            if (reviewList.Count == 0)
            {
                reviewList = GetSampleReviews();
            }

            // Display the newest reviews first.
            reviewList = reviewList
                .OrderByDescending(r => r.Date)
                .ToList();

            // Calculate review statistics.
            int totalReviews = reviewList.Count;

            double averageRating = totalReviews > 0
                ? reviewList.Average(r =>
                    Convert.ToInt32(r.Rating))
                : 0;

            int fiveStarReviews = reviewList.Count(r =>
                Convert.ToInt32(r.Rating) == 5);

            lblAverageRating.Text =
                averageRating.ToString("0.0");

            lblTotalReviews.Text =
                totalReviews.ToString();

            lblExcellentReviews.Text =
                fiveStarReviews.ToString();

            // Bind reviews to the page.
            rptReviews.DataSource = reviewList;
            rptReviews.DataBind();

            lblEmptyMessage.Visible =
                reviewList.Count == 0;

            rptReviews.Visible =
                reviewList.Count > 0;
        }

        // Sample reviews displayed when no reviews
        // have been submitted yet.
        private List<ReviewItem> GetSampleReviews()
        {
            return new List<ReviewItem>
            {
                new ReviewItem
                {
                    Name = "Thando M.",
                    Rating = "5",
                    Comment = "Excellent service! The decor was beautiful and everything was ready on time.",
                    Date = "2026-10-05 14:30"
                },

                new ReviewItem
                {
                    Name = "Lerato K.",
                    Rating = "4",
                    Comment = "The equipment was in good condition and the booking process was easy.",
                    Date = "2026-10-03 10:15"
                },

                new ReviewItem
                {
                    Name = "Sipho N.",
                    Rating = "5",
                    Comment = "Great catering and friendly staff. I would definitely recommend Forte Events.",
                    Date = "2026-09-28 16:45"
                },

                new ReviewItem
                {
                    Name = "Ayanda P.",
                    Rating = "3",
                    Comment = "The service was satisfactory, although delivery could have been earlier.",
                    Date = "2026-09-25 11:20"
                },

                new ReviewItem
                {
                    Name = "Zanele D.",
                    Rating = "5",
                    Comment = "Beautiful decorations and excellent customer service. Thank you!",
                    Date = "2026-09-20 09:00"
                }
            };
        }

        // Convert a rating into star symbols.
        public string GetStars(object rating)
        {
            int stars = Convert.ToInt32(rating);

            return new string('★', stars)
                + new string('☆', 5 - stars)
                + " (" + stars + "/5)";
        }

        // Display a friendly message for an empty comment.
        public string GetComment(object comment)
        {
            string text = Convert.ToString(comment);

            if (string.IsNullOrWhiteSpace(text))
            {
                return "No written comment provided.";
            }

            return text;
        }
    }
}
