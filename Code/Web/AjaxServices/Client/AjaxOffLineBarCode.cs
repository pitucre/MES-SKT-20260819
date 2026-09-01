using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.ProductionCollection.Client;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxOffLineBarCode
    {
        /// <summary>
        /// 离线条码注册，验证工单及获取信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ProdCollectionInputInfo CheckProdOrderIdAndGetInfo(int prodOrderId)
        {
            ProdCollectionInputInfo entity = new ProdCollectionInputInfo();
            ProdCollectionOffLineBarCode inputBll = new ProdCollectionOffLineBarCode();
            try
            {
                entity = inputBll.CheckProdOrderIdAndGetInfo(prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 通过工单和工序，找到掩码规则，js进行验证
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string CheckOffLineBarCode(int stationId, int prodOrderId)
        {
            string expression = "";
            try
            {
                ProdCollectionOffLineBarCode inputBll = new ProdCollectionOffLineBarCode();
                expression = inputBll.CheckOffLineBarCode(stationId, prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return expression;
        }
        /// <summary>
        /// 验证扫描的SN
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void  checkOffLineSN(int stationId, int prodOrderId,string SN)
        {
            try
            {
                ProdCollectionOffLineBarCode inputBll = new ProdCollectionOffLineBarCode();
                inputBll.checkOfflineSN(stationId,prodOrderId,SN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 保存离线条码
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void SaveOffLineBarCod(string scanStr, Int32 prodOrderId, int stationId, int resourceId, int userId)
        {
            try
            {
                ProdCollectionOffLineBarCode inputBll = new ProdCollectionOffLineBarCode();
                inputBll.SaveOffLineBarCode(scanStr, prodOrderId, stationId,resourceId,userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 保存离线条码批次
        /// </summary>
        /// <param name="scanStr"></param>
        /// <param name="SNQty"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void SaveOffLineBarCodBatch(string scanStr, int SNQty,Int32 prodOrderId, int stationId, int resourceId, int userId)
        {
            try
            {
                ProdCollectionOffLineBarCode inputBll = new ProdCollectionOffLineBarCode();
                inputBll.SaveOffLineBarCodeBatch(scanStr, SNQty, prodOrderId, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        ///批量保存离线条码
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void SavePassByOffLineSN(string locationStr,string SN, Int32 prodOrderId, int stationId, int resourceId, int userId)
        {
            try
            {
                ProdCollectionOffLineBarCode inputBll = new ProdCollectionOffLineBarCode();
                inputBll.SavePassByOffLineSN(locationStr,SN, prodOrderId, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

    }
}