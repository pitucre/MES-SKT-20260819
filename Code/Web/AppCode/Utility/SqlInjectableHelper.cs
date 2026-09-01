using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    public static class SqlInjectableHelper
    {
        private const string cacheKey = "sqlKeywords";
        private const string ignoreCacheKey = "ignoreSqlKeywords";
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
        /// 获取配置的系统关键字，与sql 注入检测冲突的值
        /// </summary>
        /// <returns></returns>
        public static List<string> GetIgnoreSqlKeywordList()
        {
            var sqlKeywords = (List<string>)CacheHelper.GetCache(ignoreCacheKey);

            if (sqlKeywords == null || sqlKeywords.Count <= 0)
            {
                string filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "IgnoreSqlKeyword.txt");
                if (File.Exists(filePath))
                {
                    sqlKeywords = File.ReadAllText(filePath)
                        .Split(new char[] { ';', ',' }, StringSplitOptions.RemoveEmptyEntries)
                        .ToList();
                    // 写入缓存， 30分钟更新一次
                    CacheHelper.SetCache(ignoreCacheKey, sqlKeywords, 30);
                }
            }
            return sqlKeywords;
        }
    }

}
