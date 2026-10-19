<%@ Page Title="Review Summary" Language="C#"
    MasterPageFile="~/Presentation/SystemLayout.Master"
    AutoEventWireup="true"
    CodeBehind="ReviewSummary.aspx.cs"
    Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ReviewSummary" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <style>
        .summary-container {
            background-color: #f4f7fc;
            min-height: 100vh;
            padding: 40px 15px;
        }

        .summary-heading {
            color: #0f172a;
            font-weight: 700;
        }

        .summary-description {
            color: #64748b;
        }

        .summary-stat {
            background: white;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            height: 100%;
        }

        .summary-stat h3 {
            color: #1e3a8a;
            font-size: 30px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .summary-stat p {
            color: #64748b;
            margin-bottom: 0;
        }

        .reviews-panel {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-top: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .review-stars {
            color: #f59e0b;
            font-size: 18px;
            white-space: nowrap;
        }

        .reviewer-name {
            color: #0f172a;
            font-weight: 600;
        }

        .review-comment {
            color: #475569;
            white-space: pre-wrap;
            overflow-wrap: anywhere;
        }

        .review-date {
            color: #94a3b8;
            font-size: 13px;
        }

        .review-item {
            padding: 20px 0;
            border-bottom: 1px solid #e2e8f0;
        }

        .review-item:last-child {
            border-bottom: none;
        }

        .summary-button {
            background-color: #1e3a8a;
            border-color: #1e3a8a;
        }

        .summary-button:hover {
            background-color: #172554;
            border-color: #172554;
        }
    </style>

    <div class="summary-container">
        <div class="container">

            <!-- Page Heading -->
            <div class="mb-4">
                <h2 class="summary-heading">
                    <i class="bi bi-star-fill text-warning"></i>
                    Customer Reviews
                </h2>

                <p class="summary-description">
                    Read feedback from customers who have used
                    Forte Events Catering and Decor Hire.
                </p>
            </div>

            <!-- Review Statistics -->
            <div class="row g-3">

                <div class="col-md-4">
                    <div class="summary-stat">
                        <h3>
                            <asp:Label ID="lblAverageRating"
                                runat="server"
                                Text="0.0" />
                            <small>/ 5</small>
                        </h3>
                        <p>Average Rating</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="summary-stat">
                        <h3>
                            <asp:Label ID="lblTotalReviews"
                                runat="server"
                                Text="0" />
                        </h3>
                        <p>Total Reviews</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="summary-stat">
                        <h3>
                            <asp:Label ID="lblExcellentReviews"
                                runat="server"
                                Text="0" />
                        </h3>
                        <p>5-Star Reviews</p>
                    </div>
                </div>

            </div>

            <!-- All Reviews -->
            <div class="reviews-panel">

                <div class="d-flex justify-content-between
                    align-items-center flex-wrap gap-2 mb-3">

                    <h4 class="summary-heading mb-0">
                        All Customer Feedback
                    </h4>

                    <asp:HyperLink ID="lnkWriteReview"
                        runat="server"
                        NavigateUrl="Reviews.aspx"
                        CssClass="btn btn-primary summary-button">
                        <i class="bi bi-pencil-square"></i>
                        Write a Review
                    </asp:HyperLink>

                </div>

                <asp:Label ID="lblEmptyMessage"
                    runat="server"
                    CssClass="alert alert-info d-block"
                    Text="No reviews are available."
                    Visible="false" />

                <asp:Repeater ID="rptReviews"
                    runat="server">

                    <ItemTemplate>

                        <div class="review-item">

                            <div class="d-flex justify-content-between
                                align-items-start flex-wrap gap-2">

                                <div>
                                    <div class="reviewer-name">
                                        <i class="bi bi-person-circle"></i>
                                        <%#: Eval("Name") %>
                                    </div>

                                    <div class="review-stars mt-1">
                                        <%# GetStars(Eval("Rating")) %>
                                    </div>
                                </div>

                                <span class="review-date">
                                    <%#: Eval("Date") %>
                                </span>

                            </div>

                            <p class="review-comment mt-3 mb-0">
                                <%#: GetComment(Eval("Comment")) %>
                            </p>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

                <div class="mt-4">
                    <a href="MyOrders.aspx"
                       class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left"></i>
                        Back to My Orders
                    </a>
                </div>

            </div>

        </div>
    </div>

</asp:Content>

