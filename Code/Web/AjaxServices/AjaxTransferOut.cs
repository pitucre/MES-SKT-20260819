using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Transfers.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// add by peter.wang 2016-1-18
    /// 用于物料调拨/完工申报单
    /// </summary>
    public class AjaxTransferOut
    {
        /// <summary>
        /// 通过备料单Id找到对应的数据
        /// add by peter.wang 2016-1-18
        /// </summary>
        /// <param name="sourceCode"></param>
        /// <param name="?"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<TransferOutInfo> ShowTransfOutInfo(string SN)
        {
            List<TransferOutInfo> list = new List<TransferOutInfo>();
            try
            {
                list = new TransferOut().ShowTransfOutInfo(SN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        ///add by peter.wang 2016-1-18
        ///保存调拨信息
        /// </summary>
        [AjaxMethod]
        public void SaveTransferOut(string strjosn)
        {
            try
            {
                new TransferOut().SaveTransferOut(strjosn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 生成ERP调拨
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="docNo"></param>
        /// <param name="docLineNoStr"></param>
        /// <param name="itemIdStr"></param>
        /// <param name="outWareId"></param>
        /// <param name="inWareId"></param>
        /// <param name="adjustQtyStr"></param>
        /// <param name="outLocationStr"></param>
        /// <param name="binLineNoStr"></param>
        [AjaxMethod]
        public String  SaveGenerateERP(String userName, String docNo, String docLineNoStr,
            String itemIdStr, Int64 outWareId, Int64 inWareId, String adjustQtyStr, String outLocationStr, String binLineNoStr, String TransferNO)
        {
            String TransferOrder = "";
            try
            {
               TransferOrder = new TransferOut().SaveGenerateERP(userName, docNo, docLineNoStr, itemIdStr, outWareId, inWareId,
                    adjustQtyStr, outLocationStr, binLineNoStr,TransferNO);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return TransferOrder;
        }

        ///add by liyanping 2016/1/21 10:03
        /// <summary>
        ///根据产品ID、调出仓库、调出库位获取库存数量
        /// </summary>
        [AjaxMethod]
        public Decimal GetStoreQty(Int64 txtItemID, Int64 hdnOutWareId, String txtOutLocation)
        {
            Decimal storeQty = 0;
            try
            {
                storeQty = new TransferOut().GetStoreQty(txtItemID, hdnOutWareId, txtOutLocation);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return storeQty;
        }

        //add by liyanping 2016/1/21 15:10
        /// <summary>
        ///根据产品编码获取产品ID和Name
        /// </summary>
        [AjaxMethod]
        public List<TransferOutInfo> GetItemInfo(String txtItemCode)
        {
            List<TransferOutInfo> list = new List<TransferOutInfo>();
            try
            {
                list = new TransferOut().GetItemInfo(txtItemCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 通过派工单找到对应的数据
        /// add by peter.wang 2016-1-20
        /// </summary>
        /// <param name="DispatchNo">派工单号</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<CompleteOrderInfo> ShowCompleteOrderInfo(String DispatchNo)
        {
            List<CompleteOrderInfo> list = new List<CompleteOrderInfo>();
            try
            {
                list = new CompleteOrder().ShowCompleteOrderInfo(DispatchNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 通完工单ID找到对应的数据
        /// add by peter.wang 2016-1-20
        /// </summary>
        /// <param name="ComPleteId">ComPleteId</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<CompleteOrderInfo> ShowCompleteOrderByIdInfo(Int32 ComPleteId)
        {
            List<CompleteOrderInfo> list = new List<CompleteOrderInfo>();
            try
            {
                list = new CompleteOrder().ShowCompleteOrderByIdInfo(ComPleteId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        ///add by peter.wang 2016-1-21
        ///保存完工申请单信息
        /// </summary>
        [AjaxMethod]
        public void SaveCompleteOrder(Int32 CompleteId, String completeNo, String dispatch, String factStartDates, String factEndDates, String planStartDates,
                   String planEndDates, String dispatchDates, String lineStr, String operationStr, String goalOperationStr, String operatinDescStr, 
            String dispatchQtyStr, String completeQtyStr, String workHouseStr, String userName)
        {
            DateTime factStartDate = System.DateTime.Parse(WebHelper.FormatToDate(factStartDates));
            DateTime factEndDate = System.DateTime.Parse(WebHelper.FormatToDate(factEndDates));
            DateTime planStartDate = System.DateTime.Parse(WebHelper.FormatToDate(planStartDates));
            DateTime planEndDate = System.DateTime.Parse(WebHelper.FormatToDate(planEndDates));
            DateTime dispatchDate = System.DateTime.Parse(WebHelper.FormatToDate(dispatchDates));
            try
            {
                new CompleteOrder().SaveCompleteOrder(CompleteId,completeNo, dispatch, factStartDate, factEndDate, planStartDate, planEndDate,
                    dispatchDate, lineStr, operationStr, goalOperationStr, operatinDescStr, dispatchQtyStr, completeQtyStr,
                    workHouseStr, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 生成派工申报单
        /// </summary>
        /// <param name="flag"></param>
        /// <param name="dispatch"></param>
        /// <param name="completeQtyStr"></param>
        /// <param name="userName"></param>
        /// <param name="workHouseStr"></param>
        /// <param name="ComPleteId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public String GenerateDispatch(Int32 flag, String dispatch, String completeQtyStr, String userName, String workHouseStr, Int32 ComPleteId)
        {
            string DispatchOrder = "";
            try
            {
                DispatchOrder = new CompleteOrder().GenerateDispatch(flag, dispatch, completeQtyStr, userName, workHouseStr, ComPleteId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return DispatchOrder;
        }

        /// <summary>
        /// 生成完工报告
        /// </summary>
        /// <param name="flag"></param>
        /// <param name="dispatch"></param>
        /// <param name="completeQtyStr"></param>
        /// <param name="userName"></param>'
        [AjaxMethod]
        public String GenerateCompleteReport(Int32 flag, String dispatch, String completeQtyStr, String userName, String workHouseStr, Int32 ComPleteId)
        {
            string BackOrder = "";
            try
            {
                BackOrder = new CompleteOrder().GenerateCompleteReport(flag, dispatch, completeQtyStr, userName, workHouseStr, ComPleteId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return BackOrder;
        }

        /// <summary>
        /// 入库倒冲
        /// </summary>
        /// <param name="dispatch"></param>
        /// <param name="completeOrder"></param>
        [AjaxMethod]
        public String BackStorage(String dispatch, String completeOrder, Int32 ComPleteId)
        {
            String IssueDoc = "";
            try
            {
                IssueDoc = new CompleteOrder().BackStorage(dispatch, completeOrder, ComPleteId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return IssueDoc;
        }

        //add by liyanping 2016/1/27 17:44
        /// <summary>
        ///验证输入的货位编码是否准确并带出仓库ID和Name等信息
        /// </summary>
        [AjaxMethod]
        public List<TransferOutInfo> GetWarehouseInfo(String warehouseCode)
        {
            List<TransferOutInfo> list = new List<TransferOutInfo>();
            try
            {
                list = new TransferOut().GetWarehouseInfo(warehouseCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 获取调拨出库的调拨单(PDA)
        /// </summary>
        /// <param name="value"></param>
        /// <param name="type">type 0：扫描 1：弹出面板筛选单据</param>
        /// <returns></returns>
        [AjaxMethod]
        public IList<TransfersInfo> GetTransfesOrderList(string value, int type)
        {
            IList<TransfersInfo> list = null;
            try
            {
                list = new SKT.LeanMES.Transfers.BLL.Transfers().GetTransfesOrderList(value, type);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取调拨入库的调拨单(PDA)
        /// </summary>
        /// <param name="type">type 0：扫描 1：弹出面板筛选单据</param>
        /// <returns></returns>
        [AjaxMethod]
        public IList<TransfersInfo> GetTransfesOrderInList(string value, int type)
        {
            IList<TransfersInfo> list = null;
            try
            {
                list = new SKT.LeanMES.Transfers.BLL.Transfers().GetTransfesOrderInList(value, type);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 检查并获取GRN信息(PDA有单调拨)
        /// </summary>
        [AjaxMethod]
        public string CheckGrnTransfer(int transfersId, int transfersDtlId, string grn,string GrnStrNew)
        {
            var strInfo = "";
            try
            {
                strInfo = new LeanMES.Transfers.BLL.Transfers().CheckGrnTransfer(transfersId, transfersDtlId, grn, GrnStrNew);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strInfo;
        }
        /// <summary>
        /// 检查并获取GRN信息(PDA有单成品调拨)
        /// </summary>
        [AjaxMethod]
        public string CheckSNTransfer(int transfersId, string grn)
        {
            var strInfo = "";
            try
            {
                strInfo = new LeanMES.Transfers.BLL.Transfers().CheckSNTransfer(transfersId, grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strInfo;
        }

        /// <summary>
        /// 确认调拨(PDA)
        /// </summary>
        [AjaxMethod]
        public void SaveTransfer(int transfersId, string grns, string inWhouseName, string outWhouseName, string inBarCode, string transfersNo)
        {

            try
            {
                (new LeanMES.Transfers.BLL.Transfers()).SaveTransfer(transfersId, grns, AccountController.GetCurrentUser().UserName, inWhouseName, outWhouseName, inBarCode, transfersNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }


        /// <summary>
        /// 确认成品调拨(PDA)
        /// </summary>
        [AjaxMethod]
        public void SaveTransferSN(int transfersId, string grns, string Deletegrns, string inWhouseName, string outWhouseName, string inBarCode, string transfersNo)
        {

            try
            {
                (new LeanMES.Transfers.BLL.Transfers()).SaveTransferSN(transfersId, grns, Deletegrns, AccountController.GetCurrentUser().UserName, inWhouseName, outWhouseName, inBarCode, transfersNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }


        /// <summary>
        /// 获取仓库档案信息(PDA无单调拨出库)
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public IList<TransfersInfo> GetWareHouseList()
        {
            IList<TransfersInfo> list = null;
            try
            {
                list = new SKT.LeanMES.Transfers.BLL.Transfers().GetWareHouseList();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public bool CheckUserIsWarrantted(int userId)
        {
            return Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 11441002);
        }

        [AjaxMethod]
        public bool CheckUserIsWarranttedPda(int userId)
        {
            return Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 12100341);
        }
    }
}
