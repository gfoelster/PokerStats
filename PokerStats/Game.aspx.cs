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

            string json = string.Empty;

            int gameID = -1;
            int position = -1;

            Int32.TryParse(Request.Params["ID"], out gameID);
            Int32.TryParse(Request.Params["position"], out position);
                
            if(Request["type"] != null)  // get game events, chat messages or current user
            {
                if (Request["type"] == "event")
                    json = GetEvents(gameID, position);
                else if (Request["type"] == "chat")
                    json = GetChatMessages(gameID, position);
                else if (Request["type"] == "user")
                    json = GetCurrentUser();
                else if (Request["type"] == "postmessage")
                {
                    string chatMessage = Request.Form["chatmessage"].Trim();
                    DataAccessProvider.Current.PostChatMessage(gameID, HttpContext.Current.User.Identity.Name, chatMessage);
                }
                
                Response.ContentType = "application/json";
                Response.Write(json);
                Response.End();
            }
        }

        private string GetEvents(int gameID, int position)
        {
            List<GameAction> gameActions = DataAccessProvider.Current.GetCommittedActions(gameID, position);
            
            // serialize to json
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(List<GameAction>));
            MemoryStream ms = new MemoryStream();
            serializer.WriteObject(ms, gameActions);
            string json = Encoding.Default.GetString(ms.ToArray());
            Debug.WriteLine(json);

            return json;
        }

        private string GetChatMessages(int gameID, int position)
        {
            List<ChatMessage> chatMessages = DataAccessProvider.Current.GetCommittedChatMessages(gameID, position, HttpContext.Current.User.Identity.Name);

            // serialize to json
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(List<ChatMessage>));
            MemoryStream ms = new MemoryStream();
            serializer.WriteObject(ms, chatMessages);
            string json = Encoding.Default.GetString(ms.ToArray());
            Debug.WriteLine(json);

            return json;
        }

        private string GetCurrentUser()
        {
            User user = DataAccessProvider.Current.GetUserByLogin(HttpContext.Current.User.Identity.Name);

            // set linked entities null for serialization
            user.GameAction = null;
            user.UserSeat = null;
            //user.ChatMessages = null;

            // no need to send login information to client
            user.PasswordHash = string.Empty;
            user.Login = string.Empty;

            // get gravatar image path
            user.ImageID = Gravatar.GetImagePath(HttpContext.Current.User.Identity.Name);
            // serialize to json
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(User));
            MemoryStream ms = new MemoryStream();
            serializer.WriteObject(ms, user);
            string json = Encoding.Default.GetString(ms.ToArray());
            Debug.WriteLine(json);

            return json;
        }
    }
}