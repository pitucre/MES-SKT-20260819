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
    * 类名：AjaxPickListClient      
    * 功能描述：此类主要应用于手插上料采集的Ajax方法
    * 创建人：zhiman.yuan
    * 创建时间：2017-8-24
    * 修改人：
    * 修改时间：
    ******************************************************************************************/
    public class AjaxPickListClient
    {
        #region 手插上料

        /// <summary>
        /// 获取手插上料扣料工序信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Dictionary<int, string> GetPickListStation(int prodOrderId)
        {
            Dictionary<int, string> list = new Dictionary<int, string>();
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            try
            {
                list = pickListBll.GetPickListStation(prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取手插上料状态信息
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public PickListInfo GetPickListResource(int prodOrderId, int stationId, int resouceId)
        {
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            PickListInfo entity = new PickListInfo();
            try
            {
                entity = pickListBll.GetPickListResource(prodOrderId, stationId, resouceId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 获取手插上料详情
        /// </summary>
        /// <param name="pickListId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PickListDetailInfo> GetPickListDetail(int pickListId, int prodOrderId, int stationId, int resourceId, int flage = 1)
        {
            List<PickListDetailInfo> list = new List<PickListDetailInfo>();
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            try
            {
                list = pickListBll.GetPickListDetail(pickListId, prodOrderId, stationId, resourceId, flage);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取手插上料详情
        /// </summary>
        /// <param name="pickListId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PickListDetailInfo> GetPickListDetailNew(int pickListId, int prodOrderId, int stationId, int resourceId, int flage = 1)
        {
            List<PickListDetailInfo> list = new List<PickListDetailInfo>();
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            try
            {
                list = pickListBll.GetPickListDetailNew(pickListId, prodOrderId, stationId, resourceId, flage);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取手插上料详情
        /// </summary>
        /// <param name="pickListId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PickListDetailInfo> GetPickListDetailPDA(int pickListId, int prodOrderId, int lineId, int flage)
        {
            List<PickListDetailInfo> list = new List<PickListDetailInfo>();
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            try
            {
                list = pickListBll.GetPickListDetailPDA(pickListId, prodOrderId, lineId, flage);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 采集手插上料信息
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="compentLocations"></param>
        /// <param name="grn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void CollectPickListGRN(int pickListId, string grn, int prodOrderId, int stationId, int resouceId)
        {
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                pickListBll.CollectPickListGRN(pickListId, grn, prodOrderId, stationId, resouceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 手插上料开拉停拉操作
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="resouceId"></param>
        /// <param name="flage"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void PickListPullAndStop(int pickListId, int prodOrderId, int stationId, int resouceId, int flage, int lineId = 0)
        {
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                pickListBll.PickListPullAndStop(pickListId, prodOrderId, stationId, resouceId, flage, userId, lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 该存储过程用于PickList的卸料
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void PickListUnLoadMaterial(int pickListId, int prodOrderId, int resouceId, int lineId = 0)
        {
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                pickListBll.PickListUnLoadMaterial(pickListId, prodOrderId, resouceId, userId, lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 手插续料
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="OldGRN"></param>
        /// <param name="newGRN"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void PickListAddMaterial(int pickListId, int prodOrderId, string oldGRN, string newGRN, int resouceId, int lineId)
        {
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                pickListBll.PickListAddMaterial(pickListId, prodOrderId, oldGRN, newGRN, resouceId, userId, lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 修改手插上料不良数
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="grn"></param>
        /// <param name="ncQty"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void PickListNCMaterial(int pickListId, int prodOrderId, string grn, int ncQty, int stationId, int resouceId)
        {
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                pickListBll.PickListNCMaterial(pickListId, prodOrderId, grn, ncQty, stationId, resouceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 移除未开拉的GRN信息
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="grn"></param>
        /// <param name="resouceId"></param>
        [AjaxMethod]
        public void PickListRemoveMaterial(int pickListId, int prodOrderId, string grn, int stationId, int resouceId)
        {
            ProdCollectionPickList pickListBll = new ProdCollectionPickList();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                pickListBll.PickListRemoveMaterial(pickListId, prodOrderId, grn, stationId, resouceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 查询可进行手插上料的工单
        /// </summary>
        [AjaxMethod]
        public List<SKT.LeanMES.SMT.Model.HandLoadingMaterialInfo> GetOrderList(string OrderNO)
        {
            try
            {
                string where = "";
                if (OrderNO != "")
                {
                    where = " and OrderNO like '%" + OrderNO + "%'";
                }
                return new SKT.LeanMES.SMT.BLL.HandLoadingMaterial().GetTOPOrderList(where);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<SKT.LeanMES.SMT.Model.HandLoadingMaterialInfo> GetLineList()
        {
            try
            {
                return new SKT.LeanMES.SMT.BLL.HandLoadingMaterial().GetLineList();
            }
            catch (Exception)
            {

                throw;
            }
        }
        #endregion
    }
}