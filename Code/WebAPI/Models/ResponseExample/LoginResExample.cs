using SKT.LeanMES.SDK;
using Swashbuckle.Examples;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ResponseExample
{
    /// <summary>
    /// 登录获取Token返回示例
    /// </summary>
    public class LoginResExample : IExamplesProvider
    {
        public object GetExamples()
        {
            return new APIResult
            {
                Basis = new BaseData
                {
                    State = 1,
                    Sign = "",
                    Message = ""
                },
                Result = new
                {
                    token = "D34C9F1F57EADCF62799CD86097C45C9897CAB9F52A87D1E"
                }
            };
        }
    }
}