<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameLobby.aspx.cs" Inherits="PokerStats.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    
    
    <style type="text/css">
        
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
   
        <h1>Pokerstats</h1>
        <p>Verfügbare Spiele</p>

        <asp:ListBox ID="GamesList" runat="server" 
                     DataTextField="Name" 
                     DataValueField="GameID" 
                     onselectedindexchanged="GamesList_SelectedIndexChanged" 
                     AutoPostBack="True"></asp:ListBox>

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
