using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using PokerStatsDataAccess;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using PokerStats.Tools;

namespace PokerStats
{
    public partial class Game : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = Request.Params["id"];

            if (Request.Params["ajax"] == null)
                return;


            if (Request.Params["ID"] != null && Request.Params["position"] != null && (Request["event"] != null || Request["chat"] != null)) 
            {
                int gameID = -1;
                int position = -1;

                if (Int32.TryParse(Request.Params["ID"], out gameID) && (Int32.TryParse(Request.Params["position"], out position)))
                {
                    GetEvents(gameID, position);
                }
            }
            else if (Request.Params["ID"] != null && Request.HttpMethod == "POST")
            {
                if (Request.Form["chat"] != null)
                {
                    string chatMessage = Request.Form["chat"].Trim();


                }
            }
        }

        private void GetEvents(int gameID, int position)
        {
            List<GameAction> gameActions = DataAccessProvider.Current.GetCommittedActions(gameID, position);

            // set linked entities null for serialization
            gameActions.ForEach((ga) => { ga.User = null; ga.Game = null; });

            // serialize to json
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(List<GameAction>));
            MemoryStream ms = new MemoryStream();
            serializer.WriteObject(ms, gameActions);
            string json = Encoding.Default.GetString(ms.ToArray());
            Debug.WriteLine(json);
            Response.ContentType = "application/json";
            Response.Write(json);
            Response.End();
        }
    }
}