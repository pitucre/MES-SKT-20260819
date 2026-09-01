using System;
using AjaxPro;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxDelivery
    {
        /// <summary>
        /// 获取采购单信息
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetDeliverInfo(string buyOrder, string strType, string strVender, string sPoCode, bool cbShowAll)
        {
            string strJson = "";
            try
            {
                strJson = strType == "G" ? (new Deliver()).GetDeliverByGrn(buyOrder, strVender,sPoCode, AccountController.GetCurrentUser().UserName) : (new Deliver()).GetDeliverInfo(buyOrder, sPoCode, cbShowAll);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        /// <summary>
        /// 保存生成送货单
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string SaveDeliver(string strJson)
        {
            string str = "";
            try
            {
                str =(new Deliver()).Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 保存生成送货单 PDA
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string SaveDeliverToPDA(string strJson)
        {
            string str = "";
            try
            {
                str = (new Deliver()).EditToPDA(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 获取采购单信息
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetDeliverPrint(Int32 intId)
        {
            string strJson = "";
            try
            {
                strJson = (new Deliver()).GetDeliverPrint(intId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        /// <summary>
        /// 通过采购单号获取供应商信息
        /// </summary>
        /// <param name="GRN"></param>
        /// <returns></returns>
     /*   [AjaxMethod]
        public string GetSupplierByPo(string GRN)
        {
            string str = "";
            try
            {
                str = (new ERPPOorder()).GetSupplierByPo(GRN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }*/

        [AjaxMethod]
        public string checkPOLineCanDel(string pocode, string rowid, string grns)
        {
            string str = "";
            try
            {
                (new Deliver()).checkPOLineCanRemove(pocode, rowid, grns);
            }
            catch (Exception ex)
            {
                str = ex.Message;
                WebHelper.HandleException(ex);
            }
            return str;
        }

        [AjaxMethod]
        public string checkGrnCanRemove(string grns)
        {
            string str = "";
            try
            {
                (new Deliver()).checkGrnCanRemove(grns);
            }
            catch (Exception ex)
            {
                str = ex.Message;
                WebHelper.HandleException(ex);
            }
            return str;
        }
        /// <summary>
        /// 检验送货单是否已存在扫描GRN记录且不存在确认收料记录
        /// </summary>
        /// <param name="deliverNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool CheckDeliverNoIsScanGRN(string deliverNo)
        {
            bool isScan = false;
            try
            {
                isScan = (new Deliver()).CheckDeliverNoIsScanGRN(deliverNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return isScan;
        }
        /// <summary>
        /// 撤销送货单
        /// </summary>
        /// <param name="deliverNo"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void RevocationDeliverNo(string deliverNo, string userName)
        {
            try
            {
                (new Deliver()).RevocationDeliverNo(deliverNo, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}