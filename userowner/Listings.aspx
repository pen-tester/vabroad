<%@ Page Language="C#" EnableEventValidation="false" MasterPageFile="/masterpage/mastermobile.master" AutoEventWireup="true" CodeFile="Listings.aspx.cs" Inherits="userowner_Listing" %>
<asp:Content ID="title" runat="server" ContentPlaceHolderID="head">Listings</asp:Content>
<asp:Content ID="links" runat="server" ContentPlaceHolderID="links">
    <link href="/Assets/css/listings.css" rel="stylesheet" />
    <link href="/Assets/css/response.css" rel="stylesheet" />
     <style>
       ul.nav li{display:inline-block; } ul.nav{z-index:10}
       .nav>li>a:focus, .nav>li>a:hover{text-decoration:none; background-color:#eee;}
       .nav>li>a{cursor:pointer;background-color:#f3ede3;padding:10px 15px; border-radius:0px; box-shadow:inset 0px -8px 7px -9px rgba(0,0,0,.4),-2px -2px 5px -2px rgba(0,0,0,.4); }
       .nav>li.active >a, .nav>li.active>a:hover{background:#fff;border-bottom-color:transparent;box-shadow:inset 0 0 0 0 rgba(0,0,0,.4),-2px -3px 5px -2px rgba(0,0,0,.4); }
       .tab-pane.active{display:block;} .tab-pane{display:none;}
       .tabs-content{display:block;background-color:transparent;padding:0;margin-top:-4px;}
       .form-control {
            display: block;
            width: 100%;
            height: 34px;
            padding: 2px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            box-sizing:border-box;
       }
       .form-group{margin:3px 0px;}.groupMargin{margin-top:10px;}
        table {
            width: 100%;
            font-family: Verdana;
            border-collapse: collapse;
            font-size:10pt;
            margin-top:20px;
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
        .btnBlue{cursor:pointer;color:#fff;border-radius:3px;background-color:#154890;border:2px solid #cdbfac;font-size:13px;font-family:Verdana;margin-top:10px;text-align:center;height:30px;margin:3px;}
        .btnAction{cursor:pointer;color:#fff;border-radius:3px;background-color:#154890;border:1px solid #cdbfac;font-size:12px;font-family:Verdana;margin:1px;text-align:center;}
        .table td,th{height:35px;}
        .btntab{font-size:12pt;font-family:Verdana;color:#ff6600;}
        .active .btntab{color:#154890;}
        .orangecolor{font-family:Verdana;color:#ff6600;}
        ul.nav li.hidden{display:none;}
   </style>
</asp:Content>

<asp:Content ID="cont_listing" runat="server" ContentPlaceHolderID="bodycontent">
    <form id="mainform" runat="server">
        <div class="scontainer">
    <div class="internalpage">
      <div class="srow">
	<% if (BackLink.Visible) { %>
	<div class="center">
					<strong>
						<asp:HyperLink ID="BackLink" runat="server" NavigateUrl="OwnersList.aspx">
							Return to Owners list
						</asp:HyperLink>
					</strong>
	</div>
	<br />
	<% } %>

       <div class="srow">
           <div class="col-5"></div>
            <div class ="col-2 listingpadding">
                <div class ="srow">
                    <strong>
                    <a href='<%= CommonFunctions.PrepareURL ("OwnerInformation.aspx?UserID=" + userid.ToString ()) %>' class="orangecolor">
							Contact Details
					</a>
                    </strong>
                </div>
                <div class ="srow">
                    <strong>
						<a class="orangecolor" href='<%= CommonFunctions.PrepareURL ("AccountInformation.aspx?UserID=" + userid.ToString ()) %>'>
							Email / Password
						</a>
					</strong>
                </div>
                <div class ="srow">
					<strong>
						<a class="orangecolor" href='<%= CommonFunctions.PrepareURL ("ViewInvoices.aspx?UserID=" + userid.ToString ()) %>'>
							View Invoices
						</a>
					</strong>
                </div>
            </div>
            
        </div>
        <div class="srow center">
            Welcome <%=(userinfo.FirstName+ " "+userinfo.LastName) %> !
        </div>
        <div class="newline">
            <div id="exTab3">	
                    <ul  class="nav">
		                <li class="lblFor  <%=cssclass_tabs[1]%>">
                            <a class="btntab" data-target="tab2">My Properties</a>
		                </li>                        
		                <li class="lblFor <%=cssclass_tabs[0]%>">
                            <a  class="btntab" data-target="tab1">My Inquiries</a>
		                </li>
		                <li class="lblFor  <%=cssclass_tabs[2]%>">
                            <a class="btntab" data-target="tab3">List A Property</a>
		                </li>
	                 </ul>
                    <div class="clearfix"></div>
                    <div class="tabs-content">
			            <div class="tab-pane  <%=cssclass_tabs[0]%> tabback" id="tab1">
                            <div class="srow">
                           <div class="col-4 ">
                            <div class="newline center">
                                 Current Request for a Quote
                            </div>
                            <div class="tablepanel">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Date of Arrival</th>
                                            <th>Link To Response</th>
                                        </tr>
                                     </thead>
                                    <tbody>
                                        <% int count = owner_ds.Tables[0].Rows.Count;
                                            for(int o_ind=0; o_ind<count; o_ind++) {
                                                var row = owner_ds.Tables[0].Rows[o_ind];
                                                int resp = 0;
                                                if (!Int32.TryParse(row["IfReplied"].ToString(), out resp))resp = 0;    %>
                                         <tr>
                                            <td>Property <%=row["PropertyID"] %></td>
                                             <td  ><%=DateTime.Parse(row["ArrivalDate"].ToString()).ToString("MMM d, yyyy") %></td>
                                             <% if (resp == 1)
                                                 { %>
                                                <td class="bookinglink">Responded</td>
                                             <%} else { 
                                                    
                                                     %>
                                                <td><a class="bookinglink" href="travelerresponse.aspx?quoteid=<%=row["ID"] %>">Respond</a></td>

                                             <%} %>

                                         </tr>
                                        <%} %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="newline center">
                                 Current Quote Submitted
                            </div>
                            <div class="tablepanel">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Replied Date</th>
                                            <th>Link To Quote</th>
                                        </tr>
                                     </thead>
                                    <tbody>
                                        <% 
                                            for(int o_ind=0; o_ind<count; o_ind++) {
                                                var row = owner_ds.Tables[0].Rows[o_ind];
                                                int quote = 0,resp=0;
                                                if (!Int32.TryParse(row["IsQuoted"].ToString(), out quote))quote = 0; 
                                                if (!Int32.TryParse(row["IfReplied"].ToString(), out resp))resp = 0;   %>
                                         <tr>
                                            <% if (resp == 1)
                                                     { %>
                                             <td><%=DateTime.Parse(row["SentTime"].ToString()).ToString("MMM d, yyyy") %></td>
                                             <% if (quote == 1)
                                                     { %>
                                                <td style="color:#ff6600">Reserved</></td>
                                             <%}
                                                     else
                                                     {

                                                     %>
                                                <td>Not Reserved</td>

                                             <%}
                                                 } else {  %>
                                                <td></td><td></td>
                                             <%} %>

                                         </tr>
                                        <%} %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="newline center">
                                 Quote Accepted
                            </div>
                            <div class="tablepanel">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Date of Arrival</th>
                                            <th>Link To Booking</th>
                                        </tr>
                                     </thead>
                                    <tbody>
                                        <%
                                            for (int o_ind = 0; o_ind < count; o_ind++)
                                            {
                                                var row = owner_ds.Tables[0].Rows[o_ind];
                                                int quote;
                                                if (!Int32.TryParse(row["IsQuoted"].ToString(), out quote)) quote = 0;
                                                if (quote == 1)
                                                {
                                                %>
                                                <tr>
                                                     <td><%=DateTime.Parse(row["ArrivalDate"].ToString()).ToString("MMM d, yyyy") %></td>
                                                    <td><a href="/userowner/booking.aspx?resp_number=<%=int.Parse(row["RID"].ToString()) %>">Booking</a></td>
                                                </tr>
                                              <%}else { %>
                                                    <tr><td></td><td></td></tr>
                                                <%} %>
                                        <%} %>
                                    </tbody>
                                </table>
                            </div>
                        </div>  
                            </div>
                            <div class="clear"></div>

			            </div>
			            <div class="tab-pane  <%=cssclass_tabs[1]%> tabback" id="tab2">
                          <div class="newline">
                                    <div class="srow center">
                                        MY PROPERTIES
                                    </div>
                                    <div class="srow center">
                                       <a href="/userowner/propertymap.aspx?userid=<%=userid %>" class="orangecolor">
                                           View the map of your properties
                                       </a>
                                        
                                    </div>
                                       <div class="srow">
                                           <input type="hidden" id="current_userid" value="<%=userid.ToString () %>" />
                                            <table>
                                                <thead>
                                                    <tr>
                                                        <th>Property</th>
                                                        <th>Name</th>
                                                        <th class="btgroupcontainer"></th>
                                                    </tr>
                                                    </thead>
                                                <tbody>
                                                    <%  

                                                        String now = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                                                        if (property_set.Tables.Count > 0)
                                                        {
                                                            count = property_set.Tables[0].Rows.Count;
                                                            for (int i = 0; i < count; i++)
                                                            {
                                                                var property = property_set.Tables[0].Rows[i];
                                                             %>

                                                    <tr>
                                                    <td><a href="<%= CommonFunctions.PrepareURL ("ViewProperty.aspx?UserID=" + userid.ToString () + "&PropertyID=" + property["id"], "*User* Listings") %>"> <%= property["id"] %></a></td>
                                                    <td><%= property["Name2"] %></td>
                                                    <td class="btgroupcontainer">
                                                        <div class="buttongroup">
                                                            <button type="button"  class="btnAction bt_delete_Command"   data-target ="<%= property["id"] %>">Delete</button>
                                                            <button type="button"  class="btnAction bt_edittxt_Command"  data-target = "<%= property["id"] %>">Edit Text</button>
                                                            <button type="button"  class="btnAction bt_editphoto_Command" data-target ="<%= property["id"] %>">Edit Photo</button> 
                                                            <button type="button"  class="btnAction bt_calendar_Command"  data-target ="<%= property["id"] %>">Calendar</button>
                                                            <%= String.Format("%@ %@ %d", now, property["RenewalDate"].ToString(), String.Compare(now, property["RenewalDate"].ToString())) %> 
                                                            <% if (property["RenewalDate"] == null || String.Compare(now, property["RenewalDate"].ToString()) >0)
                                                                { %>
                                                            <button type="button" class="btnAction bt_payment_Command"   data-target ="<%= property["id"] %>">Payment</button>

                                                            <% } %>

                                                        </div>
                                                                 
                                                            
                                                            
                                                    </td>
                                                    </tr>

                                                    <%
                                                            }
                                                        }%>
                                                </tbody>
                                            </table>

                                        </div>
                                </div>
           
			            </div>
                        <div class="tab-pane  <%=cssclass_tabs[2]%> tabback" id="tab3">
                            <div class="srow">
                                          <div class="srow center groupMargin">
                                            <asp:Button ID="Button1" CssClass="btnBlue" runat="server" Text="List A Property" OnClick="ListProperty_Click" />
                                        </div>
                                        <!--<div class="srow center">
                                            <asp:Button ID="Button3"  CssClass="btnBlue" OnClick="OurCommision_Click"  runat="server" Text="Our Commission %" />
                                        </div>
                                        -->
                            </div>
           
			            </div>
                  </div>

            </div>
        </div>
        </div>
    </div> 
            </div>
         
    <script src="/Assets/js/listings.js?1" defer="defer"></script>
</form>
</asp:Content>