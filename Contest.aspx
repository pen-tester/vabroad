<%@ Page Language="C#" MasterPageFile="~/masterpage/NormalMobile.master" AutoEventWireup="true" CodeFile="Contest.aspx.cs" Inherits="Contest" %>


<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations-Abroad Valentine Giveaway! | Create Your Own Contests at ShortStack.com
</asp:Content>
<asp:Content ID="link" ContentPlaceHolderID="links" runat="server">
    <style>
        .contestbackground{background-color:#f60;margin:0px;border:0px;}
        .contestform{padding:50px 20px; background:#fff; font-weight: 300;text-decoration: none;text-transform: none;}
        .contestform h1{color: inherit;text-align: inherit;font-family: inherit;font-size: 2.5em;font-style: inherit;}
        .groupfield{margin-top:30px;}
        .contestinputfield{padding-left:10px;   display:block; margin-top:10px;margin-left:10%;width:80%;height: 2.5em;line-height: 1.42857;box-shadow: none;border:1px solid #c4ae9c;border-radius: 2px;transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;color: #39200d;font-weight: 700;}
        .contestinputfield:focus{outline: none;border-color: #ff7d26;}

        .contestbox{margin:10px auto;width:80%;text-align:left;}

          .checkbox-custom, .radio-custom {
                opacity: 0;
                position: absolute;   
            }

            .checkbox-custom, .checkbox-custom-label, .radio-custom, .radio-custom-label {
                display: inline-block;
                vertical-align: middle;
                margin: 5px;
                cursor: pointer;
            }

            .checkbox-custom-label, .radio-custom-label {
                position: relative;
            }

            .checkbox-custom + .checkbox-custom-label:before, .radio-custom + .radio-custom-label:before {
                content: '';
                background: #fff;
                border: 2px solid #ddd;
                display: inline-block;
                vertical-align: middle;
                width: 15px;
                height: 15px;
                padding: 2px;
                margin-right: 10px;
                text-align: center;
            }

            .checkbox-custom:checked + .checkbox-custom-label:before {
                content: "\f00c";
                font-family: 'FontAwesome';
                background: #fff;
                color: #000;
            }

            .radio-custom + .radio-custom-label:before {
                border-radius: 50%;
            }

            .radio-custom:checked + .radio-custom-label:before {
                content: "\f00c";
                font-family: 'FontAwesome';
                color: #bbb;
            }

            .checkbox-custom:focus + .checkbox-custom-label, .radio-custom:focus + .radio-custom-label {
              outline: 1px solid #ddd; /* focus style */
            }

            .contestbtn{
                border-radius:3px;background-color:#ff7d26;border:2px solid #cdbfac;font-size:16px;font-family:Verdana;text-align:center;
                width: 100%; padding-top:10px;padding-bottom:10px; text-transform: uppercase;   color: #fff;    cursor:pointer;   }

            .contestfooter{background-color:#cdbfac;font-size:16px; text-align:center;width:100%;color:#000; }
            .contest_footer_title{font-weight:300;font-size:1.25em;margin-bottom:10px;margin-top:30px;display:block;}
            .contest_copyright{font-weight:300;font-size:10pt;}.contest_footer_text{font-size:10pt;}
            .contestfooter ul{list-style:none; list-style-type:none; width:100%;margin:0px;}.contestfooter ul li{display:inline-block;padding:10px;} 
            .contest_result{color: #39200d;font-weight: 700;text-align: center;font-family: inherit;font-size: 2em;padding:20px;}
            .chkerror{color:red;}

            .shareicon{ display:inline-block;border:solid 1px #ff7d26; color:#ff7d26;min-width:25px;min-height:25px;font-size:16px;} .shareicon:hover{cursor:pointer;}
            .glenn {
              min-height:25px;min-width:25px;
              position: relative;
            }

            .member-glenn {
              position: absolute;
              top: 0;
              opacity: 1;
              visibility: visible;
              transition: all 0.75s ease;
            }

            .glenn:hover .member-glenn {
              visibility: hidden;
              opacity: 0;
            }                        
    </style>
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="bodycontent" runat="server">
    <div class="clearfix"></div>
    <div class="contestbackground">
        <div class="scontainer">
            <div class="srow">
               <div class="internalpagewidth">
            <% if (AuthenticationManager.IfAuthenticated && AuthenticationManager.IfAdmin)
                { %>
                <div class="contestform center" id="adminform">
                    <label>Contest Site</label>
                    <asp:TextBox ID="con_name" runat="server" placeholder="Contest Site(ex Vacations Abroad)" CssClass="contestinputfield" ></asp:TextBox>
                    <label>Contest Title</label>
                    <asp:TextBox ID="con_text" runat="server" placeholder="Contest Title(ex $200 Valentine's Day Giveaway.)" CssClass="contestinputfield" ></asp:TextBox>
                    <label>Coupon Price</label>
                    <asp:TextBox ID="con_price" runat="server" placeholder="Coupon Price$(ex 200)" CssClass="contestinputfield" ></asp:TextBox>
                    <div class="groupfield center">
                            CONTEST RULES<br />
                            Coupon is valid for <asp:TextBox ID="con_valdation" runat="server" CssClass="contestinputfield" ></asp:TextBox> months from <asp:TextBox ID="con_startdate" placeholder="2017/1/1" runat="server" CssClass="contestinputfield" ></asp:TextBox>.<br />
                           <asp:TextBox ID="con_rule" runat="server" placeholder="Contest rule" CssClass="contestinputfield" TextMode="MultiLine" Height="240px" ></asp:TextBox>
                    </div>
                    <div class="contestbox">
                        <asp:Button CssClass="contestbtn" id="AdminSubmit" Text="Submit" OnClick="AdminSubmit_Click" runat="server" ValidationGroup="adminpage"/>
                    </div>
                </div>
            <%} %>

            <div class="contestform">
                <div class="center">
                    <h1><%=cont_info.Name %></h1>
                    <h1><%=cont_info.Text %></h1>
                </div>
                <div class="center">
                    <p>Enter your contact details below for a chance to win a $200 coupon towards your next vacation with Vacations-Abroad.com</p>
                </div>
                <div class="groupfield center">
                    <asp:TextBox ID="firstname" runat="server" placeholder="FirstName" CssClass="contestinputfield"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="firstnamevalid" runat="server" ForeColor="Red" ErrorMessage="First Name required" ControlToValidate="firstname" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="lastname" runat="server" placeholder="LastName" CssClass="contestinputfield"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="lastnamevalid" runat="server" ForeColor="Red" ErrorMessage="Last Name required" ControlToValidate="lastname" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="email" runat="server" placeholder="Email" CssClass="contestinputfield"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="emailvalid" runat="server" ForeColor="Red" ErrorMessage="Email Required" ControlToValidate="email" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="emailregular" runat="server" ForeColor="Red" ErrorMessage="Email format wrong" ControlToValidate="email" Display="Dynamic" ValidationExpression="\w+@\w{1,4}\.\w{1,4}"></asp:RegularExpressionValidator>
                    <asp:TextBox ID="phonenumber" runat="server" placeholder="PhoneNumber with country code" CssClass="contestinputfield"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="phonenumberregular" runat="server" ForeColor="Red" ErrorMessage="Phone Number format wrong" ControlToValidate="phonenumber" ValidationExpression="\+\d{9,}" Display="Dynamic"></asp:RegularExpressionValidator>
                    <div class="contestbox" >
                        <div>
                            <input type="checkbox"  id="chk_rule" class="checkbox-custom" name="chk_rule"  runat="server"/>
                            <label for="bodycontent_chk_rule" class="checkbox-custom-label">I have read and agree to the official rules</label>
                            
                        </div>
                        <asp:Label ID="chkerror" runat="server" CssClass="chkerror">You have to agree the official rules</asp:Label>
                    <div>
                    <div class="contestbox">
                        <asp:Button CssClass="contestbtn" id="Submit" Text="Submit" OnClick="Submit_Click" runat="server"/>
                    </div>
                    <div class="center">
                        <asp:Label CssClass="contest_result" runat="server" ID="txt_result">Thank you for your submission</asp:Label>
                    </div>
                </div>
            </div>

        
             </div>
        
         </div>

                </div>
            </div>
        </div>
        <div class="contestfooter">
            <div class="scontainer">
                <div class="srow">
                    <div class="col-2 col-x-4"></div>
                     <div class="col-8 col-x-4">
                   <div class="srow center">
                    <label class="contest_footer_title">
                        SHARE THIS CONTEST WITH FRIENDS 
                    </label>
                </div>
                   <div class="srow center">
                        <ul class="contest_footer_share">
                            <li>
                                <div class="glenn">
                                    <div class="shareicon member-glenn">
                                    <i class="fa fa-share-alt" aria-hidden="true"></i>
                                     </div>
                                </div>
                                
                            </li>
                              <li>
                                <div class="glenn ">
                                    <div class="shareicon member-glenn">
                                    <i class="fa fa-facebook" aria-hidden="true"></i>
                                    </div>
                                </div>
                                
                            </li>
                            <li>
                                <div class="glenn">
                                    <div class="shareicon member-glenn"><i class="fa fa-twitter" aria-hidden="true"></i></div>
                                </div>
                                
                            </li>
                            <li>
                                <div class="glenn">
                                   <div class="shareicon member-glenn"> <i class="fa fa-pinterest-p" aria-hidden="true"></i></div>
                                </div>
                                
                            </li>
                            <li>
                                <div class="glenn">
                                   <div class="shareicon member-glenn"> <i class="fa fa-google-plus" aria-hidden="true"></i></div>
                                </div>
                                
                            </li>
                            <li>
                                <div class="glenn">
                                    <div class="shareicon member-glenn"><i class="fa fa-linkedin" aria-hidden="true"></i></div>
                                </div>
                                
                            </li>
                       </ul>
                </div>
                    <div class="srow center">
                        <label class="contest_copyright">
                            Copyright 2017 Vacations-Abroad.com
                        </label>
                        <hr />
                    </div>
                    <div class="srow center">
                        <h4>
                            CONTEST RULES
                        </h4>
                        <label class="contest_footer_text">
                            <% DateTime dt = DateTime.Parse(cont_info.StartDate);
                                DateTime dtend = dt.AddMonths(cont_info.ValidMonth);
                                 %>
                            Coupon is valid for <%=cont_info.ValidMonth %> months from <%=dt.ToString("MMMM dd, yyyy") %> - <%=dtend.ToString("MMMM dd, yyyy") %>.<br />
                            <%=Server.HtmlDecode(cont_info.RuleText) %>
                        </label>
                        <br />
                        <br />
                    </div>
                </div>
                 </div>
            </div>
        </div>
    </div>
    <script defer="defer" src="/Assets/js/contest.js"></script>
</asp:Content>