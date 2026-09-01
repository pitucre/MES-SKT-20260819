using Newtonsoft.Json;
using SKT.LeanMES.CommonHelper.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SKT.LeanMES.Web.WebService
{
    /// <summary>
    /// XReyApi 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class XReyApi : System.Web.Services.WebService
    {
        /// <summary>
        /// X-Rey点料对接接口
        /// </summary>
        /// <returns></returns>
        [WebMethod(Description = @"
        [功能]：X-Rey点料接口<br/>
                逻辑：<br/>
                1、设备将GRN和数量传入MES，MES将对应GRN的可用数量进行修改；<br/>
                2、修改完成后，将GRN打印对应的标签字段内容返回设备；<br/>
        [参数]：
            grn：物料条码<br/>
            qty：数量<br/>
        [返回]：字符串 <br/>
                成功返回：{""Result"":true,""Msg"":"""",""PrintContent"":""[{\""LabelContent\"":[{\""name\"":\""MaterialSN\"",\""value\"":\""IDGRN00 \""},{\""name\"":\""GRN数量\"",\""value\"":\""200\""},{\""name\"":\""GRN物料\"",\""value\"":\""GRN000026\""}]}]""}<br/>
                失败返回：{""Result"":false,""Msg"":""GRN[GRN0001]不存在"",""PrintContent"":""""}<br/>
                返回JSON说明：<br/>
                    Result：调用结果（true:成功  false:失败）<br/>
                    Msg：消息（调用成功时，返回空字符串，失败时返回错误消息）<br/>
                    PrintContent：打印的JSON（调用成功时，返回打印的JOSN，失败时返回空字符串）<br/>")]
        public string UpdateGRNQtyAndReturnPrintContent(string grn, decimal qty)
        {
            XReyReturnInfo ri = new XReyReturnInfo { Result = true, Msg = string.Empty, PrintContent = string.Empty };
            try
            {
                SqlParameter[] parms = new SqlParameter[]
                {
                new SqlParameter("@GRN", SqlDbType.VarChar) { Value = grn },
                new SqlParameter("@Qty", SqlDbType.Decimal) { Value = qty },
                };
                var list = ComMethod.GetList<PrintContent>("uspUpdateGRNQtyAndReturnPrintContent", parms);

                //匿名对象
                var print = new[] { new { LabelContent = list } };
                ri.PrintContent = JsonConvert.SerializeObject(print);
            }
            catch (Exception ex)
            {
                ri.Result = false;
                ri.Msg = WebHelper.GetExceptionMsg(string.Empty, ex);
            }
            return JsonConvert.SerializeObject(ri);
        }

    }


    public class PrintContent
    {
        /// <summary>
        /// 字段名
        /// </summary>
        [JsonProperty(PropertyName = "name")]
        public string Name { get; set; }

        /// <summary>
        /// 字段值
        /// </summary>
        [JsonProperty(PropertyName = "value")]
        public string Value { get; set; }

        /// <summary>
        /// 源字段名
        /// </summary>
        [JsonIgnore]
        public string OriginalName { get; set; }
    }


    /// <summary>
    /// XRey返回信息
    /// </summary>
    public class XReyReturnInfo
    {
        /// <summary>
        /// 结果
        /// </summary>
        public bool Result { get; set; }

        /// <summary>
        /// 消息
        /// </summary>
        public string Msg { get; set; }

        /// <summary>
        /// 打印的JSON
        /// </summary>
        public string PrintContent { get; set; }
    }


}
