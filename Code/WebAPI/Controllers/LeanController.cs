using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Newtonsoft.Json;
using WebAPI.Models;
using WebAPI.Code.Attributes;
using WebAPI.Code;
using SKT.LeanMES.SDK;
using Swashbuckle.Swagger.Annotations;
using Swashbuckle.Examples;
using WebAPI.Models.RequestExample;
using WebAPI.Models.ResponseExample;
using Newtonsoft.Json.Serialization;
using WebAPI.Models.Enum;

namespace WebAPI.Controllers
{
    /// <summary>
    /// 通用执行业务
    /// </summary>
    public class LeanController : ApiController
    {
        /// <summary>
        /// 通用执行存储过程
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Runprocedure")]
        [HttpPost]
        public string Runprocedure([FromBody]Parameters entity)
        {
            ReturnMes mes = new ReturnMes();
            LeanServerDll bll = new LeanServerDll();

            string token = ConfigurationManager.AppSettings["Token"];

            if (entity.Token.Equals(token))
            {
                try
                {
                    switch (entity.ExecType)
                    {
                        case "1":
                            bll.ExecProcedure(entity.ProcedureName, entity.Array);
                            break;
                        case "2":
                            DataSet dt = bll.ExecProcedureTable(entity.ProcedureName, entity.Array);
                            mes.Data = dt;
                            break;
                    }
                    mes.Message = "操作成功";
                    mes.State = 0;

                }
                catch (Exception ex)
                {
                    mes.Message = ex.Message.ToString();
                    mes.State = -1;
                }
            }
            else
            {
                mes.Message = "Token值错误";
                mes.State = -1;
            }
            mes.TxnId = entity.TxnId;
            string jsonStr = JsonConvert.SerializeObject(mes);
            return jsonStr;
        }

        /// <summary>
        /// 测试
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("TestSignAuth")]  
        [SignAuth, LoginAuth, HttpPost]
        public APIResult TestSignAuth([FromBody] GlobalPackage entity)
        {

            return APIResponse.APIResponseMsg("");
        }

        /// <summary>
        /// Get请求签名和登录测试
        /// </summary>
        /// <param name="client_id"></param>
        /// <param name="client_secret"></param>
        /// <param name="client_type"></param>
        /// <returns></returns>
        [Route("TestHttpGetSignAuth")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(LoginResExample))] //响应示例 
        [SignAuth, LoginAuth, HttpGet]
        public APIResult TestHttpGetSignAuth(string client_id, string client_secret, string client_type)
        {
            return APIResponse.APIResponseMsg("");
        }

        /// <summary>
        /// 登录获取Token
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns> 
        [Route("GetToken")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(LoginResExample))] //响应示例
        [SwaggerRequestExample(typeof(GlobalPackage), typeof(LoginReqExample))]//请求模型，请求示例
        [SignAuth, HttpPost]
        public APIResult GetToken([FromBody] GlobalPackage entity)
        {
            //客户端ID
            var client_id = entity.Data.client_id.ToString();
            //密钥
            var client_secret = entity.Data.client_secret.ToString();
            //客户端类型
            var client_type = entity.Data.client_type.ToString();

            return GetToken(client_id, client_secret, client_type);
        }

        /// <summary>
        /// 登录获取Token
        /// </summary>
        /// <param name="client_id">客户端ID</param>
        /// <param name="client_secret">密钥</param> 
        /// <param name="client_type">客户端类型</param> 
        /// <returns></returns>
        [Route("GetToken2")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(LoginResExample))] //响应示例 
        [SignAuth, HttpGet]
        public APIResult Login2(string client_id, string client_secret, string client_type)
        {
            return GetToken(client_id, client_secret, client_type);
        }

        /// <summary>
        /// 获取Token
        /// </summary>
        /// <param name="client_id"></param>
        /// <param name="client_secret"></param>
        /// <param name="client_type"></param>
        /// <returns></returns>
        private APIResult GetToken(string client_id, string client_secret, string client_type)
        {
            //当前用户验证
            var sql = @"select top 1 sgp.ParaType from  dbo.SYS_GlobarParameter sgp where sgp.ParaName = '" + client_type + "_ClientId' and sgp.ParaValue='" + client_id + "'";

            var ret = Utility.SqlHelper.GetList(sql);
            if (ret.Count <= 0)
            {
                return APIResponse.APIResponseMsg("非法登录用户！", ResultEnum.NG);
            }

            //当前用户密钥验证
            sql = @"select top 1 sgp.ParaType from  dbo.SYS_GlobarParameter sgp where sgp.ParaName = '" + client_type + "_ClientSecret' and sgp.ParaValue='" + client_secret + "'";

            ret = Utility.SqlHelper.GetList(sql);
            if (ret.Count <= 0)
            {
                return APIResponse.APIResponseMsg("非法登录用户！", ResultEnum.NG);
            }

            //Token有效
            sql = @"update sgp set sgp.ParaValue=0 from dbo.SYS_GlobarParameter sgp where sgp.ParaName = '" + client_type + "_TokenIsExpire'";
            ret = Utility.SqlHelper.Execute(sql);
            if (ret <= 0)
            {
                return APIResponse.APIResponseMsg("未配置token销毁参数！", ResultEnum.NG);
            }

            //生成token（client_type + # + client_id + expire_time）
            var expire_time = (long)(DateTime.Now.AddHours(2).ToLocalTime() - new DateTime(1970, 1, 1).ToLocalTime()).TotalSeconds;
            var token = StringHelper.GetEncryption(client_type + "#" + client_id + "#" + expire_time);

            return APIResponse.APIResponseMsg(new { token });
        }

        [Route("UpdateAgvTaskStatus")]
        public ResultAgv UpdateAgvTaskStatus(Finfo entity)
        {
            ResultAgv result = new ResultAgv();

            long count = 0;
            result.errCode = 0;
            result.errMsg = "";
            try
            {
                LeanServerDll bll = new LeanServerDll();
                bll.UpdateAgvTaskStatus(entity.taskID, entity.taskState);
            }
            catch (Exception ex)
            {

                result.errMsg = ex.Message;
                result.errCode = 1;
            }
          
            return result;
        }


    }

    public class ResultAgv {
        public int errCode { get; set; }
        public string errMsg { get; set; }
    }

    public class Finfo
    {
        public string msgType { get; set; }
        public string taskID { get; set; }
        public int taskState { get; set; }
        public int bindAgvId { get; set; }

    }

}
