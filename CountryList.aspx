<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master" AutoEventWireup="true"
    CodeFile="~/countrylist.aspx.cs" Inherits="CountryList"
    EnableEventValidation="false" EnableViewState="true" %>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <style>
         #googlemap{width:95%; min-height:310px;margin:0 15px;}
        .footer_text{padding:25px 0 0 0;}
    </style>
</asp:Content>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <%=country %> Vacation Rentals, Boutique Hotels | Vacations Abroad
</asp:Content>
<asp:Content ID="meta" ContentPlaceHolderID="meta" runat="server">
<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "Event",
  "name": " <%=country %> Vacations",
  "startDate": "2017-07-11T19:30-08:00",
  "location": {
    "@type": "Place",
    "name": "<%=String.Format("{0} {1}", country, region) %>",
    "address": {
      "@type": "PostalAddress",
      "streetAddress": "<%=country %>",
      "addressLocality": "<%=country %>",
      "postalCode": "95051",
      "addressRegion": "<%=country %>",
      "addressCountry": "<%=country %>"
    }
  },
  "image": "https://www.vacations-abroad.com/assets/img/companylogo.jpg",
  "description": "Join us for vacations abroad.",
  "endDate": "2017-09-24T23:00-08:00",
  "offers": {
    "@type": "Offer",
    "url": "<%=String.Format("https://www.vacations-abroad.com/{0}/{1}/default.aspx", region,country)%>",
    "price": "300",
    "priceCurrency": "USD",
    "availability": "http://schema.org/InStock",
    "validFrom": "2017-01-20T16:20-08:00"
  },
  "performer": {
    "@type": "PerformingGroup",
    "name": "Linda Jenkins"
  }
}
</script>
    <meta name="description" content="<%=str_meta %>" /><meta name="keywords" content="<%=str_keyword %>" />
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
<form id="mainform" runat="server">
    <div class="scontainer">
    <div class="internalpagewidth">
        <input type="hidden" id="countryname" value="<%=country %>" />
        <%--    <asp:TextBox runat="server" ID ="txtCityVal"  value="" Style="display:none;" ></asp:TextBox>
        --%>

        <div class="srow">
            <a href="<%=String.Format("https://www.vacations-abroad.com/{0}/default.aspx", region).ToLower().Replace(" ","_") %>" class="backitem"><%=country+" <<" %></a>
        </div>
        <div class="srow center">
                <h1 class="H1CityText">
                    <%--<%= city %> Vacation Rentals--%>
                    <%=country %> Vacations

                </h1>
        </div>
        

        <div class="srow">
                <asp:Label ID="Label3" runat="server" EnableViewState="False" ForeColor="Red" Style="display: none"></asp:Label>
                <div class="srow">
                    <% if (AuthenticationManager.IfAuthenticated && AuthenticationManager.IfAdmin)
                    { %>
                    <div class="srow">
                        <asp:TextBox ID="txtCountryText" runat="server" Rows="7" TextMode="MultiLine" Width="600px"></asp:TextBox><br />
                        <asp:Button ID="btnSubmit" runat="server" Text="Save Text" OnClick="btnSubmit_Click" />
                        <br />
                        <asp:Label ID="Label1" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
                    </div>
                    <% }
                       %>
                    <div class="col-x-4 col-6">
                       <div runat="server" visible="true">
                            <asp:Label ID="lblCountryInfo" CssClass="txtalign" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="col-x-4 col-6">
                           <div  id="googlemap">
                            </div>
                    </div>
 
 


                </div>
                <div class="srow">
                    <asp:Label ID="lblInfo" runat="server" ForeColor="Red"></asp:Label>
                    <asp:SqlDataSource ID="Sql_properties" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                        SelectCommand="GetPropertiesFromStateID2" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="25" Name="StateProvinceID" QueryStringField="StateProvinceID"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                     <div class="srow text-left">  
                
                             <div class="linkpadding">
                                 <h2 class="inlineblock orangetxt"><%=country %> Vacation Rentals and Boutique Hotels</h2>
                                <a href="<%=String.Format("https://www.vacations-abroad.com/{0}/countryproperties.aspx", country).ToLower().Replace(" ","_") %>"><h3 class="inlineblock viewalllink">View all <%=country %> properties</h3></a>
                            </div>  

                     </div>          
 
              <div class="srow">
                  <div class="center">
                        <ul class="stateful">
                            <% int num_states = ds_allinfo.Tables[1].Rows.Count;
                                for (int ind_state = 0; ind_state < num_states; ind_state++)
                                {
                                    var row = ds_allinfo.Tables[1].Rows[ind_state];
                                    string href = String.Format("https://www.vacations-abroad.com/{0}/{1}/default.aspx",country, row["StateProvince"]).ToLower().Replace(" ", "_");
                                     %>
                            <li> 
                                <a href="<%=href %>" class="StateTitle">
                                    <%=row["StateProvince"] %>
                                </a><br />
                                <a href="<%=href %>">
                                    <div class='drop-shadow effect4'><img width='160' height='125' src="<%=String.Format("/images/{0}", row["FileName"]).ToLower() %>" alt="<%=row["StateProvince"] %>" title="<%=row["StateProvince"] %>" /></div>
                                </a>
                            </li>
                            <%} %>
                        </ul>
                   </div>
              </div>
        
        <div class="srow">
            <div class="contentpadding">
                             <div class="orangetxt" id="OrangeTitle" runat="server">
                                <h2 class="orangetxt">
                                    <%=country %> Vacations: Things to see while on vacation in <%=country %>
                               </h2>
                            </div>
                                <% if (AuthenticationManager.IfAuthenticated && AuthenticationManager.IfAdmin)
                    { %>
                        <div>
                        <asp:TextBox ID="txtCountryText2" runat="server" Rows="7" TextMode="MultiLine" Width="600px"></asp:TextBox><br />
                       
                            <asp:Button ID="btnSubmit2" runat="server" Text="Save Text" OnClick="btnSubmit2_Click" />
                       </div>
                        <% } %>
                        <p><asp:Label ID="lblInfo2" CssClass="contentstyle" runat="server" EnableViewState="False"></asp:Label>
                            </p>
            </div>
        </div>
        <div class="footer_text">
            <%=String.Format("{0} vacation rentals and {0} boutique hotels are the perfect opportunity to indulge in {0} vacations.",country) %>
        </div>
        <div class="srow contentpadding">
                <ul class="countrylist">
                    <li><%=region %> Countries: </li>
                    <% int num_country = ds_allinfo.Tables[2].Rows.Count;
                        for (int ind_country = 0; ind_country < num_country; ind_country++)
                        {
                            string comma = (ind_country == (num_country - 1)) ? "" : ", ";
                            var row = ds_allinfo.Tables[2].Rows[ind_country];
                            string href = String.Format("https://www.vacations-abroad.com/{0}/default.aspx", row["Country"]).ToLower().Replace(" ", "_");
                             %>
                    <li><a href="<%=href %>"><%=row["Country"]+comma %></a></li>
                    <%} %>
                </ul>
        </div>
        </div>
        </div>
       <div>     <asp:Label ID="lblInfo22" runat="server" ForeColor="Red" Style="display: none"></asp:Label>
           </div>
        <div class="smallgap">

        </div>
    </div>
    </div>
    <script>
        var markers=<%=markers %>;
    </script>
    <script type="text/javascript" defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&sensor=false">
    </script>
    <script type="text/javascript" defer="defer" src="/assets/js/countryproperty.js?4">
    </script>


<!-- Start of StatCounter Code for Default Guide -->
<script type="text/javascript">
var sc_project=3341533; 
var sc_invisible=1; 
var sc_security="ebe10c56"; 
var scJsHost = (("https:" == document.location.protocol) ?
"https://secure." : "http://www.");
document.write("<sc"+"ript type='text/javascript' defer='defer' src='" +
scJsHost+
"statcounter.com/counter/counter.js'></"+"script>");
</script>
<noscript><div class="statcounter"><a title="site stats"
href="http://statcounter.com/" target="_blank"><img
class="statcounter"
src="//c.statcounter.com/3341533/0/ebe10c56/1/" alt="site
stats"></a></div></noscript>
<!-- End of StatCounter Code for Default Guide -->

</form>
</asp:Content>

