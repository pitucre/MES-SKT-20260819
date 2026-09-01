using AjaxPro;
using Newtonsoft.Json;
using SKT.Common.Model;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Warehouse.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxWarehouseCheck
    {
        /// <summary>
        /// 获取物料信息
        /// </summary>
        /// <param name="GRN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public WarehouseCheckInfo GetMaInfo(string GRN,int status=-1)
        {
            WarehouseCheckInfo w = new WarehouseCheckInfo();
            List<WarehouseCheckInfo> list = new List<WarehouseCheckInfo>();
            list = new WarehouseCheck().GetMaInfo(GRN, status);
            return list.Count() > 0 ? list[0] : null;
        }

        /// <summary>
        /// 盘点时库位不一致，调用移库逻辑将条码移动到实际库位
        /// 支持盘点锁定(Status=14)物料，按配置911决定处理方式(1-当场执行同仓移库/跨仓记录 2-只记录实际库位,平帐统一处理)
        /// </summary>
        /// <param name="cposcode">实际库位条码</param>
        /// <param name="grn">物料条码</param>
        /// <param name="checkNo">盘点单号</param>
        /// <returns></returns>
        [AjaxMethod]
        public string MoveMaterial(string cposcode, string grn, string checkNo)
        {
            string result = new WarehouseLocation().WarehouseCheckMoveMaterial(cposcode, grn, checkNo, AccountController.GetCurrentUser().UserName);
            return result;
        }

        /// <summary>
        /// 获取物料信息
        /// </summary>
        /// <param name="GRN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<WarehouseCheckInfo> GetMaListInfo(string GRN, int status = -1)
        {
            WarehouseCheckInfo w = new WarehouseCheckInfo();
            List<WarehouseCheckInfo> list = new List<WarehouseCheckInfo>();
            list = new WarehouseCheck().GetMaList(GRN, status);
            return list;
        }

        //通过包装箱SN获取盘点单明细信息
        [AjaxMethod]
        public WarehouseCheckInfo GetCheckOrderDetailInfo(string GRN, int checkOrderId)
        {
            WarehouseCheckInfo w = new WarehouseCheckInfo();
            List<WarehouseCheckInfo> list = new List<WarehouseCheckInfo>();
            list = new WarehouseCheck().GetCheckOrderDetailInfo(GRN, checkOrderId);
            return list.Count() > 0 ? list[0] : null;
        }
        //获取盘点单明细信息
        [AjaxMethod]
        public List<WarehouseCheckInfo> GetCheckOrderDetailInfoByPackageSN(string packageSN, int checkOrderId)
        {
            WarehouseCheckInfo w = new WarehouseCheckInfo();
            List<WarehouseCheckInfo> list = new List<WarehouseCheckInfo>();
            list = new WarehouseCheck().GetCheckOrderDetailInfoByPackageSN(packageSN, checkOrderId);
            return list;
        }

        /// <summary>
        /// 盘点扫描
        /// </summary>
        /// <param name="CheckNo"></param>
        /// <param name="GRN"></param>
        /// <param name="Qty"></param>
        /// <param name="UserName"></param>
        /// <param name="Type">1:初盘 2：复盘</param>
        [AjaxMethod]
        public void Scan(string CheckNo, string GRN, decimal Qty, string UserName, int Type)
        {
            WarehouseCheck w = new WarehouseCheck();
            w.Scan(CheckNo, GRN, Qty, UserName, Type);
        }
        /// <summary>
        /// 盘点撤销
        /// </summary>
        /// <param name="CheckNo"></param>
        /// <param name="GRN"></param>
        /// <param name="Qty"></param>
        /// <param name="UserName"></param>
        /// <param name="Type">1:初盘 2：复盘</param>
        [AjaxMethod]
        public int ScanCancelCheck(string CheckNo, string GRN, int Type)
        {
            WarehouseCheck w = new WarehouseCheck();
           return w.ScanCancelCheck(CheckNo, GRN, Type);
        }
        /// <summary>
        /// 盘点撤销检验
        /// </summary>
        /// <param name="CheckNo"></param>
        /// <param name="GRN"></param>
        /// <param name="Qty"></param>
        /// <param name="UserName"></param>
        /// <param name="Type">1:初盘 2：复盘</param>
        [AjaxMethod]
        public void ScanRollback(string CheckNo, string GRN, string UserName, int Type)
        {
            WarehouseCheck w = new WarehouseCheck();
            w.ScanRollback(CheckNo, GRN, UserName, Type);
        }

        /// <summary>
        /// 差异记录
        /// </summary>
        /// <param name="CheckNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<WarehouseCheckInfo> CheckDifferenceList(string CheckNo)
        {
            List<WarehouseCheckInfo> list = new List<WarehouseCheckInfo>();
            WarehouseCheck w = new WarehouseCheck();
            list = w.CheckDifferenceList(CheckNo);
            return list;
        }
        [AjaxMethod]
        public void Finish(string CheckNo, string UserName)
        {
            new WarehouseCheck().Finish(CheckNo, UserName);
        }
        [AjaxMethod]
        public void Edit(string CheckNo, string GRN, string Qty, string Remark, string UserName)
        {
            new WarehouseCheck().Edit(CheckNo, GRN, Qty, Remark, UserName);
        }
        [AjaxMethod]
        public List<WarehouseCheckReportInfo> GetGrnInfo(string orderNo, string itemCode)
        {
            return new WarehouseCheck().GetThreeList(orderNo, itemCode);
        }

        //获取盘点单明细信息
        [AjaxMethod]
        public string GetCheckOrderDetail(string checkOrder)
        {
            string strJson = "";
            try
            {
                strJson = new WarehouseCheckOrder().GetCheckOrderDetail(checkOrder);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        [AjaxMethod]
        public void SaveFirstCheckOrder(string strJson)
        {
            try
            {
                (new WarehouseCheck()).SaveFirstCheckOrder(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void SaveCheckOrder(string strJson)
        {
            try
            {
                (new WarehouseCheck()).SaveCheckOrder(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public string CheckOrderImportToExcel(string checkOrder, int typeId)
        {
            string strJson = "";
            try
            {
                strJson = new WarehouseCheck().ViewCheckOrderItem(checkOrder, typeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        [AjaxMethod]
        public List<WarehouseCheckOrderInfo> GetMaterialToChoose(Int32 startRow, Int32 maxRows, String sortExpression, string wareHouseIDOne, string wareHouseIDTwo, string barCodeOne, string barCodeTwo, 
            string itemCodeOne, string itemCodeTwo, int warehouseCheckOrderId,string venCode,string itemLevel)
        {
            SearchSettings searchSettings = new SearchSettings();
            string Andsql = " AND ";
            
            //查询数据
            if (wareHouseIDOne != "" && wareHouseIDTwo != "")
            {
                searchSettings.ExtensionCondition = " CWhCode BETWEEN  '" + wareHouseIDOne + "' AND  '" + wareHouseIDTwo + "'";
            }
            else
            {
                if (wareHouseIDOne != "")
                {
                    searchSettings.ExtensionCondition = " CWhCode ='" + wareHouseIDOne + "'";
                }
                else if (wareHouseIDTwo != "")
                {
                    searchSettings.ExtensionCondition = " CWhCode ='" + wareHouseIDTwo + "'";
                }
            }
            //加上货位查询
            if (barCodeOne != "" && barCodeTwo != "")
            {
                if (searchSettings.ExtensionCondition == "")
                {
                    searchSettings.ExtensionCondition = " cBarCode BETWEEN  '" + barCodeOne + "' AND  '" + barCodeTwo + "'";
                }
                else
                {
                    searchSettings.ExtensionCondition += Andsql + " cBarCode BETWEEN  '" + barCodeOne + "' AND  '" + barCodeTwo + "'";
                }
            }
            else
            {
                if (barCodeOne != "")
                {
                    if (searchSettings.ExtensionCondition == "")
                    {
                        searchSettings.ExtensionCondition = " cBarCode ='" + barCodeOne + "'";
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += Andsql + " cBarCode ='" + barCodeOne + "'";
                    }
                }
                else if (barCodeTwo != "")
                {
                    if (searchSettings.ExtensionCondition == "")
                    {
                        searchSettings.ExtensionCondition = " cBarCode ='" + barCodeTwo + "'";
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += Andsql + " cBarCode ='" + barCodeTwo + "'";
                    }
                }
            }

            //产品编码查询
            if (itemCodeOne != "" && itemCodeTwo != "")
            {
                if (searchSettings.ExtensionCondition == "")
                {
                    searchSettings.ExtensionCondition = " ItemCode BETWEEN  '" + itemCodeOne + "' AND  '" + itemCodeTwo + "'";
                }
                else
                {
                    searchSettings.ExtensionCondition += Andsql + " ItemCode BETWEEN  '" + itemCodeOne + "' AND  '" + itemCodeTwo + "'";
                }
            }
            else
            {
                if (itemCodeOne != "")
                {
                    if (searchSettings.ExtensionCondition == "")
                    {
                        searchSettings.ExtensionCondition = " ItemCode ='" + itemCodeOne + "'";
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += Andsql + " ItemCode ='" + itemCodeOne + "'";
                    }
                }
                else if (itemCodeTwo != "")
                {
                    if (searchSettings.ExtensionCondition == "")
                    {
                        searchSettings.ExtensionCondition = " ItemCode ='" + itemCodeTwo + "'";
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += Andsql + " ItemCode ='" + itemCodeTwo + "'";
                    }
                }
            }
            if (venCode !="")
            {
                if (searchSettings.ExtensionCondition == "")
                {
                    searchSettings.ExtensionCondition = " VendorCode ='" + venCode + "'";
                }
                else
                {
                    searchSettings.ExtensionCondition += Andsql + " VendorCode ='" + venCode + "'";
                }
            }
            if (itemLevel != "")
            {
                if (searchSettings.ExtensionCondition == "")
                {
                    searchSettings.ExtensionCondition = " ABCCLass ='" + itemLevel  + "'";
                }
                else
                {
                    searchSettings.ExtensionCondition += Andsql + " ABCCLass ='" + itemLevel + "'";
                }
            }
            var searchSql = "";
          //  var searchSql = "  GRN NOT IN ( SELECT  GRN   FROM vwGetCheckOrderExistsGRN   where WhCheckOrderId =  " + warehouseCheckOrderId + ")";
            if (searchSettings.ExtensionCondition == "")
            {

                searchSettings.ExtensionCondition = searchSql;
            }
            else
            {
                searchSettings.ExtensionCondition += searchSql;
            }
            searchSettings.ExtensionCondition += " AND Flag =-1";
            return new WarehouseCheckOrder().GetMaterialToChoose(startRow, maxRows, sortExpression, searchSettings);
        }

        [AjaxMethod]
        public List<WarehouseCheckOrderInfo> GetMaterialChecking(Int32 startRow, Int32 maxRows, String sortExpression, int orderId)
        {
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = " WhCheckOrderId =" + orderId + " ";
            return new WarehouseCheckOrder().GetMaterialChecking(startRow, maxRows, sortExpression, searchSettings);
        }


        [AjaxMethod]
        public void ScanBatch(string CheckNo, List<WarehouseCheckInfo> list, int Type)
        {


            WarehouseCheck w = new WarehouseCheck();
            w.ScanBatch(CheckNo, JsonConvert.SerializeObject(list.Select(x => new { GRN = x.GRN, Qty = x.UsekQty, LotCode = "", DateCode = "", MPN = ""}).ToList()), AccountController.GetCurrentUser().UserName, Type);
        }


        [AjaxMethod]
        public void chenckstationandsn(string station,string sn)
        {
            try
            {
                new WarehouseCheck().ChenckStationandSn(station, sn, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}