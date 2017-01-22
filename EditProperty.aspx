<%@ Page Language="C#" MasterPageFile="~/masterpage/NormalMaster.master" AutoEventWireup="true" CodeFile="~/EditProperty.aspx.cs" Inherits="EditProperty" Title="Edit Property" ValidateRequest="false" EnableEventValidation="false" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Edit Property
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <link href="/Assets/css/editproperty.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
    <div class="internalpagewidth">
        <div class="newline">
    <div id="divJS" runat="server">
    </div>
    <div class="left">
        <% if (BackLink.Visible)
           { %>
        <table bgcolor="#e4e4af" cellspacing="0" cellpadding="0" width="250" align="center"
            border="2">
            <tr>
                <td>
                    <div align="center">
                        <strong>
                            <asp:HyperLink ID="BackLink" runat="server" NavigateUrl="Listings.aspx">
							Return to My Account page
                            </asp:HyperLink>
                        </strong>
                    </div>
                </td>
            </tr>
        </table>
        <asp:Label ID="lblInfo" runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
        <br />
        <% } %>
        <div class="frmEditProp">
            <table border="2" cellspacing="0" bordercolor="#6699cc" bgcolor="#ececd9">
                <tr>
                    <td>
                        <label id="val"></label>
                        <input type="hidden" id="Latitude" name="Latitude" />
                        <input type="hidden" id="Longitude" name="Longitude" />
                        <asp:HiddenField runat="server" ID="hdnLongitude" />
                        <asp:HiddenField runat="server" ID="hdnLatitude" />

                    </td>
                </tr>
                <tr style="margin-top: 50px">
                    <td bgcolor="#ffffff">Property Name</td>
                    <td>
                        <asp:TextBox ID="txtPropName" runat="server" Width="480px" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].Name2", "{0}") %>'></asp:TextBox><font size="-1"><font color="#ff0000">(Required, 30 Char. Max)</font></font>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server"
                            ErrorMessage="Please enter property name" ControlToValidate="txtPropName"
                            SetFocusOnError="True">Please enter property name</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server"
                            ErrorMessage="Property name only allowed 30 characters."
                            ControlToValidate="txtPropName" Display="Dynamic" SetFocusOnError="True"
                            ValidationExpression=".{1,30}">Property name only allowed 30 characters.</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Write sentence describing your property</td>
                    <td>
                        <asp:TextBox ID="PropertyName" TabIndex="8" runat="server" MaxLength="300" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].Name", "{0}") %>'
                            Width="480px" />
                        <font size="-1"><font color="#ff0000">(Required)</font></font>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"
                            ControlToValidate="PropertyName" ErrorMessage="Please enter property name" SetFocusOnError="True" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic"
                            ControlToValidate="PropertyName" ErrorMessage="Too long property name entered"
                            ValidationExpression=".{1,300}" SetFocusOnError="True" />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Virtual Tours
                    </td>
                    <td>
                        <asp:TextBox ID="VirtualTour" TabIndex="8" runat="server" MaxLength="300" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].VirtualTour", "{0}") %>'
                            Width="480px" />
                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator8" runat="server" Display="Dynamic"
                            ControlToValidate="VirtualTour" ErrorMessage="Too long virtual tour entered"
                            ValidationExpression="^[\s\S]{1,300}$" SetFocusOnError="True" />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Property Type
                    </td>
                    <td>
                        <select id="PrimaryType" name="PrimaryType" onchange="setPropertyDropDown();" style="width: 200px"></select>
                        <select id="PropertyType" name="PropertyType" onchange="PropertyTypeChanged(this.selectedIndex)" style="width: 500px"></select>
                        <br />
                        <input id="PropertyTypeNew" name="PropertyTypeNew" type="text" onchange="PropertyTypeChanged(this.selectedIndex)" style="width: 500px" />
                        <%--<asp:TextBox ID="PropertyTypeNew" TabIndex="8" runat="server" MaxLength="400" Width="480px" />--%>
                        <font size="-1"><font color="#ff0000">(Required)</font></font>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Display="Dynamic"
					ControlToValidate="PropertyTypeNew" ErrorMessage="Please enter property type" />
				<asp:RegularExpressionValidator ID="Regularexpressionvalidator13" runat="server"
					Display="Dynamic" ControlToValidate="PropertyTypeNew" ErrorMessage="Too long property type entered"
					ValidationExpression="^[\s\S]{1,300}$" />--%>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Location
                    </td>
                    <td>


                        <fieldset style="width: 90%">
                            <legend style="color: Red;"><strong>Required</strong></legend>
                            <%--<p>--%>
                            <%--<form name="test" method="POST" action="processingpage.php">--%>
                            <table width="100%">
                                <tr>
                                    <td style="text-align: left;">Region:</td>
                                    <td style="text-align: left;" colspan="2">
                                        <select name="region" id="region" onchange="setCountries();" style="width: 150px">
                                            <option value="1">Africa</option>
                                            <option value="2">Asia</option>
                                            <option value="4">Caribbean</option>
                                            <option value="5">Central America</option>
                                            <option value="6">Europe</option>
                                            <option value="7">Middle East</option>
                                            <option value="8">North America</option>
                                            <option value="3">Oceania</option>
                                            <option value="9">South America</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left;">Country:</td>
                                    <td style="text-align: left;" colspan="2">
                                        <asp:HiddenField runat="server" ID="hdnCountry" />
                                        <select name="country" id="country" onchange="setStates();GetText(this,'Country');" style="width: 150px">
                                            <option value="">Please select a Region</option>

                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left;">State:</td>
                                    <td style="text-align: left; width: 150px">
                                        <asp:HiddenField runat="server" ID="hdnState" />
                                        <select name="state" id="state" onchange="setCounty();GetText(this,'State');" style="width: 150px">
                                            <option value="">Please select a Region</option>

                                        </select>
                                    </td>
                                    <td style="text-align: left;">
                                        <asp:Label ID="lblCounty" runat="server" Text="County:"></asp:Label><select name="county" id="county" onchange="setCities();" style="width: 200px">
                                            <option value="">Please select a County</option>
                                        </select>
                                    </td>

                                </tr>
                                <tr>
                                    <td style="text-align: left;" valign="top">City:</td>
                                    <td style="text-align: left;" colspan="2">
                                        <asp:HiddenField runat="server" ID="hdcity" />
                                        <select name="city" id="city" onchange="editCities();GetLocation();" style="width: 150px">
                                            <option value="0">Please select a Region</option>
                                        </select><br />
                                        <asp:TextBox ID="CityNew" TabIndex="8" runat="server" MaxLength="300" Width="300px" onBlur="GetLocation();" />
                                    </td>
                                </tr>
                            </table>
                            <asp:Label ID="LocationError" runat="server" ForeColor="Red" Visible="False">Please select region, country, state/province and city</asp:Label>
                            <%--</form>--%>
                        </fieldset>





                        <%--<select id="Region" name="Region" onchange="RegionChanged (this.selectedIndex)" style="width: 137px"></select>
				<font size="-1"><font color="#ff0000">(Required)</font></font>--%>
                    </td>
                </tr>



                <tr>
                    <td bgcolor="#ffffff">Address
                    </td>
                    <td>
                        <asp:TextBox ID="AddressLocation" TabIndex="8" runat="server" MaxLength="300" Width="480px"
                            Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].Address", "{0}") %>' />
                        <font size="-1"><font color="#ff0000">(Required)</font></font>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic"
                            ControlToValidate="AddressLocation"
                            ErrorMessage="Please enter an address for this property. See Line 8 above."
                            SetFocusOnError="True" />
                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator14" runat="server"
                            Display="Dynamic" ControlToValidate="AddressLocation" ErrorMessage="Too long address or location entered"
                            ValidationExpression="^[\s\S]{1,300}$" SetFocusOnError="True" />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Display Address?
                    </td>
                    <td>
                        <asp:DropDownList ID="ShowAddress" runat="server" Width="64px" SelectedValue='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].IfShowAddress", "{0}") %>'
                            Height="24px">
                            <asp:ListItem Value="True" Selected="True">Yes</asp:ListItem>
                            <asp:ListItem Value="False">No</asp:ListItem>
                        </asp:DropDownList>
                        <font size="-1"><font color="#ff0000">(Required)</font></font>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Number of Bedrooms
                    </td>
                    <td>
                        <asp:TextBox ID="NumBedrooms" TabIndex="8" runat="server" MaxLength="30" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].NumBedrooms", "{0}") %>'
                            Width="64px" />
                        <font size="-1" color="#ff0000">(Whole Numbers Required Example 1, 2 etc)</font>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Width="152px"
                            Display="Dynamic" ControlToValidate="NumBedrooms" ErrorMessage="You must use whole numbers for number of Bedrooms."
                            ValidationExpression="^[0-9]{1,30}$" Height="16px">You must use whole numbers for number of Bedrooms.</asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic"
                            ControlToValidate="NumBedrooms" ErrorMessage="Please enter number of bedrooms">Please enter number of bedrooms</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Number of Bathrooms
                    </td>
                    <td>
                        <asp:TextBox ID="NumBaths" TabIndex="8" runat="server" MaxLength="30" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].NumBaths", "{0}") %>'
                            Width="64px" />
                        <font size="-1" color="#ff0000">(Whole Numbers Required Example 1, 2 etc)</font>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" Width="152px"
                            Display="Dynamic" ControlToValidate="NumBaths" ErrorMessage="You must use whole numbers for number of Baths."
                            ValidationExpression="^[0-9]{1,30}$" Height="16px" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" Display="Dynamic"
                            ControlToValidate="NumBaths" ErrorMessage="Please enter number of baths" />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Sleeps Number
                    </td>
                    <td>
                        <asp:TextBox ID="NumSleeps" TabIndex="8" runat="server" MaxLength="30" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].NumSleeps", "{0}") %>'
                            Width="64px" />
                        <font size="-1" color="#ff0000">(Whole Numbers Required Example 1, 2 etc)</font>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" Width="152px"
                            Display="Dynamic" ControlToValidate="NumSleeps" ErrorMessage="You must use whole numbers for number of Sleeps."
                            ValidationExpression="^[0-9]{1,30}$" Height="16px" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" Display="Dynamic"
                            ControlToValidate="NumSleeps" ErrorMessage="Please enter number of sleeps" />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Minimum Nightly Rental
                    </td>
                    <td>
                        <asp:DropDownList ID="MinimumNightlyRental" runat="server" Width="168px" DataSource='<%# MinimumNightlyRentalTypesSet %>'
                            DataMember="MinimumNightlyRentalTypes" DataTextField="Name" DataValueField="ID"
                            DataTextFormatString="{0}" SelectedValue='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].MinimumNightlyRentalID", "{0}") %>'
                            Height="24px">
                        </asp:DropDownList>
                        <font size="-1"><font color="#ff0000">(Required)</font></font>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Number of TVs
                    </td>
                    <td>
                        <asp:TextBox ID="NumTVs" TabIndex="8" runat="server" MaxLength="30" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].NumTVs", "{0}") %>'
                            Width="64px" />
                        <font size="-1" color="#ff0000">(Whole Numbers Required Example 1, 2 etc)</font>
                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator1" runat="server" Width="152px"
                            Display="Dynamic" ControlToValidate="NumTVs" ErrorMessage="Please enter number here"
                            ValidationExpression="^[0-9]{1,30}$" Height="16px" />
                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator2" runat="server" Display="Dynamic"
                            ControlToValidate="NumTVs" ErrorMessage="Please enter number of TVs" />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Number of VCRs
                    </td>
                    <td>
                        <asp:TextBox ID="NumVCRs" TabIndex="8" runat="server" MaxLength="30" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].NumVCRs", "{0}") %>'
                            Width="64px" />
                        <font size="-1" color="#ff0000">(Whole Numbers Required Example 1, 2 etc)</font>
                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator6" runat="server" Width="152px"
                            Display="Dynamic" ControlToValidate="NumVCRs" ErrorMessage="Please enter number here"
                            ValidationExpression="^[0-9]{1,30}$" Height="16px" />
                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator5" runat="server" Display="Dynamic"
                            ControlToValidate="NumVCRs" ErrorMessage="Please enter number of VCRs" />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff">Number of CD Players
                    </td>
                    <td>
                        <asp:TextBox ID="NumCDPlayers" TabIndex="8" runat="server" MaxLength="30" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].NumCDPlayers", "{0}") %>'
                            Width="64px" />
                        <font size="-1" color="#ff0000">(Whole Numbers Required Example 1, 2 etc)</font>
                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator7" runat="server" Width="152px"
                            Display="Dynamic" ControlToValidate="NumCDPlayers" ErrorMessage="Please enter number here"
                            ValidationExpression="^[0-9]{1,30}$" Height="16px" />
                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator6" runat="server" Display="Dynamic"
                            ControlToValidate="NumCDPlayers" ErrorMessage="Please enter number of CD players" />
                    </td>
                </tr>
                <tr align="left" valign="top">
                    <td bgcolor="#ffffff">Amenities on site or nearby</td>
                    <td>
                        <asp:CheckBoxList ID="AmenitiesList" style=" display:block;" runat="server" DataTextFormatString="{0}" DataValueField="ID"
                            DataTextField="Amenity" DataMember="Amenities" DataSource='<%# AmenitiesSet %>'
                            RepeatColumns="5" RepeatDirection="Horizontal">
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align:top; background-color:#fff;">
                        <font size="4"><b>Description: </b></font>
                        <br />
                        <font size="2">In order for your listing to be saved, you must click on the button "Next
					Step" at the bottom of the page. </font>
                    </td>
                    <td>
                        <asp:TextBox ID="Description" TabIndex="8" runat="server" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].Description", "{0}") %>'
                            Width="600px" Height="100px" TextMode="MultiLine" />
                        <br />

                        <em><b>Please enter a summary description of your property. Your description must be unique and should not contain text from your personal website as duplicate content will harm your personal website in the search engine rankings. </b></em>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align:top; background-color:#fff;">
                        <font size="4"><b>Amenities: </b></font>
                        <br />
                        <font size="2">In order for your listing to be saved, you must click on the button "Next
					Step" at the bottom of the page. </font>
                    </td>
                    <td>
                        <asp:TextBox ID="Amenities" TabIndex="8" runat="server" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].Amenities", "{0}") %>'
                            Width="600px" Height="100px" TextMode="MultiLine" />
                        <br />

                        <font size="-1"><em><b></b></em></font><font size="-1"><em><b>Please enter original text describing your property
					amenities. DO NOT COPY TEXT FROM YOUR WEBSITE </b></em></font>
                        <hr style="width:50%;">
                        <font size="-1"><em><b>The table below allows you to enter the sleeping arrangements
					and furniture for each bedroom.
					<br />
                        Click to Activate each room, also enter the title. </b></em></font>
                        <br />
                        <table width="85%" border="1" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
                            <tr bgcolor="#dbe7f2">
                                <td width="20%">Room A -
							<asp:CheckBox ID="RoomAActive" runat="server" Text="Click to Activate"></asp:CheckBox>
                                </td>
                                <td width="20%">Room B -
							<asp:CheckBox ID="RoomBActive" runat="server" Text="Click to Activate"></asp:CheckBox>
                                </td>
                                <td width="20%">Room C -
							<asp:CheckBox ID="RoomCActive" runat="server" Text="Click to Activate"></asp:CheckBox>
                                </td>
                                <td width="20%">Room D -
							<asp:CheckBox ID="RoomDActive" runat="server" Text="Click to Activate"></asp:CheckBox>
                                </td>
                                <td width="20%">Room E -
							<asp:CheckBox ID="RoomEActive" runat="server" Text="Click to Activate"></asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">Title:
							<asp:TextBox ID="RoomATitle" TabIndex="8" runat="server" MaxLength="300" Width="100px" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="Regularexpressionvalidator21" runat="server"
                                        Display="Dynamic" ControlToValidate="RoomATitle" ErrorMessage="Your room A title has too many characters. Please return and delete some text."
                                        ValidationExpression="^[\s\S]{1,300}$" />
                                </td>
                                <td valign="top">Title:
							<asp:TextBox ID="RoomBTitle" TabIndex="8" runat="server" MaxLength="50" Width="100px" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="Regularexpressionvalidator22" runat="server"
                                        Display="Dynamic" ControlToValidate="RoomBTitle" ErrorMessage="Your room B title has too many characters. Please return and delete some text."
                                        ValidationExpression="^[\s\S]{1,300}$" />
                                </td>
                                <td valign="top">Title:
							<asp:TextBox ID="RoomCTitle" TabIndex="8" runat="server" MaxLength="50" Width="100px" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="Regularexpressionvalidator23" runat="server"
                                        Display="Dynamic" ControlToValidate="RoomCTitle" ErrorMessage="Your room C title has too many characters. Please return and delete some text."
                                        ValidationExpression="^[\s\S]{1,300}$" />
                                </td>
                                <td valign="top">Title:
							<asp:TextBox ID="RoomDTitle" TabIndex="8" runat="server" MaxLength="50" Width="100px" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="Regularexpressionvalidator24" runat="server"
                                        Display="Dynamic" ControlToValidate="RoomDTitle" ErrorMessage="Your room D title has too many characters. Please return and delete some text."
                                        ValidationExpression="^[\s\S]{1,300}$" />
                                </td>
                                <td>Title:
							<asp:TextBox ID="RoomETitle" TabIndex="8" runat="server" MaxLength="50" Width="100px" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="Regularexpressionvalidator25" runat="server"
                                        Display="Dynamic" ControlToValidate="RoomETitle" ErrorMessage="Your room E title has too many characters. Please return and delete some text."
                                        ValidationExpression="^[\s\S]{1,300}$" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBoxList ID="RoomAList" runat="server" DataTextFormatString="{0}" DataValueField="ID"
                                        DataTextField="FurnitureItem" DataMember="FurnitureItems" DataSource='<%# FurnitureItemsSet %>'
                                        RepeatColumns="1" RepeatDirection="Horizontal">
                                    </asp:CheckBoxList>
                                </td>
                                <td>
                                    <asp:CheckBoxList ID="RoomBList" runat="server" DataTextFormatString="{0}" DataValueField="ID"
                                        DataTextField="FurnitureItem" DataMember="FurnitureItems" DataSource='<%# FurnitureItemsSet %>'
                                        RepeatColumns="1" RepeatDirection="Horizontal">
                                    </asp:CheckBoxList>
                                </td>
                                <td>
                                    <asp:CheckBoxList ID="RoomCList" runat="server" DataTextFormatString="{0}" DataValueField="ID"
                                        DataTextField="FurnitureItem" DataMember="FurnitureItems" DataSource='<%# FurnitureItemsSet %>'
                                        RepeatColumns="1" RepeatDirection="Horizontal">
                                    </asp:CheckBoxList>
                                </td>
                                <td>
                                    <asp:CheckBoxList ID="RoomDList" runat="server" DataTextFormatString="{0}" DataValueField="ID"
                                        DataTextField="FurnitureItem" DataMember="FurnitureItems" DataSource='<%# FurnitureItemsSet %>'
                                        RepeatColumns="1" RepeatDirection="Horizontal">
                                    </asp:CheckBoxList>
                                </td>
                                <td>
                                    <asp:CheckBoxList ID="RoomEList" runat="server" DataTextFormatString="{0}" DataValueField="ID"
                                        DataTextField="FurnitureItem" DataMember="FurnitureItems" DataSource='<%# FurnitureItemsSet %>'
                                        RepeatColumns="1" RepeatDirection="Horizontal">
                                    </asp:CheckBoxList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align:top; background-color:#fff;">
                        <font size="4"><b>Local Attractions and Activities: </b></font>
                        <br />
                        <font size="2">In order for your listing to be saved, you must click on the button "Next
					Step" at the bottom of the page. </font>
                    </td>
                    <td>
                        <asp:TextBox ID="LocalAttractions" TabIndex="8" runat="server" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].LocalAttractions", "{0}") %>'
                            Width="600px" Height="100px" TextMode="MultiLine" />

                        <br />
                        <font size="-1"><em><b>Please enter unique and original text to describe the local activities
					above... </b></em></font>
                        <br />
                        <hr  style="width:50%;"/>
                        <font size="-1"><em><b>Then select
					<input type="checkbox" name="checkbox" value="checkbox">
                        for the appropriate local activity from the table below. Next select the distance
					from the rental to these activities. </b></em></font>
                        <br />
                        <br />
                        <table align="center" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:DataGrid ID="AttractionsList1" runat="server" DataKeyField="ID" DataMember="Attractions"
                                        DataSource='<%# AttractionsDistancesSet1 %>' AutoGenerateColumns="False" BorderWidth="0">
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="" ItemStyle-Width="200" ItemStyle-BackColor="#DBE7F2">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="Attraction1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Attraction", "{0}") %>'
                                                        Checked='<%# (((System.Data.DataRowView)Container.DataItem).Row["Distance"] is string) %>'></asp:CheckBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="" ItemStyle-Width="75">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="Distance1" runat="server" DataSource='<%# DistancesSet %>'
                                                        DataMember="Distances" DataTextField="Distance" DataValueField="ID" DataTextFormatString="{0}"
                                                        SelectedValue='<%# (((System.Data.DataRowView)Container.DataItem).Row["DistanceID"] is int) ? DataBinder.Eval(Container.DataItem, "DistanceID", "{0}") : "1" %>'
                                                        Height="24px">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                                <td>
                                    <asp:DataGrid ID="AttractionsList2" runat="server" DataKeyField="ID" DataMember="Attractions"
                                        DataSource='<%# AttractionsDistancesSet2 %>' AutoGenerateColumns="False" BorderWidth="0">
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="" ItemStyle-Width="200" ItemStyle-BackColor="#DBE7F2">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="Attraction2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Attraction", "{0}") %>'
                                                        Checked='<%# (((System.Data.DataRowView)Container.DataItem).Row["Distance"] is string) %>'></asp:CheckBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="" ItemStyle-Width="75">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="Distance2" runat="server" DataSource='<%# DistancesSet %>'
                                                        DataMember="Distances" DataTextField="Distance" DataValueField="ID" DataTextFormatString="{0}"
                                                        SelectedValue='<%# (((System.Data.DataRowView)Container.DataItem).Row["DistanceID"] is int) ? DataBinder.Eval(Container.DataItem, "DistanceID", "{0}") : "1" %>'
                                                        Height="24px">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align:top; background-color:#fff;">
                        <font size="4"><b>Rates:
					<br />
                    </b></font>
                        <br />
                        <font size="2">In order for your listing to be saved, you must click on the button "Next
					Step" at the bottom of the page. </font>
                    </td>
                    <td align="left">These rates are to provide visitors a general idea of price range for your property and are displayed on the city pages.<br />
                        <div style="text-align: left">
                            <hr size="1" width="75%" />
                        </div>
                        Lowest Nightly Rate&nbsp;&nbsp;
                <asp:TextBox ID="txtReqLoRate" runat="server"></asp:TextBox>&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlCurrencies"
                    runat="server" AppendDataBoundItems="True">
                    <asp:ListItem>Currency</asp:ListItem>
                </asp:DropDownList>
                        <asp:Label ID="lblCurrReq" runat="server" Text="(Required)" ForeColor="Red"></asp:Label><br />
                        Highest Nightly Rate&nbsp;&nbsp;<asp:TextBox ID="txtReqHiRate" runat="server"></asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator1" runat="server"
                            ErrorMessage="Please enter integer amount" ControlToValidate="txtReqLoRate"
                            Display="Dynamic" MaximumValue="100000" MinimumValue="0" Type="Integer"
                            SetFocusOnError="True">Please enter integer amount</asp:RangeValidator>
                        <asp:RangeValidator ID="RangeValidator2" runat="server"
                            ErrorMessage="RangeValidator" ControlToValidate="txtReqHiRate"
                            Display="Dynamic" MaximumValue="100000" MinimumValue="0" SetFocusOnError="True"
                            Type="Integer">Please enter integer amount</asp:RangeValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                            ErrorMessage="Please enter minimum nightly rate"
                            ControlToValidate="txtReqLoRate" Display="Dynamic" SetFocusOnError="True">Please enter minimum nightly rate</asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                            ErrorMessage="Please select a currency" ControlToValidate="ddlCurrencies"
                            Text="Please select a currency" InitialValue="Currency" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server"
                            ErrorMessage="Please enter maximum nightly rate" ControlToValidate="txtReqHiRate"
                            Display="Dynamic" SetFocusOnError="True">Please enter maximum nightly rate</asp:RequiredFieldValidator><br />
                        <hr size="1" width="75%" />

                        This field displays rates on your individual property page
				<asp:TextBox ID="Rates" TabIndex="8" runat="server" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].Rates", "{0}") %>'
                    Width="600px" Height="100px" TextMode="MultiLine" /><br />

                        You are allowed to enter text in the above box and / or use the table below.
                
				<br />
                        <br />

                        <asp:DataGrid ID="RatesList" runat="server" DataKeyField="ID" DataMember="Rates"
                            DataSource='<%# RatesSet %>' AutoGenerateColumns="False" ShowFooter="True">
                            <Columns>
                                <asp:TemplateColumn HeaderText="Start Date - mo/da/year">
                                    <ItemTemplate>
                                        <asp:TextBox ID="StartDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="AddStartDate" runat="Server" style="width:98%;" />
                                    </FooterTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="End Date - mo/da/year">
                                    <ItemTemplate>
                                        <asp:TextBox ID="EndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate", "{0:d}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="AddEndDate" runat="Server" style="width:98%;" />
                                    </FooterTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="Nightly">
                                    <ItemTemplate>
                                        <asp:TextBox ID="Nightly" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Nightly", "{0:G4}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="AddNightly" runat="Server" style="width:98%;" />
                                    </FooterTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="Weekly">
                                    <ItemTemplate>
                                        <asp:TextBox ID="Weekly" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Weekly", "{0:G4}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="AddWeekly" runat="Server" style="width:98%;" />
                                    </FooterTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="Monthly">
                                    <ItemTemplate>
                                        <asp:TextBox ID="Monthly" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Monthly", "{0:G4}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="AddMonthly" runat="Server" style="width:98%;" />
                                    </FooterTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="">
                                    <ItemTemplate>
                                        <asp:Button CommandName="Delete" Text="Delete" ID="DeleteButton" runat="server" />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Button CommandName="Insert" Text="Add" ID="AddButton" runat="server" />
                                    </FooterTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                        <hr>
                        <br />
                        Prices are quoted in
				<asp:TextBox ID="PricesCurrency" TabIndex="8" runat="server" MaxLength="50" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].PricesCurrency", "{0}") %>'
                    Width="100px" />
                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator12" runat="server"
                            Display="Dynamic" ControlToValidate="PricesCurrency" ErrorMessage="Too long prices currency entered"
                            ValidationExpression="^[\s\S]{1,50}$" />
                        <br />
                        Check In:
				<asp:DropDownList ID="CheckIn" runat="server" Width="200px" SelectedValue='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].CheckIn", "{0}") %>'
                    Height="24px">
                    <asp:ListItem Value="Check with Owner">Check with Owner</asp:ListItem>
                    <asp:ListItem Value="1 AM">1 AM</asp:ListItem>
                    <asp:ListItem Value="2 AM">2 AM</asp:ListItem>
                    <asp:ListItem Value="3 AM">3 AM</asp:ListItem>
                    <asp:ListItem Value="4 AM">4 AM</asp:ListItem>
                    <asp:ListItem Value="5 AM">5 AM</asp:ListItem>
                    <asp:ListItem Value="6 AM">6 AM</asp:ListItem>
                    <asp:ListItem Value="7 AM">7 AM</asp:ListItem>
                    <asp:ListItem Value="8 AM">8 AM</asp:ListItem>
                    <asp:ListItem Value="9 AM">9 AM</asp:ListItem>
                    <asp:ListItem Value="10 AM">10 AM</asp:ListItem>
                    <asp:ListItem Value="11 AM">11 AM</asp:ListItem>
                    <asp:ListItem Value="12 PM">12 PM</asp:ListItem>
                    <asp:ListItem Value="1 PM">1 PM</asp:ListItem>
                    <asp:ListItem Value="2 PM">2 PM</asp:ListItem>
                    <asp:ListItem Value="3 PM">3 PM</asp:ListItem>
                    <asp:ListItem Value="4 PM">4 PM</asp:ListItem>
                    <asp:ListItem Value="5 PM">5 PM</asp:ListItem>
                    <asp:ListItem Value="6 PM">6 PM</asp:ListItem>
                    <asp:ListItem Value="7 PM">7 PM</asp:ListItem>
                    <asp:ListItem Value="8 PM">8 PM</asp:ListItem>
                    <asp:ListItem Value="9 PM">9 PM</asp:ListItem>
                    <asp:ListItem Value="10 PM">10 PM</asp:ListItem>
                    <asp:ListItem Value="11 PM">11 PM</asp:ListItem>
                    <asp:ListItem Value="12 AM">12 AM</asp:ListItem>
                </asp:DropDownList>
                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator11" runat="server"
                            Display="Dynamic" ControlToValidate="CheckIn" ErrorMessage="Too long check in value entered"
                            ValidationExpression="^[\s\S]{1,50}$" />
                        <br />
                        Check Out:
				<asp:DropDownList ID="CheckOut" runat="server" Width="200px" SelectedValue='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].CheckOut", "{0}") %>'
                    Height="24px">
                    <asp:ListItem Value="Check with Owner">Check with Owner</asp:ListItem>
                    <asp:ListItem Value="1 AM">1 AM</asp:ListItem>
                    <asp:ListItem Value="2 AM">2 AM</asp:ListItem>
                    <asp:ListItem Value="3 AM">3 AM</asp:ListItem>
                    <asp:ListItem Value="4 AM">4 AM</asp:ListItem>
                    <asp:ListItem Value="5 AM">5 AM</asp:ListItem>
                    <asp:ListItem Value="6 AM">6 AM</asp:ListItem>
                    <asp:ListItem Value="7 AM">7 AM</asp:ListItem>
                    <asp:ListItem Value="8 AM">8 AM</asp:ListItem>
                    <asp:ListItem Value="9 AM">9 AM</asp:ListItem>
                    <asp:ListItem Value="10 AM">10 AM</asp:ListItem>
                    <asp:ListItem Value="11 AM">11 AM</asp:ListItem>
                    <asp:ListItem Value="12 PM">12 PM</asp:ListItem>
                    <asp:ListItem Value="1 PM">1 PM</asp:ListItem>
                    <asp:ListItem Value="2 PM">2 PM</asp:ListItem>
                    <asp:ListItem Value="3 PM">3 PM</asp:ListItem>
                    <asp:ListItem Value="4 PM">4 PM</asp:ListItem>
                    <asp:ListItem Value="5 PM">5 PM</asp:ListItem>
                    <asp:ListItem Value="6 PM">6 PM</asp:ListItem>
                    <asp:ListItem Value="7 PM">7 PM</asp:ListItem>
                    <asp:ListItem Value="8 PM">8 PM</asp:ListItem>
                    <asp:ListItem Value="9 PM">9 PM</asp:ListItem>
                    <asp:ListItem Value="10 PM">10 PM</asp:ListItem>
                    <asp:ListItem Value="11 PM">11 PM</asp:ListItem>
                    <asp:ListItem Value="12 AM">12 AM</asp:ListItem>
                </asp:DropDownList>
                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator10" runat="server"
                            Display="Dynamic" ControlToValidate="CheckOut" ErrorMessage="Too long check out value entered"
                            ValidationExpression="^[\s\S]{1,50}$" />
                        <br />
                        Payment Methods:
				<asp:CheckBoxList ID="PaymentMethodsList" runat="server" DataTextFormatString="{0}"
                    DataValueField="ID" DataTextField="PaymentMethod" DataMember="PaymentMethods"
                    DataSource='<%# PaymentMethodsSet %>' RepeatColumns="1" RepeatDirection="Horizontal">
                </asp:CheckBoxList>
                        Lodging Tax:
				<asp:TextBox ID="LodgingTax" TabIndex="8" runat="server" MaxLength="300" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].LodgingTax", "{0}") %>'
                    Width="100px" />
                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator9" runat="server" Display="Dynamic"
                            ControlToValidate="LodgingTax" ErrorMessage="Too long lodging tax entered" ValidationExpression="^[\s\S]{1,300}$" />
                        <br />
                        Tax Included in Rates above
				<asp:RadioButton ID="TaxIncluded" runat="server" Width="50px" Checked='<%# (PropertiesSet.Tables["Properties"].Rows[0]["TaxIncluded"] is bool) ? (bool)PropertiesSet.Tables["Properties"].Rows[0]["TaxIncluded"] : false %>'
                    Height="24px" Text="Yes" GroupName="0"></asp:RadioButton>
                        <asp:RadioButton ID="TaxNotIncluded" runat="server" Width="50px" Checked='<%# (PropertiesSet.Tables["Properties"].Rows[0]["TaxIncluded"] is bool) ? !(bool)PropertiesSet.Tables["Properties"].Rows[0]["TaxIncluded"] : false %>'
                            Height="24px" Text="No" GroupName="0"></asp:RadioButton>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align:top; background-color:#fff;">Cancellation Policy:
                    </td>
                    <td>
                        <asp:TextBox ID="CancellationPolicy" TabIndex="8" runat="server"
                            Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].CancellationPolicy", "{0}") %>'
                            Width="600px" Height="100px" TextMode="MultiLine" />

                    </td>
                </tr>
                <tr>
                    <td style="vertical-align:top; background-color:#fff;">Deposit Required:
                    </td>
                    <td>
                        <asp:TextBox ID="DepositRequired" TabIndex="8" runat="server" Text='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].DepositRequired", "{0}") %>'
                            Width="600px" Height="100px" TextMode="MultiLine" />
                    </td>
                </tr>
                <% if (MoreThan7PhotosAllowed.Visible)
                   { %>
                <tr>
                    <td>
                        <asp:Label ID="MoreThan7PhotosAllowedLabel" runat="server">
										More than 7 photos allowed:
                        </asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="MoreThan7PhotosAllowed" runat="server" Width="64px" SelectedValue='<%# DataBinder.Eval(PropertiesSet, "Tables[Properties].DefaultView.[0].IfMoreThan7PhotosAllowed", "{0}") %>'
                            Height="24px">
                            <asp:ListItem Value="True" Selected="True">Yes</asp:ListItem>
                            <asp:ListItem Value="False">No</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <% } %>
                <tr>
                    <td valign="top" bgcolor="#996600">
                        <asp:Button ID="SubmitButton" TabIndex="20" runat="server" Text="NEXT STEP" Width="135px"
                            OnClick="SubmitButton_Click" OnClientClick="return validateForm();"
                            CausesValidation="False" />
                    </td>
                    <td valign="top">
                        <asp:Button ID="CancelButton" TabIndex="21" runat="server" Text="Cancel" Width="96px"
                            CausesValidation="False" OnClick="CancelButton_Click" />
                        <br />
                        <font size="-1"><font color="#ff0000">(Fields marked required must have a value for
					your listing to be submitted.
					<br />
                        After clicking "Next Step" you should be redirected to the upload photo page.<br />
                        If this does not happen, then one of the required fields maybe the problem.<br />
                        It could be an invalid character in the town name. Examples of invalid characters
					are � �, �, � ,. It could be a space at the end of the town name.) </font></font>
                    </td>
                </tr>
            </table>
        </div>
        <div id="divPriTypes" runat="server">
        </div>
        <div id="divCounties" runat="server">
        </div>
        <script language="javascript" type="text/javascript">
            <%= DropDownScript() %>
	    
	    
        </script>


    </div>
        </div>
    </div>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript">

var country, state, city, pinCode;
function createCORSRequest(method, url) {
    var xhr = new XMLHttpRequest();

    if ("withCredentials" in xhr) {
        // XHR for Chrome/Firefox/Opera/Safari.
        xhr.open(method, url, true);

    } else if (typeof XDomainRequest != "undefined") {
        // XDomainRequest for IE.
        xhr = new XDomainRequest();
        xhr.open(method, url);

    } else {
        // CORS not supported.
        xhr = null;
    }
    return xhr;
}
function getLocationDetails() {

    var States = document.getElementById('<%= hdnState.ClientID %>').value;
    var Countrys = document.getElementById('<%= hdnCountry.ClientID %>').value;
    latitude1 = document.getElementById("Latitude").value;
    longitude1 = document.getElementById("Longitude").value;
    var url = "http://maps.googleapis.com/maps/api/geocode/json?latlng=" +
            latitude1 + "," + longitude1 + "&sensor=false";
    var xhr = createCORSRequest('POST', url);
    if (!xhr) {
        alert('CORS not supported');
    }

    xhr.onload = function () {

        var data = JSON.parse(xhr.responseText);

        if (data.results.length > 0) {
            var locationDetails;
            var EntCity = document.getElementById('<%= CityNew.ClientID %>').value;

            if (EntCity == '' || EntCity == 'undefined') {
                var hdcty = document.getElementById('city');
                EntCity = hdcty.options[hdcty.selectedIndex].text;
                document.getElementById('<%= hdcity.ClientID %>').value = EntCity;
            }
            var isvalid = "false";
            for (var i = 0; i < data.results.length; i++) {
                locationDetails = data.results[i].formatted_address.toLowerCase();
                if (parseInt(locationDetails.indexOf(EntCity.toLowerCase().replace(/ /g, ''))) >= 0) {
                    isvalid = "true";
                    break;
                }
            }
            if (isvalid == "false") {
                document.getElementById('<%= CityNew.ClientID %>').value = '';
                alert("No location available for provided details.");
                document.getElementById('<%= CityNew.ClientID %>').focus();
            } else {
                document.getElementById('<%= hdnLatitude.ClientID %>').value = latitude1;
                document.getElementById('<%= hdnLongitude.ClientID %>').value = longitude1;
            }

        }
        else {
            alert("No location available for provided details.");
        }

    };

    xhr.onerror = function () {
        alert('Woops, there was an error making the request.');

    };
    xhr.send();

}


function GetLocation() {
    var hdcounty = document.getElementById('country');
    var hdState = document.getElementById('state');
    var hdcnty = document.getElementById('<%= hdnCountry.ClientID %>').value;
    var hdsts = document.getElementById('<%= hdnState.ClientID %>').value;
    if (hdcnty == '' && hdsts == '') {
        document.getElementById('<%= hdnCountry.ClientID %>').value = hdcounty.options[hdcounty.selectedIndex].text;
        document.getElementById('<%= hdnState.ClientID %>').value = hdState.options[hdState.selectedIndex].text;
    }

    var geocoder = new google.maps.Geocoder();
    var address = document.getElementById('<%= CityNew.ClientID %>').value;

    if (address == '' || address == 'undefined' || address == 'Other (please specify)') {
        var hdcty = document.getElementById('city');
        address = hdcty.options[hdcty.selectedIndex].text;
        document.getElementById('<%= hdcity.ClientID %>').value = address;
    }

    if (address != '' && address != 'undefined' && address != 'Other (please specify)') {
        var country = document.getElementById('<%= hdnCountry.ClientID %>').value;
        var state = document.getElementById('<%= hdnState.ClientID %>').value;
        address = address + ', ' + state + ', ' + country;
        geocoder.geocode({ 'address': address }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                var latitude = results[0].geometry.location.lat();
                var longitude = results[0].geometry.location.lng();
                document.getElementById("Latitude").value = latitude;
                document.getElementById("Longitude").value = longitude;
                if (document.getElementById('<%= CityNew.ClientID %>').value != '' && document.getElementById('<%= CityNew.ClientID %>').value != 'undefined') {
                    getLocationDetails();
                } else {
                    document.getElementById('<%= hdnLatitude.ClientID %>').value = latitude;
                    document.getElementById('<%= hdnLongitude.ClientID %>').value = longitude;
                }
            } else {
                alert("Request failed.");
            }
        });
    }
}
function GetText(element, option) {
    var text = element.options[element.selectedIndex].text;
    if (option == 'Country') {
        document.getElementById('<%= hdnCountry.ClientID %>').value = text;
    }
    else if (option == 'State') {
        document.getElementById('<%= hdnState.ClientID %>').value = text;
    }
}

function ProcessValidators() {
    var i, val;
    for (i = 0; i < Page_Validators.length; i++) {
        val = Page_Validators[i];
        if (typeof (val.evaluationfunction) == "function") {
            if (eval("val.evaluationfunction == RequiredFieldValidatorEvaluateIsValid;"))
                eval("val.evaluationfunction = RequiredFieldAlertValidate;");
            else if (eval("val.evaluationfunction == RegularExpressionValidatorEvaluateIsValid;"))
                eval("val.evaluationfunction = RegularExpressionAlertValidate;");
        }
    }
}

function RequiredFieldAlertValidate(val) {
    var result;
    result = RequiredFieldValidatorEvaluateIsValid(val)
    if (!result)
        window.alert(val.errormessage);
    return result;
}

function RegularExpressionAlertValidate(val) {
    var result;
    result = RegularExpressionValidatorEvaluateIsValid(val)
    if (!result)
        window.alert(val.errormessage);
    return result;
}


InitializeDropdowns();
    </script>

 
</asp:Content>
