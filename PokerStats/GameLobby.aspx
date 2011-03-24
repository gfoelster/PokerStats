<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameLobby.aspx.cs" Inherits="PokerStats.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h1>Welcome to the Lobby</h1>
        <p>Please Select a Game from the List, or create a new one.</p>
    </div>
    <asp:ListBox ID="ListBox1" runat="server" DataSourceID="SqlDataSource1" 
        DataTextField="IsActive" DataValueField="IsActive"></asp:ListBox>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PokerStatsConnectionString %>" 
        SelectCommand="SELECT [IsActive] FROM [Games] WHERE ([IsActive] = @IsActive)">
        <SelectParameters>
            <asp:Parameter DefaultValue="true" Name="IsActive" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
