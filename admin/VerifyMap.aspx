<%@ Page Language="C#" MasterPageFile="/masterpage/MasterMobile.master" AutoEventWireup="true" CodeFile="VerifyMap.aspx.cs" Inherits="admin_VerifyMap" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Verify the map
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
      <script src="/assets/js/lib/angular.min.js"></script>    
      <script src="/assets/js/lib/angular-route.min.js"></script> 
      <script src="/assets/js/admin/mainapp.js"></script>
      <script src="/assets/js/admin/verifymapController.js"></script>    
      <script defer="defer" src="/assets/js/admin/verifymap.js"></script>
    <style>
        .main_area{padding:30px 100px;}
        .addressedit{width:100%;}
        table {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        table td, table th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        table tr:nth-child(even){background-color: #f2f2f2;}

        table tr:hover {background-color: #ddd;}

        table th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #4CAF50;
            color: white;
            cursor:pointer;
        }
        /* For modal form*/
        .modal_form{
            position:fixed;
            top:0;left:0;
            width:100%;
            height:100%;
            z-index:10000;
            background:rgba(0,0,0,0.3);
            text-align:center;
            display:none;
        }
        .modal_dialog{
            position:absolute;
            width:500px;
            margin:auto;
            left:0; right:0;
            top:25%;
            background:#fff;
            box-shadow:2px 2px 3px 1px #ddd;
        }
        #verifymap .modal_dialog{
            top:10%;
            bottom:10%;
        }

        #verifymap .modal_content{
            position:absolute;
            top:40px;
            bottom:60px;
         }
        #verifymap .modal_footer{
            position:absolute;
            bottom:0;
         }         
        .modal_head{
            position:relative;
            height:40px;
            width:100%;
            background:#243e53;
            color:#fff;
            text-align:center;
            padding:10px;
            box-sizing:border-box;
            box-shadow:1px 1px 1px 1px #aaa;
        }
        .modal_head .btnclose{
            position:absolute;
            top:10px; right:10px;
            color:#fff;
        }
        .modal_content{
            position:relative;
            width:100%;
            padding:10px;
            text-align:center;
            box-sizing:border-box;
        }
        .modal_footer{
            position:relative;
            padding:10px;
            height:60px;
            width:100%;
            text-align:center;
            border-top:1px solid #bbb;
            box-sizing:border-box;
        }
        button{
            background:#243e53;
            padding:5px 10px;
            border-radius:5px;
            color:#fff;
        }
        button:hover{
            background:#244e53;
        }
        #map_canvas{
            width:100%;
            height:350px;
        }
    </style>     
</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="bodycontent" runat="server">
    <div ng-app="mainapp" ng-controller="verifyController" id="ngmainapp">
        <div class="main_area">
            <table class="" id="proptable">
                <thead>
                    <tr>                 				 		
                        <th ng-click="changesort('City')">                     
                            City<span ng-show="sortingfield=='City' && sorttype==true">&#9650;</span><span ng-show="sortingfield=='City' && sorttype==false">&#9660;</span>
                        </th>
                        <th ng-click="changesort('StateProvince')">                     
                            State<span ng-show="sortingfield=='StateProvince' && sorttype==true">&#9650;</span><span ng-show="sortingfield=='StateProvince' && sorttype==false">&#9660;</span>
                        </th>
                        <th ng-click="changesort('Country')">                     
                            Country<span ng-show="sortingfield=='Country' && sorttype==true">&#9650;</span><span ng-show="sortingfield=='Country' && sorttype==false">&#9660;</span>
                        </th>
                        <th ng-click="changesort('ID')">                     
                            Property #<span ng-show="sortingfield=='ID' && sorttype==true">&#9650;</span><span ng-show="sortingfield=='ID' && sorttype==false">&#9660;</span>
                        </th>
                        <th ng-click="changesort('Address')">                     
                            Address<span ng-show="sortingfield=='Address' && sorttype==true">&#9650;</span><span ng-show="sortingfield=='Address' && sorttype==false">&#9660;</span>
                        </th>
                        <th>                     
                            Verify Map
                        </th>
                        <th>
                            Link to Map
                        </th>
                        <th>
                            Action
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="property in requests = (allrequests | filter:filterfunction)|orderBy:sortingfield:sorttype | startFrom:currentPage*pageSize | limitTo:pageSize">
                        <td class="city">{{property.City}}</td>
                        <td class="state">{{property.StateProvince}}</td>
                        <td class="country">{{property.Country}}</td>
                        <td class="propid">{{property.ID}}<input type="hidden" value="{{property.ID}}"/></td>
                        <td class="address"><input class="addressedit" value="{{decodeHtml(property.Address)}}"/></td>
                        <td>{{getVerified(property.loc_verified)}}</td>
                        <td><a target="_blank"  ng-href="/userowner/propertymap.aspx?userid={{property.UserID}}">Map</a></td>
                        <td><button class="action">Verify Address</button></td>
                    </tr>
                </tbody>
            </table>
            <div>
                <button ng-disabled="currentPage == 0" ng-click="currentPage=currentPage-1">
                    Previous
                </button>
                    {{currentPage+1}}/{{numberOfPages()}}
                <button ng-disabled="currentPage >= requests.length/pageSize - 1" ng-click="currentPage=currentPage+1">
                    Next
                </button>  
            </div>
        </div>

    </div>
    <div class="modal_form" id="verifymap">
        <div class="modal_dialog">
            <div class="modal_head">Verify Map<span class="btnclose" data-target="verifymap">&times;</span></div>
            <div class="modal_content">
                <div id="map_canvas"></div>
                <div>
                    <input type="hidden" id="selected_id" />
                   <div> <label>Country: <span class="country"></span></label></div>
                   <div> <label>State province: <span class="state"></span></label></div>
                   <div> <label>City: <span class="city"></span></label></div>
                   <div> <label>Address: <span class="address editable"><input type="text" value="" /></span></label></div>
                </div>
            </div>
            <div class="modal_footer">
                <button class="verifyaddr">Verify</button>
            </div>
        </div>
    </div>
    <div class="modal_form" id="msgbox">
        <div class="modal_dialog">
            <div class="modal_head">Message<span class="btnclose" data-target="msgbox">&times;</span></div>
            <div class="modal_content">
                Test
            </div>
            <div class="modal_footer">
                <button class="btnclose"  data-target="msgbox">Close</button>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&sensor=false"> </script>
</asp:Content>