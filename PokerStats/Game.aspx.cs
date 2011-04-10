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
            if (Request.Params["ajax"] == null)
                return;
           
            if (Request.Params["ID"] != null && Request.Params["position"] != null) 
            {
                int gameID = -1;
                int position = -1;

                if (Int32.TryParse(Request.Params["ID"], out gameID) && (Int32.TryParse(Request.Params["position"], out position)))
                {
                    if(Request["type"] != null)  // get game events or chat messages
                    {
                        if (Request["type"] == "event")
                            GetEvents(gameID, position);
                        else if (Request["type"] == "chat")
                            GetChatMessages(gameID, position);
                    }
                    else if(Request.HttpMethod == "POST")   // post chat message
                    {
                        string chatMessage = Request.Form["chat"].Trim();
                        DataAccessProvider.Current.PostChatMessage(gameID, HttpContext.Current.User.Identity.Name, chatMessage);
                    }
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

        private void GetChatMessages(int gameID, int position)
        {
            List<ChatMessage> chatMessages = DataAccessProvider.Current.GetCommittedChatMessages(gameID, position);

            // set linked entities null for serialization
            chatMessages.ForEach((cm) => { cm.User = null; cm.Game = null; });

            // serialize to json
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(List<ChatMessage>));
            MemoryStream ms = new MemoryStream();
            serializer.WriteObject(ms, chatMessages);
            string json = Encoding.Default.GetString(ms.ToArray());
            Debug.WriteLine(json);
            Response.ContentType = "application/json";
            Response.Write(json);
            Response.End();
        }
    }
}