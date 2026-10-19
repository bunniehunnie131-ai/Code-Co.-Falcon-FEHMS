<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/Customer.master" AutoEventWireup="true" CodeBehind="CustomerProfile.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.CustomerProfile" %>
<%@ Register Src="~/Presentation/Profile.ascx" TagPrefix="uc" TagName="UserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerContent" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
    <uc:UserProfile ID="Profile1" runat="server" />

</asp:Content>
