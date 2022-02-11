<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Assignment.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>
        <script type="text/javascript">
            function passwordvalidate() {
                var str = document.getElementById('<%=tb_password.ClientID %>').value;

                if (str.length < 12) {
                    document.getElementById("passwordChk").innerHTML = "Password length must be at least 12 characters";
                    document.getElementById("passwordChk").style.color = "Red";
                    return ("too short")
                }
                else if (str.search(/[0-9]/)==-1) {
                    document.getElementById("passwordChk").innerHTML = "Password require at least 1 number ";
                    document.getElementById("passwordChk").style.color = "Red";
                    return ("no number")
                }
                else if (str.search(/[A-Z]/) == -1) {
                    document.getElementById("passwordChk").innerHTML = "Password must consist at least 1 upper case";
                    document.getElementById("passwordChk").style.color = "Red";
                    return ("no capital letter");
                }
                else if (str.search(/[a-z]/) == -1) {
                    document.getElementById("passwordChk").innerHTML = "Password require at least 1 lower case";
                    document.getElementById("passwordChk").style.color = "Red";
                    return ("no lower case");
                }
                else if (str.search(/[^a-zA-Z0-9]/) == -1) {
                    document.getElementById("passwordChk").innerHTML = "Password require at least 1 special characters";
                    document.getElementById("passwordChk").style.color = "Red";
                    return ("no special character");
                }

                document.getElementById("passwordChk").innerHTML = "Excellent";
                document.getElementById("passwordChk").style.color = "Green";
            }

            function creditvalidate() {
                var creditstr = document.getElementById('<%=tb_credit_no.ClientID %>').value;

                if (creditstr.length < 16) {

                    document.getElementById("credit_status").innerHTML = "Credit card length must be 16 digits";
                    document.getElementById("credit_status").style.color = "Red";
                    return ("too short")
                }
                document.getElementById("credit_status").innerHTML = "Valid!";
                document.getElementById("credit_status").style.color = "Green";

            }

            function fnamevalidate() {
                var firststr = document.getElementById('<%=tb_fname.ClientID %>').value;
            
            
                if (firststr.search(/[0-9]/) != -1) {

                    document.getElementById("fname_status").innerHTML = "Name must not include numbers!";
                    document.getElementById("fname_status").style.color = "Red";
                    return ("No numbers!")
                }

                else if (firststr.search(/[^a-zA-Z0-9]/) != -1) {

                    document.getElementById("fname_status").innerHTML = "Name must not include special character!";
                    document.getElementById("fname_status").style.color = "Red";
                    return ("No special characters!")
                }

                else {
                    document.getElementById("fname_status").innerHTML = "Valid!";
                    document.getElementById("fname_status").style.color = "Green";
                }

            }

            function lnamevalidate() {
                var laststr = document.getElementById('<%=tb_lname.ClientID %>').value;

                if (laststr.search(/[0-9]/) != -1) {

                    document.getElementById("lname_status").innerHTML = "Name must not include numbers!";
                    document.getElementById("lname_status").style.color = "Red";
                    return ("No numbers!")
                }

                else if (laststr.search(/[^a-zA-Z0-9]/) != -1) {

                    document.getElementById("lname_status").innerHTML = "Name must not include special character!";
                    document.getElementById("lname_status").style.color = "Red";
                    return ("No special characters!")
                }

                else {
                    document.getElementById("lname_status").innerHTML = "Valid!";
                    document.getElementById("lname_status").style.color = "Green";
                }
            }

            function dobvalidate() {
                var datestr = document.getElementById('<%=tb_dob.ClientID %>').value;

                if (datestr.search(/[0-9]/) == -1) {
                    document.getElementById("dob_status").innerHTML = "Only numbers are allowed";
                    document.getElementById("dob_status").style.color = "Red";
                    return ("Only numbers!");
                }

                else {
                    document.getElementById("dob_status").innerHTML = "Valid!";
                    document.getElementById("dob_status").style.color = "Green";
                }
            }
        </script>
        <style type="text/css">
            .auto-style1 {
                height: 42px;}
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <h2>
                    <br />
                    <asp:Label ID="Label1" runat="server" Text="Account Registration"></asp:Label>
                    <br />
                    <br />
               </h2>

                <table class="style1">
                    <tr>
                        <td class="style3" id="lbl_lname">
                            First Name</td>
                        <td class="style2">
                            <asp:TextBox ID="tb_fname" runat="server" Height="36px" Width="280px" onkeyup ="javascript:fnamevalidate()"></asp:TextBox>
                        </td>
                        <td class="auto-style1" >
                            <asp:Label ID="fname_status" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="style3" id="lname">
                            Last Name</td>
                        <td class="style2">
                            <asp:TextBox ID="tb_lname" runat="server" Height="32px" Width="281px" onkeyup ="javascript:lnamevalidate()"></asp:TextBox>
                        </td>
                        <td class="auto-style1" >
                            <asp:Label ID="lname_status" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1" id="lbl_credit_no">
                            Credit Card No.</td>
                        <td class="auto-style1">
                            <asp:TextBox ID="tb_credit_no" runat="server" Height="32px" Width="281px" onkeyup ="javascript:creditvalidate()"></asp:TextBox>
                        </td>
                        <td class="auto-style1" >
                            <asp:Label ID="credit_status" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="style3" id="lbl_email">
                            Email Address</td>
                        <td class="style2">
                            <asp:TextBox ID="tb_email" runat="server" Height="32px" Width="281px" onkeyup ="javascript:namevalidate()"></asp:TextBox>
                        </td>
                        <td class="auto-style1" >
                            <asp:Label ID="email_status" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1" id="lbl_password">
                            Password 
                        </td>
                        <td class="auto-style1">
                            <asp:TextBox ID="tb_password" runat="server" Height="32px" Width="281px" onkeyup ="javascript:passwordvalidate()"></asp:TextBox>
                        </td>
                        <td class="auto-style1" >
                            <asp:Label ID="passwordChk" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td class="auto-style1" >
                            <asp:Button ID="passwdBtn" runat="server" OnClick="passwd_Click" Text="Check Password" Width="288px" />
                        </td>
                        
                        <td class="auto-style1" >
                            <asp:Label ID="passwd_status" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="style4" id="lbl_dob">
                            Date Of Birth 
                        </td>
                        <td class="style5">
                            <asp:TextBox ID="tb_dob" runat="server" Height="32px" Width="281px" onkeyup ="javascript:namevalidate()" TextMode="Date"></asp:TextBox>
                        </td>
                        <td class="auto-style1" >
                            <asp:Label ID="dob_status" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                    </tr>

                    <tr>
                        <td class="style4" id="lbl_photo">
                            Photo</td>
                        <td class="style5">
                            
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                            
                        </td>
                        <td class="auto-style1" >
                            <asp:Label ID="photo_status" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr> <td class="style4"></td></tr>

                    <tr>
                        <td class="style4"></td>
                       <td> 

                           <asp:Button ID="btn_Submit" runat="server" Text="Submit" Height="45px" Width="288px" OnClick="btn_Submit_Click" />

                       </td>
                    </tr>
                </table>

                <br />
                <br />
    
            </div>
        </form>
    </body>
</html>
