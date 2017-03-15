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
