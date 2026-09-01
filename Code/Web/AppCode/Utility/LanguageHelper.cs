using SKT.LeanMES.Language.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    public static class LanguageHelper
    {
        /// <summary>
        /// 初始化资源
        /// </summary>
        static LanguageHelper()
        {
            LoadLanguages();
        }

        /// <summary>
        /// 最后一次修改时间
        /// </summary>
        public static DateTime? LastModifyTime = null;
        /// <summary>
        /// 多语言资源
        /// </summary>
        public static List<LanguageInfo> Languages = null;

        /// <summary>
        /// 加载多语言资源
        /// </summary>
        /// <param name="lastModifyTime"></param>
        public static void LoadLanguages(bool isUpdate = false)
        {
            //更新缓存数据
            var bll = new Language.BLL.Language();
            if (!LastModifyTime.HasValue || isUpdate)
            {
                LastModifyTime = bll.GetLastModifyTime();
            }
            if (Languages == null || isUpdate)
            {
                Languages = bll.GetAll(0, 100000000, "LanguageId DESC", null);
            }
        }
        /// <summary>
        /// 获取当前语言的JS文本
        /// </summary>
        /// <returns></returns>
        public static string GetCurLanguageJsText(string lang)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("var languages ={");
            foreach (var item in Languages)
            {
                switch (lang)
                {
                    case "zh-cn":
                        sb.AppendLine($"    \"{ProcessSpecialChar(item.LanguageKey)}\":\"{ProcessSpecialChar(item.CN)}\",");
                        break;
                    case "en-us":
                        sb.AppendLine($"    \"{ProcessSpecialChar(item.LanguageKey)}\":\"{ProcessSpecialChar(item.EN)}\",");
                        break;
                    default:
                        break;
                }
            }
            sb.AppendLine("};");
            return sb.ToString();
        }

        #region 私有方法

        /// <summary>
        /// 处理特殊字符
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        private static string ProcessSpecialChar(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return "";
            }
            return value.Replace("\r", "")
                .Replace("\n", "")
                .Replace("\r\n", "")
                .Replace("\"", "'")
                .Replace("\t", "");
        }

        #endregion
    }
}