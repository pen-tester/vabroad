<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GetPropertyNum.aspx.cs" Inherits="GetPropertyNum" %>

<!DOCTYPE html>

<html  xmlns="http://www.w3.org/1999/xhtml"  lang="en" xml:lang="en">
<head runat="server">
    <title></title>
    <style>
        .column{
            width:250px;
            display:inline-block;
        }


    </style>
</head>

<body>
    <form id="form1" runat="server">
    <div>
        <div>
             <div class="column">
                   Region
                </div>
                <div class="column">
                   Country
                </div>
                <div class="column">
                   # of Properties
                </div>

        </div>
              
      <%
          int count = Num_list.Count;
          for (int i = 0; i < count; i++)
          { %>
        
            <div>
                <div class="column">
                    <%= Num_list[i].Region %>
                </div>
                <div class="column">
                    <%= Num_list[i].Country %>
                </div>
                <div class="column">
                    <%= Num_list[i].NumProCountry %>
                </div>
            </div>


        <%} %>
    </div>
    </form>
</body>
</html>
