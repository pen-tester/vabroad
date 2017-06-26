<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="/masterpage/mastermobile.master"
    CodeFile="ThankYou.aspx.cs" Inherits="ThankYou" %>

<%@ OutputCache Duration="600" VaryByParam="*" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Thank your for listing your property
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <style>
        .scontent{
            text-align:left;
            color:#333;
        }
    </style>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
 <form id="mainform" runat="server">
   <div class="scontainer">
    <div class="internalpage srow">
         <div class="smallgap"></div>
           <div class="advertise-con" style="min-height:560px;">
        
               <blockquote>
            <div align="center">
                <p>
                    <font color="#cc0000" size="4" face="Arial">Thank You for listing your property on Vacations-Abroad.com</font></p><br />
                <p>
                    <font color="#cc0000" size="3" face="Arial">ALL INQUIRIES will come from ar@vacations-abroad.com</font><font
                        color="#cc0000" size="3" face="Arial"><br>
                        
                        Create a rule in your email program to make sure that your inquires do not go into
                        the Spam box.</font>
                </p>
            </div>
        </blockquote><br />
        <div class="center">
            <div class="prop-con" style="margin:0px;">
                <strong>
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="lnkCalendar_Click">Click here to edit the reservation calendar for this property.</asp:LinkButton>
                </strong>
            </div>
        </div>
        <div class="scontent">
            <li><span>Your current listing has not been approved for inclusion into our website
                YET. Once it has been approved, we will notify you via email.</span></li><br />
            <li><span>Our Site Fees</span></li><br />
	    <span> By default all listings will have a 10 % commission deducted from all bookings.</br>
	    <br /> <br /> 
           <li><span>Please make sure that the text for your property is totally original and is not duplicated.</span></li>
            <li><span>We review all new listing.<br />
                <li><span>We want to insure that we only have reputable properties on our website, so please allow us 2 days for inclusion in our site.</span></li>

        </div>
        

        
        <div class="center">
            <strong><a href="/userowner/listings.aspx">Your Account </a></strong>
        </div>
    </div>
         <div class="smallgap"></div>
    </div>
   </div>
</form>
</asp:Content>
