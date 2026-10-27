<%@ Page Title="Manage Inventory" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManageInventory.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManageInventory" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
    <link href="../Stylesheet/AdminStyle.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-workspace admin-workspace-inventory">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
            <div>
                <h1 class="h2 text-navy mb-1 heading-font">Manage Inventory</h1>
                <p class="text-muted mb-0">Add, update and deactivate rental items.</p>
            </div>
            <asp:Button ID="btnShowForm" runat="server" Text="Add Item" CssClass="btn btn-primary" OnClick="btnShowForm_Click" CausesValidation="false" />
        </div>
        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert">
            <asp:Label ID="lblMessage" runat="server" />

        </asp:Panel>
        <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="card mb-3">
            <div class="card-body">
                <h2 class="h5">
                    <asp:Literal ID="litFormTitle" runat="server" Text="Add Inventory Item" /></h2>
                <asp:HiddenField ID="hfProductID" runat="server" />
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Item name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="150" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Category</label>
                        <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control" MaxLength="80" />
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Colour</label>
                        <asp:TextBox ID="txtColour" runat="server" CssClass="form-control" MaxLength="200" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Daily price (R)</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Quantity available</label>
                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Image path</label>
                        <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" MaxLength="500" placeholder="../Images/item.jpg" />
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <div class="form-check">
                            <asp:CheckBox ID="chkAvailable" runat="server" CssClass="form-check-input" Checked="true" />
                            <label class="form-check-label" for="<%= chkAvailable.ClientID %>">Available for hire</label>
                        </div>
                    </div>
                    <div class="col-12 d-flex gap-2">
                        <asp:Button ID="btnSave" runat="server" Text="Save Item" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary" OnClick="btnCancel_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>
        </asp:Panel>
        <div class="admin-filter-tabs mb-3" aria-label="Inventory categories">
            <asp:LinkButton ID="lnkAll" runat="server" CssClass="admin-filter-tab active" CommandArgument="" OnClick="Category_Click" CausesValidation="false">All items</asp:LinkButton>
            <asp:LinkButton ID="lnkTables" runat="server" CssClass="admin-filter-tab" CommandArgument="Tables" OnClick="Category_Click" CausesValidation="false">Tables</asp:LinkButton>
            <asp:LinkButton ID="lnkChairs" runat="server" CssClass="admin-filter-tab" CommandArgument="Chairs" OnClick="Category_Click" CausesValidation="false">Chairs</asp:LinkButton>
            <asp:LinkButton ID="lnkTents" runat="server" CssClass="admin-filter-tab" CommandArgument="Tents" OnClick="Category_Click" CausesValidation="false">Tents</asp:LinkButton>
            <asp:LinkButton ID="lnkDecor" runat="server" CssClass="admin-filter-tab" CommandArgument="Décor" OnClick="Category_Click" CausesValidation="false">Décor</asp:LinkButton>
            <asp:LinkButton ID="lnkCatering" runat="server" CssClass="admin-filter-tab" CommandArgument="Catering" OnClick="Category_Click" CausesValidation="false">Catering</asp:LinkButton>
        </div>
        <div class="row g-2 mb-3">
            <div class="col-md-6">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search items..." /></div>
            <div class="col-md-3">
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Text="All Statuses" Value="" />
                    <asp:ListItem Text="Active" Value="1" />
                    <asp:ListItem Text="Inactive" Value="0" />

                </asp:DropDownList>
            </div>
            <div class="col-md-3">
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100" OnClick="btnSearch_Click" CausesValidation="false" />
            </div>
        </div>
        <div class="table-responsive">
            <table class="table admin-data-table align-middle mb-0">
                <thead>
                    <tr>
                        <th>Item ID</th>
                        <th>Item name</th>
                        <th>Category</th>
                        <th>Quantity available</th>
                        <th>Daily price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptItems" runat="server" OnItemCommand="rptItems_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td><%#: Eval("ProductID", "IT{0:0000}") %></td>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <img src='<%#: ResolveUrl(Convert.ToString(Eval("ImageUrl"))) %>' class="admin-product-thumb" alt="" onerror="this.style.visibility='hidden'" />
                                        <span><%#: Eval("ProductName") %><small class="d-block text-muted"><%#: Eval("Colour") %></small></span>
                                    </div>
                                </td>
                                <td><%#: Eval("Category") %></td>
                                <td><%#: Eval("QuantityAvailable") %></td>
                                <td><%#: FormatRands(Eval("Price")) %></td>
                                <td><span class='<%# Convert.ToBoolean(Eval("IsAvailable")) ? "badge text-bg-success" : "badge text-bg-secondary" %>'><%# Convert.ToBoolean(Eval("IsAvailable")) ? "Active" : "Inactive" %></span></td>
                                <td class="text-nowrap">
                                    <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-outline-dark btn-sm admin-icon-button" CommandName="EditItem" CommandArgument='<%# Eval("ProductID") %>' CausesValidation="false" aria-label="Edit item" ToolTip="Edit item">
                                    <i class="bi bi-pencil-square" aria-hidden="true"></i></asp:LinkButton>
                                    <asp:LinkButton ID="btnToggle" runat="server" CssClass="btn btn-outline-dark btn-sm admin-icon-button" CommandName="ToggleItem" CommandArgument='<%# Eval("ProductID") %>' CausesValidation="false" aria-label="Change item availability" ToolTip="Change availability">
                                    <i class='<%# Convert.ToBoolean(Eval("IsAvailable")) ? "bi bi-toggle-on" : "bi bi-toggle-off" %>' aria-hidden="true"></i></asp:LinkButton></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="card p-5 text-center text-muted mt-3">No inventory items found.</asp:Panel>
    </div>
</asp:Content>

