using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Plan.BLL;
using SKT.Common.Model;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.SMT.BLL;
using System.Data;
using SKT.LeanMES.Plan.Model;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxStockList
    {
        [AjaxMethod]
        /// <summary>
        /// 新增电子备料清单替代料
        /// </summary>
        /// <param name="stockListId"></param>
        /// <param name="replaceItemCode"></param>
        /// <param name="userId"></param>
        public void AddStockListReplaceMaterial(int stockListId, string replaceItemCode, string location)
        {
            StockList stockListBll = new StockList();
            int userId = AccountController.GetCurrentUser().UserId;

            try
            {
                stockListBll.AddStockListReplaceMaterial(stockListId, replaceItemCode, userId, location);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 新增电子备料清单主料和料站信息
        /// </summary>
        /// <param name="linePlanOrder"></param>
        /// <param name="mainItemCode"></param>
        /// <param name="position"></param>
        /// <param name="num"></param>
        /// <param name="equipmentId"></param>
        /// <param name="userId"></param>
        /// <param name="feederType"></param>
        [AjaxMethod]
        public void AddStockListPosition(string linePlanOrder, string mainItemCode, string position, decimal num, int equipmentId,string feederType,string area,int stockListId=0)
        {
            StockList stockListBll = new StockList();
            int userId = AccountController.GetCurrentUser().UserId;

            try
            {
                stockListBll.AddStockListPosition(linePlanOrder, mainItemCode, position, num, equipmentId, userId, feederType,area, stockListId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 排产工单换线
        /// </summary>
        /// <param name="linePlanOrder"></param>
        /// <param name="lineId"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void StockListChangeLine(string linePlanOrder, int lineId)
        {
            StockList stockListBll = new StockList();
            string userName = AccountController.GetCurrentUser().UserName;

            try
            {
                stockListBll.StockListChangeLine(linePlanOrder,lineId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// JIT发料
        /// </summary>
        /// <param name="linePlanOrder"></param>
        /// <param name="applyId"></param>
        /// <param name="grn"></param>
        /// <param name="equipmentId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public string CollectStockListMaterial(string linePlanOrder, int applyId, string grn, int equipmentId)
        {
            StockList stockListBll = new StockList();
            int userId = AccountController.GetCurrentUser().UserId;
            string userName = AccountController.GetCurrentUser().UserName;
            string itemcode = "";
            try
            {
                itemcode = stockListBll.CollectStockListMaterial(linePlanOrder, applyId, grn, equipmentId, userId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return itemcode;
        }

        /// <summary>
        /// 获取排产单信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<LoadingListSetOrderInfo> GetLinePlanList(string linePlanOrder)
        {
            SearchSettings searchSettings = new SearchSettings();
            List<LoadingListSetOrderInfo> list = new List<LoadingListSetOrderInfo>();
            if (linePlanOrder != "")
            {
                searchSettings.ExtensionCondition = " PlanOrderNo like '%"+linePlanOrder.Replace("'","''")+"%'";
            }
            try
            {
                if (linePlanOrder == "")
                {
                    list = new LoadingListSet().GetPlanOrderList(0, -1, "", searchSettings);
                }
                else
                {
                    list = new LoadingListSet().GetPlanOrderList(0, 20, "", searchSettings);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取排产工单所排线别上的设备信息
        /// </summary>
        /// <param name="linePlanNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetEquipmentList(string linePlanNo)
        {
            StockList stockListBll = new StockList();
            DataTable dt = new DataTable();
            try
            {
                dt = stockListBll.GetEquipmentList(linePlanNo);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return dt;
        }

        /// <summary>
        /// 获取排产工单所排线别上的设备信息
        /// </summary>
        /// <param name="linePlanNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetPDAEquipmentList(string linePlanNo)
        {
            StockList stockListBll = new StockList();
            DataTable dt = new DataTable();
            try
            {
                dt = stockListBll.GetPDAEquipmentList(linePlanNo);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return dt;
        }

        /// <summary>
        /// 获取领料单信息
        /// </summary>
        /// <param name="linePlanId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetApplyNo(string linePlanNo)
        {
            StockList stockListBll = new StockList();
            DataTable dt = new DataTable();
            try
            {
                dt = stockListBll.GetApplyNo(linePlanNo);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return dt;
        }

        /// <summary>
        /// 获取JIT电子备料单信息
        /// </summary>
        /// <param name="linePlanId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<StockListInfo> GetJITStockList(string linePlanNo,int equipmentId)
        {
            StockList stockListBll = new StockList();
            List<StockListInfo> list = new List<StockListInfo>();
            try
            {
                list = stockListBll.GetJITStockList(linePlanNo,equipmentId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// PDA扫描GRN接收物料
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void StockListMaterialReceive(string grn, string prepareMaterialNo, string getType)
        {
            StockList stockListBll = new StockList();
            int userId = AccountController.GetCurrentUser().UserId;
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                stockListBll.StockListMaterialReceive(grn, userId, userName, prepareMaterialNo, getType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }           
        }


        [AjaxMethod]
        public void DeleteStockListPosition(int stockListId, string orderNo)
        {
            StockList bll = new StockList();
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                bll.DeleteStockListPosition(stockListId, orderNo, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// PDA扫描GRN接收物料
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void StockListMaterialReceives(string grn, string PrepareMaterialNo, string GetType)
        {
            StockList stockListBll = new StockList();
            int userId = AccountController.GetCurrentUser().UserId;
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                stockListBll.StockListMaterialReceive(grn, userId, userName, PrepareMaterialNo, GetType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #region 获取备料单下GRN数量
        /// <summary>
        /// 获取备料单下GRN数量
        /// </summary>
        /// <param name="prepareMaterialNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetMaterialGrnNumber(string prepareMaterialNo, int statue)
        {
            int retvalue = 0;
            try
            {
                retvalue = new SKT.LeanMES.Material.BLL.Apply().GetMaterialGrnNumber(prepareMaterialNo, statue);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return retvalue;
        }
        #endregion

        /// <summary>
        /// PDA先边仓接收 根据GRN获取领料单号
        /// </summary>
        /// <param name="GRN"></param>
        /// <param name="Statue"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetPrepareMaterialNo(string GRN)
        {
            string PrepareMaterialNo = "";

            try
            {
                //  string cmdTxt = string.Format(" select PrepareMaterialNo from Prod_PrepareMaterialGrn where SerialNumber = '{0}'", GRN);
                string cmdTxt = string.Format(" select applyNo from vwProMaterialMember where SerialNumber = '{0}'", GRN);
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                if (dt != null && dt.Rows.Count > 0)
                {
                    PrepareMaterialNo = dt.Rows[0][0].ToString();
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return PrepareMaterialNo;
        }

        /// <summary>
        /// PDA线边仓接收查询
        /// </summary>
        /// <param name=""></param>
        /// <param name=""></param>
        /// <param name=""></param>
        /// <param name=""></param>
        /// <param name=""></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ApplyInfo> GetPrepareMaterialGrnDel(string MOCode, string ApplyNo, string SN, int Statue)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            try
            {
                list = new SKT.LeanMES.Material.BLL.Apply().PrepareMaterialGrnDel(MOCode, ApplyNo, SN, Statue);
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
    }
}