using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace SKT.LeanMES.SqlInjection.BLL
{
    public static class SqlInjectionHelper
    {

        private const string cacheKey = "sqlKeywords";
        /// <summary>
        /// 一般处理程序sql 注入验证
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static void Validation(HttpContext context)
        {

            // 获取查询字符串参数
            var queryStringParams = context.Request.QueryString;
            foreach (string key in queryStringParams.Keys)
            {
                string value = queryStringParams[key];

                if (string.IsNullOrEmpty(value))
                {
                    continue;
                }
                if (IsSqlInjectable(value))
                {
                    throw new Exception($"SQL注入检测异常:{key}");
                }
                // 处理查询字符串参数
            }

            // 获取表单参数（例如POST数据）
            var formParams = context.Request.Form;
            foreach (string key in formParams.Keys)
            {
                string value = formParams[key];
                if (string.IsNullOrEmpty(value))
                {
                    continue;
                }
                if (IsSqlInjectable(value))
                {
                    throw new Exception($"SQL注入检测异常:{key}");
                }
            }
        }


        /// <summary>
        /// 主要是对sql 查询关键字注入的补充校验
        /// </summary>
        /// <param name="paramValue"></param>
        /// <returns></returns>
        private static bool IsSqlInjectable(string paramValue)
        {
            if (string.IsNullOrEmpty(paramValue)) return false;

            var listSqlKeyword = new List<string>()
            {
                "SELECT", "FROM", "WHERE", "JOIN", "UNION"
            };
            //判断输入是否包含关键词整个单词
            var query = from a in listSqlKeyword
                        where Regex.IsMatch(paramValue, $@"\b{Regex.Escape(a)}\b", RegexOptions.IgnoreCase)
                        select a;
            var sql = query.FirstOrDefault();
            if (sql != null)
            {
                return true;
            }

            return false;
        }


        /// <summary>
        /// 读取sql注入关键字缓存， 如果不存在则读取文件
        /// </summary>
        /// <returns></returns>
        public static List<string> GetSqlKeywordList()
        {
            var sqlKeywords = (List<string>)CacheHelper.GetCache(cacheKey);

            if (sqlKeywords == null || sqlKeywords.Count <= 0)
            {
                string filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlKeyword.txt");
                if (File.Exists(filePath))
                {
                    sqlKeywords = File.ReadAllText(filePath)
                        .Split(new char[] { ';', ',' }, StringSplitOptions.RemoveEmptyEntries)
                        .ToList();
                    // 写入缓存， 30分钟更新一次
                    CacheHelper.SetCache(cacheKey, sqlKeywords, 30);
                }
            }
            return sqlKeywords;
        }
        /// <summary>
        /// SQL注入
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        public static void SecurityValidate_SQL(string json, HttpContext httpContext)
        {
            var listSqlKeyword = GetSqlKeywordList();

            if (listSqlKeyword == null || listSqlKeyword.Count <= 0) return;
            //// 移除忽略的关键字
            //HashSet<string> ignoreCaseSet = new HashSet<string>(
            //    ignoreKeywords,
            //    StringComparer.OrdinalIgnoreCase
            //);

            //listSqlKeyword.RemoveAll(item => ignoreCaseSet.Contains(item));


            var list = new Dictionary<string, string>();
            Dictionary<string, object> dic = null;
            try
            {
                if (!string.IsNullOrWhiteSpace(json))
                {
                    dic = JsonConvert.DeserializeObject<Dictionary<string, object>>(json);
                }
            }
            catch
            {

            }
            if (dic != null)
            {
                //Json格式
                foreach (var item in dic)
                {
                    if (item.Value == null)
                        continue;
                    if (item.Value.GetType().Name.Equals("String"))
                    {
                        list.Add(item.Key, item.Value.ToString());
                    }
                    else if (item.Value.GetType().Name.Equals("JObject"))
                    {
                        SecurityValidate_SQL(JsonConvert.SerializeObject(item.Value), httpContext);
                    }
                }
            }
            else
            {
                //Form表单
                foreach (var key in httpContext.Request.Form.AllKeys)
                {
                    // 忽略掉 删除操作传入参数 
                    if (!list.ContainsKey(key))
                    {
                        list.Add(key, httpContext.Request.Form[key]);
                    }
                }
            }
            //查询字符串
            foreach (var key in httpContext.Request.QueryString.AllKeys)
            {
                if (key == null)
                {
                    continue;
                }
                if (!list.ContainsKey(key))
                {
                    list.Add(key, httpContext.Request.QueryString[key]);
                }
            }
            //验证
            foreach (var item in list)
            {
                var value = item.Value;
                // 多个空格替换成一个
                value = Regex.Replace(value, @"\s+", " ");
                if (string.IsNullOrWhiteSpace(value))
                {
                    continue;
                }

                //布尔恒真条件的拦截
                Regex booleanInjectionRegex = new Regex(
                    @"(?i)(['""]\s*(or|and)\s*['""]?[01]?['""]?\s*=\s*['""]?[01]?['""]?)",
                    RegexOptions.Compiled
                );

                if (booleanInjectionRegex.IsMatch(value))
                {
                    throw new Exception($"SQL注入检测：非法输入'{value}'包含非法字符:{booleanInjectionRegex.Match(value).Value}");
                }

                // 综合危险操作检测

                if (IsSqlInjection(value))
                {
                    throw new Exception($"SQL注入检测：非法输入'{value}'");
                }

                //var query1 = from a in listSqlKeyword
                //             where
                //             Regex.IsMatch(value,
                //              $@"(?i)(['\s]?(and|or|exec)['\s]?{Regex.Escape(a)}.*-{{2,}})",
                //              RegexOptions.IgnoreCase
                //             )
                //             select a;
                //var sql1 = query1.FirstOrDefault();

                //if (sql1 != null)
                //{
                //    throw new Exception($"SQL注入检测：非法输入'{value}'包含非法字符:{sql1}");
                //}

                //  数据库关键字验证
                var query = from a in listSqlKeyword
                            where
                            !value.Equals("create", StringComparison.OrdinalIgnoreCase) &&
                            !value.Equals("delete", StringComparison.OrdinalIgnoreCase) &&
                            !value.Equals("insert", StringComparison.OrdinalIgnoreCase) &&
                            !value.Equals("update", StringComparison.OrdinalIgnoreCase) 
                            &&
                            (
                            Regex.IsMatch(value,
                              $@"(?i)(['\s]?(and|or|exec)['\s]?{Regex.Escape(a)}.*-{{2,}})",
                              RegexOptions.IgnoreCase
                             )
                            || // 排除系统关键字  delete
                            Regex.IsMatch(
                                value,
                                $@"(^|[^\w-]){Regex.Escape(a)}([^\w-]|$)(\s*$$)?|(^|[^\w-]){Regex.Escape(a)}\s",
                                RegexOptions.IgnoreCase
                            ))
                            select a;
                var sql = query.FirstOrDefault();

                if (sql != null)
                {
                    throw new Exception($"SQL注入检测：非法输入'{value}'包含非法字符:{sql}");
                }
            }
        }

        // 危险操作检测
        private static bool IsSqlInjection(string input)
        {
            // 阶段1：检测语句终止符
            var terminationCheck = new Regex(@"(['""]\))?\s*;\s*", RegexOptions.IgnoreCase);

            // 阶段2：危险命令白名单
            var dangerCommands = new Regex(
                @"\b(DELETE|DELETE\s+FROM|DROP\s+TABLE|TRUNCATE|EXEC\s+)\b",
                RegexOptions.IgnoreCase
            );

            // 阶段3：注释符验证
            var commentCheck = new Regex(@"(--|#|\/\*|\/\/)\s*$");

            return terminationCheck.IsMatch(input)
                   && dangerCommands.IsMatch(input)
                   && commentCheck.IsMatch(input);
        }
    }
}
