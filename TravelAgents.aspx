<%@ Page Language="C#" MasterPageFile="/masterpage/mastermobile.master" AutoEventWireup="True" Inherits="TravelAgents" Title="Travel Agent - Vacation rentals that pay a travel agent commission" EnableEventValidation="False" CodeFile="TravelAgents.aspx.cs" %>

<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
    <div class="internalpage">
        <div class="srow">
    <div align="center">
    <div class="apphead">
    <h1 class="listingPagesH1Color H1CityText">Travel Agents 
                            Vacation Rentals<br>
        </h1>
        </div>
        </div>
    <div class="Left listingPagesH1Container">
        
    </div>
    <div style="padding-top: 50px"></div>
    
    <asp:Repeater ID="Repeater1" runat="server" DataMember="Properties" DataSource="<%# PropertiesFullSet %>">
        <HeaderTemplate>
            <table cellspacing="1" cellpadding="0" width="750" align="center" border="0" bgcolor="#333366">
                <tr bgcolor="#333366">
                    <td bgcolor="#ffffff" align="center"></td>

                    <td bgcolor="#333366" align="center">
                        <font color="#ffffff" size="2"><strong>Country</strong></font>
                    </td>
                    <td bgcolor="#333366" align="center">
                        <font color="#ffffff" size="2"><strong>State/Province</strong></font>
                    </td>
                    <td bgcolor="#333366" align="center">
                        <font color="#ffffff" size="2"><strong>City</strong></font>
                    </td>
                    <td bgcolor="#333366" align="center">
                        <font color="#ffffff" size="2"><strong>Prop Type</strong></font>
                    </td>
                    <td bgcolor="#333366" align="center">
                        <font color="#ffffff" size="2"><strong>Bedrms</strong></font>
                    </td>
                    <td bgcolor="#333366" align="center">
                        <font color="#ffffff" size="2"><strong>Sleeps</strong></font>
                    </td>
                    <td bgcolor="#333366" align="center">
                        <font color="#ffffff" size="2"><strong>Pool</strong></font>
                    </td>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr bgcolor="#ffffff">
                <td bgcolor="#ffffff" align="center" style="padding: 3px">
                    <%# CommonFunctions.ShowPropertyPhotoWithoutBacklinkTravel (((System.Data.DataRowView)Container.DataItem).Row)%>
                </td>

                <td align="center" style="vertical-align: middle">
                    <%# DataBinder.Eval(Container.DataItem, "Country", "{0}") %>
                </td>
                <td align="center" style="vertical-align: middle">
                    <%# DataBinder.Eval(Container.DataItem, "StateProvince", "{0}") %>
                </td>
                <td align="center" style="vertical-align: middle">
                    <%# DataBinder.Eval(Container.DataItem, "City", "{0}") %>
                </td>
                <td align="center" style="vertical-align: middle">
                    <a href='<%# CommonFunctions.PrepareURL (DataBinder.Eval(Container.DataItem, "Country", "{0}").Replace (" ", "_").ToLower () + "/" + DataBinder.Eval(Container.DataItem, "StateProvince", "{0}").Replace (" ", "_").ToLower () + "/" + DataBinder.Eval(Container.DataItem, "City", "{0}").Replace (" ", "_").ToLower () + "/" + DataBinder.Eval(Container.DataItem, "ID", "{0:d}") + "/default.aspx") %>'>
                        <%# DataBinder.Eval(Container.DataItem, "Type", "{0}") %>
                    </a>
                </td>
                <td align="center" style="vertical-align: middle">
                    <%# DataBinder.Eval(Container.DataItem, "NumBedrooms", "{0}") %>
                </td>
                <td align="center" style="vertical-align: middle">
                    <%# DataBinder.Eval(Container.DataItem, "NumSleeps", "{0}") %>
                </td>
                <td align="center" style="vertical-align: middle">
                    <%# DataBinder.Eval(Container.DataItem, "Pool", "{0}") %>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
        </div>
    </div>

    <!-- Start of StatCounter Code -->
 
    <!-- End Quantcast tag -->
</asp:Content>
