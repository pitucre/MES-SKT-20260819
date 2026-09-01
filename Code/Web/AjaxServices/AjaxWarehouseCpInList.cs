using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using System;
using System.Collections.Generic;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxWarehouseCpInList
    {
        //public List<WarehouseCpInListInfo> SearchDtl()
        //{
        //    WarehouseCpInList w = new WarehouseCpInList();
        //    return w.SearchDtl();
        //}

        /// <summary>
        /// pc端确认入库
        /// </summary>
        /// <param name="SNList"></param>
        [AjaxMethod]
        public void InStock(string SNList, string BarCode, string Uname)
        {
            try
            {
                WarehouseCpInList s = new WarehouseCpInList();
                s.InStock(SNList, BarCode, Uname);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 扫描入库
        /// </summary>
        /// <param name="InStockNo"></param>
        /// <param name="SN"></param>
        /// <param name="WorkOrderNo"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void ScanSave(string InStockNo, string SN, string WorkOrderNo, int Qty, string userName)
        {
            try
            {
                WarehouseCpInList s = new WarehouseCpInList();
                s.ScanSave(InStockNo, SN, WorkOrderNo, Qty, userName);
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// 入库
        /// </summary>
        /// <param name="InStockNo">入库单号</param>
        /// <param name="StationId">入库库位</param>
        [AjaxMethod]
        public void Save(string InStockNo, string StationId, string UserName)
        {
            try
            {
                WarehouseCpInList s = new WarehouseCpInList();
                s.Save(InStockNo, StationId, UserName);
            }
            catch (Exception)
            {
                throw;
            }
        }

        /*获取成品入库配置信息
        1	是否启用FQC          0:是 1：否
        2	是否启用PDA备货扫描  0:是 1：否
        3	选择PDA扫描单据类型  1:无单  2：工单 3：FQC单
        4   是否启用OQC          0:是 1：否
        */

        [AjaxMethod]
        public string GetConfigType(string Id)
        {
            string result = "";
            try
            {
                SKT.LeanMES.Warehouse.BLL.WarehouseCpInConfig s = new WarehouseCpInConfig();
                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                searchSettings.ExtensionCondition = "ConfigId = " + Id.ToString();
                List<WarehouseCpInConfigInfo> list = s.GetAll(0, 15, "", searchSettings);
                if (list != null && list.Count > 0)
                {
                    if (list[0].ConfigId == 6)
                    {
                        result = list[0].ConfigDesc.ToString();
                    }
                    else
                    {
                        result = list[0].ConfigType.ToString();
                    }
                }

                return result;
            }
            catch (Exception ex)
            {
                return "0";
            }
        }

        /// <summary>
        /// 获取产品信息
        /// </summary>
        /// <param name="id"></param>
        /// <param name="typeId">类型</param>
        [AjaxMethod]
        public WarehouseCpInListInfo GetTable(string id)
        {
            WarehouseCpInListInfo model = new WarehouseCpInListInfo();
            try
            {
                WarehouseCpInList w = new WarehouseCpInList(); ;
                model = w.SearchOrderCount(id);
                return model;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// 生成一个入库单
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="WorkOrderNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetInStockNo()
        {
            WarehouseCpInListInfo model = new WarehouseCpInListInfo();
            SearchSettings searchSettings = new SearchSettings();
            try
            {
                WarehouseCpInList w = new WarehouseCpInList(); ;
                return w.GetInStockNo();
            }
            catch (Exception)
            {
                throw;
            }
        }

        [AjaxMethod]
        public List<WarehouseCpInListInfo> Checked(string Number, string InStockNo, int ScanType)
        {
            List<WarehouseCpInListInfo> model = new List<WarehouseCpInListInfo>();
            try
            {
                //判断属于SN或者栈板 卡通箱
                WarehouseCpInList w = new WarehouseCpInList();
                var UserName = AccountController.GetCurrentUserInfo().UserName;
                model = w.Check(Number, InStockNo, ScanType, UserName);
            }
            catch (Exception ex)
            {
                throw;
            }

            return model;
        }

        [AjaxMethod]
        public IList<WarehouseCpInListInfo> GetSNInfo(string InStockNo)
        {
            try
            {
                IList<WarehouseCpInListInfo> list = new WarehouseCpInList().GetSNInfo(InStockNo);
                return list;
            }
            catch (Exception)
            {
                throw;
            }
        }

        [AjaxMethod]
        public IList<WarehouseCpInListInfo> GetInStockNoList()
        {
            try
            {
                IList<WarehouseCpInListInfo> list = new WarehouseCpInList().GetInStockNoList();
                return list;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// 根据入库单号获取已经入库的SN信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public IList<WarehouseCpInListInfo> GetInStockSNList(WarehouseCpInListInfo entity)
        {
            try
            {
                var bll = new WarehouseCpInList();
                return bll.GetInStockSNList(entity); ;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 根据入库单号获取已扫描未入库条码信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public IList<WarehouseCpInListInfo> GetInStockScanSN(WarehouseCpInListInfo entity)
        {
            try
            {
                var bll = new WarehouseCpInList();
                return bll.GetInStockScanSN(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }


        /// <summary>
        /// 根据箱号号获取未入库的入库单
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public WarehouseCpInListInfo GetScanedInStockNo(WarehouseCpInListInfo entity)
        {
            try
            {
                var bll = new WarehouseCpInList();
                return bll.GetScanedInStockNo(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// PDA成品入库
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public List<string> FinishProductInStorage(WarehouseCpInListInfo entity)
        {
            List<string> list = new List<string>();
            var tipMsg = string.Empty;
            try
            {
                WarehouseCpInList bll = new WarehouseCpInList();
                entity.ModifyBy = AccountController.GetCurrentUserInfo().UserName;
                //var erpInstockNo = bll.FinishProductInStorage(entity, out tipMsg);
                var erpInstockNo = bll.FinishProductInStorage(entity);
                list.Add(erpInstockNo);
                list.Add(tipMsg);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                list.Add(string.Empty);
                list.Add(tipMsg);
            }
            return list;
        }

        /// <summary>
        /// 获取成品打印的数量
        /// </summary>
        /// <param name="PoCode">工单号</param>
        /// <returns></returns>
        [AjaxMethod]
        public Decimal GetPrintQty(String PoCode)
        {
            Decimal POQty = 0;
            try
            {
                POQty = new WarehouseCpInList().GetPrintQty(PoCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return POQty;
        }

        /// <summary>
        /// 不良采集打印
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public List<string> NcPrintCollection(NcPrintCollectionInfo entity)
        {
            List<string> list = new List<string>();
            var tipMsg = string.Empty;
            try
            {
                WarehouseCpInList bll = new WarehouseCpInList();
                entity.UserName = AccountController.GetCurrentUserInfo().UserName;
                var erpInstockNo = bll.NcPrintCollection(entity);
                list.Add(erpInstockNo);
                list.Add(tipMsg);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                list.Add(string.Empty);
                list.Add(tipMsg);
            }
            return list;
        }


        [AjaxMethod]
        public string GenerateLineMaterialSN(LineMaterialSNInfo entity)
        {
            string result = string.Empty;
            try
            {
                WarehouseCpInList bll = new WarehouseCpInList();
                entity.UserName = AccountController.GetCurrentUserInfo().UserName;
                result = bll.GenerateLineMaterialSN(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return result;
        }

        /// <summary>
        /// 不良采集打印
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public List<string> CommonNcPrintCollection(NcPrintCollectionInfo entity)
        {
            List<string> list = new List<string>();
            var tipMsg = string.Empty;
            try
            {
                WarehouseCpInList bll = new WarehouseCpInList();
                entity.UserName = AccountController.GetCurrentUserInfo().UserName;
                var erpInstockNo = bll.CommonNcPrintCollection(entity);
                list.Add(erpInstockNo);
                list.Add(tipMsg);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                list.Add(string.Empty);
                list.Add(tipMsg);
            }
            return list;
        }
        [AjaxMethod]
        public List<ProdOrderStationInfo> GetProdOrderStationCollection(int orderid)
        {
            List<ProdOrderStationInfo> model ;
            try
            {
                //判断属于SN或者栈板 卡通箱
                WarehouseCpInList w = new WarehouseCpInList();
                model =(List<ProdOrderStationInfo>) w.GetProdOrderStationList(orderid);               
            }
            catch (Exception ex)
            {
                throw;
            }

            return model;
        }
    }
}