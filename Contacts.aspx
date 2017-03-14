<%@ Page Title="Vacations-Abroad.com Contact Information" Language="C#" MasterPageFile="~/masterpage/mastermobile.master"
    AutoEventWireup="true" CodeFile="Contacts.aspx.cs" Inherits="Contacts" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations-Abroad.com Contact Information
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <link href="/Assets/css/staticspage.css" rel="stylesheet" />
   <style> .background{position:relative;min-height:640px;} .back_img{width:100%;}.backitem{position:absolute;margin:0;padding:0;left:0;top:0;width:100%;}
      .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;cursor:pointer;margin:auto;}
      .formgroup{margin-top:60px;} .footeritem{float:right; margin:20px 40px 0 0;  width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;text-align:left;}
    .itemtile{font-variant: small-caps;font-size:14pt;display:inline-block;padding:4px;}.itemtext{font-variant:small-caps; font-size:12pt;display:block;padding:4px;text-decoration:none;text-decoration-style:none;}
    .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:15px 30px;border:2px solid #ff6600;width:400px;margin:auto;}
    .footerarea{float:right; margin:20px 40px 0 0;  width:400px; padding:5px; color:#5a5a5a;text-align:left;}
    .btnSendEmail{border-radius:5px; border:3px solid #fff;font-size:11pt; color:#fff;padding:7px 25px;background-color:#426ebd;font-weight:bold;
                 -moz-box-shadow:
		 2px 2px 3px 3px #2f508a inset,-2px -2px 3px 3px #2f508a inset;
	-webkit-box-shadow:
		 2px 2px 3px 3px #2f508a inset,-2px -2px 3px 3px #2f508a inset;
	box-shadow: 2px 2px 3px 3px #2f508a inset,-2px -2px 3px 3px #2f508a inset;
        cursor:pointer;
    }
    .btnSendEmail:active{
           -moz-box-shadow:
		 3px 3px 3px 3px #2f508a inset,-1px -1px 3px 3px #2f508a inset;
	-webkit-box-shadow:
		 3px 3px 3px 3px #2f508a inset,-1px -1px 3px 3px #2f508a inset;
	box-shadow: 3px 3px 3px 3px #2f508a inset,-1px -1px 3px 3px #2f508a inset;
    padding:8px 24px 6px 26px;
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
        position:absolute;right:0px; top:-10px;
    }
    .emailform{
        background-color:#fafbfc;
        border:5px solid #f0b892;
        border-radius:55px;
        color:#767271;
        width:340px;
        position:relative;
        margin:auto;
        margin-top:180px;
        padding:30px;
    }
    .required{color:red;}.hidden{display:none;}
    .groupitem{margin:9px 0;}.formitem{width:90%;margin:0px 20px;} .txtarea{height:100px;}.captcha{padding:10px 0px 10px 15px;}
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="bodycontent" runat="Server">
          <div id="inquiryform" class="modalform">
              <div class="emailform">
                      <div class="modalhead">
                            <span class="mclose" id="inquriyclose">x</span>
                      </div>
                      <div>
                       <div class="srow groupitem">
                          <div class="cols-s-1">
                              Your name: <label class="required">*</label>
                          </div>
                          <div class="cols-s-2">
                              <input type="text" class="formitem" id="username" name="username" />
                          </div>
                      </div>
                      <div class="srow groupitem">
                          <div class="cols-s-1">
                              Your email: <label class="required">*</label>
                          </div>
                          <div class="cols-s-2">
                              <input type="text"  class="formitem" id="useremail" name="useremail" />
                          </div>
                      </div>
                      <div class="srow groupitem">
                          <div class="cols-s-1">
                              Telephone: 
                          </div>
                          <div class="cols-s-2">
                              <input type="text" class="formitem" id="userphone" name="userphone" />
                          </div>
                      </div>
                      <div class="srow groupitem">
                          <div class="cols-s-1">
                              Subject: 
                          </div>
                          <div class="cols-s-2">
                              <select class="formitem" id="userselect" name="userselect">
                                <option value="0">Select one</option>
                                  <option value="1">About a property</option>
                                  <option value="2">About a reservation</option>
                              </select>
                          </div>
                      </div>
                      <div class="srow groupitem">
                          <div class="cols-s-1">
                              How can we help? 
                          </div>
                          <div class="cols-s-2">
                              <textarea  class="formitem txtarea" id="usercomment" name="usercomment"></textarea>
                          </div>
                      </div>
                      <div class="srow captcha">
                        <div class="g-recaptcha" data-callback="recaptchaCallback" data-sitekey="6LeiuBcUAAAAABl8pqeeYVr_M7DwF_b-CPzKo1eJ"></div>
                      </div>
                      <div class="srow center">
                          <input type="button" id="btnsend" class="btnBookNow" style="width:90%;" value="Send Email" />
                          <input type="submit" id="btnsendback" name="btnsendback" class="hidden" runat="server" onserverclick="btnsendback_ServerClick"  />
                      </div>
                      </div>
              </div>
          </div>
          <div id="msgform" class="modalform">
                  <div id="modal_loading" class="modalLoading">
                        <div class="loader"> </div>
                  </div>
                  <div id="modal_dialog" class="dlgMsg" >
                      <div class="modalhead">
                            <span class="mclose" id="msgclose">x</span>
                      </div>
                      <div class="srow">
                          <div class="col-4">Message:</div>
                          <div class="col-8" id="modalmsg"></div>
                      </div>
                  </div>
            </div>
     <div class="background">
          <img class="back_img" src="/Assets/img/stay.jpg" />
        <div class="backitem">
            <div class="srow center formgroup">
                <div class="topbox"> <a class="alist" >Stay In Touch</a></div>
               
            </div>
            <div class="clear"></div>
            <div class="srow formgroup" >
                  <div class="footeritem">
                    <span class="itemtile">Our Mailing Address:</span>
                    <span class="itemtext">Suite G 284, 5805 State Bridge Rd.</span>
                    <span class="itemtext">Johns Creek, GA 30097</span>
                 </div>

              </div>
            <div class="srow " >
                  <div class="footeritem">
                    <span class="itemtile">Our Telephone: </span>
                    <span class="itemtext">770-687-6889</span>

                 </div>

              </div>
            <div class="srow " >
                  <div class="footeritem">
                    <span class="itemtile">Office Hours:(Eastern Time Zone)</span>
                    <span class="itemtext">Monday-Friday 8AM-8PM</span>
                    <span class="itemtext">Saturday 9AM-1PM</span>
                    <span class="itemtext">Sunday Closed</span>
                 </div>

              </div>
            <div class="srow " >
                  <div class="footerarea">
                      <input class="btnSendEmail" id="btnsendemail" type="button" value="Send Us an Email" />
                 </div>

              </div>
            <div class="clear"></div>
        </div>
    </div>
    <script defer="defer" src='https://www.google.com/recaptcha/api.js'></script>
    <script src="/assets/js/contacts.js" defer="defer"></script>
</asp:Content>
