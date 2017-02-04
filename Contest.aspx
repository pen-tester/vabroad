<%@ Page Language="C#" MasterPageFile="~/masterpage/NormalMobile.master" AutoEventWireup="true" CodeFile="Contest.aspx.cs" Inherits="Contest" %>


<asp:Content ID="head" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="link" ContentPlaceHolderID="links" runat="server">
    <style>
        .contestbackground{background-color:#fc8c40;background-image: url("https://d2xcq4qphg1ge9.cloudfront.net/assets/19/3244482/original_grunge.png");
background-repeat: repeat;margin:0px;border:solid 1px #fc8c40;}
        .contestform{margin:50px 20px; background:#fff; padding:30px 0px;font-weight: 300;text-decoration: none;text-transform: none;}
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

            .contestfooter{background-color:#39200d;font-size:16px; text-align:center;width:100%;color:#fff; }
            .contest_footer_title{font-weight:300; color:#fff; font-size:1.25em;margin-bottom:10px;margin-top:30px;display:block;}
            .contest_copyright{font-weight:300;font-size:10pt;}.contest_footer_text{font-size:10pt;}
            .contestfooter ul{list-style:none; list-style-type:none; width:100%;margin:0px;}.contestfooter ul li{display:inline-block;padding:25px;} 
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
                <div class="contestform" id="adminform">

                </div>
            <%} %>

            <div class="contestform">
                <div class="center">
                    <h1>Vacations Abroad</h1>
                    <h1>$200 Valentine's Day Giveaway.</h1>
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
                    <asp:RegularExpressionValidator ID="emailregular" runat="server" ForeColor="Red" ErrorMessage="Email format wrong" ControlToValidate="email" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:TextBox ID="phonenumber" runat="server" placeholder="PhoneNumber 1(240)2341234" CssClass="contestinputfield"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="phonenumberregular" runat="server" ForeColor="Red" ErrorMessage="Phone Number format wrong" ControlToValidate="phonenumber" Display="Dynamic"></asp:RegularExpressionValidator>
                    <div class="contestbox" >
                        <div>
                            <input type="checkbox"  id="chk_rule" class="checkbox-custom" name="chk_rule"  runat="server"/>
                            <label for="bodycontent_chk_rule" class="checkbox-custom-label">I have read and agree to the official rules</label>
                        </div>
                    <div>
                    <div class="contestbox">
                        <asp:Button CssClass="contestbtn" id="Submit" Text="Submit" runat="server"/>
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
                                    <div class="shareicon member-glennn">
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
                            Coupon is valid for 6 months from February 14, 2017- August 14, 2017.<br /><br />
                            Coupon can only be used for (1) purchase<br /><br />
                            You must be 21 years of age to enter the contest.<br /><br />
                            Coupon must be used on purchase of $400 or more.<br /><br />
                        </label>
                    </div>
                </div>
                 </div>
            </div>
        </div>
    </div>
    <script defer="defer" src="/Assets/js/contest.js"></script>
</asp:Content>