<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Game.aspx.cs" Inherits="PokerStats.Game" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script type="text/javascript">
         <!--
        var chatPosition = -1;
        var eventPosition = -1;
        var currentUser;
        var allUsers = [];

        $(document).ready(function ()
        {
            $("#chatInputArea").keydown(function (e)
            {
                if (e.keyCode == '13') // if 'Enter'...
                {
                    e.preventDefault();
                    PostChatMessage();
                }
            }).focus();

            $("#chatSubmitButton").click(PostChatMessage);

            GetCurrentUser();
            var aktiv = window.setInterval("metaPolling()", 1000);
        });

        function metaPolling() 
        {
            pollEvents();
            pollChatMessages();
            $("#debugLabel").text(new Date().getSeconds());
        };

        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }

        function GetCurrentUser()
        {
            $.getJSON("game.aspx?ajax=true&type=user", function (user)
            {
                currentUser = user;

                // show avatar
                $("#userAvatar").attr("src", user.ImageID)
                                .attr("title", user.Name);
            });
        }

        function ProcessEvent(evt)
        {
            switch (evt.ActionTypeID)
            {
                case 1: DisplayText("JoinAction"); break;
                default: alert("Unknown action type!"); break;

            }
        }

        function DisplayText(text)
        {
            var output = $("#chatTextArea");
            output.val(output.val() + text + "\n")
                          .scrollTop(output[0].scrollHeight - output.height()); // scroll down 
        }

        function PostChatMessage() 
        {
             var message = $("#chatInputArea").val();
             if (message != '') {
                 var gameID = getUrlVars()["id"];

                 $.post("game.aspx?ajax=true&ID=" + gameID + "&type=postmessage", { chatmessage: message });
                    $("#chatInputArea").val("");

                    DisplayText(message);
             }
        }

        function pollChatMessages() 
        {
            var gameID = getUrlVars()["id"];

            var isReconnect = false;
            if (chatPosition == -1)
                isReconnect = true;

            $.getJSON("game.aspx?ajax=true&ID=" + gameID + "&position=" + chatPosition + "&type=chat&timestamp=" + new Date().getTime(), function (json)
            {
                if (json.length > 0)
                {
                    var items = "";
                    $.each(json, function (ndx, val)
                    {
                        if (isReconnect || val.UserID != currentUser.UserID) // filter out current user
                        {
                            items = items + val.UserID + ": " + val.Text;

                            if (ndx < json.length - 1)
                                items = items + "\n";
                        }

                        // increment chatposition
                        chatPosition = val.ChatMessageID;
                    });

                    if (items != '')
                        DisplayText(items);
                }
            });  
        };

        function pollEvents() 
        {
            var gameID = getUrlVars()["id"];
            $.getJSON("game.aspx?ajax=true&ID=" + gameID + "&position=" + eventPosition + "&type=event&timestamp=" + new Date().getTime(), function (json)
            {
                var items = "";

                $.each(json, function (ndx, val)
                {
                    items = items + ndx + "\t" + val.ActionTypeID + "\t" + val.Timestamp;

                    if (ndx < json.length - 1)
                        items = items + "\n";

                    // increment eventposition
                    eventPosition = val.GameActionID;

                    ProcessEvent(val);
                });
            });
        };
    </script>
    <style type="text/css">
        .chatArea
        {
            position: absolute;
            height: 150px;
            left: 0px;
            right: 8px;
            bottom: 0px;
            padding:5px;
            
        }
        .textArea
        {
             width:100%;
             height:115px;
        }
        
        #userAvatar
        {
            float:left;
            width:20px; height:20px;
            margin-top:4px;
            margin-right:3px;
        }
        
        #chatInputArea
        {
            margin-top:3px;
            width:250px;
            float:left;
        }
        
        #chatSubmitButton
        {
           margin-top:2px;
        }
        
        .clear
        {
            clear:both;
        }
        
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
            top: 20px; /*border:solid 1px black;*/
          
        }
        
        .tableBackground
        {
            position:absolute;
            width: 715px;
            height: 334px;
            margin-top:155px;
            margin-left: 142px;
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
        <span id="debugLabel"> 0 </span>
    </div>

    <div class="chatArea"> 
        
        <textarea class="textArea" id="chatTextArea" readonly="readonly"></textArea>

        <br />
        <img id="userAvatar" />
        <input id="chatInputArea" type="text" maxlength="299"/> 
        <input id="chatSubmitButton" type="button" value="Senden" />
        <br class="clear" />
    </div>
</body>
</html>
