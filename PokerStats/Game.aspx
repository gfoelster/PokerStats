﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Game.aspx.cs" Inherits="PokerStats.Game" %>

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
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <br />
    </div>
    <p>
        <input id="Button1" type="button" value="button" onclick="return doIt()" />
        <img id="img1" alt="" src="" style="width: 108px" /></p>
    </form>
</body>
</html>
