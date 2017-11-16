<%--<%@ Page Language="C#" MasterPageFile="~/MasterPPropertiesFullSetageNoCss.master" AutoEventWireup="true" CodeFile="~/viewproperty.aspx.cs" Inherits="ViewProperty" Title="<%# GetTitle () %>" EnableEventValidation="false" %>--%>
<%--EnableViewState="false"--%>

<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master" AutoEventWireup="true" CodeFile="~/viewproperty.aspx.cs" Inherits="ViewProperty" Title="<%# GetTitle () %>" EnableEventValidation="false" %>

<%@ Register Assembly="GoogleReCaptcha" Namespace="GoogleReCaptcha" TagPrefix="ccl" %>
<%---@ Register TagPrefix="recaptcha" Namespace="Recaptcha" Assembly="Recaptcha" ---%>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <%=city %> <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Type"] %> | Vacations Abroad
</asp:Content>
<asp:Content ID="meta" ContentPlaceHolderID="meta" runat="server">
<script type="application/ld+json">
{
  "@context": "http://schema.org/",
  "@type": "Product",
  "name": "<%# PropertiesFullSet.Tables["Properties"].Rows[0]["City"] %> <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Type"] %>",
  "image": "https://www.vacations-abroad.com/images/<% =PhotosSet.Tables["PropertyPhotos"].Rows[0]["FileName"] %>",
  "description": "<%= PropertiesFullSet.Tables["Properties"].Rows[0]["Name"] %>",
  "brand": {
    "@type": "Thing",
    "name": "Vacation Property"
  },
 <% int count = comment_set.Tables[0].Rows.Count;
    if (count > 0) {
        float total = 0;
        for (int vindex=0; vindex<count; vindex++)
        {
            var vrow = comment_set.Tables[0].Rows[vindex];
            total += Convert.ToInt32(vrow["rating"].ToString());
        }
        %>
          "aggregateRating": {
            "@type": "AggregateRating",
            "ratingValue": "<%=(total/count).ToString("0.0") %>",
            "reviewCount": "<%=count %>"
          },
  <%   
    } %>
  "offers": {
    "@type": "AggregateOffer",
    "lowPrice": "<%= (PropertiesFullSet.Tables["Properties"].Rows[0]["MinNightRate"].ToString()=="")?0:PropertiesFullSet.Tables["Properties"].Rows[0]["MinNightRate"] %>",
    "highPrice": "<%= (PropertiesFullSet.Tables["Properties"].Rows[0]["HiNightRate"].ToString()=="")?0:PropertiesFullSet.Tables["Properties"].Rows[0]["HiNightRate"] %>",
    "priceCurrency": "<%= (PropertiesFullSet.Tables["Properties"].Rows[0]["MinRateCurrency"].ToString()=="")?"USD":PropertiesFullSet.Tables["Properties"].Rows[0]["MinRateCurrency"] %>"
  }
}
</script>

    <meta name="description" content="<%=str_meta %>" /><meta name="keywords" content="<%=str_keyword %>" />
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">

 <link id="jscss" rel="stylesheet"  href="/css/jcarousel.css" />
  <style>
      .commentimgrow{margin-top:20px;} .commentrow{margin-top:10px;}.topborder{border-top:2px solid #c4d9e3; }.bottombordder{border-bottom:2px solid #c4d9e3;}
      .btnwritereview,.btnwritereview:hover{padding:5px 20px;border-radius:1em;color:#fff;font-family:arial;font-size:12px;background:#154890;font-weight:700;height:26px;right:6px;box-shadow:2px 2px 6px #154890;border:1px solid #154890;text-decoration:none;}
      .viewTitle {font-size: 16px; font-family: Verdana;    color: #1d2d33;  }
      .textfont{color:#3c3c3c;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;}.dotstyle{font-size:16px;font-weight:bold;color:#154890;}.amenitybackground{background-color:#f3ede3;} 
      .PropTable10 td{text-align:center;width:250px;color:#000;border:1px solid #cdbfac}.bulletwrap{display:inline-block;padding:4px 5px;}
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
    .hidden{display:none;}
  </style>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
<form id="mainform" runat="server">
        <div class="scontainer">
    <div class="srow">
     <div class="internalpagewidth">
          <script type="text/javascript" defer="defer" src="/js/responsiveCarousel.min.js"></script>



    <script type="text/javascript" defer="defer" src="/js/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" defer="defer" src="/js/jcarousel.basic.js"></script>
    <script defer="defer" src='https://www.google.com/recaptcha/api.js'></script>
    
    <asp:Label ID="Title" runat="server" Visible="false" Text="%city% %bedroom% Bedroom %type% # %propid% | Vacations Abroad"></asp:Label>
    <asp:Label ID="Keywords" runat="server" Visible="false" Text="%city% %bedroom% Bedroom %type%, %city% %stateprovince% %type% rental, %city% %country% %type% "></asp:Label>
    <asp:Label ID="Description" runat="server" Visible="false" Text="Kickback and relax in this %city% %type% in %stateprovince% %country% from Vacations-Abroad"></asp:Label>
    <asp:Label ID="Alt" runat="server" Visible="false" Text="%city% %bedroom% Bedroom %type%"></asp:Label>
    <%--content and city cells--%>
    <%--<div class="rtOuter">
        <div class="rtHeader" id="rtHead" runat="server">
           </div>
        <div id="divCitiesRt" runat="server" class="rtText2">
        </div>
    </div>--%>
<!-- The Modal -->
 

    <div id="inqureform" class="modalform">

      <!-- Modal content -->
      <div id="modal_contents" class="modal_contents">
          <div class="dlghead">
                <span id="closeform" class="mclose">x</span>
          </div>
        
            <div class="center">
                <table>
                    <tr>
                        <td align="center" >
                            <% if (EmailPresent())
                               { %>
                            <div class="inquriyform">
                          <table >
                                <tr align="center">
                                    <td style="width: 100px" align="left">
                                        <asp:Label ID="Label1" runat="server">Your name:</asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="Label21" runat="server" ForeColor="Red">*</asp:Label>
                                    </td>
                                    <td style="width: 175px;" align="right">
                                        <asp:TextBox ID="ContactName" runat="server" Width="170px" MaxLength="300" />
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="left">
                                        <asp:Label ID="Label2" runat="server">And email:</asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="Label12" runat="server" ForeColor="Red">*</asp:Label>
                                    </td>
                                    <td align="right" style="width: 175px; margin-left: -5px">
                                        <asp:TextBox ID="ContactEmail" runat="server" Width="170px" MaxLength="175" />
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="left">
                                        <asp:Label ID="Label3" runat="server">Telephone:</asp:Label>
                                    </td>
                                    <td></td>
                                    <td colspan="2" align="right" style="width: 175px">
                                        <asp:TextBox ID="ContactTelephone" runat="server" Width="170px" MaxLength="300" />
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="left">
                                        <asp:Label ID="Label4" runat="server">Arrival:</asp:Label>
                                    </td>
                                    <td></td>
                                    <td align="right" style="width: 172px">
                                        <asp:DropDownList ID="ArrivalDay" runat="server" Width="47px" Height="24px">
                                            <asp:ListItem Value="1">1</asp:ListItem>
                                            <asp:ListItem Value="2">2</asp:ListItem>
                                            <asp:ListItem Value="3">3</asp:ListItem>
                                            <asp:ListItem Value="4">4</asp:ListItem>
                                            <asp:ListItem Value="5">5</asp:ListItem>
                                            <asp:ListItem Value="6">6</asp:ListItem>
                                            <asp:ListItem Value="7">7</asp:ListItem>
                                            <asp:ListItem Value="8">8</asp:ListItem>
                                            <asp:ListItem Value="9">9</asp:ListItem>
                                            <asp:ListItem Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="11">11</asp:ListItem>
                                            <asp:ListItem Value="12">12</asp:ListItem>
                                            <asp:ListItem Value="13">13</asp:ListItem>
                                            <asp:ListItem Value="14">14</asp:ListItem>
                                            <asp:ListItem Value="15">15</asp:ListItem>
                                            <asp:ListItem Value="16">16</asp:ListItem>
                                            <asp:ListItem Value="17">17</asp:ListItem>
                                            <asp:ListItem Value="18">18</asp:ListItem>
                                            <asp:ListItem Value="19">19</asp:ListItem>
                                            <asp:ListItem Value="20">20</asp:ListItem>
                                            <asp:ListItem Value="21">21</asp:ListItem>
                                            <asp:ListItem Value="22">22</asp:ListItem>
                                            <asp:ListItem Value="23">23</asp:ListItem>
                                            <asp:ListItem Value="24">24</asp:ListItem>
                                            <asp:ListItem Value="25">25</asp:ListItem>
                                            <asp:ListItem Value="26">26</asp:ListItem>
                                            <asp:ListItem Value="27">27</asp:ListItem>
                                            <asp:ListItem Value="28">28</asp:ListItem>
                                            <asp:ListItem Value="29">29</asp:ListItem>
                                            <asp:ListItem Value="30">30</asp:ListItem>
                                            <asp:ListItem Value="31">31</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ArrivalMonth" runat="server" Width="53px" Height="24px">
                                            <asp:ListItem Value="January">Jan</asp:ListItem>
                                            <asp:ListItem Value="February">Feb</asp:ListItem>
                                            <asp:ListItem Value="March">Mar</asp:ListItem>
                                            <asp:ListItem Value="April">Apr</asp:ListItem>
                                            <asp:ListItem Value="May">May</asp:ListItem>
                                            <asp:ListItem Value="June">Jun</asp:ListItem>
                                            <asp:ListItem Value="July">Jul</asp:ListItem>
                                            <asp:ListItem Value="August">Aug</asp:ListItem>
                                            <asp:ListItem Value="September">Sep</asp:ListItem>
                                            <asp:ListItem Value="October">Oct</asp:ListItem>
                                            <asp:ListItem Value="November">Nov</asp:ListItem>
                                            <asp:ListItem Value="December">Dec</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ArrivalYear" runat="server" Width="62px" Height="24px">
                                            <asp:ListItem Value="2017">2017</asp:ListItem>
                                            <asp:ListItem Value="2018">2018</asp:ListItem>
                                            

                                        </asp:DropDownList>
                                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator7" runat="server" ValidationExpression="^[0-9]{1,2}$"
                                            ErrorMessage="Invalid day entered" ControlToValidate="ArrivalDay" Display="Dynamic" />
                                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator8" runat="server" ValidationExpression="^[a-zA-Z]{1,20}$"
                                            ErrorMessage="Invalid month entered" ControlToValidate="ArrivalMonth" Display="Dynamic" />
                                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator9" runat="server" ValidationExpression="^[0-9]{4}$"
                                            ErrorMessage="Invalid year entered" ControlToValidate="ArrivalYear" Display="Dynamic" />
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="left">
                                        <asp:Label ID="Label6" runat="server"># nights:</asp:Label>
                                    </td>
                                    <td></td>
                                    <td align="right" style="width: 175px">
                                        <asp:TextBox ID="HowManyNights" runat="server" Width="170px" MaxLength="200" />
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="left">
                                        <asp:Label ID="Label7" runat="server"># Adults:</asp:Label>
                                    </td>
                                    <td></td>
                                    <td colspan="2" style="width:178px;">
                                        <div class="srow">
                                            <div class="col-x-1">
                                                <asp:TextBox ID="HowManyAdults" runat="server" Width="46px" MaxLength="300" />
                                            </div>
                                            <div class="col-x-2">
                                                               &nbsp;#Children:&nbsp;
                                            </div>
                                           <div class="col-x-1">
                         
                                            <asp:TextBox ID="HowManyChildren"  runat="server" Width="40px" MaxLength="300" />
                                           </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td style="vertical-align: top;" align="left">
                                        <asp:Label ID="Label11" runat="server">Additional comments:</asp:Label>
                                    </td>
                                    <td></td>
                                    <td align="right" style="width: 175px">
                                        <asp:TextBox ID="Comments" runat="server" MaxLength="4000" Width="170px" TextMode="MultiLine"
                                            Rows="2" />
                                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator6" runat="server" ValidationExpression="^[\s\S]{1,4000}$"
                                            ErrorMessage="Invalid comments entered" ControlToValidate="Comments" Display="Dynamic" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                       <div class="g-recaptcha" data-callback="recaptchaCallback" data-sitekey="6LeiuBcUAAAAABl8pqeeYVr_M7DwF_b-CPzKo1eJ"></div>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td style="height: 30px;" colspan="3" align="center">
                                        <input type="button" id="btnsend" class="btnBookNow" style="width:90%;" value="Request a Quote" />
                                        <input type="submit" id="SubmitButton" name="SubmitButton" runat="server" class="hidden" onserverclick="SubmitButton_Click"  />
                                        <asp:Label ID="lblMsg" Style="color: Red; font-weight: bold;" runat="server"></asp:Label>
                                    </td>
                                </tr>
								<tr align="center">
                                    <td style="height: 30px;" colspan="3" align="center">
                                        <button class="btnBookNow" style="background-color:#154890;height:30px;width:90%;">Add To Favorites</button>
                                    </td>
                                </tr>
                            </table>
                            </div>
  
                            <% }
                               else
                               { %>
                            <div class="Center">
                                This owner didn't enter an e-mail into the system so there is no way to send an
                                    e-mail to him.
                            </div>
                            <% } %>
                            <%--actual form--%>
                            <%--right side--%>
                        </td>
                    </tr>
                </table>
                </div>
      </div>

    </div>

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
     <asp:Label ID="lblTest" runat="server" Style="display: none"></asp:Label>
    <div class="srow">
                    <div class="listingPagesH1Container">   
                         <asp:HyperLink ID="hyplnkRegionBackLink" runat="server">
                            
                                <asp:Literal ID="ltrRegionBackText" runat="server"></asp:Literal>
                        </asp:HyperLink>
                        <asp:HyperLink ID="hyplnkCountryBackLink" runat="server">
                           
                                <asp:Literal ID="ltrCountryBackText" runat="server"></asp:Literal>
                        </asp:HyperLink>
                        <asp:HyperLink ID="hyplnkStateBackLink" runat="server">
                            
                                <asp:Literal ID="ltrStateBackText" runat="server"></asp:Literal>
                        </asp:HyperLink>
                        <asp:HyperLink ID="hyplnkCityBackLink" runat="server">
                            
                                <asp:Literal ID="ltrCityBackText" runat="server"></asp:Literal>
                        </asp:HyperLink>

                    </div>
    </div>
     <div class="srow">
                    <div class="center">
                        <h1><span class="H1CityText">
                            <%# PropertiesFullSet.Tables["Properties"].Rows[0]["City"] %> <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Type"] %> </span></h1>
                        <br />

                       
                    </div>
     </div>
     <div class="srow">
         <div class="center">
                    <div class="wrapper">
                        <div class="jcarousel-wrapper">
                            <div class="jcarousel" id="">
                                <ul>
                                    <%if (PhotosSet.Tables["PropertyPhotos"].Rows.Count > 0)
                                    {
                                        int images_count = PhotosSet.Tables["PropertyPhotos"].Rows.Count;
                                        for (int ind_image = 0; ind_image < images_count; ind_image++)
                                        {
                                            string alt = String.Format("{0} {1} {2}", PropertiesFullSet.Tables["Properties"].Rows[0]["Name2"].ToString(), PropertiesFullSet.Tables["Properties"].Rows[0]["City"].ToString(), PropertiesFullSet.Tables["Properties"].Rows[0]["Type"].ToString());
                                            if (ind_image % 3 == 1) alt = String.Format("{0} {1} {2}", PropertiesFullSet.Tables["Properties"].Rows[0]["Name2"].ToString(), PropertiesFullSet.Tables["Properties"].Rows[0]["StateProvince"].ToString(), PropertiesFullSet.Tables["Properties"].Rows[0]["Type"].ToString());
                                            else if (ind_image % 3 == 2) alt = String.Format("{0} {1} {2}", PropertiesFullSet.Tables["Properties"].Rows[0]["Name2"].ToString(), PropertiesFullSet.Tables["Properties"].Rows[0]["Country"].ToString(), PropertiesFullSet.Tables["Properties"].Rows[0]["Type"].ToString());
                                            var image_row = PhotosSet.Tables["PropertyPhotos"].Rows[ind_image];

                                             %>
                                    <li>
                                        <div class='drop-shadow effect4'>
                                        <img  alt="<%=alt %>" title="<%=alt %>"
                                            src="<%= ConfigurationManager.AppSettings["ImagesVirtualLocation"] + image_row["FileName"].ToString() + "?" + AjaxProvider.Base64Encode(DateTime.Now.ToString()) %>"
                                            width='<%=image_row["Width"].ToString() %>'
                                            height='<%=image_row["Height"].ToString()  %>' />
                                        </div>
                                    </li>


                                    <%}
                                    }%>
                                </ul>
                            </div>
                            
                            <a href="#" class="jcarousel-control-prev" style="color: white">&lsaquo;</a>
                            <a href="#" class="jcarousel-control-next" style="color: white">&rsaquo;</a>
                        </div>

                    </div>
         </div>
     </div>
    <div class="srow">

        <div class="TitleFont">
            <div class="srow center">
                <h2 class="viewTitle">
                    <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Name2"] %>
                </h2>
                <h2 class="ViewPropertyPageFonts">
                    <%# PropertiesFullSet.Tables["Properties"].Rows[0]["NumBedrooms"] %> Bedroom <%# PropertiesFullSet.Tables["Properties"].Rows[0]["City"] %> <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Type"] %> Sleeps <%# PropertiesFullSet.Tables["Properties"].Rows[0]["NumSleeps"] %>
                    <br />
                    Rates: <%# PropertiesFullSet.Tables["Properties"].Rows[0]["HiNightRate"] %>-<%# PropertiesFullSet.Tables["Properties"].Rows[0]["MinNightRate"] %> <%# PropertiesFullSet.Tables["Properties"].Rows[0]["MinRateCurrency"] %> per night. Minimum Rental - <%# PropertiesFullSet.Tables["Properties"].Rows[0]["MinimumNightlyRental"] %>. <br />
                    <%# ((int)PropertiesFullSet.Tables["Properties"].Rows[0]["IfPaid"] == 1) && (bool)PropertiesFullSet.Tables["Properties"].Rows[0]["IfShowAddress"] ? "Address: " + PropertiesFullSet.Tables["Properties"].Rows[0]["Address"] : "" %>
                </h2>

            </div>

        </div>
         <div class="clear"></div>
        <div class="srow">
          <div id="tabs" >
            <ul class="tabs">
                <li data-tab="tabs-1" class="current">Amenities</li>
                <li data-tab="tabs-5">Attractions</li>
                <li data-tab="tabs-2">Rates</li>
                <% if (calendar_view)
                    { %> 
                <li data-tab="tabs-6">Calendar</li>
                <%} %>
                <li data-tab="tabs-4">Reviews</li>
                <li data-tab="tabs-3">Inquire</li>

            </ul>
            <div id="tabs-1"  class="tab-content current textfont">

                <%= PropertiesFullSet.Tables["Properties"].Rows[0]["Description"] %><br /><br />
                    <div class="textfont amenitybackground">
                       <div class="bulletwrap">
                        <span class="dotstyle">&#9679;</span> <%# PropertiesFullSet.Tables["Properties"].Rows[0]["NumTVs"] %>
                        TVs </div>
                          <% int rows = AmenitiesSet.Tables[0].Rows.Count;
                            for (int rind = 0; rind < rows; rind++)
                            {
                                string ame_pro = AmenitiesSet.Tables[0].Rows[rind][1].ToString();
                                if (ame_pro != "DVD" && ame_pro != "Toaster" && ame_pro != "Alarm Clock" && ame_pro !="Coffee Pot")
                                {
                               %>
                             <div class="bulletwrap"> <span class="dotstyle">&#9679;</span> <%=ame_pro %></div>
                            <%}
                              }%>

      
                    </div>
                <div class ="center" style="margin-top:30px;">
                        <table class="PropTable10">
                            <tr>
                                <asp:Repeater ID="Repeater5" runat="server" DataMember="RoomInfo" DataSource="<%# RoomsFurnitureSet %>">
                                    <HeaderTemplate>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <td style="font-size: 14px; background-color: #ff6414; color: #f5ede3;">
                                            <%# DataBinder.Eval(Container.DataItem, "RoomTitle", "{0}") %>
                                        </td>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </tr>
                            <tr>
                                <asp:Repeater ID="Repeater6" runat="server" DataMember="RoomInfo" DataSource="<%# RoomsFurnitureSet %>">
                                    <HeaderTemplate>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <td class="PropTable10B ViewPropertyPageFonts">
                                            <asp:Repeater ID="Repeater7" runat="server" DataMember="FurnitureItems" DataSource='<%# ((System.Data.DataRowView)Container.DataItem).CreateChildView("RoomsFurniture") %>'>
                                                <HeaderTemplate>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "FurnitureItem", "{0}") %><%# !CommonFunctions.IfLastRow ((System.Data.DataRowView)Container.DataItem) ? "," : "." %>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </td>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </tr>
                        </table>
           </div>
                <br />
                <%= PropertiesFullSet.Tables["Properties"].Rows[0]["Amenities"] %>
  
            </div>

            <div id="tabs-2"  class="tab-content">
                <div align="center" class="contentfont" style="color: #343d6c;">
                    <table class="PropTable12">
                        <tr>
                            <td class="Center">
                                <a name="Rates"></a>

                            </td>
                        </tr>
                    </table>
                    <%-- <div class="PropertiesFont3">
                            
                        </div>--%>
                    
                        <div class="contentfont">
                            <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Rates"].ToString().Replace(Environment.NewLine, "<br />") %><br />
                        </div>
                        <% if (RatesSet.Tables["Rates"].Rows.Count > 0)
                           { %>
                        <asp:Repeater ID="Repeater8" runat="server" DataMember="Rates" DataSource="<%# RatesSet %>">
                            <HeaderTemplate>
                                <table class="PropTable14">
                                    <tr>
                                        <td class="Center">Start Mo/Da/Yr
                                        </td>
                                        <td class="Center">End Mo/Da/Yr
                                        </td>
                                        <td class="Center">Nightly
                                        </td>
                                        <td class="Center">Weekly
                                        </td>
                                        <td class="Center">Monthly
                                        </td>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="Center">
                                        <%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}") %>
                                    </td>
                                    <td class="Center">
                                        <%# DataBinder.Eval(Container.DataItem, "EndDate", "{0:d}") %>
                                    </td>
                                    <td class="Center">
                                        <%# DataBinder.Eval(Container.DataItem, "Nightly", "{0:0}") %>
                                    </td>
                                    <td class="Center">
                                        <%# DataBinder.Eval(Container.DataItem, "Weekly", "{0:0}") %>
                                    </td>
                                    <td class="Center">
                                        <%# DataBinder.Eval(Container.DataItem, "Monthly", "{0:0}") %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <% } %>
                    
                    <div class="contentfont">
                        Pricing for  <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Type"] %> in <%# PropertiesFullSet.Tables["Properties"].Rows[0]["City"] %> <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Country"] %> are quoted in
                            <%# PropertiesFullSet.Tables["Properties"].Rows[0]["PricesCurrency"] %><br />
                        <br />
                        <br />
                        <br />
                        <br />

                    </div>
                    <div class="text-left" style="font-size: 11pt; font-family: Arial; color: #000;">
                        Check in time <%# PropertiesFullSet.Tables["Properties"].Rows[0]["CheckIn"] %><br />
                        Check out time   <%# PropertiesFullSet.Tables["Properties"].Rows[0]["CheckOut"] %><br />
                        Payment methods accepted:
                            <% if (PaymentMethodsPresent())
                               { %>
                        <asp:Repeater ID="Repeater4" runat="server" DataMember="PaymentMethods" DataSource="<%# PaymentMethodsSet %>">
                            <HeaderTemplate>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "PaymentMethod", "{0}") %><%# !CommonFunctions.IfLastRow ((System.Data.DataRowView)Container.DataItem) ? "," : "." %>
                            </ItemTemplate>
                            <FooterTemplate>
                            </FooterTemplate>
                        </asp:Repeater>
                        <% }
                               else
                               { %>
                            Check with Property Owner
                            <% } %>
                        <br />
                        <% if (LodgingTaxPresent())
                           { %>
                            Property Lodging Tax :
                            <%# PropertiesFullSet.Tables["Properties"].Rows[0]["LodgingTax"] %><br />
                        <%# (PropertiesFullSet.Tables["Properties"].Rows[0]["TaxIncluded"] is bool) && (bool)PropertiesFullSet.Tables["Properties"].Rows[0]["TaxIncluded"] ? "Tax included in rates above" : "Tax not included in rates above" %><br />
                        <% } %>
                        <b>Cancellation Policy:</b>
                        <%# PropertiesFullSet.Tables["Properties"].Rows[0]["CancellationPolicy"] %><br />
                        <b>Deposit Required for <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Type"] %>
                          
                            :</b>
                        <%# PropertiesFullSet.Tables["Properties"].Rows[0]["DepositRequired"] %><br />
                    </div>
                </div>

            </div>
            <% if (calendar_view)
                { %>
            <div id="tabs-6"  class="tab-content">
                      <div class="center">
                         <h3> Property Availability Calendar</h3>
                          <div class="srow marginTop">
                              <div class="col-x-4 col-m-6 col-3">

                                 <asp:Calendar ID="Calendar1" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                              
                                  </div>
                              <div class="col-x-4 col-m-6 col-3">
                                 <asp:Calendar ID="Calendar2" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px" ShowNextPrevMonth="False"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                               </div>
                              <div class="col-x-4 col-m-6 col-3">
                            <asp:Calendar ID="Calendar3" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px" ShowNextPrevMonth="False"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                              </div>
                                <div class="col-x-4 col-m-6 col-3">
                            <asp:Calendar ID="Calendar4" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px" ShowNextPrevMonth="False"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                                 </div>
                              <div class="col-x-4 col-m-6 col-3">
                            <asp:Calendar ID="Calendar5" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                                  </div>
                                <div class="col-x-4 col-m-6 col-3">
                            <asp:Calendar ID="Calendar6" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px" ShowNextPrevMonth="False"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                                    </div>
                            <div class="col-x-4 col-m-6 col-3">
                            <asp:Calendar ID="Calendar7" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px" ShowNextPrevMonth="False"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                                </div>
                            <div class="col-x-4 col-m-6 col-3">
                            <asp:Calendar ID="Calendar8" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px" ShowNextPrevMonth="False"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                                </div>
                                 <div class="col-x-4 col-m-6 col-3">
                            <asp:Calendar ID="Calendar9" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                                     </div>
                                 <div class="col-x-4 col-m-6 col-3">
                            <asp:Calendar ID="Calendar10" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px" ShowNextPrevMonth="False"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                                       </div>
                                 <div class="col-x-4 col-m-6 col-3">
                            <asp:Calendar ID="Calendar11" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px" ShowNextPrevMonth="False"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                                   </div>
                                <div class="col-x-4 col-m-6 col-3">
                            <asp:Calendar ID="Calendar12" runat="server" OnDayRender="Calendar1_DayRender"
                                SelectionMode="Day" BorderColor="#000000" Width="175px"
                                Font-Names="Arial" Font-Size="14px">
                                <NextPrevStyle ForeColor="Black" />
                                <TitleStyle BackColor="#ffffff" ForeColor="Black" />
                            </asp:Calendar>
                                </div>

                          </div>

                </div>
            </div>
            <% } %>
            <div id="tabs-3"  class="tab-content">
                
            </div>
            <div id="tabs-4"  class="tab-content">
                <%--reviews--%>
                <div id="divReviews" runat="server" class="contentfont">
                    <div class="srow">
                        <div class="srow">
                        <div class="col-12">
                            <div class="srow">
                                <% if (userinfo.Registered != "") {%>      
                                Member of <%=userinfo.Registered %> Chamber of commerce
                                <%} %>
                            </div>
                        </div>
                        </div>
                        <div class="col-12">
                            <div class="centered">
                            <% string st="";
                                if (AuthenticationManager.IfAdmin && Request.QueryString["simple"]=="true") st = "?propid=" + propertyid; %>
                             <a href='writereview.aspx<%=st %>' class="btnwritereview">Write a Review</a>
                            </div>
                        </div>
                    </div>
                    <div class="srow commentimgrow">
                        <% int count = comment_set.Tables[0].Rows.Count;
                            for (int i = 0; i < count; i++)
                            {

                                %>

                              <div class =" srow commentimgrow">
                                  <%  int vrates = Convert.ToInt32(comment_set.Tables[0].Rows[i]["rating"].ToString());
                                      for (int star_ind = 0; star_ind < vrates; star_ind++)
                                      { %>
                                       <img src="/images/star2.gif" />
                                  <%} %>
                              </div>
                              <div class="srow commentrow">
                                  <div class="col-4 col-x-2"><%=String.Format("{0} {1}",comment_set.Tables[0].Rows[i]["FirstName"],comment_set.Tables[0].Rows[i]["LastName"]) %></div>
                                  <div class="col-4 col-x-2">
                                      Date of Trip:<%=Convert.ToDateTime(comment_set.Tables[0].Rows[i]["ArrivalDate"]).ToString("yyyy-MM-dd") %>
                                  </div>
                              </div>
                              <div class="srow commentrow">
                                  <%=comment_set.Tables[0].Rows[i]["comments"] %>
                              </div>
                              <div class="srow commentrow">
                                  <% int cimg = commentimgset_list[i].Tables[0].Rows.Count;
                                      int unclosed = 0;
                                      for (int ind_img = 0; ind_img < cimg; ind_img++)
                                      {
                                          string alt_txt = String.Format("Review of {0} in {1} {2}",PropertiesFullSet.Tables["Properties"].Rows[0]["Name2"],city,stateprovince ); %>
                                      <% if (ind_img % 3 == 0 && ind_img>0)
                                    { unclosed = 0; %>  </div>
                                <%} %>
                                  <% if (ind_img % 3 == 0)
                                      {
                                          unclosed = 1; %>  <div class="srow">
                                <%} %>
                                     <div class="col-4">
                                         <div class="srow">
                                             <img alt="<%=alt_txt %>" title="<%=alt_txt %>"  style="width:90%;margin-left:5%;" src="/img/comments/<%=commentimgset_list[i].Tables[0].Rows[ind_img]["ImgName"] %>" />
                                         </div>
                                         <div class="srow" style="width:90%;padding-left:5%;padding-right:5%;text-align:justify;">
                                               <%=commentimgset_list[i].Tables[0].Rows[ind_img]["Comments"]  %>
                                         </div>
                                     </div>
                                     
                                  <%} if (unclosed == 1)
                                      { %>
                                              </div>
                                     <%} %>
                                  
                              </div>
                        <%} %>
                    </div>
                </div>
                <%--reviews--%>
            </div>
            <div id="tabs-5"  class="tab-content text-center">
                <div class="center" style="color: #1D2D33;">
                    <table class="NonTable contentfont">
                        <tr>
                            <td align="center" style="color: #000072;">
                                <a name="Attractions"></a>
                                <label class="colorOnHover"><%# PropertiesFullSet.Tables["Properties"].Rows[0]["City"] %> <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Country"] %> Local Attractions</label>
                            </td>
                        </tr>
                    </table>
                    <%--attractions--%>
                    <%if (PropertiesFullSet.Tables["Properties"].Rows[0]["LocalAttractions"].ToString().Length > 0)
                      {%>
                    <div align="left" class="ViewPropertyPageFonts textfont">
                        <%# PropertiesFullSet.Tables["Properties"].Rows[0]["LocalAttractions"]%>
                    </div>
                    <%} %>
                    <%--attractions--%>
                    <% if (AttractionsDistancesSet.Tables[0].Rows.Count > 0)
                        { %>
                    <div class="tableCenter">
                        <asp:Repeater ID="Repeater2" runat="server" DataMember="Attractions" DataSource="<%# AttractionsDistancesSet %>">
                            <HeaderTemplate>
                                <table class="proptable">
                                    <tr>
                                        <td align="center" colspan="4" style="background-color: #ff6600; color: White; font-size: 12pt;">
                                            <%# PropertiesFullSet.Tables["Properties"].Rows[0]["City"] %> Local Attractions
                                                
                                        </td>
                                    </tr>
                                    <tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <td >
                                    <%# DataBinder.Eval(Container.DataItem, "Attraction", "{0}") %>
                                </td>
                                <td >
                                    <%# DataBinder.Eval(Container.DataItem, "Distance", "{0}") %>
                                </td>
                                <%# IfEvenRow ((System.Data.DataRowView)Container.DataItem) ? "</tr><tr>" : "" %>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tr> </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                    <%} %>
                </div>
            </div>

            <asp:Label ID="lblInfo" runat="server" ForeColor="Red"></asp:Label>
            <div class="TitleFont" style="display:none">
                <div class="rtHeader rightSideHeaders" id="rtHd3" runat="server" style="width: 917px; text-align: left; background-color: transparent !important; font-size: 10pt; font-weight: bold;">
                </div>
                <div id="rtLow3" runat="server" style="border: none; box-shadow: none; margin-left: 0px !important; font-size: 10pt; font-weight: bold; color: #2f6547;">
                </div>
            </div>

        </div>
        </div>

        <br />
     </div>
        <div class="newline">
             <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Name2"] %> is a  <%# PropertiesFullSet.Tables["Properties"].Rows[0]["City"] %> <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Type"] %> in <%# PropertiesFullSet.Tables["Properties"].Rows[0]["StateProvince"] %> <%# PropertiesFullSet.Tables["Properties"].Rows[0]["Country"] %>
        </div>
       <div class="newline">
             <ul class="citylist">
                 <li><%=stateprovince %> Cities: </li>
             <% int rcount = city_ds.Tables[0].Rows.Count;
                 for (int i = 0; i < rcount; i++)
                 {
                     string txt = String.Format("{0}",city_ds.Tables[0].Rows[i][0] );
                     string href = String.Format("/{0}/{1}/{2}/default.aspx", country, stateprovince, txt).ToLower().Replace(" ", "_");
                     string mark = (i != (rcount - 1)) ? ",&nbsp;" : "";
                     %>
                 <li><a href="<%=href %>"><%=txt+mark %></a></li>
              <%} %>
             </ul>
         </div>
    </div>
 
    </div>
            <div class="smallgap">

        </div>
    
    </div>

  

        <asp:Label ID="devnote" runat="server" Text="" BackColor="White" ForeColor="White"
            Visible="false" />
        <script defer="defer" src="/Assets/js/viewproperty.js"></script>
<!-- Start of StatCounter Code for Default Guide -->
<script type="text/javascript">
var sc_project=3614019; 
var sc_invisible=1; 
var sc_security="5d0ed9a7"; 
var scJsHost = (("https:" == document.location.protocol) ?
"https://secure." : "http://www.");
document.write("<sc"+"ript type='text/javascript' src='" +
scJsHost+
"statcounter.com/counter/counter.js'></"+"script>");
</script>
<noscript><div class="statcounter"><a title="free hit
counter" href="http://statcounter.com/" target="_blank"><img
class="statcounter"
src="//c.statcounter.com/3614019/0/5d0ed9a7/1/" alt="free
hit counter"></a></div></noscript>
<!-- End of StatCounter Code for Default Guide -->
    </form>
</asp:Content>
