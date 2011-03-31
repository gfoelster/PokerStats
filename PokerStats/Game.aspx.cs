﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

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
                Response.Write("./cards/"+cardNumber+"h.png");
                Response.Write(",");
                Response.Write(DateTime.Now.ToString());
                Response.End();
            }
        }
    }
}