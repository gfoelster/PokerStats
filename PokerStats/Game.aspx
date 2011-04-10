﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Game.aspx.cs" Inherits="PokerStats.Game" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script type="text/javascript">
         <!--
        $(document).ready(function () {
            $("#Label1").text("XXX");
            for (var i = 2; i < 9; i++) {
                $("div #player" + i).hide("slow");
            }
        });

        //        var aktiv = window.setInterval("doIt()", 1000);
        var cardnumber = 0;
        function doIt() {
            //            cardnumber++;
            //            $.get('game.aspx?ajax=true&card=' + ((cardnumber % 9) + 2), function (data) {
            //                var splitted = data.split(",");
            //                $("#player1Card1").attr("src", splitted[0] + "c.png");
            //                $("#player1Card2").attr("src", splitted[0] + "s.png");

            //            });
            $.getJSON("game.aspx?ajax=true&ID=5&position=1", function (json) {
                var items = [];

                $.each(json, function (key, val) {
                    items.push('<li id="' + key + '">' + val + '</li>');
                });
                $('<ul/>', {
                    'class': 'my-new-list',
                    html: items.join('')
                }).appendTo('body');
            });
        };
    </script>
    <style type="text/css">
        .clickMeButton
        {
            position: relative;
            margin-bottom: auto;
            margin-left: auto;
        }
        
        .tableContainer
        {
            width: 1000px;
            height: 640px;
            position: relative;
            margin-left: auto;
            margin-right: auto;
            top: 80px; /*border:solid 1px black;*/
        }
        
        
        .tableBackground
        {
            width: 715px;
            height: 334px;
            margin-top: 155px;
        }
        
        .playerPanel
        {
            position: absolute;
            height: 142px;
            width: 115px;
            background-color: Gray;
        }
        
        .playerName
        {
            margin-left: 10px;
        }
        
        .chipStack
        {
            position: absolute;
            top: 40px;
            left: 0px;
        }
        
        .avatar
        {
            height: 40px;
            width: 37px;
            position: absolute;
            left: 0px;
            top: 0px;
        }
        
        .leftcard
        {
            height: 80px;
            width: 57px;
            position: absolute;
            left: 0px;
            bottom: 0px;
        }
        
        .rightcard
        {
            height: 80px;
            width: 57px;
            position: absolute;
            right: 0px;
            bottom: 0px;
        }
        
        .player1
        {
            top: 120px;
            left: 15px;
        }
        .player2
        {
            top: 0px;
            left: 260px;
        }
        .player3
        {
            top: 0px;
            right: 260px;
        }
        .player4
        {
            top: 120px;
            right: 15px;
        }
        .player5
        {
            bottom: 120px;
            right: 15px;
        }
        .player6
        {
            bottom: 0px;
            right: 260px;
        }
        .player7
        {
            bottom: 0px;
            left: 260px;
        }
        .player8
        {
            bottom: 120px;
            left: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="tableContainer">
        <img id="table" alt="" src="Images/tablev2.png" class="tableBackground" />
        <div id="player1" class="playerPanel player1">
            <img id="player1Avatar" class="avatar" alt="" src="Images/anonymous_avatar.gif" />
            <span class="playerName">1 </span><span class="chipStack">Chips: </span>
            <img id="player1Card1" class="leftcard" alt="" src="cards/3c.png" />
            <img id="player1Card2" class="rightcard" alt="" src="cards/3s.png" />
        </div>
        <div id="player2" class="playerPanel player2">
            <img id="player2Avatar" class="avatar" alt="" src="Images/anonymous_avatar.gif" />
            <span class="playerName">2 </span><span class="chipStack">Chips: </span>
            <img id="player2Card1" class="leftcard" alt="" src="cards/3c.png" />
            <img id="player2Card2" class="rightcard" alt="" src="cards/3s.png" />
        </div>
        <div id="player3" class="playerPanel player3">
            <img id="player3Avatar" class="avatar" alt="" src="Images/anonymous_avatar.gif" />
            <span class="playerName">3 </span><span class="chipStack">Chips: </span>
            <img id="player3Card1" class="leftcard" alt="" src="cards/3c.png" />
            <img id="player3Card2" class="rightcard" alt="" src="cards/3s.png" />
        </div>
        <div id="player4" class="playerPanel player4">
            <img id="player4Avatar" class="avatar" alt="" src="Images/anonymous_avatar.gif" />
            <span class="playerName">4 </span><span class="chipStack">Chips: </span>
            <img id="player4Card1" class="leftcard" alt="" src="cards/3c.png" />
            <img id="player4Card2" class="rightcard" alt="" src="cards/3s.png" />
        </div>
        <div id="player5" class="playerPanel player5">
            <img id="player5Avatar" class="avatar" alt="" src="Images/anonymous_avatar.gif" />
            <span class="playerName">5 </span><span class="chipStack">Chips: </span>
            <img id="player5Card1" class="leftcard" alt="" src="cards/3c.png" />
            <img id="player5Card2" class="rightcard" alt="" src="cards/3s.png" />
        </div>
        <div id="player6" class="playerPanel player6">
            <img id="player6Avatar" class="avatar" alt="" src="Images/anonymous_avatar.gif" />
            <span class="playerName">6 </span><span class="chipStack">Chips: </span>
            <img id="player6Card1" class="leftcard" alt="" src="cards/3c.png" />
            <img id="player6Card2" class="rightcard" alt="" src="cards/3s.png" />
        </div>
        <div id="player7" class="playerPanel player7">
            <img id="player7Avatar" class="avatar" alt="" src="Images/anonymous_avatar.gif" />
            <span class="playerName">7 </span><span class="chipStack">Chips: </span>
            <img id="player7Card1" class="leftcard" alt="" src="cards/3c.png" />
            <img id="player7Card2" class="rightcard" alt="" src="cards/3s.png" />
        </div>
        <div id="player8" class="playerPanel player8">
            <img id="player8Avatar" class="avatar" alt="" src="Images/anonymous_avatar.gif" />
            <span class="playerName">8 </span><span class="chipStack">Chips: </span>
            <img id="player8Card1" class="leftcard" alt="" src="cards/3c.png" />
            <img id="player8Card2" class="rightcard" alt="" src="cards/3s.png" />
        </div>
    </div>
    <div>
        <input class="clickMeButton" id="Button1" type="button" value="Click me!" onclick="return doIt()" />
    </div>
    <div style="text-align: center">
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    </div>
    </form>
</body>
</html>
