using Newtonsoft.Json;
using SKT.LeanMES.SDK;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebAPI.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }

        // GET: Home
        public ActionResult ERPSyncList()
        {
            return View();
        }

        /// <summary>
        /// 获取YonBIP开放平台 AccessToken 示例
        /// </summary>
        public string YonBIP_GetAccessToken()
        {
            var token = string.Empty;
            //YonBIP开放平台提供 
            var appKey = SettingsHelper.AppSettings("YonBIPAppKey");
            var appSecret = SettingsHelper.AppSettings("YonBIPAppSecret");
            //时间戳（毫秒）
            var timestamp = ((long)(DateTime.Now.ToLocalTime() - new DateTime(1970, 1, 1).ToLocalTime()).Milliseconds).ToString();
            var list = new
            {
                appKey = appKey,
                timestamp = timestamp
            };

            var dic = StringHelper.GetDictionaryByType(list);

            var postStr = StringHelper.FormatParaMap(dic);
            //获取签名数据
            string signStr = SignHelper.SignHMACSHA256(postStr, appSecret);

            Dictionary<string, string> sArray = new Dictionary<string, string>();
            sArray.Add("appKey", list.appKey);
            sArray.Add("timestamp", list.timestamp);
            sArray.Add("signature", signStr);

            var result = SignClient.GetRequest("http://...", null, sArray);

            if (string.IsNullOrWhiteSpace(result))
            {
                var res_obj = JsonConvert.DeserializeObject<dynamic>(result);
                //AccessToken
                token = res_obj.data.access_token.ToString();
            }
            return token;
        }

        /// <summary>
        /// 获取YonBIP开放平台 租户id 示例
        /// </summary>
        public string YonBIP_GetRomoteTenantId()
        {
            var tenantId = string.Empty;
            //YonBIP开放平台提供 
            var appKey = SettingsHelper.AppSettings("YonBIPAppKey");
            var appSecret = SettingsHelper.AppSettings("YonBIPAppSecret");
            //时间戳（毫秒）
            var timestamp = ((long)(DateTime.Now.ToLocalTime() - new DateTime(1970, 1, 1).ToLocalTime()).Milliseconds).ToString();
            var list = new
            {
                appKey = appKey,
                timestamp = timestamp
            };

            var dic = StringHelper.GetDictionaryByType(list);

            var postStr = StringHelper.FormatParaMap(dic);
            //获取签名数据
            string signStr = SignHelper.SignHMACSHA256(postStr, appSecret);

            Dictionary<string, string> sArray = new Dictionary<string, string>();
            sArray.Add("appKey", list.appKey);
            sArray.Add("timestamp", list.timestamp);
            sArray.Add("signature", signStr);

            var result = SignClient.GetRequest("http://...", null, sArray);

            if (string.IsNullOrWhiteSpace(result))
            {
                var res_obj = JsonConvert.DeserializeObject<dynamic>(result);
                //租户id
                tenantId = res_obj.data.ToString();
            }
            return tenantId;
        }

        /// <summary>
        /// YonBIP开放平台 POST接口示例
        /// </summary>
        public void YonBIP_Post()
        {
            // 实际情况可做持久化处理
            var token = YonBIP_GetAccessToken();
            var tenantId = YonBIP_GetRomoteTenantId();

            var list = new
            {
                abc = "aaa",
                efg = "bbb"
            };

            //用友商业创新平台接口数据包
            var post = new YonBIPPackage
            {
                //是否异步
                async = false,
                //方案代码
                schemeCode = "qwerq2342",
                //数据
                data = list,
                //可压缩
                compressEnable = false 
            };

            Dictionary<string, string> sArray = new Dictionary<string, string>();
            sArray.Add("access_token", token);
            sArray.Add("tenantId", tenantId);

            var result = SignClient.PostRequest("http://...", sArray, null, post);

            if (string.IsNullOrWhiteSpace(result))
            {

            }
        }

        /// <summary>
        /// YonBIP开放平台 GET接口示例
        /// </summary>
        public void YonBIP_Get()
        {
            // 实际情况可做持久化处理
            var token = YonBIP_GetAccessToken();
            var tenantId = YonBIP_GetRomoteTenantId();

            var list = new
            {
                abc = "aaa",
                efg = "bbb",
                hij = new
                {
                    abc = "aaaaaaaa",
                    efg = "bbbbbbbb",
                }
            };
            //对象转字典
            var sArray = StringHelper.GetDictionaryByType(list);

            var result = SignClient.GetRequest("http://...", null, sArray);

            if (string.IsNullOrWhiteSpace(result))
            {

            }
        }
    }
}
