using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    public class AESHelper
    {
        private readonly static string DefaultKey = "1234567890123456";
        private readonly static string DefaultIV = "1234567890123456";

        /// <summary>
        /// Aes解密
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        public static string DecryptString(string cipherText)
        {
            try
            {
                // 将字符串转换为 UTF8 字节数组
                byte[] keyBytes = Encoding.UTF8.GetBytes(DefaultKey);
                byte[] ivBytes = Encoding.UTF8.GetBytes(DefaultIV);
                byte[] cipherBytes = Convert.FromBase64String(cipherText);

                using (Aes aes = Aes.Create())
                {
                    // 关键配置（必须与前端一致）
                    aes.Key = keyBytes;
                    aes.IV = ivBytes;
                    aes.Mode = CipherMode.CBC;
                    aes.Padding = PaddingMode.PKCS7;

                    using (ICryptoTransform decryptor = aes.CreateDecryptor())
                    using (MemoryStream ms = new MemoryStream(cipherBytes))
                    using (CryptoStream cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read))
                    using (StreamReader sr = new StreamReader(cs))
                    {
                        return sr.ReadToEnd();
                    }
                }
            }
            catch (CryptographicException ex)
            {
                throw new Exception($"解密失败: {ex.Message}");
            }
        }
    }
}