<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master" AutoEventWireup="true"
    CodeFile="CityList.aspx.cs" Inherits="newCityList" ValidateRequest="false" EnableEventValidation="false" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <%=countryinfo.City %> Vacation Rentals And Boutique Hotels | Vacations Abroad
</asp:Content>
<asp:Content ID="meta" ContentPlaceHolderID="meta" runat="server">
<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [{
    "@type": "ListItem",
    "position": 1,
    "item": {
      "@id": "<%=String.Format("https://www.vacations-abroad.com/{0}/default.aspx",countryinfo.Region).ToLower().Replace(" ","_") %>",
      "name": "<%=countryinfo.Region %>"
    }
  },{
    "@type": "ListItem",
    "position": 2,
    "item": {
      "@id": "<%=String.Format("https://www.vacations-abroad.com/{0}/default.aspx",countryinfo.Country).ToLower().Replace(" ","_") %>",
      "name": "<%=countryinfo.Country %>"
    }
  },{
    "@type": "ListItem",
    "position": 3,
    "item": {
      "@id": "<%=String.Format("https://www.vacations-abroad.com/{0}/{1}/default.aspx",countryinfo.Country,countryinfo.StateProvince).ToLower().Replace(" ","_") %>",
      "name": "<%=countryinfo.StateProvince %>"
    }
  },{
    "@type": "ListItem",
    "position": 4,
    "item": {
      "@id": "<%=String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/default.aspx",countryinfo.Country,countryinfo.StateProvince, countryinfo.City).ToLower().Replace(" ","_") %>",
      "name": "<%=countryinfo.City %>"
    }
  }] 
}
     <meta name="description" content="<%=Server.HtmlDecode(newdescription) %>"/>
</asp:Content>

<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">

    <style>
    /*For footer text*/
       .footer_text{padding:25px 0 0 0;}
    /* For map*/
        .smap{height:300px;min-height:1px;margin:15px 20px; }
        .borerstep{display:none;}
    /*For the step box*/
        ul.step_line{display:block; margin:0;padding:0;}
        ul.step_line li{display:inline-block; padding:3px 0px;}
        .btn_wrapper{padding:5px 0 0 15px;display:inline-block;}
    /*for each property*/
        .property_img{ width: 300px; height:220px;}
        .sleepsicon{width:40px;height:55px;}
        .prop_type{font-size:11pt;font-style:italic; padding:10px;color: #3c3c3c; }
        .prop_name{font-size:12pt;color: #3c3c3c; padding:0 10px;}
        .prop_sleep{padding-left:10px;}
        .prop_sleep span{font-size:11pt;color: #050505;display:inline-block; vertical-align:top; padding-top:10px;}
        .prop_detail{font-size:11pt;color: #3c3c3c; padding:0 10px;}
        .prop_amenity{font-size:11pt;color: #3c3c3c; padding:10px;}
        .prop_rates{font-size:12pt;color: #050505;padding:10px;}
        .prop_rates_val{font-size:11pt;color: #3c3c3c;padding:5px 10px;}
        .btn_moreinfos,.btn_moreinfos:hover{font-variant:small-caps;  font-size:11pt; color:#2f528f;display:inline-block;font-weight:bold;padding:10px 20px;border:2px solid #ffd4c0;}
        .btn_gurantee, .btn_gurantee:hover{width :100%;display:inline-block; padding:10px 20px; background-color:#4472c4;border:1px solid #2f528f;color:#fff; box-sizing:border-box;}
        .btn_moreinfo,.btn_moreinfo:hover{border-radius:5px; border:3px solid #e1d4c0;font-size:11pt; color:#2f528f;padding:7px 25px;background-color:#f5ede3;font-weight:bold;
                 -moz-box-shadow:
		 2px 2px 3px 3px #c5bfb6 inset,-2px -2px 3px 3px #c5bfb6 inset;
	-webkit-box-shadow:
		 2px 2px 3px 3px #c5bfb6 inset,-2px -2px 3px 3px #c5bfb6 inset;
	box-shadow: 2px 2px 3px 3px #c5bfb6 inset,-2px -2px 3px 3px #c5bfb6 inset;
        cursor:pointer;
    }
    .btn_moreinfo:active{
           -moz-box-shadow:
		 3px 3px 3px 3px #c5bfb6 inset,-1px -1px 3px 3px #c5bfb6 inset;
	-webkit-box-shadow:
		 3px 3px 3px 3px #c5bfb6 inset,-1px -1px 3px 3px #c5bfb6 inset;
	box-shadow: 3px 3px 3px 3px #c5bfb6 inset,-1px -1px 3px 3px #c5bfb6 inset;
    padding:8px 24px 6px 26px;
    }
    .cont_button{padding:20px 0; width:100%;}
        [class*=colfield_]{float:left;}
      .mapbox{
         border:3px solid #f0b892;
         padding:10px;
         width:550px;
         height:350px;
         margin-top:210px;
         display:inline-block;
         z-index:30;
     }
      #map_canvas{
          width:550px;
          height:350px;
      }
     @media(max-width:600px){
        .colfield_1{width:65px;}
        .colfield_2{}
        .colfield_3{width:200px;text-align:right;}
        .mapbox{
            width:95%; margin:250px auto;
            height:270px;
        }
        #map_canvas{
              width:95%;
              height:250px;
        }
     }

     @media(max-width:768px) and (min-width:600px){
        .colfield_1{width:65px;}
        .colfield_2{width:460px;}
        .colfield_3{width:350px;text-align:right;}
        .property_img{ width: 240px; height:170px;}
     }

     @media(min-width:768px)and (max-width:992px){
        .colfield_1{width:65px;}
        .colfield_2{width:460px;}
        .colfield_3{width:350px;text-align:right;}
        .property_img{ width: 260px; height:180px;}
     }

     @media(max-width:1200px )and (min-width:992px){
        .colfield_1{width:65px;}
        .colfield_2{width:560px;}
        .colfield_3{width:250px;text-align:right;}
        .property_img{ width: 260px; height:180px;}
     }
     @media(min-width:1200px){
        .colfield_1{width:65px;}
        .colfield_2{width:560px;}
        .colfield_3{width:450px;text-align:right;}
     }
     /* For Scrollable*/
     .scrollable{
         
     }
     .selected_prop{
         background-color:#fff;
     }

     .wrapper_property{
         margin:4px 0;
         border:2px solid #ffd4c0;
         padding:5px;
     }
     .btn_linker,.btn_linker:hover{
         padding:5px 15px;
         border:2px solid #808080;
         background-color:#fff;
         color:#808080;
         font-size:11pt;
         cursor:pointer;
         display:inline-block;
     }
     .wraper_buttons{
         padding:15px;
     }

    </style>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
    <form id="mainform" runat="server">
    <input type="hidden" name="proptyperadio" value="<%=rproptype_id %>" />
    <input type="hidden" name="bedroomtyperadio" value="<%=rbedroom_id %>" />
    <input type="hidden" name="amenityradio" value="<%=ramenity_id %>" />
    <input type="hidden" name="sortradio" value="<%=rsort_id %>" />
    <input type="hidden" name="pagenums" value="<%=pagenum %>" />

    <input type="hidden" id="cityname" value="<%=countryinfo.City %>" />
    
    <div class="scontainer">
        <div class="internalpagewidth">
            <div class="srow">
                    <div >
                        <asp:HyperLink ID="hyperRegion" CssClass="backitem" runat="server"><%=countryinfo.Region %> Vacations<<</asp:HyperLink>
                        <asp:HyperLink ID="hyplnkCountryBackLink" CssClass="backitem" runat="server"><%=countryinfo.Country %> Vacations<<</asp:HyperLink>
                        <asp:HyperLink ID="hyplnkStateBackLink" CssClass="backitem" runat="server"><%=countryinfo.StateProvince %> Vacations<<</asp:HyperLink>
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
            <!--- For buttons Area  -->
            <div class="srow wraper_buttons">
                <div class="col-x-2 col-m-6 col-6 center" id="container_search">
                    <span class="btn_linker" id="btn_filter"><i class="fa fa-filter" aria-hidden="true"></i> Refine Your Search</span> 
                </div>
                <div class="col-x-2 col-m-6 col-6 center" id="container_map">
                    <span class="btn_linker" id="btn_showmap"><i class="fa fa-globe" aria-hidden="true"></i> Map</span>
                </div>
            </div>
            <!--- For Search Filter Area   Step Box  -->
            <div class="srow">
                <div class="borerstep">
                    <div class="stepfont">
                        <div class="colfield_1">
                                <label> Step 1: </label>
                        </div>
                            <div class="colfield_2">
                                <ul class="step_line">
                                <% 
        //"City" vacation Rentals (count) "City" Hotesl (count)
                                    for (int i = 0; i < 3; i++) {%>
                                <li> <input type="radio" name="proptype" value="<%=prop_typeval[i]%>" /> <%=str_propcate[i] %> (<%=prop_nums[i] %>)</li>
                            <%} %>
                   
                            </ul>
                            </div>
                        <div class="clear"></div>
                    </div>
                    <div class="stepfont">
                        <div class="colfield_1">
                            <label> Step 2: </label> 
                        </div>
                        <div class="colfield_2">
                            <ul class="step_line">
                                <li>  <input type="radio"  name="roomnums"  value="1" /> 0-2 BD (<%=bedroominfo[1] %>)</li>
                                <li> <input type="radio"   name="roomnums" value="2" /> 3-4 BD (<%=bedroominfo[2] %>)</li>
                                <li> <input type="radio"  name="roomnums" value="3" /> 5+ BD (<%=bedroominfo[3] %>)</li>
                                <li> <input type="radio"  name="roomnums" value="0" /> All (<%=bedroominfo[0] %>)</li>
                            </ul>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="stepfont">
                        <div class="colfield_1">
                                <label> Step 3: </label>
                        </div>
                        <div class="colfield_2">
                            <ul class="step_line">
                                <li> <input type="radio"  name="amenitytype" value="8" /> Hot Tub(<%=amenity_nums[0] %>)</li>
                                <li> <input type="radio"  name="amenitytype" value="33" /> Internet(<%=amenity_nums[1] %>)</li>
                                <li> <input type="radio"  name="amenitytype" value="1" /> Pets(<%=amenity_nums[2] %>)</li>
                                <li> <input type="radio"  name="amenitytype" value="11" /> Pool(<%=amenity_nums[3] %>)</li>
                                <li> <input type="radio"  name="amenitytype" value="0" /> All(<%=amenity_nums[4] %>)</li>
                                </ul>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="stepfont">
                        <div class="colfield_1">
                            <label> Step 4: </label>
                        </div>
                        <div class="colfield_s2">
                            <ul class="step_line">
                                <li> <input type="radio"  name="pricesort" value="1" /> High to Low Price</li>
                                <li> <input type="radio"  name="pricesort" value="2" /> Low to High Price</li>
                            </ul>
                        </div>
                        <div class="colfield_3">
                            <div class="btn_wrapper">
                                <input type="submit" id="refresh" class="btnsigns" value="Search" />
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <!--- For Property List   -->
            <div class="srow">
                <%   //Loop for pages
                    //int pages = (proplistset.allnums+19) / 20 ;
                    int pages = (proplistset.allnums+9) / 10 ;
                    List<Location> eLocation = new List<Location>();
                    for (int pg = 0; pg < pages; pg++)
                    { %>
                <div class="page_hid" id="cpage<%=pg %>">
                   
                    <%  //Loop for each property
                       // int maxitem = (proplistset.allnums > (pg + 1) * 20) ? (pg + 1) * 20 : proplistset.allnums;
                        int maxitem = (proplistset.allnums > (pg + 1) * 10) ? (pg + 1) * 10 : proplistset.allnums;
                        //for (int i = 0pg*20; i < proplistset.allnums; i++)
                        for (int i = pg*10; i < maxitem; i++)
                        {
                            //Response.Write(proplistset.propertyList.Count);break;
                            PropertyAmenityInfo propamen = proplistset.propertyList[i];
                            //string propname = propamen.detail.PropertyName + " " + propamen.detail.NumBedrooms + " Bedroom " + propamen.detail.NumBaths + " BA Sleeps " + propamen.detail.NumSleeps;
                            // Rates:  79-169 EUR Per Night 2 nights Minimum 
                            //string rates = "Rates: " + propamen.detail.MinNightRate + "-" + propamen.detail.HiNightRate + "  " + propamen.detail.MinRateCurrency + " Per Night. Minimum " + min_rentaltypes[propamen.detail.MinimumNightlyRentalID] + " Rental.";
                            string amenity = "Amenity:  ";
                            int am_count = propamen.amenity.Count;
                            string href = ("/" + propamen.detail.Country + "/" + propamen.detail.StateProvince + "/" + propamen.detail.City + "/" + propamen.detail.ID + "/default.aspx").ToLower().Replace(" ", "_");
                            // var alt = (propamen_typeval.indexOf(propamen.detail.Category) == -1) ? propamen.detail.City + " " + propamen.detail.NumBedrooms +" bedroom Vacation Rentals" : propamen.detail.City + " " + propamen.detail.NumBedrooms+" bedroom Boutique Hotels";
                            //var alt = (propamen_typeval.indexOf(propamen.detail.Category) == -1) ?"Rentals" : "Hotel";
                            //console.log(am_count);
                            //string alt = (!property_typeval.Contains(propamen.detail.Category)) ? propamen.detail.City + " " + propamen.detail.NumBedrooms + " bedroom Vacation Rental" : propamen.detail.City + " " + propamen.detail.NumBedrooms + " bedroom Hotel";
                            string alt = propamen.detail.Name2;
                            if (proptypeinfo.Contains(propamen.detail.CategoryID)) alt = propamen.detail.Name2;
                            else alt = propamen.detail.Name2 ;

                            int addr_verified;
                            addr_verified = propamen.detail.loc_verified;
                            double latitude, longitude;
                            latitude = propamen.detail.loc_latlang;
                            longitude = propamen.detail.loc_logitude;
                            
                            string url = String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/{3}/default.aspx",
                                propamen.detail.Country, propamen.detail.StateProvince, propamen.detail.City, propamen.detail.ID).ToLower().Replace(" ", "_");

                            if (addr_verified == 1)
                            {
                                Location loc = new Location();
                                loc.title = Server.HtmlDecode(propamen.detail.Name2);
                                loc.lat = latitude;
                                loc.lng = longitude;
                                loc.description = propamen.detail.Name2;
                                loc.URL = url;
                                eLocation.Add(loc);
                            }
                                                        
                            for (int j = 0; j < am_count; j++)
                            {
                                if(filtered_amenity.Contains(propamen.amenity[j].AmenityID)) amenity += (propamen.amenity[j].Amenity + ", ");
                            }
                            amenity = amenity.Substring(0, amenity.Length - 2);

                    %>

                    <!--For one property -->
                        <div class="wrapper_property">
                        <div class="srow">
                            <div class="col-x-4 col-m-6 col-g-4 center">
                                <div class="drop-shadow effect4">
                                  <a href="<%=href.Replace(" ", "_") %>"> <img class="property_img" title="<%=alt %>" alt="<%=alt %>" src="/images/<%= propamen.detail.FileName.ToLower() %>"/></a>
                                </div>
                            </div>
                            <div class="col-x-4 col-m-6 col-g-8">
                                <div class="srow">
                                    <div class="col-12 col-g-7">
                                        <div class="srow">
                                            <div class="prop_type">
                                                <%=propamen.detail.CategoryTypes %> in <%=propamen.detail.City %>
                                            </div>
                                            <div class="prop_name">
                                                <%=propamen.detail.Name2 %>
                                            </div>                                          
                                            <div class="prop_sleep">
                                                 <img class="sleepsicon" src="/assets/img/sleeps.png" alt="sleep"   /> <span> Sleeps <%=propamen.detail.NumSleeps %> in <%=propamen.detail.NumBedrooms %> bedrooms</span>
                                            </div>
                                            <div class="prop_detail">
                                              <%=propamen.detail.Name %>
                                            </div>
                                            <div class="prop_amenity">
                                                <%=amenity %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-g-5">
                                        <div class="srow center">
                                            <div class="prop_rates">
                                                RATES
                                            </div>
                                            <div class="prop_rates_val center">
                                                 <%=propamen.detail.MinRateCurrency %> <%=propamen.detail.MinNightRate %> –  <%=propamen.detail.HiNightRate %> <br /> 
                                                       Per Night
                                            </div>                                                        
                                            <div class="cont_button">
                                                <a class="btn_gurantee" href="https://www.vacations-abroad.com/rentalguarantee.aspx">Reservation Guarantee</a>
                                            </div>
                                            <div class="cont_button">
                                                <a class="btn_moreinfos" href="<%=href %>">More Information</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%} %>
                </div>
                <%} %>
            </div>
            <input type="hidden" name="pages" value="<%=pages %>"/>
            <!--- Adding Pagination -->
            <div class="srow">
                <input type="hidden" name="allpages" value="<%=proplistset.allnums %>" />
                <div class="pagination" id="paging">
        
                </div>
            </div>


            <!--- Things to visit   h2-->
            <div class="srow">
                 <div class="com_box">
                    <h2 class="orangetxt">
                        <%=countryinfo.City %> Vacations: Things to see while on vacation in <%=countryinfo.City %> <%=countryinfo.StateProvince %>
                    </h2><br />
                     <div class="srow">
                         <div class="txtalign">
                            <asp:Label runat="server" ID="lblcity"  ></asp:Label>
                        </div>
                    </div>
                    <div class="srow">
                        <% if (AuthenticationManager.IfAuthenticated && AuthenticationManager.IfAdmin)
                           { %>
                        <asp:TextBox ID="txtCityText" runat="server" Rows="7" TextMode="MultiLine" Width="600px"></asp:TextBox><br />
                        <asp:Button ID="btnSubmit" runat="server" Text="Save Text" OnClick="btnSubmit_Click" />
                        <br />
                        <asp:Label ID="lblInfo" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
                        <% }%>
                         
                    </div>
                    <div class="srow">
                     <label>
                         <%=Server.HtmlDecode(countryinfo.CityText2)%>
                     </label>
                    </div>
                    <div class="srow center">
                        <% if (AuthenticationManager.IfAuthenticated && AuthenticationManager.IfAdmin)
                            { %>
                                <asp:TextBox ID="txtCityText2" runat="server" Rows="7" TextMode="MultiLine" Width="600px"></asp:TextBox>
                                <br />
                                <asp:Button ID="btnSubmit2" runat="server" Text="Save Text" OnClick="btnSubmit2_Click" />
                                <br />
                        <% } %>
                    </div>
                 </div> 
            </div>
            <!---- Old page item  -->
  
            <!-- Hidden Values -->
                <input type="hidden"  id="cityid" value="<%=cityid %>"  />
                <input type="hidden"  id="CityParam" name="CityParam"  runat="server" /> 
            <!--Footer text -->
            <div class="footer_text">
               <%=String.Format("{0} vacation rentals and {0} boutique hotels let you indulge in {0} vacations", countryinfo.City) %> 

            </div>
            <!-- Bottom City list -->
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



            <div class="smallgap">

            </div>
  
         </div>
     </div>
    <div id="wrap_map" class="modalform center">
        <div class="mapbox center">
            <div  id="map_canvas">
            </div>
        </div>
    </div>
  <script>
      <% string ans =BookDBProvider.getJsonString<Location>(eLocation) ; %>
      var gmarkers = <%=ans%>;
  </script>
   
    <script defer="defer" type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&sensor=false"> </script>
    <script defer="defer" src="/assets/js/citylist.js?28"></script>

<!-- Start of StatCounter Code for Default Guide -->
<script type="text/javascript">
var sc_project=3345790; 
var sc_invisible=1; 
var sc_security="b7bf8208"; 
var scJsHost = (("https:" == document.location.protocol) ?
"https://secure." : "http://www.");
document.write("<sc"+"ript type='text/javascript' defer='defer' src='" +
scJsHost+
"statcounter.com/counter/counter.js'></"+"script>");
</script>
<noscript><div class="statcounter"><a title="website
statistics" href="http://statcounter.com/"
target="_blank"><img class="statcounter"
src="//c.statcounter.com/3345790/0/b7bf8208/1/" alt="website
statistics"></a></div></noscript>
<!-- End of StatCounter Code for Default Guide -->
</form>
</asp:Content>
