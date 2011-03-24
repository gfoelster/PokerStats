<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameLobby.aspx.cs" Inherits="PokerStats.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h1>Wilkommen in der Pokerstats Lobby</h1>
        <p>Bitte wähle ein Spiel aus, oder eröffne ein neues.</p>
    </div>
    <asp:ListBox ID="GamesList" runat="server" DataSourceID="Pokerstats" 
        DataTextField="Name" DataValueField="Name" 
        onselectedindexchanged="GamesList_SelectedIndexChanged" 
        AutoPostBack="True"></asp:ListBox>
    <asp:SqlDataSource ID="Pokerstats" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PokerStatsConnectionString %>" 
        SelectCommand="SELECT [Name] FROM [Games] WHERE ([IsActive] = @IsActive)">
        <SelectParameters>
            <asp:Parameter DefaultValue="True" Name="IsActive" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
    <hr />
    <p>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Erstellen" />
    </p>
    <p>
        <asp:Label ID="DebugLabel" runat="server" Text="Label"></asp:Label>
    </p>
    </form>
</body>
</html>
