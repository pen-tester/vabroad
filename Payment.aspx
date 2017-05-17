<%@ Page Language="C#" MasterPageFile="/masterpage/MasterMobile.master" AutoEventWireup="true" CodeFile="Payment.aspx.cs" Inherits="userowner_Payment" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Payment
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <style>
        .siteName{font-size:16pt; font-weight:bold; font-family:Verdana;}
        .normalMargintop{margin-top:10px;}
        .location_right{text-align:right;}
        .borderpane{
            border:1px solid #ff6600;
            border-radius:3px;
            background-color:#f3ede3;
            padding:10px; margin:20px;
        }
        .table-bordered{
            border:1px solid #ddd;
            width:100%;
            background-color:#154890;
            color:#fff;
        }
        .normalTable{
            border:1px solid #ddd;
            width:100%;
            background-color:#fff;color:#000;
        }
        .tablerow{
            border:1px solid #fff;
        }
        td{text-align:center;}
        .text-right{text-align:right;}
        .smallwidth{width:45px;}
 .btnsendquote{cursor:pointer; padding:5px; border-radius:5px;color:#fff;font-family:arial;font-size:12px;background:#154890;font-weight:700;height:26px;right:6px;box-shadow:2px 2px 6px #154890;border:1px solid #154890}
                                  .btnsendquote:active{padding-top:4px;}
        .fullwidth{width:90%;}
        .margindown{margin-bottom:10px;}
        .pricebox{width:80px; display:inline-block; text-align:right;}
        .redcolor{color:#ff0000;}
    </style>
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="bodycontent" runat="server" >
        <div class="scontainer">
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
                <div class="col-6 page_hid">
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
                      <th>Property Name</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td><%=prop_info.City %> <%=prop_info.StateProvince %> <%=prop_info.Country %></td>
                      <td><%=inquiryinfo.PropertyID %></td>
                      <td><%=prop_info.Name2 %></td>
                    </tr>
                   </tbody>
                </table>
            </div>
            <div class="srow normalMargintop">
                Arrival Date:<%=DateTime.Parse(inquiryinfo.ArrivalDate).ToString("MMM d, yyyy") %>
                Currency:<%=currency_type[email_resp.CurrencyType] %> 
            </div>
            <div class="srow normalMargintop">
                <table class="normalTable">
                  <thead>
                    <tr class="tablerow">
                      <th># of Nights</th>
                      <th>Price Quote</th>
                      <th>Total Rental</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td><%=inquiryinfo.Nights %></td>
                      <td><%=BookDBProvider.DoFormat(email_resp.NightRate) %></td>
                      <td><%=BookDBProvider.DoFormat(_total_sum) %></td>
                    </tr>
                   </tbody>
                </table>
            </div>
            <div class="srow text-right normalMargintop">
                <div class="srow top_formrow">
                    Coupon Discount:<label id="cou_discount" class="pricebox">0%</label><label id="discounted_price" class="pricebox redcolor">-0.00</label>
                </div>
               <div class="srow">
                    Amount Due to Reserve Property:<label class="pricebox" id="rental_price"> <%=BookDBProvider.DoFormat(_total_sum) %></label>
                   <input type="hidden" id="totalsum" value="<%=BookDBProvider.DoFormat(_total_sum) %>" />
                </div>
                <div class="srow">
                    Amount Due to Owner upon Arrival:<label class="pricebox"><%=BookDBProvider.DoFormat(_balance) %></label>
                </div>
                <div class="srow top_formrow">
                    Total Rental Price:<label class="pricebox"  id="cou_rental_price" ><%=BookDBProvider.DoFormat(_total) %></label>
                    <input type="hidden" id="hid_total" value="<%=BookDBProvider.DoFormat(_total) %>" />
                    <input type="hidden" id="hid_sum" value="<%=_total_sum %>" />
                    <input type="hidden" id="hid_balance" value="<%=_balance %>" />

                </div>

            </div>
            <div class="srow normalMargintop">
                <div class="col-4">
                    If you have a coupon, enter it here
                </div>
                <div class="col-4">
                    <input type="text" class="fullwidth" id="coupon" name="coupon" value="<%=str_coupon %>" />
                </div>
            </div>
        </div>

        <div class="srow margindown">
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
            </div>
    <script src="/Assets/js/payment.js" defer="defer"></script>
</asp:Content>

