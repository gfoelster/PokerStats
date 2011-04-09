using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PokerStatsDataAccess;
using System.Web.Security;
using System.Diagnostics;

namespace PokerStats
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DebugLabel.Text = GamesList.SelectedIndex.ToString();

            if (!Page.IsPostBack)
            {
                GamesList.DataSource = DataAccessProvider.Current.GetActiveGames();
                GamesList.DataBind();
            }
        }

        protected void GamesList_SelectedIndexChanged(object sender, EventArgs e)
        {
            int gameID = Convert.ToInt32(GamesList.SelectedItem.Value);

            bool joined = DataAccessProvider.Current.JoinGame(gameID, HttpContext.Current.User.Identity.Name);
            
            if(joined)            
                Response.Redirect("~/Game.aspx?id=" + gameID);
            else
                DebugLabel.Text = "Dieses Spiel ist leider schon voll.";
        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }

        protected void CreateButton_Click(object sender, EventArgs e)
        {
            // CHANGE Jeff
            // Alles ins DataAccess Projekt ausgelagert

            string gameName = NewGameName.Text.Trim();
            if (!String.IsNullOrEmpty(gameName) && !DataAccessProvider.Current.GameNameExists(gameName))
            {
                int newGameID = DataAccessProvider.Current.StartNewGame(gameName, HttpContext.Current.User.Identity.Name);

                Debug.WriteLine(newGameID);
                Response.Redirect("~/Game.aspx?id=" + newGameID);
            }
            else
                DebugLabel.Text = "Der Name ist leider schon vergeben, bitte wähle einen neuen.";
        }
    }
}