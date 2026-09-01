using Newtonsoft.Json;
using Quartz;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using WebAPI.Models.ERP;
using WebAPI.Utility;

namespace WebAPI.Job
{
    [DisallowConcurrentExecution]//同一个job，不允许没执行完就再执行
    public class BaseJob
    {
        #region 用友Open API

        ///// <summary>
        ///// 获取ERP链接
        ///// </summary>
        //protected static readonly string ERPUrl = ConfigurationManager.AppSettings["ERPUrl"].ToString();

        ///// <summary>
        ///// 调用方id
        ///// </summary>
        //protected static readonly string FromAccount = ConfigurationManager.AppSettings["from_account"].ToString();

        ///// <summary>
        ///// 提供方id
        ///// </summary>
        //protected static readonly string ToAccount = ConfigurationManager.AppSettings["to_account"].ToString();

        ///// <summary>
        ///// 应用编码
        ///// </summary>
        //protected static readonly string AppKey = ConfigurationManager.AppSettings["app_key"].ToString();

        ///// <summary>
        ///// 密钥
        ///// </summary>
        //protected static readonly string AppSecret = ConfigurationManager.AppSettings["app_secret"].ToString();

        ///// <summary>
        ///// 数据库ERP_Sync表LastSyncTime字段为null时，默认的开始同步时间
        ///// </summary>
        //protected static readonly string DefaultSyncTimeIfNull = ConfigurationManager.AppSettings["DefaultSyncTimeIfNull"].ToString();


        ///// <summary>
        ///// ERP Token
        ///// </summary>
        //protected static string erpToken = string.Empty;

        ///// <summary>
        ///// 获取OA Token
        ///// </summary>
        //public ERPTokenInfo GetERPToken()
        //{
        //    using (HttpClient client = new HttpClient() { Timeout = new TimeSpan(0, 0, 10) })    //超时时间为10秒
        //    {
        //        //设置请求头类型为：application/json
        //        client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        //        var url = string.Format("{0}/system/token?from_account={1}&app_key={2}&app_secret={3}", ERPUrl, FromAccount, AppKey, AppSecret);
        //        using (HttpResponseMessage responseMessage = client.GetAsync(url).Result)
        //        {
        //            using (Task<string> taskRead = responseMessage.Content.ReadAsStringAsync())
        //            {
        //                taskRead.Wait();
        //                var result = taskRead.Result;
        //                if (responseMessage.IsSuccessStatusCode)
        //                {
        //                    ERPTokenInfo model = JsonConvert.DeserializeObject<ERPTokenInfo>(result);
        //                    if (model.errcode != "0")
        //                    {
        //                        throw new Exception("获取ERP Token失败：" + model.errmsg);
        //                    }
        //                    return model;
        //                }
        //                else
        //                {
        //                    throw new HttpException((int)responseMessage.StatusCode, $"获取Token失败：{result}");
        //                }
        //            }
        //        }
        //    }
        //}


        ///// <summary>
        ///// Get方式调用WebAPI
        ///// </summary>
        ///// <param name="controller">控制器名称</param>
        ///// <param name="parms">额外的参数（以$开头，例如：$cwhcode=WhCode01）</param>
        ///// <returns>json字符串</returns>
        //public string GetWebApiResult(string controller, string parms)
        //{
        //    if (!string.IsNullOrEmpty(parms))
        //    {
        //        if (!parms.StartsWith("&"))
        //        {
        //            parms = $"&{parms}";
        //        }
        //    }

        //    try
        //    {
        //        return GetResultByWebRequest(controller, parms);
        //    }
        //    catch (Exception ex)
        //    {
        //        Logger.Write.Info($"重试一次，获取ERP[{controller}]信息，parms[{parms}]，异常消息:{ex.Message}");
        //        return GetResultByWebRequest(controller, parms);
        //    }


        //    //try
        //    //{
        //    //    return GetResult(controller, parms);
        //    //}
        //    //catch (Exception ex)
        //    //{
        //    //    Logger.Write.Info($"重试一次，获取ERP[{controller}]信息，parms[{parms}]");
        //    //    return GetResult(controller, parms);
        //    //}

        //}

        //public static string GetResultByWebRequest(string controller, string parms)
        //{
        //    string retString = string.Empty;
        //    var url = $"{ERPUrl.TrimEnd('/')}/api/{controller}?from_account={FromAccount}&to_account={ToAccount}&app_key={AppKey}&token={erpToken}{parms}";

        //    HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
        //    request.Method = "GET";
        //    request.ContentType = "application/json";
        //    using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
        //    {
        //        using (Stream myResponseStream = response.GetResponseStream())
        //        {
        //            //using (StreamReader myStreamReader = new StreamReader(myResponseStream, Encoding.GetEncoding("utf-8")))
        //            using (StreamReader myStreamReader = new StreamReader(myResponseStream))
        //            {
        //                retString = myStreamReader.ReadToEnd();
        //            }
        //        }
        //    }
        //    return retString;
        //}


        ///// <summary>
        ///// 获取API结果
        ///// </summary>
        ///// <param name="controller"></param>
        ///// <param name="parms"></param>
        ///// <returns></returns>
        ///// <exception cref="HttpException"></exception>
        //protected string GetResult(string controller, string parms)
        //{
        //    using (HttpClient client = new HttpClient() { Timeout = TimeSpan.FromSeconds(60), MaxResponseContentBufferSize = 1024 * 1000 })
        //    {
        //        ////设置请求头类型为：application/json
        //        client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

        //        //var url = string.Format("{0}/api/{1}?from_account={2}&to_account={3}&app_key={4}&token={5}{6}", ERPUrl,controller , FromAccount, ToAccount, AppKey, erpToken, parms);
        //        var url = $"{ERPUrl.TrimEnd('/')}/api/{controller}?from_account={FromAccount}&to_account={ToAccount}&app_key={AppKey}&token={erpToken}{parms}";
        //        using (HttpResponseMessage responseMessage = client.GetAsync(url).Result)
        //        {
        //            using (Task<string> taskRead = responseMessage.Content.ReadAsStringAsync())
        //            {
        //                //taskRead.Wait();
        //                var result = taskRead.Result;
        //                if (responseMessage.IsSuccessStatusCode)
        //                {
        //                    Logger.Write.Info($"获取ERP[{controller}]信息，请求URL[{url}]，返回数据：{result}");
        //                    return result;
        //                }
        //                else
        //                {
        //                    throw new HttpException((int)responseMessage.StatusCode, result);
        //                }
        //            }
        //        }
        //    }
        //} 

        #endregion
    }

}