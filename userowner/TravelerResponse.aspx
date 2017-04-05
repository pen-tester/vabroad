<%@ Page Language="C#"  MasterPageFile="~/masterpage/MasterMobile.master" AutoEventWireup="true" CodeFile="TravelerResponse.aspx.cs" Inherits="userowner_TravelerResponse" %>

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
    .form-group{margin-top:10px;} .btnsendquote{padding:5px; border-radius:5px;color:#fff;font-family:arial;font-size:12px;background:#154890;font-weight:700;height:26px;right:6px;box-shadow:2px 2px 6px #154890;border:1px solid #154890}
                                  .btnsendquote:active{padding-top:4px;}
    .commentbox{
        width:90%; height:140px;
    }
    </style>
</asp:Content>

<asp:Content ID="content" ContentPlaceHolderID="bodycontent" runat="server">
           <div id="msgdlg" class="modalform">
                  <div id="modal_loading" class="modalLoading">
                        <div class="loader"> </div>
                  </div>
                  <div id="modal_dialog" class="dlgMsg" >
                      <div class="modalhead">
                            <span class="mclose">x</span>
                      </div>
                      <div class="srow">
                          <div class="col-4">Message:</div>
                          <div class="col-8" id="modalmsg"></div>
                      </div>
                  </div>
            </div>
        <div class="scontainer">
        <div class="srow">
            <div class="col-2"></div>
            <div class="col-8 col-x-4">
                <div id="resp_form" class="formborder">
                    <div class="srow">
                        <div id="headertitle" class="col-8 col-x-3">Property <%=inquiryinfo.PropertyID %> in <%=countryinfo.city %>, <%=countryinfo.state %>,<%=countryinfo.country %></div>
                        <div id="headerlast" class="col-4 col-x-1"><span class="pull-right">Owner Response</span></div>
                    </div>


                    <div class="srow">
                          <div class="form-group">
                            <label for="arrivaldate" class="normaltxt">Arrival Date</label>
                            <label id="arrivaldate" class="normalval"><%=inquiryinfo.ArrivalDate %> </label>
                          </div>
                    </div>
                    <div class="srow">
                        Is your property available?
                        <select id="opt_prop">
                            <option selected="selected" value="0">Yes</option>
                            <option value="1">No</option>
                        </select>
                    </div>
                    <div class="srow" id="optform1">
                        <div class="srow">
                            <textarea id="comments" name="comments" class="normalval commentbox">

                            </textarea>
                        </div>
                        <div class="srow">
                            <input type="button" id="sendcomment" value="Send Comment" class="btnsendquote"/>
                            <asp:Button ID="sendcomments" ClientIDMode="Static" CssClass="page_hid" runat="server" OnClick="sendcomments_Click"/>
                        </div>
                    </div>
                    <div class="srow" id="optform0">
                       <div class="srow">
                            <div class="col-4">
                              <div class="form-group">
                                <label for="nights" class="normaltxt"># of Nights Requested</label><br />
                                <label id="nights" class="normalval"><%=inquiryinfo.Nights %></label>
                              </div>
                            </div>
                            <div class="col-4">
                              <div class="form-group">
                                <label for="rates" class="normaltxt">Price Quote</label>
                                  <input id="rates" name="rates" runat="server" class="normalval"/>
                              </div>
                            </div>
                            <div class="col-4">
                              <div class="form-group">
                                <label for="currency" class="normaltxt">Select Currency </label><br />
                                 <asp:DropDownList ID="currency" runat="server" ClientIDMode="Static" Width="150px">
                                     <asp:ListItem Text="USD" Value="0" Selected="True">
                                      </asp:ListItem>
                                     <asp:ListItem Text="EUR" Value="1">
                                      </asp:ListItem>
                                     <asp:ListItem Text="CAD" Value="2">
                                      </asp:ListItem>
                                     <asp:ListItem Text="GPB" Value="3">
                                      </asp:ListItem>
                                     <asp:ListItem Text="YEN" Value="4">
                                      </asp:ListItem>
                                 </asp:DropDownList>
                              </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="srow top_formrow">
                            <div class="col-4"></div>
                            <div class="col-4">
                                <label class="normaltxt">Total Due to Reserve</label>
                            </div>
                            <div class="col-4">
                                <label class="normalval" id="totalsum"> Sum of Above</label>
                            </div>
                        </div>

                        <div class="srow top_formrow">
                            <div class="col-4 col-x-2">
                                <label class="normaltxt">Cleaning Fee</label>
                            </div>
                            <div class="col-4 col-x-0"></div>
                            <div class="col-4 col-x-2">
                                <input type="text" runat="server" id="cleaningfee" name="cleaningfee" class="normalval" />
                            </div>
                        </div>

                        <div class="srow top_formrow">
                            <div class="col-4">
                                <label class="normaltxt">Security Deposit</label>
                            </div>
                            <div class="col-4 col-x-0"></div>
                            <div class="col-4 col-x-2">
                                <input type="text" runat="server" id="secdeposit" name="secdeposit"  class="normalval"/>
                             </div>
                        </div>

                        <div class="srow top_formrow">
                            <div class="col-4 col-x-2">
                                <label class="normaltxt">Lodging Tax</label>
                            </div>
                            <div class="col-4 col-x-2">
                                <input type="text" runat="server" id="loadingtax" name="loadingtax"  class="normalval smallwidth"/>%
                            </div>
                            <div class="col-4">
                                <label class="normaltxt" id="loadingtaxval"  >(Rate % x Price Quote)</label>
                            </div>
                        </div>

                        <div class="srow top_formrow">
                            <div class="col-4"></div>
                            <div class="col-4">
                                <label class="normaltxt">Balance Due Upon Arrival</label>
                            </div>
                            <div class="col-4">
                                <input type="text" id="balance" name="balance" readonly="true" class="normalval" value="Cleaning Fee + Sec Deposit + Lodging Tax" />
                            </div>
                        </div>

                        <div class="srow top_formrow">
                            <label class="normaltxt">Cancellation policy</label>
                        </div>

                        <div class="srow top_formrow">
                            <div class="col-3"><label class="normaltxt">90 days prior to arrival</label></div>
                            <div class="col-5">
                                <input type="text" runat="server" id="cancel90" class="normalval smallwidth" name="cancel90" />%
                            </div>
                        </div>
                        <div class="srow top_formrow">
                            <div class="col-3"><label class="normaltxt">60 days prior to arrival</label></div>
                            <div class="col-5">
                                 <input type="text" runat="server" id="cancel60" class="normalval smallwidth" name="cancel60" />%
                            </div>
                        </div>
                        <div class="srow top_formrow">
                            <div class="col-3"><label class="normaltxt">30 days prior to arrival</label></div>
                            <div class="col-5">
                                 <input type="text" runat="server" id="cancel30" class="normalval smallwidth" name="cancel30" />%
                            </div>
                        </div>

                        <%
                            DateTime cur = DateTime.Now;
                             %>

                        <div class="srow top_formrow">
                            This offer is valid for <input type="text"  id="validnumber" name="validnumber" runat="server" class="normalval smallwidth" /> days from <%=cur.ToString("MM/dd/yyyy") %>.<br />
                            30 days prior to renter’s arrival; the funds are transferred to the property owner.

                        </div>
                        <div class="srow top_formrow">
                            <div class="col-3"><label class="normaltxt">Message</label></div>
                            <div class="col-9"><textarea id="comment" name="comment" runat="server" class="normalval commentbox"></textarea></div>
                        </div>
                        <br />
                        <input type="button" id="btnsend" class="btnsendquote" value="Send Quote to Traveler"  />
                        <asp:button ID="sendquote" ClientIDMode="Static" CssClass="page_hid" runat="server" OnClick="SendQuote_Click" />
                    </div>
 
                </div>
            </div>
        </div>
    </div>
    <script defer="defer" src="/Assets/js/traveler.js"></script>
</asp:Content>
