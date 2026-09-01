using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using System.Xml;
using Newtonsoft.Json;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Web.Material;
using SKT.LeanMES.Model;
using SKT.Common.DAL.Marshal;
using System.Data;
using System.Data.SqlClient;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaterialApply
    {
        /// <summary>
        /// 领料申请 新增、修改
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void MaterialApplyEdit(string strJson)
        {
            try
            {
                Apply bll = new Apply();
                bll.Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 领料申请 新增、修改
        /// </summary>
        /// <param name="entity"></param>
        ///<param name="detailStrJson"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void ApplyEdit(string enJSON, string dtlJson)
        {
            try
            {
                Apply bll = new Apply();

                ApplyInfo entity = new ApplyInfo();
                entity = JsonConvert.DeserializeObject<ApplyInfo>(enJSON);

                bll.Edit(entity, dtlJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 编辑领料申请-根据选择的领料申请ID获取领料申请单详细
        /// </summary>
        /// <param name="supplierDeliveryId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetMaterialApply(string applyId)
        {
            string strJson = "";
            try
            {
                strJson = new Apply().GetMaterialApply(applyId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        /// <summary>
        /// 领料申请时，根据选择的生产投料单，自动带出所有物料信息
        /// </summary>
        /// <param name="moCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[][] MaterialApplyAllItem(string moCode)
        {
            try
            {
                return (new Apply()).MaterialApplyAllItem(moCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 根据选择的领料单获取物料信息
        /// </summary>
        /// <param name="formNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ApplyDtlInfo> GetApplyDtlList(int applyID)
        {
            List<ApplyDtlInfo> list = null;
            try
            {
                ApplyDtl bll = new ApplyDtl();
                list = bll.GetMaterialPrepareItem(applyID);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        #region PDA
        [AjaxMethod]
        public List<ApplyInfo> GetWorkOrderInfo(string No)
        {
            try
            {
                List<ApplyInfo> list = new ApplyDtl().GetWorkOrderInfo(No);
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="WorkOrderNo">工单号</param>
        /// <param name="ApplyNo">领料单</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ApplyDtlInfo> GetMaterialPrepareInfo(string WorkOrderNo, string ApplyNo)
        {
            List<ApplyDtlInfo> list = new ApplyDtl().GetMaterialPrepareInfo(WorkOrderNo, ApplyNo);
            return list;
        }
        #endregion
        /// <summary>
        /// 根据选择的领料单获取物料信息 PDA分页查询
        /// </summary>
        /// <param name="formNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetApplyDtlLists(string formNumber, int pageNo)
        {
            int rowCount = 0;
            List<ApplyDtlInfo> list = null;
            try
            {
                ApplyDtl bll = new ApplyDtl();
                list = bll.GetMaterialPrepareItem(pageNo, 4, "", formNumber, ref rowCount);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            if (list.Count > 0)
            {
                return "[{\"rowCount\":\"" + rowCount + "\"}," + Newtonsoft.Json.JsonConvert.SerializeObject(list).Replace("[", "");
            }
            else
            {
                throw new Exception("未查询到数据");
            }

        }
        /// <summary>
        /// 领料单打印资料获取
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetApplyPrint(Int32 intId)
        {
            string strJson = "";
            try
            {
                strJson = (new Apply()).GetApplyPrint(intId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        /// <summary>
        /// 检验物料备料GRN信息是否正确
        /// </summary>
        /// <param name="ItemStr"></param>
        /// <param name="grn"></param>
        /// <param name="flage"></param>
        /// <param name="grnStr"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> CheckGrnMaterialPrepare(String ItemStr, String grn, Int32 flage, String grnStr)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                list = new Apply().CheckGrnMaterialPrepare(ItemStr, grn, flage, grnStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 保存 物料备料
        /// </summary>
        [AjaxMethod]
        public string SaveMaterialPrepare(string materialStorageNo, Int32 RequestId, Int32 selLocation, string locDesc, String grnStr, String userName, string strJson, string FLGrnStr,int ProductMinNumType,int Isexceed)
        {
            string FLgrn = "";
            try
            {

                LeanMES.Material.BLL.Material bll = new LeanMES.Material.BLL.Material();
                FLgrn = bll.SaveMaterialPrepare(RequestId, selLocation, locDesc, grnStr, userName, materialStorageNo, FLGrnStr, ProductMinNumType, Isexceed);//有GRN备料
                bll.SaveMaterialPrepare(strJson);//无GRN备料
                //}
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return FLgrn;
        }


        /// <summary>
        /// 发料交接确认操作
        /// </summary>
        /// <param name="deliverCode"></param>
        [AjaxMethod]
        public void SaveApplyMaterialHandover(string applyId)
        {
            try
            {
                new Apply().SaveApplyMaterialHandover(applyId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据GRN获取数量
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public Decimal GetGrnQuantiyByGrn(string grn)
        {
            Decimal qty = 0;
            try
            {
                qty = (new LeanMES.Material.BLL.Material()).GetGrnQuantiyByGrn(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return qty;
        }

        /// <summary>
        /// 根据GRN获取信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string GetInfoByGrnReturn(string grn)
        {
            try
            {
                return (new LeanMES.Material.BLL.Material()).GetInfoByGrnReturn(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }

        /// <summary>
        /// 生成退料单8.5  批量GRN退
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public void SaveGrnsReturn(string grns, string depId, string user)
        {
            try
            {
                (new LeanMES.Material.BLL.Material()).SaveMaterialReturn(grns, depId, user);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 生产退料-生成退料单
        /// </summary>
        /// <param name="grn">物料条码</param>
        /// <param name="depId">部门ID</param>
        /// <param name="qty">数量</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> SaveMaterialReturn(String grn, int depId, int qty)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                LeanMES.Material.BLL.Material bll = new LeanMES.Material.BLL.Material();
                list = bll.SaveMaterialReturn(grn, Convert.ToDecimal(qty), depId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 根据GRN获取数量
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public String GetGrnQuantiyByGrnBar(string grn, string barCode)
        {
            try
            {
                return (new LeanMES.Material.BLL.Material()).GetGrnQuantiyByGrnBar(grn, barCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 仓库退料-确认退料操作,退料到库位
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public void MaterialReturn2Warehouse(String grns, String warCode)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                LeanMES.Material.BLL.Material bll = new LeanMES.Material.BLL.Material();
                bll.SaveReturn2Warehouse(grns, warCode, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        /// <summary>
        /// 仓库退料-确认退料操作
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="depId"></param>
        /// <param name="qty"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> SureMaterialReturn(String grn, String warCode, int qty)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                LeanMES.Material.BLL.Material bll = new LeanMES.Material.BLL.Material();
                list = bll.SureMaterialReturn(grn, warCode, Convert.ToDecimal(qty), AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /*

  
        /// <summary>
        /// 保存检验结果
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        /// <param name="checkResult"></param>
        /// <param name="remark"></param>
        [AjaxMethod]
        public void SaveCheckResult(String idString,String checkResult, String remark)
        {
            try
            {
                (new MaterialReturn()).SaveCheckResult(idString, AccountController.GetCurrentUser().UserName, checkResult, remark);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

 
        /// <summary>
        /// 根据检验单获取GRN信息
        /// </summary>
        /// <param name="InspectionId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetProdMaterialIQCGrn(int InspectionId)
        {
            string strJson = "";
            try
            {
                strJson = new MaterialIQC().GetProdMaterialIQCGrn(InspectionId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        /// <summary>
        /// 根据产品序列号获取产品信息
        /// </summary>
        /// <param name="productSN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetProductInfo(string productSN)
        {
            string strJson = "";
            try
            {
                strJson = new ProductStorage().GetProductInfo(productSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        /// <summary>
        /// 保存产品入库信息
        /// </summary>
        /// <param name="strJson"></param>
        [AjaxMethod]
        public void SaveProductStorage(String strJson)
        {
            try
            {
                (new ProductStorage()).Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 备货确认-根据出货单ID获取产品信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetProductPrepareItem(int id, string code)
        {
            string strJson = "";
            try
            {
                strJson = new ProductPrepare().GetProductPrepareItem(id, code);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        /// <summary>
        /// 备货确认-保存操作
        /// </summary>
        /// <param name="strJson"></param>
        [AjaxMethod]
        public void SaveProductPrepare(string strJson)
        {
            try
            {
                ProductPrepare bll = new ProductPrepare();
                bll.Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

         
        /// <summary>
        /// 备料回写ERP
        /// </summary>
        /// <param name="RequestId">领料申请单ID</param>
        /// <param name="grnStr">GRN集合</param>
        /// <param name="strJson"></param>
        /// <returns></returns>
        public string ErpPrepareService(string materialStorageNo, Int32 RequestId, String grnStr, string strJson)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            string employeeCName = AccountController.GetCurrentUser().EmployeeCName;
            string strValue;
            MaterialPrepare bll = new MaterialPrepare();
            //根据领料单ID查询领料单信息
            ApplyInfo applyEntity = bll.GetApplyService(RequestId);
            if (applyEntity == null || string.IsNullOrEmpty(applyEntity.ApplyNo))
            {
                if (string.IsNullOrEmpty(applyEntity.MOCode))
                {
                    //判断是否手工增单  不回写
                    return "";
                }
                else
                {
                    return "回写失败，没有找到相应的领料单信息";
                }
            }
            strValue = @"<?xml version=""1.0"" encoding=""GB2312""?>";
            strValue += @"<Bill><Rows><FTransSystemNumber>MES</FTransSystemNumber><FAcctNo>10.01</FAcctNo><FTransType>领料出库单</FTransType> ";
            strValue += @"<FTransBillNo>" + materialStorageNo + "</FTransBillNo>";//备料单号
            strValue += @"<FDate>" + applyEntity.CreateDateTime.ToString("yyyy-MM-dd") + "</FDate>";
            strValue += @"<FUser>" + employeeCName + "</FUser>";
            strValue += @"<FChecker>" + employeeCName + "</FChecker>";
            strValue += @"<FICMOBillNo>" + applyEntity.MOCode + "</FICMOBillNo>";
            strValue += @"<FSupplyNo></FSupplyNo>";//供应商编码  
            strValue += @"<FSupplyName></FSupplyName>";//供应商名称
            strValue += @"<FDeptNo>" + applyEntity.DepCode + "</FDeptNo>";
            strValue += @"<FDeptName>" + applyEntity.DepName + "</FDeptName>";

            strValue += @"<FFManagerNo>" + userName + "</FFManagerNo>";
            strValue += @"<FFManagerName>" + employeeCName + "</FFManagerName>";
            strValue += @"<FSManagerNo>" + userName + "</FSManagerNo>";
            strValue += @"<FSManagerName>" + employeeCName + "</FSManagerName>";
           
            strValue += @"<FNote></FNote><Entry>";

            //无GRN入库
            ApplyInfo apply = ComMethod.JsonToEntity<ApplyInfo>(strJson);
            string strDtl = apply.tbDtl;
            List<ApplyDtlInfo> applyDtlList = ComMethod.JsonToEntities<ApplyDtlInfo>(strDtl);
            int tempInt = 1;
            for (int i = 0; i < applyDtlList.Count; i++)
            {
                ApplyDtlInfo itemEntity = bll.GetItemService(applyDtlList[i].ItemId);
                if (itemEntity == null || string.IsNullOrEmpty(itemEntity.ItemCode))
                {
                    return "回写失败，获取物料信息失败";
                }
                ApplyDtlInfo whEntity = bll.GetWhService(applyDtlList[i].WHouse);
                if (whEntity == null || string.IsNullOrEmpty(whEntity.CWhCode))
                {
                    return "回写失败，获取仓库信息失败";
                }
                strValue += @"<Rows><FEntryID>" + tempInt.ToString() + "</FEntryID>";
                strValue += @"<FItemNo>" + itemEntity.ItemCode + "</FItemNo>";//产品代码
                strValue += @"<FBatchNo>001</FBatchNo>";//批号
                strValue += @"<FUnitName>" + itemEntity.Units + "</FUnitName>";//计量单位名称
                strValue += @"<FQty>" + applyDtlList[i].WHouseNum + "</FQty>";//收货数量
                strValue += @"<FAuxPrice>" + 0 + "</FAuxPrice>";//单价  中间库没有数据
                strValue += @"<FAmount>" + 0 + "</FAmount>";//金额   中间库没有数据
                strValue += @"<FDCStockNo>" + whEntity.CWhCode + "</FDCStockNo>";//收货仓库编码
                strValue += @"<FDCStockName>" + whEntity.CWhName + "</FDCStockName>";//收货仓库名称
                strValue += @"<FDCSPName>" + whEntity.cStoreName + "</FDCSPName>";//仓位名称
                strValue += @"<FNote></FNote></Rows>";
                tempInt++;
            }
            //有GRN入库
            string[] arrGrn = grnStr.Split(',');
            for (int i = 0; i < arrGrn.Length; i++)
            {
                if (arrGrn[i] != "")
                {
                    ApplyDtlInfo itemEntity = bll.GetItemServiceByGRN(arrGrn[i]);
                    if (itemEntity == null || string.IsNullOrEmpty(itemEntity.ItemCode))
                    {
                        return "回写失败，获取物料信息失败";
                    }
                    string CWhCode = "";
                    string CWhName = "";
                    string cStoreName = "";
                    if (itemEntity.WHouse != "")
                    {
                        ApplyDtlInfo whEntity = bll.GetWhService(itemEntity.WHouse);
                        if (whEntity == null || string.IsNullOrEmpty(whEntity.CWhCode))
                        {
                            return "回写失败，获取仓库信息失败";
                        }
                        CWhCode = whEntity.CWhCode;
                        CWhName = whEntity.CWhName;
                        cStoreName = whEntity.cStoreName;
                    }
                    strValue += @"<Rows><FEntryID>" + tempInt.ToString() + "</FEntryID>";
                    strValue += @"<FItemNo>" + itemEntity.ItemCode + "</FItemNo>";//产品代码
                    strValue += @"<FBatchNo>" + itemEntity.cBarCode + "</FBatchNo>";//批号
                    strValue += @"<FUnitName>" + itemEntity.Units + "</FUnitName>";//计量单位名称
                    strValue += @"<FQty>" + itemEntity.BalanceQty + "</FQty>";//收货数量
                    strValue += @"<FAuxPrice>" + 0 + "</FAuxPrice>";//单价  中间库没有数据
                    strValue += @"<FAmount>" + 0 + "</FAmount>";//金额   中间库没有数据
                    strValue += @"<FDCStockNo>" + CWhCode + "</FDCStockNo>";//收货仓库编码
                    strValue += @"<FDCStockName>" + CWhName + "</FDCStockName>";//收货仓库名称
                    strValue += @"<FDCSPName>" + cStoreName + "</FDCSPName>";//仓位名称
                    strValue += @"<FNote></FNote></Rows>";
                    tempInt++;
                }
            }
            strValue += @"</Entry>   </Rows></Bill>";
            //定义接口对象
            K3service.szK3VoucherSoapClient obj = new K3service.szK3VoucherSoapClient();
            //调用接口函数
            string strR = obj.CreateBill(strValue);
            #region "解析接口返回的结果"
            string status = ReadParseXml(strR, "Status");
            string error = ReadParseXml(strR, "Error");

            if (status != "0")
            {
                return "";
            }
            else
            {
                return "提交失败,原因:" + error;
            }
            #endregion
        }
        */

        /// <summary>
        /// OQC检验-根据出货单ID获取产品信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetInspectionOQC(int id, string code)
        {
            string strJson = "";
            try
            {
                strJson = new ProductOQC().GetInspectionOQC(id, code);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        /// <summary>
        ///  OQC检验-扫描产品序列号或送检批号获取产品信息
        /// </summary>
        /// <param name="txtSn"></param>
        /// <param name="txtBatch"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetInspectionOQCSN(string txtSn, string txtBatch)
        {
            string strJson = "";
            try
            {
                strJson = new ProductOQC().GetInspectionOQCSN(txtSn, txtBatch);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        /// <summary>
        ///  获取备料GRN/数量
        /// </summary>
        [AjaxMethod]
        public string GetMaterialPrepareGrn(int applyId, int itemId)
        {
            try
            {
                return (new LeanMES.Material.BLL.Material()).GetMaterialPrepareGrn(applyId, itemId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        ///  根据领料单获取信息 
        /// </summary>
        [AjaxMethod]
        public string GetApplyInfo(string ApplyNo)
        {
            try
            {
                return (new Apply()).GetApplyInfo(ApplyNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
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
        ///  获取自定义备料地点 
        /// </summary>
        [AjaxMethod]
        public string GetPrepareLoc()
        {
            try
            {
                return (new LeanMES.Material.BLL.Material()).GetPrepareLoc();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        [AjaxMethod]
        public bool CheckUserIsWarrantted(int userId)
        {
            return Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 12100051);
        }

        /*成品出货*/
        [AjaxMethod]
        public List<MaterialIQCInfo> CheckCPrepareBySN(int scanType, string SN)
        {
            try
            {
                return new Apply().CheckCPrepareBySN(scanType, SN);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void SavePrepareBySN(int ApplyId, string SNList, string UserName)
        {
            try
            {
                new Apply().SavePrepareBySN(ApplyId, SNList, UserName);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public List<ApplyInfo> GetList()
        {
            try
            {
                
                SearchSettings s = new SearchSettings();
              
                return new SKT.LeanMES.Material.BLL.Apply().GetAll(0, 10000, "", s);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public List<ApplyInfo> GetListStatue()
        {
            try
            {

                SearchSettings s = new SearchSettings();
                s.ExtensionCondition += " Statue != 1";
                return new SKT.LeanMES.Material.BLL.Apply().GetAll(0, 100, "", s);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        #region PDA查询退料单号
        
        [AjaxMethod]
        public List<MaterialInfo>   GetReturnOrder()
        {
            try
            { 
                SearchSettings s = new SearchSettings();
                s.ExtensionCondition += " Status = 1 ";
                return new SKT.LeanMES.Material.BLL.Material().GetProdReturnOrder(0,-1,"",s);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public List<MaterialInfo> GetReturnOrderNo(string returnOrderNo)
        {
            try
            {
                returnOrderNo = returnOrderNo.Replace("'", string.Empty);

                SearchSettings search = new SearchSettings();
                string where = " Status = 0";
                if (returnOrderNo.Length > 0)
                {
                    where += $" AND ExchangeOrderNo  LIKE '%{returnOrderNo.Replace("'", string.Empty)}%'";
                }
                var list = new SKT.LeanMES.Material.BLL.Material().GetProdReturnOrder(0, 20, "CreateDateTime DESC", search);
                return list;
                //SearchSettings s = new SearchSettings();
                //s.ExtensionCondition += "  ";
                //return new SKT.LeanMES.Material.BLL.Material().GetProdReturnOrder(0, -1, "CreateTime desc", s);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        #endregion

        //PDA查询工单
        [AjaxMethod]
        public List<ApplyInfo> GetApplyMoCodeAll()
        {
            try
            {

                SearchSettings s = new SearchSettings();
               // s.ExtensionCondition += " Statue != 1";
                return new SKT.LeanMES.Material.BLL.Apply().MaterialApplySelMO(0, -1, "", s);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public List<ApplyInfo> GetListStatuePlus(string charsets)
        {
            try
            {
                SearchSettings s = new SearchSettings();
                s.ExtensionCondition += " Statue != 1 AND ApplyClass<>0  AND ApplyNo like '%" + charsets + "%' ";
                return new SKT.LeanMES.Material.BLL.Apply().GetAll(0, 20, "", s);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        #region 通过领料单查询明细信息
        /// <summary>
        /// 通过领料单查询明细信息
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ApplyInfo GetApplyDtlInfo(string ApplyNo)
        {
            ApplyInfo list = null;
            try
            {
                list = (new Apply()).GetApplyDtlInfo(ApplyNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 保存合并领料单信息
        /// <summary>
        /// 保存合并领料单信息
        /// </summary>
        /// <param name="entityList"></param>
        [AjaxMethod]
        public void SaveMergeApply(String entityList)
        {
            try
            {
                (new Apply()).SaveMergeApply(entityList, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion


        /// <summary>
		/// 获取备料的GRN
		/// </summary>
		[AjaxMethod]
        public DataTable GetMaterialPrepareGRN(int Id)
        {
            string sql = @"SELECT a.RecordId, a.SerialNumber, BI.ItemCode, BI.ItemName, c.WarehouseId, isnull(D.CWhCode,'') as CWhCode, C.cBarCode, C.BalanceQty,
                        c.VendorCode,c.LotCode,ISNULL(c.DateCode,'') DateCode,c.storagedate,ISNULL(u.CName,'') createby2
						FROM dbo.Prod_PrepareMaterialGrn a WITH(NOLOCK) INNER JOIN dbo.Prod_Apply b  WITH(NOLOCK) ON a.ApplyNo=b.ApplyNo 
						INNER JOIN dbo.Prod_MaterialUnit C WITH(NOLOCK) ON C.SerialNumber=a.SerialNumber
						INNER JOIN dbo.Basal_Item BI WITH(NOLOCK) ON BI.ItemID=C.PartId
						LEFT JOIN dbo.Basal_Warehouse D WITH(NOLOCK) ON D.WarehouseId=C.WarehouseId
                        left join SYS_Users u on u.UserName=a.CreateBy 
						WHERE b.ApplyId=@ApplyId";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ApplyId", SqlDbType.Int) { Value = Id }
            };
            return ComMethod.GetListDataSetBySql(sql, parms, SQLHelper.MESConnString).Tables[0];
        }

        /// <summary>
        /// 保存 站位备料
        /// </summary>
        [AjaxMethod]
        public void SaveStationMaterialPrepar(int areainfo, string stationinfo, string planOrder, string grnStr)
        {
            try
            {
                LeanMES.Material.BLL.Material bll = new LeanMES.Material.BLL.Material();
                bll.SaveStationMaterialPrepar(areainfo, stationinfo, planOrder, grnStr);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        /// <summary>
        /// 线边仓定制
        /// </summary>
        /// <param name="ItemStr"></param>
        /// <param name="grn"></param>
        /// <param name="flage"></param>
        /// <param name="grnStr"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> CheckGrnMaterialPrepareNew(String ItemStr, String grn, Int32 flage, String grnStr)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                list = new Apply().CheckGrnMaterialPrepareNew(ItemStr, grn, flage, grnStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

    }
}