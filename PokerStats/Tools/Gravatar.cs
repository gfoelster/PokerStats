using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PokerStats.Tools
{
    public static class Gravatar
    {
        private const string GRAVATAR_BASE_URL = "http://www.gravatar.com/avatar/{0}";

        public static string GetImagePath(string email)
        {
            string gravatarReady = email.Trim().ToLower();

            System.Security.Cryptography.MD5CryptoServiceProvider md5Obj =
               new System.Security.Cryptography.MD5CryptoServiceProvider();

            byte[] bytesToHash = System.Text.Encoding.ASCII.GetBytes(gravatarReady);

            bytesToHash = md5Obj.ComputeHash(bytesToHash);

            string strResult = "";

            foreach (byte b in bytesToHash)
            {
                strResult += b.ToString("x2");
            }

            return String.Format(GRAVATAR_BASE_URL, strResult);
        }
    }
}