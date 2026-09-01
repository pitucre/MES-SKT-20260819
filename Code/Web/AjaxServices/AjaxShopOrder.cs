using System;
using System.Collections.Generic;
using System.Web;
using AjaxPro;
using System.Data;
using SKT.LeanMES.Web;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Order.Model;
using SKT.LeanMES.Order.BLL;
using SKT.Common.Model;
using SKT.LeanMES.Print.BLL;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;
using Newtonsoft.Json;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// Summary description for AjaxServiceShopOrder
    /// </summary>
    public class AjaxShopOrder
    {
        [AjaxMethod]
        public Int32 EditShopOrder(ShopOrderInfo entity, string pst, string pcd, string ssd, string sct)
        {
            try
            {
                return (new ShopOrder()).Edit(entity, pst, pcd, ssd, sct);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return -1;
            }
        }

        [AjaxMethod]
        public void RouterBind(int id, int routerId, string userName)
        {
            try
            {
                (new ShopOrder()).RouterBind(id, routerId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        [AjaxMethod]
        public String GetMsg(string resKey)
        {
            string lang = HttpContext.Current.Request.Cookies["lang"].Value;
            System.Globalization.CultureInfo cultereInfo = new System.Globalization.CultureInfo(lang);
            return HttpContext.GetGlobalResourceObject("Messages", resKey, cultereInfo).ToString();
        }

        /// <summary>
        /// 释放工单数量并返回生成的产品序列号
        /// </summary>
        /// <param name="Qty">本次释放的数量</param>
        /// <param name="WOID">工单ID</param>
        /// <param name="ItemID">产品ID</param>
        /// <returns>返回产品序列号List</returns>
        [AjaxMethod(TimeType.Minute, 30, "Func")]
        public SNInfo ReleaseSO(Int32 Qty, Int32 WOID, Int32 ItemID)
        {
            #region 注释
            /*
            string result = "";
            try
            {
                DateTime date = DateTime.Now;
                SKT.MES.LIBRARY.NEXTSN.GenerateSFC genSFC = new SKT.MES.LIBRARY.NEXTSN.GenerateSFC();
                 
                Int32 nextID = genSFC.GetNextID(strItem, strVer, "Item");

                 
                int SN = genSFC.GenerateShopOrderSN(nextID, Qty, -1, -10, -1, -1, -1, WOID, ItemID, AccountController.GetCurrentUser().UserId) ? 1 : 0;
                if (SN == 1)
                {
                    result= date.ToString();
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return result;
            */
            #endregion

            SNInfo sninfo = new SNInfo();
            try
            {
                sninfo = (new ShopOrder()).ReleaseSO(Qty, WOID, ItemID, AccountController.GetCurrentUser().UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return sninfo;
        }



        /// <summary>
        /// 吴锋文修改，增加一个工序明细表数据
        /// </summary>
        /// <param name="Qty"></param>
        /// <param name="BatchQty"></param>
        /// <param name="WOID"></param>
        /// <param name="ItemID"></param>
        /// <param name="LotCode"></param>
        /// <param name="ClassId"></param>
        /// <param name="EquimentCode"></param>
        /// <param name="EquipmentMoudle"></param>
        /// <param name="ProdDate"></param>
        /// <param name="Remark"></param>
        /// <param name="stationdtlJson"></param>
        /// <returns></returns>
        [AjaxMethod]
        public SNInfo ReleaseBatchSOCPIn(Int32 Qty, decimal BatchQty, Int32 WOID, Int32 ItemID, string LotCode, int ClassId, string EquimentCode, string EquipmentMoudle, string ProdDate, string Remark,string stationdtlJson)
        {

            SNInfo sninfo = new SNInfo();
            try
            {
                sninfo = (new ShopOrder()).ReleaseBatchSOCPIn(Qty, BatchQty, WOID, ItemID, LotCode, ClassId, EquimentCode, EquipmentMoudle, ProdDate, Remark, AccountController.GetCurrentUser().UserId, stationdtlJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return sninfo;
        }


        /// <summary>
        /// 释放批次条码并返回生成的产品序列号
        /// </summary>
        /// <param name="Qty">本次释放的数量</param>
        /// <param name="BatchQty">批次数量</param>
        /// <param name="WOID">工单ID</param>
        /// <param name="ItemID">产品ID</param>
        /// <returns>返回产品序列号List</returns>
        [AjaxMethod]
        public SNInfo ReleaseBatchSO(Int32 Qty, decimal BatchQty, Int32 WOID, Int32 ItemID)
        {

            SNInfo sninfo = new SNInfo();
            try
            {
                sninfo = (new ShopOrder()).ReleaseBatchSO(Qty, BatchQty, WOID, ItemID, AccountController.GetCurrentUser().UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return sninfo;
        }

        /// <summary>
        /// 释放批次条码并返回生成的产品序列号
        /// </summary>
        /// <param name="Qty">本次释放的数量</param>
        /// <param name="BatchQty">批次数量</param>
        /// <param name="WOID">工单ID</param>
        /// <param name="ItemID">产品ID</param>
        /// <returns>返回产品序列号List</returns>
        [AjaxMethod]
        public SNInfo ReleaseBatchSOAndPass(Int32 Qty, decimal BatchQty, Int32 WOID, Int32 ItemID,int openId,int resId)
        {

            SNInfo sninfo = new SNInfo();
            try
            {
                sninfo = (new ShopOrder()).ReleaseBatchSOAndPass(Qty, BatchQty, WOID, ItemID, AccountController.GetCurrentUser().UserId,openId,resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return sninfo;
        }

        /// <summary>
        /// 释放拼板SN add by weixia on 2018.3.28
        /// </summary>
        [AjaxMethod]
        public SNInfo ReleasePanelSN(Int32 remainQty, Int32 snCount, Int32 releaseQty, Int32 WOID, Int32 ItemID, Int32 userId)
        {
            SNInfo sninfo = new SNInfo();
            try
            {
                sninfo = (new ShopOrder()).ReleasePanelSN(remainQty, snCount, releaseQty, WOID, ItemID, AccountController.GetCurrentUser().UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return sninfo;
        }

        /// <summary>
        /// 根据已释放的产品数量，选择的工位，生成置换条码。
        /// </summary>
        /// <param name="Qty">本次释放的数量</param>
        /// <param name="WOID">工单ID</param>
        /// <param name="ItemID">产品ID</param>
        /// <param name="StationID">工位ID</param>
        /// <returns>返回产品序列号List</returns>
        [AjaxMethod]
        public IList<string> ReleaseReplaceSN(Int32 Qty, Int32 WOID, Int32 ItemID, Int32 StationId)
        {
            #region 注释
            /*
            string result = "";
            try
            {
                DateTime date = DateTime.Now;
                SKT.MES.LIBRARY.NEXTSN.GenerateSFC genSFC = new SKT.MES.LIBRARY.NEXTSN.GenerateSFC();
                 
                Int32 nextID = genSFC.GetNextID(strItem, strVer, "Item");

                 
                int SN = genSFC.GenerateShopOrderSN(nextID, Qty, -1, -10, -1, -1, -1, WOID, ItemID, AccountController.GetCurrentUser().UserId) ? 1 : 0;
                if (SN == 1)
                {
                    result= date.ToString();
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return result;
            */
            #endregion

            IList<string> list = null;
            try
            {
                list = (new ShopOrder()).ReleaseReplaceSN(Qty, WOID, ItemID, StationId, AccountController.GetCurrentUser().UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 根据工单释放数量 和 输入的包装箱数量  生成指定的包装箱
        /// </summary>
        /// <param name="Qty">本次需要生成的数量</param>
        /// <param name="WOID">工单ID</param>
        /// <param name="ItemID">产品ID</param>
        /// <returns>返回包装箱序列号List</returns>
        [AjaxMethod]
        public IList<string> GenerateBoxNO(Int32 Qty, Int32 WOID, Int32 ItemID)
        {
            #region 注释
            /*
            string result = "";
            try
            {
                DateTime date = DateTime.Now;
                SKT.MES.LIBRARY.NEXTSN.GenerateSFC genSFC = new SKT.MES.LIBRARY.NEXTSN.GenerateSFC();
                 
                Int32 nextID = genSFC.GetNextID(strItem, strVer, "Item");

                 
                int SN = genSFC.GenerateShopOrderSN(nextID, Qty, -1, -10, -1, -1, -1, WOID, ItemID, AccountController.GetCurrentUser().UserId) ? 1 : 0;
                if (SN == 1)
                {
                    result= date.ToString();
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return result;
            */
            #endregion

            IList<string> list = null;
            try
            {
                list = (new ShopOrder()).GenerateBoxNO(Qty, WOID, ItemID, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 根据生成指定的拼板
        /// </summary>
        /// <param name="Qty">本次需要生成的数量</param>
        /// <param name="WOID">工单ID</param>
        /// <param name="ItemID">产品ID</param>
        /// <returns>返回拼板序列号List</returns>
        [AjaxMethod]
        public IList<string> GeneratePanelSN(Int32 Qty, Int32 WOID, Int32 ItemID)
        {
            #region 注释
            /*
            string result = "";
            try
            {
                DateTime date = DateTime.Now;
                SKT.MES.LIBRARY.NEXTSN.GenerateSFC genSFC = new SKT.MES.LIBRARY.NEXTSN.GenerateSFC();
                 
                Int32 nextID = genSFC.GetNextID(strItem, strVer, "Item");

                 
                int SN = genSFC.GenerateShopOrderSN(nextID, Qty, -1, -10, -1, -1, -1, WOID, ItemID, AccountController.GetCurrentUser().UserId) ? 1 : 0;
                if (SN == 1)
                {
                    result= date.ToString();
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return result;
            */
            #endregion

            IList<string> list = null;
            try
            {
                list = (new ShopOrder()).GeneratePanelSN(Qty, WOID, ItemID, AccountController.GetCurrentUser().UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取该工单，剩余可生成的拼板数。
        /// </summary>
        /// <param name="prodOrderId"></param>
        [AjaxMethod]
        public int GetResiduePanelQty(Int32 prodOrderId)
        {
            int qty = 0;

            try
            {
                qty = (new ShopOrder()).GetResiduePanelQty(prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return qty;
        }


        [AjaxMethod]
        public IList<string> GetSNByOrderID(int orderID, string dateStr)
        {
            ShopOrder orderBll = new ShopOrder();
            SearchSettings searchSettings = new Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "uid in( select uid from Prod_Unit b where a.UID = b.UID  and b.ProdOrderID = " + orderID + " and CreateTime > '" + dateStr + "')";
            IList<string> list = orderBll.GetSN(0, int.MaxValue, "", searchSettings);
            return list;
        }


        [AjaxMethod]
        public String GenerateContainerSN()
        {
            SKT.MES.LIBRARY.NEXTSN.GenerateSFC genSFC = new SKT.MES.LIBRARY.NEXTSN.GenerateSFC();
            /*Release SN*/
            return genSFC.GenerateRMASN();
        }

        [AjaxMethod]
        public string GetSNLabelData(string value, int left, int top, int columnsDistance, int barcodeHeigth)
        {
            string strLabel = "";
            try
            {
                string[] str = { value, value };
                //strLabel = (new ZPLPrinter()).PrintBarcode(left, top, columnsDistance, barcodeHeigth, str);
                //strLabel=(new ZPLPrinter()).ZPLPrintGRNLabel(,false,left);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strLabel;
        }

        /// <summary>
        /// 将中文转换成ZPL
        /// add by zhibin.Chen  2015-12-26
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string ConvertChineseZPL(string value)
        {
            string strLabel = "";
            try
            {
                strLabel = (new ZPLPrinter()).TextToHex(value, "-1", 20);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strLabel;
        }

        /// <summary>
        /// add by  zhibin.Chen 2016-1-5
        /// 用于工单条码重打印。 根据所选择的UID字符串，检查这些UID对应的ItemId是否一致。如果一致，那么返回ItemId, ProdOrderId。
        /// </summary>
        /// <param name="UIDstr"></param>
        /// <returns>ItemId, ProdOrderId</returns>
        [AjaxMethod]
        public Int32[] GetItemIdByUIDstr(string UIDstr)
        {
            Int32[] arr = new Int32[3];
            try
            {
                arr = (new ShopOrder()).GetItemIdByUIDstr(UIDstr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, false);
            }
            return arr;
        }


        //[AjaxMethod]
        //public DataTable GetPCBSNByGRN(Int64 grnID)
        //{
        //    SKT.MES.Material.BLL.MaterialUnit bllMat = new MaterialUnit();
        //    /*Release SN*/
        //    return bllMat.ReturnPCBSNByGRN(grnID);
        //}

        //[AjaxMethod]
        //public Int32 getOrderInputQtyByID(Int32 orderID)
        //{
        //    SKT.MES.Production.BLL.ShopOrder bllOrder = new ShopOrder();
        //    return bllOrder.getOrderInputQtyByID(orderID);
        //}

        //[AjaxMethod]
        //public List<OperationInfo> GetOperationByWO(string orderNO)
        //{            
        //    List<OperationInfo> list = null;
        //    try
        //    {
        //        SKT.MES.BasalData.BLL.Operation bllOperation = new SKT.LeanMES.BasalData.BLL.Operation();
        //        list=bllOperation.GetNormalOperationByWO(orderNO);                
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }

        //    return list;
        //}

        //#region RMA Order
        //[AjaxMethod]
        //public Int32 EditRMANumber(Int32 RMAID, Int32 OrderID, string RMANO, string PO, string remark, string returnDate)
        //{
        //    try
        //    {
        //        string Operator = AccountController.GetCurrentUser().LoginID;
        //        return (new vwRMAOrder().Edit(RMAID, OrderID, RMANO, PO, remark, Operator, Convert.ToDateTime(returnDate)));
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //        return -1;
        //    }
        //}

        //[AjaxMethod]
        //public Int32 EditRMADATA(RMADATAInfo objRMAData,String strReturnDate)
        //{
        //    try
        //    {
        //        objRMAData.CreateBy = AccountController.GetCurrentUser().LoginID;
        //        objRMAData.ReturnDate = Convert.ToDateTime(strReturnDate);
        //        return (new vwRMAOrder().EditRMAData(objRMAData));
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //        return -1;
        //    }
        //}

        //[AjaxMethod]
        //public Int32 SaveRMADATA(Int32 rmaID)
        //{
        //    try
        //    {
        //         return (new vwRMAOrder().SaveRMADATA(rmaID, AccountController.GetCurrentUser().UserID));
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //        return -1;
        //    }
        //}

        //[AjaxMethod]
        //public ShopOrderInfo GetRMAWOByID(Int32 orderID)
        //{
        //    SKT.MES.Production.BLL.ShopOrder bllOrder = new ShopOrder();
        //    return (ShopOrderInfo)bllOrder.GetInfo(orderID);
        //}

        //#endregion

        /// <summary>
        /// 工单确认更新
        /// </summary>
        /// <param name="moChangeId"></param>
        [AjaxMethod]
        public void ERP_MO_ConfirmUpdate(int moChangeId, string user)
        {
            try
            {
                (new MO_Change()).ConfirmUpdate(moChangeId, user);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 根据工单，工位 获取此工单，此工位还可释放的置换条码数。
        /// </summary>
        /// <param name="prodorderId"></param>
        /// <param name="stationId"></param>
        /// <returns>已释放的置换条码数，可释放的置换条码数。</returns>
        [AjaxMethod]
        public int[] GetCanReleaseQty(int prodorderId, int stationId)
        {
            int[] qty = new int[2] { 0, 0 };

            try
            {
                qty = (new ShopOrder()).GetCanReleaseQty(prodorderId, stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return qty;
        }


        /// <summary>
        /// 工单BOM显示
        /// </summary> 
        [AjaxMethod]
        public List<OrderBomInfo> GetOrderBOM(int orderID, int bomID, int choosingFlag)
        {
            try
            {
                List<OrderBomInfo> list = (new OrderBom()).GetInfo(orderID, bomID, choosingFlag);
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }

        }

        /// <summary>
        /// 工单BOM EDIT
        /// </summary>
        [AjaxMethod]
        public void EditOrderBOM(string obOrderNo
            //,string obSeqStr 
            , string obItemIDStr
            , string obUnitTypeIDStr, string obTotalNumStr, string obPerNumStr, string obOpeIDStr
            , string obCustIDStr, string obIsReStr, string CreateBy, int PrivacyBOMFlag)
        {

            try
            {
                (new OrderBom()).Edit(obOrderNo, obItemIDStr
            , obUnitTypeIDStr, obTotalNumStr, obPerNumStr, obOpeIDStr, obCustIDStr, obIsReStr, CreateBy
            , PrivacyBOMFlag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }
        /// <summary>
        /// 工单BOM delete
        /// </summary>
        [AjaxMethod]
        public void DeleteOrderBOM(String OrderNo, String AssSeq, String ItemID)
        {

            try
            {
                (new OrderBom()).Delete(OrderNo, AssSeq, ItemID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        /// <summary>
        /// 工单工艺参数显示
        /// </summary> 
        [AjaxMethod]
        public List<OrderParamInfo> GetOrderParam(int OrderID, int StationID, int ItemID)
        {
            try
            {
                //SearchSettings searchSettings = new Common.Model.SearchSettings();
                //searchSettings.ExtensionCondition = " OrderNo = (select OrderNO from Prod_Order where ProdOrderID=" + OrderID + ") ";
                //List<OrderParamInfo> list = (new OrderParam()).GetAll(0, -1, "OrderParamId",searchSettings);

                List<OrderParamInfo> list = (new OrderParam()).GetInfo(OrderID, StationID, ItemID);

                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }

        }

        /// <summary>
        /// 工单工艺参数 EDIT
        /// </summary>
        [AjaxMethod]
        public void EditOrderParams(string obOrderNo, string obSeqStr, string opStationStr, string opParaNameStr
            , string opParaValueStr, string opParaRemarkStr, string CreateBy, string opItemIDStr
            , int PrivacyItemFlag, int PrivacyOpeFlag)
        {
            try
            {
                (new OrderParam()).Edit(obOrderNo, obSeqStr, opStationStr, opParaNameStr, opParaValueStr
                    , opParaRemarkStr, CreateBy, opItemIDStr, PrivacyItemFlag, PrivacyOpeFlag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }
        /// <summary>
        /// 工单工艺参数 delete
        /// </summary>
        [AjaxMethod]
        public void DeleteParam(String OrderNo, int StationID, String ParaName)
        {

            try
            {
                (new OrderParam()).Delete(OrderNo, StationID, ParaName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        /// <summary>
        /// 获取路由可选工序
        /// </summary>
        [AjaxMethod]
        public String getRouterDetail(String Type, String TypeValue)
        {
            String result = "";
            try
            {
                result = (new SKT.LeanMES.PubItems.BLL.PubItems()).GetStationList(Type, TypeValue);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return result;

        }

        /// <summary>
        /// MES8.5 获取产品当前版本工单BOM
        /// </summary>
        [AjaxMethod]
        public String GetCurItemBom(int itemId)
        {
            String strList = "";
            try
            {
                strList = (new OrderBom()).GetCurItemBom(itemId);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strList;

        }

        [AjaxMethod]
        public ShopOrderInfo GetInfo(Int32 shopOrderId)
        {
            ShopOrderInfo entity = null;
            try
            {
                ShopOrder bll = new ShopOrder();
                entity = bll.GetInfo(shopOrderId);
                return entity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public ShopOrderInfo GetOrderInfo(string serialNumber)
        {
            try
            {
                ShopOrder bll = new ShopOrder();
                ShopOrderInfo orderInfo = bll.GetInfoBySerialNumber(serialNumber);
                return orderInfo;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }



        [AjaxMethod]
        public DataTable GetMoldingOrderInfo(string OrderID, string MachineID, string LinePlanCode)
        {
            DataTable dt = null;
            try
            {
                dt = (new ShopOrder()).GetMoldingOrderInfo(OrderID, MachineID, LinePlanCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }

        [AjaxMethod]
        public string GetOrderGoodRate(string LinePlanCode, string MoudlCode)
        {
            DataTable dt = null;
            try
            {
                dt = (new ShopOrder()).GetOrderGoodRate(LinePlanCode, MoudlCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return JsonConvert.SerializeObject(dt);
        }

        /// <summary>
        /// 形态转换校验-ERP回写
        /// </summary>
        [AjaxMethod]
        public string SaveFormChangeCheck(string strJson)
        {
            try
            {
                List<string> list = (new ShopOrder()).SaveFormChangeCheck(strJson);
                return string.Join(",", list);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }
    }
}