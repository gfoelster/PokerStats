using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PokerStatsDataAccess;
using System.Web.Security;

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
            DebugLabel.Text = GamesList.SelectedIndex.ToString();
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
               
                //Response.Redirect("~/Game?id=" + newGameID);
            }
            else
                DebugLabel.Text = "Der Name ist leider schon vergeben, bitte wähle einen neuen.";

            //var ctx = new PokerDBDataContext();

            //List<Game> gamelist = ctx.Games.ToList();       // check if Name of new game is already in use
            //Boolean exists = false;
            //for (int i = 0; i < gamelist.Count; i++)
            //{
            //    exists = exists || (gamelist.ElementAt(i).Name == NewGameName.Text);
            //}

            //DebugLabel.Text = exists.ToString();

            //if (!exists)
            //{
            //    Game newgame = new Game();
            //    newgame.Name = NewGameName.Text;
            //    newgame.IsActive = true;
            //    newgame.StartTime = DateTime.Now;
            //    ctx.Games.InsertOnSubmit(newgame);
            //    ctx.SubmitChanges();
            //    return;
            //}


            
            //DebugLabel.Text="Der Name ist leider schon vergeben, bitte wähle einen neuen.";
 
        }

    }
}