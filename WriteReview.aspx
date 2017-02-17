<%@ Page Language="C#" MasterPageFile="/masterpage/MasterMobile.master"
    AutoEventWireup="true" EnableEventValidation="true" ValidateRequest="true" CodeFile="WriteReview.aspx.cs"
    Inherits="PropertyReview" %>

<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <meta name="description" content="Have you visited <%=propName %> in <%=city %>; then let us know about your experience." />
    <style>
        .comimg{
            width:100px;height:100px;
        }
        .comtxt{
            width:90%; height:100px;
        }
        .ReviewTitle{ margin:auto;width:80%;text-align:center;margin-top:10px;color:#f60}
        .rating {
            overflow: hidden;
            display: inline-block;
            font-size: 0;
            position: relative;
        }
        .rating-input {
            float: right;
            width: 16px;
            height: 16px;
            padding: 0;
            margin: 0 0 0 -16px;
            opacity: 0;
        }
        .rating:hover .rating-star:hover,
        .rating:hover .rating-star:hover ~ .rating-star,
        .rating-input:checked ~ .rating-star {
            background-position: 0 0;
        }
        .rating-star,
        .rating:hover .rating-star {
            position: relative;
            float: right;
            display: block;
            width: 16px;
            height: 16px;
            background: url('/assets/img/star.png') 0 -16px;
        }
     .loader {
         margin:auto;
        border: 16px solid #f3f3f3; /* Light grey */
        border-top: 16px solid #3498db; /* Blue */
        border-radius: 50%;
        width: 120px;
        height: 120px;
        animation: spin 2s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
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
        margin-top:400px;
        padding:40px;
    }
    .modalhead{
        position:absolute;right:15px; top:10px;
    }
    .uploadimg{
        margin-top:20px;
    }
    .uploadtitle{
        font-size:14px; font-weight:bold;
    }
  </style>
</asp:Content>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Write Review for <%=propName %> in <%=city %> <%=state %> <%=country %>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="bodycontent" runat="Server">
    <input type="hidden" name="propid" id="propid" value="<%=propNum %>" />
    <input type="hidden" name="commentid" id="commentid" value="-1" />
   <div class="internalpagewidth">
           <div id="inqureform" class="modalform">
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

                    <div class="srow" >
                        <asp:HyperLink ID="hyplnkCountryBackLink" CssClass="backitem" runat="server"><%=country %><<</asp:HyperLink>
                        <asp:HyperLink ID="hyplnkStateBackLink" CssClass="backitem" runat="server"><%=state %><<</asp:HyperLink>
                        <asp:HyperLink ID="hyplnkCityBack" CssClass="backitem" runat="server"><%=city %><<</asp:HyperLink>
                        <asp:HyperLink ID="hyplnkPropBack" CssClass="backitem" runat="server">Property <%=propNum %></asp:HyperLink>
                        <div class="clear"></div>
                    </div>
       <div class="srow">
           <h1 class="ReviewTitle">Write a Review for <%=propName %> in <%=city %></h1>
       </div>

           <div class="clear"></div>
        <div class="newline">
            <div class="srow">
                <div id="divLftContent" class="col-5 col-x-4 center">
                      <div style="margin:auto;text-align:left">
                        <img src="<%=imgurl %>" alt="<%=String.Format("Review of {0} in {1} {2}",propName, city,state) %>"  title="<%=String.Format("Review of {0} in {1} {2}",propName, city,state) %>" />
                        <br />
                        <br />
                        <%-- star section--%>
                        <span class="rating">
                                <input type="radio" class="rating-input"
                            id="rating-input-1-5" name="ratings" value="5"/>
                                <label for="rating-input-1-5" class="rating-star"></label>
                                <input type="radio" class="rating-input"
                                        id="rating-input-1-4" name="ratings"  value="4"/>
                                <label for="rating-input-1-4" class="rating-star"></label>
                                <input type="radio" class="rating-input"
                                        id="rating-input-1-3" name="ratings"  value="3"/>
                                <label for="rating-input-1-3" class="rating-star"></label>
                                <input type="radio" class="rating-input"
                                        id="rating-input-1-2" name="ratings"  value="2"/>
                                <label for="rating-input-1-2" class="rating-star"></label>
                                <input type="radio" class="rating-input"
                                        id="rating-input-1-1" name="ratings"  value="1"/>
                                <label for="rating-input-1-1" class="rating-star"></label>
                        </span>                        <br />
                        Rate your overall stay!
                        <br />
                        </div>
                        <%--star section--%>
                        <div class="clearfix"></div>
                        <div class="srow uploadimg">
                             <div class ="srow" >
                                <label class="uploadtitle">Upload Photos</label> 
                             </div>
                            <div class ="srow" >
                                <input type="file" id="imgfile"  accept="Image/*"/>
                                <input type="button" class="btnsigns" id="uploadbutton" value="Upload" onclick="UploadFile()" />
                             </div>
                        </div>
          
                </div>
                <div id="divRightContent" class="col-7 col-x-4">
                    <div style="width: 98%; text-align: right;">
                        <table width="100%">
                            <tr>
                                <td align="left" style="width: 25%">
                                    First Name:
                                </td>
                                <td style="width: 75%" align="left">
                                    <input type="text" id="txtFName" name="txtFName" style="width:97%" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Last Name:
                                </td>
                                <td align="left">
                                    <input type="text" id="txtLName" name="txtLName" style="width:97%" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Vacation Month:
                                </td>
                                <td align="left">
                                    <select name="ddlMonth" id="ddlMonth" style="width:95px">
                                        <option value="0">Month</option>
                                        <option value="1">January</option>
                                        <option value="2">February</option>
                                        <option value="3">March</option>
                                        <option value="4">April</option>
                                        <option value="5">May</option>
                                        <option value="6">June</option>
                                        <option value="7">July</option>
                                        <option value="8">August</option>
                                        <option value="9">September</option>
                                        <option value="10">October</option>
                                        <option value="11">November</option>
                                        <option value="12">December</option>
                                    </select>
                                    <select id="ddlYear" name="ddlYear" style="width:70px;">
                                        <option value="0" selected="selected">Year</option>
                                        <option value="2018">2018</option>
                                        <option value="2017">2017</option>
                                        <option value="2016">2016</option>
                                        <option value="2015">2015</option>
                                        <option value="2014">2014</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">Email:</td>
                                <td align="left">
                                    <input type="text" id="email" name="email" style="width:97%"/><br />
                                    <i>Your email will not be displayed.</i>
                                </td>
                            </tr>
                             <tr>
                                <td align="left" valign="top">
                                    Phone Number:
                                </td>
                                <td align="left">
                                    <input type="text" id="txtPhone" name="txtPhone" style="width:97%"/><br />
                                    <i>Your phone number will not be displayed.  We will call you if there are any questions 
                                    regarding your stay.</i>
                                </td>
                            </tr>
                        </table>
                        <asp:Label ID="lblCurInfo" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                    <br />
                    <div style="width: 100%;">
                        <div style="width: 100%; text-align: left;">
                            <%--<asp:Label ID="Label1" runat="server" Text="STEP TWO" Font-Bold="True" Font-Size="15px"></asp:Label>&nbsp;-Write
            Comments--%>
                        </div>
                        <textarea id="txtComments" name="txtComments" style="width:97%; height:150px;" ></textarea>
                        <br />
                        
                        <%--<asp:Label ID="Label3" runat="server" Text="STEP THREE" Font-Bold="True" Font-Size="15px"></asp:Label>&nbsp;-Submit Comments--%>
                        <br />
                        <br />
                        <label id="lblInfo" style="color:red;height:30px;width:300px;" ></label>
                    </div>
                </div>
            </div>
        </div>
    <div class="clear"></div>
    <div class="srow">

        <input type="hidden" name="image_count" id="image_count" value="0"/>
        <div class="col-1"></div>
        <div class=" col-10 col-x-4">
            <div id="list_image">

            </div>
        </div>
    </div>
       <div class="srow marginTop centered">
           <input type="button" class="btnsigns" onclick="Submit()" value="Submit" />
       </div>
   </div>

    <script defer="defer" src="/Assets/js/writereview.js"></script>
</asp:Content>
