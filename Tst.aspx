<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Tst.aspx.cs" Inherits="Tst" %>
<%@ Register Assembly="GoogleReCaptcha" Namespace="GoogleReCaptcha" TagPrefix="ccl" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <div>
            <ccl:GoogleReCaptcha ID="ctlCaptcha" runat="server" PublicKey="6LeiuBcUAAAAABl8pqeeYVr_M7DwF_b-CPzKo1eJ" PrivateKey="6LeiuBcUAAAAAPEGRRVqTcLsdO83GSnGetOwOfMM" />
        </div>
    </form>
</body>
</html>
