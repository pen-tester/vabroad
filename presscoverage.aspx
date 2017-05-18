<%@ Page Title="Vacations-Abroad.com Our Mentions in the Press" Language="C#" MasterPageFile="/masterpage/mastermobile.master" AutoEventWireup="true"
    CodeFile="rentalguarantee.aspx.cs" Inherits="rentalguarantee" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations-Abroad.com Our Mentions in the Press
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <link href="/Assets/css/staticspage.css" rel="stylesheet" />
    <style> 
        .itemtile a{color:#ff6600;}
    .righttext{float:right;}
    .imgwraper{
        margin:0;padding:0 0 30px 0;left:0;top:0;width:100%;
        position:relative;
    }
      .background{position:relative;margin:0;}
      .back_img{width:100%; left:0;top:-0px;z-index:0;position:relative;}.back_item{z-index:10; margin:0;padding:0 0 30px 0;left:0;top:0;width:100%;position:absolute;}
        @media(max-width:510px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;cursor:pointer;margin:auto;}
       .formgroup{padding-top:4px;} .footeritem{width:300px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin-left:1%;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:6pt;display:block;padding:0px;}.itemtext{font-variant:small-caps; font-size:7pt;display:block;padding:2px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}
        .contentbox{margin-top:10px;}
        .link{font-size:8pt;}
            .shidden{display:none;}
        }
       @media(max-width:670px) and (min-width:510px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;cursor:pointer;margin:auto;}
       .formgroup{padding-top:25px;} .footeritem{width:320px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin-left:30px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:10pt;display:block;padding:0px;}.itemtext{font-variant:small-caps; font-size:8pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}
        .contentbox{margin-top:20px;}
       }
        @media(min-width:670px)
        {
        .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:16pt; background-color:#fff;cursor:pointer;margin:auto;}
       .formgroup{padding-top:35px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 30px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:11pt;display:block;padding:3px;}.itemtext{font-variant:small-caps; font-size:9pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 15px;border:2px solid #ff6600;width:400px;margin:auto;}
        .contentboxmargin{margin-top:30px;}
        .contentbox{margin-top:20px;}
        }
        @media(min-width:990px)
        {
        .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;cursor:pointer;margin:auto;}
       .formgroup{padding-top:50px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 100px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:12pt;display:block;padding:3px;}.itemtext{font-variant:small-caps; font-size:10pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 15px;border:2px solid #ff6600;width:400px;margin:auto;}
        .contentboxmargin{margin-top:30px;}
        .contentbox{margin-top:20px;}
         }
        @media(min-width:1200px)
        {
         .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;cursor:pointer;margin:auto;}
          .formgroup{padding-top:120px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 170px;text-align:left;}
        .itemtile{font-variant: small-caps;font-size:14pt;display:block;padding:4px;}.itemtext{font-variant:small-caps; font-size:12pt;display:block;padding:4px;}
        .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:15px 30px;border:2px solid #ff6600;width:400px;margin:auto;}
         .contentboxmargin{margin-top:30px;}
         .contentbox{margin-top:80px;}
        }
    </style>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
        <div class="scontainer">
    <div class="background">
          <img class="back_img" src="/Assets/img/press.jpg" />
        <div class="back_item">
            <div class="srow center formgroup">
                <div class="topbox"> <a class="alist" >Our Press</a></div>
            </div>
            <div class="srow contentbox" >
                  <div class="footeritem">
                    <span class="itemtile"><a href="http://awayishome.com/4171/europe-questions/">• Away Is Home:</a></span>
       <span class="itemtile"><a href="http://www.huffingtonpost.com/kari-haugeto/an-authentic-european-exp_b_5040061.html">• Huffington Post:</a></span>
        <span class="itemtile"><a href="http://www.justluxe.com/travel/villa/feature-1954492.php">•	Just Luxe:</a></span>
    <span class="itemtile"><a href="http://masalamommas.com/2014/05/15/tips-travelling-extended-family/">•	Masala Mommas:   </a></span>
               <span class="itemtile"><a href="http://www.huffingtonpost.com/kari-haugeto/guilt-free-wine-tasting-w_b_5489388.html">•	Huffington Post: </a></span>

<span class="itemtile"><a href="http://wanderlusters.com/molokai-travel-guide-hawaiian-island/">•	Wanderlusters:</a> </span>

<span class="itemtile"><a href="http://suitcasestories.com/5-reasons-book-escape-molokai/">•	Suitcase Stories:</a> </span>

<span class="itemtile"><a href="http://www.toomuchtuscany.com/montalto-medieval-castle-tuscany/">•	Too Much Tuscany: </a></span>


<span class="itemtile"><a href="http://www.crazyintherain.com/enchanting-haven-british-columbia/">•	Legendary Adventures of Anna:</a> </span>

<span class="itemtile"><a href="http://blog.expertflyer.com/expertflyer/2014/11/planning-winter-escape-mallorca-calling/">•	Expert Flyer Blog: </a></span>


<span class="itemtile"><a href="http://www.holidaynomad.com/2014/11/10-awesome-things-to-do-in-santorini.html">•	Holiday Nomad: </a></span>


<span class="itemtile"><a href="http://www.crazyintherain.com/the-inn-at-clifftop-lane-whistler-british-columbia/">•	The Legendary Adventures of Anna:</a> </span>

<span class="itemtile">The Management at Vacations-Abroad.Com</span>

                 </div>

              </div>
        </div>
    </div>
            </div>
        <script src="/Assets/js/footerpage.js" defer="defer"></script>
</asp:Content>
