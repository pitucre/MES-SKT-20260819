using AjaxPro;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSWMS
    {

        #region 新电子货架

        /// <summary>
        /// 扫描物料GRN
        /// </summary>
        /// <param name="code"></param>
        [AjaxMethod]
        public InStorageDtl InStorageScanGRN_New(string cposcode, string grn, string cbarcode)
        {
            InStorageDtl dtl = null;
            try
            {
                dtl = new WarehouseLocation().ScanGRN(cposcode, AccountController.GetCurrentUser().UserName, grn);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
            return dtl;
        }
        /// <summary>
        /// 获取grn 备料的库位灯灭灯
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetCbarcode(string grn)
        {
            return new WarehouseLocation().GetCbarcode(grn);
        }

        /// <summary>
        /// 扫描物料GRN 移库
        /// </summary>
        /// <param name="cposcode"></param>
        /// <param name="grn"></param>
        /// <param name="cbarcode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] MoveMaterialScanGRN_New(string cposcode, string grn, string cbarcode)
        {
            try
            {
                //如果是备料移库，先灭灯
                int iscbarcode = 0;
                string result = new WarehouseLocation().MoveMaterialScanGRN(cposcode, grn, ref iscbarcode);
                return new string[] { iscbarcode.ToString(), result };
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 查询备料信息
        /// </summary>
        /// <returns></returns>

        [AjaxMethod]
        public List<TakeMaterialGRNDtl> GetTakeGRNInfo_New(int type, string code, int lockgrn, List<string> cbarcode, string itemcode)
        {
            try
            {
                return new WarehouseLocation().GetTakeGRNInfo(type, code, lockgrn, AccountController.GetCurrentUser().UserName, itemcode);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 取消备料
        /// </summary>
        /// <returns></returns>

        [AjaxMethod]
        public string CancelTakeGRNInfo(int type, string code)
        {
            try
            {
                return new WarehouseLocation().CancelTakeGRNInfo(type, code);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 确认备料,取消锁定,灭灯
        /// </summary>
        /// <param name="type"></param>
        /// <param name="code"></param>
        [AjaxMethod]
        public string SaveTakeGRNInfo(int type, string code)
        {
            try
            {
                return new WarehouseLocation().SaveCancelTakeGRNInfo(type, code);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 查询库龄
        /// </summary>
        /// <param name="code"></param>
        /// <param name="day"></param>
        [AjaxMethod]
        public List<AgeOfStorageDtl> QueryAgeOfStorage_New(string code, int day, List<string> cbarcodes)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(code))
                    return null;
                return new WarehouseLocation().QueryAgeOfStorage(code, day);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 物料库龄 下架
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="cbarcode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void AgeOfStorageScanGRN_New(string grn, string cbarcode)
        {
            try
            {
                new WarehouseLocation().AgeOfStorageScanGRN(grn, cbarcode);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        [AjaxMethod]
        public List<string> QueryDateCode_New(string itemcode, List<string> cbarcodes)
        {
            try
            {
                return new WarehouseLocation().QueryDateCode(itemcode);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 物料周期查询
        /// </summary>
        /// <param name="itemcode"></param>
        /// <param name="datecode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<QueryMaterialUnitDtl> QueryMaterialUnit_New(string itemcode, string datecode, List<string> cbarcodes)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(datecode))
                    return null;
                return new WarehouseLocation().QueryMaterialUnit(itemcode, datecode);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 物料盘点确认
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="grn"></param>
        /// <param name="qty"></param>
        [AjaxMethod]
        public string CheckMaterialConfirm_New(int itemId, string grn, decimal qty)
        {
            try
            {
                return new WarehouseLocation().CheckMaterialConfirm(itemId, grn, qty, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 盘点亮灯和灭灯
        /// </summary>
        [AjaxMethod]
        public List<string> CheckMaterial_New(int itemId, int type)
        {
            try
            {
                Tuple<string, string> t = new WarehouseLocation().CheckMaterial(itemId, type, AccountController.GetCurrentUser().UserName);
                return t.Item2.Split(new string[] { ",", "，" }, StringSplitOptions.RemoveEmptyEntries).ToList();
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 查询超期
        /// </summary>
        /// <param name="code"></param>
        /// <param name="cbarcodes"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ExpiredMaterialDtl> QueryExpiredMaterial_New(string code, List<string> cbarcodes)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(code))
                    return null;
                return new WarehouseLocation().QueryExpiredMaterial(code);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        #endregion

        /// <summary>
        /// 扫描货架层码
        /// </summary>
        /// <param name="code"></param>
        [AjaxMethod]
        public void InStorageScanCposcode(string cposcode)
        {
            try
            {
                new WarehouseLocation().ScanCposcode(cposcode);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 扫描物料GRN
        /// </summary>
        /// <param name="code"></param>
        [AjaxMethod]
        public InStorageDtl InStorageScanGRN(string cposcode, string grn, string cbarcode)
        {
            InStorageDtl dtl = null;
            try
            {
                dtl = new WarehouseLocation().ScanGRN(cposcode, AccountController.GetCurrentUser().UserName, grn);
                Close(new List<string> { cbarcode }, AccountController.GetCurrentUser().UserId.ToString() + "_0", "上架入库灭灯");

                //如果扫描的是货架，才亮灯
                if (dtl != null && dtl.iscbarcode == 0)
                {
                    string color = new WarehouseLocation().TaskColorCode(0).ColorCode;
                    Open(new List<ControlData> { new ControlData { Ce = dtl.cbarcode, Co = color } }, AccountController.GetCurrentUser().UserId.ToString() + "_0", "上架入库开灯");
                }
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
            return dtl;
        }
        
        /// <summary>
        /// 获取指定类型亮灯颜色描述
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        [AjaxMethod]
        public string TaskColorDesc(int type)
        {
            return new WarehouseLocation().TaskColorCode(type).ColorDescription;
        }
        /// <summary>
        /// 完成入库
        /// </summary>
        /// <param name="cposcode"></param>
        /// <param name="cbarcode"></param>
        /// <param name="orders">检验单号</param>
        [AjaxMethod]
        public void SaveInStorage(string cposcode, string cbarcode, List<string> orders)
        {
            try
            {
                Close(new List<string> { cbarcode }, AccountController.GetCurrentUser().UserId.ToString() + "_0", "完成入库灭灯");
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 查询库龄
        /// </summary>
        /// <param name="code"></param>
        /// <param name="day"></param>
        [AjaxMethod]
        public List<AgeOfStorageDtl> QueryAgeOfStorage(string code, int day, List<string> cbarcodes)
        {
            try
            {
                Close(cbarcodes, AccountController.GetCurrentUser().UserId.ToString() + "_1", "查询库龄灭灯");
                if (string.IsNullOrWhiteSpace(code))
                    return null;

                string color = new WarehouseLocation().TaskColorCode(1).ColorCode;
                //光灯
                List<AgeOfStorageDtl> data = new WarehouseLocation().QueryAgeOfStorage(code, day);
                //亮起所有货位灯
                List<ControlData> list = new List<ControlData>();
                data.ForEach(item => list.Add(new ControlData { Ce = item.cbarcode, Co = color }));
                Open(list, AccountController.GetCurrentUser().UserId.ToString() + "_1", "查询库龄开灯");
                return data;
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 物料库龄 下架
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="cbarcode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void AgeOfStorageScanGRN(string grn, string cbarcode)
        {
            try
            {
                new WarehouseLocation().AgeOfStorageScanGRN(grn, cbarcode);
                //关闭货位灯 cbarcode
                Close(new List<string> { cbarcode }, AccountController.GetCurrentUser().UserId.ToString() + "_1", "物料库龄下架灭灯");
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 物料周期查询
        /// </summary>
        /// <param name="itemcode"></param>
        /// <param name="datecode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<QueryMaterialUnitDtl> QueryMaterialUnit(string itemcode, string datecode, List<string> cbarcodes)
        {
            try
            {
                Close(cbarcodes, AccountController.GetCurrentUser().UserId.ToString() + "_6", "物料周期灭灯");
                if (string.IsNullOrWhiteSpace(datecode))
                    return null;
                string color = new WarehouseLocation().TaskColorCode(6).ColorCode;
                List<QueryMaterialUnitDtl> data = new WarehouseLocation().QueryMaterialUnit(itemcode, datecode);
                List<ControlData> list = new List<ControlData>();
                data.ForEach(item => list.Add(new ControlData { Ce = item.cBarCode, Co = color }));
                Open(list, AccountController.GetCurrentUser().UserId.ToString() + "_6", "物料周期开灯");

                return data;
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        [AjaxMethod]
        public List<string> QueryDateCode(string itemcode, List<string> cbarcodes)
        {
            try
            {

                Close(cbarcodes, AccountController.GetCurrentUser().UserId.ToString() + "_6", "物料周期灭灯");
                return new WarehouseLocation().QueryDateCode(itemcode);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 扫描物料GRN 移库
        /// </summary>
        /// <param name="cposcode"></param>
        /// <param name="grn"></param>
        /// <param name="cbarcode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string MoveMaterialScanGRN(string cposcode, string grn, string cbarcode)
        {
            try
            {
                //如果是备料移库，先灭灯
                int iscbarcode = 0;

                string code = new WarehouseLocation().GetCbarcode(grn);
                if (!string.IsNullOrWhiteSpace(code))
                {
                    Close(new List<string> { code }, AccountController.GetCurrentUser().UserId.ToString() + "_5", "备料中的物料移库灭灯");
                }

                string result = new WarehouseLocation().MoveMaterialScanGRN(cposcode, grn, ref iscbarcode);
                Close(new List<string> { cbarcode }, AccountController.GetCurrentUser().UserId.ToString() + "_5", "物料移库灭灯");
                if (iscbarcode == 0)
                {
                    string color = new WarehouseLocation().TaskColorCode(5).ColorCode;
                    Open(new List<ControlData> { new ControlData { Ce = result, Co = color } }, AccountController.GetCurrentUser().UserId.ToString() + "_5", "物料移库开灯");
                }
                return result;
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        [AjaxMethod]
        public void SaveMoveMaterial(string cposcode, string cbarcode)
        {
            try
            {
                Close(new List<string> { cbarcode }, AccountController.GetCurrentUser().UserId.ToString() + "_5", "保存物料移库灭灯");
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 查询超期
        /// </summary>
        /// <param name="code"></param>
        /// <param name="cbarcodes"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ExpiredMaterialDtl> QueryExpiredMaterial(string code, List<string> cbarcodes)
        {
            try
            {
                Close(cbarcodes, AccountController.GetCurrentUser().UserId.ToString() + "_2", "查询超期灭灯");
                if (string.IsNullOrWhiteSpace(code))
                    return null;

                string color = new WarehouseLocation().TaskColorCode(2).ColorCode;
                List<ExpiredMaterialDtl> data = new WarehouseLocation().QueryExpiredMaterial(code);
                //亮起所有货位灯
                List<ControlData> list = new List<ControlData>();
                data.ForEach(item => list.Add(new ControlData { Ce = item.cBarCode, Co = color }));
                Open(list, AccountController.GetCurrentUser().UserId.ToString() + "_2", "查询超期开灯");
                return data;
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 查询退料单
        /// </summary>
        /// <returns></returns>

        [AjaxMethod]
        public List<string> GetRecord()
        {
            try
            {
                return new WarehouseLocation().GetRecord();
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 查询工单
        /// </summary>
        /// <returns></returns>

        [AjaxMethod]
        public List<string> GetLoadOrder()
        {
            try
            {
                return new WarehouseLocation().GetLoadOrder();
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 查询领料单
        /// </summary>
        /// <returns></returns>

        [AjaxMethod]
        public List<string> GetRequestOrder()
        {
            try
            {
                return new WarehouseLocation().GetRequestOrder();
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 查询备料信息
        /// </summary>
        /// <returns></returns>

        [AjaxMethod]
        public List<TakeMaterialGRNDtl> GetTakeGRNInfo(int type, string code, int lockgrn, List<string> cbarcode, string itemcode)
        {
            try
            {
                List<TakeMaterialGRNDtl> data = null;
                if (lockgrn == 0)
                {
                    data = new WarehouseLocation().GetTakeGRNInfo(type, code, lockgrn, AccountController.GetCurrentUser().UserName, itemcode);
                }
                else if (lockgrn == 1)
                {
                    data = new WarehouseLocation().GetTakeGRNInfo(type, code, lockgrn, AccountController.GetCurrentUser().UserName, itemcode);
                    //备料，锁定
                    List<ControlData> list1 = new List<ControlData>();//不闪烁的
                    List<ControlData> list2 = new List<ControlData>();//闪烁的
                    foreach (var item in data)
                    {
                        if (!string.IsNullOrWhiteSpace(item.LockCode))
                            continue;

                        if (item.Cut == 0)
                            list1.Add(new ControlData { Ce = item.cBarCode, Co = item.ColorCode });
                        else
                            list2.Add(new ControlData { Ce = item.cBarCode, Co = item.ColorCode });
                    }
                    Open(list1, "take001", code + "备料开灯");
                    Open(list2, "take001", code + "备料开灯闪烁", true);
                }
                else if (lockgrn == 2)
                {
                    string cbarcodes = new WarehouseLocation().CancelTakeGRNInfo(type, code);
                    if (!string.IsNullOrWhiteSpace(cbarcodes))
                    {
                        //取消备料，取消锁定
                        Close(cbarcodes.Split(',').ToList(), "take001", code + "备料灭灯");
                    }
                }
                return data;
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 设置工单亮灯是否可用
        /// </summary>
        /// <returns></returns>

        [AjaxMethod]
        public void SetInUseProdOrderNo(int id, string prodOrderNo)
        {
            try
            {
                new WarehouseLightColor().SetInUseProdOrderNo(id, prodOrderNo);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 获取可用得工单颜色配置
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public WarehouseLightColorInfo GetUsableProdOrderLightColor()
        {
            try
            {
                return new WarehouseLightColor().GetUsableProdOrderLightColor();
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 获取可用得工单颜色配置
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public WarehouseLightColorInfo GetProdOrderLightColor(string prodOrderNo)
        {
            try
            {
                return new WarehouseLightColor().GetProdOrderLightColor(prodOrderNo);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 查询盘点物料
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        /// 
        [AjaxMethod]
        public List<CheckMaterialDtl> QueryCheckMaterial(string code)
        {
            try
            {
                return new WarehouseLocation().QueryCheckMaterial(code);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 查询GRN数量
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [AjaxMethod]
        public decimal CheckMaterialScanGRN(int itemId, string grn)
        {
            try
            {
                return new WarehouseLocation().CheckMaterialScanGRN(itemId, grn);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        [AjaxMethod]
        public void CheckMaterialConfirm(int itemId, string grn, decimal qty)
        {
            try
            {
                string cbarcode = new WarehouseLocation().CheckMaterialConfirm(itemId, grn, qty, AccountController.GetCurrentUser().UserName);
                Close(new List<string> { cbarcode }, AccountController.GetCurrentUser().UserId.ToString() + "_3_" + itemId, grn + "盘点完成灭灯");
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 盘点亮灯和灭灯
        /// </summary>
        [AjaxMethod]
        public void CheckMaterial(int itemId, int type)
        {
            try
            {
                Tuple<string, string> t = new WarehouseLocation().CheckMaterial(itemId, type, AccountController.GetCurrentUser().UserName);
                List<string> codes = t.Item2.Split(new string[] { ",", "，" }, StringSplitOptions.RemoveEmptyEntries).ToList();
                if (type == 0)
                {
                    List<ControlData> list = new List<ControlData>();
                    codes.ForEach(item =>
                    {
                        list.Add(new ControlData { Ce = item, Co = t.Item1 });
                    });
                    //亮灯
                    Open(list, AccountController.GetCurrentUser().UserId.ToString() + "_3_" + itemId, "盘点开灯");
                }
                else
                {
                    //灭灯
                    Close(codes, AccountController.GetCurrentUser().UserId.ToString() + "_3_" + itemId, "盘点灭灯");
                }
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 关灯
        /// </summary>
        /// <param name="cbarcodes"></param>
        public void Close(List<string> cbarcodes, string code, string title)
        {
            if (string.IsNullOrWhiteSpace(code))
                code = AccountController.GetCurrentUser().UserId.ToString();
            List<ControlData> list = new List<ControlData>();
            if (cbarcodes != null)
                cbarcodes.ForEach(item => list.Add(new ControlData { Ce = item }));

            APIRequest(new ControlInfo
            {
                T1 = new List<ControlHead> { new ControlHead { Code = code, Command = "close" } },
                T2 = list
            }, title);
        }
        /// <summary>
        /// 开灯
        /// </summary>
        /// <param name="list">库位</param>
        /// <param name="code">批次</param>
        /// <param name="pro">闪烁</param>
        private void Open(List<ControlData> list, string code, string title, bool pro = false)
        {
            if (list == null || list.Count == 0)
                return;

            APIRequest(new ControlInfo
            {
                T1 = new List<ControlHead> { new ControlHead { Code = code, Pro = pro ? "1" : "0" } },
                T2 = list
            }, title);
        }

        /// <summary>
        /// 设置工单亮灯是否可用
        /// </summary>
        /// <returns></returns>

        [AjaxMethod]
        public void SetInUseProdOrderNoST(int id, string prodOrderNo, int isUse)
        {
            try
            {
                new WarehouseLightColor().SetInUseProdOrderNo(id, prodOrderNo, isUse > 0);
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                throw new Exception(ex.Message);
            }
        }

        private void APIRequest(ControlInfo info, string title)
        {
            string result = "";
            string url = "";
            string content = "";
            try
            {
                content = Newtonsoft.Json.JsonConvert.SerializeObject(info);
                url = System.Configuration.ConfigurationManager.AppSettings["MAESWEBServiceAPIURL"];
                if (string.IsNullOrWhiteSpace(url))
                {
                    throw new Exception("请设置参数MAESWEBServiceAPIURL");
                }
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                request.Timeout = 6000;
                request.ContentLength = 0;
                request.ContentType = "application/json";
                request.Method = "POST";
                if (info != null)
                {
                    byte[] data = Encoding.GetEncoding("UTF-8").GetBytes(Newtonsoft.Json.JsonConvert.SerializeObject(info));
                    request.ContentLength = data.Length;
                    Stream stream = request.GetRequestStream();
                    stream.Write(data, 0, data.Length);
                    stream.Close();
                }
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                using (StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                {
                    result = sr.ReadToEnd();
                }
                response.Close();
                request.Abort();
                if (!string.IsNullOrWhiteSpace(result) && result.Contains(":") && result.Substring(0, result.IndexOf(":")).ToLower() == "false")
                {
                    new WarehouseLocation().WritLog(AccountController.GetCurrentUser().UserName, title + "，API地址：" + url + "\r\n请求参数：" + content + "\r\n错误消息：" + result);
                }
                else
                {
                    new WarehouseLocation().WritLog(AccountController.GetCurrentUser().UserName, title + "，API地址：" + url + "\r\n请求参数：" + content + "\r\n返回消息：" + result);
                }
            }
            catch (Exception ex)
            {
                new WarehouseLocation().WritLog(AccountController.GetCurrentUser().UserName, title + "，API地址：" + url + "\r\n请求参数：" + content + "\r\n异常消息：" + ex.Message + "\r\n堆栈信息：" + ex.StackTrace);
            }
        }
        public class ControlInfo
        {
            public List<ControlHead> T1 { get; set; }
            public List<ControlData> T2 { get; set; }
        }
        public class ControlHead
        {
            public string Code = "";
            public string Command = "";
            public string Pro = "0";
            public string Time = "0";
        }
        public class ControlData
        {
            /// <summary>
            /// 库位
            /// </summary>
            public string Ce { get; set; }
            /// <summary>
            /// 颜色
            /// </summary>
            public string Co { get; set; }
        }
    }
}