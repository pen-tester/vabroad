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

        .btnaction{
            background-color:#154890;
            border:2px solid #cdbfac;
            border-radius:6px;
        }
    </style>
</asp:Content>
<asp:Content ID="content" ContentPlaceHolderID="bodycontent" runat="server">
    <div class="internalpage">
        <div class="srow">
            <div id="map_canvas" class="smap">
            </div>
        </div>
        <div class="srow">
            <table>
                <tr>
                    <th>Property#</th>
                    <th>Name</th>
                    <th>Country</th>
                    <th>State</th>
                    <th>City</th>
                    <th>Address</th>
                    <th>Verified</th>
                    <th>Action</th>
                </tr>
                <tr>
                    <td>8332 </td>
                    <td>Name </td>
                    <td>c </td>
                    <td>s </td>
                    <td>ct </td>
                    <td>add </td>
                    <td>Verified </td>
                    <td><input type="button" value="Edit" class="btnaction"/></td>
                </tr>
                <tr>
                    <td>8332 </td>
                    <td>Name </td>
                    <td>c </td>
                    <td>s </td>
                    <td>ct </td>
                    <td>add </td>
                    <td>Verified </td>
                    <td><input type="button" value="Edit" class="btnaction"/></td>
                </tr>
                <tr>
                    <td>8332 </td>
                    <td>Name </td>
                    <td>c </td>
                    <td>s </td>
                    <td>ct </td>
                    <td>add </td>
                    <td>Verified </td>
                    <td><input type="button" value="Edit" class="btnaction"/></td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&sensor=false"> </script>
    <script src="/assets/js/propmap.js" defer="defer"></script>
</asp:Content>
