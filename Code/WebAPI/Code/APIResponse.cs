
using Newtonsoft.Json;
using System;
using System.Net;
using System.Net.Http;
using System.Text;
using WebAPI.Models.MES;
using WebAPI.Models.Enum;
using WebAPI.Utility;
using WebAPI.Models;
using SKT.LeanMES.SDK;
using Swashbuckle.Examples;

namespace WebAPI.Code
{
    /// <summary>
    /// API 自定义响应
    /// @author xudong.zhu 
    /// @date 2022-08-19
    /// </summary>
    public class APIResponse
    {
        /// <summary>
        /// 响应结果是否使用数据签名
        /// </summary>
        private static string is_sign = SettingsHelper.AppSettings("IsResponseSign");


        /// <summary>
        /// 自定义数据响应
        /// </summary>
        /// <param name="data"></param>
        /// <param name="reusltEnum"></param>
        /// <returns></returns>
        public static HttpResponseMessage ResponseMsg(dynamic data, ResultEnum reusltEnum = ResultEnum.OK)
        {
            APIResult result = new APIResult();
            result.Basis = new BaseData()
            {
                State = reusltEnum == ResultEnum.OK ? 1 : 0,
                Message = reusltEnum == ResultEnum.OK ? "" : ((data is string || data is char) ? data.ToString() : "")
            };

            result.Result = data;
            return ResponseMsg(result);
        }

        /// <summary>
        /// 实体响应
        /// </summary>
        /// <param name="result"></param>
        /// <returns></returns>
        public static HttpResponseMessage ResponseMsg(APIResult result)
        {
            if (result == null || result.Basis == null) throw new Exception("返回数据异常");
            if (result.Result == null)
            {
                result.Result = new { };
            }
            //非简单参数模式下
            if (!bool.Parse(SettingsHelper.AppSettings("IsEasyParamMode")))
            {
                //响应数据签名
                if (bool.Parse(is_sign)) result.Basis.Sign = SignHelper.GetSignRSAStr(result);
            }
            return toJson(result);
        }

        /// <summary>
        /// 响应json 格式
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        private static HttpResponseMessage toJson(object obj)
        {
            string str;
            if (obj is string || obj is char)
            {
                str = obj.ToString();
            }
            else
            {
                JsonSerializerSettings jsetting = new JsonSerializerSettings();
                jsetting.NullValueHandling = NullValueHandling.Ignore;
                jsetting.DateFormatString = "yyyy-MM-dd hh:mm:ss";
                str = JsonConvert.SerializeObject(obj, jsetting);
            }

            HttpResponseMessage response = new HttpResponseMessage { Content = new StringContent(str, Encoding.GetEncoding("UTF-8"), "application/json") };

            response.Headers.Add("Access-Control-Allow-Origin", "*"); //允许哪些url可以跨域请求到本域
            response.Headers.Add("Access-Control-Allow-Methods", "GET, POST, PUT"); //允许的请求方法，一般是GET,POST,PUT,DELETE,OPTIONS
            //response.Headers.Add("Access-Control-Allow-Headers", "x-requested-with,content-type"); //允许哪些请求头可以跨域
            response.Headers.Add("Access-Control-Allow-Headers", "*"); //允许哪些请求头可以跨域
            return response;
        }

        /// <summary>
        /// 自定义数据响应
        /// </summary>
        /// <param name="data"></param>
        /// <param name="reusltEnum"></param>
        /// <returns></returns>
        public static APIResult APIResponseMsg(dynamic data, ResultEnum reusltEnum = ResultEnum.OK)
        {
            APIResult result = new APIResult();
            result.Basis = new BaseData()
            {
                State = reusltEnum == ResultEnum.OK ? 1 : 0,
                Message = reusltEnum == ResultEnum.OK ? "" : ((data is string || data is char) ? data.ToString() : "")
            };

            result.Result = data;
            return APIResponseMsg(result);
        }

        /// <summary>
        /// 实体响应
        /// </summary>
        /// <param name="result"></param>
        /// <returns></returns>
        public static APIResult APIResponseMsg(APIResult result)
        {
            if (result == null || result.Basis == null) throw new Exception("返回数据异常");
            if (result.Result == null)
            {
                result.Result = new { };
            }
            //非简单参数模式下
            if (!bool.Parse(SettingsHelper.AppSettings("IsEasyParamMode")))
            {
                //响应数据签名
                if (bool.Parse(is_sign)) result.Basis.Sign = SignHelper.GetSignRSAStr(result);
            }
            return result;
        }
    }
}