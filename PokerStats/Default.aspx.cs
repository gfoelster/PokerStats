using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PokerStats.Tools;
using System.Web.Security;
using PokerStatsDataAccess;

namespace PokerStats
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var ctx = new PokerDBDataContext();
            List<ActionType> x = ctx.ActionTypes.ToList();

            
        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }
    }
}
