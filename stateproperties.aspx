<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master"
    AutoEventWireup="true" CodeFile="~/stateproperties.aspx.cs" Inherits="stateproperties"
    EnableEventValidation="false" ValidateRequest="false"  %>

<%--<%@ OutputCache Duration="600" VaryByParam="*" %>--%>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
   Vacation Properties in <%=countryinfo.StateProvince %> <%= countryinfo.Country %>
</asp:Content>
<asp:Content ID="meta" ContentPlaceHolderID="meta" runat="server">
    <meta name="description" content="<%=Server.HtmlDecode(String.Format("Explore {0} while staying in our boutique hotels and vacation rentals",countryinfo.StateProvince)) %>"/>
    <meta name="keywords" content="<%=Server.HtmlDecode(String.Format("{0} vacation rentals, {0} Hotels, {0} Cottages, {0} B&Bs, {0} villas , {1} ",countryinfo.StateProvince, city_lists)) %>"/>
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <style>
        .normalGroup{margin-top:20px;}.radiogroup{display:inline-block;}
        .footer_text{padding:25px 0 0 0;}
        /* For map*/                      
        #googlemap{width:95%; height:310px;margin:0 15px;}
        /*For the step box*/
        ul.step_line{display:block; margin:0;padding:0;}
        ul.step_line li{display:inline-block; padding:3px 0px;}
        .btn_wrapper{padding:5px 0 0 15px;display:inline-block;}
        .cont_button{padding:20px 0; width:100%;}
        .country_list_box ul li:first-child{
            color:#000;
        }
     [class*=colfield_]{float:left;}
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
    </style>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
<form id="mainform" method="post">
    <div class="scontainer">
        <input type="hidden" name="proptyperadio" value="<%=rproptype_id %>" />
        <input type="hidden" name="bedroomtyperadio" value="<%=rbedroom_id %>" />
        <input type="hidden" name="amenityradio" value="<%=ramenity_id %>" />
        <input type="hidden" name="sortradio" value="<%=rsort_id %>" />
        <input type="hidden" name="pagenums" value="<%=pagenum %>" />
            <input type="hidden" id="statename" value="<%=countryinfo.StateProvince %>" />
         <div class="srow">
               <div class="internalpagewidth">
                    <div class="srow">
                           <div>
                            <div >
                                <a class="backitem" href="<%=String.Format("/" + countryinfo.Region.ToLower().Replace(" ", "_") + "/default.aspx") %>"><%=countryinfo.Region %> Vacations<< </a>
                                <a class="backitem" href="<%=String.Format("/" + countryinfo.Country.ToLower().Replace(" ", "_") + "/default.aspx") %>"><%=countryinfo.Country %> Vacations<<</a>
                                <div class="clear">

                             </div>
                            </div>
 
                                  <h1 class="H1CityText center">
                                    <%=String.Format("Vacation Properties in {0} {1}",countryinfo.StateProvince ,countryinfo.Country) %>
                                    <br />
                                </h1>
                            </div>

            <div class="srow">
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
                                        <li> <input type="radio"  name="roomnums" value="0" /> Display All (<%=bedroominfo[0] %>)</li>
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
                                        <li> <input type="radio"  name="amenitytype" value="0" /> Display All(<%=amenity_nums[4] %>)</li>
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
                                        <li> <input type="radio"  name="pricesort" value="1" /> High to Low Rate</li>
                                        <li> <input type="radio"  name="pricesort" value="2" /> Low to High Rate</li>
                                        <li> <input type="radio"  name="pricesort" value="0" /> Display All</li>
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
            </div>

                <div class="srow" style="padding-bottom:80px;">
                    <div class="center">
                        <div class="srow">
                            <%
                                 int counts = ds_PropList.Tables[0].Rows.Count;
                                //For google map markers
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
                                      if (proptypeinfo.Contains(prop_cat)) alt = vrow["Name2"].ToString();
                                      else alt = vrow["Name2"].ToString();
                                  if (rind % 4 == 0) {
                                 %>
                                        <div class="srow normalGroup">
                            
                                    <%} %>
                                <div class="col-3">
                                    <div><a href="<%=city_url %>"><%=str_city %></a></div>
                                    <div class="imgwrapper"><a href="<%=url %>"><img src="/images/<%=vrow["FileName"] %>" class="imgstyle" alt="<%=alt %>" title="<%=alt %>"/></a></div>
                                    <div>
                                        <span class='scomments'><%=vrow["CategoryTypes"]%> Sleeps <%=vrow["NumSleeps"] %> </span> <br />
                                         <span class='scomments'>Rates <%=vrow["minNightRate"] %> - <%=vrow["HiNightRate"] %> <%=vrow["minRateCurrency"] %> </span>
                                    </div>
                                </div>
                    

                            <%} %>
                            </div>
                        </div>
                    </div>
         </div>
 


            </div>
         </div>
    </div>
    </div>
</form>

    <script type="text/javascript" defer="defer" src="/assets/js/statelistall.js?8">
    </script>

        <!-- Start of StatCounter Code for Default Guide -->
        <script type="text/javascript">
        var sc_project=3345780; 
        var sc_invisible=1; 
        var sc_security="c7e8957f"; 
        var scJsHost = (("https:" == document.location.protocol) ?
        "https://secure." : "http://www.");
        document.write("<sc"+"ript type='text/javascript' src='" +
        scJsHost+
        "statcounter.com/counter/counter.js'></"+"script>");
        </script>
        <noscript><div class="statcounter"><a title="real time web
        analytics" href="http://statcounter.com/"
        target="_blank"><img class="statcounter"
        src="//c.statcounter.com/3345780/0/c7e8957f/1/" alt="real
        time web analytics"></a></div></noscript>
        <!-- End of StatCounter Code for Default Guide -->

</asp:Content>