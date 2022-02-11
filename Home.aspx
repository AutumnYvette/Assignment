<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Assignment.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Login"></asp:Label>
            <br />
            <br />
        </h2>
        <asp:Label ID="lbl_message" runat="server" EnableViewState ="false" />
        <br />
        <td class="style5">
        </td>
        <p>
            <asp:Button ID="btn_Logout" runat="server" Height="35px" 
                onclick="LogoutUser" Text="Logout" Width="176px" />
        </p>
    </form>
</body>
</html>
