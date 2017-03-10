<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master" AutoEventWireup="true" CodeFile="SocialSignup.aspx.cs" Inherits="accounts_SocialSignup" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
<style>
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
       .form-group{margin:10px 0px;}
       .btnAction{padding:4px 10px; cursor:pointer;color:#fff;border-radius:3px;background-color:#154890;border:1px solid #cdbfac;font-size:12px;font-family:Verdana;margin:1px;text-align:center;}
</style>
</asp:Content>

<asp:Content runat="server" ID="LoginContent" ContentPlaceHolderID="bodycontent">
       
        <div id="" class="internalpage">	
               <div class="srow">
                   <div class="col-3"></div>
                   <div class="col-6">
                        <h3 class="formpaddingcont">
                            Register with Social Netwrok----
                        </h3>
                         <div class="srow">
                            <div class="form-group">
                                <label for="Email">Email</label>
                                <asp:TextBox ID="Email" runat="server" class="form-control"></asp:TextBox><asp:CustomValidator ID="CustomValidator1" OnServerValidate="EmailValidate" Display="Dynamic" runat="server" ForeColor="Red" ErrorMessage="The user used this email is existed" ControlToValidate="Email"></asp:CustomValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="Email" Display="Dynamic" ForeColor="Red" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Email Format Error"></asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ForeColor="Red" ControlToValidate="Email" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label for="LoginName">Login Name</label>
                                <asp:TextBox ID="LoginName" runat="server" class="form-control"></asp:TextBox><asp:CustomValidator ID="CustomValidator2" OnServerValidate="UsernameValidate" runat="server" ControlToValidate="LoginName" ForeColor="Red" ErrorMessage="User Name duplicated" Display="Dynamic"></asp:CustomValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Display="Dynamic" ForeColor="Red" ControlToValidate="LoginName" ValidationExpression="[0-9a-zA-Z_]+" ErrorMessage="Allowed letters, number, _"></asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="LoginName" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                <asp:HiddenField ID="hidden_id" runat="server" />
                                <asp:HiddenField ID="acctype" runat="server" />
                            </div>

                        </div>
                       <div class ="srow">
                                <div class="">
                                    <input id="showproperty" name="showproperty" type="checkbox" checked=""  runat="server"/>
                                    <label for="showproperty" class="lblCheck">
                                        I want to list a property!
                                    </label>
                                </div>
 
                       </div>

                       <div  class="srow form-group">
                            <asp:Button ID="bt_register" runat="server" class="btnAction" Text="Register" OnClick="bt_register_Click" />
                       </div>
                       
                   </div>
               </div>
    </div>






</asp:Content>
