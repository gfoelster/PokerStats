using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PokerStatsDataAccess;

namespace PokerStats
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DebugLabel.Text = GamesList.SelectedIndex.ToString();
        }

        protected void GamesList_SelectedIndexChanged(object sender, EventArgs e)
        {
            DebugLabel.Text = GamesList.SelectedIndex.ToString();
        }

        protected void CreateButton_Click(object sender, EventArgs e)
        {
            var ctx = new PokerDBDataContext();

            List<Game> gamelist = ctx.Games.ToList();       // check if Name of new game is already in use
            Boolean exists = false;
            for (int i = 0; i < gamelist.Count; i++)
            {
                exists = exists || (gamelist.ElementAt(i).Name == NewGameName.Text);
            }

            DebugLabel.Text = exists.ToString();

            if (!exists)
            {
                Game newgame = new Game();
                newgame.Name = NewGameName.Text;
                newgame.IsActive = true;
                newgame.StartTime = DateTime.Now;
                ctx.Games.InsertOnSubmit(newgame);
                ctx.SubmitChanges();
                return;
            }


            
            DebugLabel.Text="Der Name ist leider schon vergeben, bitte wähle einen neuen.";
 
        }

    }
}