<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wizard.aspx.cs" Inherits="wizard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <script src="/assets/js/jquery-3.1.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#btn').click(function () {
                $.ajax({
                    type: "POST",
                    url:  "/wizard.aspx",
                    data: $('#main').serialize(),
                    success: function (response) {
                        console.log(response);
                    },
                    error: function (response) {
                        console.log(response);
                    }
                });
            });
        })
    </script>
</head>
<body>
    <form id="main">
        <input type="hidden" name="param" value="test" />
        <input type="button" value="Submit" id="btn" />
    </form>
</body>
</html>
