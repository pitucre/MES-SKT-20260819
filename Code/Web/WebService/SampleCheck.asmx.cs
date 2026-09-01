using SKT.LeanMES.ProductionCollection.WebService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SKT.LeanMES.Web.WebService
{
    /// <summary>
    /// SampleCheck 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://mesateapi.com/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class SampleCheck : System.Web.Services.WebService
    {
        /// <summary>
        /// 镭雕机接口，验证工单、产品编码关系是否正确
        /// </summary>
        /// <param name="orderNumber">工单号</param>
        /// <param name="itemCode"></param>
        /// <returns></returns>       
        [WebMethod(Description = @"
        [样机测试接口]<br/>
        [处理逻辑]：依据输入的工单号、样机条码、工序、工号、资源<br/>
        [功能]：验证输入信息是否正确 插入样机使用记录<br/>
        [输入-参数]：orderNumber-工单号  sampleNumber-样机条码 station-工序名称 employeeCode-工号 resourceName-资源名称 isPass-是否PASS（0：否 1：是） ncDescribes-不良描述（多个用逗号隔开）<br/>
        [输出-返回]：字符串，成功 【OK】; 失败 【NG:返回错误信息】<br/> 
        ")]
        public string SampleCheckTest(string orderNumber, string sampleNumber, string station, string employeeCode, string resourceName, int isPass, string ncDescribes)
        {
            string msg = "";
            SampleCheckService bll = new SampleCheckService();
            try
            {
                if (orderNumber == "")
                {
                    return string.Format("NG;工单号不能传空！");
                }
                if (sampleNumber == "")
                {
                    return string.Format("NG;样机编码不能传空!");
                }
                if (station == "")
                {
                    return string.Format("NG;工序不能传空!");
                }
                if (employeeCode == "")
                {
                    return string.Format("NG;工号不能传空!");
                }
                if (resourceName == "")
                {
                    return string.Format("NG;资源名称不能传空!");
                }
                if (isPass != 0 && isPass != 1)
                {
                    return string.Format("NG;是否PASS值必须为0或1");
                }
                msg = bll.SampleCheckTest(orderNumber, sampleNumber, station, employeeCode, resourceName, isPass, ncDescribes);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return string.Format(msg);
        }
    }
}
