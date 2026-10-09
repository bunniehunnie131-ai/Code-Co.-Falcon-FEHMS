namespace FEHMS_FortEventHireManagementSystem.Presentation
{
    public partial class TrackOrder
    {
        protected global::System.Web.UI.WebControls.Panel pnlListView;
        protected global::System.Web.UI.WebControls.Panel pnlMessage;
        protected global::System.Web.UI.WebControls.Label lblStatusMessage;
        protected global::System.Web.UI.WebControls.Repeater rptTrackableOrders;
        protected global::System.Web.UI.WebControls.Panel pnlNoTrackableOrders;
        protected global::System.Web.UI.WebControls.Panel pnlDetailView;

        protected global::System.Web.UI.WebControls.LinkButton btnBackToList;
        protected global::System.Web.UI.WebControls.HyperLink lnkRefresh;
        protected global::System.Web.UI.WebControls.HyperLink lnkReceipt;

        protected global::System.Web.UI.WebControls.Label lblDetailReference;
        protected global::System.Web.UI.WebControls.Label lblDetailCustomerName;
        protected global::System.Web.UI.WebControls.Label lblDetailPaymentStatus;
        protected global::System.Web.UI.WebControls.Label lblDetailCurrentStatus;
        protected global::System.Web.UI.WebControls.Label lblProgressHeadline;

        protected global::System.Web.UI.WebControls.Repeater rptSteps;
        protected global::System.Web.UI.WebControls.Label lblEstimatedDelivery;
        protected global::System.Web.UI.WebControls.Label lblLastUpdated;

        protected global::System.Web.UI.WebControls.Label lblEventDate;
        protected global::System.Web.UI.WebControls.Label lblEventType;
        protected global::System.Web.UI.WebControls.Label lblTransportMethod;
        protected global::System.Web.UI.WebControls.Label lblDeliveryAddress;
        protected global::System.Web.UI.WebControls.Label lblDeliveryDate;
        protected global::System.Web.UI.WebControls.Label lblEstimatedTime;

        protected global::System.Web.UI.WebControls.Label lblCustomerContact;
        protected global::System.Web.UI.WebControls.Label lblCustomerEmail;
        protected global::System.Web.UI.WebControls.Label lblSetupRequired;
        protected global::System.Web.UI.WebControls.Label lblServiceProviders;
        protected global::System.Web.UI.WebControls.Label lblPaidAt;

        protected global::System.Web.UI.WebControls.Repeater rptBookingItems;
        protected global::System.Web.UI.WebControls.Label lblSubtotal;
        protected global::System.Web.UI.WebControls.Label lblDeliveryFee;
        protected global::System.Web.UI.WebControls.Label lblSetupFee;
        protected global::System.Web.UI.WebControls.Label lblProviderFee;
        protected global::System.Web.UI.WebControls.Label lblLateFee;
        protected global::System.Web.UI.WebControls.Label lblGrandTotal;

        protected global::System.Web.UI.WebControls.Label lblPaymentMethod;
        protected global::System.Web.UI.WebControls.Label lblPaymentStatusRow;
        protected global::System.Web.UI.WebControls.Label lblAmountPaid;
    }
}