using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    public static class ConfigHelper
    {
        /// <summary>
        /// 读取配置文件节点值
        /// </summary>
        /// <param name="appSettingNodeName">AppSetting节点名</param>
        /// <returns>AppSetting节点名对应的节点值</returns>
        public static string ReadConfigAppSettingNodeValue(string appSettingNodeName)
        {
            string appSettingNodeValue = "";

            Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
            AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
            if (appseting.Settings[appSettingNodeName] != null)
            {
                appSettingNodeValue = appseting.Settings[appSettingNodeName].Value;
            }

            return appSettingNodeValue;
        }

        /// <summary>
        /// 更新AppSetting节点值
        /// </summary>
        /// <param name="appSettingNodeName">AppSetting节点名</param>
        /// <param name="appSettingNodeValue">AppSetting节点值</param>
        public static void UpdateConfigAppSettingNodeValue(string appSettingNodeName, string appSettingNodeValue)
        {
            Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
            AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
            if (appseting.Settings[appSettingNodeName] == null)
            {
                throw new ApplicationException("节点[" + appSettingNodeName + "]不存在。");
            }
            else
            {
                appseting.Settings[appSettingNodeName].Value = appSettingNodeValue;
                config.Save(ConfigurationSaveMode.Modified);
            }
        }

        /// <summary>
        /// 添加AppSetting节点
        /// </summary>
        /// <param name="appSettingNodeName">AppSetting节点名</param>
        /// <param name="appSettingNodeValue">AppSetting节点值</param>
        public static void AddConfigAppSettingNode(string appSettingNodeName, string appSettingNodeValue)
        {
            Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
            AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
            if (appseting.Settings[appSettingNodeName] == null)
            {
                appseting.Settings.Add(new KeyValueConfigurationElement(appSettingNodeName, appSettingNodeValue));
                config.Save(ConfigurationSaveMode.Modified);
            }
        }
    }
}