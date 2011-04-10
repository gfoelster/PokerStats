<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Game.aspx.cs" Inherits="PokerStats.Game" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
            <script type="text/javascript">
         <!--
                var aktiv = window.setInterval("doIt()", 1000);
                var cardnumber = 0;
                function doIt() {

                    //erstellen des requests
                    var req = null;

                    try {
                        req = new XMLHttpRequest();
                    }
                    catch (ms) {
                        try {
                            req = new ActiveXObject("Msxml2.XMLHTTP");
                        }
                        catch (nonms) {
                            try {
                                req = new ActiveXObject("Microsoft.XMLHTTP");
                            }
                            catch (failed) {
                                req = null;
                            }
                        }
                    }

                    if (req == null)
                        alert("Error creating request object!");

                    //anfrage erstellen (GET, url ist localhost,
                    //request ist asynchron      
                    req.open("GET", 'game.aspx?ajax=true&card=' + ((cardnumber % 9) + 2), true);
                    cardnumber++;

                    //Beim abschliessen des request wird diese Funktion ausgeführt
                    req.onreadystatechange = function () {
                        switch (req.readyState) {
                            case 4:
                                if (req.status != 200) {
                                    alert("Fehler: " + req.status);
                                } else {
                                    //alert("Status ist: " + req.status);
                                    //schreibe die antwort in den div container mit der id content
                                    var myResponse = req.responseText.split(",")
                                    document.getElementById("img1").src = myResponse[0];
                                    document.getElementById('Label1').innerHTML = '<strong>' +
                                                                        myResponse[1]
                                                                        + '</strong>';
                                }
                                break;

                            default:
                                return false;
                                break;
                        }
                    };

                    req.setRequestHeader("Content-Type",
                                      "application/x-www-form-urlencoded");
                    req.send(null);
                }

         //-->
            </script>

            <style type="text/css">
            
                .tableContainer
                {
                    width:1000px;
                    height:640px;
                    position:relative;
                    margin-left:auto;
                    margin-right:auto;
                    top:80px;
                    /*border:solid 1px black;*/
                }
                
            
                .tableBackground
                {
                    width: 715px; height: 334px; margin-top:155px;
                  
                }
                
                .playerPanel
                {
                    position:absolute; 
                    height: 142px; 
                    width: 115px; 
                    background-color:Gray;
                }
                
                .playerName
                {
                    margin-left:10px;
                }
                
                .chipStack
                {
                    position:absolute;
                    top:40px;
                    left:0px;
                }
                
                .avatar
                {
                    height:40px;
                    width:37px;   
                    position:absolute;
                    left:0px; top:0px;  
                }
                
                .leftcard
                {
                     height: 80px; width: 57px;
                     position:absolute;
                     left:0px;
                     bottom:0px;
                }
                
                .rightcard
                {
                     height: 80px; width: 57px;
                     position:absolute;
                     right:0px;
                     bottom:0px;
                }
                
                .player1  { top:120px; left:15px; }
                .player2  { top:0px; left:260px; }
                .player3  { top:0px; right:260px; }
                .player4  { top:120px; right:15px; }
                .player5  { bottom:120px; right:15px; }
                .player6  { bottom:0px; right:260px; }
                .player7  { bottom:0px; left:260px; }
                .player8  { bottom:120px; left:15px; }
                
                
            </style>
</head>
<body>
    <form id="form1" runat="server">
   
        <div class="tableContainer">

            <img id="table" alt="" src="Images/tablev2.png" class="tableBackground" />

            <div class="playerPanel player1">
                <img id="avatar" class="avatar" alt="" src="Images/anonymous_avatar.gif"  />
                <span class="playerName"> 1 </span>
                <span class="chipStack">Chips: </span>
                <img id="card1" class="leftcard" alt="" src="cards/3c.png" />
                <img id="card2" class="rightcard" alt="" src="cards/3s.png" />
            </div>

            <div class="playerPanel player2">
                <img id="Img1" class="avatar" alt="" src="Images/anonymous_avatar.gif"  />
                <span class="playerName"> 2 </span>
                <span class="chipStack">Chips: </span>
                <img id="Img2" class="leftcard" alt="" src="cards/3c.png" />
                <img id="Img3" class="rightcard" alt="" src="cards/3s.png" />
            </div>

            <div class="playerPanel player3">
                <img id="Img13" class="avatar" alt="" src="Images/anonymous_avatar.gif"  />
                <span class="playerName"> 3 </span>
                <span class="chipStack">Chips: </span>
                <img id="Img14" class="leftcard" alt="" src="cards/3c.png" />
                <img id="Img15" class="rightcard" alt="" src="cards/3s.png" />
            </div>

            <div class="playerPanel player4">
                <img id="Img16" class="avatar" alt="" src="Images/anonymous_avatar.gif"  />
                <span class="playerName"> 4 </span>
                <span class="chipStack">Chips: </span>
                <img id="Img17" class="leftcard" alt="" src="cards/3c.png" />
                <img id="Img18" class="rightcard" alt="" src="cards/3s.png" />
            </div>

            <div class="playerPanel player5">
                <img id="Img7" class="avatar" alt="" src="Images/anonymous_avatar.gif"  />
                <span class="playerName"> 5 </span>
                <span class="chipStack">Chips: </span>
                <img id="Img8" class="leftcard" alt="" src="cards/3c.png" />
                <img id="Img9" class="rightcard" alt="" src="cards/3s.png" />
            </div>

            <div class="playerPanel player6">
                <img id="Img10" class="avatar" alt="" src="Images/anonymous_avatar.gif"  />
                <span class="playerName"> 6 </span>
                <span class="chipStack">Chips: </span>
                <img id="Img11" class="leftcard" alt="" src="cards/3c.png" />
                <img id="Img12" class="rightcard" alt="" src="cards/3s.png" />
            </div>

            <div class="playerPanel player7">
                <img id="Img19" class="avatar" alt="" src="Images/anonymous_avatar.gif"  />
                <span class="playerName"> 7 </span>
                <span class="chipStack">Chips: </span>
                <img id="Img20" class="leftcard" alt="" src="cards/3c.png" />
                <img id="Img21" class="rightcard" alt="" src="cards/3s.png" />
            </div>

             <div class="playerPanel player8">
                <img id="Img4" class="avatar" alt="" src="Images/anonymous_avatar.gif"  />
                <span class="playerName"> 8 </span>
                <span class="chipStack">Chips: </span>
                <img id="Img5" class="leftcard" alt="" src="cards/3c.png" />
                <img id="Img6" class="rightcard" alt="" src="cards/3s.png" />
            </div>

        </div>        
    
        <p>
            <input id="Button1" type="button" value="button" onclick="return doIt()" />
        </p>

           <div style="text-align: center">
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            </div>
    </form>
</body>
</html>
