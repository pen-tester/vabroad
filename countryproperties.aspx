<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master" AutoEventWireup="true"
    CodeFile="countryproperties.aspx.cs" Inherits="allPropertiesList" EnableEventValidation="false" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacation Properties in <%=country %>
</asp:Content>

<asp:Content ID="link" ContentPlaceHolderID="links" runat="server">
    <style>
        .imgCenter{margin:auto;}.imgwrapper{margin:auto;width:170px;text-align:left;}.scomments{display:block;}
        .topMargin{margin-top:20px;}                                                                                     
    </style>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
<form id="mainform" runat="server">
        <div class="scontainer">
    <div class="internalpagewidth">
   <asp:Label ID="Label2" runat="server" Visible="false" Text="%country% vacation Rentals, %country% Holiday Rentals, %country% Rental Accommodations"></asp:Label>
    <asp:Label ID="Title" runat="server" Visible="false" Text="Vacation Properties in %country%"></asp:Label>
    <asp:Label ID="Keywords" runat="server" Visible="false" Text="%country% apartments, %country% villas, %country% hotels, %country% B&Bs."></asp:Label>
    <asp:Label ID="Description" runat="server" Visible="false" Text="%country%  Find and Book : Apartments, Villas, Hotels and B&Bs"></asp:Label>
    <asp:TextBox runat="server" ID="txtCityVal" value="" Style="display: none;"></asp:TextBox>
    <asp:TextBox runat="server" ID="txtCityVal2" value="" Style="display: none;"></asp:TextBox>
    <input type="hidden" name="step1radio" value="" />
    <input type="hidden" name="step2radio" value="" />
    <input type="hidden" name="step3radio" value="" />
    <div class="srow">
                 <div  class="listingPagesContainer">
                        <asp:HyperLink ID="hyplnkCountryBackLink" runat="server" CssClass="backitem"><asp:Literal ID="ltrCountryBackText"  runat="server"></asp:Literal></asp:HyperLink>
                        <div class="clear"></div>
                        <h1 class="listingPagesH1Color H1CityText" style="text-align: center;position: relative; top: -5px" >
                            <asp:Literal ID="ltrH11" runat="server"></asp:Literal>
                            <br />
                        </h1>
                    </div>
    </div>
    <div class="srow">
        <div class="borerstep">
            <div class="srow">
              <div class="stepfont">
                <div class="col-1">
                   <label> Step 1:</label>
                </div>
                <div class="col-11">
                    <asp:RadioButtonList ID="rdoBedrooms" runat="server" RepeatDirection="Horizontal" RepeatColumns="6"
                                            RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="rdoBedrooms_SelectedIndexChanged"/>

                </div>
            </div>
             </div>
            <div class="srow">
            <div class="stepfont">
                <div class="col-1">
                   <label> Step 2:</label>
                </div>
                <div class="col-9">
                    <asp:RadioButtonList ID="rdoFilter" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                        <asp:ListItem>Sleeps 1-4</asp:ListItem>
                        <asp:ListItem>Sleeps 5-8</asp:ListItem>
                        <asp:ListItem>Sleeps 9+</asp:ListItem>
                        <asp:ListItem Selected="True">Display All</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-2">
                    <div>
                    <asp:Button ID="btnFilter" runat="server" Text="Search" Style="width: 117px !important;white-space: normal;white-space: normal;border-radius: 1em;
                            color: white;font-family: arial; font-size: 12px;background: #154890;cursor:pointer;font-weight: bold;height: 26px;right: 6px;top: -22px;
                                                                    
                            width: 120px;box-shadow: 2px 2px 6px #154890;border: 1px solid #154890;"
                        OnClick="btnFilter_Click" CausesValidation="False"
                        OnClientClick="$('#ctl00_Content_selectedRdoTypes').val($('.test').find('input:checked')[0].value)" />
                    </div>
                </div>
            </div>
                </div>

        </div>
    </div>

    <span id="test234" runat="server" style="display: none"></span>
        <div class="srow">

    <div>
        <div class="PurpleTable" id="allcountryproperties" runat="server"/>
        <asp:Label ID="lblInfo22" runat="server" ForeColor="Red"></asp:Label>
    </div>
        </div>



    </div>
 </div>
    <script type="text/javascript" src="/scripts/pager.js"></script>	
    <script src="/Assets/js/countryproperty.js"></script>
</form>
</asp:Content>
