using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;

namespace PokerStats.Tools
{
    public static class EncryptionFactory
    {
        public static HashAlgorithm GetHashAlgorithm()
        {
            HashAlgorithm hashAlgo = new SHA1Managed();
            return hashAlgo;
        }
    }

    public static class EncryptionHelper
    {
        public static string EncryptString(string str)
        {
            byte[] strData = Encoding.UTF8.GetBytes(str);

            HashAlgorithm hashAlgo = EncryptionFactory.GetHashAlgorithm();
            byte[] hash = hashAlgo.ComputeHash(strData);

            string strHash = BitConverter.ToString(hash);
            return strHash;
        }
    }
}