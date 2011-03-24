using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PokerStats.Tools;
using System.Web.Security;

namespace PokerStats
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var ctx = new DAL.PokerDBDataContext();
            List<DAL.ActionType> x = ctx.ActionTypes.ToList();
           
            //DAL.User u = new DAL.User()
            //{
            //    Name = "Jeff",
            //    PasswordHash = "Blub"
            //};
            //ctx.Users.InsertOnSubmit(u);
            //ctx.SubmitChanges();

            

        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }
    }
}
