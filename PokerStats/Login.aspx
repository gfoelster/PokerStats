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
            <span>Login:</span>
            <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                                CssClass="failureNotification" ErrorMessage="Bitte Login angeben." ToolTip="Bitte Login angeben." 
                                ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
       </p>
       <p>
            <span>Passwort:</span>
            <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                    CssClass="failureNotification" ErrorMessage="Bitte Passwort angeben." ToolTip="Bitte Passwort angeben." 
                    ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
       </p>
       <p>
          <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification" 
                     ValidationGroup="LoginUserValidationGroup"/>
        </p>
        <p>
            <asp:CheckBox ID="RememberMe" runat="server"/>
            <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe" CssClass="inline">Eingeloggt bleiben</asp:Label>
        </p>
        <p>
            <asp:Button ID="LoginButton" runat="server" Text="Log In" 
            ValidationGroup="LoginUserValidationGroup" onclick="LoginButton_Click"/>
        </p>
        <p>
            <asp:Label ID="ErrorLabel" runat="server" Visible="false" CssClass="failureNotification" 
               Text="Einloggen fehlgeschlagen. Bitte überprüfe Login und Passwort."></asp:Label>
        </p>
    </form>
    </body>
</html>
