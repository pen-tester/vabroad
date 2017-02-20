<%@ Page Language="C#"  MasterPageFile="~/masterpage/NormalMaster.master" AutoEventWireup="true" CodeFile="TravelerResponse.aspx.cs" Inherits="userowner_TravelerResponse" %>

<asp:Content ID="title" ContentPlaceHolderID="head" runat="server">
    Response
</asp:Content>

<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <style>
#headertitle{
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
     padding:50px;
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

.top_formrow { margin-top:20px; }

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
.formtxtbox{
    display:inline-block;width:100%;height:34px;padding:6px 12px;font-size:14px;line-height:1.42857143;color:#555;background-color:#fff;background-image:none;border:1px solid #ccc;border-radius:4px;-webkit-box-shadow:inset 0 1px 1px rgba(0,0,0,.075);box-shadow:inset 0 1px 1px rgba(0,0,0,.075);-webkit-transition:border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;-o-transition:border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition:border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}

    </style>
</asp:Content>

<asp:Content ID="content" ContentPlaceHolderID="bodycontent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-offset-3 col-md-6">
                <div id="resp_form" class="formborder">
                    <div class="row">
                        <div id="headertitle" class="col-md-6">Property <%=inquiryinfo.PropertyID %> in <%=countryinfo.city %>, <%=countryinfo.state %>,<%=countryinfo.country %></div>
                        <div id="headerlast" class="col-md-6"><span class="pull-right">Owner Response</span></div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                          <div class="form-group">
                            <label for="arrivaldate" class="normaltxt">Arrival Date</label>
                            <label id="arrivaldate" class="normalval"><%=inquiryinfo.ArrivalDate %> </label>
                          </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                          <div class="form-group">
                            <label for="nights" class="normaltxt"># of Nights Requested</label>
                            <label id="nights" class="normalval"><%=inquiryinfo.Nights %></label>
                          </div>
                        </div>
                        <div class="col-md-4">
                          <div class="form-group">
                            <label for="rates" class="normaltxt">Price Quote Nightly Rates</label>
                              <asp:TextBox ID="rates" ClientIDMode="Static" CssClass="normalval" runat="server" OnTextChanged="rates_TextChanged" AutoPostBack="true"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="req_rate" ControlToValidate="rates" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>
                              <asp:RegularExpressionValidator ID="reg_rate" runat="server" ControlToValidate="rates" Display="Dynamic" ValidationExpression="\d+(\.\d+)?" ErrorMessage="Only Number allowed"></asp:RegularExpressionValidator>
                          </div>
                        </div>
                        <div class="col-md-4">
                          <div class="form-group">
                            <label for="currency" class="normaltxt">Select Currency </label>
                             <asp:DropDownList ID="currency" runat="server" CssClass="formtxtbox" ClientIDMode="Static">
                                 <asp:ListItem Text="USD" Value="0" Selected="True">
                                  </asp:ListItem>
                                 <asp:ListItem Text="Euro" Value="1">
                                  </asp:ListItem>
                                 <asp:ListItem Text="CAD" Value="2">
                                  </asp:ListItem>
                                 <asp:ListItem Text="GPB" Value="3">
                                  </asp:ListItem>
                                 <asp:ListItem Text="AUD" Value="4">
                                  </asp:ListItem>
                             </asp:DropDownList>
                          </div>
                        </div>
                    </div>

                    <div class="row top_formrow">
                        <div class="col-md-4 col-md-offset-4">
                            <label class="normaltxt">Total Due to Reserve</label>
                        </div>
                        <div class="col-md-4">
                            <label class="normalval" id="totalsum" runat="server"> Sum of Above</label>
                        </div>
                    </div>

                    <div class="row top_formrow">
                        <div class="col-md-4">
                            <label class="normaltxt">Cleaning Fee</label>
                        </div>
                        <div class="col-md-4 col-md-offset-4">
                            <asp:TextBox ID="cleaningfee" runat="server" ClientIDMode="Static"  AutoPostBack="true" OnTextChanged="rates_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="req_cleanfee" ControlToValidate="cleaningfee" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="reg_cleanfee" runat="server" ControlToValidate="cleaningfee" Display="Dynamic" ValidationExpression="\d+(\.\d+)?" ErrorMessage="Only Number allowed"></asp:RegularExpressionValidator>

                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <label class="normaltxt">Security Deposit</label>
                        </div>
                        <div class="col-md-4 col-md-offset-4">
                            <asp:TextBox ID="secdeposit" runat="server" ClientIDMode="Static" AutoPostBack="true" OnTextChanged="rates_TextChanged"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="req_secd" ControlToValidate="secdeposit" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="reg_secd" runat="server" ControlToValidate="secdeposit" Display="Dynamic" ValidationExpression="\d+(\.\d+)?" ErrorMessage="Only Number allowed"></asp:RegularExpressionValidator>

                         </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <label class="normaltxt">Lodging Tax</label>
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="loadingtax" runat="server" Width="90px" ClientIDMode="Static" AutoPostBack="true" OnTextChanged="rates_TextChanged"></asp:TextBox>%
                             <asp:RequiredFieldValidator ID="req_load" ControlToValidate="loadingtax" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="reg_load" runat="server" ControlToValidate="loadingtax" Display="Dynamic" ValidationExpression="\d+(\.\d+)?" ErrorMessage="Only Number allowed"></asp:RegularExpressionValidator>

                        </div>
                        <div class="col-md-4">
                            <label class="normaltxt" id="loadingtaxval" runat="server">(Rate % x Price Quote)</label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 col-md-offset-4">
                            <label class="normaltxt">Balance Due Upon Arrival</label>
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox CssClass="normalval" ID="balance" runat="server" ClientIDMode="Static" ReadOnly="true">Cleaning Fee + Sec Deposit + Lodging Tax</asp:TextBox>
                        </div>
                    </div>

                    <div class="row top_formrow">
                        <label class="normaltxt">Cancellation policy</label>
                    </div>

                    <div class="row">
                        <div class="col-md-3"><label class="normaltxt">90 days prior to arrival</label></div>
                        <div class="col-md-5"> <asp:TextBox ID="cancel90" Width="90px"  CssClass="normalval" ClientIDMode="Static" runat="server"></asp:TextBox>%
                             <asp:RequiredFieldValidator ID="req_90" ControlToValidate="cancel90" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="reg_90" runat="server" ControlToValidate="cancel90" Display="Dynamic" ValidationExpression="\d+(\.\d+)?" ErrorMessage="Only Number allowed"></asp:RegularExpressionValidator>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3"><label class="normaltxt">60 days prior to arrival</label></div>
                        <div class="col-md-5"> <asp:TextBox ID="cancel60" Width="90px" CssClass="normalval" ClientIDMode="Static" runat="server"></asp:TextBox>%
                            <asp:RequiredFieldValidator ID="req_60" ControlToValidate="cancel60" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="reg_60" runat="server" ControlToValidate="cancel60" Display="Dynamic" ValidationExpression="\d+(\.\d+)?" ErrorMessage="Only Number allowed"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3"><label class="normaltxt">30 days prior to arrival</label></div>
                        <div class="col-md-5"> <asp:TextBox ID="cancel30" Width="90px" CssClass="normalval" ClientIDMode="Static" runat="server"></asp:TextBox>%
                            <asp:RequiredFieldValidator ID="req_30" ControlToValidate="cancel30" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="reg_30" runat="server" ControlToValidate="cancel30" Display="Dynamic" ValidationExpression="\d+(\.\d+)?" ErrorMessage="Only Number allowed"></asp:RegularExpressionValidator>

                        </div>
                    </div>

                    <%
                        DateTime cur = DateTime.Now;
                         %>

                    <div class="row top_formrow">
                        This offer is valid for <input type="text"  id="validnumber" name="validnumber" runat="server" class="normalval smallwidth" /> days from <%=cur.ToString("MM/dd/yyyy") %>.<br />
                        30 days prior to renter’s arrival; the funds are transferred to the property owner.
                            <asp:RequiredFieldValidator ID="req_val" ControlToValidate="validnumber" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="reg_val" runat="server" ControlToValidate="validnumber" Display="Dynamic" ValidationExpression="\d+" ErrorMessage="Only Number allowed"></asp:RegularExpressionValidator>

                    </div>

                    <asp:Button ID="SendQuote" CssClass="btn btn-primary" runat="server" Text="Send Quote to Traveler" OnClick="SendQuote_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
