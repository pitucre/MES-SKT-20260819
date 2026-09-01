using System;
using System.Collections.Generic;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.MobileMat.BLL;
using SKT.LeanMES.MobileMat.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMobileShipment
    {
        /// <summary>
        /// 根据销售单号查询销售明细和相关的信息 陆文元 2015-12-29
        /// </summary>
        [AjaxMethod]
        public List<FinishProdShipmentInfo> JqueryWorkOderInfo(String Code)
        {
            List<FinishProdShipmentInfo> list = null;
            try
            {
                FinishProdShipment bllShipment = new FinishProdShipment();
                list = bllShipment.JqueryWorkOderInfo(Code);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 保存成品出货数据
        /// </summary>
        /// <param name="f"></param>
        [AjaxMethod]
        public void SaveShipment(FinishProdShipmentInfo f, string snList)
        {
            try
            {
                FinishProdShipment bllShipment = new FinishProdShipment();
                bllShipment.Edit(f, snList);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FinishProdOutInfo 实体对象。</returns>
        [AjaxMethod]
        public FinishProdShipmentInfo GetInfo(String fieldValue)
        {
            FinishProdShipmentInfo m = null;
            try
            {
                FinishProdShipment bllShipment = new FinishProdShipment();
                m = bllShipment.GetInfo(fieldValue);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return m;
        }
        /// <summary>
        /// 成品出货时，刷条码带出正确的ItemId和SN。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FinishProdOutInfo 实体对象。</returns>
        [AjaxMethod]
        public FinishProdShipmentInfo GetShipmentItemIdSN(String SN)
        {
            FinishProdShipmentInfo m = null;
            try
            {
                FinishProdShipment bllShipment = new FinishProdShipment();
                m = bllShipment.GetShipmentItemIdSN(SN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return m;
        }
        /// <summary>
        /// 根据shimpentId取得成品出货明细
        /// </summary>
        /// <param name="shimpentId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<FinishProdShipmentInfo> GetFinishProdShipmentItem(int shimpentId)
        {
            try
            {
                FinishProdShipment bll = new FinishProdShipment();
                List<FinishProdShipmentInfo> Listentity = bll.GetFinishProdShipmentItem(shimpentId);
                return Listentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
    }
}