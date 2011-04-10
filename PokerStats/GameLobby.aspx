<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameLobby.aspx.cs" Inherits="PokerStats.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    
    
    <style type="text/css">
        
        #container
        {
            margin:5px;
        }
        
        
        .gamesList
        {
            width:300px;
            height:100px;
        }
        
        .newGamePanel
        {
            margin-top:50px;
        }
        
        .newGameTextBox
        {
            width:215px;
        }
        
        .logoutButton
        {
            position:absolute; margin:10px; top:0px; right:0px;
        }
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
   
    <div id="container">
        <h1>Pokerstats</h1>
        <p>Verfügbare Spiele</p>

        <asp:ListBox ID="GamesList" runat="server" 
                     DataTextField="Name" 
                     DataValueField="GameID" 
                     onselectedindexchanged="GamesList_SelectedIndexChanged" 
                     CssClass="gamesList"
                     AutoPostBack="True"></asp:ListBox>

    <p class="newGamePanel">
        <span>Neues Spiel erstellen:</span><br />
        <asp:TextBox ID="NewGameName" runat="server" CssClass="newGameTextBox" ></asp:TextBox>
        <asp:Button ID="CreateButton" runat="server" Text="Erstellen" 
            onclick="CreateButton_Click" /><br />
        <asp:Label ID="ErrorLabel" runat="server" Text=""></asp:Label>
    </p>
   
       
       


        <asp:Button ID="LogoutButton" runat="server" Text="Logout" CssClass="logoutButton"
            onclick="LogoutButton_Click" />
   

    </div>

    </form>
</body>
</html>
