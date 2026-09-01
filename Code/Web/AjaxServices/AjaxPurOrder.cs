using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;
using static SKT.LeanMES.Material.Model.PurOrderInfo;
namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPurOrder
    {


        /// <summary>
        /// 通过采购单ID获取采购单明细
        /// /// </summary>
        /// <param name="InspectionTemplateId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PurOrderDtlInfo> GetPurOrderDtlList(string poCode)
        {
            List<PurOrderDtlInfo> list = new List<PurOrderDtlInfo>();
            try
            {
                PurOrder bll = new PurOrder();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = string.Format("  POCode='{0}' ", poCode);
                //search.AddCondition("POCode",poCode); 
                list = bll.GetPurOrderDtlAll(0, int.MaxValue, "", search);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 采购单新增、修改
        /// </summary>
        /// <param name="entity"></param>
        ///<param name="detailStrJson"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void PurOrderEdit(string strjosn)
        {
            try
            {
                PurOrder bll = new PurOrder();

                PurOrderInfo entity = new PurOrderInfo();
                bll.PurOrderEdit(strjosn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 查询采购单和到货单的上传文件
        /// </summary>
        /// <param name="poCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<FileInfo> GetReportFileInfo(string poCode = "")
        {
            try
            {
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.ExtensionCondition = "(FromCode ='') ";
                if (poCode != "")
                {
                    searchSettings.ExtensionCondition = searchSettings.ExtensionCondition + " OR (FromCode = '" + poCode + "' and RowType in ('TestReport','ShippingReport'))";
                }
                return new PurOrder().GetSysUpLoadFileList(0, 1000, "", searchSettings);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        
    }
}