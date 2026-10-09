<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/SystemLayout.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="FEHMS_FortEventHireManagementSystem.Presentation.WebForm8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="lblMainHeading" runat="server" Text="Create Your Account"></asp:Label>
                            <br />
                    <asp:Label ID="lblSubHeading" runat="server" Text="Join Code & Co. Falcon Event Hire"></asp:Label>
                        <br />
                        <br />
                    <asp:TextBox ID="txtFullName" runat="server" placeHolder="Full Name"></asp:TextBox>
                            <br />
                    <asp:TextBox ID="txtEmailAddress" runat="server" placeHolder="Email Address"></asp:TextBox>
                        <br />
                                        <asp:TextBox ID="txtDateOfBirth" runat="server" placeHolder="Date Of Birth"></asp:TextBox>
                                            <br />
                                        <asp:TextBox ID="txtIDNumber" runat="server" placeHolder="ID Number"></asp:TextBox>
                                            <br />
                        
                        <asp:DropDownList ID="ddlSecurityQuestion" runat="server">
                        </asp:DropDownList>
                            <br />

                    <asp:TextBox ID="txtPassword" runat="server" placeHolder="Password"></asp:TextBox>
                    <br />
        <asp:TextBox ID="txtConfirmPassword" runat="server" placeHolder="ConfirmPassword"></asp:TextBox>
                <br />
                                <asp:CheckBox ID="cbUserAgreement" runat="server" />
            
                                    <label>I agree to the</label>
                <asp:HyperLink ID="hlTermsAndConditions" runat="server">Terms and Condtions</asp:HyperLink>
                <label>and</label>
<asp:HyperLink ID="hlPrivacyPolicy" runat="server">Privacy Policy</asp:HyperLink>
<br />

<asp:Button ID="btnRegister" runat="server" Text="Register" />
<br />
<br />
        <label>Already have an account?</label>
<asp:HyperLink ID="hlLoginHere" runat="server">Login here</asp:HyperLink>
</asp:Content>
