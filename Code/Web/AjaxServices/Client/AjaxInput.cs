using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.ProductionCollection.Client;
namespace SKT.LeanMES.Web.AjaxServices
{
    /******************************************************************************************
     * 类名：AjaxInput      
     * 功能描述：此类主要应用于开发内置UI类型为【投入】的Ajax方法
     * 创建人：zhiman.yuan
     * 创建时间：2017-7-3
     * 修改人：
     * 修改时间：
     ******************************************************************************************/
    public class AjaxInput
    {
        #region 拼板绑定

        /// <summary>
        /// 检测拼版SN信息返回拼版规格
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ProdCollectionInputInfo CheckPanelBindSN(string sn, int prodOrderId)
        {
            ProdCollectionInputInfo entity = new ProdCollectionInputInfo();
            ProdCollectionInput inputBll = new ProdCollectionInput();
            try
            {
                entity = inputBll.CheckPanelBindSN(sn, prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }


        /// <summary>
        /// 检测拼版SN信息返回拼版规格,add by weixia on 2018.3.29
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ProdCollectionInputInfo CheckScanPanelSN(string sn, int prodOrderId)
        {
            ProdCollectionInputInfo entity = new ProdCollectionInputInfo();
            ProdCollectionInput inputBll = new ProdCollectionInput();
            try
            {
                entity = inputBll.CheckScanPanelSN(sn, prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 检查扫描的拼板子条码
        /// </summary>
        /// <param name="panelSN"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="sn"></param>
        [AjaxMethod]
        public void checkScanSNBiandPanel(string panelSN, int prodOrderId, string sn)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            try
            {
                inputBll.checkScanSNBiandPanel(panelSN, prodOrderId, sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 保存拼版绑定
        /// </summary>
        /// <param name="panelScanStr"></param>
        /// <param name="panelSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void savePanelBindSN(string panelScanStr, string panelSN, int stationId, int resourceId)
        {
            int userId = 0;
            userId = AccountController.GetCurrentUser().UserId;
            ProdCollectionInput inputBll = new ProdCollectionInput();
            try
            {
                inputBll.savePanelBindSN(panelScanStr, panelSN, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 拼版投入过站
        /// </summary>
        /// <param name="panelUnitIdArr">拼版集合</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="resId">资源ID</param>
        /// <param name="userId">用户ID</param>
        [AjaxMethod]
        public void CollectPanelBindSN(string panelUnitIdArr, int stationId, int resId)
        {
            int userId = 0;
            userId = AccountController.GetCurrentUser().UserId;
            ProdCollectionInput inputBll = new ProdCollectionInput();
            try
            {
                inputBll.CollectPanelBindSN(panelUnitIdArr, stationId, resId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 验证产线是否开拉
        ///验证GRN信息
        ///返回GRN数量 物料信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public decimal[] CheckPanelBindGRN(string grn, int prodOrderId, int stationId)
        {
            decimal[] grnArr = new decimal[3];
            ProdCollectionInput inputBll = new ProdCollectionInput();
            try
            {
                grnArr = inputBll.CheckPanelBindGRN(grn, prodOrderId, stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return grnArr;
        }

        /// <summary>
        /// 验证SN
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="sacnCount"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ProdCollectionInputInfo CheckMatPanelBindSN(string sn, int prodOrderId, int stationId, int resId)
        {
            ProdCollectionInputInfo entity = new ProdCollectionInputInfo();
            ProdCollectionInput inputBll = new ProdCollectionInput();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                entity = inputBll.CheckMatPanelBindSN(sn, prodOrderId, stationId, resId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 拼版上料投入过站
        /// </summary>
        /// <param name="panelUnitIdArr"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public decimal CollectMatPanelBindSN(string panelUnitIdArr, int stationId, int resId, string grn)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            decimal balanceQty = 0;
            int userId = AccountController.GetCurrentUser().UserId;
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                balanceQty = inputBll.CollectMatPanelBindSN(panelUnitIdArr, stationId, resId, userId, userName, grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return balanceQty;
        }

        #endregion

        #region 上料投入采集UI


        /// <summary>
        /// 验证产线是否开拉
        ///验证GRN信息
        ///返回GRN数量 物料信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public decimal[] CheckInputGRN(string grn, int prodOrderId, int stationId)
        {
            decimal[] grnArr = new decimal[3];
            ProdCollectionInput inputBll = new ProdCollectionInput();
            try
            {
                grnArr = inputBll.CheckInputGRN(grn, prodOrderId, stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return grnArr;
        }

        /// <summary>
        /// 检查投入SN
        /// </summary>
        /// <param name="sn">产品序号</param>
        /// <param name="prodOrderId">工单ID</param>
        /// <param name="stationId">工序ID</param>
        /// <returns></returns>
        [AjaxMethod]
        public ProdCollectionInputInfo CheckMatInputSN(string sn, int prodOrderId, int stationId, int resId, int scanCount)
        {
            ProdCollectionInputInfo entity = new ProdCollectionInputInfo();
            ProdCollectionInput inputBll = new ProdCollectionInput();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                entity = inputBll.CheckMatInputSN(sn, prodOrderId, stationId, resId, userId, scanCount);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 拼版上料投入过站
        /// </summary>
        /// <param name="panelUnitIdArr"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public decimal CollectMatInputSN(string panelUnitIdArr, int stationId, int resId, string grn)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            decimal balanceQty = 0;
            int userId = AccountController.GetCurrentUser().UserId;
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                balanceQty = inputBll.CollectMatInputSN(panelUnitIdArr, stationId, resId, userId, userName, grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return balanceQty;
        }
        #endregion

        #region 投入采集UI

        /// <summary>
        /// 检查投入SN，返回掩码规则/拼版信息
        /// </summary>
        /// <param name="sn">产品序号</param>
        /// <param name="prodOrderId">工单ID</param>
        /// <param name="stationId">工序ID</param>
        /// <returns></returns>
        [AjaxMethod]
        public ProdCollectionInputInfo CheckInputSN(string sn, int prodOrderId, int stationId, int resId)
        {
            ProdCollectionInputInfo entity = new ProdCollectionInputInfo();
            ProdCollectionInput inputBll = new ProdCollectionInput();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                entity = inputBll.CheckInputSN(sn, prodOrderId, stationId, resId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 进行离线条码投入过站
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="routerId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void OffLineSNInput(string sn, int prodOrderId, int routerId, int stationId, int resId)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            int userId = AccountController.GetCurrentUser().UserId;

            try
            {
                inputBll.OffLineSNInput(sn, prodOrderId, routerId, stationId, resId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 投入过站
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="resId"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void CollectOrderInput(string sn, int resId, int stationId)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            int userId = AccountController.GetCurrentUser().UserId;

            try
            {
                inputBll.CollectOrderInput(sn, resId, stationId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion

        #region 转工单采集UI

        /// <summary>
        /// 转工单
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="opeId"></param>
        [AjaxMethod]
        public void ChangeOrder(string sn, int prodOrderId, int stationId, int resId)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            int userId = AccountController.GetCurrentUser().UserId;

            try
            {
                inputBll.ChangeOrder(prodOrderId, sn, stationId, resId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion

        #region 整机投入【聚电】

        #region 判断该条码是否存在未打散的客户条码
        /// <summary>
        /// 判断该条码是否存在未打散的客户条码
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="checkType"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        [AjaxMethod]
        public string CheckSNAnew(string sn, int prodOrderId, int checkType, int stationId, int resouceId)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            int userId = AccountController.GetCurrentUser().UserId;
            string userName = AccountController.GetCurrentUser().UserName;
            string strResult = "";

            try
            {
                strResult = inputBll.CheckSNAnew(sn, prodOrderId, checkType, stationId, resouceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strResult;
        }
        #endregion

        /// <summary>
        /// 验证采集整机投入信息
        /// </summary>
        /// <param name="sn">--扫描的SN信息[DIP段完工的条码]</param>
        /// <param name="prodOrderId"></param>
        /// <param name="checkType">-- 1、验证升级工单逻辑 2、验证SN（客户条码1） 3、验证Mac(客户条码2)</param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void CheckFinishedGoodsInput(string sn, int prodOrderId, int checkType, int stationId, int resouceId)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            int userId = AccountController.GetCurrentUser().UserId;
            string userName = AccountController.GetCurrentUser().UserName;

            try
            {
                inputBll.CheckFinishedGoodsInput(sn, prodOrderId, checkType, stationId, resouceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 采集整机投入信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="cusSN1"></param>
        /// <param name="cusSN2"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void FinishedGoodsInput(string sn, int prodOrderId, string cusSN1, string cusSN2, int stationId, int resouceId)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            int userId = AccountController.GetCurrentUser().UserId;
            string userName = AccountController.GetCurrentUser().UserName;

            try
            {
                inputBll.FinishedGoodsInput(sn, prodOrderId, cusSN1, cusSN2, stationId, resouceId, userId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion

        #region 彩盒扫描验证

        /// <summary>
        /// 彩盒扫描工序验证
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="macSN"></param>
        [AjaxMethod]
        public void ColorBoxValidation(string sn, string macSN)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            try
            {
                inputBll.ColorBoxValidation(sn, macSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion


        /// <summary>
        /// 检测拼版SN信息返回拼版规格
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ProdCollectionInputInfo GetPanelInfoByOrderId(int prodOrderId)
        {
            ProdCollectionInput inputBll = new ProdCollectionInput();
            try
            {
                return inputBll.GetPanelInfoByOrderId(prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        } 




    }
}