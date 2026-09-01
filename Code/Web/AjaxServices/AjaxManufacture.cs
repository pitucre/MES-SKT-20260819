using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Manufacture.BLL;
using SKT.LeanMES.Manufacture.Model;
using SKT.LeanMES.ProdUnit.Model;
using SKT.LeanMES.Warehouse.Model;
using System.Data;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.ProductionCollection.Client;

namespace SKT.LeanMES.Web.AjaxServices
{
    /*************************************
    *              信息中心交互
    *              
    * 创建时间：2014-11-13                                         
    * 更新时间：  
    * 创建人：zhibin.Chen
    * 修改人：
    ************************************/
    public class AjaxManufacture
    {
        /// <summary>
        /// 获取该产品的所有物料或不显示移除的物料
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <param name="isAll"></param>
        [AjaxMethod]
        public List<ItemsInfo> GetAllItem(String serialNumber, Int32 isall)
        {
            List<ItemsInfo> itemsinfo = null;
            try
            {
                itemsinfo = new InfoCenter().GetUseItemList(serialNumber, isall);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return itemsinfo;
        }

        /// <summary>
        /// 根据产品序列号，获取物料使用的历史记录。
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ItemsInfo> GetItemUseHistory(String serialNumber)
        {
            List<ItemsInfo> itemsinfo = null;

            try
            {
                itemsinfo = new InfoCenter().GetItemUseHistory(serialNumber);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return itemsinfo;
        }

        /// <summary>
        /// 根据产品序列号，获取所使用的物料。
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <param name="isAll"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ItemsInfo> GetUseItemList(String serialNumber, Int32 isAll)
        {
            List<ItemsInfo> itemsinfo = null;

            try
            {
                itemsinfo = new InfoCenter().GetUseItemList(serialNumber, 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return itemsinfo;
        }

        /// <summary>
        /// 根据产品序列号，获取产品简要信息。
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public VUnitHistoryInfo GetProductSummaryInfo(String serialNumber)
        {
            VUnitHistoryInfo vuinfo = null;

            try
            {
                vuinfo = new InfoCenter().GetProductSummaryInfo(serialNumber);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return vuinfo;
        }

        /// <summary>
        /// 根据产品序列号，获取产品的生产记录。
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<VUnitHistoryInfo> GetProductHistory(String serialNumber)
        {
            List<VUnitHistoryInfo> vuinfo = new List<VUnitHistoryInfo>();
            try
            {
                vuinfo = new InfoCenter().GetProductHistory(serialNumber);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return vuinfo;
        }

        /// <summary>
        /// 根据物料ID，获取物料详细信息。
        /// </summary>
        /// <param name="SerialNumber"></param>
        /// <param name="itemId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ItemsInfo GetItemDetailInfo(String serialNumber, Int32 itemId)
        {
            ItemsInfo itemsinfo = null;
            try
            {
                itemsinfo = new InfoCenter().GetItemDetailInfo(serialNumber, itemId);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return itemsinfo;
        }

        /// <summary>
        /// 工单包含的产品列表分页
        /// </summary>
        /// <param name="productOrderNumber">工单号</param>
        /// <param name="startRow">开始行</param>
        /// <param name="maxRows">最大行</param>
        /// <param name="isPO">是否根据工单号查询,此方法调用时默认给值 1 。代表按工单号</param>
        /// <returns>返回产品序列号集合</returns>
        [AjaxMethod]
        public List<InfoCenterInfo> ProductListPaging(String productOrderNumber, Int32 startRow, Int32 maxRows, Int32 isPO)
        {
            List<InfoCenterInfo> plist = null;
            try
            {
                plist = new InfoCenter().GetProductListByOrderNo(productOrderNumber, startRow, maxRows, isPO);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return plist;
        }

        [AjaxMethod]
        public ProdUnitInfo GetProcessFormBySearch(String searchId, Int32 flage)
        {
            ProdUnitInfo entity = null;
            try
            {
                SKT.LeanMES.ProdUnit.BLL.ProdUnit bllUnit = new SKT.LeanMES.ProdUnit.BLL.ProdUnit();
                entity = bllUnit.GetProcessFormBySearch(searchId, flage);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        [AjaxMethod]
        public List<ProdUnitInfo> GetTurnNoInfoBySearch(String SearchStr, Int32 flage, String SaveScanSN, Int32 stationId, DateTime startDate, DateTime endDate)
        {
            List<ProdUnitInfo> list = new List<ProdUnitInfo>();
            try
            {
                SKT.LeanMES.ProdUnit.BLL.ProdUnit bllUnit = new SKT.LeanMES.ProdUnit.BLL.ProdUnit();
                list = bllUnit.GetTurnNoInfoBySearch(SearchStr, flage, SaveScanSN, stationId, startDate, endDate);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 绑定工序信息
        /// </summary>
        /// <param name="SearchStr"></param>
        /// <param name="flage"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ProdUnitInfo> GetStationByRouterName(String routerName)
        {
            List<ProdUnitInfo> list = new List<ProdUnitInfo>();
            try
            {
                SKT.LeanMES.ProdUnit.BLL.ProdUnit bllUnit = new SKT.LeanMES.ProdUnit.BLL.ProdUnit();
                list = bllUnit.GetProcessStationByRouterName(routerName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 保存产品变更
        /// </summary>
        [AjaxMethod]
        public void SaveProductionChange(Int32 routerId, Int32 stationId, String serialNumbers, int isUnAss, int isUnCustomerSN, int chkIsUnAgeing, string remark, int orderId = -1, int itemId = -1)
        {
            try
            {
                int userId = AccountController.GetCurrentUser().UserId;
                string userName = AccountController.GetCurrentUser().UserName;
                SKT.LeanMES.ProdUnit.BLL.ProdUnit bllUnit = new SKT.LeanMES.ProdUnit.BLL.ProdUnit();
                bllUnit.SaveProductionChange(routerId, stationId, userId, userName, serialNumbers, isUnAss, isUnCustomerSN, chkIsUnAgeing, remark, orderId, itemId);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据部件条码获取需要收集的数据信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SKT.LeanMES.ProductionCollection.Model.AssyDataDetailInfo> GetAssyDataDetailInfo(string sn, string mainSN)
        {
            SKT.LeanMES.ProductionCollection.Client.ProdCollectionAssemble pcb = new ProductionCollection.Client.ProdCollectionAssemble();
            List<ProductionCollection.Model.AssyDataDetailInfo> list = new List<ProductionCollection.Model.AssyDataDetailInfo>();
            try
            {
                list = pcb.GetAssyDataDetailInfo(sn, mainSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        [AjaxMethod]
        public List<StockInfo.WarehouseCpOutStockDtlInfo> GetMemberHistoryList(int id)
        {
            try
            {
                return new InfoCenter().GetMemberHistoryList(id);
            }
            catch (Exception)
            {

                throw;
            }
        }

        /// <summary>
        /// 根据SN获取生产详细信息
        /// </summary>
        [AjaxMethod]
        public DataTable GetProdDetailInfo(string sn)
        {
            DataTable dt = null;
            try
            {
                dt = new SKT.LeanMES.ProdUnit.BLL.ProdUnit().GetProdDetailInfo(sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }

        /// <summary>
        /// 强制生产变更  迁移by zhi.li 20180621
        /// </summary>
        /// <param name="SNList"></param>
        /// <param name="stationId"></param>
        /// <param name="isUnAss"></param>
        /// <param name="isUnCustomerSN"></param>
        [AjaxMethod]
        public void SaveForceChange(string SNList, int stationId, int isUnAss, int isUnCustomerSN)
        {
            try
            {
                int userId = AccountController.GetCurrentUser().UserId;
                string userName = AccountController.GetCurrentUser().UserName;
                SKT.LeanMES.ProdUnit.BLL.ProdUnit bllUnit = new SKT.LeanMES.ProdUnit.BLL.ProdUnit();
                bllUnit.SaveForceChange(SNList, stationId, userId, userName, isUnAss, isUnCustomerSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 维修更换物料列表
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public IList<NcReplaceMaterialInfo> GetRepairReplaceMaterial(NcReplaceMaterialInfo entity)
        {
            IList<NcReplaceMaterialInfo> list = null;
            try
            {
                ProdCollectionRepair bll = new ProdCollectionRepair();
                list = bll.GetRepairReplaceMaterial(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

    }
}