using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PokerStats.Tools;

namespace PokerStats
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var ctx = new DAL.PokerDBDataContext();
            List<DAL.ActionType> x = ctx.ActionTypes.ToList();

        }
    }
}
