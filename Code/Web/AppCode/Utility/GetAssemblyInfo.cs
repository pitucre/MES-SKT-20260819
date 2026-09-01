using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Reflection;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    public class GetAssemblyInfo
    {
        /// <summary>
        /// 获取程序的版本，取前三位，如果第三位为0则取前两位
        /// </summary>
        /// <returns></returns>
        public static string GetApplicationVersion()
        {
            string applicationVersion = "";
            string verInfo = GetVersion();
            string[] verInfoArr = verInfo.Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries);
            string ver1 = (verInfoArr.Length < 1) ? "0" : verInfoArr[0].ToString();
            string ver2 = (verInfoArr.Length < 2) ? "0" : verInfoArr[1].ToString();
            string ver3 = (verInfoArr.Length < 3) ? "0" : verInfoArr[2].ToString();
            string ver4 = (verInfoArr.Length < 4) ? "0" : verInfoArr[3].ToString();

            applicationVersion = ver1 + "." + ver2;
            if (ver3 != "0")
            {
                applicationVersion += "." + ver3;
            }
            return applicationVersion;
        }

        /// <summary>
        /// 获取程序的完整版本，四位版本编号，如： 1.0.0.0
        /// </summary>
        /// <returns></returns>
        public static string GetAppicationFullVersion()
        {
            return GetVersion();
        }

        /// <summary>
        /// 获取程序版本信息
        /// </summary>
        /// <returns></returns>
        private static string GetVersion()
        {
            return ConfigurationManager.AppSettings["Version"];
            //return Assembly.GetExecutingAssembly().GetName().Version.ToString();
        }

        /// <summary>
        /// 版本名：标准版，冲锋版，Express，Demo，每个版本对应此属性在此修改
        /// </summary>
        public static string VERSION_NAME = "(标准版)";

        public static string GetApplicationSoftwareName() {
            string VersionName = ConfigurationManager.AppSettings["SoftwareName"];
            return string.Format("产品名称{0}{1}",string.IsNullOrEmpty(Resources.Common.Colon)? "：": Resources.Common.Colon, string.IsNullOrEmpty(VersionName) ? Resources.Common.AppName : VersionName);
                
        }
        
        public static string GetApplicationVersionName()
        {
            string VersionName = ConfigurationManager.AppSettings["VersionName"];
            return string.Format("{0}", string.IsNullOrEmpty(VersionName) ? "" : "("+ VersionName + ")");

        }
        public static string GetApplicationGroupVersionName()
        {
            string VersionName = ConfigurationManager.AppSettings["GroupVersionName"];
            return string.Format("{0}", string.IsNullOrEmpty(VersionName) ? "" : "(" + VersionName + ")");

        }
        public static string GetApplicationChannelVersionName()
        {
            string ChannelVersionName = ConfigurationManager.AppSettings["ChannelVersionName"];
            return string.Format("{0}", string.IsNullOrEmpty(ChannelVersionName) ? "" : ChannelVersionName);

        }
        
    }
}