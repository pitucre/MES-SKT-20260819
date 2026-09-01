using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;

namespace WebAPI.Utility
{
    public class HttpClientHelper
    {

        /// <summary>
        /// POST提交
        /// </summary>
        /// <param name="url"></param>
        /// <param name="json"></param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        public string Post(string url, string json)//post同步请求方法
        {
            using (var client = new HttpClient())
            {
                using (HttpContent content = new StringContent(json))
                {
                    content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                    //client.DefaultRequestHeaders.Connection.Add("keep-alive");

                    //由HttpClient发出Post请求
                    using (HttpResponseMessage res = client.PostAsync(url, content).Result)
                    {
                        string str = res.Content.ReadAsStringAsync().Result;
                        return str;
                        //if (res.StatusCode == System.Net.HttpStatusCode.OK)
                        //{
                        //    return str;
                        //}
                        //else
                        //{
                        //    throw new Exception($"调用接口异常：{res.StatusCode}。错误消息：{str}");
                        //}
                    }
                }
            }
        }

        public async Task<string> PostAsync(string url, string strJson)//post异步请求方法
        {
            using (var client = new HttpClient())
            {
                HttpContent content = new StringContent(strJson);
                content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                //由HttpClient发出异步Post请求
                HttpResponseMessage res = await client.PostAsync(url, content);
                if (res.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    string str = res.Content.ReadAsStringAsync().Result;
                    return str;
                }
                else
                {
                    return null;
                }
            }
        }

    }
}