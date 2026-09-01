using System;
using System.Collections.Generic;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxERPPOorder
    {
        /// <summary>
        /// 通过采购单号获取物料信息
        /// </summary>
        /// <param name="billNo">采购单号</param>
        /// <returns>物料信息列表</returns>
        [AjaxMethod]
        public object[] GetPOEntryByBillNum(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            object[] objArr = new object[2];
            List<ERPPOorderEntryInfo> list = new List<ERPPOorderEntryInfo>();
            MaterialUnit UnitBll = new MaterialUnit();            
            try
            {
                //objArr = UnitBll.GetMaterialListByPO(startRow, maxRows, sortExpression, searchSettings);
                
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
             
            return objArr;
        }
         
    }
}