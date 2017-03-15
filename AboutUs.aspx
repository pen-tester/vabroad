<%@ Page Title="Vacations-Abroad.com - Who We Are" Language="C#" MasterPageFile="~/masterpage/mastermobile.master"
    AutoEventWireup="true" CodeFile="Contacts.aspx.cs" Inherits="Contacts" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations-Abroad.com - Who We Are
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
      .back_img{width:100%; left:0;top:-0px;z-index:-10;position:relative;}.back_item{margin:0;padding:0 0 30px 0;left:0;top:0;width:100%;position:absolute;}
       @media(max-width:600px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;cursor:pointer;margin:auto;}
       .formgroup{padding-top:2px;} .footeritem{width:90%; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin-left:1%;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:10pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:8pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}
        .contentbox{margin-top:10px;}
       }
        @media(min-width:600px)
        {
        .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:16pt; background-color:#fff;cursor:pointer;margin:auto;}
       .formgroup{padding-top:45px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 30px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:11pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:9pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 15px;border:2px solid #ff6600;width:400px;margin:auto;}
        .contentboxmargin{margin-top:30px;}
        .contentbox{margin-top:10px;}
        }
        @media(min-width:900px)
        {
        .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;cursor:pointer;margin:auto;}
       .formgroup{padding-top:55px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 100px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:12pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:10pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 15px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:30px;}
        .contentbox{margin-top:20px;}
         }
        @media(min-width:1170px)
        {
         .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;cursor:pointer;margin:auto;}
          .formgroup{padding-top:120px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 170px;text-align:left;}
        .itemtile{font-variant: small-caps;font-size:14pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:12pt;display:block;padding:4px;}
        .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:15px 30px;border:2px solid #ff6600;width:400px;margin:auto;}
         .contentboxmargin{margin-top:30px;}
         .contentbox{margin-top:80px;}
        }
     

    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="bodycontent" runat="Server">
    <div class="background">
        <div class="back_item">
            <div class="srow center formgroup">
                <div class="topbox"> <a class="alist" >About Us</a></div>
               
            </div>
            <div class="clear"></div>
            <div class="srow formgroup righttext" >
                <div class="footeritem">
                      <span class="itemtile">Founder</span>
                    <span class="itemtext">Linda Jenkins</span>
                 </div>
                  <div class="footeritem contentboxmargin">
                      <span class="itemtile">Established 2000</span>
                    <span class="itemtext">Vacations-Abroad.com is a registered Delaware LLC (Limited Liability Company) </span>
                    <span class="itemtext">Vacations-Abroad.com is a registered trademark with United States Patent and Trademark Office</span>
                    <span class="itemtext">The Management at Vacations-Abroad.Com</span>
                 </div>
             </div>
             <div class="clear"></div>
        </div>
          <img class="back_img" src="/Assets/img/about.jpg" />
    </div>
</asp:Content>
