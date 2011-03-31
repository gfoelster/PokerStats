<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="PokerStats._Default" %>
<html>
    <head>
        <title>Pokerstats</title>
        <script type="text/javascript">
      
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
                req.open("GET", 'http://81.20.84.98/eins/test.txt', true);

                //Beim abschliessen des request wird diese Funktion ausgeführt
                req.onreadystatechange = function () {
                    switch (req.readyState) {
                        case 4:
                            if (req.status != 200) {
                                alert("Fehler: " + req.status);
                            } else {
                                //alert("Status ist: " + req.status);
                                //schreibe die antwort in den div container mit der id content 
                                document.getElementById('eins').innerHTML = '<strong>' +
                                                                        req.responseText
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

        </script>
    </head>
    <body>
     <form id="form1" runat="server">
    <h2>
        Welcome to Pokerstats!
    </h2>
    <p>
        <asp:Button ID="LogoutButton" runat="server" Text="Logout" 
            onclick="LogoutButton_Click" />
    </p>
        <div id="eins" style="width: 80%; height: 80%; border: dashed 1px;">
            <input type="button" onclick="doIt();" value="Mach was!"/>
        </div>
        </form>
    </body>
</html>

