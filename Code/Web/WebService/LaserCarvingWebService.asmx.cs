using Newtonsoft.Json;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.ProductionCollection.WebService;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml;
using System.Xml.Serialization;

namespace SKT.LeanMES.Web.WebService
{
    /// <summary>
    /// LaserCarvingWebService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://mesateapi.com/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class LaserCarvingWebService : System.Web.Services.WebService
    {
        LaserCarvingService ser = new LaserCarvingService();

        /// <summary>
        /// 镭雕机接口，验证工单、产品编码关系是否正确
        /// </summary>
        /// <param name="orderNumber">工单号</param>
        /// <param name="itemCode"></param>
        /// <returns></returns>       
        [WebMethod(Description = @"
        [镭雕接口1]<br/>
        [处理逻辑]：依据输入的工单号，产品编码<br/>
        [功能]：镭雕机接口，验证工单、产品编码关系是否正确<br/>
        [输入-参数]：orderNumber-工单号  itemCode-产品编码<br/>
        [输出-返回]：字符串，成功 【OK】; 失败 【NG:返回错误信息】<br/> 
        ")]
        public string LaserCarvingCheckOrder(string orderNumber,string itemCode)
        {
            string msg = "";
            LaserCarvingOrderInfo model = new LaserCarvingOrderInfo();
            try
            {
                if(orderNumber=="")
                {
                    return string.Format("NG;工单号不能传空！");
                }
                if (itemCode == "")
                {
                    return string.Format("NG;产品编码不能传空!");
                }
                model = ser.LaserCarvingCheckOrder(orderNumber, itemCode,ref msg);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            
            return string.Format(msg);
        }


        /// <summary>
        /// 镭雕机接口，获取SN号码
        /// </summary>
        /// <param name="orderNumber">工单号</param>
        /// <param name="count">条码数量</param>
        /// <returns></returns>       
        [WebMethod(Description = @"
        [镭雕接口2]<br/>
        [处理逻辑]：根据工单、产品编码、拼版数量获取SN号码信息<br/>
        [功能]：镭雕机接口，获取SN号码信息，多个用,号分隔)<br/>
        [输入-参数]：orderNumber-工单号;itemCode-产品编码;Qty-拼版数量<br/>
        [输出-返回]：字符串，成功 OK;【SN 条码序列号，多个用“,”号分隔】; 失败 NG;【返回错误信息】<br/> 
        ")]
        public string LaserCarvingGetOrderSN(string orderNumber,string itemCode,int qty)
        {
            string msg = "";
            string sn = "";
            try
            {
                if (orderNumber == "")
                {
                    return string.Format("NG;工单号不能传空！");
                }
                if (itemCode == "")
                {
                    return string.Format("NG;产品编码不能传空!");
                }
                if (qty<=0)
                {
                    return string.Format("NG;拼板数量要大于0!");
                }
                sn = ser.LaserCarvingGetOrderSN(orderNumber, itemCode, qty, ref msg);
                if (sn!="")
                {
                    msg = "OK;"+qty+"拼板;"+sn;
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return string.Format(msg);
        }


        /// <summary>
        /// 镭雕机接口，接收镭雕结果，更改状态
        /// </summary>
        /// <param name="orderNumber">工单号</param>
        /// <param name="itemCode">产品编码</param>
        /// <param name="json">镭雕结果</param>
        /// <returns></returns>       
        [WebMethod(Description = @"
        [镭雕接口3]<br/>
        [处理逻辑]：根据工单、产品编码、接收镭雕结果，更改SN状态<br/>
        [功能]：镭雕机接口，接收镭雕结果，更改SN状态,更新拼板状态（以第一SN作为拼板主号码进行绑定），雕机需整板条码ok，才传到MES<br/>
        [输入-参数]：orderNumber-工单号;itemCode-产品编码;json-接收的镭雕结果，例如:{""SN001"":""OK"",""SN002"":""OK""}<br/>
        [输出-返回]：字符串，成功 OK; 失败 NG;【返回错误信息】<br/> 
        ")]
        public string LaserCarvingUpdateSNStatus(string orderNumber, string itemCode, string json)
        {
            string msg = "";
            string sn = "";
            try
            {
                if (orderNumber == "")
                {
                    return string.Format("NG;工单号不能传空！");
                }
                if (itemCode == "")
                {
                    return string.Format("NG;产品编码不能传空!");
                }

                sn= ser.LaserCarvingUpdateSNStatus(orderNumber, itemCode, json, ref msg);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
          
            return string.Format(msg);
            
        }

    }
}
