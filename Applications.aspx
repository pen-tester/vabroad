<%@ Page Language="C#" MasterPageFile="~/masterpage/mastermobile.master" AutoEventWireup="true"
    CodeFile="Applications.aspx.cs" Inherits="Applications" Title="" %>

<%@ OutputCache Duration="70" VaryByParam="*" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations-Abroad.com Our Mentions in the Press
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <link href="/Assets/css/staticspage.css" rel="stylesheet" />
    <style>
     .background{position:relative;} .back_img{width:100%;}.backitem{position:absolute;margin:0;padding:0;left:0;top:0;width:100%;}
      .alist{ color:#000;padding:3px 0px; font-family:Verdana; font-size:22pt; background-color:#f5ede3;cursor:pointer;margin:auto;}
      .formgroup{margin-top:100px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin-left:170px;text-align:left;}
    .itemtile{font-variant: small-caps;font-size:14pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:12pt;display:block;padding:4px;}
    .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 30px;border:2px solid #ff6600;width:400px;margin:auto;}
    </style>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
    <div class="background">
          <img class="back_img" src="/Assets/img/footerimg.jpg" />
        <div class="backitem">
            <div class="srow center formgroup">
                <div class="topbox"> <a class="alist" href="/userowner/listings.aspx">List a Property</a></div>
               
            </div>
            <div class="srow formgroup" >
                  <div class="footeritem">
                   <span class="itemtile">Our Terms For Listing: </span>
                   <span class="itemtext">1)	Our Booking Fee Is 10% Of The Reservation Amount.</span>
                   <span class="itemtext">2)	We Do Not Collect Security Deposits, Local Taxes Or Cleaning Fees.</span>
                   <span class="itemtext">3)	We Can Wire Funds Directly Into Your Bank Account Or Send To You Via Paypal.</span>
                   <span class="itemtext">4)	We Transfer Funds To You 10 Days Prior To Arrival Of Your Guest.</span>
                   <span class="itemtext">5)	All Listings Include:</span>
                    <div class="interalitem">
                   <span class="itemtext"> a.	7 Photos.</span>
                   <span class="itemtext"> b.	Emails Inquiries Regarding Availability.</span>
                   <span class="itemtext"> c.	Your Ability To Provide A Quote For The Inquiry.</span>
                   <span class="itemtext"> d.	Upon The Booking Of A Reservation, You Will Receive The Contact Details Of The Person Making The Reservation.</span>
                        </div>

                     <div class="center">          <a>      >Click Here to List Your Property<</a></div>
                   <span class="itemtext">The Management AT Vacations-Abroad.Com</span>

                 </div>
                </div>
        </div>
    </div>

    <div class="clear">
        
    
    </div>
</asp:Content>


