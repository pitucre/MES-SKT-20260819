using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.ESOP.BLL;
using System.Web;
using System.Web.UI;
using System.Text;
using System.Runtime.InteropServices;

namespace SKT.LeanMES.Web.Product
{
    public partial class ESOPFileView : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEsop));
            //var ip = GetClientIP();
            //hidMachineMac.Value = GetMacAddress(ip);  
            string Tmp_ClientIP = "";
            string Tmp_ClientMac = "";
            GetClientMac(out Tmp_ClientIP, out Tmp_ClientMac);
            hidMachineMac.Value = Tmp_ClientMac;

        }

        [DllImport("Iphlpapi.dll")]
        static extern int SendARP(Int32 DestIP, Int32 SrcIP, ref Int64 MacAddr, ref Int32 PhyAddrLen);

        [DllImport("Ws2_32.dll")]
        static extern Int32 inet_addr(string ipaddr);

        ///<summary>  
        /// SendArp获取MAC地址  
        ///</summary>  
        ///<param name="RemoteIP">目标机器的IP地址如(192.168.1.1)</param>  
        ///<returns>目标机器的mac 地址</returns>  
        public static string GetMacAddress(string RemoteIP)
        {
            StringBuilder macAddress = new StringBuilder();
            try
            {
                Int32 remote = inet_addr(RemoteIP);
                Int64 macInfo = new Int64();
                Int32 length = 6;
                SendARP(remote, 0, ref macInfo, ref length);
                string temp = Convert.ToString(macInfo, 16).PadLeft(12, '0').ToUpper();
                int x = 12;
                for (int i = 0; i < 6; i++)
                {
                    if (i == 5)
                    {
                        macAddress.Append(temp.Substring(x - 2, 2));
                    }
                    else
                    {
                        macAddress.Append(temp.Substring(x - 2, 2) + "-");
                    }
                    x -= 2;
                }
                return macAddress.ToString();
            }
            catch
            {
                return macAddress.ToString();
            }
        }

        //获取客户IP地址#region 获取客户IP地址
        public static string GetClientIP()
        {
            string result = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (null == result || result == String.Empty)
            {
                result = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            if (null == result || result == String.Empty)
            {
                result = HttpContext.Current.Request.UserHostAddress;
            }
            return result;
        }

        //获取客户MAC地址#region 获取客户MAC地址
        public static string GetClientMac(out string Tmp_ClientIP, out string Tmp_ClientMac)
        {
            Tmp_ClientIP = "";
            Tmp_ClientMac = "";
            try
            {
                string strClientIP = GetClientIP();
                Int32 ldest = inet_addr(strClientIP); //目的地的ip
                Int64 macinfo = new Int64();
                Int32 len = 6;
                int res = SendARP(ldest, 0, ref macinfo, ref len);
                string mac_src = macinfo.ToString("X");

                if (mac_src == "0")
                {
                    if (strClientIP == "192.168.0.88")
                        Tmp_ClientIP = "本地测试";
                    else
                        Tmp_ClientIP = strClientIP;
                    //return;
                }

                while (mac_src.Length < 12)
                {
                    mac_src = mac_src.Insert(0, "0");
                }

                for (int i = 0; i < 11; i++)
                {
                    if (0 == (i % 2))
                    {
                        if (i == 10)
                        {
                            Tmp_ClientMac = Tmp_ClientMac.Insert(0, mac_src.Substring(i, 2));
                        }
                        else
                        {
                            Tmp_ClientMac = "-" + Tmp_ClientMac.Insert(0, mac_src.Substring(i, 2));
                        }
                    }
                }
                return Tmp_ClientMac;
            }
            catch
            {
                return "";
            }

        }
    }
}