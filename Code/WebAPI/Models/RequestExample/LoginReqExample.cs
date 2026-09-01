using SKT.LeanMES.SDK;
using Swashbuckle.Examples;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebAPI.Models.RequestExample
{
    /// <summary>
    /// 登录请求示例【post】
    /// </summary>
    public class LoginReqExample : IExamplesProvider
    {
        public object GetExamples()
        {
            return new GlobalPackage
            {
                Global = new SignPackage
                {
                    IMEI = "",
                    IMSI = "",
                    IP = "",
                    OS = 0,
                    Token = "",
                    Sign = "b1nWmQ+nzBk/lIpHgtLYx9YUAK7KwmoRxiXHrqBRNu/sdgRECfKE1ynCRH8swyloVPwe6xt0PULCSMuqZfDdWwZo5V45ncWIZku2XRsuiHtUIsB2OJR7cINXN5Z4ojn4j0ufmEmH9UI+8xJqHyOpoqyK97IEb1A6q4nEJKmeXVo="
                },
                Data = new
                {
                    client_id = "123456789",
                    client_secret = "5Q4GosgqFONuFbRijMbqyaE9kXFNsPb",
                    client_type = "U9"
                }
            };
        }
    }
}