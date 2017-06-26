<%@ Page Language="C#" MasterPageFile="/masterpage/mastermobile.master" AutoEventWireup="true" CodeFile="FindOwner.aspx.cs" Inherits="FindOwner" Title="Find Owner" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Find Owner by Email | Vacations-Abroad.com
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" Runat="Server">
<form id="mainform" runat="server">
        <div class="scontainer">
  <div class="internalpage srow">
   <br /><br /><br /><br /> Want to list a property with us? First, let us verify if you have an account with <%= CommonFunctions.GetSiteName () %>
    <br />
    <br />
    Enter your e-mail address:
    <asp:TextBox ID="EmailAddress" runat="server" Width="200px" /><br />
    <br />
    <asp:Button ID="CheckEmail" runat="server" Width="120px" Text="Check E-mail" OnClick="CheckEmail_Click">
    </asp:Button>
    <br /> <br /> <br />
    <asp:HyperLink ID="UserFound" runat="server" Visible="False" NavigateUrl="Login.aspx">We found you in our database. Click here to login.</asp:HyperLink>
    <asp:HyperLink ID="UserNotFound" runat="server" Visible="False" NavigateUrl="AccountInformation.aspx">We did not find you in our database. Click here to create your account.</asp:HyperLink>
 <br /> <br />
  </div>
    </div>
</form>
</asp:Content>
