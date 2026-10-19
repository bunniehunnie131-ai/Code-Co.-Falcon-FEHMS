<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="CustomerProfile.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.CustomerProfile" %>
<%@ Register Src="~/Presentation/Profile.ascx" TagPrefix="uc" TagName="UserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
    <uc:UserProfile ID="Profile1" runat="server" />

</asp:Content>

