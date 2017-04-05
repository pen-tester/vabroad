<%@ Page Language="C#"  MasterPageFile="/masterpage/MasterMobile.master" AutoEventWireup="true" CodeFile="QuoteResponse.aspx.cs" Inherits="userowner_TravelerResponse" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Booking for Property <%=inquiryinfo.PropertyID %> in <%=countryinfo.city %>, <%=countryinfo.state %>,<%=countryinfo.country %>
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <style>
    .headertitle{
    color:#154890;
    font-family:Verdana;
    font-size:16px;
}

#headerlast{
    color:black;
    font-family:Verdana;
    font-size:16px;
}

.normaltxt{
    color:black;
    font-family:Verdana;
    font-size:12px;
}

.normalval{
    color:#154890;
    font-family:Verdana;
    font-size:12px;
}

#validnumber{
    width:40px;
}

.formborder{
    margin-top:15px;
    border:3px solid #e1d4c0;
    border-radius:3px;
    background-color:#fff;
     padding:80px;
}

.listingpadding{
    margin-top:50px;
    text-align:center;
    border:3px solid black;
    border-radius:3px;
    background-color:#f3ede3;
    padding-top:10px;
    padding-bottom:10px;    
    margin-bottom:10px;
}

.borderpane{
    text-align:center;
    border:3px solid black;
    border-radius:3px;
    background-color:#f3ede3;
    padding-top:10px;
    padding-bottom:10px;    
}

.textcenter{
    text-align:center;
}


.formmargin{
    margin-bottom:200px;
}

.tablepanel{
    padding:10px;
    margin-left:3px;
    margin-right:3px;
    border:1px solid #e1d4c0;
}

.formpadding{
    padding:20px;
}

.formcontrolmargin{
    margin-top:10px;
    margin-left:10px;
    margin-right:10px;
}

.formcommadbt{
    font-size:10px;
    font-family:Verdana;
    margin-left:1px;
    margin-right:1px;
    float:left;
}

.buttongroup{
    margin-left:4px;
}
.btgroupcontainer{
    width:400px;
    background-color:white;
    border:none;
    margin-right:0px;
    padding:0px;
}

.pagewidth{
    width:80%;
    margin-left:10%;
}

.smallwidth{ width:60px;}

.formtable{
    background-color:#fff;
}

.top_formrow { margin-top:10px; }

.tab-pane {
    background: white;
    box-shadow: 0 0 4px rgba(0,0,0,.4);
    border-radius: 0;
    padding: 10px;
}

.tabback{
    background-color:white;
    padding-top:10px;

}

.normalmargin{
    margin-left:20px;
    margin-right:20px;
}

#exTab3{
    background-color:white;
    padding:5px 5px 5px;
    margin-left:30px;
    margin-right:30px;
}

ul {
  list-style-type: none;
}

.tablerow{
    background-color:#154890;
}

.titletxt{
    font-family:Verdana;
    font-size:14px;
    font-weight:bold;
}

.normalbackground{
    padding:10px;
    background-color:#f3ede3;
}

.headerbartxt{
    color:orangered;
    font-size:16px;
    font-weight:bold;
    padding-left:20px;
}

.companyname{
    margin-top:30px;
    font-size:80px;
}

.companyname a:hover {
    text-decoration: none !important;
    color:dimgray;
}

.footermargin{

}

.dropdown-menu .sub-menu {
    left: 100%;
    position: absolute;
    top: 0;
    visibility: hidden;
    margin-top: -1px;
}

.dropdown-menu li:hover .sub-menu {
    visibility: visible;
}

.dropdown:hover .dropdown-menu {
    display: block;
}

.navigation{
    border-top:1px solid #e1d4c0;
    color:#323e4f;
}

.bottommargin{
    margin-bottom:200px;
}

.navigation ul li:hover{
    color:azure;
}
   .modalLoading{
        margin-top:270px;
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
    .form-group{margin-top:10px;} .btnsendquote{cursor:pointer; padding:5px; border-radius:5px;color:#fff;font-family:arial;font-size:12px;background:#154890;font-weight:700;height:26px;right:6px;box-shadow:2px 2px 6px #154890;border:1px solid #154890}
                                  .btnsendquote:active{padding-top:4px;}
@media only screen and (max-width:600px){
    .respformpadding{padding:5px;}
}
.pricebox{width:80px; display:inline-block; text-align:right;}
.margintop{margin-top:10px;} 
</style>
</asp:Content>
<asp:Content ID="content" ContentPlaceHolderID="bodycontent" runat="server">
        <div class="srow">
            <div class="col-2"></div>
            <div class="col-8">
                <div id="resp_form" class="formborder respformpadding" runat="server">
                    <div class="srow">
                        <div id="headertitle" class="col-8 headertitle"><a class="headertitle" href="<%=url %>">Property <%=inquiryinfo.PropertyID %> </a> in <%=countryinfo.city %>, <%=countryinfo.state %>,<%=countryinfo.country %></div>
                        <div id="headerlast" class="col-4"><span class="pull-right">Owner Response</span></div>
                    </div>

                    <div class="srow">
                        <div class="col-4">
                          <div class="form-group">
                            <label for="arrivaldate" class="normaltxt">Arrival Date</label>
                            <label id="arrivaldate" class="normalval"><%=DateTime.Parse(inquiryinfo.ArrivalDate).ToString("MMM d,yyyy") %> </label>
                          </div>
                        </div>
                    </div>

                    <div class="srow">
                        <div class="col-4">
                          <div class="form-group">
                            <label for="nights" class="normaltxt"># of Nights Requested</label><br />
                            <label id="nights" class="normalval"><%=inquiryinfo.Nights %></label>
                          </div>
                        </div>
                        <div class="col-4">
                          <div class="form-group">
                            <label for="rates" class="normaltxt">Price Quote</label><br />
                              <label id="rates" class="normalval"><%=BookDBProvider.DoFormat(email_resp.NightRate) %></label>
                          </div>
                        </div>
                        <div class="col-4">
                          <div class="form-group">
                            <label for="currency" class="normaltxt">Currency </label><br />
                            <label id="currency" class="normalval"><%=currency_type[email_resp.CurrencyType] %></label>
                          </div>
                        </div>
                    </div>

                    <div class="srow top_formrow">
                         <div class="col-4"></div>
                        <div class="col-4 col-x-2">
                            <label class="normaltxt">Total Due to Reserve</label>
                        </div>

                        <div class="col-4 col-x-2">
                            <label class="normalval pricebox" id="totalsum" runat="server"> <%=BookDBProvider.DoFormat(_total_sum) %></label>
                        </div>
                    </div>

                    <div class="srow top_formrow">
                        <div class="col-4 col-x-2">
                            <label class="normaltxt">Cleaning Fee</label>
                        </div>
                        <div class="col-x-0 col-4"></div>
                        <div class="col-4 col-x-2">
                           <label class="normalval pricebox" id="Label1" runat="server"> <%=BookDBProvider.DoFormat(email_resp.CleaningFee) %></label>

                        </div>
                    </div>

                    <div class="srow">
                        <div class="col-4">
                            <label class="normaltxt ">Security Deposit</label>
                        </div>
                        <div class="col-x-0 col-4"></div>
                        <div class="col-4">
                          <label class="normalval pricebox" id="Label2" runat="server"> <%=BookDBProvider.DoFormat(email_resp.SecurityDeposit) %></label>
                         </div>
                    </div>
    
                    <div class="srow">
                        <div class="col-4 col-x-2">
                            <label class="normaltxt">Lodging Tax</label>
                        </div>
                        <div class="col-4 col-x-2">
                               <label class="normalval " id="Label3" runat="server"> <%=BookDBProvider.DoFormat(email_resp.LoadingTax) %>%</label>
                        </div>
                        <div class="col-4">
                            <label class="normalval pricebox" id="loadingtaxval" runat="server"><%=BookDBProvider.DoFormat(_lodgingval) %></label>
                        </div>
                    </div>

                    <div class="srow">
                        <div class="col-4"></div>
                        <div class="col-4 col-x-2">
                            <label class="normaltxt">Balance Due Upon Arrival</label>
                        </div>
                        <div class="col-4 col-x-2">
                            <label class="normalval pricebox" id="Label4" runat="server"> <%=BookDBProvider.DoFormat(_balance) %></label>
                            <input type="hidden" id="hid_total" value="<%=BookDBProvider.DoFormat(_total) %>"/>
                            <input type="hidden" id="hid_sum" value="<%=_total_sum %>"/>
                            <input type="hidden" id="hid_balance" value="<%=_balance %>"/>
                        </div>
                    </div>
                <div class="srow">
                        <div class="col-4">
                        </div>
                        <div class="col-4 col-x-2">
                            Discount:
                        </div>
                        <div class="col-4 col-x-2">
                             <label class="normalval pricebox" id="cou_discount"></label>
                        </div>
                    </div>
                    <div class="srow">
                        <div class="col-4">
                        </div>
                        <div class="col-4 col-x-2">
                            Adjusted Rental Price:
                        </div>
                        <div class="col-4 col-x-2">
                            <label class="normalval pricebox" id="cou_rental_price"><%=BookDBProvider.DoFormat(_total_sum) %></label>
                        </div>
                    </div>
                    <div class="srow margintop">
                        <div class="col-6">
                            If you have a coupon, enter it here
                        </div>
                        <div class="col-6">
                            <input type="text" class="fullwidth" id="coupon" name="coupon" />
                        </div>
                    </div>

                    <div class="srow top_formrow">
                        <label class="normaltxt">Cancellation policy</label>
                    </div>

                    <div class="srow">
                        <div class="col-3 col-x-2"><label class="normaltxt">90 days prior to arrival</label></div>
                        <div class="col-3 col-x-2"> <label class="normalval pricebox" id="Label5" runat="server"> <%=BookDBProvider.DoFormat(email_resp.Cancel90) %>%</label>
                        </div>
                    </div>
                    <div class="srow">
                        <div class="col-3 col-x-2"><label class="normaltxt">60 days prior to arrival</label></div>
                        <div class="col-3 col-x-2"> <label class="normalval pricebox" id="Label6" runat="server"> <%=BookDBProvider.DoFormat(email_resp.Cancel60) %>%</label>
                        </div>
                    </div>
                    <div class="srow">
                        <div class="col-3 col-x-2"><label class="normaltxt">30 days prior to arrival</label></div>
                        <div class="col-3 col-x-2"> <label class="normalval pricebox" id="Label7" runat="server"> <%=BookDBProvider.DoFormat(email_resp.Cancel30) %>%</label>
                        </div>
                    </div>

                    <%
                        DateTime cur = DateTime.Now;
                         %>

                    <div class="srow top_formrow">
                         This offer is valid until 5:00 pm
                        30 days prior to renter’s arrival; the funds are transferred to the property owner.
                       <div class="srow">
                           <input id="chk_agree" type="checkbox"/>agree to all the terms specified above. 
                           <div class="row">
                                <asp:Label ID="errormsg" ClientIDMode="Static" runat="server" Text="" ForeColor="Red"></asp:Label>
                           </div>
                       </div>
                       <div class="srow top_formrow">
                            <input type="button" id="SendQuote" class="btnsendquote" value="Reserve this Property" />
                          <input type="hidden" name="resp_number" value="<%=respid %>" />  
                       </div>
                                                   
                    </div>


                </div>
            </div>
        </div>
    <script src="/Assets/js/quoteresp.js" defer="defer">  </script>
</asp:Content>
