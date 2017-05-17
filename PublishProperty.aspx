<%@ Page Language="C#" MasterPageFile="/masterpage/mastermobile.master" AutoEventWireup="true" CodeFile="PublishProperty.aspx.cs" Inherits="PublishProperty" Title="Publish Property" %>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" Runat="Server">
        <div class="scontainer">
<div class="internalpage srow">
	<% if (BackLink.Visible) { %>
    <table bgcolor="#e4e4af" cellspacing="0" cellpadding="0" width="250" align="center"
        border="2">
        <tr>
            <td>
                <div align="center">
                    <strong>
                        <asp:HyperLink ID="BackLink" runat="server" NavigateUrl="MyAccount.aspx">
							Return to My Account page
                        </asp:HyperLink>
                    </strong>
                </div>
            </td>
        </tr>
    </table>
	<br />
	<% } %>
    <%# PropertiesSet.Tables["Properties"].Rows[0]["Name"] %>
    -
    <%# PropertiesSet.Tables["Properties"].Rows[0]["City"] %>
    ,
    <%# PropertiesSet.Tables["Properties"].Rows[0]["StateProvince"] %>
    ,
    <%# PropertiesSet.Tables["Properties"].Rows[0]["Type"] %>
    <%# PropertiesSet.Tables["Properties"].Rows[0]["NumBedrooms"] %>
    Bedrooms,
    <%# PropertiesSet.Tables["Properties"].Rows[0]["NumBaths"] %>
    Baths,
    <%# PropertiesSet.Tables["Properties"].Rows[0]["NumSleeps"] %>
    Sleeps, Minimum nightly rental -
    <%# PropertiesSet.Tables["Properties"].Rows[0]["MinimumNightlyRental"] %>
    <br />
    Do you want to publish this property to the Internet?
    <br />
    <asp:Button ID="PublishButton" TabIndex="20" runat="server" Text="Publish" Width="96px"
        OnClick="PublishButton_Click" />
    <asp:Button ID="CancelButton" TabIndex="20" runat="server" Text="Cancel" Width="96px"
        OnClick="CancelButton_Click" />
        <br />
    <asp:Label ID="lblInfo" runat="server"></asp:Label>
</div>
            </div>
</asp:Content>
