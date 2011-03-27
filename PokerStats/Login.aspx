<%@ Page Title="Log In" Language="C#" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="PokerStats.Account.Login" %>

<html>
    <head title="PokerStats">

        <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
    <form id="form1" runat="server">
    <h2>
        Anmeldung
    </h2>

       <p>
            <table>
                <tr>
                    <td>Login:</td>
                    <td>
                        <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                                CssClass="failureNotification" ErrorMessage="Bitte Login angeben." ToolTip="Bitte Login angeben." 
                                ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Passwort:</td>
                    <td>
                        <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                            CssClass="failureNotification" ErrorMessage="Bitte Passwort angeben." ToolTip="Bitte Passwort angeben." 
                            ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification" 
                                                ValidationGroup="LoginUserValidationGroup"/>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                           <asp:CheckBox ID="RememberMe" runat="server" Text="Eingeloggt bleiben" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                           <asp:Button ID="LoginButton" runat="server" Text="Log In" CssClass="loginButton"
                            ValidationGroup="LoginUserValidationGroup" onclick="LoginButton_Click"/>
                    </td>
                </tr>
            </table>
         
            
       </p>
      
    
        <p>
            <asp:Label ID="ErrorLabel" runat="server" Visible="false" CssClass="failureNotification" 
               Text="Einloggen fehlgeschlagen. Bitte überprüfe Login und Passwort."></asp:Label>
        </p>
    </form>
    </body>
</html>
