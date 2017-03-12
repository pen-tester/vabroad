<%@ Page Title="Vacations-Abroad.com - Who We Are" Language="C#" MasterPageFile="~/masterpage/mastermobile.master"
    AutoEventWireup="true" CodeFile="Contacts.aspx.cs" Inherits="Contacts" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations-Abroad.com - Who We Are
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <link href="/Assets/css/staticspage.css" rel="stylesheet" />
    <style>
    .background{position:relative;} .back_img{width:100%;}.backitem{position:absolute;margin:0;padding:0;left:0;top:0;width:100%;}
      .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;cursor:pointer;margin:auto;}
      .formgroup{margin-top:60px;} .footeritem{margin:30px 180px 0px 0px; width:450px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;text-align:left;}
    .itemtile{font-variant: small-caps;font-size:14pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:12pt;display:block;padding:4px;}
    .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:15px 30px;border:2px solid #ff6600;width:400px;margin:auto;}
    .righttext{float:right;}
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="bodycontent" runat="Server">
    <div class="background">
          <img class="back_img" src="/Assets/img/about.jpg" />
        <div class="backitem">
            <div class="srow center formgroup">
                <div class="topbox"> <a class="alist" >About Us</a></div>
               
            </div>
            <div class="clear"></div>
            <div class="srow formgroup righttext" >
                <div class="footeritem">
                      <span class="itemtile">Founder</span>
                    <span class="itemtext">Linda Jenkins, CEO</span>
                      <span class="itemtext"> About the founder</span>
                 </div>
                  <div class="footeritem">
                      <span class="itemtile">ESTABLISHED 2000</span>
                    <span class="itemtext">We are a member of the Johns Creek Chamber of Commerce</span>
                      <span class="itemtext"> We do our banking with Compass Bank in St Augustine, Florida</span>
                    <span class="itemtext">Vacations-Abroad.com is a registered Delaware LLC (Limited Liability Company) </span>
                    <span class="itemtext">Vacations-Abroad.com is a registered trademark with United States Patent and Trademark Office</span>
                    <span class="itemtext">The Management at Vacations-Abroad.Com</span>
                 </div>
             </div>
             <div class="clear"></div>
        </div>
    </div>
</asp:Content>
