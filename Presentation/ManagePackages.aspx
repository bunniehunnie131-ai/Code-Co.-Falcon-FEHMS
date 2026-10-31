<%@ Page Title="Manage Packages" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="ManagePackages.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.ManagePackages" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
   <style>

       /* Manage Packages: visible table lines */
.admin-workspace-packages .admin-data-table {
    border-collapse: collapse;
}

.admin-workspace-packages .admin-data-table th,
.admin-workspace-packages .admin-data-table td {
    border: 1px solid var(--border-color);
}

/* Medium package pictures */
.admin-workspace-packages .admin-product-thumb {
    width: 68px;
    height: 58px;
    flex: 0 0 68px;
    object-fit: cover;
    border: 1px solid var(--border-light);
    border-radius: 6px;
}
.admin-workspace-packages .admin-page-heading {
    flex-direction: row-reverse;
}

@media (max-width: 767px) {
    .admin-workspace-packages .admin-page-heading {
        flex-direction: column;
        align-items: flex-start;
    }
}

   </style>

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-workspace admin-workspace-packages">

        <div class="admin-page-heading">
            <div>
                <h1 class="h2 text-navy mb-1 heading-font">Manage Hire Packages</h1>
                <p class="text-muted mb-0">
                    Create and manage event packages in the hire catalogue.
                </p>
            </div>

            <asp:Button ID="btnAddPackage" runat="server"
                Text="Add package"
                CssClass="btn btn-dark"
                OnClick="btnAddPackage_Click"
                CausesValidation="false" />
        </div>

        <asp:Panel ID="pnlMessage" runat="server"
            Visible="false"
            CssClass="alert">
            <asp:Label ID="lblMessage" runat="server" />
        </asp:Panel>

        <asp:Panel ID="pnlForm" runat="server"
            Visible="false"
            CssClass="card mb-3">
            <div class="card-body">
                <h2 class="h5">
                    <asp:Literal ID="litFormTitle" runat="server"
                        Text="Add package" />
                </h2>

                <asp:HiddenField ID="hfProductID" runat="server" />

                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Package name</label>
                        <asp:TextBox ID="txtName" runat="server"
                            CssClass="form-control"
                            MaxLength="150" />
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Category</label>
                        <asp:TextBox ID="txtCategory" runat="server"
                            CssClass="form-control"
                            Text="Packages"
                            MaxLength="80" />
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Price (R)</label>
                        <asp:TextBox ID="txtPrice" runat="server"
                            CssClass="form-control"
                            TextMode="Number" />
                    </div>

                    <div class="col-md-8">
                        <label class="form-label">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server"
                            CssClass="form-control"
                            MaxLength="1000" />
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Image path</label>
                        <asp:TextBox ID="txtImage" runat="server"
                            CssClass="form-control"
                            MaxLength="500"
                            placeholder="../Images/package.jpg" />
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Available quantity</label>
                        <asp:TextBox ID="txtQuantity" runat="server"
                            CssClass="form-control"
                            TextMode="Number" />
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Colour / variant</label>
                        <asp:TextBox ID="txtColour" runat="server"
                            CssClass="form-control"
                            Text="Various"
                            MaxLength="200" />
                    </div>

                    <div class="col-12 d-flex gap-2">
                        <asp:Button ID="btnSave" runat="server"
                            Text="Save package"
                            CssClass="btn btn-dark"
                            OnClick="btnSave_Click" />

                        <asp:Button ID="btnCancel" runat="server"
                            Text="Cancel"
                            CssClass="btn btn-outline-secondary"
                            OnClick="btnCancel_Click"
                            CausesValidation="false" />
                    </div>
                </div>
            </div>
        </asp:Panel>

        <div class="row g-2 align-items-center mb-3">
            <div class="col-md-9">
                <asp:TextBox ID="txtSearch" runat="server"
                    CssClass="form-control"
                    placeholder="Search package name or category..." />
            </div>

            <div class="col-md-3">
                <asp:Button ID="btnSearch" runat="server"
                    Text="Search"
                    CssClass="btn btn-primary w-100"
                    OnClick="btnSearch_Click"
                    CausesValidation="false" />
            </div>
        </div>

        <div class="table-responsive">
            <table class="table admin-data-table align-middle mb-0">
                <thead>
                    <tr>
                        <th>Package ID</th>
                        <th>Package name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Category</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                    <asp:Repeater ID="rptPackages" runat="server"
                        OnItemCommand="rptPackages_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td>PK<%#: Eval("ProductID", "{0:0000}") %></td>

                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <img src='<%#: ResolveUrl(Convert.ToString(Eval("ImageUrl"))) %>'
                                            class="admin-product-thumb"
                                            alt=""
                                            onerror="this.style.visibility='hidden'" />
                                        <span><%#: Eval("ProductName") %></span>
                                    </div>
                                </td>

                                <td class="small text-muted">
                                    <%#: Eval("Description") %>
                                </td>

                                <td><%#: FormatRands(Eval("Price")) %></td>

                                <td><%#: Eval("Category") %></td>

                                <td>
                                    <span class='<%# Convert.ToBoolean(Eval("IsAvailable")) ? "badge text-bg-success" : "badge text-bg-secondary" %>'>
                                        <%# Convert.ToBoolean(Eval("IsAvailable")) ? "Active" : "Inactive" %>
                                    </span>
                                </td>

                                <td class="text-nowrap">
                                    <asp:LinkButton ID="btnEdit" runat="server"
                                        CssClass="btn btn-outline-dark btn-sm admin-icon-button"
                                        CommandName="EditPackage"
                                        CommandArgument='<%# Eval("ProductID") %>'
                                        CausesValidation="false"
                                        aria-label="Edit package"
                                        ToolTip="Edit package">
                                        <i class="bi bi-pencil-square"
                                            aria-hidden="true"></i>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnToggle" runat="server"
                                        CssClass="btn btn-outline-dark btn-sm admin-icon-button"
                                        CommandName="TogglePackage"
                                        CommandArgument='<%# Eval("ProductID") %>'
                                        CausesValidation="false"
                                        aria-label="Change package availability"
                                        ToolTip="Change availability">
                                        <i class='<%# Convert.ToBoolean(Eval("IsAvailable")) ? "bi bi-toggle-on" : "bi bi-toggle-off" %>'
                                            aria-hidden="true"></i>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>

        <asp:Panel ID="pnlEmpty" runat="server"
            Visible="false"
            CssClass="card p-5 text-center text-muted mt-3">
            No hire packages found.
        </asp:Panel>

    </div>
</asp:Content>

