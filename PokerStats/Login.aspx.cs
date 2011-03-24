﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PokerStats.Tools;
using System.Web.Security;

namespace PokerStats.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            ErrorLabel.Visible = false;
            var ctx = new DAL.PokerDBDataContext();

            string login = UserName.Text.Trim();
            string passwordHash = EncryptionHelper.EncryptString(Password.Text.Trim());

            if (ctx.Users.Any(u => u.Login == login && u.PasswordHash == passwordHash))
            {
                FormsAuthentication.SetAuthCookie(login, RememberMe.Checked);
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                ErrorLabel.Visible = true;
            }
        }
    }
}