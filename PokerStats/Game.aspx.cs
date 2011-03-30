using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PokerStats
{
    public partial class Game : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = Request.Params["id"];

            if (Request.Params["ajax"] != null)
            {
                Response.Write(DateTime.Now.ToString());
                Response.End();
            }
        }
    }
}