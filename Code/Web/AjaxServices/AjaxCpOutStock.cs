using AjaxPro;
using SDYC.Data;
using SKT.Common.Model;
using SKT.LeanMES.ProductionCollection.Client;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using SKT.LeanMES.Web.Models;
using System;
using System.Collections.Generic;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxCpOutStock
    {
        private WarehouseCpOutStock w = new WarehouseCpOutStock();

        /// <summary>
        /// 获取销售订单
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<WarehouseCpOutStockInfo> GetSalOrderList(int code)
        {
            SearchSettings searchSettings = new SearchSettings();
            var str = "";
            if (code != -1)
            {
                str += " SalOrderID = " + code;
            }
            searchSettings.ExtensionCondition = str;
            return w.Searchmes(0, 10000, "", searchSettings);//查询mes
        }
        /// <summary>
        /// PDA获取销售订单
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<WarehouseCpOutStockInfo> PDAGetSalOrderList(string code)
        {
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = "  DNCode like '%" + code + "%'";
            return w.Searchmes(0, 20, "", searchSettings);//查询mes
        }
        /// <summary>
        /// 获取备货单详情
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<WarehouseCpOutStockDtlInfo> GetSalOrderDtlList(int code)
        {
            try
            {
                return w.GetSalOrderDtlList(code);
            }
            catch (Exception)
            {
                throw;
            }
        }
        /// <summary>
        /// 获取备货单详情扫描记录
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<WarehouseCpOutStockDtlMemberInfo> GetSalOrderDtlMemberList(int code)
        {
            try
            {
                return w.GetSalOrderDtlMemberList(code);
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// 获取出货列表可用的GRN
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<WarehouseGrnMember> GetProductGRNMemberList(string ItemCode, string Whcode)
        {
            try
            {
                return w.GetProductGRNMemberList(ItemCode, Whcode);
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// 获取销售出货单详情扫描记录
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<WarehouseCpOutStockDtlMemberInfoOutput> GetSalOrderMemberListDetails(int code)
        {
            try
            {
                return w.GetSalOrderMemberListDetails(code);
            }
            catch (Exception)
            {
                throw;
            }
        }
        /// <summary>
        /// 保存DN到mes
        /// </summary>
        /// <param name="dnCode"></param>
        [AjaxMethod]
        public void SaveDN(string dnCode, string username)
        {
            try
            {
                w.SaveDN(dnCode, username);
            }
            catch (Exception)
            {
                throw;
            }
        }
        /// <summary>
        /// 扫描保存
        /// </summary>
        /// <param name="dnCode"></param>
        [AjaxMethod]
        public void ScanSave(string dncode,string sn, int type, string username)
        {
            try
            {
                w.ScanSave(dncode, sn, type, username);
            }
            catch (Exception)
            {
                throw;
            }
        }
        /// <summary>
        /// 删除扫描记录
        /// </summary>
        /// <param name="id"></param>
        [AjaxMethod]
        public void DeleteScanInfo(int id)
        {
            try
            {
                w.DeleteScan(id);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 备货完成
        /// </summary>
        /// <param name="id"></param>
        [AjaxMethod]
        public void Stocking(int id,string username)
        {
            try
            {
                w.Stocking(id, username);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 出货确认
        /// </summary>
        /// <param name="id"></param>
        [AjaxMethod]
        public void OutStockConfirmation(int id,string userName)
        {
            try
            {
                w.OutStockConfirmation(id, userName);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 删除备货单
        /// </summary>
        /// <param name="id"></param>
        [AjaxMethod]
        public void Delete(int id)
        {
            try
            {
                w.Delete(id);
            }
            catch (Exception)
            {

                throw;
            }
        }

        [AjaxMethod]
        public List<AttachFileInfo> GetAttachFileInfo(int salOrderID)
        {
            List<AttachFileInfo> list = new List<AttachFileInfo>();

            try
            {
                list = w.GetAttachFileInfo(salOrderID);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public void DeleteAttachFileInfo(int fileID)
        {
            try
            {
                w.DeleteAttachFileInfo(fileID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        #region 保存备料单
        /// <summary>
        /// 保存备料单
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void StockOrderEdit(StockOrderInfo entity)
        {
            try
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                w.StockOrderEdit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 保存备料单明细信息
        /// <summary>
        /// 保存备料单明细信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void StockOrderDtlEdit(WarehouseCpOutStockDtlInfo entity)
        {
            try
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                w.StockOrderDtlEdit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion



        #region 获取形态转换单信息

        /// <summary>
        /// 获取形态转换单信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<ModelFormChangeInfo> GetFormChangeInfo(string FormChangeNo)
        {
            List<ModelFormChangeInfo> list = new List<ModelFormChangeInfo>();

            try
            {
                FormChangeNo = FormChangeNo.Replace("'", "''");
                string sql = string.Format(@"FormChangeNo like '%{0}%'", FormChangeNo);

                using (MAction action = new MAction("Prod_FormChange"))
                {
                    list = action.Select(sql).ToList<ModelFormChangeInfo>();
                }
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return list;
        }

        #endregion


        #region 获取形态转换单明细信息

        /// <summary>
        /// 获取形态转换单明细信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<ModelFormChangeDtlInfo> GetFormChangeDtlInfo(string FormChangeNo)
        {
            List<ModelFormChangeDtlInfo> list = new List<ModelFormChangeDtlInfo>();

            try
            {
                FormChangeNo = FormChangeNo.Replace("'", "''");
                string where = string.Format(@"   FormChangeId =(  SELECT  FormChangeId  FROM Prod_FormChange WHERE FormChangeNo='{0}')", FormChangeNo);

                using (MAction action = new MAction("Prod_FormChangeDtl"))
                {
                    list = action.Select(where).ToList<ModelFormChangeDtlInfo>();
                }
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return list;
        }

        #endregion


        #region 初始化形态转换单明细表已扫描数量

        /// <summary>
        /// 初始化形态转换单明细表已扫描数量
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public void InitFormChangeCurrentQty(string FormChangeNo)
        {
            try
            {
                FormChangeNo = FormChangeNo.Replace("'", "''");
                string sql = string.Format(@"update Prod_FormChangeDtl set CurrentQty=0 where   FormChangeId =(  SELECT  FormChangeId  FROM Prod_FormChange WHERE FormChangeNo='{0}')", FormChangeNo);

                MProc proc = new MProc(sql);
                proc.ExeNonQuery();


            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }

        }

        #endregion

        #region 扫描库位条码

        /// <summary>
        /// 扫描库位条码
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string ScanCBarCode(string cBarCode)
        {
            try
            {
                cBarCode = cBarCode.Replace("'", "''");
                string sql = string.Format(@"cBarCode='{0}'", cBarCode);
                using (MAction action = new MAction("Basal_WarehouseLocation"))
                {
                    if (action.Exists(sql))
                    {
                        return "";
                    }
                    else
                    {
                        return "库位不存在";
                    }

                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "库位不存在";
            }
        }

        #endregion

    }
}