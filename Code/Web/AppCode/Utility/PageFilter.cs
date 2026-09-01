using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.Web.Utility
{
    public class PageFilter
    {
        // 过滤ViewState
        public static string ViewStateFilter(string strHTML)
        {
            string matchString1 = "type=\"hidden\" name=\"__VIEWSTATE\" id=\"__VIEWSTATE\"";
            string matchString2 = "type=\"hidden\" name=\"__EVENTVALIDATION\" id=\"__EVENTVALIDATION\"";
            string matchString3 = "type=\"hidden\" name=\"__EVENTTARGET\" id=\"__EVENTTARGET\"";
            string matchString4 = "type=\"hidden\" name=\"__EVENTARGUMENT\" id=\"__EVENTARGUMENT\"";

            string positiveLookahead1 = "(?=.*(" + Regex.Escape(matchString1) + "))";
            string positiveLookahead2 = "(?=.*(" + Regex.Escape(matchString2) + "))";
            string positiveLookahead3 = "(?=.*(" + Regex.Escape(matchString3) + "))";
            string positiveLookahead4 = "(?=.*(" + Regex.Escape(matchString4) + "))";

            RegexOptions opt = RegexOptions.IgnoreCase | RegexOptions.Singleline | RegexOptions.CultureInvariant | RegexOptions.Compiled;

            Regex[] arrRe = new Regex[] {
                new Regex("\\s*<div>" + positiveLookahead1 + "(.*?)</div>\\s*", opt),
                new Regex("\\s*<div>" + positiveLookahead2 + "(.*?)</div>\\s*", opt),
                new Regex("\\s*<div>" + positiveLookahead3 + "(.*?)</div>\\s*", opt),
                new Regex("\\s*<div>" + positiveLookahead3 + "(.*?)</div>\\s*", opt),
                new Regex("\\s*<div>" + positiveLookahead4 + "(.*?)</div>\\s*", opt)
            };

            foreach (Regex re in arrRe)
            {
                strHTML = re.Replace(strHTML, "");
            }

            return strHTML;
        }

        //以下是删除页面空白的方法：
        // 删除空白
        private static Regex tabsRe = new Regex("\\t", RegexOptions.Compiled | RegexOptions.Multiline);
        private static Regex carriageReturnRe = new Regex(">\\r\\n<", RegexOptions.Compiled | RegexOptions.Multiline);
        private static Regex carriageReturnSafeRe = new Regex("\\r\\n", RegexOptions.Compiled | RegexOptions.Multiline);
        private static Regex multipleSpaces = new Regex("  ", RegexOptions.Compiled | RegexOptions.Multiline);
        private static Regex spaceBetweenTags = new Regex(">\\s<", RegexOptions.Compiled | RegexOptions.Multiline);
        public static string WhitespaceFilter(string html)
        {
            html = tabsRe.Replace(html, string.Empty);
            html = carriageReturnRe.Replace(html, "><");
            html = carriageReturnSafeRe.Replace(html, " ");

            while (multipleSpaces.IsMatch(html))
                html = multipleSpaces.Replace(html, " ");

            html = spaceBetweenTags.Replace(html, "><");

            html = html.Replace("//<![CDATA[", "");
            html = html.Replace("//]]>", "");

            return html;
        }

        //以下是删除ASP.NET控件的垃圾UniqueID名称方法：
        // 过滤NamingContainer
        public static string NamingContainerFilter(string html)
        {
            RegexOptions opt =
                RegexOptions.IgnoreCase |
                RegexOptions.Singleline |
                RegexOptions.CultureInvariant |
                RegexOptions.Compiled;

            Regex re = new Regex("( name=\")(?=.*(" + Regex.Escape("$") + "))([^\"]+?)(\")", opt);

            html = re.Replace(html, new MatchEvaluator(delegate(Match m)
            {
                int lastDollarSignIndex = m.Value.LastIndexOf('$');

                if (lastDollarSignIndex >= 0)
                {
                    return m.Groups[1].Value + m.Value.Substring(lastDollarSignIndex + 1);
                }
                else
                {
                    return m.Value;
                }
            }));

            return html;
        }
    }

}