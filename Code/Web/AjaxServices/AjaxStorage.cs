using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ProductionCollection;
using SKT.LeanMES.ProductionCollection.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxStorage
    {

        #region 成品入库
      
        /// <summary>
        /// 检测库位条码是否存在
        /// </summary>
        /// <param name="cBarCode"></param>
        [AjaxMethod]
        public void CheckScrapInStorage(string cBarCode)
        {
            try
            {
                ProdCollectBinding bll = new ProdCollectBinding();
                bll.CheckScrapInStorage(cBarCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        ///  验证包装条码是否存在
        /// </summary>
        /// <param name="SerialNumber"></param>
        /// <returns>反回1：包内条码有已入库的</returns>
        [AjaxMethod]
        public int CheckContainerSN(string serialNumber)
        {
            int storageId = -1;
            try
            {
                ProdCollectBinding bll = new ProdCollectBinding();
                storageId = bll.CheckContainerSN(serialNumber);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return storageId;
        }

        /// <summary>
        /// 查询当前产线是否有入库单
        /// </summary>
        /// <param name="resId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int CheckStorageOrder(int resId)
        {
            int storageId = -1;
            try
            {
                ProdCollectBinding bll = new ProdCollectBinding();
                storageId = bll.CheckStorageOrder(resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return storageId;
        }

        /// <summary>
        /// 通过SN获取库存表ID（SN 可为栈板、包装箱、产品SN）
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetStorageID(string serialNumber)
        {
            int storageId = -1;
            try
            {
                ProdCollectBinding bll = new ProdCollectBinding();
                storageId = bll.GetStorageID(serialNumber);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return storageId;
        }

        ///  </summary>
        ///  入库扫描
        /// </summary>
        /// <param name="SerialNumber"></param>
        [AjaxMethod]
        public void PutInStorage(int StorageID, string SerialNumber, string BarCode, int scanType, int resId)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                ProdCollectBinding bll = new ProdCollectBinding();
                bll.PutInStorage(StorageID, SerialNumber, BarCode, userName, scanType, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        ///  </summary>
        ///  通过入库单号获取入库详情
        /// </summary>
        /// <param name="SerialNumber"></param>
        [AjaxMethod]
        public List<SKT.LeanMES.ProductionCollection.Model.StorageMemberInfo> GetStorageMember(int StorageID)
        {
            try
            {
                ProdCollectBinding bll = new ProdCollectBinding();
                return bll.GetStorageMember(StorageID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        /// <summary>
        /// 保存入库信息
        /// </summary>
        /// <param name="StorageID"></param>
        /// <param name="SerialNumber"></param>
        /// <param name="BarCode"></param>
        /// <param name="scanType"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void SaveToStorage(int storageID, int resId, int stationId)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                int userId = AccountController.GetCurrentUser().UserId;
                ProdCollectBinding bll = new ProdCollectBinding();
                bll.SaveToStorage(storageID, userName,userId, resId,stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 删除未完成入库的扫描入库信息
        /// </summary>
        /// <param name="storageMemberID"></param>
        [AjaxMethod]
        public void PutInStorageDelete(int storageMemberID)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                ProdCollectBinding bll = new ProdCollectBinding();
                bll.PutInStorageDelete(storageMemberID, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 成品出库

        /// <summary>
        /// 根据走货单号获取产品信息
        /// </summary>
        /// <param name="soCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<OutStorageInfo> GetAllSoOrderInfo(string soCode)
        {
            ProdCollectBinding bll = new ProdCollectBinding();
            try
            {
                return bll.GetAllSoOrderInfo(soCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        /// <summary>
        /// 成品出库
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="scanType"></param>
        /// <param name="itemId"></param>
        /// <param name="balanceQty"></param>
        /// <param name="soCode"></param>
        /// <param name="userName"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public Int32 ProductOutStorage(string sn, int scanType, int itemId, int balanceQty, string soCode, int stationId, int resId)
        {
            ProdCollectBinding bll = new ProdCollectBinding();
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
               return bll.ProductOutStorage(sn,scanType,itemId,balanceQty,soCode,userName,stationId,resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return 0;
        }
        /// <summary>
        /// 获取出库车辆信息
        /// </summary>
        /// <param name="soCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public OutStorageCarInfo GetOutStorageCarInfo(string soCode)
        {
            ProdCollectBinding bll = new ProdCollectBinding();
            try
            {
                return bll.GetOutStorageCarInfo(soCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        /// <summary>
        /// 编辑出货车辆信息
        /// </summary>
        /// <param name="soCode"></param>
         [AjaxMethod]
        public void OutStorageCarEdit(OutStorageCarInfo entity)
        {
            ProdCollectBinding bll = new ProdCollectBinding();
            try
            {
                bll.OutStorageCarEdit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }         
        }
           
        #endregion

        #region 成品库位转移

         /// <summary>
         /// 获取产品包装库位信息
         /// </summary>
         /// <param name="sn"></param>
         /// <param name="transType"></param>
         /// <returns></returns>
         [AjaxMethod]
         public List<StorageTransferInfo> GetStorageInfo(String sn, Int32 transType)
         {
             List<StorageTransferInfo> list = new List<StorageTransferInfo>();
             ProdCollectBinding bll = new ProdCollectBinding();
             try
             {
                  
                 list = bll.GetStorageInfo(sn, transType);
             }
             catch (Exception ex)
             {
                 WebHelper.HandleException(ex);
             }
             return list;
         }

        /// <summary>
         /// 成品信息库位转移
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="Code"></param>
        /// <param name="userName"></param>
         [AjaxMethod]
         public void ProdStorageTransfer(String sn, String Code, String userName,int transType)
         {
             ProdCollectBinding bll = new ProdCollectBinding();
             try
             { 
                 bll.ProdStorageTransfer(sn, Code, userName, transType);
             }
             catch (Exception ex)
             {
                 WebHelper.HandleException(ex);
             }
         }

        #endregion
    }
}