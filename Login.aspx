<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Assignment.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="http://www.google.com/recaptcha/api.js?render=6LclhG8eAAAAABCyyigtSdbGHKPYAsFzMxsQ2r68"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>
                <br />
                <asp:Label ID="Label1" runat="server" Text="Login"></asp:Label>
                <br />
                <br />
            </h2>

            <table class="style1">
                    <tr>
                        <td class="style3" id="login_email">
                            Email Address</td>
                        <td class="style2">
                            <asp:TextBox ID="tb_login_email" runat="server" Height="32px" Width="281px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1" id="login_passwd">
                            Password 
                        </td>
                        <td class="auto-style1">
                            <asp:TextBox ID="tb_login_passwd" runat="server" Height="32px" Width="281px" TextMode="Password"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="style4"></td>
                        <td class="style5">
                            <asp:Button ID="btn_Submit" runat="server" Height="48px" 
                                onclick="LoginUser" Text="Login" Width="288px" />
                        </td>
                   </tr>
             </table>
        </div>
    </form>
    <br />
    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
    <asp:Label ID="lbl_message" runat="server" EnableViewState ="false"></asp:Label>

    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6LclhG8eAAAAABCyyigtSdbGHKPYAsFzMxsQ2r68', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</body>
</html>
