using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.SerialNumber.BLL;
namespace SKT.LeanMES.Web.AppCode.Utility
{
    public class GenerateHelper
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="appTypeId">申请类型（1.产品 2.货位 3.单据）</param>
        /// <param name="appRuleId">序列号规则类型ID(1.编码规则 2.包装规则)</param>
        /// <param name="appId">需要获取序列号对应的产品ID/货位ID/单据ID</param>
        /// <param name="SN">返回的序列号</param>
        /// <returns></returns>
        public static string GenerateRuleMethod(Int32 appTypeId, Int32 appRuleId, Int32 appId, String SN)
        {
            string  serialNumber = "";
            try
            {
                SKT.LeanMES.SerialNumber.BLL.SerialNumber serialBll = new LeanMES.SerialNumber.BLL.SerialNumber();
                serialNumber = serialBll.GenerateRuleMethod(appTypeId, appRuleId, appId, SN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(String.Empty, ex, true);
            }
            return serialNumber;
        }
    }
}