using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using PokerStatsDataAccess;

namespace PokerStats
{
    public partial class Game : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = Request.Params["id"];

            if (Request.Params["ajax"] != null)
            {
                int cardNumber = Convert.ToInt32(Request.Params["card"]);
                Debug.WriteLine(cardNumber);
                Response.Write("cards/"+cardNumber);
                Response.Write(",");

                //if(Request.Params["gameID"] != null && Request.Params["position"] != null)
                //{
                //    int gameID = -1;
                //    int position = -1;

                //    if(Int32.TryParse(Request.Params["gameID"], out gameID) && (Int32.TryParse(Request.Params["position"], out position)))
                //    {
                //        List<GameAction> gameActions = DataAccessProvider.Current.GetCommittedActions(gameID, position);
                        
                //        // serialize to string somehow....
                //        string serialized = "blaaaaa";
                        
                //        Response.Write(serialized);
                //        Response.End();
                //    }
                //}

            

                Response.Write(DateTime.Now.ToString());
                Response.End();
            }


         
        }
    }
}