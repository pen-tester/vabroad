<%@ Page Language="C#" MasterPageFile="/masterpage/MasterMobile.master" AutoEventWireup="true" CodeFile="Payment.aspx.cs" Inherits="userowner_Payment" %>

<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <style>
        .siteName{font-size:16pt; font-weight:bold; font-family:Verdana;}
        .normalMargintop{margin-top:10px;}
        .location_right{text-align:right;}
        .borderpane{
            border:3px solid black;
            border-radius:3px;
            background-color:#f3ede3;
            padding:10px; 
        }
        .table-bordered{
            border:1px solid #ddd;
            width:100%;
            background-color:#154890;
            color:#fff;
        }
        .tablerow{
            border:1px solid #fff;
        }
        td{text-align:center;}
        .text-right{text-align:right;}
        .smallwidth{width:45px;}
 .btnsendquote{cursor:pointer; padding:5px; border-radius:5px;color:#fff;font-family:arial;font-size:12px;background:#154890;font-weight:700;height:26px;right:6px;box-shadow:2px 2px 6px #154890;border:1px solid #154890}
                                  .btnsendquote:active{padding-top:4px;}
    </style>
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="bodycontent" runat="server" >
    <div class="internalpagewidth">
    <div class="internalpagewidth">
        <div class="srow normalMargintop">
            <div class="col-6">
                <label class="siteName">Vacation-Abroad.com</label>
            </div>
            <div class="col-6">
                <div class="srow location_right">
                <label>Payment for reservation</label>         
                 </div>
                <div class="srow location_right">
                       <label>Current Date:<%=DateTime.Now.ToString("MMM d, yyyy") %></label>
                 </div>
            </div>
        </div>

        <div class="srow normalMargintop">
            <div class="srow">
                You have agreed the following terms.
            </div>
            <div class="srow normalMargintop">
                <div class="col-6">
                    <div class="borderpane srow">
                        <div class="col-2 centered">
                            Owner:
                        </div>
                        <div class="col-10 text-left">
                            <ul>
                                <li><%=owner_info.firstname+" "+owner_info.lastname %></li>
                                <li>Email:<%=owner_info.email %></li>
                                <li>Phone Number:<%=owner_info.PrimaryTelephone %></li>
                            </ul>
                        </div>
                     </div>
                </div>
                <div class="col-6">
                    <div class="borderpane srow">
                    <div class="col-2 centered">
                        Renter:
                    </div>
                    <div class="col-10 text-left">
                        <ul>
                            <li><%=inquiryinfo.ContactorName %></li>
                            <li>Email:<%=inquiryinfo.ContactorEmail %></li>
                            <li>Phone Number:<%=inquiryinfo.Telephone %></li>
                        </ul>
                    </div>
                    </div>
                </div>
            </div>
             <div class="srow normalMargintop">
                <table class="table-bordered">
                  <thead>
                    <tr class="tablerow">
                      <th>Property Location</th>
                      <th>Property #</th>
                      <th>Our Commission(%)</th>
                      <th>Our Commission</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td><%=prop_info.City %> <%=prop_info.StateProvince %> <%=prop_info.Country %></td>
                      <td><%=inquiryinfo.PropertyID %></td>
                      <td>10</td>
                      <td><%=BookDBProvider.DoFormat(_total_sum*Convert.ToDecimal(0.1)) %></td>
                    </tr>
                   </tbody>
                </table>
            </div>
            <div class="srow normalMargintop">
                Arrival Date:<%=DateTime.Parse(inquiryinfo.ArrivalDate).ToString("MMM d, yyyy") %><br />
                Currency:<%=currency_type[email_resp.CurrencyType] %> 
            </div>
            <div class="srow normalMargintop">
                <table class="table-bordered">
                  <thead>
                    <tr class="tablerow">
                      <th># of Nights</th>
                      <th>Description</th>
                      <th>Price Quote</th>
                      <th>Total Rental</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td><%=inquiryinfo.Nights %></td>
                      <td><%=prop_info.Name2 %></td>
                      <td><%=BookDBProvider.DoFormat(email_resp.NightRate) %></td>
                      <td><%=BookDBProvider.DoFormat(_total_sum) %></td>
                    </tr>
                   </tbody>
                </table>
            </div>
            <div class="srow text-right normalMargintop">
               <div class="srow">
                    Amount Due to Reserve Property: <%=BookDBProvider.DoFormat(_total_sum) %>
                </div>
                <div class="srow">
                    Security Deposit:<%=BookDBProvider.DoFormat(email_resp.SecurityDeposit) %>
                </div>
                <div class="srow">
                    Lodaing Tax: <input type="text" readonly="true" class="smallwidth" value="<%=BookDBProvider.DoFormat(email_resp.LoadingTax) %>%" />  <input type="text" readonly="true" class="smallwidth" value="<%=BookDBProvider.DoFormat(email_resp.LoadingTax) %>" />
                </div>
                <div class="srow">
                    Cleaning Fee:<%=BookDBProvider.DoFormat(email_resp.CleaningFee) %>
                </div>
                <div class="srow">
                   Security Deposit + Lodging Tax + Cleaning Fee = Amount Due to Owner upon Arrival:<%=BookDBProvider.DoFormat(_balance) %>
                </div>
                <div class="srow top_formrow">
                    Total Rental Price:<%=BookDBProvider.DoFormat(_total) %>
                </div>
            </div>
 
        </div>

        <div class="srow">
            <div class="col-4">
                <div id="pay_form">

                    <div class="srow normalMargintop">
                        <asp:Button ID="payment" OnClick="payment_Click" CssClass="btnsendquote" runat="server" Text="Pay To Reserve" />
                    </div>
                            <asp:HiddenField ID="resp_id" runat="server" />
                </div>
            </div>
        </div>
    

    </div>
    </div>
</asp:Content>

