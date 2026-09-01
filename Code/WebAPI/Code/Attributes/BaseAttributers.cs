using Newtonsoft.Json;
using SKT.LeanMES.SDK;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace WebAPI.Code.Attributes
{
    /// <summary>
    /// 
    /// </summary>
    public class BaseAttributers : ActionFilterAttribute
    {
        /// <summary>
        /// 请求数据包字符串
        /// </summary>
        public string DynamicStr { get; set; }

        /// <summary>
        /// 数据包
        /// </summary>
        public GlobalPackage Package { get; set; }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="actionContext"></param>
        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            base.OnActionExecuting(actionContext);

            //通过上下文获取请求对象
            HttpContextBase context = (HttpContextBase)actionContext.Request.Properties["MS_HttpContext"];
            HttpRequestBase request = context.Request;

            //请求方式
            string requestType = request.RequestType.ToLower();
            if ("post".Equals(requestType))
            {
                DynamicStr = "";
                var reader = new StreamReader(request.InputStream, Encoding.UTF8);

                //如果已经读取过
                if (reader.EndOfStream)
                {
                    //重新设置流的位置
                    reader.BaseStream.Seek(0, SeekOrigin.Begin);
                    DynamicStr = reader.ReadToEnd();
                }
                else
                {
                    DynamicStr = reader.ReadToEnd();
                }
                //数据包
                Package = JsonConvert.DeserializeObject<GlobalPackage>(DynamicStr);
            }
            else
            {
                string sign = HttpContext.Current.Request.QueryString["Sign"];
                //token字符串
                string token = HttpContext.Current.Request.QueryString["Token"];
                string imei = HttpContext.Current.Request.QueryString["IMEI"];
                string imsi = HttpContext.Current.Request.QueryString["IMSI"];
                string ip = HttpContext.Current.Request.QueryString["IP"];
                string os = HttpContext.Current.Request.QueryString["OS"];

                if (Package == null) Package = new GlobalPackage { Global = new SignPackage { } };

                if (!string.IsNullOrWhiteSpace(token)) Package.Global.Token = token;
                if (!string.IsNullOrWhiteSpace(sign)) Package.Global.Sign = sign.Replace(' ', '+');
                if (!string.IsNullOrWhiteSpace(imei)) Package.Global.IMEI = imei;
                if (!string.IsNullOrWhiteSpace(imsi)) Package.Global.IMSI = imsi;
                if (!string.IsNullOrWhiteSpace(ip)) Package.Global.IP = ip;
                if (!string.IsNullOrWhiteSpace(os)) Package.Global.OS = int.Parse(os);

                var arg_dic = new Dictionary<string, string>();
                foreach (var arg in HttpContext.Current.Request.QueryString.AllKeys)
                {
                    if (arg != "sign") arg_dic.Add(arg, HttpContext.Current.Request.QueryString[arg]);
                }

                if (arg_dic.Count > 0)
                {
                    var json = JsonConvert.SerializeObject(arg_dic);

                    Package.Data = JsonConvert.DeserializeObject<dynamic>(json);
                }
            }
        }
    }
}