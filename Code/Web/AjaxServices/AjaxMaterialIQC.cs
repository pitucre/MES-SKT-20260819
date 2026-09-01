using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data;
using System.Xml;
using SKT.LeanMES.Model;
using SKT.Common.Model;
using System.Data.SqlClient;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaterialIQC
    {
        /// <summary>
        ///  IQC检验处理
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="ManageResult">1：特采、3：退货</param>
        [AjaxMethod]
        public void MaterialIQCFormAttend(String idString, int ManageResult)
        {
            try
            {
                (new MaterialIQC()).MaterialIQCFormAttend(idString, ManageResult, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 根据检验单ID获取检验单GRN信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIQCFormGrn(int intIqcId)
        {
            string str = "";
            try
            {
                str = (new MaterialIQC()).GetIQCFormGrn(intIqcId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        /// <summary>
        /// 保存IQC检验处理挑选结果
        /// </summary>
        /// <param name="strJson"></param>
        [AjaxMethod]
        public void SaveIQCFormAttendGRN(string strJson)
        {
            try
            {
                (new MaterialIQC()).SaveIQCFormAttendGRN(strJson);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 根据检验单ID和GRN获取检验单GRN信息。
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetMaterialIQCHandleGrn(string strGrn, Int32 intIqcId)
        {
            DataTable dt = new DataTable();
            try
            {
                dt = (new MaterialIQCHandleGrn()).GetMaterialIQCHandleGrn(strGrn, intIqcId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return SKT.LeanMES.Web.AppCode.Utility.ConvertJson.ToJson(dt);
        }

        //获取交接确认的IQC单据信息
        [AjaxMethod]
        public string GetShowIQCConfirmDetail(string InspectionNo)
        {
            string str = "";
            try
            {
                str = (new MaterialIQC()).GetShowIQCConfirmDetail(InspectionNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        //保存交接确认
        [AjaxMethod]
        public void SaveIQCConfirmDetail(string InspectionNo)
        {
            string userName = SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName;
            try
            {
                (new MaterialIQC()).SaveIQCConfirmDetail(InspectionNo, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        //保存挑选（输入数量）
        [AjaxMethod]
        public void SaveIQCChooseQtyInfo(string strJson)
        {
            try
            {
                (new MaterialIQC()).SaveIQCChooseQtyInfo(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 根据IQC检验单ID，获取IQC检验单入库数量
        /// </summary>
        /// <param name="intIqcId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIQCStorageQty(Int64 intIqcId)
        {
            string str = "";
            try
            {
                str = (new MaterialIQCHandleGrn()).GetIQCStorageQty(intIqcId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        [AjaxMethod]
        public string GetIQCScanGRNInfo(Int64 intIqcId, String grn, Int32 IsAll)
        {
            string str = "";
            try
            {
                str = (new MaterialIQC()).GetIQCScanGRNInfo(intIqcId, grn, IsAll);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 检验库位条码是否正确
        /// </summary>
        /// <param name="barCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetBarCode(string barCode)
        {
            string str = "";
            try
            {
                str = (new MaterialIQCHandleGrn()).GetBarCode(barCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 检验库位条码是否正确
        /// </summary>
        /// <param name="barCode"></param>
        /// <param name="warehouseName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetBarCode2(string barCode, string warehouseName)
        {
            string str = "";
            try
            {
                str = (new MaterialIQCHandleGrn()).GetBarCode(barCode, warehouseName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 检验仓库条码是否正确
        /// </summary>
        /// <param name="barCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetWarehouseCode(string barCode)
        {
            string str = "";
            try
            {
                str = (new MaterialIQCHandleGrn()).GetWarehouseCode(barCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        //保存物料入库(扫描数量)
        [AjaxMethod]
        public void SaveIQCGRNStorageQty(string strJson)
        {
            try
            {
                new MaterialIQC().SaveIQCGRNStorageQty(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        //保存物料入库（扫描物料条码）
        [AjaxMethod]
        public void SaveIQCGRNStorage(string strJson)
        {
            try
            {
                new MaterialIQC().uspSaveIQCGRNStorage(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// PDA物料入库
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public string PDASaveIQCGRNStorage(MaterialIQCInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                return new MaterialIQC().PDASaveIQCGRNStorage(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return string.Empty;
            }
        }


        /// <summary>
        /// 解析XML格式文本
        /// </summary>
        /// <param name="strXml">XML格式字符串</param>
        /// <param name="nodeName">需要得到的节点值</param>
        /// <returns></returns>
        public string ReadParseXml(string strXml, string nodeName)
        {
            using (System.IO.StringReader strRdr = new System.IO.StringReader(strXml))
            {
                //通过XmlReader.Create静态方法创建XmlReader实例 
                using (XmlReader rdr = XmlReader.Create(strRdr))
                {
                    //循环Read方法直到文档结束 
                    while (rdr.Read())
                    {
                        //如果是开始节点 
                        if (rdr.NodeType == XmlNodeType.Element)
                        {
                            //通过rdr.Name得到节点名 
                            string elementName = rdr.Name;

                            if (elementName == nodeName)
                            {
                                if (rdr.Read())
                                {
                                    return rdr.Value;
                                }
                            }
                        }
                    }
                }
            }
            Console.Read();
            return "";
        }

        /// <summary>
        /// 获取入库编码
        /// </summary>
        /// <param name="strJson"></param>
        [AjaxMethod]
        public string GetMaterialStorageNo(int serialNumberType)
        {
            string materialStorageNo = "";
            MaterialUnit bll = new MaterialUnit();
            try
            {
                materialStorageNo = bll.GetMaterialStorageNo(serialNumberType);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return materialStorageNo;
        }
        /*********PDA**add chenglong.zhu*******/
        /// <summary>
        /// 判断grn是否属于该采购单号
        /// </summary>
        /// <param name="purchaseNo">采购单号</param>
        /// <param name="GRN">GRN</param>
        /// <returns></returns>
        //[AjaxMethod]
        //public MaterialIQCInfo IsGRN(string purchaseNo, string GRN)
        //{
        //    MaterialIQCInfo model = new MaterialIQCInfo();
        //    MaterialIQC bll = new MaterialIQC();
        //    try
        //    {
        //        model = bll.IsGRN(purchaseNo, GRN);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //    return model;
        //}
        [AjaxMethod]
        public List<MaterialIQCInfo> IsGRN(string purchaseNo, string GRN, string station, int putOnShelf)
        {
            List<MaterialIQCInfo> model = new List<MaterialIQCInfo>();
            MaterialIQC bll = new MaterialIQC();
            try
            {
                model = bll.IsGRN(purchaseNo, GRN, station, putOnShelf);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;
        }
        [AjaxMethod]
        public string IsPack(string GRN)
        {
            string num = "";
            MaterialIQC bll = new MaterialIQC();
            try
            {
                var list=bll.IsPack(GRN);
                num = list.FirstOrDefault();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return num;
        }
        /*******************************/
        [AjaxMethod]
        public string Select(string orderno, int pageNo)
        {
            string result = "";
            int rowCount = 0;
            MaterialIQC m = new MaterialIQC();
            IList<MaterialIQCInfo> list = m.GetSourceListInfo(orderno, pageNo, ref rowCount);
            if (list.Count > 0)
            {
                result = "[{\"rowCount\":\"" + rowCount + "\"}," + Newtonsoft.Json.JsonConvert.SerializeObject(list).Replace("[", "");
            }
            else
            {
                throw new Exception("未获取到检验单信息");
            }
            return result;
        }
        [AjaxMethod]
        public string SelectByGRN(string grn)
        {
            string result = "";
            int rowCount = 0;
            MaterialIQC m = new MaterialIQC();
            IList<MaterialIQCInfo> list = m.GetSourceListInfoByGRN(grn);
            if (list.Count > 0)
            {
                result = "[{\"rowCount\":\"" + rowCount + "\"}," + Newtonsoft.Json.JsonConvert.SerializeObject(list).Replace("[", "");
            }
            else
            {
                throw new Exception("未获取到检验单信息");
            }
            return result;
        }

        /// <summary>
        /// 获取IQC退货信息
        /// </summary>
        [AjaxMethod]
        public string GetIqcReturnInfo(string IqcNo)
        {
            try
            {
                return (new MaterialIQC()).GetIqcReturnInfo(IqcNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return ex.Message;
            }
        }

        /// <summary>
        /// 保存生成IQC退货单
        /// </summary>
        [AjaxMethod]
        public void SaveIqcReturn(string strJSON)
        {
            try
            {
                (new MaterialIQC()).SaveIqcReturn(strJSON);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
        }

        /// <summary>
        /// 确认IQC退货
        /// </summary>
        [AjaxMethod]
        public void ConfirmIqcReturn(MaterialIQCInfo entity, int returnMode)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                (new MaterialIQC()).ConfirmIqcReturn(entity, returnMode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取IQC退货信息
        /// </summary>
        [AjaxMethod]
        public string GetIqcFormGrnBack(int ReturnId)
        {
            try
            {
                return (new MaterialIQC()).GetIQCFormGrnBack(ReturnId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return ex.Message;
            }
        }

        /// <summary>
        /// IQC退料列表-查看功能
        /// </summary>
        [AjaxMethod]
        public string GetIqcFormGrnReturn(int ReturnId)
        {
            try
            {
                return (new MaterialIQC()).GetIqcFormGrnReturnDal(ReturnId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return ex.Message;
            }
        }

        [AjaxMethod]
        public void InspectionFileSave(string itemcode, string suppliercode, string filename, string username)
        {
            try
            {
                new MaterialIQC().SaveFileManage(itemcode, suppliercode, filename, username);
            }
            catch (Exception ex)
            {

                throw;
            }
        }


        [AjaxMethod]
        public void DeleteSysUpLoadFileFile(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "uspUpLoadFileDelete");
        }

        [AjaxMethod]
        public List<InspectionFileManageInfo> GetFileInfo(string itemcode, string InspectionNo = "", string SupplierCode = "")
        {
            try
            {
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.ExtensionCondition = "(ItemCode = '" + itemcode + "' and SupplierCode = '" + SupplierCode + "' and FromCode ='') ";
                if (InspectionNo != "")
                {
                    searchSettings.ExtensionCondition = searchSettings.ExtensionCondition + " OR FromCode = '" + InspectionNo + "'";
                }
                return new MaterialIQC().GetFileInfo(0, 1000, "CreateDateTime desc", searchSettings);
            }
            catch (Exception ex)
            {

                throw;
            }
        }


        /// <summary>
        /// 入库打印记录
        /// </summary>
        /// <param name="barCode"></param>
        /// <param name="warehouseName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void MaterialStorageEdit(int intId, int isRePrint)
        {
            try
            {
                (new MaterialIQC()).MaterialStorageEdit(intId, isRePrint, AccountController.GetCurrentUser().UserName, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// IQC接收
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void IQCRecive(MaterialIQCInfo entity)
        {
            try
            {
                if (entity == null)
                {
                    return;
                }
                entity.ReciveBy = AccountController.GetCurrentUser().UserName;
                (new MaterialIQC()).IQCRecive(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// IQC接收
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void IQCBatchRecive(string Ids)
        {
            try
            {
                if (string.IsNullOrEmpty(Ids))
                {
                    return;
                }
                var ReciveBy = AccountController.GetCurrentUser().UserName;
                SqlParameter[] array = new SqlParameter[]
               {
                    new SqlParameter("@Ids", SqlDbType.VarChar),
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
               };
                array[0].Value = Ids;
                array[1].Value = ReciveBy;
                ComMethod.Edit("uspIQCBatchRecive", array);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }



        /// <summary>
        /// 验证IQC检验是否已经接收
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void ValidateIQCRecived(MaterialIQCInfo entity)
        {
            try
            {
                if (entity == null)
                {
                    return;
                }
                entity.ReciveBy = AccountController.GetCurrentUser().UserName;
                (new MaterialIQC()).ValidateIQCRecived(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// IQC审核
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void IQCVerify(MaterialIQCInfo entity)
        {
            try
            {
                if (entity == null)
                {
                    return;
                }
                entity.VerifyBy = AccountController.GetCurrentUser().UserName;
                (new MaterialIQC()).IQCVerify(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据IQC Id 获取IQC检验单信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public MaterialIQCInfo GetEntity(MaterialIQCInfo entity)
        {
            try
            {
                if (entity == null)
                {
                    return null;
                }
                return (new MaterialIQC()).GetEntity(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// MRB审核
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void MRBVerify(MaterialIQCInfo entity)
        {
            try
            {
                if (entity == null)
                {
                    return;
                }
                entity.MRBVerifyBy = AccountController.GetCurrentUser().UserName;
                (new MaterialIQC()).MRBVerify(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// MRB撤回
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void MRBWithdraw(MaterialIQCInfo entity)
        {
            try
            {
                if (entity == null)
                {
                    return;
                }
                entity.MRBVerifyBy = AccountController.GetCurrentUser().UserName;
                (new MaterialIQC()).MRBWithdraw(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 获取MRB明细信息
        /// </summary>
        /// <param name="IQCNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public IList<MaterialIQCInfo> GetMRBGRNList(MaterialIQCInfo entity)
        {
            try
            {
                return new MaterialIQC().GetMRBGRNList(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// MRB结案
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void RMBCloseCase(MaterialIQCInfo entity)
        {
            try
            {
                if (entity == null)
                {
                    return;
                }
                entity.CloseCaseBy = AccountController.GetCurrentUser().UserName;
                (new MaterialIQC()).RMBCloseCase(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// MRB处理检查
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void CheckMRBEnd(string QCOrderId)
        {
            try
            {
                if (string.IsNullOrEmpty(QCOrderId))
                {
                    return;
                }

                (new MaterialIQC()).CheckMRBEndDal(QCOrderId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 得到库位
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetCbarcodeListbyGrn(string Grn)
        {
            string Cbarcode = "";
            try
            {
                List<MaterialCbarcode> list = new List<MaterialCbarcode>();
                list = new MaterialUnit().GetCbarcodeListbyGrn(Grn);
                if (list.Count <= 0)
                {
                    Cbarcode = ""; ;
                }
                else
                {
                    if (list.Count > 2)
                    {
                        for (int i = 0; i < 3; i++)
                        {
                            if (!Cbarcode.Contains(list[i].cbarcode + ","))
                            {
                                Cbarcode += list[i].cbarcode + ",";
                            }
                        }
                    }
                    else
                    {
                        foreach (var r in list)
                        {
                            if (!Cbarcode.Contains(r.cbarcode + ","))
                            {
                                Cbarcode += r.cbarcode + ",";
                            }
                        }
                    }
                }
                if (Cbarcode.Length > 0)
                {
                    Cbarcode = Cbarcode.Substring(0, Cbarcode.Length - 1);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return Cbarcode;
        }
        /// <summary>
        /// 根据退料单查询物料信息
        /// </summary>
        /// <param name="ReturnNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialWhReturn> SelectMaterialWhReturnByNo(string ReturnNo)
        {
            List<MaterialWhReturn> list = new List<MaterialWhReturn>();
            try
            {
                list = new MaterialUnit().SelectMaterialWhReturnByNo(ReturnNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ReturnToWarehouseDtlTemp> SelectReturnToWarehouseDtlTemp()
        {
            List<ReturnToWarehouseDtlTemp> list = new List<ReturnToWarehouseDtlTemp>();
            try
            {
                string userName = SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName;
                list = new MaterialUnit().SelectReturnToWarehouseDtlTemp(userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        [AjaxMethod]
        public void SaveReturnToWarehouseDtlTemp(string orderNo, string grn, string station)
        {
            try
            {
                string userName = SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName;
                new MaterialUnit().SaveReturnToWarehouseDtlTemp(orderNo, grn, userName, station);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ReturnToWarehouseDtlTemp> DeleteReturnToWarehouseDtlTempGRN(string orderNo, string grn)
        {
            List<ReturnToWarehouseDtlTemp> list = new List<ReturnToWarehouseDtlTemp>();
            try
            {
                string userName = SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName;
                list = new MaterialUnit().DeleteReturnToWarehouseDtlTempGRN(orderNo, grn, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        [AjaxMethod]
        public void DeleteReturnToWarehouseDtlTemp()
        {
            try
            {
                string userName = SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName;
                new MaterialUnit().DeleteReturnToWarehouseDtlTemp(userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ReturnToWarehouseDtlTemp> SelectReturnToWarehouseDtlTempHave(string number)
        {
            List<ReturnToWarehouseDtlTemp> list = new List<ReturnToWarehouseDtlTemp>();
            try
            {
                list = new MaterialUnit().SelectReturnToWarehouseDtlTempHave(number);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// PDA调拨入库
        /// </summary>
        /// <param name="strJson"></param>
        [AjaxMethod]
        public string PDASaveTransferIn(int TransfersId, string TransfersNo, string UserName, string TransferDtlMaterial, string TransferInShelfGRN)
        {
            try
            {
                UserName = AccountController.GetCurrentUser().UserName;
                return new MaterialIQC().PDASaveTransferIn(TransfersId, TransfersNo, UserName, TransferDtlMaterial, TransferInShelfGRN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return string.Empty;
            }
        }

    }
}