<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master"
    AutoEventWireup="true" CodeFile="~/stateprovincelist.aspx.cs" Inherits="StateProvinceList"
    Title="<%# GetTitle () %>" EnableEventValidation="false" ValidateRequest="false"  %>

<%--<%@ OutputCache Duration="600" VaryByParam="*" %>--%>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
   <%=stateprovince %> Vacation Rentals, Boutique Hotels | Vacations Abroad
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <style>
        .normalGroup{margin-top:20px;}.radiogroup{display:inline-block;}
                                    
    </style>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
    <asp:Label ID="Title" runat="server" Visible="false" Text="%stateprovince% %country% Vacation Rentals, %stateprovince% Vacation Home Rentals, %stateprovince% Holiday Accommodation"></asp:Label>
    <asp:Label ID="Keywords" runat="server" Visible="false" Text="%stateprovince% vacation rentals, %stateprovince% Hotels, %stateprovince% Cottages, %stateprovince% B&Bs, %stateprovince% villas , "></asp:Label>
    <asp:Label ID="Description" runat="server" Visible="false" Text="A great selection of unique %stateprovince% vacation rentals and boutique %stateprovince% properties for your next adventure in %stateprovince% ."></asp:Label>
    <asp:TextBox runat="server" ID="txtCityVal" value="" Style="display: none;"></asp:TextBox>
    <asp:TextBox runat="server" ID="txtCityVal2" value="" Style="display: none;"></asp:TextBox>
    <%--    <asp:TextBox runat="server" ID ="txtCityVal"  value="" Style="display:none;" ></asp:TextBox>
    --%>
        <div class="scontainer">

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
         <div class="heding_box center">

            <h2 class="orangetxt">
                <asp:Literal ID="ltrHeading" runat="server"></asp:Literal></h2>

        </div>
    <div class="srow">
        <div class="borerstep normalGroup">
            <div class="srow">
              <div class="stepfont">
                <div class="col-1">
                   <label> Step 1:</label>
                </div>
                <div class="col-11">
                    <%      int total_count = 0;
                        int rcount = ds_PTypeNum.Tables[0].Rows.Count;
                         string dis_all =(ptype == 0 ) ? "checked='checked'" : "";
                        if (ds_PTypeNum.Tables[0].Rows.Count > 0)
                        {
                           
                            for(int tid= 0; tid< rcount; tid++)
                            {
                                string pcid = ds_PTypeNum.Tables[0].Rows[tid]["pcid"].ToString();
                                string pctype = ds_PTypeNum.Tables[0].Rows[tid]["CategoryTypes"].ToString();
                                int pnum = int.Parse( ds_PTypeNum.Tables[0].Rows[tid]["Num"].ToString());
                                total_count += pnum;
                                string str_chk = (ptype.ToString() == pcid) ? "checked='checked'" : "";
                                %>
                        <div class="radiogroup"> <input type="radio" value="<%=pcid %>" name="ptypes" <%=str_chk %>  /><%=pctype %> (<%=pnum %>)</div>                    <%

                                
                            }

                        }
                        
                         %>
                   <div class="radiogroup"> <input type="radio" value="0" name="ptypes"  <%=dis_all %> />Dispay all (<%=total_count %>)</div>

                </div>
            </div>
             </div>
            <div class="srow">
            <div class="stepfont">
                <div class="col-1">
                   <label> Step 2:</label>
                </div>
                <div class="col-9">
                    <% string[] chk_sleep = { "", "", "", "" }; chk_sleep[psleep] = "checked='checked'"; %>
                    <div class="radiogroup"><input type="radio" value="1" name="psleep" <%=chk_sleep[1] %>/>Sleeps 1-4 (<%=sleeps[1] %>)</div>
                    <div class="radiogroup"><input type="radio" value="2" name="psleep" <%=chk_sleep[2] %>/>Sleeps 5-8 (<%=sleeps[2] %>)</div>
                    <div class="radiogroup"><input type="radio" value="3" name="psleep" <%=chk_sleep[3] %>/>Sleeps 9+ (<%=sleeps[3] %>)</div>
                    <div class="radiogroup"><input type="radio" value="0" name="psleep"  <%=chk_sleep[0] %>/>Display All (<%=sleeps[0] %>)</div>
                </div>
                <div class="col-2">
                    <div>
                    <asp:Button ID="btnFilter" runat="server" Text="Search" Style="width: 117px !important;white-space: normal;white-space: normal;border-radius: 1em;
                            color: white;font-family: arial; font-size: 12px;background: #154890;cursor:pointer;font-weight: bold;height: 26px;right: 6px;top: -22px;
                                                                    
                            width: 120px;box-shadow: 2px 2px 6px #154890;border: 1px solid #154890;"
                        OnClick="btnFilter_Click" CausesValidation="False"/>
                    </div>
                </div>
            </div>
                </div>

        </div>
    </div>
        <div class="srow">
            <div class="center">
            <div class="srow">
                <%

                    int counts = ds_PropList.Tables[0].Rows.Count;
                    for (int rind = 0; rind < counts; rind++)
                    {
                        if (rind != 0 && rind % 4 == 0)
                        {
                        %>
                        </div>
                  <%}
                          var vrow = ds_PropList.Tables[0].Rows[rind];
                          int vpropid = int.Parse(vrow["ID"].ToString());
                          string str_city = vrow["City"].ToString();
                          string str_state= vrow["StateProvince"].ToString();
                          string str_country= vrow["Country"].ToString();
                          string url = String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/{3}/default.aspx", str_country, str_state, str_city, vpropid).ToLower().Replace(" ", "_");
                          string city_url= String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/default.aspx", str_country, str_state, str_city).ToLower().Replace(" ", "_");

                          string alt;
                          int prop_cat;
                          int.TryParse(vrow["Category"].ToString(), out prop_cat);
                          if (proptypeinfo.Contains(prop_cat)) alt = vrow["Name2"].ToString() + " Boutique Hotel";
                          else alt = vrow["Name2"].ToString() + " Vacation Rental";


                      if (rind % 4 == 0) {
                     %>
                            <div class="srow normalGroup">
                            
                        <%} %>
                    <div class="col-3">
                        <div><a href="<%=city_url %>"><%=str_city %></a></div>
                        <div class="imgwrapper"><a href="<%=url %>"><img src="/images/<%=vrow["FileName"] %>" class="imgstyle" alt="<%=alt %>" title="<%=alt %>"/></a></div>
                        <div><span class='scomments'><%=vrow["CategoryTypes"]%> Sleeps <%=vrow["NumSleeps"] %> </span> <br />
                             <span class='scomments'>Rates <%=vrow["minNightRate"] %> - <%=vrow["HiNightRate"] %> <%=vrow["minRateCurrency"] %>
                          </span>

                        </div>
                    </div>
                    

                <%} %>
                </div>
            </div>
            </div>
        </div>
                  <%--right cities column edit--%>
 


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
                           <asp:Label ID="lblInfo22" runat="server" ForeColor="Red" Style="display: none"></asp:Label>

                   <div class="smallgap">

                </div>
    </div>
        </div>

 </div>
 


    </div>

   
</asp:Content>
