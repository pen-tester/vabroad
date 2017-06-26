<%@ Page Language="C#" MasterPageFile="~/masterpage/mastermobile.master" AutoEventWireup="true"
    CodeFile="Applications.aspx.cs" Inherits="Applications" Title="" %>

<%@ OutputCache Duration="70" VaryByParam="*" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations-Abroad.com Our Mentions in the Press
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <link href="/Assets/css/staticspage.css" rel="stylesheet" />
    <style>
 .righttext{float:right;}
    .imgwraper{
        margin:0;padding:0 0 30px 0;left:0;top:0;width:100%;
        position:relative;
    }
      .background{position:relative;margin:0;}
      .back_img{width:100%; left:0;top:-0px;z-index:0;position:relative;}.back_item{z-index:10; margin:0;padding:0 0 30px 0;left:0;top:0;width:100%;position:absolute;}
        .topbox h1{display:inline;font-size:28px;margin:0;padding:0; -webkit-margin-before: 0;  -webkit-margin-after: 0; -webkit-margin-start: 0px;    -webkit-margin-end: 0px;}
        .footeritem h2{padding:0px;margin:0px;}
        @media(max-width:510px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;margin:auto;}
       .formgroup{padding-top:15px;} .footeritem{width:90%; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin-left:1%;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:8pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:7pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}
        .contentbox{margin-top:10px;}
        .link{font-size:8pt;}
            .shidden{display:none;}
        }
       @media(max-width:670px) and (min-width:510px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;margin:auto;}
       .formgroup{padding-top:2px;} .footeritem{width:90%; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin-left:1%;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:10pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:8pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}
        .contentbox{margin-top:10px;}
       }
        @media(min-width:670px)
        {
        .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:16pt; background-color:#fff;margin:auto;}
       .formgroup{padding-top:45px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 30px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:11pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:9pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 15px;border:2px solid #ff6600;width:400px;margin:auto;}
        .contentboxmargin{margin-top:30px;}
        .contentbox{margin-top:10px;}
        }
        @media(min-width:900px)
        {
        .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;margin:auto;}
       .formgroup{padding-top:55px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 100px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:12pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:10pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 15px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:30px;}
        .contentbox{margin-top:20px;}
         }
        @media(min-width:1200px)
        {
         .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;margin:auto;}
          .formgroup{padding-top:120px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 170px;text-align:left;}
        .itemtile{font-variant: small-caps;font-size:14pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:12pt;display:block;padding:4px;}
        .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:15px 30px;border:2px solid #ff6600;width:400px;margin:auto;}
         .contentboxmargin{margin-top:30px;}
         .contentbox{margin-top:80px;}
        }
    </style>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
    <form id="mainform" runat="server">
        <div class="scontainer">
    <div class="background">
          <img class="back_img" src="/Assets/img/footerimg.jpg" />
        <div class="back_item">
            <div class="srow center formgroup">
                <div class="topbox"> <h1><label class="alist" href="/userowner/listings.aspx">List a Property</label></h1></div>
               
            </div>
            <div class="srow contentbox" >
                  <div class="footeritem widewidth">
                   <span class="itemtile">Our Terms For Listing: </span>
                   <span class="itemtext">1)	Our Booking Fee Is 10% Of The Reservation Amount.</span>
                   <span class="itemtext">2)	We Do Not Collect Security Deposits, Local Taxes Or Cleaning Fees.</span>
                   <span class="itemtext">3)	We Can Wire Funds Directly Into Your Bank Account Or Send To You Via Paypal.</span>
                   <span class="itemtext">4)	We Transfer Funds To You 10 Days Prior To Arrival Of Your Guest.</span>
                   <span class="itemtext shidden">5)	All Listings Include:</span>
                    <div class="interalitem shidden">
                   <span class="itemtext"> a.	7 Photos.</span>
                   <span class="itemtext"> b.	Emails Inquiries Regarding Availability.</span>
                   <span class="itemtext"> c.	Your Ability To Provide A Quote For The Inquiry.</span>
                   <span class="itemtext"> d.	Upon The Booking Of A Reservation, You Will Receive The Contact Details Of The Person Making The Reservation.</span>
                        </div>

                     <div class="center">          <a class="link" href="/accounts/login.aspx">      >Click Here to List Your Property<</a></div>
                   <span class="itemtext">The Management AT Vacations-Abroad.Com</span>

                 </div>
                </div>
        </div>
    </div>

    <div class="clear">
        
    
    </div>
            </div>
    <script src="/Assets/js/footerpage.js" defer="defer"></script>
</form>
</asp:Content>


