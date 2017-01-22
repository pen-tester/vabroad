<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master"
    AutoEventWireup="true" CodeFile="~/stateprovincelist.aspx.cs" Inherits="StateProvinceList"
    Title="<%# GetTitle () %>" EnableEventValidation="false" ValidateRequest="false"  %>

<%--<%@ OutputCache Duration="600" VaryByParam="*" %>--%>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
   <%=stateprovince %> Vacation Rentals, Boutique Hotels | Vacations Abroad
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
    <asp:Label ID="Title" runat="server" Visible="false" Text="%stateprovince% %country% Vacation Rentals, %stateprovince% Vacation Home Rentals, %stateprovince% Holiday Accommodation"></asp:Label>
    <asp:Label ID="Keywords" runat="server" Visible="false" Text="%stateprovince% vacation rentals, %stateprovince% Hotels, %stateprovince% Cottages, %stateprovince% B&Bs, %stateprovince% villas , "></asp:Label>
    <asp:Label ID="Description" runat="server" Visible="false" Text="A great selection of unique %stateprovince% vacation rentals and boutique %stateprovince% properties for your next adventure in %stateprovince% ."></asp:Label>
    <asp:TextBox runat="server" ID="txtCityVal" value="" Style="display: none;"></asp:TextBox>
    <asp:TextBox runat="server" ID="txtCityVal2" value="" Style="display: none;"></asp:TextBox>
    <%--    <asp:TextBox runat="server" ID ="txtCityVal"  value="" Style="display:none;" ></asp:TextBox>
    --%>
    

 <div class="srow">
       <div class="internalpagewidth">
            <div class="srow">
                   <div>
                       <div class=" backitem">
                       <asp:HyperLink ID="hyplinkBackRegion" runat="server">
                                <asp:Literal ID="ltrRegion" runat="server"></asp:Literal>
                        </asp:HyperLink>
                       <asp:HyperLink ID="hyplnkBackLink" runat="server">
                                <asp:Literal ID="ltrBackText" runat="server"></asp:Literal>
                        </asp:HyperLink>
                       </div>
 
                          <h1 class="H1CityText center">
                            <asp:Literal ID="ltrH1" runat="server"></asp:Literal>
                            <br />
                        </h1>
                    </div>

                    <asp:Label ID="Label1" runat="server" EnableViewState="False" ForeColor="Red" Style="display: none"></asp:Label>

                    <div class="srow">
                        <div class="col-x-4 col-6">
                      <% if (AuthenticationManager.IfAuthenticated && AuthenticationManager.IfAdmin)
                           { %>
                        <asp:TextBox ID="txtCityText" runat="server" Rows="7" TextMode="MultiLine" Width="600px"></asp:TextBox><br />
                        <asp:Button ID="btnSubmit" runat="server" Text="Save Text" OnClick="btnSubmit_Click" />
                        <br />
                        <asp:Label ID="Label9" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
                        <% }
                           else
                           {%>
                        <div id="divHide123" class="txtalign" runat="server">
                            <asp:Label ID="lblcityInfo" runat="server"></asp:Label>
                        </div>


                        <% } %>
                        </div>
                        <div class="col-x-4 col-6">
                           <div  id="googlemap" runat="server">
                            </div>
                        </div>
  

 
                    </div>
                <div>
                   <asp:Label ID="lblInfo" runat="server" ForeColor="Red"></asp:Label>
                    <asp:SqlDataSource ID="Sql_properties" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                        SelectCommand="GetPropertiesFromStateID2" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="25" Name="StateProvinceID" QueryStringField="StateProvinceID"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

 
                    <%--right cities column edit--%>
          <div class="heding_box center">

            <h2>
                <asp:Literal ID="ltrHeading" runat="server"></asp:Literal></h2>

        </div>

        <div class="srow">
            <div class="center">
            <ul id="ulManiGrid" class="stateful" runat="server">
            </ul>
            </div>
        </div>
        <div class="custm-content">

            <div class="srow">
                   <div class="col-12">

                    <div class="subtitle" visible="true" id="OrangeTitle" runat="server">

                        <h2 style="margin-top:55px; background-color:white;"><%=stateprovince %> Vacations: Things to see while on vacation in 
                        <asp:Literal ID="ltrStateThing" runat="server"></asp:Literal> <%=country %></h2>
  
                    </div>

                    <% if (AuthenticationManager.IfAuthenticated && AuthenticationManager.IfAdmin)
               { %>
                    <asp:TextBox ID="txtCityText2" runat="server" Rows="7" TextMode="MultiLine" Width="600px"></asp:TextBox><br />
                    <center>
                        <asp:Button ID="btnSubmit2" runat="server" Text="Save Text" OnClick="btnSubmit2_Click" /></center>
                    <br />
                    <% } %>
                    <p>
                        <asp:Label ID="lblInfo2" runat="server" EnableViewState="False" CssClass="LightTextLower"></asp:Label></p>

                </div>
            </div>

        </div>

        <div class="country_list_box">

            <ul>
                <li>
                    <div id="rtHd3" runat="server" style="display: inline"></div>
                </li>
                <asp:Literal ID="rtLow3" runat="server"></asp:Literal>
            </ul>
            <br />
            <ul>
                <li>
                    <div id="rtCountiesHd" runat="server" style="display: inline;"></div>
                </li>
                <asp:Literal ID="divCitiesRt" runat="server"></asp:Literal>
            </ul>

        </div>
    </div>
        </div>
 </div>
 

    <%--end right column edit--%>
    <div class="OrangeText" style="text-align: left; float: left;">
        <br />
    </div>

    <asp:Label ID="lblInfo22" runat="server" ForeColor="Red" Style="display: none"></asp:Label>
   
</asp:Content>
