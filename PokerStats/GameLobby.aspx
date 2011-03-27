<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameLobby.aspx.cs" Inherits="PokerStats.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h1>Willkommen in der Pokerstats Lobby</h1>
        <p>Bitte wähle ein Spiel aus, oder eröffne ein neues.</p>
    </div>
    <asp:ListBox ID="GamesList" runat="server" 
        DataTextField="Name" DataValueField="Name" 
        onselectedindexchanged="GamesList_SelectedIndexChanged" 
        AutoPostBack="True"></asp:ListBox>
   
   <!-- Jeff: Sorry die DataSource musste gekillt werden -->


    <hr />
    <p>
        <asp:TextBox ID="NewGameName" runat="server" >NewGame</asp:TextBox>
        <asp:Button ID="CreateButton" runat="server" Text="Erstellen" 
            onclick="CreateButton_Click" />
    </p>
    <p>
        <asp:Label ID="DebugLabel" runat="server" Text="Label"></asp:Label>


        <asp:Button ID="LogoutButton" runat="server" Text="Logout" 
            onclick="LogoutButton_Click" />
    </p>
    </form>
</body>
</html>
