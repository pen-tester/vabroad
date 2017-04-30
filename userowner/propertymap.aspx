<%@ Page Language="C#" AutoEventWireup="true" CodeFile="propertymap.aspx.cs" Inherits="userowner_propertymap" MasterPageFile="/masterpage/mastermobile.master" %>

<asp:Content ID="title" runat="server" ContentPlaceHolderID="head">Property Map</asp:Content>
<asp:Content ID="links" runat="server" ContentPlaceHolderID="links">
    <style>
        .smap{width:500px; height:400px;min-height:1px;margin:10px auto; }
       table {
            width: 100%;
            font-family: Verdana;
            border-collapse: collapse;
            font-size:10pt;
            margin:20px 0px;
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
            cursor:pointer;
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
                    <th>Country</th>
                    <th>State</th>
                    <th>City</th>
                    <th>Address</th>
                    <th>Verified</th>
                    <th>Action</th>
                </tr>
                 <%
                     int count = ds_proplocation.Tables[0].Rows.Count;
                     for (int i=0; i<count; i++)
                     {
                         var srow = ds_proplocation.Tables[0].Rows[i];
                         string action = String.Format("showeditmap({0})", srow["ID"].ToString());
                         int addr_verified;
                         if (!int.TryParse(srow["loc_verified"].ToString(), out addr_verified)) addr_verified = 0;
                         float latitude, longitude;
                         if (!float.TryParse(srow["loc_latlang"].ToString(), out latitude)) latitude = 0;
                         if (!float.TryParse(srow["loc_logitude"].ToString(), out longitude)) longitude = 0;

                         string url = String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/{3}/default.aspx",
                             srow["Country"], srow["StateProvince"] ,srow["City"]);

                 %>
                     <tr>
                        <td><a href="<%=url %>"><%=srow["ID"] %> </a> </td>
                        <td><%=srow["Country"] %>  </td>
                        <td><%=srow["StateProvince"] %>  </td>
                        <td><%=srow["City"] %>  </td>
                        <td><%=srow["Address"] %>  </td>
                        <td><%=addr_verified %>  </td>
                        <td><input type="button" value="Edit" onclick="<%=action%>" class="btnaction"/></td>
                    </tr>
                <%
                    }
                %>

            </table>
        </div>
    </div>
    <script>

    </script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&sensor=false"> </script>
    <script src="/assets/js/propmap.js" defer="defer"></script>
</asp:Content>
