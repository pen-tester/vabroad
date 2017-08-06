<%@ Page Language="C#" MasterPageFile="~/masterpage/mastermobile.master" AutoEventWireup="true" CodeFile="~/EditProperty.aspx.cs" Inherits="EditProperty" Title="Edit Property" ValidateRequest="false" EnableEventValidation="false" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Edit Property
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
<style>
     /* Progress Tracker v2 */
    ul.progress[data-steps="2"] li { width: 49%; }
    ul.progress[data-steps="3"] li { width: 33%; }
    ul.progress[data-steps="4"] li { width: 24%; }
    ul.progress[data-steps="5"] li { width: 19%; }
    ul.progress[data-steps="6"] li { width: 16%; }
    ul.progress[data-steps="7"] li { width: 14%; }
    ul.progress[data-steps="8"] li { width: 12%; }
    ul.progress[data-steps="9"] li { width: 11%; }

    .progress {
        width: 100%;
        list-style: none;
        list-style-image: none;
        padding:5px 0;
        margin:0;
        overflow:hidden;
    }
    .progress li{
        float:left;
        text-align:center;
        position:relative;
    }
    .progress span.name{padding:25px 10px 0 10px;display:block;  height:40px;}
    .progress div.step{
        width:40px;
        padding:0;
        display:inline-block;
    }
    .progress li.done div.step, .progress li.active div.step{
        cursor:pointer;
    }
    .progress div.step >div{
        width:40px;
        height:40px;
        line-height:40px;
        border-radius:50%;
        background-color:#ccc;
        position:relative;
        z-index:10;
    }
    .progress div.step:before{
        content:"";
        position:absolute;
        left:0;
        width:50%;
        height:4px;
        bottom:20px;
        background-color:#ccc;
    }
    .progress div.step:after{
        content:"";
        position:absolute;
        right:0;
        width:50%;
        height:4px;
        bottom:20px;
        background-color:#ccc;
    }
    .progress li:last-of-type div.step:after ,.progress li:first-child div.step:before{
        display:none;
    }
    .progress .done div.step >div{
        background-color:#ff6600;
    }
    .progress .done div.step:before,.progress .done div.step:after {
        background-color:#ff6600;
    }
    .progress .active div.step:before {
        background-color:#ff6600;
    }
    .progress .active div.step >div{
        background-color:#ff6600;
    }
    .progress li.done .name,.progress li.done div.step div span{
        opacity:0.3;
    }
    .stepwzardbox{
        margin:20px 0;
        border:2px solid #ff6600;
        padding:15px;
        overflow-x:hidden;
        overflow:visible;
    }
    .stepwzardbox>div:not(.buttongroup) {
        position:relative;
        display:none;
    }
    .buttongroup{
        padding:10px 0 0 0; text-align:right;
    }
    .btnprev, .btnnext{
        color:#fff; background-color:#154890; border:1px solid #426ebd; padding:5px 0; width:100px; border-radius:5px; cursor:pointer;
    } .btnnormal{color:#fff; background-color:#154890; border:1px solid #426ebd; padding:5px; border-radius:5px; cursor:pointer; margin:5px;} .btnnormal:active{ background-color:#426ebd;}
    .btnprev:not(.firststep):active, .btnnext:active{
        background-color:#426ebd;
    }
    input.firststep[type=button]{
        background-color:#ccc; border-color:#ccc;
        color:#000; cursor:not-allowed;
    }
    .stepwzardbox >div .header_text{ font-size:14pt; font-weight:bold; color:#ff6600;display:block;}
    /*End for step wizard*/
    /*For wizard step box content*/
    .input_text {
        padding: 5px;
        border: 2px solid #F1B720;
        border-radius: 5px;
        color: #333;
        transition: all 0.3s ease-out;
    }
    .input_text:hover {
        border-radius: 8px
    }
    .input_text:focus {
        outline: none;
        border-radius: 8px;
        border-color: #EBD292;
    }
    .selectbox{width:90%; border:2px solid #F1B720; padding:5px; border-radius:6px; }
    .large_width{width:90%;} .medium_width{width:45%;} .small_width{width:30%;}
    .group_form{padding:10px 0;}
    input.error_required, div.error_required{border-color:red;}
    .error_msg{color:red;}
    /*End wizard step box content*/
    /*For message box*/
   .modalLoading{
        margin-top:270px;
    }
    .dlgMsg{
        background-color:#fafbfc;
        border:5px solid #f0b892;
        border-radius:55px;
        color:#767271;
        width:300px;
        position:relative;
        margin:auto;
        margin-top:300px;
        padding:40px;
    }
     .modalhead{
        position:absolute;right:15px; top:10px;
    }
    .textboxheight{
        height:80px;
    }
    .hidden{display:none;}
    /*For room info*/
    .roomrange{border:1px dashed #f0b892; }
    .roomborder{border:1px dotted #000;margin:5px; padding:10px;}
    .roomHeaer{color:#ff6600;}
    .attracationwarpper{
        background-color:#DBE7F2;
        padding:10px;
    }
     @media(max-width:600px){
        .input_text{width:90%;}
     }
</style>
 <link href="/assets/plugins/chosen/chosen.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
   <input type="hidden" value="<%=userid %>"  id="userid" />
  <div class="scontainer">
    <div class="internalpagewidth">
        <div class="stepwizard">
            <ul class="progress" data-steps="4">
                <li class="active">
                    <span class="name">Basic Information</span>
                    <div class="step" data-target="0"><div><span><i class="fa fa-info" aria-hidden="true"></i></span></div></div>
                </li>
                <li>
                    <span class="name">Description& Amenities</span>
                    <div class="step" data-target="1"><div><span><i class="fa fa-coffee" aria-hidden="true"></i></span></div></div>
                </li>
                <li>
                    <span class="name">Local Attractions</span>
                    <div class="step" data-target="2"><div><span><i class="fa fa-film" aria-hidden="true"></i></span></div></div>
                </li>
                <li>
                    <span class="name">Rates</span>
                    <div class="step" data-target="3"><div><span><i class="fa fa-usd" aria-hidden="true"></i></span></div></div>
                </li>
            </ul> 
        </div>
        <div class="srow stepwzardbox">
            <div class="" id="wzardstep0">
                <span class="header_text">Basic Information</span>
                <form id="frmstep0">
                <input type="hidden" name="wizardstep" value="0"/>
                <input type="hidden" value="<%=propertyid %>"  name="propid" />
                <div class="srow group_form">
                    <div class="col-x-4 col-2">
                        Property Name
                    </div>
                    <div class="col-x-4 col-8">
                        <input type="text" id="_propname2" name="_propname2" class="input_text medium_width required maxchars" data-max="50" placeholder="(Required, 30 Char. Max)" />
                    </div>
                </div>
                <div class="srow group_form">
                    <div class="col-x-4 col-2">
                        Write sentence describing your property
                    </div>
                    <div class="col-x-4 col-10">
                        <input type="text" id="_propname" name="_propname" class="input_text large_width required" placeholder="Desrcibe your property " />
                    </div>
                </div>
                <div class="srow group_form">
                    <div class="col-x-4 col-2">
                        Virtual Tours
                    </div>
                    <div class="col-x-4 col-10">
                        <input type="text" id="_virttour" name="_virttour" class="input_text large_width"/>
                    </div>
                </div>
                <div class="srow group_form">
                    <div class="col-x-4 col-2">
                        Property Type
                    </div>
                    <div class="col-x-4 col-10">
                        <div class="srow">
                            <div class="col-x-4 col-3">
                                <select class="selectbox chosen-select" id="propcategory" name="propcategory">
                                    <%int cate_count = prop_category.Tables[0].Rows.Count;
                                        for (int cat_ind = 0; cat_ind < cate_count; cat_ind++)
                                        {
                                            var row = prop_category.Tables[0].Rows[cat_ind]; %>
                                     <option value="<%=row[0] %>"><%=row[1] %></option>
                                    <%} %>
                                </select>
                            </div>
                            <div class="col-x-4 col-9">
                                <input type="text" class="input_text large_width required " id="additional_type" name="additional_type" placeholder="Be creative and create a unique type." />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="srow group_form">
                    <div class="col-x-4 col-2">
                        Location
                    </div>
                    <div class="col-x-4 col-10">
                        <div class="srow">
                            <div class="col-x-4 col-3">
                                <select class="selectbox chosen-select" id="regionlist" name="regionlist">
                                    <option value="1">Africa</option>
                                    <option value="2">Asia</option>
                                    <option value="6">Europe</option>
                                    <option value="7">Middle East</option>
                                    <option value="8">North America</option>
                                    <option value="3">Oceania</option>
                                    <option value="9">South America</option>
                                </select>
                            </div>
                            <div class="col-x-4 col-3">
                                <input type="hidden" name="countryname" />
                                <select class="selectbox chosen-select" name="countrylist" id="countrylist">
                                </select>
                            </div>
                            <div class="col-x-4 col-3">
                                <input type="hidden" name="statename" />
                                <select class="selectbox chosen-select" name="statelist" id="statelist">
                                </select>
                            </div>
                            <div class="col-x-4 col-3">
                                <select class="selectbox chosen-select" name="citylist" id="citylist">
                                </select>
                                <div class="group_form">
                                    <input type="text" name="additionalcity" id="additionalcity" class="input_text large_width page_hid" placeholder="Input city name" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="srow group_form">
                    <div class="col-x-4 col-2">
                        Address
                    </div>
                    <div class="col-x-4 col-10">
                        <div class="srow">
                            <input type="text"  name="_propaddr" id="_propaddr" class="input_text large_width required" placeholder="Address" />
                        </div>
                        <div class="srow">
                            <div class="srow group_form">
                                <div class="col-x-4 col-4">
                                    Display Address
                                </div>
                                <div class="col-x-1 col-1">
                                    <select class="selectbox" name="_propdisplay" id="_propdisplay" >
                                        <option value="0" selected="selected">No</option>
                                        <option value="1">Yes</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="srow group_form">
                    <div class="col-x-4 col-m-6 col-4">
                        <div class="srow group_form">
                            <div>
                               Number of Bedrooms
                            </div>
                            <div>
                                <input type="number" name="_propbedroom" id="_propbedroom" class="input_text medium_width required" value="0" min="0"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-x-4 col-m-6 col-4">
                        <div class="srow group_form">
                            <div>
                               Number of Bathrooms
                            </div>
                            <div>
                                <input type="number" name="_propbathrooms" id="_propbathrooms" class="input_text medium_width required" value="0" min="0" />
                            </div>
                        </div>
                    </div>
                    <div class="col-x-4 col-m-6 col-4">
                        <div class="srow group_form">
                            <div>
                                Sleeps Number
                            </div>
                            <div>
                                <input type="number" name="_propsleep" id="_propsleep" class="input_text medium_width required" value="0" min="0" />
                            </div>
                        </div>
                    </div>
                    <div class="col-x-4 col-m-6 col-4">
                        <div class="srow group_form">
                            <div>
                                Minimum Nightly Rental
                            </div>
                            <div>
                                <select class="selectbox medium_width"  name="_propminrental" id="_propminrental">
                                    <option value="1">2 Nights</option>
                                    <option value="2">3 Nights</option>
                                    <option value="3">1 Week</option>
                                    <option value="4">2 Weeks</option>
                                    <option value="5">Monthly</option>
                                    <option value="6" selected="selected">1 Night</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-x-4 col-m-6 col-4">
                        <div class="srow group_form">
                            <div>
                                Number of TVs
                            </div>
                            <div>
                                <input type="number" name="_proptv" id="_proptv" class="input_text medium_width required" value="0" min="0" />
                            </div>
                        </div>
                    </div>
                    <div class="col-x-4 col-m-6 col-4">
                        <div class="srow group_form">
                            <div>
                                Number of CD Players
                            </div>
                            <div>
                                <input type="number" name="_propcd" id="_propcd" class="input_text medium_width required" value="0" min="0" />
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            </div>
            <div class="" id="wzardstep1">
                <span class="header_text">Description& Amenities</span>
                <form id="frmstep1">
                    <input type="hidden" name="wizardstep"  value="1"/>
                    <input type="hidden" value="<%=propertyid %>"  name="propid" />
                    <div class="srow group_form">
                        <div class="col-x-4 col-2">
                            Description
                        </div>
                        <div class="col-x-4 col-8">
                            <textarea id="_propdescription" name="_propdescription" class="input_text large_width textboxheight" placeholder="Please enter a summary description of your property. Your description must be unique and should not contain text from your personal website as duplicate content will harm your personal website in the search engine rankings."></textarea>
                        </div>
                    </div>
                    <div class="srow group_form">
                        <div class="col-x-4 col-2">
                            Amenities
                        </div>
                        <div class="col-x-4 col-8">
                            <textarea id="_propamenitytxt" name="_propamenitytxt" class="input_text large_width textboxheight" placeholder="Please enter original text describing your property amenities. DO NOT COPY TEXT FROM YOUR WEBSITE"></textarea>
                        </div>
                    </div>
                    <div class="srow group_form">
                        <div class="col-x-4 col-2">
                            Amenities on site or nearby
                        </div>
                        <div class="col-x-4 col-8">
                            <select id="propamenity"  name="propamenity" class="selectbox chosen-select large_width" multiple="multiple">
                            <% int am_count = all_amenities.Tables[0].Rows.Count;
                                for (int am_ind = 0; am_ind < am_count; am_ind++)
                                {
                                    var row = all_amenities.Tables[0].Rows[am_ind];
                                    %>
                                <option value="<%=row["ID"]%>"><%=row["Amenity"] %></option>

                            <%} %>
                            </select>
                        </div>
                    </div>
                    <div class="srow group_form roomrange page_hid" id="roomwarper">
                        <div class="srow">
                            The table below allows you to enter the sleeping arrangements and furniture for each bedroom. 
                        </div>
                        <div class="srow" id="roomcontainer">
                            <input type="hidden" name="_countroom" id="_countroom" value="0" />
                        </div>
                        <div class="srow">
                            <div class="buttongroup">
                                <input class="btnnormal" type="button" id="addroom" value ="Add Room"/>
                            </div>
                        </div>
                    </div>
                </form>
                
            </div>
            <div class="" id="wzardstep2">
                <span class="header_text">Local Attractions</span>
                <form id="frmstep2">
                     <input type="hidden" name="wizardstep"  value="2"/>
                     <input type="hidden" value="<%=propertyid %>"  name="propid" />
                    <div class="srow group_form">
                        <div class="col-x-4 col-2">
                            Local Attractions and Activities: 
                        </div>
                        <div class="col-x-4 col-8">
                            <textarea id="_propattract" name="_propattract" class="input_text large_width textboxheight" placeholder="Please enter unique and original text to describe the local activities above..."></textarea>
                        </div>
                    </div>
                    <div class="srow group_form">
                         <div class="col-x-4 col-2">
                         </div>
                        <div class="col-x-4 col-8">
                            <div class="srow">
                                 Then select   for the appropriate local activity from the table below. Next select the distance from the rental to these activities. 
                            </div>
                            <div class="srow attracationwarpper">
                                <% int count_attract = allattractions.Tables[0].Rows.Count;
                                    for (int ind_attr = 0; ind_attr < count_attract; ind_attr++)
                                    {
                                        var row = allattractions.Tables[0].Rows[ind_attr]; %>
                                <div class="col-x-4 col-6">
                                    <div class="srow">
                                        <div class="col-x-2 col-8"><input type="checkbox" name="attractids" value="<%=row["ID"] %>"/><%=row["Attraction"] %></div>
                                        <div class="col-x-2 col-4">
                                            <select name="attract_near" class="selectbox">
			                                    <option selected="selected" value="1">Nearby</option>
			                                    <option value="2">Under 1 Mile</option>
			                                    <option value="3">1-5 Miles</option>
			                                    <option value="4">5-10 Miles</option>
			                                    <option value="5">10-20 Miles</option>
			                                    <option value="6">Over 20 Miles</option>
		                                    </select>
                                        </div>
                                    </div>
                                 </div>
                                <%} %>
                            </div>
                        </div>                       
                    </div>
                </form>                
            </div>
            <div class="" id="wzardstep3">
                <span class="header_text">Rates</span>
                 <form id="frmstep3">
                     <input type="hidden" name="wizardstep"  value="3"/>
                     <input type="hidden" value="<%=propertyid %>"  name="propid" />
                     <div class="srow">
                         These rates are to provide visitors a general idea of price range for your property and are displayed on the city pages.
                     </div>
                     <div class="srow group_form">
                         <div class="col-2">Rate Range:</div>
                         <div class="col-10">
                             <div class="srow">
                                 <div class="col-4">
                                     <div> Lowest Nightly Rate:</div>
                                     <input type="number" id="minrate" name="minrate" class="input_text large_width required" min="0" value="0"/>
                                 </div>
                                 <div class="col-4">
                                     <div> Highest Nightly Rate :</div>
                                     <input type="number"  id="hirate" name="hirate" class="input_text large_width required" min="0" value="0" />
                                 </div>
                                 <div class="col-4">
                                     <div> Currency </div>
                                     <div >
                                            <select class="selectbox" id="currency" name="currency">
	                                            <option value="EUR">EUR - Euros</option>
	                                            <option selected="selected" value="USD">USD - US Dollars</option>
	                                            <option value="AED">AED - United Arab Emirates Dirhams</option>
	                                            <option value="ARS">ARS - Argentina Pesos</option>
	                                            <option value="AUD">AUD - Australian Dollars</option>
	                                            <option value="CAD">CAD - Canadian Dollars</option>
	                                            <option value="CHF">CHF - Switzerland Franc</option>
	                                            <option value="CLP">CLP - Chilean Peso</option>
	                                            <option value="CNY">CNY - Chinese Yuan</option>
	                                            <option value="CZK">CZK - Czech Crown</option>
	                                            <option value="GBP">GBP - United Kingdom Pounds</option>
	                                            <option value="IDR">IDR - Indonesian rupiah</option>
	                                            <option value="INR">INR - Indian Rupees</option>
	                                            <option value="LKR">LKR - Sri Lanka Rupee</option>
	                                            <option value="MAD">MAD - Morocco Dirham</option>
	                                            <option value="MXN">MXN - Mexico Pesos</option>
	                                            <option value="MYR">MYR - Malaysian Ringgit</option>
	                                            <option value="NZD">NZD - New Zealand Dollars</option>
	                                            <option value="PHP">PHP - Philippines Pesos</option>
	                                            <option value="RIA">RIA - South Africa Riad</option>
	                                            <option value="SGD">SGD - Singapore Dollars</option>
	                                            <option value="THB">THB - Thailand Bhat</option>
	                                            <option value="TRY">TRY - Turkey Lira</option>
	                                            <option value="ZAR">ZAR - South African Rand</option>
		                                    </select>
                                     </div>
                                 </div>
                             </div>

                         </div>
                     </div>
                     <div class="srow group_form">
                         <div class="col-3">This field displays rates on your individual property page</div>
                         <div class="col-9"><textarea class="input_text large_width textboxheight" id="rates" name="rates"></textarea></div>
                     </div>
                     <div class="srow group_form">
                         <div class="col-3">Cancellation Policy:</div>
                         <div class="col-9"><textarea class="input_text large_width textboxheight" id="cancel" name="cancel"></textarea></div>
                     </div>
                     <div class="srow group_form">
                         <div class="col-3">Deposit Required:</div>
                         <div class="col-9"><textarea class="input_text large_width textboxheight" id="deposit" name="deposit"></textarea></div>
                     </div>
                </form>               
            </div>
            <div class="buttongroup">
                <input class="btnprev" type="button" value ="Prev"/>
                <input class="btnnext" type="button" value ="Next"/>
            </div>
        </div>
        <input type="hidden" value="<%=propertyid %>" id="propid" name="propid" />
        <div class="clear"></div>
        <div class="smallgap"></div>
    </div>
  </div>
    <!-- Message Box  Modal-->
    <div id="msgdlg" class="modalform">
            <div id="modal_loading" class="modalLoading">
                <div class="loader"> </div>
            </div>
            <div id="modal_dialog" class="dlgMsg" >
                <div class="modalhead">
                    <span id="msgclose" class="mclose">x</span>
                </div>
                <div class="srow">
                    <div class="col-4">Message:</div>
                    <div class="col-8" id="modalmsg"></div>
                </div>
            </div>
    </div>
    <script>
        var prop_info=<%=json_propinfo%>;
        var prop_amenity= <%=json_amenity%>;
        var prop_furniture= <%=json_roomfurnitures %>;
        var all_furniture= <%=json_allfurnitures %>;
        var prop_attraction=<%=json_attractions %>;
    </script>
    <script defer="defer" src="/assets/plugins/custom_chosen/chosen.js"></script>
    <script defer="defer" src="/assets/plugins/chosen/chosen.jquery.min.js"></script>
    <script defer="defer" src="/assets/js/editproperty.js?os=30"></script>
    <script defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCvUZLV46qiEwP-tQm3gA7xdLYiDuEyW3o&callback=initMap"></script>
</asp:Content>
