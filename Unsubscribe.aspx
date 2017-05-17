<%@ Page Title="Newsletter Subscribe" Language="C#" MasterPageFile="/masterpage/mastermobile.master" AutoEventWireup="true" CodeFile="Unsubscribe.aspx.cs" Inherits="Unsubscribe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bodycontent" Runat="Server">
        <div class="scontainer">
 <div class="internalpage">
    <div class="srow">
        <h1>
        <asp:Label ID="lblTitle" runat="server"></asp:Label></h1>
    <table>
    <%--<tr><td align="left">
        <asp:TextBox ID="txtName" runat="server" Width="200px"></asp:TextBox>&nbsp;<asp:Label
            ID="lblName" runat="server" Text="Name"></asp:Label></td></tr>--%>
        <tr><td align="center">
        <asp:TextBox ID="txtEmail" runat="server" Width="200px"></asp:TextBox>&nbsp;Email</td></tr>
        <tr><td>
        <asp:Button ID="btnSubmit" runat="server" Text="Remove from List" 
            onclick="btnSubmit_Click" /><asp:Button ID="btnAdd" runat="server" 
                Text="Subscribe to List" onclick="btnAdd_Click" /></td></tr>
            </table>
        <asp:Label ID="lblInfo" runat="server" ForeColor="Red"></asp:Label>
    </div>
 </div>
            </div>
</asp:Content>

