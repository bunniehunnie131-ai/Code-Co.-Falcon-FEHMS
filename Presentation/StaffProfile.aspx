<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="StaffProfile.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.StaffProfile" %>
<%@ Register Src="~/Presentation/Profile.ascx" TagPrefix="uc" TagName="Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Stylesheet/Forte.css" rel="stylesheet" />
    <uc:Profile ID="Profile1" runat="server" /> 
</asp:Content>

