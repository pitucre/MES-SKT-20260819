using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI
{
    /// <summary>
    /// 缓存
    /// </summary>
    public static class CacheHelper
    {
        //缓存容器 
        private static Dictionary<string, object> CacheDictionary = new Dictionary<string, object>();

        /// <summary>
        /// 添加缓存
        /// </summary>
        public static void Add(string key, object value)
        {
            CacheDictionary.Add(key, value);
        }

        /// <summary>
        /// 获取缓存
        /// </summary>
        public static T Get<T>(string key)
        {
            return (T)CacheDictionary[key];
        }
        /// <summary>
        /// 设置缓存
        /// </summary>
        public static void Set(string key, object value)
        {
            if (Exsits(key))
            {
                CacheDictionary[key] = value;
            }            
        }

        /// <summary>
        /// 判断缓存是否存在
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static bool Exsits(string key)
        {
            return CacheDictionary.ContainsKey(key);
        }

        /// <summary>
        /// 移除缓存
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static bool Remove(string key)
        {
            return CacheDictionary.Remove(key);
        }
    }
}