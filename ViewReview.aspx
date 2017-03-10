<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="/masterpage/MasterMobile.master" CodeFile="ViewReview.aspx.cs" Inherits="ViewReview" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    View Review
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderId="links" runat="server">
        <link href="/css/StyleSheetBig4.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="bodycontent" runat="server">
    <div class="internalpage">
        <div class="srow">
		    Auction Transaction: <%# DrawAsterisks (MainDataSet.Tables["Auctions"].Rows[0]["Auction"])%><br />
		    Accurately Represented: <%# DrawAsterisks (MainDataSet.Tables["Auctions"].Rows[0]["AccuratelyRepresented"])%><br />
		    Customer Service: <%# DrawAsterisks (MainDataSet.Tables["Auctions"].Rows[0]["CustomerService"])%><br />
		    Cleanliness: <%# DrawAsterisks (MainDataSet.Tables["Auctions"].Rows[0]["Cleanliness"])%><br />
		    Good Value: <%# DrawAsterisks (MainDataSet.Tables["Auctions"].Rows[0]["GoodValue"])%><br />
		    <br />
		    Comments:<br />
		    <%# MainDataSet.Tables["Auctions"].Rows[0]["Notes"].ToString () %><br />
		    <br />
		    <button onclick='window.close ();'>Close</button>
        </div>
    </div>
</asp:Content>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>

</head>
<body>
    <form id="MainForm" runat="server">

    </form>
</body>
</html>
