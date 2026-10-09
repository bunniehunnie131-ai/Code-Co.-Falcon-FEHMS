<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/Staff.master" AutoEventWireup="true" CodeBehind="ManageDeliveries.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageDeliveries" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StaffContent" runat="server">
    
    <div class="delivery-page">

    <!-- Page Header -->
    <div class="delivery-header">
        <div>
            <h1>Manage Deliveries</h1>
            <p>View and monitor all scheduled and completed deliveries.</p>
        </div>
    </div>

    <!-- Delivery Summary -->
    <div class="delivery-stats">

        <div class="delivery-stat-card">
            <div class="delivery-stat-icon">
                <i class="bi bi-truck"></i>
            </div>
            <div>
                <span class="delivery-stat-label">Scheduled</span>
                <h3>12</h3>
            </div>
        </div>

        <div class="delivery-stat-card">
            <div class="delivery-stat-icon">
                <i class="bi bi-check-circle"></i>
            </div>
            <div>
                <span class="delivery-stat-label">Delivered</span>
                <h3>28</h3>
            </div>
        </div>

        <div class="delivery-stat-card">
            <div class="delivery-stat-icon">
                <i class="bi bi-exclamation-circle"></i>
            </div>
            <div>
                <span class="delivery-stat-label">Overdue</span>
                <h3>3</h3>
            </div>
        </div>

        <div class="delivery-stat-card">
            <div class="delivery-stat-icon">
                <i class="bi bi-box-seam"></i>
            </div>
            <div>
                <span class="delivery-stat-label">Total Deliveries</span>
                <h3>43</h3>
            </div>
        </div>

    </div>

    <!-- Search and Filter -->
    <div class="delivery-filter-card">

        <div class="delivery-search">
            <label for="txtSearch">Search Deliveries</label>
            <asp:TextBox 
                ID="txtSearch" 
                runat="server"
                CssClass="form-control"
                placeholder="Search by booking reference or customer name">
            </asp:TextBox>
        </div>

        <div class="delivery-status-filter">
            <label for="ddlStatus">Delivery Status</label>

            <asp:DropDownList 
                ID="ddlStatus" 
                runat="server"
                CssClass="form-select">

                <asp:ListItem Text="All Deliveries" Value=""></asp:ListItem>
                <asp:ListItem Text="Scheduled" Value="Scheduled"></asp:ListItem>
                <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                <asp:ListItem Text="Overdue" Value="Overdue"></asp:ListItem>

            </asp:DropDownList>
        </div>

        <div class="delivery-filter-buttons">

            <asp:Button 
                ID="btnSearch"
                runat="server"
                Text="Search"
                CssClass="btn btn-primary delivery-search-button" />

            <asp:Button 
                ID="btnClear"
                runat="server"
                Text="Clear"
                CssClass="btn btn-secondary delivery-clear-button" />

        </div>

    </div>

    <!-- Deliveries Table -->
    <div class="delivery-table-card">

        <div class="delivery-table-header">
            <div>
                <h2>Delivery Records</h2>
                <p>Scheduled and completed deliveries</p>
            </div>
        </div>

        <div class="table-responsive">

            <asp:GridView 
                ID="gvDeliveries"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="table delivery-table"
                GridLines="None"
                EmptyDataText="No delivery records found."
                AllowPaging="True"
                PageSize="10" OnSelectedIndexChanged="gvDeliveries_SelectedIndexChanged">

                <Columns>

                    <asp:BoundField 
                        DataField="DeliveryID"
                        HeaderText="Delivery ID" />

                    <asp:BoundField 
                        DataField="BookingReference"
                        HeaderText="Booking Reference" />

                    <asp:BoundField 
                        DataField="CustomerName"
                        HeaderText="Customer" />

                    <asp:BoundField 
                        DataField="Phone"
                        HeaderText="Contact Number" />

                    <asp:BoundField 
                        DataField="ScheduledDate"
                        HeaderText="Delivery Date"
                        DataFormatString="{0:dd MMM yyyy}" />

                    <asp:TemplateField HeaderText="Delivery Address">

                        <ItemTemplate>

                            <div class="delivery-address">
                                <%# Eval("StreetAddress") %><br />
                                <%# Eval("Suburb") %>,
                                <%# Eval("City") %><br />
                                <%# Eval("PostalCode") %>
                            </div>

                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:BoundField 
                        DataField="StaffName"
                        HeaderText="Assigned Staff" />

                    <asp:TemplateField HeaderText="Status">

                        <ItemTemplate>

                            <span class='status-badge <%# GetStatusClass(Eval("DeliveryStatus").ToString()) %>'>
                                <%# Eval("DeliveryStatus") %>
                            </span>

                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>

                            <asp:LinkButton

                                ID="btnView"
                                runat="server"
                                CommandName="ViewDelivery"
                                CommandArgument='<%# Eval("DeliveryID") %>'
                                CssClass="view-delivery-button">
                                <i class="bi bi-eye"></i>
                                View

                            </asp:LinkButton>

                        </ItemTemplate>

                    </asp:TemplateField>

                </Columns>

            </asp:GridView>

        </div>
    </div>
</div>

</asp:Content>
