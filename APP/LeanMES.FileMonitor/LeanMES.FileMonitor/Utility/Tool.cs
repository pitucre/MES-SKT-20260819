using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.Configuration;
using System.Windows.Forms;
using System.IO;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Security.Cryptography;
using System.Xml;

using System.Threading;
using System.Net.Http;
using System.Threading.Tasks;

namespace LeanMES.FileMonitor.Utility
{
    public class Tool
    {

        public static string MD5Encode(string strText)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] result = md5.ComputeHash(System.Text.Encoding.UTF8.GetBytes(strText));
            return BitConverter.ToString(result).Replace("-", "").ToLower();
        }

        public static byte[] GetByteData(string s)
        {
            byte[] data = new byte[s.Length / 2];
            for (int i = 0; i < s.Length / 2; i++)
            {
                if (s[i * 2] <= '9')
                {
                    data[i] = (byte)((s[i * 2] - '0') * 16);
                }
                else if (s[i * 2] <= 'f' && s[i * 2] >= 'a')
                {
                    data[i] = (byte)((s[i * 2] - 'a' + 10) * 16);
                }
                else if (s[i * 2] <= 'F' && s[i * 2] >= 'A')
                {
                    data[i] = (byte)((s[i * 2] - 'A' + 10) * 16);
                }

                if (s[i * 2 + 1] <= '9')
                {
                    data[i] = (byte)(data[i] + (byte)((s[i * 2 + 1] - '0')));
                }
                else if (s[i * 2 + 1] <= 'f' && s[i * 2 + 1] >= 'a')
                {
                    data[i] = (byte)(data[i] + (byte)((s[i * 2 + 1] - 'a' + 10)));
                }
                else if (s[i * 2 + 1] <= 'F' && s[i * 2 + 1] >= 'A')
                {
                    data[i] = (byte)(data[i] + (byte)((s[i * 2 + 1] - 'A' + 10)));
                }
            }
            return data;
        }

        public static string GetHexString(string str)
        {
            int len = str.Length;
            string datarev = "";
            int i = 0;
            for (i = 0; i < (len) / 3; i++)
            {
                if ((ishex(str[3 * i])) && (ishex(str[3 * i + 1])) && (str[3 * i + 2] == ' '))
                {
                    datarev = datarev + str[3 * i] + str[3 * i + 1];
                }
                else if ((ishex(str[3 * i])) && (ishex(str[3 * i + 1])) && (3 * i + 2 == len))
                {
                    datarev = datarev + str[3 * i] + str[3 * i + 1];
                }
            }
            if (len - i * 3 == 2)
            {
                if ((ishex(str[len - 1])) && (ishex(str[len - 2])))
                {
                    datarev = datarev + str[len - 2] + str[len - 1];
                }
            }
            return datarev;
        }
        public bool ishexstring(string strl)
        {
            string del = "  ";
            string str = strl.Trim(del.ToCharArray());
            int len = str.Length;
            bool re = false;
            for (int i = 0; i < (len) / 3; i++)
            {
                if ((ishex(str[3 * i])) && (ishex(str[3 * i + 1])) && (str[3 * i + 2] == ' '))
                {
                    re = true;
                }
                else if ((ishex(str[3 * i])) && (ishex(str[3 * i + 1])) && (3 * i + 2 == len))
                {
                    re = true;
                }
                else
                {
                    re = false;
                }
            }
            return re;
        }

        public static bool ishex(char x)
        {
            bool re = false;
            if ((x <= '9') && (x >= '0'))
            {
                re = true;
            }
            else if ((x <= 'F') && (x >= 'A'))
            {
                re = true;
            }
            else if ((x <= 'f') && (x >= 'a'))
            {
                re = true;
            }

            return re;
        }
        /// <summary>
        /// 十进制转换为二进制
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public static string DecToBin(string x)
        {
            string z = null;
            int X = Convert.ToInt32(x);
            int i = 0;
            long a, b = 0;
            while (X > 0)
            {
                a = X % 2;
                X = X / 2;
                b = b + a * Pow(10, i);
                i++;
            }
            z = Convert.ToString(b);
            if (z == "0")
            {
                z = "00";
            }


            return z;
        }

        /// <summary>
        /// 16进制转ASCII码
        /// </summary>
        /// <param name="hexString"></param>
        /// <returns></returns>
        public static string HexToAscii(string hexString)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i <= hexString.Length - 2; i += 2)
            {
                sb.Append(
                    Convert.ToString(
                        Convert.ToChar(Int32.Parse(hexString.Substring(i, 2),
                                                   System.Globalization.NumberStyles.HexNumber))));
            }
            return sb.ToString();
        }

        /// <summary>
        /// 十进制转换为八进制
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public static string DecToOtc(string x)
        {
            string z = null;
            int X = Convert.ToInt32(x);
            int i = 0;
            long a, b = 0;
            while (X > 0)
            {
                a = X % 8;
                X = X / 8;
                b = b + a * Pow(10, i);
                i++;
            }
            z = Convert.ToString(b);
            return z;
        }

        /// <summary>
        /// 十进制转换为十六进制
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public static string DecToHex(string x)
        {
            if (string.IsNullOrEmpty(x))
            {
                return "0";
            }
            string z = null;
            int X = Convert.ToInt32(x);
            Stack a = new Stack();
            int i = 0;
            while (X > 0)
            {
                a.Push(Convert.ToString(X % 16));
                X = X / 16;
                i++;
            }
            while (a.Count != 0)
                z += ToHex(Convert.ToString(a.Pop()));
            if (string.IsNullOrEmpty(z))
            {
                z = "0";
            }
            return z;
        }

        /// <summary>
        /// 二进制转换为十进制
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public static string BinToDec(string x)
        {
            string z = null;
            if (String.IsNullOrEmpty(x))
            {
                x = "00";
            }
            Int64 X = Convert.ToInt64(x);
            int i = 0;
            long a, b = 0;
            while (X > 0)
            {
                a = X % 10;
                X = X / 10;
                b = b + a * Pow(2, i);
                i++;
            }
            z = Convert.ToString(b);
            return z;
        }

        /// <summary>
        /// 二进制转换为十进制，定长转换
        /// </summary>
        /// <param name="x"></param>
        /// <param name="iLength"></param>
        /// <returns></returns>
        public static string BinToDec(string x, short iLength)
        {
            StringBuilder sb = new StringBuilder();
            int iCount = 0;

            iCount = x.Length / iLength;

            if (x.Length % iLength > 0)
            {
                iCount += 1;
            }

            int X = 0;

            for (int i = 0; i < iCount; i++)
            {
                if ((i + 1) * iLength > x.Length)
                {
                    X = Convert.ToInt32(x.Substring(i * iLength, (x.Length - iLength)));
                }
                else
                {
                    X = Convert.ToInt32(x.Substring(i * iLength, iLength));
                }
                int j = 0;
                long a, b = 0;
                while (X > 0)
                {
                    a = X % 10;
                    X = X / 10;
                    b = b + a * Pow(2, j);
                    j++;
                }
                sb.AppendFormat("{0:D2}", b);
            }
            return sb.ToString();
        }

        /// <summary>
        /// 二进制转换为十六进制，定长转换
        /// </summary>
        /// <param name="x"></param>
        /// <param name="iLength"></param>
        /// <returns></returns>
        public static string BinToHex(string x, short iLength)
        {
            StringBuilder sb = new StringBuilder();
            int iCount = 0;

            iCount = x.Length / iLength;

            if (x.Length % iLength > 0)
            {
                iCount += 1;
            }

            int X = 0;

            for (int i = 0; i < iCount; i++)
            {
                if ((i + 1) * iLength > x.Length)
                {
                    X = Convert.ToInt32(x.Substring(i * iLength, (x.Length - iLength)));
                }
                else
                {
                    X = Convert.ToInt32(x.Substring(i * iLength, iLength));
                }
                int j = 0;
                long a, b = 0;
                while (X > 0)
                {
                    a = X % 10;
                    X = X / 10;
                    b = b + a * Pow(2, j);
                    j++;
                }
                //前补0
                sb.Append(DecToHex(b.ToString()));
            }
            return sb.ToString();
        }

        /// <summary>
        /// 八进制转换为十进制
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public static string OctToDec(string x)
        {
            string z = null;
            int X = Convert.ToInt32(x);
            int i = 0;
            long a, b = 0;
            while (X > 0)
            {
                a = X % 10;
                X = X / 10;
                b = b + a * Pow(8, i);
                i++;
            }
            z = Convert.ToString(b);
            return z;
        }


        /// <summary>
        /// 十六进制转换为十进制
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public static string HexToDec(string x)
        {
            if (string.IsNullOrEmpty(x))
            {
                return "0";
            }
            string z = null;
            Stack a = new Stack();
            int i = 0, j = 0, l = x.Length;
            long Tong = 0;
            while (i < l)
            {
                a.Push(ToDec(Convert.ToString(x[i])));
                i++;
            }
            while (a.Count != 0)
            {
                Tong = Tong + Convert.ToInt64(a.Pop()) * Pow(16, j);
                j++;
            }
            z = Convert.ToString(Tong);
            return z;
        }



        /// <summary>
        /// 
        /// </summary>
        /// <param name="x"></param>
        /// <param name="y"></param>
        /// <returns></returns>
        private static long Pow(long x, long y)
        {
            int i = 1;
            long X = x;
            if (y == 0)
                return 1;
            while (i < y)
            {
                x = x * X;
                i++;
            }
            return x;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        private static string ToDec(string x)
        {
            switch (x)
            {
                case "A":
                    return "10";
                case "B":
                    return "11";
                case "C":
                    return "12";
                case "D":
                    return "13";
                case "E":
                    return "14";
                case "F":
                    return "15";
                default:
                    return x;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        private static string ToHex(string x)
        {
            switch (x)
            {
                case "10":
                    return "A";
                case "11":
                    return "B";
                case "12":
                    return "C";
                case "13":
                    return "D";
                case "14":
                    return "E";
                case "15":
                    return "F";
                default:
                    return x;
            }
        }

        /// <summary>
        /// 将16进制BYTE数组转换成16进制字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static string ToHexString(byte[] bytes) // 0xae00cf => "AE00CF "
        {
            string hexString = string.Empty;
            if (bytes != null)
            {
                StringBuilder strB = new StringBuilder();

                for (int i = 0; i < bytes.Length; i++)
                {
                    strB.Append(bytes[i].ToString("X2"));
                }
                hexString = strB.ToString();
            }
            return hexString;
        }


        public static String GetAppSeting(String key)
        {
            try
            {
                return ConfigurationSettings.AppSettings[key];
            }
            catch (Exception err)
            {
                Log.info(key + "没有配置:" + err.Message);
                return String.Empty;
            }
        }

        /// <summary>
        /// ping ip,测试能否ping通
        /// </summary>
        /// <param name="strIP">IP地址</param>
        /// <returns></returns>
        public static bool PingIp(string strIP)
        {
            bool bRet = false;
            try
            {
                Ping pingSend = new Ping();
                PingReply reply = pingSend.Send(strIP, 1000);
                if (reply.Status == IPStatus.Success)
                    bRet = true;
            }
            catch (Exception)
            {
                bRet = false;
            }
            return bRet;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="ipString">IP</param>
        /// <param name="port">端口</param>
        /// <returns></returns>
        public static bool CheckConnect(string ipString, int port)
        {
            bool right = false;
            System.Net.Sockets.TcpClient tcpClient = new System.Net.Sockets.TcpClient()
            { SendTimeout = 1000 };
           
            try
            {
                IPAddress ip = IPAddress.Parse(ipString);
                var result = tcpClient.BeginConnect(ip, port, null, null);
                var back = result.AsyncWaitHandle.WaitOne(2000);
                right = tcpClient.Connected;
            }
            catch (Exception ex)
            {
               return false;
            }
            tcpClient.Close();
          
            return right;
        }

   

        public static bool IsValidUrl(string url)
        {
            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "HEAD"; // 使用HEAD方法，只获取头信息，不下载内容
                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                {
                    return (response.StatusCode == HttpStatusCode.OK);
                }
            }
            catch (Exception)
            {
                return false; // 如果发生任何异常，则认为URL无效
            }
        }


        public static void SaveConfig(string AppKey, string AppValue)
        {
            try
            {

             
                XmlDocument xDoc = new XmlDocument();
                //获取App.config文件绝对路径
                String basePath = System.AppDomain.CurrentDomain.BaseDirectory;
                //basePath = basePath.Substring(0, basePath.Length - 10);
                String path = basePath + "EquimentCollection.exe.Config";
                //Log.info("配置写入path：" + path);

                xDoc.Load(path);

                XmlNode xNode;
                XmlElement xElem1;
                XmlElement xElem2;
                //修改完文件内容，还需要修改缓存里面的配置内容，使得刚修改完即可用
                //如果不修改缓存，需要等到关闭程序，在启动，才可使用修改后的配置信息
                Configuration cfa = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
                xNode = xDoc.SelectSingleNode("//appSettings");
                xElem1 = (XmlElement)xNode.SelectSingleNode("//add[@key='" + AppKey + "']");
                if (xElem1 != null)
                {
                    xElem1.SetAttribute("value", AppValue);
                    cfa.AppSettings.Settings[AppKey].Value = AppValue;
                }
                else
                {
                    xElem2 = xDoc.CreateElement("add");
                    xElem2.SetAttribute("key", AppKey);
                    xElem2.SetAttribute("value", AppValue);
                    xNode.AppendChild(xElem2);
                    cfa.AppSettings.Settings.Add(AppKey, AppValue);
                }
                //改变缓存中的配置文件信息（读取出来才会是最新的配置）
                cfa.Save();
                ConfigurationManager.RefreshSection("appSettings");
                xDoc.Save(path);
                Properties.Settings.Default.Reload();
            }
            catch (Exception e)
            {
                Log.info("配置写入：" + e.Message);
                string error = e.Message;

            }
        }


        public static void SetAppSeting(String key, string value)
        {
            try
            {
                Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
                AppSettingsSection app = config.AppSettings;
                app.Settings[key].Value = value;
                config.Save(ConfigurationSaveMode.Modified);
                ConfigurationManager.RefreshSection("appSettings");
            }
            catch (Exception err)
            {
                Log.info(key + "没有配置:" + err.Message);
            }
        }

        

        public static string GetInternalIp()
        {
            NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();

            foreach (NetworkInterface adapter in nics)
            {
                foreach (var uni in adapter.GetIPProperties().UnicastAddresses)
                {
                    if (uni.Address.AddressFamily == AddressFamily.InterNetwork)
                    {
                        return uni.Address.ToString();
                    }
                }
            }
            return "";
        }
        public static string GetMacAddress()
        {
            string physicalAddress = "";
            NetworkInterface[] nice = NetworkInterface.GetAllNetworkInterfaces();
            foreach (NetworkInterface adaper in nice)
            {
                if (adaper.Description == "en0")
                {
                    physicalAddress = adaper.GetPhysicalAddress().ToString();
                    break;
                }
                else
                {
                    physicalAddress = adaper.GetPhysicalAddress().ToString();
                    if (physicalAddress != "")
                    {
                        break;
                    };
                }
            }
            string mac = "";
            for (int i = 0; i < physicalAddress.Length; i++)
            {
                if (0 == (i % 2))
                {
                    if (i == 10)
                    {
                        mac = mac + physicalAddress.Substring(i, 2);
                    }
                    else
                    {
                        mac = mac + physicalAddress.Substring(i, 2) + "-";
                    }
                }
            }
            return mac;
        }
    }
}
