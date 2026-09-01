using System;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace WebAPI
{
    /// <summary>
    /// 
    /// </summary>
    public static class HttpHelper
    {
        /// <summary>
        /// 
        /// </summary>
        public static HttpClient HttpClient { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public static void InitializeClient()
        {
            //单例模式
            if (HttpClient == null)
            {
                HttpClient = new HttpClient();                
            }

            HttpClient.DefaultRequestHeaders.Accept.Clear();
            HttpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            //能解读https类型
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
        }

        /// <summary>
        /// Get方法
        /// </summary>
        /// <param name="url">目标链接(含参数)</param>
        /// <returns>返回的字符串</returns>
        public static async Task<string> GetAsync(string url)
        {
            if (HttpClient == null) InitializeClient();

            using (HttpResponseMessage response = await HttpClient.GetAsync(url))
            {
                response.EnsureSuccessStatusCode();
                string result = await response.Content.ReadAsStringAsync();
                return result;
            }
        }


        /// <summary>
        /// Post方法
        /// </summary>
        /// <param name="url">目标链接</param>
        /// <param name="json">发送的json格式的参数字符串</param>
        /// <param name="dataFormat">数据编码</param>
        /// <returns></returns>
        public static async Task<string> PostAsync(string url, string json, string dataFormat = "utf-8")
        {
            if (HttpClient == null) InitializeClient();

            StringContent content = new StringContent(json);
            content.Headers.ContentType = new MediaTypeHeaderValue("application/json") { CharSet = dataFormat };

            using (HttpResponseMessage response = await HttpClient.PostAsync(url, content))
            {
                response.EnsureSuccessStatusCode();
                string result = await response.Content.ReadAsStringAsync();
                return result;
            }
        }

        /// <summary>
        /// Post方法
        /// </summary>
        /// <param name="url">目标链接</param>
        /// <param name="json">发送的json格式的参数字符串</param>
        /// <returns>返回的字符串</returns>
        //public static async Task<string> PostAsync(string url, HttpContent content)
        //{
        //    //HttpContent content = new FormUrlEncodedContent(new Dictionary<string, string>()
        //    //       {
        //    //           { "token", token},
        //    //           { "orderNo", orderNo}
        //    //       });
        //    content.Headers.ContentType = new MediaTypeHeaderValue("application/x-www-form-urlencoded") { CharSet = "utf-8" };

        //    using (HttpResponseMessage response = await HttpClient.PostAsync(url, content))
        //    {
        //        response.EnsureSuccessStatusCode();
        //        string result = await response.Content.ReadAsStringAsync();
        //        return result;
        //    }
        //}
    }
}