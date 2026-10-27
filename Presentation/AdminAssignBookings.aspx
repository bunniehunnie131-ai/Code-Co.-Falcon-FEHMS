<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="AdminAssignBookings.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.AdminAssignBookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
    <link href="../Stylesheet/AdminStyle.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-workspace admin-workspace-assignment">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-4">
            <div>
                <h1 class="h2 text-navy mb-1">Assign Bookings</h1>
                <p class="text-muted mb-0">Assign delivery, collection and return tasks to active staff.</p>
            </div>
        </div>
        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert">
            <asp:Label ID="lblMessage" runat="server" />
        </asp:Panel>
        <div class="table-responsive">
            <asp:GridView ID="gvTasks" runat="server" AutoGenerateColumns="false" CssClass="table admin-data-table admin-assignment-table align-middle mb-0" DataKeyNames="TaskID" OnRowDataBound="gvTasks_RowDataBound" OnRowCommand="gvTasks_RowCommand" EmptyDataText="No booking tasks are waiting for assignment.">
                <Columns>
                    <asp:BoundField DataField="BookingReference" HeaderText="Booking" />
                    <asp:BoundField DataField="CustomerFullName" HeaderText="Customer" />
                    <asp:BoundField DataField="EventType" HeaderText="Event" />
                    <asp:BoundField DataField="TaskType" HeaderText="Task" />
                    <asp:BoundField DataField="ScheduledAt" HeaderText="Scheduled" DataFormatString="{0:dd MMM yyyy HH:mm}" />
                    <asp:BoundField DataField="TaskLocation" HeaderText="Location" />
                    <asp:BoundField DataField="TaskStatus" HeaderText="Status" />
                    <asp:TemplateField HeaderText="Assign to">
                        <ItemTemplate>
                            <asp:DropDownList
                                ID="ddlStaff"
                                runat="server"
                                CssClass="form-select admin-assignment-staff" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton
                                ID="btnAssign"
                                runat="server"
                                CommandName="Assign"
                                CommandArgument='<%# Eval("TaskID") %>'
                                CssClass="btn btn-dark btn-sm text-nowrap"
                                ToolTip="Save assignment">
                                <i class="bi bi-person-check" aria-hidden="true"></i> Assign</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>


</asp:Content>
