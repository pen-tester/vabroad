<%@ Page Language="C#" MasterPageFile="~/masterpage/mastermobile.master" AutoEventWireup="true" CodeFile="~/EditProperty_working.aspx.cs" Inherits="EditProperty" Title="Edit Property" ValidateRequest="false" EnableEventValidation="false" %>

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
    }
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
     @media(max-width:600px){
        .input_text{width:90%;}
     }
</style>
 <link href="/assets/plugins/chosen/chosen.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">

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
                                <select class="selectbox chosen-select" id="proptypename" name="proptypename">
                                </select>
                                <div class="group_form">
                                    <input type="text" class="input_text large_width page_hid" id="additional_type" name="additional_type" placeholder="Be creative and create a unique type." />
                                </div>
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
                                <select class="selectbox chosen-select" name="countrylist" id="countrylist">
                                </select>
                            </div>
                            <div class="col-x-4 col-3">
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
                                        <option value="0">No</option>
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
                                    <option value="6">1 Night</option>
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
                </form>
                
            </div>
            <div class="" id="wzardstep2">
                <span class="header_text">Local Attractions</span>
                <form id="frmstep2">
                     <input type="hidden" name="wizardstep"  value="2"/>
                     <input type="hidden" value="<%=propertyid %>"  name="propid" />
                </form>                
            </div>
            <div class="" id="wzardstep3">
                <span class="header_text">Rates</span>
                 <form id="frmstep3">
                     <input type="hidden" name="wizardstep"  value="3"/>
                     <input type="hidden" value="<%=propertyid %>"  name="propid" />
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
    <script>
        var prop_info=<%=json_propinfo%>;
    </script>
    <script defer="defer" src="/assets/plugins/custom_chosen/chosen.js"></script>
    <script defer="defer" src="/assets/plugins/chosen/chosen.jquery.min.js"></script>
   <script defer="defer" src="/assets/js/editproperty.js?2"></script>
</asp:Content>
