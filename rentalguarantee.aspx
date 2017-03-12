<%@ Page Language="C#" MasterPageFile="~/masterpage/mastermobile.master" AutoEventWireup="true"
    CodeFile="rentalguarantee.aspx.cs" Inherits="rentalguarantee" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
   Rental Guarantee
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <link href="/Assets/css/staticspage.css" rel="stylesheet" />
    <style>
     .background{position:relative;} .back_img{width:100%;}.backitem{position:absolute;margin:0;padding:0;left:0;top:0;width:100%;}
      .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;cursor:pointer;margin:auto;}
      .formgroup{margin-top:60px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin-left:170px;text-align:left;}
    .itemtile{font-variant: small-caps;font-size:14pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:12pt;display:block;padding:4px;}
    .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:15px 30px;border:2px solid #ff6600;width:400px;margin:auto;}
    </style>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
    <div class="background">
          <img class="back_img" src="/Assets/img/rent.jpg" />
        <div class="backitem">
            <div class="srow center formgroup">
                <div class="topbox"> <a class="alist" >Rental Guarantee</a></div>
               
            </div>
            <div class="srow formgroup" >
                  <div class="footeritem">
                    <span class="itemtile">Vacations-Abroad.com will Guarantee Your Reservation Booked Through Our Website. </span>
                    <span class="itemtext">Upon Your Arrival, If The Property Is Not Up To Your Expectations And You Have Found It To Be Unacceptable and Inaccurately Represented.  Notify Us Immediately.  We Will Begin Negotiations With the Property Owner Regarding a Refund. </span>
                    <span class="itemtext">Should The Property Owner Decline a Refund, Vacations-Abroad.com will Reimburse You Directly.  If Possible, Document the Status of The Property With Your Phone Camera.</span>
                 </div>
                </div>
        </div>
    </div>
</asp:Content>
