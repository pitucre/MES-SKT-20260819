/*-------------------------------------------------
// Copyright(C)2016 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:AjaxClientController.cs
// 文件功能描述：用于生产采集模块中的流程验证、Activity等的执行
// 
// 创建标识：Larry.Lin 2016/08/05
// 
// 
//--------------------------------------------------*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using System.Text;
using System.Data;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.ProductionCollection.Client;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.Labels.Model;
using SKT.LeanMES.Labels.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxClientController
    {

        /// <summary>
        /// 切换站位返回对应的带参数跳转路径
        /// </summary>
        /// <param name="stationId">工序Id</param>
        /// <param name="resourceId">资源Id</param>
        /// <returns></returns>
        [AjaxMethod]
        public string SwitchStation(int stationId, int resourceId)
        {

            SKT.LeanMES.ClientConfig.BLL.PopedomInStation bll = new LeanMES.ClientConfig.BLL.PopedomInStation();

            return bll.GetLocationByStationId(stationId, resourceId);
        }

        #region 拼版绑定

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
            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();
            try
            {
                entity = pcb.CheckPanelBindSN(sn, prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
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
            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();
            try
            {
                pcb.CollectPanelBindSN(panelUnitIdArr, stationId, resId, userId);
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
            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();
            try
            {
                grnArr = pcb.CheckPanelBindGRN(grn, prodOrderId, stationId);
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
            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                entity = pcb.CheckMatPanelBindSN(sn, prodOrderId, stationId, resId, userId);
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
            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();
            decimal balanceQty = 0;
            int userId = AccountController.GetCurrentUser().UserId;
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                balanceQty = pcb.CollectMatPanelBindSN(panelUnitIdArr, stationId, resId, userId, userName, grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return balanceQty;
        }
        #endregion

        #region 投入采集


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
            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();
            int userId = AccountController.GetCurrentUser().UserId;

            try
            {
                pcb.CollectOrderInput(sn, resId, stationId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 在线条码投入过站--验证当前SN的工单是否与投入站位选择的工单一致
        /// 离线条码投入过站--将当前条码插入Prod_SerialNumber/Prod_Unit表并与投入工单关联起来
        /// </summary>
        /// <param name="SN">产品条码</param>
        /// <param name="prodOrderId">工单ID</param>
        /// <param name="routerId">路由ID</param>        
        /// <param name="isOffLineSN">是否为离线条码投入 0、不是 1、是 </param>
        [AjaxMethod]
        public decimal CheckSNInputOrder(string SN, int prodOrderId, int routerId, int isOffLineSN, string grn, int resId, int stationId, int isOnLineSN)
        {
            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();

            int userId = AccountController.GetCurrentUser().UserId;
            decimal balanceQty = -1;
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                balanceQty = pcb.CheckSNInputOrder(SN, prodOrderId, routerId, userId, isOffLineSN, grn, resId, stationId, userName, isOnLineSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return balanceQty;
        }

        /// <summary>
        /// 获取工单产品的离线条码规则
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetRegExpByOrderId(int prodOrderId)
        {
            string regExp = "";
            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();
            try
            {
                regExp = pcb.GetRegExpByOrderId(prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return regExp;
        }
        #endregion

        #region 采集送检单

        /// <summary>
        /// 查询送检单信息
        /// </summary>
        /// <param name="inspectionQty"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetInspectionSheet(int inspectionQty)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            string[] inspectionArr = new string[3];

            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();
            try
            {
                inspectionArr = pcb.GetInspectionSheet(inspectionQty, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return inspectionArr;
        }

        /// <summary>
        /// 编辑送检单信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="inspectionId"></param>
        /// <param name="flag"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] EditInspectionSheet(string sn, int opeId, int resId)
        {
            string[] inspectionArr = new string[2];

            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;

            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();
            try
            {
                inspectionArr[0] = pcb.EditInspectionSheet(sn, opeId, resId, userId, userName);
                inspectionArr[1] = DateTime.Now.ToString();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return inspectionArr;
        }


        /// <summary>
        /// 手动关闭送检单
        /// </summary>
        /// <param name="inspectionId"></param>
        [AjaxMethod]
        public void CloseInspectionSheet(int inspectionId)
        {
            ProductionCollection.ProdCollectBinding pcb = new ProductionCollection.ProdCollectBinding();
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                pcb.CloseInspectionSheet(inspectionId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 通用方法
        /// <summary>
        /// 通用过站验证
        /// </summary>
        /// <param name="strSN">SN</param>
        /// <param name="resId">资源Id</param>
        /// <param name="stationId">工序Id</param>
        /// <param name="isRepair">是否维修</param>
        [AjaxMethod]
        public void CommonValidate(string strSN, int resId, int stationId, bool isRepair = false)
        {
            ProdCollectionCommon commonBll = new ProdCollectionCommon();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                commonBll.ProcessValidation(strSN, userId, stationId, resId, isRepair);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 记录用户登录选择的工序资源等信息
        /// </summary>
        /// <param name="stationId"></param>
        /// <param name="redId"></param>
        /// <param name="userId"></param>    
        [AjaxMethod]
        public void SetUserLoginCache(int stationId, int resId)
        {
            SKT.LeanMES.ClientConfig.BLL.ClientProInfoConfig bll = new LeanMES.ClientConfig.BLL.ClientProInfoConfig();
            string hostName = "";
            string hostAddress = "";
            int userId = 0;
            userId = AccountController.GetCurrentUser().UserId;

            bll.SetUserLoginCache(stationId, resId, userId, hostName, hostAddress);
        }

        /// <summary>
        /// 获取用户默认登录地址信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string GetUserLoginLocation()
        {
            SKT.LeanMES.ClientConfig.BLL.ClientProInfoConfig bll = new LeanMES.ClientConfig.BLL.ClientProInfoConfig();
            int userId = 0;
            userId = AccountController.GetCurrentUser().UserId;
            return bll.GetUserLoginCache(userId);
        }

        /// <summary>
        /// 获取资源
        /// </summary>
        /// <param name="resClass"></param>
        /// <param name="resKey"></param>
        /// <returns></returns>
        [AjaxMethod]
        public String GetResourceString(string resClass, string resKey)
        {
            string str = "";

            HttpCookie cookie = HttpContext.Current.Request.Cookies["lang"];
            string lang = cookie == null ? "zh-cn" : cookie.Value;
            Object resource = HttpContext.GetGlobalResourceObject(resClass, resKey, new System.Globalization.CultureInfo(lang));
            if (resource != null)
            {
                str = resource.ToString();
            }
            return str;
        }

        /// <summary>
        /// 扫描序列号操作完成
        /// </summary>
        /// <param name="unitID"></param>
        /// <param name="opeID"></param>
        /// <param name="isPass"></param>
        /// <param name="lineID"></param>
        /// <param name="userID"></param>
        /// <param name="resID"></param>
        /// <param name="enterTime"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void UnitComplete(string sn, int stationId, int resID, bool isPass)
        {
            ProdCollectionCommon commonBll = new ProdCollectionCommon();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                commonBll.UnitComplete(sn, userId, stationId, resID, isPass);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 通过扫描的SN获取拼版ID
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetPanelInfoBySN(string sn)
        {
            string[] panelArr = new string[4];
            ProdCollectionCommon inputCommon = new ProdCollectionCommon();
            try
            {
                panelArr = inputCommon.GetPanelInfoBySN(sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return panelArr;
        }

        /// <summary>
        /// 通过扫描的SN获取拼版信息SN信息
        /// </summary>
        /// <param name="panelId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetPanelListInfoById(Int64 panelId)
        {
            string[] panelArr = new string[] { };
            ProdCollectionCommon inputCommon = new ProdCollectionCommon();
            try
            {
                panelArr = inputCommon.GetPanelListInfoById(panelId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return panelArr;
        }

        /// <summary>
        /// 获取是否打印条码信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="snTypeId">--1、包装箱 2、栈板 3、客户条码</param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool CheckIsPrintSN(string sn, int snTypeId, int stationId)
        {
            bool isPrint = true;
            ProdCollectionCommon inputCommon = new ProdCollectionCommon();
            try
            {
                isPrint = inputCommon.CheckIsPrintSN(sn, snTypeId, stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return isPrint;
        }

        /// <summary>
        /// 获取产品信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public SKT.LeanMES.ProdUnit.Model.ProdUnitInfo GetUnitInfo(string sn)
        {
            SKT.LeanMES.ProdUnit.Model.ProdUnitInfo entity = new ProdUnit.Model.ProdUnitInfo();
            SKT.LeanMES.ProdUnit.BLL.ProdUnit puBll = new ProdUnit.BLL.ProdUnit();
            try
            {
                entity = puBll.GetProdUnitInfo(sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 某用户是否有某权限
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="popedom">权限</param>
        /// <returns></returns>
        [AjaxMethod]
        public Boolean IsPermission(int userId, int popedom)
        {
            return SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(userId, popedom);
        }

        #endregion

        #region 释放打印条码、重新打印条码

        /// <summary>
        /// 根据扫描条码释放新的SN
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>      
        /// <returns></returns>
        [AjaxMethod]
        public string ReleaseSNAndPrint(string sn, int stationId, int resourceId)
        {
            string snStr = "";
            ProdCollectionCommon commonBll = new ProdCollectionCommon();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                snStr = commonBll.ReleaseSNAndPrint(sn, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return snStr;
        }

        /// <summary>
        /// 保存打印记录
        /// </summary>
        /// <param name="entity">打印记录</param>
        [AjaxMethod]
        public void RecodePrint(PrintRecordInfo entity)
        {
            try
            {
                PrintRecord bll = new PrintRecord();
                entity.PrintUser = AccountController.GetCurrentUser().UserName;
                entity.PrintTime = DateTime.Now;
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据SN获取已经打印过的记录
        /// </summary>
        /// <param name="scanSN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<LabelDocumentInfo> GetReprintSNInfo(string scanSN)
        {
            LabelPrint bll = new LabelPrint();
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            try
            {
                list = bll.GetReprintSNInfo(scanSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        #endregion

        /// <summary>
        /// 检查是否需要进行某项操作
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="snTypeId"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool CheckIsOperate(string sn, int operateType, int stationId)
        {
            bool isOperate = false;
            ProdCollectionCommon inputCommon = new ProdCollectionCommon();
            try
            {
                isOperate = inputCommon.CheckIsOperate(sn, operateType, stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return isOperate;
        }

        /// <summary>
        /// 检查系统是否存在此条码
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="operateType"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool CheckIsExsitSN(string sn, int stationId, int resouceId)
        {
            bool isExsist = false;
            ProdCollectionCommon inputCommon = new ProdCollectionCommon();
            try
            {
                isExsist = inputCommon.CheckIsExsitSN(sn, stationId, resouceId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return isExsist;
        }
        /// <summary>
        /// 通过扫描的SN获取拼版ID
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetPanelInfoBySN_PDA(string sn)
        {
            string[] panelArr = new string[5];
            ProdCollectionCommon inputCommon = new ProdCollectionCommon();
            try
            {
                panelArr = inputCommon.GetPanelInfoBySN_PDA(sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return panelArr;
        }

        ///// <summary>
        ///// 首件检验验证
        ///// </summary>
        ///// <param name="ProdOrderId"></param>
        //[AjaxMethod]
        //public void CheckOrderFAI(int ProdOrderId)
        //{
        //    ProdCollectionCommon commonBll = new ProdCollectionCommon();
        //    int userId = AccountController.GetCurrentUser().UserId;
        //    try
        //    {
        //        commonBll.CheckOrderFAI(ProdOrderId);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //}
    }
}
