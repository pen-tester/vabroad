<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master" AutoEventWireup="true"
    CodeFile="CityList.aspx.cs" Inherits="newCityList" ValidateRequest="false" EnableEventValidation="false" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <%=countryinfo.City %> Vacation Rentals And Boutique Hotels | Vacation abroad
</asp:Content>


<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <meta name="description" content="<%=Server.HtmlDecode(newdescription) %>"/>
    <style>
        .smap{width:400px; height:300px;min-height:1px;margin:10px auto; }
    </style>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
    <asp:Label ID="Label2" runat="server" Visible="false" Text="%city% %stateprovinc% vacation Rentals, %city% %country% Holiday Rentals, %city% Rental Accommodations"></asp:Label>
    <asp:Label ID="Title" runat="server" Visible="false" Text="%city% %country% Vacation Rentals, %city% Villas, %city% Condos, Apartments, Hotels, Cottages"></asp:Label>
    <asp:Label ID="Keywords" runat="server" Visible="false" Text="%city% vacation rentals, %city% vacations, %city% %stateprovince% vacation rentals,   villas, cottages, boutique hotels"></asp:Label>
    <asp:Label ID="Description" runat="server" Visible="false" Text="Enjoy %city% vacations while relaxing in %city% vacation rentals, boutique hotels direct from owner in %stateprovince% %country%"></asp:Label>
    <asp:TextBox runat="server" ID="txtCityVal" value="" Style="display: none;"></asp:TextBox>
    <asp:TextBox runat="server" ID="txtCityVal2" value="" Style="display: none;"></asp:TextBox>
    <input type="hidden" name="proptyperadio" value="<%=rproptype_id %>" />
    <input type="hidden" name="bedroomtyperadio" value="<%=rbedroom_id %>" />
    <input type="hidden" name="amenityradio" value="<%=ramenity_id %>" />
    <input type="hidden" name="sortradio" value="<%=rsort_id %>" />
    <input type="hidden" name="pagenums" value="<%=pagenum %>" />

    
    <div class="scontainer">
         <span id="test234" runat="server" style="display: none"></span>
        <div class="internalpagewidth">
            <div class="srow">
                    <div >
                        <asp:HyperLink ID="hyperRegion" CssClass="backitem" runat="server"><%=countryinfo.Region %><<</asp:HyperLink>
                        <asp:HyperLink ID="hyplnkCountryBackLink" CssClass="backitem" runat="server"><%=countryinfo.Country %><<</asp:HyperLink>
                        <asp:HyperLink ID="hyplnkStateBackLink" CssClass="backitem" runat="server"><%=countryinfo.StateProvince %><<</asp:HyperLink>
                        <div class="clear"></div>

                    </div>
                <div class="center">
                        <h1 class="H1CityText">
                            <%--<%= city %> Vacation Rentals--%>
                            <asp:Literal ID="ltrH11"  runat="server"></asp:Literal>
                            <br />
                        </h1>
                </div>

            </div>
            <div class="srow">
                <div class="col-6" id="lbl_City">
                 <div class="txtalign">
                        <asp:Label runat="server" ID="lblcity"  ></asp:Label>
                  </div>
                 </div>
                <div class="col-6 center" id="wrap_map">
                    <div class="smap" id="map_canvas">

                    </div>
                </div> 
                <input type="hidden"  id="cityid" value="<%=cityid %>"  />
                <input type="hidden"  id="CityParam" name="CityParam"  runat="server" />
                    <%--padding 305 center--%>
                    <div class="srow">
                        <% if (AuthenticationManager.IfAuthenticated && AuthenticationManager.IfAdmin)
                           { %>
                        <asp:TextBox ID="txtCityText" runat="server" Rows="7" TextMode="MultiLine" Width="600px"></asp:TextBox><br />
                        <asp:Button ID="btnSubmit" runat="server" Text="Save Text" OnClick="btnSubmit_Click" />
                        <br />
                        <asp:Label ID="lblInfo" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
                        <% }%>
                         
                    </div>

            <div class="srow" >
                        <div class="heding_box">
                                <h2>
                                    <%=countryinfo.City %> Vacation Rentals and <%=countryinfo.City %> Hotels
                                </h2>
                            </div>
                        
            </div>
        <div class="srow">
                  <div class="borerstep">

            <div class="stepfont">
                <div class="col-1">
                     <label> Step 1: </label>
                </div>
                 <div class="col-7">
                       <% 
//"City" vacation Rentals (count) "City" Hotesl (count)
                           for (int i = 0; i < 3; i++) {%>
                        <input type="radio" name="proptype" value="<%=prop_typeval[i]%>" /> <%=str_propcate[i] %> (<%=prop_nums[i] %>)
                    <%} %>
                   
       
                 </div>
               <div class="clear"></div>
            </div>
            <div class="stepfont">
                <div class="col-1">
                    <label> Step 2: </label> 
                </div>
                <div class="col-8"><input type="radio"  name="roomnums"  value="1" /> 0-2 BD (<%=bedroominfo[1] %>)
                <input type="radio"   name="roomnums" value="2" /> 3-4 BD (<%=bedroominfo[2] %>)
                <input type="radio"  name="roomnums" value="3" /> 5+ BD (<%=bedroominfo[3] %>)
                <input type="radio"  name="roomnums" value="0" /> All (<%=bedroominfo[0] %>)</div>
                <div class="clear"></div>
            </div>
            <div class="stepfont">
                <div class="col-1">
                        <label> Step 3: </label>
                </div>
                <div class="col-9">
                <div  class="svisible"><input type="radio"  name="amenitytype" value="8" /> Hot Tub(<%=amenity_nums[0] %>)</div>
                <input type="radio"  name="amenitytype" value="33" /> Internet(<%=amenity_nums[1] %>)
                <input type="radio"  name="amenitytype" value="1" /> Pets(<%=amenity_nums[2] %>)
                <input type="radio"  name="amenitytype" value="11" /> Pool(<%=amenity_nums[3] %>)
                <input type="radio"  name="amenitytype" value="0" /> All(<%=amenity_nums[4] %>)
                </div> 
                <div class="clear"></div>
            </div>
            <div class="stepfont">
                <div class="col-1">
                    <label> Step 4: </label>
                </div>
                <div class="col-9">
                 <input type="radio"  name="pricesort" value="1" /> High to Low Price
                <input type="radio"  name="pricesort" value="2" /> Low to High Price
                
                </div>
                <div class="col-2">
                    <input type="submit" id="refresh" class="btnsigns" value="Search" />
                </div>
                <div class="clear"></div>
            </div>

        </div>
        </div>
          <div class="srow">
        
 
        <div class="srow">
            <div class="pcontent">
                <%  int pages = (proplistset.allnums+19) / 20 ;
                    List<Location> eLocation = new List<Location>();
                    for (int pg = 0; pg < pages; pg++)
                    {
                         %>
              
                <div class="page_hid" id="cpage<%=pg %>">

                         <%   int maxitem = (proplistset.allnums > (pg + 1) * 20) ? (pg + 1) * 20 : proplistset.allnums;
                             for (int i = pg*20; i < maxitem; i++)
                             {
                                 //Response.Write(proplistset.propertyList.Count);break;
                                 PropertyAmenityInfo propamen = proplistset.propertyList[i];
                                 string propname = propamen.detail.PropertyName + " " + propamen.detail.NumBedrooms + " Bedroom " + propamen.detail.NumBaths + " BA Sleeps " + propamen.detail.NumSleeps;
                                 // Rates:  79-169 EUR Per Night 2 nights Minimum 
                                 string rates = "Rates: " + propamen.detail.MinNightRate + "-" + propamen.detail.HiNightRate + "  " + propamen.detail.MinRateCurrency + " Per Night. Minimum " + min_rentaltypes[propamen.detail.MinimumNightlyRentalID]+" Rental.";
                                 string amenity = "Amenity:  ";
                                 int am_count = propamen.amenity.Count;
                                 string href = ("/" + propamen.detail.Country + "/" + propamen.detail.StateProvince + "/" + propamen.detail.City + "/" + propamen.detail.ID + "/default.aspx").ToLower().Replace(" ", "_");
                                 // var alt = (propamen_typeval.indexOf(propamen.detail.Category) == -1) ? propamen.detail.City + " " + propamen.detail.NumBedrooms +" bedroom Vacation Rentals" : propamen.detail.City + " " + propamen.detail.NumBedrooms+" bedroom Boutique Hotels";
                                 //var alt = (propamen_typeval.indexOf(propamen.detail.Category) == -1) ?"Rentals" : "Hotel";
                                 //console.log(am_count);
                                 //string alt = (!property_typeval.Contains(propamen.detail.Category)) ? propamen.detail.City + " " + propamen.detail.NumBedrooms + " bedroom Vacation Rental" : propamen.detail.City + " " + propamen.detail.NumBedrooms + " bedroom Hotel";
                                 string alt = propamen.detail.Name2;

                                 int addr_verified;
                                 addr_verified = propamen.detail.loc_verified;
                                 float latitude, longitude;
                                 latitude = propamen.detail.loc_latlang;
                                 longitude = propamen.detail.loc_logitude;

                                 string url = String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/{3}/default.aspx",
                                     propamen.detail.Country, propamen.detail.StateProvince ,propamen.detail.City,propamen.detail.ID).ToLower().Replace(" ","_");

                                 if(addr_verified == 1)
                                 {
                                     Location loc = new Location();
                                     loc.title = propamen.detail.Name2;
                                     loc.lat = latitude;
                                     loc.lng = longitude;
                                     loc.description = propamen.detail.Name2;
                                     loc.URL = url;
                                     eLocation.Add(loc);
                                 }



                                 for (int j = 0; j < am_count; j++)
                                 {
                                     amenity += (propamen.amenity[j].Amenity + ", ");
                                 }
                                 amenity = amenity.Substring(0, amenity.Length - 2);




                                   %>
                           <div class="img_row" > 
                                <div class="srow">
                 <div class="col-x-4 col-3">
                     <div class="drop-shadow effect4">
                       <a href="<%=href.Replace(" ", "_") %>"> <img class="thumbimg" title="<%=alt %>" alt="<%=alt %>" src="/images/<%= propamen.detail.FileName %>"/></a>
                     </div>
                     <div class="srow">
                         <label class="imgtitle">
                             <%=propamen.detail.Name2 %>
                         </label>
                     </div>
                 </div>          
                <div class="col-x-4 col-9">
                    <div class="explaination">
                        <div class="srow">
                            <div class="col-9">
                                <div class="ex_con1">
                                    <a href="<%=href.Replace(" ", "_") %>"><%=propname %></a>
                                </div>
                            </div>
                            <div class="col-3">
                                <div style="float:right;">
                                    <% for (int star_ind = 0; star_ind < list_rating[i]; star_ind++)
                                        { %>
                                    <img src="/images/star2.gif" />
                                    <%} %>
                                </div>
                            </div>
                        </div>
                        
                        <div class="ex_con2">
                            <%=rates %>
                        </div>
                        <div class="ex_con2">
                            <%=amenity %>
                        </div>
                        <div class="ex_con3">
                            <%=propamen.detail.Name %>

                        </div>
                    </div>
                </div>
                </div>
                          </div> 

                          <%} %>
                </div>
                <%}
                    string ans =BookDBProvider.getJsonString<Location>(eLocation) ; %>
            </div>
        </div>
        <div class="srow">
            <input type="hidden" name="allpages" value="<%=proplistset.allnums %>" />
            <div class="pagination" id="paging">
        
            </div>
        </div>
   <% if (countryinfo.CityText2!="")
{ %>
                 <div class="com_box">
                                <h2>
                                    <%=countryinfo.City %> Vacations: Things to see while on vacation in <%=countryinfo.City %> <%=countryinfo.StateProvince %>
                                </h2><br />
                     <label>
                         <%=Server.HtmlDecode(countryinfo.CityText2)%>
                     </label>
                   </div> 

            <% } %>
               </div>


 
                                               <div>

                                                                <br />
                                                                <% if (AuthenticationManager.IfAuthenticated && AuthenticationManager.IfAdmin)
                                                                   { %>
                                                                <center>
                                                                        <asp:TextBox ID="txtCityText2" runat="server" Rows="7" TextMode="MultiLine" Width="600px"></asp:TextBox>
                                                                        <br />
                                                                        <asp:Button ID="btnSubmit2" runat="server" Text="Save Text" OnClick="btnSubmit2_Click" /></center>
                                                                <br />
                                                                <% } %>
                                                    </div>
                                  <div class="OrangeText" style="text-align: left; float: left;">
                        <br />
                    </div>
        <asp:Label ID="lblInfo22" runat="server" ForeColor="Red"></asp:Label>
                <div class="clear"></div>

   
        </div>
                       <div class="row">
         <div class="srow normalbottom">
             <ul class="citylist">
                 <li><%=countryinfo.StateProvince %> Cities: </li>
             <% int rcount = city_ds.Tables[0].Rows.Count;
                 for (int i = 0; i < rcount; i++)
                 {
                     string txt = String.Format("{0}",city_ds.Tables[0].Rows[i][0] );
                     string href = String.Format("/{0}/{1}/{2}/default.aspx", countryinfo.Country, countryinfo.StateProvince, txt).ToLower().Replace(" ", "_");
                     string mark = (i != (rcount - 1)) ? ",&nbsp;" : "";
                     %>
                 <li><a href="<%=href %>"><%=txt+mark %></a></li>
              <%} %>
             </ul>
         </div> 
     </div>

    </div>

 

    </div>
  <script>
      var gmarkers = <%=ans%>;
  </script>
   
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&sensor=false"> </script>
    <script defer="defer" src="/Assets/js/citylist.js"></script>
</asp:Content>
