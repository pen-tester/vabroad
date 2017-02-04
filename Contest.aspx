<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master" AutoEventWireup="true" CodeFile="Contest.aspx.cs" Inherits="Contest" %>


<asp:Content ID="head" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="link" ContentPlaceHolderID="links" runat="server">
    <style>
        .contestbackground{background-color:#fc8c40;background-image: url("https://d2xcq4qphg1ge9.cloudfront.net/assets/19/3244482/original_grunge.png");
background-repeat: repeat;}
        .contestform{margin:50px 20px; background:#fff; padding:30px 0px;font-weight: 300;text-decoration: none;text-transform: none;}
        .contestform h1{color: inherit;text-align: inherit;font-family: inherit;font-size: 2.5em;font-style: inherit;}
        .groupfield{margin-top:30px;}
        .contestinputfield{display:block; margin-top:10px;margin-left:10%;width:80%;height: 2.5em;line-height: 1.42857;box-shadow: none;border:1px solid #c4ae9c;border-radius: 2px;transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;color: #39200d;font-weight: 700;}
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
            width: 20px;
            height: 20px;
            padding: 2px;
            margin-right: 10px;
            text-align: center;
        }

        .checkbox-custom:checked + .checkbox-custom-label:before {
            content: "\f00c";
            font-family: 'FontAwesome';
            background: rebeccapurple;
            color: #fff;
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
    </style>
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="bodycontent" runat="server">
    <div class="contestbackground">
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
                    <asp:RequiredFieldValidator ID="firstnamevalid" runat="server" ErrorMessage="First Name required" ControlToValidate="firstname" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="lastname" runat="server" placeholder="LastName" CssClass="contestinputfield"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="lastnamevalid" runat="server" ErrorMessage="Last Name required" ControlToValidate="lastname" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="email" runat="server" placeholder="Email" CssClass="contestinputfield"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="emailvalid" runat="server" ErrorMessage="Email Required" ControlToValidate="email" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="emailregular" runat="server" ErrorMessage="Email format wrong" ControlToValidate="email" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:TextBox ID="phonenumber" runat="server" placeholder="PhoneNumber 1(240)2341234" CssClass="contestinputfield"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="phonenumberregular" runat="server" ErrorMessage="Phone Number format wrong" ControlToValidate="phonenumber" Display="Dynamic"></asp:RegularExpressionValidator>
                    <div class="contestbox">
                         <asp:CheckBox ID="chk_agree_rule" runat="server" CssClass="contestchkbox" Text="I have read and agree to the official rules" />
                                <div>
            <input id="checkbox-1" class="checkbox-custom" name="checkbox-1" type="checkbox" checked>
            <label for="checkbox-1" class="checkbox-custom-label">First Choice</label>
        </div>
        <div>
            <input id="checkbox-2" class="checkbox-custom" name="checkbox-2" type="checkbox">
            <label for="checkbox-2" class="checkbox-custom-label">Second Choice</label>
        </div>
        <div>
            <input id="checkbox-3" class="checkbox-custom" name="checkbox-3" type="checkbox">
            <label for="checkbox-3"class="checkbox-custom-label">Third Choice</label>    
        </div>
                    </div>
                    
                </div>
            </div>

        </div>
    </div>
</asp:Content>