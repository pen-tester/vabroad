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
    .dlgMsg{
        background-color:#fafbfc;
        border:5px solid #f0b892;
        border-radius:55px;
        color:#767271;
        width:300px;
        position:relative;
        margin:auto;
        margin-top:300px;
        padding:40px;
    }
     .modalhead{
        position:absolute;right:15px; top:10px;
    }
     .editmapform{
         margin:150px auto;
         width:600px; height: 700px;
         background-color:#fafbfc;
         border:5px solid #f0b892;
         border-radius:20px;
         position:relative;
     }
     .mapcontent{

     }
     .maddr{
         width:400px; 
     }
     .mselect{
         width:150px; 
     }
     .fieldgroup{
         padding:10px;
     }
     .lblField{
         width:100px; display:inline-block;
     }
     .btnMapForm{
            background-color:#154890;
            border:2px solid #cdbfac;
            border-radius:6px;
            cursor:pointer;
            padding:5px 20px;
     }
    </style>
</asp:Content>
<asp:Content ID="content" ContentPlaceHolderID="bodycontent" runat="server">
    <form id="mainform" runat="server">
        <div class="scontainer">
    <div id="editform" class="modalform">
        <div class="editmapform">
                  <div class="modalhead">
                    <span class="mclose" data-target="editform">x</span>
                </div>   
            <div class="mapcontent">
                <div class="smap" id="propmap">

                </div>
                <div>
                    
                </div>
                <div class="map_form">
                    <div class="fieldgroup">
                        <div class="lblField">Country:</div>
                         <select id="m_country" class="mselect" data-target="">
                        </select>
                    </div>
                    <div class="fieldgroup">
                        <div class="lblField">State:</div>
                        <select id="m_state" class="mselect" data-target="">

                        </select>
                    </div>
                    <div class="fieldgroup">
                        <div class="lblField">City:</div>
                        <select id="m_city" class="mselect" data-target="">
                        </select>
                        <input type="text" id="m_othercity" class="mselect" />
                    </div>
                    <div class="fieldgroup">
                        <div class="lblField">Address:</div>
                         <input type="text" id="m_addr" class="maddr" />
                    </div>
                    <div class="fieldgroup center">
                        <input type="button" value="Verify Address" id="verify" class="btnMapForm" />
                    </div>

                    <div class="fieldgroup center">
                        <input type="button" value="Update" id="update" class="btnMapForm" />
                        <input type="button" value="Cancel" id="cancel" class="btnMapForm" />
                    </div>
                    <input type="hidden" name="hpropid" id="hpropid" />
                    <input type="hidden" name="hcityid" id="hcityid" />
                    <input type="hidden" name="hstateid" id="hstateid" />
                    <input type="hidden" name="hcity" id="hcity" />
                    <input type="hidden" name="haddr" id="haddr" />
                    <input type="hidden" name="hlat" id="hlat" />
                    <input type="hidden" name="hlng" id="hlng" />


                   
                </div>
            </div>       
        </div>
    </div>

    <div id="msgdlg" class="modalform">
            <div id="modal_loading" class="modalLoading">
                <div class="loader"> </div>
            </div>
            <div id="modal_dialog" class="dlgMsg" >
                <div class="modalhead">
                    <span class="mclose" data-target="msgdlg">x</span>
                </div>
                <div class="srow">
                    <div class="col-4">Message:</div>
                    <div class="col-8" id="modalmsg"></div>
                </div>
            </div>
    </div>

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
                     List<Location> eLocation = new List<Location>();
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
                             srow["Country"], srow["StateProvince"] ,srow["City"],srow["ID"]).ToLower().Replace(" ","_");

                         if(addr_verified == 1)
                         {
                             Location loc = new Location();
                             loc.title = srow["Name2"].ToString();
                             loc.lat = Double.Parse(srow["loc_latlang"].ToString());
                             loc.lng =Double.Parse(srow["loc_logitude"].ToString());
                             loc.description = srow["City"].ToString();
                             loc.URL = url;
                             eLocation.Add(loc);
                         }
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
                    string ans =BookDBProvider.getJsonString<Location>(eLocation) ;
                %>

            </table>
        </div>
    </div>
            </div>
    <script>
        var gmarkers=<%=ans%>;
    </script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&sensor=false"> </script>
    <script src="/assets/js/propmap.js?os=0" defer="defer"></script>
</form>
</asp:Content>
