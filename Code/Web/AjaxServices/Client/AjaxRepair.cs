using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ProductionCollection.Client;
using System.Data;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.Product.BLL;
using System.Transactions;

namespace SKT.LeanMES.Web.AjaxServices
{
    /******************************************************************************************
 * 类名：AjaxRepair      
 * 功能描述：此类主要应用于开发内置UI类型为【维修】的Ajax方法
 * 创建人：zhiman.yuan
 * 创建时间：2017-7-13
 * 修改人：
 * 修改时间：
 ******************************************************************************************/
    public class AjaxRepair
    {

        #region 不良接收
       
        /// <summary>
        /// 检测扫描的SN条码信息是否需要维修，是否已经接收过
        /// </summary>
        /// <param name="sn"></param>
        [AjaxMethod]
        public string CheckReceiveSN(string sn)
        {
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            string mainSN = "";           
            try
            {
                mainSN = repairBll.CheckReceiveSN(sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return mainSN;
        }

        /// <summary>
        /// 检查扫描的维修SN，如果扫的是部件带出主件SN
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string CheckRepairSN(string sn, int stationId, int resouceId)
        {
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            string mainSN = "";
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                mainSN = repairBll.CheckRepairSN(sn,stationId,resouceId,userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return mainSN;
        }

        /// <summary>
        /// 保存不良接收信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="receiveUserId"></param>
        /// <param name="userId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void CollectReceiveSN(string sn, int receiveUserId, int stationId, int resId)
        {
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                repairBll.CollectReceiveSN(sn,receiveUserId,userId,stationId,resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion

        #region 不良维修
        
        /// <summary>
        /// 获取具体产品相关的不良记录
        /// </summary>
        /// <param name="scanSN">产品条码</param>   
        /// <param name="status">不良记录状态</param> 
        /// <returns></returns>
        [AjaxMethod]
        public string GetNcCodeDetail(string scanSN, string status)
        {
            string result = "[]";
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            DataTable dt = repairBll.GetNCDataInfo(scanSN, status);
            if (dt.Rows.Count > 0)
            {
                result = AppCode.Utility.ConvertJson.ToJson(dt);
            }
            return result;
        }

        /// <summary>
        /// 获取不良记录的详情描述
        /// </summary>
        /// <param name="ncDataId">不良记录ID</param>       
        /// <returns></returns>
        [AjaxMethod]
        public string GetNcDataDesc(int ncDataId)
        {
            string result = "[]";
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            DataTable dt = repairBll.GetNcDataDesc(ncDataId);
            if (dt.Rows.Count > 0)
            {
                result = AppCode.Utility.ConvertJson.ToJson(dt);
            }
            return result;
        }

        /// <summary>
        /// <不良维修--查询工序绑定的不良检测代码>
        /// </summary>
        /// <param name="scanSN">产品条码</param>
        /// <param name="debugCode">检测代码</param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetNCDebugCodeList(string scanSN, string debugCode,int OpeId)
        {
            string result = "[]";
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            DataTable dt = repairBll.GetNCDebugCodeList(scanSN, debugCode, OpeId);
            if (dt.Rows.Count > 0)
            {
                result = AppCode.Utility.ConvertJson.ToJson(dt);
            }
            return result;
        }

        /// <summary>
        /// <不良维修--查询工序绑定的不良维修代码>
        /// </summary>
        /// <param name="scanSN">产品条码</param>
        /// <param name="repairCode">维修代码</param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetNCRepairCodeList(string scanSN, string repairCode, int OpeId)
        {
            string result = "[]";
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            DataTable dt = repairBll.GetNCRepairCodeList(scanSN, repairCode, OpeId);
            if (dt.Rows.Count > 0)
            {
                result = AppCode.Utility.ConvertJson.ToJson(dt);
            }
            return result;
        }

        /// <summary>
        /// 获取不良代码数据采集项
        /// </summary>
        /// <param name="scanSN"></param>
        /// <param name="repairCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetNCCodeDataField(int ncCodeId)
        {
            string result = "[]";
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            DataTable dt = repairBll.GetNCCodeDataField(ncCodeId);
            if (dt.Rows.Count > 0)
            {
                result = AppCode.Utility.ConvertJson.ToJson(dt);
            }
            return result;
        }

        /// <summary>
        /// 查询不良维修完成后的目的工位
        /// </summary>
        /// <param name="scanSN"></param>
        /// <param name="opeId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetRepairNextStation(string scanSN, int opeId)
        {
            string result = "[]";
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            DataTable dt = repairBll.GetRepairNextStation(scanSN, opeId);
            if (dt.Rows.Count > 0)
            {
                result = AppCode.Utility.ConvertJson.ToJson(dt);
            }
            return result;
        }

        /// <summary>
        /// 查询不良代码列表
        /// </summary>
        /// <param name="category">不良类别</param>
        /// <param name="nccode">不良代码</param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetNCCodeList(string category, string nccode)
        {
            string result = "[]";
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            DataTable dt = repairBll.GetNCCodeList(category, nccode);
            if (dt.Rows.Count > 0)
            {
                result = AppCode.Utility.ConvertJson.ToJson(dt);
            }
            return result;
        }
      
        /// <summary>
        /// 更新不良记录的不良点
        /// </summary>
        /// <param name="ncDataId">不良记录ID</param>
        /// <param name="ncCodeId">不良代码ID</param>
        [AjaxMethod]
        public void UpdateTypeInNCCode(int ncDataId, int ncCodeId)
        {
            try
            {
                ProdCollectionRepair repairBll = new ProdCollectionRepair();
                repairBll.UpdateTypeInNCCode(ncDataId, ncCodeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 保存维修记录 如果有组件变更保存组装信息，以及部件变更记录。
        /// </summary>
        /// <param name="unitId"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="data"></param>
        /// <param name="bomId"></param>
        /// <param name="assyDataChangeRecords"></param>
        [AjaxMethod]
        public void SynthesisRepairPartsChange(int unitId, int opeId, int resId, int userId, string data, int bomId, string assyDataChangeRecords)
        {
            try
            {
                ProdCollectionRepair repairBll = new ProdCollectionRepair();
                repairBll.SynthesisRepairPartsChange(unitId, opeId, resId, userId, data, bomId, assyDataChangeRecords);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// <不良维修--产品条码所有不良维修完成后产品过站>
        /// </summary>
        /// <param name="unitID"></param>
        /// <param name="opeID">当前操作的工位</param>
        /// <param name="stationID">指定的过站工位</param>
        /// <param name="userID"></param>
        /// <param name="resID"></param>
        /// <param name="passType">
        /// 过站类型 
        /// 1、默认工位过站（维修后的目的工位只有一个） 
        ///	2、指定工位过站（维修后有多个目的工位可以选择）
        /// </param>
        [AjaxMethod]
        public void NcRepairUnitComplete(Int64 unitID, int opeID, int stationID, int userID, int resID, int passType)
        {
            try
            {
                ProdCollectionRepair repairBll = new ProdCollectionRepair();
                repairBll.NcRepairUnitComplete(unitID, opeID, stationID, userID, resID, passType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        [AjaxMethod]
        public void SaveSNScrap(string SN, int stationId, int resourceId, int gotoStationId, int userId,int passType)
        {
            try
            {
                ProdCollectionRepair repairBll = new ProdCollectionRepair();
                repairBll.SaveSNScrap(SN,stationId,resourceId,gotoStationId,userId,passType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 物料更换

        [AjaxMethod]
        /// <summary>
        /// 获取物料BOM列表
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<ItemBomChildInfo> GetItemBomListByPosition(ItemBomChildInfo entity)
        {
            try
            {
                ItemBomChild bll = new ItemBomChild();
                return bll.GetItemBomListByPosition(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }


        [AjaxMethod]
        /// <summary>
        /// 获取物料BOM列表
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public void MaterialReplace(NcReplaceMaterialInfo entity)
        {
            try
            {
                ProdCollectionRepair bll = new ProdCollectionRepair();
                bll.MaterialReplace(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion


        #region RMA维修

        /// <summary>
        /// 获取扫描SN的不良代码记录
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetRMANcCode(string sn)
        {
            string result = "[]";
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            DataTable dt = repairBll.GetRMANcCode(sn);
            if (dt.Rows.Count > 0)
            {
                result = AppCode.Utility.ConvertJson.ToJson(dt);
            }
            return result;
        }

        /// <summary>
        /// 保存维修记录 如果有组件变更保存组装信息，以及部件变更记录。
        /// </summary>
        /// <param name="unitId"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="data"></param>
        /// <param name="bomId"></param>
        /// <param name="assyDataChangeRecords"></param>
        [AjaxMethod]
        public void SynthesisRepairPartsChangeRMA(int unitId, int opeId, int resId, int userId, string data, int bomId, string assyDataChangeRecords, string warrantyDate, bool isWarranty)
        {
            TransactionOptions option = new TransactionOptions();
            option.IsolationLevel = System.Transactions.IsolationLevel.ReadCommitted;
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required, option))
                {

                    repairBll.SynthesisRepairPartsChange(unitId, opeId, resId, userId, data, bomId, assyDataChangeRecords);
                    repairBll.CollectRMARepairInfo(unitId, warrantyDate, isWarranty, userId, opeId, resId);

                    ts.Complete();
                }


            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public string GetRMAInfo(string sn)
        {
            string result = "[]";
            ProdCollectionRepair repairBll = new ProdCollectionRepair();
            try
            {
                DataTable dt = repairBll.GetRMAInfo(sn);

                if (dt.Rows.Count > 0)
                {
                    result = AppCode.Utility.ConvertJson.ToJson(dt);
                }
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return result;
        }
        #endregion
    }
}