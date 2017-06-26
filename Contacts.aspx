<%@ Page Title="Vacations-Abroad.com Contact Information" Language="C#" MasterPageFile="~/masterpage/mastermobile.master"
    AutoEventWireup="true" CodeFile="Contacts.aspx.cs" Inherits="Contacts" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations-Abroad.com Contact Information
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <link href="/Assets/css/staticspage.css" rel="stylesheet" />
   <style>

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
        margin-top:120px;
        padding:25px 5px;
    }
    .required{color:red;}.hidden{display:none;}
    .groupitem{margin:9px 0;}.formitem{width:90%;margin:0px 20px;} .txtarea{height:100px;}.captcha{padding:10px 0px 10px 15px;}
    .righttext{float:right;}
    .imgwraper{
        margin:0;padding:0 0 30px 0;left:0;top:0;width:100%;
        position:relative;
    }
      .background{position:relative;margin:0;}
      .back_img{width:100%; left:0;top:-0px;z-index:0;position:relative;}.back_item{z-index:10; margin:0;padding:0 0 30px 0;left:0;top:0;width:100%;position:absolute;}
        .topbox h1{display:inline;font-size:28px;margin:0;padding:0; -webkit-margin-before: 0;  -webkit-margin-after: 0; -webkit-margin-start: 0px;    -webkit-margin-end: 0px;}
        .footeritem h2{padding:0px;margin:0px;}
        @media(max-width:470px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;margin:auto;}
       .formgroup{padding-top:10px;} .footeritem{width:190px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 20px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:6pt;display:block;padding:0px;}.itemtext{font-variant:small-caps; font-size:7pt;display:block;padding:2px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}    .footerarea{float:right; margin:0 20px 0 0;  width:@00px; padding:5px; color:#5a5a5a;text-align:left;}
        .contentbox{margin-top:3px;}.margingroup{margin-top:10px;}
        .link{font-size:8pt;}
            .shidden{display:none;}

        }

        @media(max-width:560px) and (min-width:470px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;margin:auto;}
       .formgroup{padding-top:10px;} .footeritem{width:300px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 20px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:6pt;display:block;padding:0px;}.itemtext{font-variant:small-caps; font-size:7pt;display:block;padding:2px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}    .footerarea{float:right; margin:10px 20px 0 0;  width:300px; padding:5px; color:#5a5a5a;text-align:left;}
        .contentbox{margin-top:10px;}.margingroup{margin-top:10px;}
        .link{font-size:8pt;}

        }
       @media(max-width:720px) and (min-width:560px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;margin:auto;}
       .formgroup{padding-top:25px;} .footeritem{width:320px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 30px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:10pt;display:block;padding:0px;}.itemtext{font-variant:small-caps; font-size:8pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}    .footerarea{float:right; margin:5px 30px 0 0;  width:320px; padding:5px; color:#5a5a5a;text-align:left;}
        .contentbox{margin-top:10px;}.margingroup{margin-top:10px;}
       }
        @media(min-width:720px)
        {
        .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:16pt; background-color:#fff;margin:auto;}
       .formgroup{padding-top:35px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 30px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:11pt;display:block;padding:3px;}.itemtext{font-variant:small-caps; font-size:9pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 15px;border:2px solid #ff6600;width:400px;margin:auto;}
        .contentboxmargin{margin-top:30px;}    .footerarea{float:right; margin:20px 30px 0 0;  width:400px; padding:5px; color:#5a5a5a;text-align:left;}
        .contentbox{margin-top:20px;}.margingroup{margin-top:30px;}
        }
        @media(min-width:990px)
        {
        .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;margin:auto;}
       .formgroup{padding-top:50px;} .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 100px;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:12pt;display:block;padding:3px;}.itemtext{font-variant:small-caps; font-size:10pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 15px;border:2px solid #ff6600;width:400px;margin:auto;}
        .contentboxmargin{margin-top:30px;}    .footerarea{float:right; margin:20px 100px 0 0;  width:400px; padding:5px; color:#5a5a5a;text-align:left;}
        .contentbox{margin-top:20px;}.margingroup{margin-top:60px;}
         }
        @media(min-width:1200px)
        {
         .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;margin:auto;}
          .formgroup{padding-top:120px;} .footeritem{ width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:0 170px;text-align:left;}
        .itemtile{font-variant: small-caps;font-size:14pt;display:block;padding:4px;}.itemtext{font-variant:small-caps; font-size:12pt;display:block;padding:4px;}
        .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:15px 30px;border:2px solid #ff6600;width:400px;margin:auto;}
         .contentboxmargin{margin-top:30px;}
         .contentbox{margin-top:30px;} .margingroup{margin-top:60px;}
        .footerarea{float:right; margin:20px 170px 0 0;  width:400px; padding:5px; color:#5a5a5a;text-align:left;}
        }
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="bodycontent" runat="Server">
    <form id="mainform" runat="server">
        <div class="scontainer">
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
        <div class="back_item">
            <div class="srow center formgroup">
                <div class="topbox"> <h1><label class="alist" >Stay In Touch</label></h1></div>
               
            </div>
            <div class="clear"></div>
            <div class="srow margingroup righttext" >
                  <div class="footeritem">
                    <span class="itemtile">Our Mailing Address:</span>
                    <span class="itemtext">Suite G 284, 5805 State Bridge Rd.</span>
                    <span class="itemtext">Johns Creek, GA 30097</span>
                 </div>

              </div>
            <div class="srow contentbox righttext" >
                  <div class="footeritem">
                    <span class="itemtile">Our Telephone: </span>
                    <span class="itemtext">770-687-6889</span>

                 </div>

              </div>
            <div class="srow contentbox righttext" >
                  <div class="footeritem shidden">
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
            </div>
    <script defer="defer" src='https://www.google.com/recaptcha/api.js'></script>
    <script src="/assets/js/contacts.js" defer="defer"></script>
        <script src="/Assets/js/footerpage.js" defer="defer"></script>
</form>
</asp:Content>
