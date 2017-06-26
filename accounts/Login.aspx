<%@ Page Language="C#" MasterPageFile="/masterpage/MasterMobile.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="accounts_Login" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Sign in
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">

    <link href="/Assets/css/customs.css" rel="stylesheet" />
   <style>
       ul.nav li{display:inline-block; } ul.nav{z-index:10}
       .nav>li>a:focus, .nav>li>a:hover{text-decoration:none; background-color:#eee;}
       .nav>li>a{cursor:pointer;background-color:#f3ede3;padding:10px 15px; border-radius:0px; box-shadow:inset 0px -8px 7px -9px rgba(0,0,0,.4),-2px -2px 5px -2px rgba(0,0,0,.4); color:#767171;}
       .nav>li.active >a, .nav>li.active>a:hover{background:#fff;border-bottom-color:transparent;box-shadow:inset 0 0 0 0 rgba(0,0,0,.4),-2px -3px 5px -2px rgba(0,0,0,.4); }
       .tab-pane.active{display:block;} .tab-pane{display:none;}
       .tabs-content{display:block;background-color:transparent;padding:0;margin-top:-4px;}
       .form-control {
            display: block;
            width: 100%;
            height: 34px;
            padding: 2px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            box-sizing:border-box;
       }
       .form-group{margin:3px 0px;}
   </style>
</asp:Content>

<asp:Content runat="server" ID="LoginContent" ContentPlaceHolderID="bodycontent">
    <form id="mainform" runat="server">
        <div class="scontainer">
    <div class="internalpage">
         <div class="srow formmargin">
             <div class="col-3"></div>
             <div class="col-6 col-x-4">	
        <ul  class="nav">
            <% if (logtype == 0)
                { %>
		    <li class="active lblFor">
                <a class="btntab" data-target="tab1"><i class="fa fa-user" aria-hidden="true"></i> Register</a>
		    </li>
		    <li class="lblFor"><a class="btntab" data-target="tab2"><i class="fa fa-sign-in" aria-hidden="true"></i> Sign In</a>
		    </li>
            <%}
            else
            { %>
		    <li class="lblFor">
                <a class="btntab" data-target="tab1"><i class="fa fa-user" aria-hidden="true"></i> Register</a>
		    </li>
		      <li class="active lblFor"><a class="btntab" data-target="tab2"><i class="fa fa-sign-in" aria-hidden="true"></i> Sign In</a>
		    </li>
            <%} %>
	     </ul>

        <div class="clearfix"></div>
        <div class="tabs-content">
			<div class="tab-pane  <%=(logtype!=0)?"active":"" %> tabback" id="tab2">
                <div class="srow">
                   <div class="col-sm-offset-1 col-sm-10 ">

                    <div class="srow">
                        <div class ="col-sm-12">
                             <button type="button" class="btnLogins" runat="server" onServerClick="btn_signinfacebook_Click" validationgroup="facebook"> <i class="fa fa-facebook-f socialchar"></i>  &nbsp;Login with Facebook</button>
                        </div>
                        
                    </div>
   

                    <div class="srow" >
                        <div class="col-sm-12">
                            <button type="button" class="btnLogins" runat="server" onServerClick="btn_signintwitter_Click" validationgroup="twitter"> <i class="fa fa-twitter socialchar"></i>   &nbsp;Login with Twitter</button>
                        </div>
                        
                    </div>

               
                    <h3 class="formpaddingcont lblOr">
                        Or---
                    </h3>
                       

                    <div class="form-group formpaddingcont">
                        <label for="usrname" class="lblFor">Email or Username</label>
                        <asp:TextBox ID="usrname" runat="server" class="form-control"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator4" ValidationGroup="signining" runat="server" ControlToValidate="usrname" Display="Dynamic" ValidationExpression="(^[0-9a-zA-Z_]+$|^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$)" ErrorMessage="Please type username or email"></asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="usrname" ErrorMessage="Required" Display="Dynamic" ForeColor="Red" ValidationGroup="signining"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group formpaddingcont">
                        <label for="pwd" class="lblFor">Password</label>
                        <asp:TextBox ID="pwd" runat="server" class="form-control" TextMode="Password"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="signining" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="pwd" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                    <asp:Button ID="btn_signin" ValidationGroup="signining" runat="server" class="btnLogin" Text="Sign In" OnClick="btn_signin_Click" />
                </div>
                   <div class="srow center">
                       <a href="/accounts/reset.aspx" >Forgot your password?</a>
                   </div>

                </div>
 

			</div>
			<div class="tab-pane <%=(logtype==0)?"active":"" %> tabback" id="tab1">
               <div class="srow">
                   <div class="col-sm-offset-1 col-sm-10 ">
                       <div class="srow">
                        <div class="col-sm-12">
                                <button type="button" class="btnLogins" runat="server" validationgroup="facebookup" onserverclick="btn_signupfacebook_Click"> <i class="fa fa-facebook-f socialchar"></i>  &nbsp;Register with Facebook</button>
                        </div>
                       </div>

                        <div class="srow">
                        <div class="col-sm-12" >
                            <button type="button" class="btnLogins" runat="server" validationgroup="twitterup" onserverclick="btn_signuptwitter_Click"> <i class="fa fa-twitter socialchar"></i>  &nbsp;Register with Twitter</button>
                        </div>
                        </div>




                        <h3 class="formpaddingcont lblOr">
                            Or---
                        </h3>
                        <div class ="srow">
                            <div class="form-group col-6 col-x-2">
                                <label for="usrname"  class="lblFor">First Name</label>
                                <asp:TextBox ID="reg_firstname" runat="server" class="form-control"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="reg_firstname" ForeColor="Red" Display="Dynamic"  ErrorMessage="Required"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Only English letters are allowed" Display="Dynamic" ControlToValidate="reg_firstname" ForeColor="Red" ValidationExpression="[a-zA-Z]+"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group  col-6 col-x-2">
                                <label for="usrname" class="lblFor">Last Name</label>
                                <asp:TextBox ID="reg_lastname" runat="server" class="form-control"></asp:TextBox><asp:RegularExpressionValidator ID="LastNameValid" runat="server" ControlToValidate="reg_lastname" ValidationExpression="[a-zA-Z]+" display="Dynamic" ForeColor="Red" ErrorMessage="Only English letters are allowed"></asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="reg_lastname" runat="server" ForeColor="Red" display="Dynamic" ErrorMessage="Last Name Required"></asp:RequiredFieldValidator>
                            </div>

                        </div>
                        <div class="srow">
                                <div class="form-group  col-sm-9">
                                <label for="Email"  class="lblFor">Email</label>
                                <asp:TextBox ID="Email" runat="server" class="form-control"></asp:TextBox><asp:CustomValidator ID="CustomValidator1" OnServerValidate="EmailValidate" Display="Dynamic" runat="server" ForeColor="Red" ErrorMessage="The user used this email is existed" ControlToValidate="Email"></asp:CustomValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="Email" Display="Dynamic" ForeColor="Red" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Email Format Error"></asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ForeColor="Red" ControlToValidate="Email" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group  col-sm-9">
                                <label for="Password"  class="lblFor">Password</label>
                                <asp:TextBox ID="Password" runat="server" class="form-control" TextMode="Password"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" ForeColor="Red" ControlToValidate="Password" runat="server" ErrorMessage="Password Required"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group formpaddingcont col-sm-9">
                                <label for="ConfirmPwd"  class="lblFor">Confirm Password</label>
                                <asp:TextBox ID="ConfirmPwd" runat="server" class="form-control" TextMode="Password"></asp:TextBox><asp:CompareValidator ID="CompareValidator1" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="Confirm Password doesn't match" ControlToValidate="Password" ControlToCompare="ConfirmPwd"></asp:CompareValidator>
                            </div>
                            <div class="form-group formpaddingcont col-sm-9">
                                <label for="LoginName"  class="lblFor">Login Name</label>
                                <asp:TextBox ID="LoginName" runat="server" class="form-control"></asp:TextBox><asp:CustomValidator ID="CustomValidator2" OnServerValidate="UsernameValidate" runat="server" ControlToValidate="LoginName" ForeColor="Red" ErrorMessage="User Name duplicated" Display="Dynamic"></asp:CustomValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Display="Dynamic" ForeColor="Red" ControlToValidate="LoginName" ValidationExpression="[0-9a-zA-Z_]+" ErrorMessage="Allowed letters, number, _"></asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="LoginName" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            </div>

                        </div>

                       <div  class="col-sm-12">
                            <asp:Button ID="bt_register" runat="server" class="btnLogin" Text="Register" OnClick="bt_register_Click" />
                       </div>
                       
                   </div>
               </div>
			</div>
      </div>

    </div>
            
         </div>
    </div>
            </div>
  <script src="/assets/js/login.js?2" defer="defer"></script>  
<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId: '226270344073919',
      autoLogAppEvents : true,
      xfbml            : true,
      version          : 'v2.9'
    });
    FB.AppEvents.logPageView();
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
</script>       
        </form>  
</asp:Content>
