using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Print.BLL;
using AjaxPro;
using AJAXdataHelper;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Web.Material;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Supplier.Model;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.AccessoryManagement.Model;
using SKT.LeanMES.AccessoryManagement.BLL;
using SKT.Common.Model;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Manufacture.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaterial
    {
        /// <summary>
        /// 页面加载时，获取批次号
        /// add by weixia on 2016.9.8
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetLotCode()
        {
            string strJson = "";
            try
            {
                strJson = new MaterialUnit().GetLotCode();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        /// <summary>
        /// 根据PO，物料获取该PO的已打印总数量
        /// add by weixia on 2016.9.8
        /// </summary>
        /// <param name="PoCode"></param>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Decimal GetPrintQty(String PoCode, String ItemCode, int rowID)
        {
            Decimal POQty = 0;
            try
            {
                POQty = new MaterialUnit().GetPrintQty(PoCode, ItemCode, rowID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return POQty;
        }
        /// <summary>
        /// 生成GRN条码
        /// add by weixia on 2016.9.9
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="VendorCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GenerateGRN(int ItemId, decimal GRNQty, decimal MinQty, decimal bigCartonQty, decimal itemAllQty, decimal aPrintQty
            , string LotCode, string DateCode, string VendorCode, string poCode
            , string factory, string remark, int RowId, bool isSupplyPrint, string WeekCode, string MPN, string iqcOrder = "") //,string POInStockNo="" //2017-09-09 ,wenshun ,到货单打印功能，创维专利，正式版本不需要
        {
            string[] str = new string[2];
            try
            {
                str = (new MaterialUnit()).GenerateGRN(ItemId, GRNQty, MinQty, bigCartonQty, itemAllQty, aPrintQty,
                   LotCode, DateCode, VendorCode, AccountController.GetCurrentUser().UserName, poCode, factory, remark, RowId, isSupplyPrint, WeekCode, MPN, iqcOrder); //, POInStockNo//2017-09-09 ,wenshun ,到货单打印功能，创维专利，正式版本不需要
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 销售退货生成GRN条码
        /// </summary>
        [AjaxMethod]
        public string[] SaleReturnGenerateGRN(int ItemId, decimal GRNQty, decimal MinQty, decimal bigCartonQty, decimal itemAllQty, decimal aPrintQty
            , string LotCode, string DateCode, string CustomerCode,  string SaleReturnNo
            , string factory, string remark, int SaleReturnRowId, bool isSupplyPrint, string WeekCode, string MPN, string iqcOrder = "") //,string POInStockNo=""//到货单打印功能，创维专利，正式版本不需要
        {
            string[] str = new string[2];
            try
            {
                str = (new MaterialUnit()).SaleReturnGenerateGRN(ItemId, GRNQty, MinQty, bigCartonQty, itemAllQty, aPrintQty,
                   LotCode, DateCode, CustomerCode, AccountController.GetCurrentUser().UserName, SaleReturnNo, factory, remark, SaleReturnRowId, isSupplyPrint, WeekCode, MPN, iqcOrder); //, POInStockNo//2017-09-09 ,wenshun ,到货单打印功能，创维专利，正式版本不需要
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        //离线条码
        [AjaxMethod]
        public string[] OfflineGenerateGRN(int ItemId, int GRNQty, decimal MinQty, decimal bigCartonQty, decimal itemAllQty, decimal aPrintQty
            , string LotCode, string DateCode, string VendorCode, string poCode
            , string factory, string remark, int RowId, bool isSupplyPrint, string WeekCode, string MPN, string GRNString, string iqcOrder = "") //,string POInStockNo="" //2017-09-09 ,wenshun ,到货单打印功能，创维专利，正式版本不需要
        {
            string[] str = new string[2];
            try
            {
                str = (new MaterialUnit()).OfflineGenerateGRN(ItemId, GRNQty, MinQty, bigCartonQty, itemAllQty, aPrintQty,
                   LotCode, DateCode, VendorCode, AccountController.GetCurrentUser().UserName, poCode, factory, remark, RowId, isSupplyPrint, WeekCode, MPN, GRNString, iqcOrder); //, POInStockNo//2017-09-09 ,wenshun ,到货单打印功能，创维专利，正式版本不需要
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 离线条码登记扫描GRN校验GRN是否存在
        /// </summary>
        /// <param name="grn">扫描的GRN</param>
        /// <returns>返回空字符串，则表示验证OK，否则返回具体的错误消息</returns>
        [AjaxMethod]
        public string OfflineValidateGRN(string grn)
        {
            try
            {
                return new MaterialUnit().OfflineValidateGRN(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return ex.Message;
            }
        }

        /// <summary>
        /// 删除物料GRN
        /// </summary>
        /// <param name="idString">Id 字符串</param>
        /// <param name="Type">类型(1供应商删除GRN、2仓库删除GRN)</param>
        [AjaxMethod]
        public void DeleteGRN(string idString, int Type)
        {
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                bllUnit.Delete(idString, Type, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 保存报废动作
        /// add by weixia on 2016.9.10
        /// </summary>
        [AjaxMethod]
        public void FailGRNByVenCode(String idString)
        {
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                bllUnit.FailGrnByVencode(idString, AccountController.GetCurrentUser().UserName);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 判断物料GRN是否在仓库：恒温箱、烘烤箱中
        /// </summary>
        /// <param name="idString"></param>
        [AjaxMethod]
        public void GRNCheckOperation(String idString)
        {
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                bllUnit.GRNCheckOperation(idString);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取供应商编码根据userId
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public SuppliersInfo GetVenCodeByUserId(int userId)
        {
            SuppliersInfo entity = null;
            try
            {
                entity = (new Suppliers()).GetVenCodeByUserId(userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 
        /// 验证GRN有效性 add by weixia on 2016.9.10
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="cartonsn"></param>
        /// <param name="vendorCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] ValidateGRN(string grn, string cartonsn, string vendorCode,string firstGrn="")
        {
            string[] str = new string[3];
            try
            {
                str = (new MaterialUnit()).ValidateGRN(grn, cartonsn, vendorCode, AccountController.GetCurrentUser().UserName, firstGrn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        /// <summary>
        /// 
        /// 验证GRN状态是否在送货单
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="cartonsn"></param>
        /// <param name="vendorCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool ValidateGRNOnWay(string grn)
        {
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                MaterialUnitInfo model = null;
                model = bllUnit.GetMateialUnitById(0, grn);
                return model != null && model.Status == 7;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return false;
        }
        /// <summary>
        /// 产生一个新的包装箱，用于包装。
        /// add by weixia on 2016.9.10
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="isBigCarton">1 - 产生新的中箱，2 - 产生新的大箱</param>
        /// <returns></returns>
        [AjaxMethod]
        public string GenerateNewCartonSNAndPack(string grn, int isBigCarton)
        {
            string cartonsn = "";
            try
            {
                cartonsn = (new MaterialUnit()).GenerateNewCartonSNAndPack(grn, isBigCarton, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return cartonsn;
        }

        /// <summary>
        /// 获取所有未关闭的包装箱条码
        /// add by peter on 2016-5-17
        /// </summary>
        /// <param name="cartonsn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetOldCartonGRNList(string cartonsn)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                list = (new MaterialUnit()).GetOldCartonGRNList(cartonsn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 对选择未关闭的包装箱条码进行包装
        /// add by peter on 2016-5-11
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="vendorCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void GetOldCartonGRN(string grn, string vendorCode, string oldCartonSN)
        {
            try
            {
                (new MaterialUnit()).GetOldCartonGRN(grn, vendorCode, oldCartonSN, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 已包装的物料列表
        /// </summary>
        /// <param name="cartonsn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetPackedItemList(string cartonsn)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                list = (new MaterialUnit()).GetPackedItemList(cartonsn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 关闭包装箱
        /// </summary>
        /// <param name="cartonsn"></param>
        [AjaxMethod]
        public void ClosePack(string cartonsn)
        {
            try
            {
                (new MaterialUnit()).ClosePack(cartonsn, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据GRN获取物料信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public MaterialUnitInfo GetMaterialUnitInfoByGRN(string grn)
        {
            MaterialUnitInfo entity = null;
            try
            {
                entity = (new MaterialUnit()).GetInfo(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
            }
            return entity;
        }
        /// <summary>
        /// 根据物料条码查是否是包装箱，如果是返回包装箱条码，如果不是返回物料条码
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public MaterialUnitInfo GetSelectSerialNumberBySerialNumber(string grn)
        {
            MaterialUnitInfo entity = null;
            try
            {
                entity = (new MaterialUnit()).GetSelectSerialNumberBySerialNumber(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
            }
            return entity;
        }

        /// <summary>
        /// 根据SerialNumber 查询所有采购单号
        /// </summary>
        /// <param name="SerialNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetMaterialUnitPoCode(string SerialNumber)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            try
            {
                list = (new MaterialUnit()).GetMaterialUnitPoCode(SerialNumber);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 取消包装
        /// </summary>
        /// <param name="cartonsn"></param>
        /// <param name="IsSuply">是否供应商解包 1：是 0：否</param>
        [AjaxMethod]
        public void UnPack(string cartonsn,int IsSuply=0)
        {
            try
            {
                (new MaterialUnit()).UnPack(cartonsn, AccountController.GetCurrentUser().UserName, IsSuply);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取包装箱状态
        /// </summary>
        /// <param name="cartonsn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetCartonStatus(string cartonsn)
        {
            Int32 cartonStatus = 1;
            try
            {
                cartonStatus = (new MaterialUnit()).GetCartonStatus(cartonsn, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return cartonStatus;
        }

        /// <summary>
        /// 删除包装箱
        /// </summary>
        /// <param name="cartonId"></param>
        [AjaxMethod]
        public void DeleteCarton(int cartonId)
        {
            try
            {
                (new MaterialUnit()).DeleteCarton(cartonId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 从包装箱内移除GRN
        /// add by weixia on 2016.9.10
        /// </summary>
        /// <param name="cartonsn"></param>
        /// <param name="grnsn"></param>
        [AjaxMethod]
        public void RemoveGRN(string cartonsn, string grnsn)
        {
            try
            {
                (new MaterialUnit()).RemoveGRN(cartonsn, grnsn, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 自动从包装箱内移除GRN
        /// add by weixia on 2016.9.10
        /// </summary>
        /// <param name="cartonsn"></param>
        /// <param name="grnsn"></param>
        [AjaxMethod]
        public void RemoveGRNAuto(string cartonsn, string grnsn)
        {
            try
            {
                (new MaterialUnit()).RemoveGRN(cartonsn, grnsn, AccountController.GetCurrentUser().UserName, true);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }



        /// <summary>
        /// 仓库备料先进先出列表
        /// </summary>
        [AjaxMethod]
        public string GetMaterialPrepareGRN(string uspName, string strJson)
        {
            try
            {
                return ComMethod.EditBack(strJson, uspName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }

        /// <summary>
        ///  add by weixia on 2015.10.28 打印历史物料
        /// </summary>
        [AjaxMethod]
        public List<GRNLabelsInfo> PrintHistoryGRN(Int32 itemId, Decimal grnQty, Decimal minQty, String lotCode, String dateCode, String vendorCode, String userName, String cBarCode)
        {
            List<GRNLabelsInfo> list = new List<GRNLabelsInfo>();
            try
            {
                list = (new MaterialUnit()).PrintHistoryGRN(itemId, grnQty, minQty, lotCode, dateCode, vendorCode, userName, cBarCode);
            }
            catch (Exception ex)
            {
                if (ex.Message.IndexOf("&nbsp;") > 0)
                {
                    throw ex;
                }
                else
                {
                    WebHelper.HandleException(ex);
                }
            }
            return list;
        }

        [AjaxMethod]
        public ItemInfo GetItemInfo(string itemcode)
        {
            ItemInfo entity = null;
            try
            {
                 entity = new Item().GetInfo(itemcode);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }
        [AjaxMethod]
        public string GetProItemInfo(string itemcode)
        {
            string entity = string.Empty;
            try
            {
                entity = new Item().GetItemInfo(itemcode);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }
        /// <summary>
        /// 更改GRN数量
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int ModifyGRNQuantity(string id, decimal quantity)
        {
            try
            {
                SKT.LeanMES.Material.BLL.MaterialUnit bll = new SKT.LeanMES.Material.BLL.MaterialUnit();
                int result = bll.EditGRNQuanty(Convert.ToInt32(id), quantity, AccountController.GetCurrentUser().UserName);
                return 1;
            }
            catch (Exception EX)
            {
                WebHelper.HandleException(EX);
                return 0;
            }
        }
        /// <summary>
        /// 库位转移
        /// add by weixia on 2016.10.18
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="Code"></param>
        /// <param name="userName"></param>
        /// <param name="flag"></param>
        [AjaxMethod]
        public string  StorageTransfer(String sn, String Code, String userName, Int32 flag)
        {
            try
            {
                MaterialUnit bll = new MaterialUnit();
                return  bll.StorageTransfer(sn, Code, userName, flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return "";
        }

        /// <summary>
        /// PDA成品库位转移
        /// add by weixia on 2016.10.18
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="Code"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void SaveStorageTransferProd(String sn, String Code, String userName)
        {
            try
            {
                MaterialUnit bll = new MaterialUnit();
                bll.SaveStorageTransferProd(sn, Code, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 成品库位转移
        /// add by weixia on 2016.10.18
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="Code"></param>
        /// <param name="userName"></param>
        /// <param name="flag"></param>
        [AjaxMethod]
        public DataTable StorageTransferProd(String sn)
        {
            DataTable dt = null;
            try
            {
                MaterialUnit bll = new MaterialUnit();
                dt = bll.StorageTransferProd(sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }

        /// <summary>
        /// 根据GRN和库位条码获取数量
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public Decimal GetQuantityByQty(string grn, string wareCode, int flag)
        {
            Decimal qty = 0;
            try
            {
                qty = (new MaterialUnit()).GetQuantityByQty(grn, wareCode, flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return qty;
        }

        /// <summary>
        /// 物料报废
        /// </summary>
        /// <param name="grn">物料条码</param>
        /// <param name="wareCode">库位条码</param>
        /// <param name="qty">报废数量</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> ScrapMaterial(String grn, String wareCode)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                list = bllUnit.ScrapMaterial(grn, wareCode, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        ///检查物料合并
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> CheckMaterialCombine(String grn)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                list = bllUnit.CheckMaterialCombine(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 保持物料合并
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="waitCombineGrn"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> SaveCombineMaterial(String grn, String waitCombineGrn)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                list = bllUnit.SaveCombineMaterial(grn, waitCombineGrn, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 分料截料
        /// </summary>
        /// <param name="qty"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> SplitMaterial(string qty, string grn)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                list = (new MaterialUnit()).SplitMaterial(Convert.ToDecimal(qty), grn, AccountController.GetCurrentUser().UserName).OrderBy(t=>t.SplitTime).ToList();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取GRN总数量
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public object[] GetGRNQuantity(string grn)
        {

            object[] obj = new object[2];
            try
            {
                obj = (new MaterialUnit()).GetGRNQuantity(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return obj;
        }

        [AjaxMethod]
        public SuppliersInfo GetVendorInfo(string vendorcode)
        {
            SuppliersInfo entity = null;
            try
            {
                entity = (new Suppliers()).GetInfo(vendorcode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 获取物料信息
        /// </summary>
        /// <param name="materialUnitId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetMaterialInfo(string materialUnitIds)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();

            try
            {
                var materialUnitIdArr = materialUnitIds.Split(',');
                MaterialUnitInfo entity = new MaterialUnitInfo();
                foreach (var materialUnitId in materialUnitIdArr)
                {
                    entity = (new MaterialUnit()).GetMateialUnitById(Convert.ToInt64(materialUnitId));
                    if (entity != null && !string.IsNullOrEmpty(entity.SerialNumber))
                    {
                        list.Add(entity);
                    }
                }

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取RTV信息
        /// </summary>
        [AjaxMethod]
        public string GetInfoRTV(string rtvOrderId, string IsByID = "")
        {
            var strInfo = "";
            try
            {                    
                strInfo = (new LeanMES.Material.BLL.ReturnToVendor()).GetRtvItemInfo(rtvOrderId, string.IsNullOrWhiteSpace(IsByID));
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strInfo;
        }

        /// <summary>
        /// 检查并获取GRN信息
        /// </summary>
        [AjaxMethod]
        public string CheckGrnReturn(int returnOrderId, string grn)
        {
            var strInfo = "";
            try
            {
                strInfo = (new LeanMES.Material.BLL.ReturnToVendor()).CheckGrnReturn(returnOrderId, grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strInfo;
        }

        /// <summary>
        /// 确认保存退料到供应商
        /// </summary>
        [AjaxMethod]
        public void SaveRTV(int returnOrderId, string grns,string reTurnDetailsJson)
        {

            try
            {
                (new LeanMES.Material.BLL.ReturnToVendor()).SaveGrnReturn(returnOrderId, grns, AccountController.GetCurrentUser().UserName, reTurnDetailsJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        /// <summary>
        /// 确认保存备料接收地
        /// </summary>
        [AjaxMethod]
        public void PrepareToOtherEdit(PrepareToOtherInfo entity)
        {

            try
            {
                (new LeanMES.Material.BLL.PrepareToOther()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        /// <summary>
        ///  生成生产退料单 
        /// </summary>
        [AjaxMethod]
        public void NewProdReturnOrder(string ReturnNo, string ItemList, int DeptId, string UserName, String ProdOrderNo)
        {
            try
            {
                new LeanMES.Material.BLL.Material().EditProdReturnOrder(ReturnNo, ItemList, DeptId, UserName, ProdOrderNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取RTV信息
        /// </summary>
        [AjaxMethod]
        public string GetInfoRTW(string rtOrderNo)
        {
            var strInfo = "";
            try
            {
                strInfo = (new LeanMES.Material.BLL.Material()).GetProdRtItemInfo(rtOrderNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strInfo;
        }

        /// <summary>
        /// 检查并获取GRN信息
        /// </summary>
        [AjaxMethod]
        public string CheckGrnRTW(string returnOrder, string grn)
        {
            var strInfo = "";
            try
            {
                strInfo = (new LeanMES.Material.BLL.Material()).CheckGrnReturnWarehouse(returnOrder, grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strInfo;
        }

        /// <summary>
        /// 保存仓库退料入料
        /// </summary>
        [AjaxMethod]
        public void SaveRTW(string returnNo, string strGrns, string cBarcode)
        {
            try
            {
                (new LeanMES.Material.BLL.Material()).SaveGrnReturnWarehouse(returnNo, strGrns, cBarcode, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据物料条码获取物料明细信息
        /// </summary>
        [AjaxMethod]
        public DataTable GetMaterialDetailInfo(string val)
        {
            DataTable dt = null;
            try
            {
                dt = new SKT.LeanMES.Material.BLL.MaterialUnit().GetMaterialDetailInfo(val);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }

        [AjaxMethod]
        public DataTable SearchWarehouseInfo(int type,string val)
        {
            DataTable dt = null;
            try
            {
                dt = new SKT.LeanMES.Material.BLL.MaterialUnit().SearchWarehouseInfo(type,val);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }

        /// <summary>
        /// 成品入库/出货信息
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        [AjaxMethod]
        public PDAWarehouseInfo SearchFinishProdInfo(string val)
        {
            PDAWarehouseInfo result = new PDAWarehouseInfo();
            try
            {
             
                SKT.LeanMES.SerialNumber.BLL.SerialNumber bllData = new LeanMES.SerialNumber.BLL.SerialNumber();
                var No=bllData.GetSNByCSN(val);//获取关联产品条码
                var storageInfo= new SKT.LeanMES.Manufacture.BLL.InfoCenter().GetStorageInfo(val);//入库信息
                //获取条码关联的条码
                string code = "";
                string sn = "";
                if(val== No)//传入的产品条码
                {
                    sn = No;
                    //查询产品对应客户条码
                    code =  (bllData.GetSNByCustome(val));
                }
                else//客户条码
                {
                    sn = No;
                    code = val;
                }
                var outStockInfo = new SKT.LeanMES.Manufacture.BLL.InfoCenter().GetOutStockInfo(sn,code);//出库信息

                //产品基础信息
                VUnitHistoryInfo vhi = new SKT.LeanMES.Manufacture.BLL.InfoCenter().GetProductSummaryInfo(No);
                result.storageInfo = storageInfo;
                result.outStockInfo = outStockInfo;
                result.productInfo = vhi;


            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return result;
        }
        /// <summary>
        /// 获取退料单
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public IList<ReturnToVendorInfo> GetRtvOrderList(string value)
        {
            IList<ReturnToVendorInfo> list = null;
            try
            {
                SearchSettings setting = new SearchSettings();
                setting.ExtensionCondition = string.Format(" ReturnOrder like '%{0}%'", value);
                list = new LeanMES.Material.BLL.ReturnToVendor().GetRtvOrderList(setting);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 物料分拆  AKX
        /// </summary>
        /// <param name="qty"></param>
        /// <param name="grn"></param>
        /// <param name="Newgrn">目标GRN</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> MaterialPartition(string qty, string grn, string Newgrn)
        {
            List<MaterialUnitInfo> list = null;
            var userName = AccountController.GetCurrentUser().UserName;
            try
            {
                list = new LeanMES.Material.BLL.MaterialUnit().SplitMaterialUDP(qty, grn, Newgrn, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        //[AjaxMethod]
        //public void SaveMolding(MaterialMoldingInfo t)
        //{
        //    try
        //    {
        //        if (t == null)
        //            throw new Exception("保存失败!");

        //        t.ModifyBy = AccountController.GetCurrentUser().UserId;
        //        new LeanMES.Material.BLL.MaterialMolding().Save(t);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //}

        //[AjaxMethod]
        //public void DeleteMolding(string ids)
        //{
        //    try
        //    {
        //        new LeanMES.Material.BLL.MaterialMolding().Delete(ids);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //}

        //[AjaxMethod]
        //public void DeleteMoldingMember(string ids)
        //{
        //    try
        //    {
        //        new LeanMES.Material.BLL.MaterialMolding().DeleteMember(ids);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //}

        //[AjaxMethod]
        //public MaterialMoldingInfo GetMolding(int moldingId)
        //{
        //    try
        //    {
        //        return new LeanMES.Material.BLL.MaterialMolding().Get(moldingId);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //    return null;
        //}

        //[AjaxMethod]
        //public List<MaterialProcessInfo> GetMaterialProcess(int orderId)
        //{
        //    try
        //    {
        //        return new LeanMES.Material.BLL.MaterialMolding().GetMaterialProcess(orderId);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //    return null;
        //}

        //[AjaxMethod]
        //public MaterialMoldingMemberInfo CheckMemberSourceGRN(int orderId, int moldingMemberId, string sourceGRN)
        //{
        //    try
        //    {
        //        return new LeanMES.Material.BLL.MaterialMolding().CheckMemberSourceGRN(orderId, moldingMemberId, sourceGRN);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //    return null;
        //}

        //[AjaxMethod]
        //public MaterialMoldingMemberInfo GetMemberInfo(int memberId)
        //{
        //    try
        //    {
        //        return new LeanMES.Material.BLL.MaterialMolding().GetMemberInfo(memberId);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //    return null;
        //}

        //[AjaxMethod]
        //public MaterialUnitInfo PrintMoldingGRN(MaterialProcessInfo t)
        //{
        //    try
        //    {
        //        return new LeanMES.Material.BLL.MaterialMolding().AddMaterialProcess(t);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //    return null;
        //}


        /// <summary>
        /// add by zhi.li 20180703  获取在库存物料,验证物料
        /// </summary>
        /// <param name="Grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetItemIdByMaterialGRN(String Grn)
        {

            List<MaterialUnitInfo> list = null;
            try
            {
                list = new LeanMES.Material.BLL.MaterialUnit().GetItemIdByMaterialGRN(Grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        #region 根据工单显示工单领料信息
        /// <summary>
        /// add by weixia 显示工单的退料GRN信息
        /// </summary>
        /// <param name="Grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ReinspectionInfo> GetAllReturnMaterial(string prodOrder)
        {

            List<ReinspectionInfo> list = null;
            try
            {
                list = new LeanMES.Material.BLL.Reinspection().GetAllReturnMaterial(prodOrder);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 根据退料单显示退料单GRN信息
        /// <summary>
        /// add by weixia 显示工单的退料GRN信息
        /// </summary>
        /// <param name="Grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ReinspectionInfo> GetAllReturnGRN(string prodOrder)
        {

            List<ReinspectionInfo> list = null;
            try
            {
                list = new LeanMES.Material.BLL.Reinspection().GetAllReturnGRN(prodOrder);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region  检验扫描的清点GRN
        [AjaxMethod]
        public void CheckReturnApplyGRN(string prodOrder, string GRN, int GRNQty)
        {
            try
            {
                new LeanMES.Material.BLL.Reinspection().CheckReturnApplyGRN(prodOrder, GRN, GRNQty, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 获取 查GRN信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetGRNIsBoxIsGRN(string grn)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            try
            {
                list = new LeanMES.Material.BLL.Reinspection().GetGRNIsBoxIsGRN(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }





        #endregion

        #region  检验仓库确认的清点GRN
        [AjaxMethod]
        public void CheckConfrimGRN(string prodOrder, string GRN, int GRNQty, string cbarCode)
        {
            try
            {
                new LeanMES.Material.BLL.Reinspection().CheckConfrimGRN(prodOrder, GRN, GRNQty, AccountController.GetCurrentUser().UserName, cbarCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion


        #region  保存扫描的清点GRN
        [AjaxMethod]
        public void SaveReturnApplyGRN(string strJson)
        {
            try
            {
                new LeanMES.Material.BLL.Reinspection().SaveReturnApplyGRN(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region  保存扫描的清点GRN
        [AjaxMethod]
        public void SaveConfrimMaterial(string strJson)
        {
            try
            {
                new LeanMES.Material.BLL.Reinspection().SaveConfrimMaterial(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 根据供应商ID获取标准离线标签设置信息
        /// <summary>
        /// 根据供应商ID获取标准离线标签设置信息
        /// </summary>
        /// <param name="VendorID"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetOffLineLabel(string VendorCode)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                list = bllUnit.GetVendorOffLineLabel(VendorCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 标准离线条码登记
        /// <summary>
        /// 标准离线条码登记
        /// </summary>
        /// <param name="GRNInfoList"></param>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="bigCartonQty"></param>
        /// <param name="itemAllQty"></param>
        /// <param name="aPrintQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="VendorCode"></param>
        /// <param name="poCode"></param>
        /// <param name="factory"></param>
        /// <param name="remark"></param>
        /// <param name="RowId"></param>
        /// <param name="isSupplyPrint"></param>
        /// <param name="WeekCode"></param>
        /// <param name="MPN"></param>
        /// <param name="GRNString"></param>
        /// <param name="iqcOrder"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] SaveBZOfflineGenerateGRN(String GRNInfoList, int ItemId, decimal GRNQty, decimal MinQty, decimal bigCartonQty, decimal itemAllQty, decimal aPrintQty
            , string LotCode, string DateCode, string VendorCode, string poCode
            , string factory, string remark, int RowId, bool isSupplyPrint, string WeekCode, string MPN, string GRNString, string iqcOrder = "")
        {
            string[] str = new string[2];
            try
            {
                str = (new MaterialUnit()).SaveBZOfflineGenerateGRN(GRNInfoList, ItemId, GRNQty, MinQty, bigCartonQty, itemAllQty, aPrintQty,
                   LotCode, DateCode, VendorCode, AccountController.GetCurrentUser().UserName, poCode, factory, remark, RowId, isSupplyPrint, WeekCode, MPN, GRNString, iqcOrder);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        #endregion

        #region 保存导入GRN信息
        /// <summary>
        /// 保存导入GRN信息
        /// </summary>
        /// <param name="entityList"></param>
        [AjaxMethod]
        public void SaveImportGRN(String entityList)
        {
            try
            {
                (new MaterialUnit()).SaveImportGRN(entityList, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 物料条码以及箱号打印
        /// <summary>
        /// 物料条码以及箱号打印
        /// 黄亮 2018.08.21
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="bigCartonQty"></param>
        /// <param name="itemAllQty"></param>
        /// <param name="aPrintQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="VendorCode"></param>
        /// <param name="poCode"></param>
        /// <param name="factory"></param>
        /// <param name="remark"></param>
        /// <param name="RowId"></param>
        /// <param name="isSupplyPrint"></param>
        /// <param name="WeekCode"></param>
        /// <param name="MPN"></param>
        /// <param name="PackQty"></param>
        /// <param name="iqcOrder"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GenerateGRNAndPack(int ItemId, decimal GRNQty, decimal MinQty, decimal bigCartonQty, decimal itemAllQty, decimal aPrintQty
            , string LotCode, string DateCode, string VendorCode, string poCode
            , string factory, string remark, int RowId, bool isSupplyPrint, string WeekCode, string MPN, int PackGrnQty, string iqcOrder = "")
        {
            string[] str = new string[2];
            try
            {
                str = (new MaterialUnit()).GenerateGRNAndPack(ItemId, GRNQty, MinQty, bigCartonQty, itemAllQty, aPrintQty,
                   LotCode, DateCode, VendorCode, AccountController.GetCurrentUser().UserName, poCode, factory, remark, RowId, isSupplyPrint, WeekCode, MPN, PackGrnQty, iqcOrder);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        #endregion

        #region 查询可生成送货单的GRN
        /// <summary>
        /// 查询可生成送货单的GRN
        /// </summary>
        /// <param name="VendorCode"></param>
        /// <param name="DateFrom"></param>
        /// <param name="DateTo"></param>
        /// <param name="ItemId"></param>
        /// <param name="Carton"></param>
        /// <param name="GRN"></param>
        /// <param name="CreateBy"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> QueryDeliverGrn(string VendorCode, string DateFrom, string DateTo, int ItemId, string Carton, string GRN, string CreateBy)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                list = (new MaterialUnit()).QueryDeliverGrn(VendorCode, DateFrom, DateTo, ItemId, Carton, GRN, CreateBy);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 生成送货单并打印
        /// <summary>
        /// 生成送货单并打印
        /// </summary>
        /// <param name="VendorCode"></param>
        /// <param name="SerialNumberStr"></param>
        [AjaxMethod]
        public string SaveAndPrintDeliver(string VendorCode, string SerialNumberStr)
        {
            string str = "";
            try
            {
                str = (new MaterialUnit()).SaveAndPrintDeliver(VendorCode, SerialNumberStr, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        #endregion

        #region 客供料解析
        /// <summary>
        /// 客供料解析
        /// </summary>
        /// <param name="GRNInfoList"></param>
        /// <param name="ItemId"></param>
        /// <param name="VendorCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] SupplierMaterialPrint(String GRNInfoList, int ItemId, string VendorCode)
        {
            string[] str = new string[2];
            try
            {
                str = (new MaterialUnit()).SupplierMaterialPrint(GRNInfoList, ItemId, VendorCode, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        #endregion

        #region 查询可生成虚拟PO单的GRN
        /// <summary>
        /// 查询可生成虚拟PO单的GRN
        /// </summary>
        /// <param name="VendorCode"></param>
        /// <param name="DateFrom"></param>
        /// <param name="DateTo"></param>
        /// <param name="CreateBy"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> QueryVirtualPoGrn(string VendorCode, string DateFrom, string DateTo, string CreateBy)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                list = (new MaterialUnit()).QueryVirtualPoGrn(VendorCode, DateFrom, DateTo, CreateBy);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 生成虚拟采购订单
        /// <summary>
        /// 生成虚拟采购订单
        /// </summary>
        /// <param name="VenID"></param>
        /// <param name="VendorCode"></param>
        /// <param name="ReceiveType"></param>
        /// <param name="SerialNumberStr"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string SaveVirtualPo(int VenID, string VendorCode, string ReceiveType, string Remark, string SerialNumberStr, string SOCode)
        {
            string Po = "";
            try
            {
                Po = (new MaterialUnit()).SaveVirtualPo(VenID, VendorCode, ReceiveType, Remark, SerialNumberStr, AccountController.GetCurrentUser().UserName, SOCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return Po;
        }
        #endregion

        #region 校验物料编码是否存在
        /// <summary>
        /// 校验物料编码是否存在
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string VerifyItemCode(string ItemCode)
        {
            string ItemId = "";
            try
            {
                ItemId = (new MaterialUnit()).VerifyItemCode(ItemCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return ItemId;
        }
        #endregion

        #region 生成客供料
        /// <summary>
        /// 生成客供料
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="VendorCode"></param>
        /// <param name="poCode"></param>
        /// <param name="remark"></param>
        /// <param name="WeekCode"></param>
        /// <param name="MPN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GenerateSupplierMaterial(int ItemId, decimal GRNQty, decimal MinQty,
            string LotCode, string DateCode, string VendorCode, string poCode, string remark, string WeekCode, string MPN)
        {
            string[] str = new string[2];
            try
            {
                str = (new MaterialUnit()).GenerateSupplierMaterial(ItemId, GRNQty, MinQty, LotCode, DateCode, VendorCode,
                    AccountController.GetCurrentUser().UserName, poCode, remark, WeekCode, MPN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        #endregion

        #region 修改GRN状态
        /// <summary>
        /// 修改GRN状态
        /// </summary>
        /// <param name="GRN"></param>
        [AjaxMethod]
        public void UpdateGRNState(String GRN)
        {
            try
            {
                (new MaterialUnit()).UpdateGRNState(GRN, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 转移GRN数量
        /// <summary>
        /// 修改GRN状态
        /// </summary>
        /// <param name="GRN"></param>
        [AjaxMethod]
        public void GRNTransfer(string GRN, string TragetGRN, decimal Qty)
        {
            string UserName = AccountController.GetCurrentUser().UserName;
            try
            {
                (new MaterialUnit()).GRNTransfer(GRN, TragetGRN, Qty, UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion


        /// <summary>
        /// 编辑退料单信息
        /// </summary>
        /// <param name="json"></param>
        [AjaxMethod]
        public void WarehouseReturnSupplierEdit(string json)
        {
            try
            {
                new LeanMES.Material.BLL.ReturnToVendor().WarehouseReturnSupplierEdit(json);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取退料单明细信息
        /// </summary>
        /// <param name="json"></param>
        [AjaxMethod]
        public IList<ReturnToVendorDtlInfo> GetReturnToVendorDetailList(ReturnToVendorInfo entity)
        {
            try
            {
                entity.UpdateBy = AccountController.GetCurrentUser().UserName;
                return new LeanMES.Material.BLL.ReturnToVendor().GetReturnToVendorDetailList(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 锡膏条码解析
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [AjaxMethod]
        public MaterialPrint GetMaterialPrintInfo(string code)
        {
            MaterialPrint model = new MaterialPrint();
            try
            {
                Accessory bll = new Accessory();
                model.msg = "";
                string[] codelist = null;
                codelist = code.Split(';');
                //if (!(code.Contains("C") && code.Contains("Q")))
                //{
                //    model.msg = " 二维码错误，解析报错，禁止转码！";
                //    return model;
                //}
                int count = 0;
                DateTime ProdDate = new DateTime();
                foreach (var c in codelist)
                {
                    if (c.Substring(0, 1).Contains("O"))
                    {
                        count = count + 1;
                        model.OrderNO = c.Substring(1, c.Length - 1);
                    }
                    if (c.Substring(0, 1).Contains("C"))
                    {
                        count = count + 1;
                        model.ItemCode = c.Substring(1, c.Length - 1);
                        //查询ItemID
                        List<MaterialPrint> list = new List<MaterialPrint>();
                        list = bll.GetItemInfo(model.ItemCode);
                        if (list.Count <= 0)
                        {
                            model.msg = " 物料料号不存在系统中！";
                            return model;
                        }
                        else
                        {
                            model.ItemID = list[0].ItemID;
                            model.ItemName = list[0].ItemName;

                        }
                    }
                    if (c.Substring(0, 1).Contains("S"))
                    {
                        model.Scode = c.Substring(1, c.Length - 1);
                    }
                    if (c.Substring(0, 1).Contains("D"))
                    {
                        try
                        {
                            model.ProdDate = c.Substring(1, c.Length - 1);
                            model.ProdDate = model.ProdDate.Substring(0, 4) + "-" + model.ProdDate.Substring(4, 2) + "-" + model.ProdDate.Substring(6, 2);
                            ProdDate = DateTime.Parse(model.ProdDate);
                            //查询失效日期
                            model.StopTime = bll.SelectAccessoryExpiredDateByItemID(model.ItemID, ProdDate);
                        }
                        catch (Exception ex)
                        {
                            ProdDate = DateTime.Now;
                            model.ProdDate = DateTime.Now.ToString("yyyy-MM-dd");
                        }
                    }
                    if (c.Substring(0, 1).Contains("L"))
                    {
                        model.LotCode = c.Substring(1, c.Length - 1);
                    }
                    if (c.Substring(0, 1).Contains("Q"))
                    {
                        model.QTY = c.Substring(1, c.Length - 1);
                        if (int.Parse(model.QTY) <= 0)
                        {
                            model.msg = " 数据错误！";
                            return model;
                        }
                    }
                    if (c.Substring(0, 1).Contains("N"))
                    {
                        model.LNumber = c.Substring(1, c.Length - 1);
                    }

                }
                if (count < 2)
                {
                    model.msg = " 二维码错误，解析报错，禁止转码！";
                    return model;
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;
        }

        /// <summary>
        /// 根据 供应商代码  获取 客供料默认供应商名称
        /// </summary>
        /// <param name="SupplierCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public CustomerSupplierInfo CustomerSupplierInfoBySupplierCode(String SupplierCode)
        {
            CustomerSupplierInfo model = new CustomerSupplierInfo();
            try
            {
                model = (new MaterialUnit()).CustomerSupplierInfoBySupplierCode(SupplierCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;
        }
        /// <summary>
        /// 锡膏条码转换，加打印份数
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="VendorCode"></param>
        /// <param name="poCode"></param>
        /// <param name="remark"></param>
        /// <param name="WeekCode"></param>
        /// <param name="MPN"></param>
        /// <param name="QRCodeText"></param>
        /// <param name="txtSCode"></param>
        /// <param name="txtlNumber"></param>
        /// <param name="txtstopTime"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] AccessrySupplierMaterialGenerateCount(int ItemId, decimal GRNQty, decimal MinQty,
            string LotCode, string DateCode, string VendorCode, string poCode, string remark, string WeekCode, string MPN, string QRCodeText, string txtSCode, string txtlNumber, string txtstopTime, int GenerateCount)
        {
            string[] str = new string[2];
            try
            {
                str = (new MaterialUnit()).AccessrySupplierMaterialGenerateCount(ItemId, GRNQty, MinQty, LotCode, DateCode, VendorCode,
                    AccountController.GetCurrentUser().UserName, poCode, remark, WeekCode, MPN, QRCodeText, txtSCode, txtlNumber, txtstopTime, GenerateCount);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 依据采购单号查询采购订单明细
        /// </summary>
        /// <param name="poOrder">采购订单号</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetAllItemByVendor(string poOrder)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            var querySql = "select ItemId, ItemName, VenCode,ItemCode,POorder,BuyQty,RowID,MinPackQty,ItemSpec from vwVendorPart where POorder=@POorder";

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@POorder",SqlDbType.VarChar,100) { Value = poOrder}
            };
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, querySql, parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.ItemId = rdr.GetInt32(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.VendorCode = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.POorder = rdr.GetString(4);
                    entity.BuyQty = rdr.GetDecimal(5);
                    entity.RowId = rdr["RowID"].ToString();
                    entity.MinPackQty = rdr.GetDecimal(7);
                    entity.ItemSpec = rdr.GetString(8);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 验证条码是否存在包装箱
        /// </summary>
        /// <param name="idString"></param>
        [AjaxMethod]
        public DataTable CheckGrnIsPacking(String idString)
        {
            DataTable dt = null;
            try
            {
                MaterialUnit bll = new MaterialUnit();
                dt = bll.CheckGrnIsPacking(idString);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }
        /// <summary>
        /// 获取物料状态 
        /// </summary>
        /// <param name="serialNumber">物料条码</param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetMateriaStatus(string serialNumber)
        {
            MaterialUnit bll = new MaterialUnit();
            return bll.GetMateriaStatus(serialNumber);
        }


        /// <summary>
        /// 检查并获取GRN信息 PDA
        /// </summary>
        [AjaxMethod]
        public string CheckGrnRTWPDA(string returnOrder, string grn)
        {
            var strInfo = "";
            try
            {
                strInfo = (new LeanMES.Material.BLL.Material()).CheckGrnReturnWarehousePDA(returnOrder, grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strInfo;
        }

        /// <summary>
        /// 保存仓库退料入料 PDA
        /// </summary>
        [AjaxMethod]
        public void SaveRTWPDA(string returnNo, string strGrns, string cBarcode)
        {
            try
            {
                (new LeanMES.Material.BLL.Material()).SaveGrnReturnWarehousePDA(returnNo, strGrns, cBarcode, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 导入急料信息
        /// </summary>
        /// <param name="ShortageXml"></param>
        [AjaxMethod]
        public void ImportUrgentMaterial(string ShortageXml)
        {
            var UserName = AccountController.GetCurrentUser().UserName;
            SqlParameter[] parms = new SqlParameter[]{
                            new SqlParameter("@UserName", SqlDbType.NVarChar,50),
                            new SqlParameter("@ShortageXml", SqlDbType.NVarChar)
                            };

            try
            {
                parms[0].Value = UserName;
                parms[1].Value = ShortageXml;

                SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "uspImportUrgentMaterial", parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        #region 仓库退供应商限制需加上采购单上已退物料
        /// <summary>
        /// 保存仓库退料入料 PDA
        /// </summary>
        [AjaxMethod]
        public void ValidReturnMaterialUnit(string poCode, string itemCode, int lineID, decimal itemQty, decimal returnQty)
        {
            try
            {
                (new LeanMES.Material.BLL.Material()).ValidReturnMaterialUnit(poCode, itemCode, lineID, itemQty, returnQty);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion


        /// <summary>
        /// 依据采购单号查询采购订单明细
        /// </summary>
        /// <param name="poOrder">采购订单号</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetAllItemByPoCode(string poOrder, string rowId)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            var querySql = "select ItemId, ItemName, VenCode,ItemCode,POorder,BuyQty,RowID,MinPackQty,ItemSpec from vwVendorPart where POorder=@POorder AND RowID = @RowID";

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@POorder",SqlDbType.VarChar,100) { Value = poOrder},
                new SqlParameter("@RowID",SqlDbType.VarChar) { Value = rowId}
            };
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, querySql, parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.ItemId = rdr.GetInt32(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.VendorCode = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.POorder = rdr.GetString(4);
                    entity.BuyQty = rdr.GetDecimal(5);
                    entity.RowId = rdr["RowID"].ToString();
                    entity.MinPackQty = rdr.GetDecimal(7);
                    entity.ItemSpec = rdr.GetString(8);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        [AjaxMethod]
        public string CheckGRNIsIsLineMaterial(string grn)
        {
            try
            {
                return (new MaterialUnit()).CheckGRNIsIsLineMaterial(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return "";
        }

    }
}