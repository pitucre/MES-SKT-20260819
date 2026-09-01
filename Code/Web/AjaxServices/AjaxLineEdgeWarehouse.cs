using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using AjaxPro;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Order.Model;
using SKT.LeanMES.Order.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxLineEdgeWarehouse
    {
        //add by liyanping 2015/8/24 17:06:43
        /// <summary>
        /// 根据线边仓ID或GRN获取物料列表
        /// </summary>
        /// <param name="lineEdgeID"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        /*
        [AjaxMethod]
        public List<MaterialUnitInfo> ShowLineEdgeWarehouseDetail(Int32 lineEdgeID, String grn) 
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            try
            {
                list = (new MaterialUnit()).ShowLineEdgeWarehouseDetail(lineEdgeID, grn, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex) 
            {
                WebHelper.HandleException(ex);
            }

            return list;
        }

        //add by liyanping 2015/8/25 14:45:57
        /// <summary>
        /// 根据物料条码或包装箱条码做收料
        /// </summary>
        /// <param name="lineEdgeID"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void SaveLineEdgeReceiveGRN(Int32 lineEdgeID,String lineEdgeGRN, String grn) 
        {
            try
            {
                (new MaterialUnit()).SaveLineEdgeReceiveGRN(lineEdgeID, lineEdgeGRN, grn, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex) 
            {
                WebHelper.HandleException(ex);
            }
        }

        //add by liyanping 2015/9/2 13:47:24
        /// <summary>
        /// 根据工单号获取物料清单名等基本信息
        /// </summary>
        /// <param name="formNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ShopOrderInfo GetItemInfoByFormNo(String formNo, Int32 flage)
        {
            ShopOrderInfo model = new ShopOrderInfo();
            try
            {
                model = (new SKT.LeanMES.Order.BLL.ShopOrder()).GetItemInfoByFormNo(formNo,flage);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;
        }

        //add by liyanping 2015/9/2 15:14:36
        /// <summary>
        /// 根据GRN，工单号验证物料条码是否有效
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="formNo"></param>
        [AjaxMethod]
        public void CheckMaterialLoadinglist(String grn, String formNo)
        {
            try
            {
                (new SKT.LeanMES.Order.BLL.ShopOrder()).uspCheckMaterialLoadinglist(grn, formNo, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        //add by liyanping 2015/9/6 10:44:35
        /// <summary>
        /// 根据工单号带出物料清单列表信息
        /// </summary>
        /// <param name="formNo"></param>
        /// <param name="flage"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ShopOrderInfo> GetItemListByFormNo(String formNo, Int32 flage)
        {
            List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            try
            {
                list = (new SKT.LeanMES.Order.BLL.ShopOrder()).GetItemListByFormNo(formNo, flage);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        // add by liyanping 2015/9/6 14:53:24
        /// <summary>
        /// 根据续料ID、GRN进行换料
        /// </summary>
        /// <param name="loadingList"></param>
        /// <param name="grn"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void SaveContinuedMaterial(Int32 loadingList, String grn, String userName)
        {
            try
            {
                (new SKT.LeanMES.Order.BLL.ShopOrder()).SaveContinuedMaterial(loadingList, grn, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
         * 
         * */
    }
}