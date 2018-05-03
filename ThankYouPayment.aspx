<%@ Page Language="C#" MasterPageFile="/masterpage/mastermobile.master" AutoEventWireup="true" CodeFile="ThankYouPayment.aspx.cs" Inherits="ThankYouPayment" Title="Thank you" %>
<asp:Content ID="Content1" ContentPlaceHolderID="bodycontent" Runat="Server">
<div class="scontainer">
    <div class="internalpage">
        <input type="hidden" id="userid" value="<%=userid %>" />
        <div class="srow">
	    <div align="center">
		    <blockquote>
			    <p>
				    <font color="#cc0000" size="5">Your Payment has been received!</font>
			    </p>
		    </blockquote>
	    </div>
        </div>
    </div>
</div>
     <script src="/assets/js/paymentdone.js" defer="defer"></script>
</asp:Content>
