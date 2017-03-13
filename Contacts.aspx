<%@ Page Title="Vacations-Abroad.com Contact Information" Language="C#" MasterPageFile="~/masterpage/mastermobile.master"
    AutoEventWireup="true" CodeFile="Contacts.aspx.cs" Inherits="Contacts" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations-Abroad.com Contact Information
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <link href="/Assets/css/staticspage.css" rel="stylesheet" />
   <style> .background{position:relative;} .back_img{width:100%;}.backitem{position:absolute;margin:0;padding:0;left:0;top:0;width:100%;}
      .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;cursor:pointer;margin:auto;}
      .formgroup{margin-top:60px;} .footeritem{float:right; margin:20px 40px 0 0;  width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;text-align:left;}
    .itemtile{font-variant: small-caps;font-size:14pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:12pt;display:block;padding:4px;}
    .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:15px 30px;border:2px solid #ff6600;width:400px;margin:auto;}
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="bodycontent" runat="Server">
     <div class="background">
          <img class="back_img" src="/Assets/img/stay.jpg" />
        <div class="backitem">
            <div class="srow center formgroup">
                <div class="topbox"> <a class="alist" >Stay In Touch</a></div>
               
            </div>
            <div class="clear"></div>
            <div class="srow formgroup" >
                  <div class="footeritem">
                    <span class="itemtile">Our Mailing Address:</span>
                    <span class="itemtext">Suite G 284, 5805 State Bridge Rd.</span>
                    <span class="itemtext">Johns Creek, GA 30097</span>
                 </div>

              </div>
            <div class="srow " >
                  <div class="footeritem">
                    <span class="itemtile">Our Telephone: </span>
                    <span class="itemtext">770-687-6889</span>

                 </div>

              </div>
            <div class="srow " >
                  <div class="footeritem">
                    <span class="itemtile">Office Hours:(Eastern Time Zone)</span>
                    <span class="itemtext">Monday-Friday 8AM-8PM</span>
                    <span class="itemtext">Saturday 9AM-1PM</span>
                    <span class="itemtext">Sunday Closed</span>
                 </div>

              </div>
            <div class="clear"></div>
        </div>
    </div>
    <script src="Assets/js/contacts.js"></script>
</asp:Content>
