using SKT.LeanMES.SDK;
using Swashbuckle.Examples;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ResponseExample
{
    /// <summary>
    /// 通用返回示例
    /// </summary>
    public class ResExample : IExamplesProvider
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
                   
                }
            };
        }
    }
}