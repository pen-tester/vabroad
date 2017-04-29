<%@ Page Language="C#" AutoEventWireup="true" CodeFile="propertymap.aspx.cs" Inherits="userowner_propertymap" MasterPageFile="/masterpage/mastermobile.master" %>

<asp:Content ID="title" runat="server" ContentPlaceHolderID="head">Property Map</asp:Content>
<asp:Content ID="links" runat="server" ContentPlaceHolderID="links">
    <style>
        .smap{width:400px; height:400px;min-height:1px;}
       table {
            width: 100%;
            font-family: Verdana;
            border-collapse: collapse;
            font-size:10pt;
            margin-top:20px;
            border:1px solid #444;
        }
        td {
            border: 0;
            text-align: left;
            padding:3px 0px;
        }
        th{text-align:center; padding:3px 0px;border: 0;}

        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>
</asp:Content>
<asp:Content ID="content" ContentPlaceHolderID="bodycontent" runat="server">
    <div class="internalpage">
        <div id="map" class="smap">
        </div>
    </div>
    <script src="/assets/js/propmap.js" defer="defer"></script>
</asp:Content>
