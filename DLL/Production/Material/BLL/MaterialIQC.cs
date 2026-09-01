using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Model;
using System.Linq;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using Dapper;
using SKT.LeanMES.ERP;

namespace SKT.LeanMES.Material.BLL
{
    public class MaterialIQC
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialIQC 信息。
        /// </summary>
        /// <param name="entity">MaterialIQC 实体对象。</param>
        public void Edit(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionId", SqlDbType.Int),
                new SqlParameter("@InspectionResult", SqlDbType.Int),
                new SqlParameter("@InspectionUser", SqlDbType.NVarChar,50),
                new SqlParameter("@InspectionCode", SqlDbType.NVarChar,50),
                new SqlParameter("@Auditing", SqlDbType.NVarChar,50),
                new SqlParameter("@PrintLv", SqlDbType.NVarChar,50),
                new SqlParameter("@Instrument", SqlDbType.NVarChar,500),
                new SqlParameter("@Remark", SqlDbType.NVarChar,500),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar,50),
                //new SqlParameter("@CheckList", SqlDbType.Structured),
                new SqlParameter("@ActualQty", SqlDbType.Int),
                new SqlParameter("@NCQty", SqlDbType.Int),
            };
            ComMethod.Edit<MaterialIQCInfo>(strJson, "uspSaveIQCCechkResult", parms);
        }

        /// <summary>
        /// IQC批量质检合格
        /// </summary>
        /// <param name="entity">MaterialIQC 实体对象。</param>
        public void SaveIqcALLCheck(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionIds", SqlDbType.NVarChar,2000),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar,50)
            };
            ComMethod.Edit<MaterialIQCInfo>(strJson, "uspSaveALLIQCCechkResult", parms);
        }

        /// <summary>
        /// 更新IQC退料信息
        /// </summary>
        /// <param name="strJson"></param>
        public void SaveIqcGrnBack(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionId", SqlDbType.BigInt),
                new SqlParameter("@tbGRNDtl", SqlDbType.Structured)
            };
            ComMethod.Edit<MaterialIQCInfo>(strJson, "uspDeliverGrnNgSave", parms);
        }

        /// <summary>
        /// 根据 MaterialIQCId 字符串删除 MaterialIQC 信息。
        /// </summary>
        /// <param name="idString">MaterialIQCId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Prod_MaterialIQC_Delete");
        }

        /// <summary>
        /// 根据 MaterialIQCId 获取实体信息。
        /// </summary>
        /// <param name="materialIQCId">MaterialIQCId。</param>
        /// <returns>MaterialIQC 实体对象。</returns>
        public MaterialIQCInfo GetInfo(Int32 materialIQCId)
        {
            return ComMethod.GetInfo<MaterialIQCInfo>(materialIQCId, "Prod_MaterialIQC_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialIQC 实体对象。</returns>
        public MaterialIQCInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<MaterialIQCInfo>(fieldValue, "Prod_MaterialIQC_GetInfo");
        }

        public List<MaterialIQCInfo> GetIQCResultAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialIQCInfo> list = new List<MaterialIQCInfo>();
            //表名或者视图
            string strTb = "Prod_MaterialIQCConfig";
            //主键
            string strKey = "ID";
            //查询栏位字串
            string strColumns = @" ID,CheckTypeId,CheckType ";
            list = ComMethod.GetComList<MaterialIQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        /// <summary>
        /// 分页获取 MaterialIQC 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialIQCCount">materialIQC 总数。</param>
        /// <returns>MaterialIQC 列表。</returns>
        public List<MaterialIQCInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialIQCInfo> list = new List<MaterialIQCInfo>();

            //表名或者视图
            string strTb = "vwProdMaterialIQCList";
            //主键
            string strKey = "InspectionId";
            //查询栏位字串
            string strColumns = @"InspectionId,  InspectionNo,  POCode,  DeliverNo,  DeliverDtlId,  ItemId,  ItemCode,  SuplierCode,  InspectionResult, 
                             InspectionUser,  InspectionQty,  QualifiedQty, StatusName ,UrgentName,  Remark,  CreateBy,  CreateDateTime,  ModifyBy, 
                             ModifyDateTime,  IsGRN, ItemName, VendorName, SendSample, SendSampleName, IsFile, ManageResult, AttendDateTime, AttendPerson
                            ,CheckType,HaveGRN,Site,ItemSpec ,POrder ,OkQty,NgQty,CheckDate,POTypeName,SOCode,CategoryOne,CategoryTwo,CategoryThree,InspectionStartTime,ReciveBy,ReciveTime,VerifyBy,VerifyTime
                            ,MRBNo,MRBStatus,WarehouseBarCode,InStorageQty,StorageTime,StorageBy,StorageQty";
            list = ComMethod.GetComList<MaterialIQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            // list = list.OrderByDescending(q=>q.ModifyDateTime).OrderBy(q => q.CreateDateTime).OrderBy(q => q.Statusname).OrderBy(q => q.UrgentName).ToList();

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        //仓库收料确认时- 选择已送出的 送货单列表
        public List<MaterialIQCInfo> GetDeliverList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //选择状态为已送出的送货单
            searchSettings.AddCondition("DeliState", "1");

            List<MaterialIQCInfo> list = new List<MaterialIQCInfo>();
            //表名或者视图
            string strTb = "vwMaterialReceiveSelDeliver";
            //主键
            string strKey = "DeliverId";
            //查询栏位字串
            string strColumns = @"[DeliverId],[DeliverNo], [VendorCode], [VendorName]";
            list = ComMethod.GetComList<MaterialIQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        // 仓库退料时-选择已经收料确认的 送货单列表 
        public List<MaterialIQCInfo> GetDeliverReceiveList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //选择状态为已收料的送货单
            searchSettings.AddCondition("DeliState", "2");
            //退货状态为未退货
            searchSettings.AddCondition("Status", "1");

            List<MaterialIQCInfo> list = new List<MaterialIQCInfo>();
            //表名或者视图
            string strTb = "vwPordDeliverSel";
            //主键
            string strKey = "DeliverId";
            //查询栏位字串
            string strColumns = @"[DeliverId],[DeliverNo], [VendorCode], [VendorName]";
            list = ComMethod.GetComList<MaterialIQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        /// <summary>
        /// 仓库确认收料
        /// </summary>
        /// <param name="deliverCode">送货单ID</param>
        /// <param name="level">优先级</param>
        /// <param name="userName"></param>
        public void SaveReceiveMaterial(String deliverCode, String level, String userName, string deliverDtlId, string receiveQty)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@DeliverDtlIds",SqlDbType.NVarChar,200),
                  new SqlParameter("@ReceiveQtys",SqlDbType.NVarChar,200),
                  new SqlParameter("@DeliverNo",SqlDbType.NVarChar,50),
                  new SqlParameter("@Level",SqlDbType.NVarChar,50),
                  new SqlParameter("@CreateName",SqlDbType.NVarChar,50)
            };
            parms[0].Value = deliverDtlId;
            parms[1].Value = receiveQty;
            parms[2].Value = deliverCode;
            parms[3].Value = level;
            parms[4].Value = userName;
            ComMethod.Get("uspSaveMaterialReceive", parms);
        }
        /// <summary>
        /// 仓库收料-确认退货操作
        /// </summary>
        /// <param name="deliverCode"></param>
        public void MaterialReturn(String deliverCode, String modifyBy)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@DeliverNo",SqlDbType.NVarChar,50),
                  new SqlParameter("@ModifyBy",SqlDbType.NVarChar,50)
            };
            parms[0].Value = deliverCode;
            parms[1].Value = modifyBy;
            ComMethod.Get("uspMaterialReturn", parms);
        }
        /// <summary>
        /// 根据送货单获取可收料的送货单明细
        /// </summary>
        /// <param name="deliverCode"></param>
        /// <returns></returns>
        public string GetMaterialDeliverDtl(string deliverCode, string grnCode, int choosePageId, bool isScanGRN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@DeliverNo",SqlDbType.NVarChar,50),
                  new SqlParameter("@GRNNo",SqlDbType.NVarChar,50),
                  new SqlParameter("@ChoosePageId",SqlDbType.Int),
                  new SqlParameter("@IsScanGRN",SqlDbType.Bit),
            };
            parms[0].Value = deliverCode;
            parms[1].Value = grnCode;
            parms[2].Value = choosePageId;
            parms[3].Value = isScanGRN;
            return ComMethod.GetList("uspGetMaterialDeliverInfo", parms);
        }


        /// <summary>
        /// 根据送货单获取可退货的送货单明细
        /// </summary>
        /// <param name="deliverCode"></param>
        /// <returns></returns>
        public string GetMaterialDeliverReturn(string deliverCode, string grnCode)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@DeliverNo",SqlDbType.NVarChar,50),
                  new SqlParameter("@GRNNo",SqlDbType.NVarChar,50)
            };
            parms[0].Value = deliverCode;
            parms[1].Value = grnCode;
            return ComMethod.GetList("uspGetMaterialDeliverReturn", parms);
        }
        /// <summary>
        /// 仓库确认退货操作
        /// </summary>
        /// <param name="deliverCode">送货单号</param>
        /// <param name="userName"></param>
        public void SaveMaterialReturn(String deliverCode, String userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@DeliverNo",SqlDbType.NVarChar,50),
                  new SqlParameter("@CreateName",SqlDbType.NVarChar,50)
            };
            parms[0].Value = deliverCode;
            parms[1].Value = userName;
            ComMethod.Get("uspSaveMaterialReturn", parms);
        }
        //仓库交接确认时- 选择 送货单列表
        public List<MaterialIQCInfo> GetHadoverDeliverList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //选择状态为已收货的送货单
            searchSettings.AddCondition("DeliState", "2");

            List<MaterialIQCInfo> list = new List<MaterialIQCInfo>();
            //表名或者视图
            string strTb = "vwMaterialHadoverSelDeliver";
            //主键
            string strKey = "DeliverId";
            //查询栏位字串
            string strColumns = @"[DeliverId],[DeliverNo], [VendorCode], [VendorName]";
            list = ComMethod.GetComList<MaterialIQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        //仓库交接确认时 - 根据选择的送货单查询IQC检验单
        public string GetIQCListByCodes(string deliverNo)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@DeliverNo",SqlDbType.NVarChar,50)
            };
            parms[0].Value = deliverNo;
            return ComMethod.GetListBySql("select InspectionId from Prod_MaterialIQC where DeliverNo=@DeliverNo and (InspectionResult=1 or ManageResult=1 or  ManageResult=4  or (ManageResult=2 and IsChooseOver=1)) and (statue=1)", parms);
        }

        //仓库交接确认时 - 根据扫描的IQC送检单号查询IQC检验单ID
        public string GetInspectionIdListByCodes(string inspectionNo)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionNo",SqlDbType.NVarChar,50)
            };
            parms[0].Value = inspectionNo;
            return ComMethod.GetListBySql("select InspectionId from Prod_MaterialIQC where InspectionNo=@InspectionNo AND (InspectionResult=1 or ManageResult=1 or  ManageResult=4  or (ManageResult=2 and IsChooseOver=1)) and (statue=1)", parms);
        }
        //仓库交接确认时- 选择IQC处理结果为特采、挑选、退货 的IQC检验单
        public List<MaterialIQCInfo> GetHandoverList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //选择状态为检验合格的单
            //searchSettings.AddCondition("InspectionResult", "1");

            //选择IQC处理结果为特采、挑选、退货 或者 检验结果为合格的 且状态为已检的单
            searchSettings.ExtensionCondition = " (InspectionResult=1 or ManageResult=1 or  ManageResult=4  or (ManageResult=2 and IsChooseOver=1)) and (statue=1)";

            List<MaterialIQCInfo> list = new List<MaterialIQCInfo>();
            //表名或者视图
            string strTb = "vwMaterialIQCHandover";
            //主键
            string strKey = "InspectionId";
            //查询栏位字串
            string strColumns = @"[InspectionId],[InspectionNo],[ItemCode], [ItemName],[QualifiedQty],[UrgentLevel], [VendorName], ManageResult";
            list = ComMethod.GetComList<MaterialIQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        //仓库交接确认时 - 根据选择的IQC检验单或GRN条码查询IQC检验单明细信息和GRN
        public string GetHandoverListByCodes(string inspectionIds, string grnCode)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionIds",SqlDbType.NVarChar,50),
                  new SqlParameter("@GRNNo",SqlDbType.NVarChar,50)
            };
            parms[0].Value = inspectionIds;
            parms[1].Value = grnCode;
            return ComMethod.GetList("uspMaterialIQCHandover", parms);
        }
        /// <summary>
        /// 仓库交接确认操作
        /// </summary>
        /// <param name="deliverCode">IQC检验单</param>
        /// <param name="userName"></param>
        public void SaveMaterialHandover(String inspectionIds, String userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@IdString",SqlDbType.NVarChar,50),
                  new SqlParameter("@ModifyName",SqlDbType.NVarChar,50)
            };
            parms[0].Value = inspectionIds;
            parms[1].Value = userName;
            ComMethod.Get("uspSaveMaterialHandover", parms);
        }

        /// <summary>
        /// IQC检验处理
        /// </summary>
        /// <param name="idString">检验单ID</param>
        /// <param name="ManageResult">1：特采、3：退货</param>
        /// <param name="userName"></param>
        public void MaterialIQCFormAttend(String idString, int ManageResult, String userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@IdString",SqlDbType.NVarChar,500),
                  new SqlParameter("@ManageResult",SqlDbType.Int),
                  new SqlParameter("@CreateBy",SqlDbType.NVarChar,50)
            };
            parms[0].Value = idString;
            parms[1].Value = ManageResult;
            parms[2].Value = userName;
            ComMethod.Get("Prod_MaterialIQCFormAttend_Edit", parms);
        }
        /// <summary>
        /// 根据检验单ID获取检验单GRN信息
        /// </summary>
        /// <param name="intIqcId"></param>
        /// <returns></returns>
        public string GetIQCFormGrn(Int32 intIqcId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int)
                };
            parms[0].Value = intIqcId;
            return ComMethod.GetList("upsGetIQCFormGrn", parms);
        }
        /// <summary>
        /// 保存IQC检验处理挑选结果
        /// </summary>
        /// <param name="strJson"></param>
        public void SaveIQCFormAttendGRN(string strJson)
        {
            ComMethod.Edit<MaterialIQCInfo>(strJson, "uspSaveIQCFormAttendGRN");
        }

        /// <summary>
        /// 保存IQC检验处理挑选结果(扫描数量)
        /// </summary>
        /// <param name="strJson"></param>
        public void SaveIQCChooseQtyInfo(string strJson)
        {
            ComMethod.Edit<MaterialIQCInfo>(strJson, "uspSaveIQCChooseQtyInfo");
        }
        /// <summary>
        /// 根据IQC检验单号查询GRN信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialIQCInfo> GetProdMaterialIQCGrn(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialIQCInfo> list = new List<MaterialIQCInfo>();
            //表名或者视图
            string strTb = "vwProdMaterialIQCGrn";
            //主键
            string strKey = "InspectionId";
            //查询栏位字串
            string strColumns = @"InspectionId,  GRN,  BalanceQty,  CreateDateTime, statusname, InspectionNo ";
            list = ComMethod.GetComList<MaterialIQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        /// <summary>
        /// 根据检验单获取GRN信息
        /// </summary>
        /// <param name="InspectionId"></param>
        /// <returns></returns>
        public string GetProdMaterialIQCGrn(int InspectionId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                              new SqlParameter("@InspectionId",SqlDbType.Int)
                        };
            parms[0].Value = InspectionId;
            return ComMethod.GetListBySql("select InspectionId,  GRN,  BalanceQty,  CreateDateTime, statusname, InspectionNo from vwProdMaterialIQCGrn where InspectionId=@InspectionId", parms);
        }

        //显示IQC交接的物料信息 add by weixia on 2016.9.28
        public string GetShowIQCConfirmDetail(string InspectionNo)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InsPectionNo",SqlDbType.VarChar,200)
            };
            parms[0].Value = InspectionNo;
            return ComMethod.GetList("uspShowIQCConfirmDetail", parms);
        }

        //保存交接确认
        public void SaveIQCConfirmDetail(string InspectionNo, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InsPectionNo",SqlDbType.VarChar,200),
                  new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };
            parms[0].Value = InspectionNo;
            parms[1].Value = userName;
            ComMethod.Get("uspSaveIQCConfirmDetail", parms);
        }

        //保存物料入库信息(扫描数量)
        public void SaveIQCGRNStorageQty(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionId",SqlDbType.BigInt),
                  new SqlParameter("@StorageQty",SqlDbType.Decimal),
                  new SqlParameter("@CBarCode",SqlDbType.VarChar,100),
                  new SqlParameter("@CreateBy",SqlDbType.VarChar,20)
            };
            ComMethod.Edit<MaterialIQCInfo>(strJson, "uspSaveIQCGRNStorageQty", parms);
        }

        /// <summary>
        /// 保存物料入库信息（扫描物料条码）
        /// </summary>
        /// <param name="strJson"></param>
        public void uspSaveIQCGRNStorage(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@StorageQty", SqlDbType.Decimal),
                    new SqlParameter("@tbDtl", SqlDbType.Structured),
                    new SqlParameter("@PutOnShelf", SqlDbType.Int),
                    new SqlParameter("@CreateBy",SqlDbType.NVarChar,50)
                };

            ComMethod.Edit<MaterialIQCInfo>(strJson, "uspSaveIQCGRNStorage", parms);
        }

        public string GetIQCScanGRNInfo(Int64 intIqcId, String grn, Int32 IsAll)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.BigInt),
                    new SqlParameter("@GRN", SqlDbType.VarChar,100),
                    new SqlParameter("@IsAll", SqlDbType.Int)
                };
            parms[0].Value = intIqcId;
            parms[1].Value = grn;
            parms[2].Value = IsAll;
            return ComMethod.GetList("uspGetIQCGRNStorageQty", parms);
        }

        /// <summary>
        /// 根据IQC检验单获取退货信息
        /// </summary>
        public string GetIqcReturnInfo(string InspectNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectNo", SqlDbType.NVarChar,50)
                };
            parms[0].Value = InspectNo;

            return ComMethod.GetList("uspGetIqcReturnInfo", parms);
        }

        public List<MaterialIQCInfo> GetIqcReturnAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialIQCInfo> list = new List<MaterialIQCInfo>();
            //表名或者视图
            string strTb = "vwGetAbleIqcReturnForm";
            //主键
            string strKey = "InspectionId";
            //查询栏位字串
            string strColumns = @"InspectionId,InspectionNo,DeliverNo,POCode,ItemCode,ItemName
                                ,VendorCode,VendorName,SentQty,NgQty";
            list = ComMethod.GetComList<MaterialIQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 保存IQC退货单生成
        /// </summary>
        public void SaveIqcReturn(string strJSON)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@ReturnFormId", SqlDbType.Int),
                    new SqlParameter("@InspectionNo", SqlDbType.NVarChar,50),
                    new SqlParameter("@Remark", SqlDbType.NVarChar,-1),
                    new SqlParameter("@CreateBy",SqlDbType.VarChar,20)
                };

            ComMethod.Edit<MaterialIQCInfo>(strJSON, "uspIQCreturnSave", parms);
        }

        /// <summary>
        /// IQC检验退货列表
        /// </summary>
        public List<MaterialIQCInfo> GetIqcReturnList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialIQCInfo> list = new List<MaterialIQCInfo>();
            //表名或者视图
            string strTb = "vwGetIQCreturnList";
            //主键
            string strKey = "ReturnFormId";
            //查询栏位字串
            string strColumns = @"[ReturnFormId],[ReturnFormNo],[InspectionNo],[InspectionId]
                    ,[POCode],[DeliverNo],[ItemCode],[ItemName],[InspectionQty]
                    ,[NgQty],[VendorCode],[VendorName],[CreateDateStr],[Remark]
                    ,[Status],[SureReturn],[OkQty],[DelDatatime],[LoweredUserName],[NgReson],[CreateBy]";
            list = ComMethod.GetComList<MaterialIQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 保存IQC退货单生成
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="returnMode">0,供应商，1，不良仓</param>
        public string ConfirmIqcReturn(MaterialIQCInfo entity, int returnMode)
        {
            //SqlParameter[] parms = new SqlParameter[]{
            //        new SqlParameter("@ReturnFormId", SqlDbType.Int),
            //        new SqlParameter("@ConfirmBy",SqlDbType.NVarChar,50),
            //        new SqlParameter("@ReturnMode", SqlDbType.Int)
            //    };
            //ComMethod.Edit<MaterialIQCInfo>(strJSON, "uspConfirmIqcReturn", parms);

            var msg = string.Empty;
            string erpNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.IQCReturn;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）

            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@ReturnFormId", entity.ReturnFormId);
                    dp.Add("@ConfirmBy", entity.ModifyBy);
                    dp.Add("@ReturnMode", returnMode);
                    reader = conn.ExecuteReader("uspConfirmIqcReturn", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                    //退供应商才需要回写
                    if (returnMode == 0)
                    {
                        //是否需要回写
                        isWriteBack = WriteBackERP.IsWriteBack(em);
                        if (isWriteBack)
                        {
                            if (dtWrite == null || dtWrite.Rows.Count <= 0)
                            {
                                msg = "未获取到需要回写ERP数据";
                                throw new Exception(msg);
                            }
                            var returnNo = dtWrite.Rows[0]["MESDocNO"].ToString();

                            //调用接口
                            ERPReturnInfo info = WriteBackERP.SendPost(em, dtWrite, returnNo, entity.ModifyBy, dtEnterTime, dtAfterExecProcTime);
                            if (!info.Result)
                            {
                                //回写失败
                                throw new Exception(info.msg);
                            }
                        }
                    }
                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw ex;
                }
                finally
                {
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                }
            }
            return erpNo;
        }

        /// <summary>
        /// 根据IQC检验单获取退货信息
        /// </summary>
        public string GetIQCFormGrnBack(int ReturnId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@ReturnFormId", SqlDbType.Int)
                };
            parms[0].Value = ReturnId;
            return ComMethod.GetList("upsGetIQCFormGrnBack", parms);
        }

        /// <summary>
        /// IQC退料列表-查看功能
        /// </summary>
        public string GetIqcFormGrnReturnDal(int ReturnId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@ReturnFormId", SqlDbType.Int)
                };
            parms[0].Value = ReturnId;
            return ComMethod.GetList("upsGetIQCFormGrnReturn", parms);
        }

        /********************************IQC检验项录入GRN信息*****************************************/
        /// <summary>
        /// 更改固定值检验项状态
        /// </summary>
        /// <param name="id"></param>
        public void UpdateFixedInspectionItem(int Id, int Status)
        {
            string strsql = @"UPDATE  Prod_InspectionIQCInputGRNInfo SET Result=" + Status + ", InspectionTime = GETDATE() WHERE Id=" + Id;
            ComMethod.EditBySql(strsql, null);
        }

        /// <summary>
        /// 更改备注检验项状态
        /// </summary>
        /// <param name="id"></param>
        public void UpdateInspectionItemRemark(int Id, string remark)
        {
            string strsql = @"UPDATE  Prod_InspectionIQCInputGRNInfo SET Remark='" + remark + "' WHERE Id=" + Id;
            ComMethod.EditBySql(strsql, null);
        }

        /// <summary>
        /// 获取IQC检验信息
        /// </summary>
        /// <param name="iqcNo"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        public List<InspectionInputGRNInfo> GetIQCInputGRNInfo(int Pid)
        {
            string strsql = @"SELECT
                                 GRN ,
                                Value ,
                                Remark ,
                                Result AS DtlResult,
                                CreateBy ,
                                CreateDateTime FROM dbo.Prod_InspectionIQCInputGRNInfoDtl WHERE Pid=" + Pid + " ORDER BY CreateDateTime DESC ";
            return ComMethod.GetListBySql<InspectionInputGRNInfo>(strsql, null);
        }
        public int uspIsIQCInputGRNInfo(string IQCNo, string GRN)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@IQCNo", SqlDbType.VarChar,50),
                    new SqlParameter("@GRN", SqlDbType.VarChar,50),
                    new SqlParameter("@Result", SqlDbType.Int),
            };
            parms[0].Value = IQCNo;
            parms[1].Value = GRN;
            parms[2].Direction = ParameterDirection.Output;
            ComMethod.Edit("uspIsIQCInputGRNInfo", parms);
            return Convert.ToInt32(parms[2].Value);
        }
        public List<MaterialIQCInfo> uspSearchIQCInputGRNInfo(string IQCNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@IQCNo", SqlDbType.VarChar,50)
            };
            parms[0].Value = IQCNo;
            return ComMethod.GetList<MaterialIQCInfo>("uspSearchIQCInputGRNInfo", parms);
        }
        /// <summary>
        ///  插入IQC检验GRN录入记录
        /// </summary>
        /// <param name="ReturnId"></param>
        /// <returns></returns>
        public InspectionInputGRNInfo InsertIQCInputGRNInfo(InspectionInputGRNInfo model)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionNo", SqlDbType.VarChar,50),
                    new SqlParameter("@InspectionTemplateId", SqlDbType.Int),
                    new SqlParameter("@InspectionTemplateMemberId", SqlDbType.Int),
                    new SqlParameter("@InspectionMethodValue", SqlDbType.VarChar,200),
                    new SqlParameter("@CreateBy", SqlDbType.VarChar,50),
                };
            parms[0].Value = model.InspectionNo;
            parms[1].Value = model.InspectionTemplateId;
            parms[2].Value = model.InspectionTemplateMemberId;
            parms[3].Value = model.Value;
            parms[4].Value = model.CreateBy;
            var models = ComMethod.Get<InspectionInputGRNInfo>("uspSaveInspectionInputGRN", parms);
            return models;
        }

        public InspectionInputGRNInfo InsertInspectionTemplateItem(string InspectionNo, string InspectionTemplateId, string InspectionItemId, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionNo", SqlDbType.VarChar,50),
                    new SqlParameter("@InspectionTemplateId", SqlDbType.Int),
                    new SqlParameter("@InspectionItemId", SqlDbType.Int),
                    new SqlParameter("@CreateBy", SqlDbType.VarChar,50),
                };
            parms[0].Value = InspectionNo;
            parms[1].Value = InspectionTemplateId;
            parms[2].Value = InspectionItemId;
            parms[3].Value = UserName;
            var models = ComMethod.Get<InspectionInputGRNInfo>("uspSaveInspectionTemplateItem", parms);
            return models;
        }

        public void DeleteInspectionTemplateItem(string InspectionTemplateId, string InspectionItemId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionTemplateId",SqlDbType.Int),
                new SqlParameter("@InspectionItemId",SqlDbType.Int)
            };
            parms[0].Value = InspectionTemplateId;
            parms[1].Value = InspectionItemId;
            ComMethod.Edit("uspDelInspectionInputGRNInfo", parms);
        }

        //修改文件地址
        public void UpdateInspectionItemFilePath(string FilePath, int Id)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id",SqlDbType.Int)
            };
            parms[0].Value = Id;
            string sql = string.Format(@"DELETE FROM SYS_UpLoadFile WHERE FromID=@Id AND FromCode=@Id and RowType='InspectionItemReport';  
                                        UPDATE Prod_InspectionIQCInputGRNInfo SET FilePath='{0}' WHERE id=@Id ", FilePath);
            ComMethod.ExeNonQuerySpcSql(sql, parms);
        }

        public InspectionInputGRNInfo GetInspectionIQCInputGRNInfo(string InspectionIQCInputGRNInfoId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionIQCInputGRNInfoId", SqlDbType.Int),
                };
            parms[0].Value = InspectionIQCInputGRNInfoId;
            var models = ComMethod.Get<InspectionInputGRNInfo>("uspGetInspectionIQCInputGRNInfo", parms);
            return models;
        }

        public void ChangIQCInputGRNInfoUnit(string InspectionItemId, string UnitName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionItemId",SqlDbType.Int),
                new SqlParameter("@UnitName",SqlDbType.VarChar,50)
            };
            parms[0].Value = InspectionItemId;
            parms[1].Value = UnitName;
            ComMethod.Edit("uspChangIQCInputGRNInfoUnit", parms);
        }

        public void ChangIQCInputGRNInfoMethodValue(string InspectionItemId, string MethodValue, string UnitName, string OffsetUnitName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionItemId",SqlDbType.Int),
                new SqlParameter("@MethodValue",SqlDbType.VarChar,50),
                new SqlParameter("@UnitName",SqlDbType.VarChar,30),
                new SqlParameter("@OffsetUnitName",SqlDbType.VarChar,30)
            };
            parms[0].Value = InspectionItemId;
            parms[1].Value = MethodValue;
            parms[2].Value = UnitName;
            parms[3].Value = OffsetUnitName;
            ComMethod.Edit("uspChangIQCInputGRNInfoMethodValue", parms);
        }


        public void InsertIQCInputGRNInfoDtl(string jsonStr)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Result",SqlDbType.Int),
                new SqlParameter("@Tab",SqlDbType.Structured),
                new SqlParameter("@MethodValue",SqlDbType.NVarChar),
                new SqlParameter("@Remark", SqlDbType.NVarChar),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar),
                    //new SqlParameter("@Pid", SqlDbType.Int),
                    //new SqlParameter("@GRN", SqlDbType.VarChar,50),
                    //new SqlParameter("@Value", SqlDbType.VarChar,200),
                    //new SqlParameter("@Remark", SqlDbType.VarChar,200),
                    //new SqlParameter("@Result", SqlDbType.Bit),
                    //new SqlParameter("@CreateBy", SqlDbType.VarChar,50),
                };
            //parms[0].Value = model.InspectionTemplateMemberId;
            //parms[1].Value = model.GRN;
            //parms[2].Value = model.Value;
            //parms[3].Value = model.Remark;
            //parms[4].Value = model.Result;
            //parms[5].Value = model.CreateBy;
            ComMethod.Edit<InspectionInputGRNInfo>(jsonStr, "uspSaveInspectionInputGRNDtl", parms);
        }

        /// <summary>
        /// 删除IQC检验GRN录入记录
        /// </summary>
        /// <param name="ReturnId"></param>
        /// <returns></returns>
        public void DeleteIQCInputGRNInfo(int Pid)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Pid",SqlDbType.Int),
            };
            parms[0].Value = Pid;
            ComMethod.Edit("uspDelInspectionInputGRNDtl", parms);
        }
        /************************add***zcl 2017-02-28*******************************/
        /// <summary>
        /// PDA获取来源单据信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IList<MaterialIQCInfo> GetSourceListInfo(string id, int pageNo, ref int rowCount)
        {
            IList<MaterialIQCInfo> list = new List<MaterialIQCInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@id", SqlDbType.VarChar,50)
                };
            parms[0].Value = id;
            list = ComMethod.GetList<MaterialIQCInfo>("uspPDAInStockGetSourceListInfo", parms);
            //list = ComMethod.GetPageList<MaterialIQCInfo>("uspPDAInStockGetSourceListInfo", parms, pageNo, 4, ref rowCount);
            var list1 = list.Where(i => i.IsStorage != false).OrderBy(i => i.ItemCode).ToList();
            return list1;
        }

        /// <summary>
        /// 根据GRN获取IQC单据信息
        /// </summary>
        /// <param name="id"></param>
        /// <param name="pageNo"></param>
        /// <param name="rowCount"></param>
        /// <returns></returns>
        public IList<MaterialIQCInfo> GetSourceListInfoByGRN(string grn)
        {
            IList<MaterialIQCInfo> list = new List<MaterialIQCInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@GRN", SqlDbType.VarChar,50)
                };
            parms[0].Value = grn;
            list = ComMethod.GetList<MaterialIQCInfo>("uspPDAInStockGetSourceListInfoByGRN", parms);
            //var list1 = list.Where(i => i.IsStorage != false).OrderBy(i => i.ItemCode).ToList();
            return list;
        }
        /// <summary>
        /// 判断
        /// </summary>
        /// <param name="purchaseNo">采购单号</param>
        /// <param name="GRN">GRN</param>
        /// <returns></returns>
        //    public MaterialIQCInfo IsGRN(string purchaseNo, string GRN)
        //    {
        //        MaterialIQCInfo model = new MaterialIQCInfo();
        //        SqlParameter[] parms = new SqlParameter[]{
        //	new SqlParameter("@purchaseNo", SqlDbType.VarChar,100),
        //                new SqlParameter("@GRN", SqlDbType.VarChar,100)
        //};
        //        parms[0].Value = purchaseNo;
        //        parms[1].Value = GRN;
        //        model = ComMethod.GetList<MaterialIQCInfo>("uspPDAInStockGRNCheck", parms)[0];
        //        return model;
        //    }
        public List<MaterialIQCInfo> IsGRN(string purchaseNo, string GRN, string station, int putOnShelf)
        {
            MaterialIQCInfo model = new MaterialIQCInfo();
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@purchaseNo", SqlDbType.VarChar,100),
                    new SqlParameter("@GRN", SqlDbType.VarChar,100),
                    new SqlParameter("@station", SqlDbType.VarChar,100),
                    new SqlParameter("@PutOnShelf", SqlDbType.Int),
                };
            parms[0].Value = purchaseNo;
            parms[1].Value = GRN;
            parms[2].Value = station;
            parms[3].Value = putOnShelf;
            List<MaterialIQCInfo> list = ComMethod.GetList<MaterialIQCInfo>("uspPDAInStockGRNCheck1", parms);
            return list;
        }
        public class PackNum
        {
            public string SerialNumber { get; set; }
        }
        public List<string> IsPack(string GRN)
        {

            string sql = @"SELECT SerialNumber FROM dbo.Prod_MaterialUnit WHERE MaterialUnitId IN(SELECT PID FROM dbo.Prod_MaterialUnit 
		WHERE SerialNumber='" + GRN + "') AND Flag!=-1";
            var list = ComMethod.GetListBySql<PackNum>(sql, null);
            return list.Count() > 0 ? list.Select(it => it.SerialNumber).ToList() : new List<string>();
        }
        //public void uspPDASaveIQCGRNStorage(string strJson)
        //{
        //    SqlParameter[] parms = new SqlParameter[]{
        //            new SqlParameter("@InspectionId", SqlDbType.Int),
        //            new SqlParameter("@StorageQty", SqlDbType.Decimal),
        //            new SqlParameter("@tbDtl", SqlDbType.Structured),
        //            new SqlParameter("@PutOnShelf", SqlDbType.Int),
        //            new SqlParameter("@CreateBy",SqlDbType.NVarChar,50)
        //        };

        //    ComMethod.Edit<MaterialIQCInfo>(strJson, "uspPDASaveIQCGRNStorage", parms);
        //}

        /// <summary>
        /// PC&PDA物料入库
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string PDASaveIQCGRNStorage(MaterialIQCInfo entity)
        {
            //SqlParameter[] parms = new SqlParameter[]{
            //        new SqlParameter("@InspectionId", SqlDbType.Int),
            //        new SqlParameter("@StorageQty", SqlDbType.Decimal),
            //        new SqlParameter("@tbDtl", SqlDbType.Structured),
            //        new SqlParameter("@PutOnShelf", SqlDbType.Int),
            //        new SqlParameter("@CreateBy",SqlDbType.NVarChar,50)
            //    };

            //ComMethod.Edit<MaterialIQCInfo>(strJson, "uspPDASaveIQCGRNStorage", parms);

            var msg = string.Empty;
            string inspectionNo = string.Empty;
            string erpInstockNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            DataTable dt = ComMethod.JsonToDataTable(entity.tbDtl);
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@InspectionId", entity.InspectionId);
                    dp.Add("@StorageQty", entity.StorageQty);
                    dp.Add("@tbDtl", dt, DbType.Object);
                    dp.Add("@PutOnShelf", entity.PutOnShelf);
                    dp.Add("@CreateBy", entity.CreateBy);
                    reader = conn.ExecuteReader("uspPDASaveIQCGRNStorage", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);

                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间


                    var IsStorage = dtWrite.Rows[0]["IsStorage"].ToString();
                    var POType = dtWrite.Rows[0]["POType"].ToString();//采购类型
                    WriteBackEnum em = WriteBackEnum.MaterialStorage;
                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);
                    if (isWriteBack)
                    {
                        //采购单类型不等于1 则需要全部入库
                        if (POType == "1" || POType == "2" ||(POType == "3" && IsStorage == "1"))
                        {
                            if (dtWrite == null || dtWrite.Rows.Count <= 0)
                            {
                                msg = "未获取到需要回写ERP数据";
                                throw new Exception(msg);
                            }
                            var materialStorageNo = dtWrite.Rows[0]["billCode"].ToString();//MES入库单号
                            //杂收单
                            if (POType == "3")
                            {
                                em = WriteBackEnum.MiscellaneousInStorage;
                            }
                            else if (POType == "2")
                            {
                                em = WriteBackEnum.MaterialMixStorage;
                            }
                            //调用接口
                            ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, materialStorageNo, entity.ModifyBy, dtEnterTime, dtAfterExecProcTime);
                            logList.Add(new WriteBackLogInfo
                            {
                                WriteBackCode = em.ToString(),
                                ERPMsg = info.Msg,
                                ERPResult = info.Result ? 1 : 0,
                                ERPNo = info.ERPNo,
                                MESBillNo = materialStorageNo,
                                WriteBackData = info.SendInfo,
                                ReceiveData = info.ReceiveData,
                                EnterTime = dtEnterTime,
                                AfterExecProcTime = dtAfterExecProcTime,
                                AfterExecERPTime = info.dtAfterExecERPTime,
                                CreateDateTime = DateTime.Now
                            });

                            if (!info.Result)
                            {
                                //回写失败
                                throw new Exception(info.Msg);
                            }
                            else
                            {
                                //回写成功，更新ERP入库单号
                                var obj = new { ERPInstockNo = info.ERPNo, ModifyBy = entity.ModifyBy, MaterialStorageNo = materialStorageNo };
                                int i = conn.Execute(@"UPDATE ps SET ps.ERPInstockNo = @ERPInstockNo,ps.ModifyBy = @ModifyBy,ps.ModifyDateTime = GETDATE() FROM dbo.Prod_MaterialStorage ps WHERE ps.MaterialStorageNo = @MaterialStorageNo", obj, tran);
                                erpInstockNo = info.ERPNo;
                            }
                        }
                    }
                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw ex;
                }
                finally
                {
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    foreach (var log in logList)
                    {
                        WriteBackERP.AddWriteBackLog(conn, log);
                    }
                    conn.Close();
                }
            }

            return erpInstockNo;

        }

        public void SaveFileManage(string itemcode, string suppliercode, string filename, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@ItemCode", SqlDbType.VarChar,50),
                    new SqlParameter("@SupplierCode", SqlDbType.VarChar,50),
                    new SqlParameter("@FileName", SqlDbType.VarChar,300),
                    new SqlParameter("@CreateBy",SqlDbType.VarChar,50)
                };
            parms[0].Value = itemcode;
            parms[1].Value = suppliercode;
            parms[2].Value = filename;
            parms[3].Value = username;
            ComMethod.Edit("uspSaveInspectionFileManage", parms);
        }
        public List<InspectionFileManageInfo> GetFileInfo(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionFileManageInfo> list = new List<InspectionFileManageInfo>();
            //表名或者视图
            string strTb = "vwInspectionFileInfo";
            //主键
            string strKey = "Id";
            //查询栏位字串
            string strColumns = @"[Id],[ItemCode],[SupplierCode],[SupplierName]
                    ,[FileType],[FileName],[CreateBy],[CreateDateTime],FileSaveName,DataSource,FileVersion";
            list = ComMethod.GetComList<InspectionFileManageInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 删除上传的数据 （Prod_InspectionInputGRNFileManage表数据（检验文档管理—载入时保存的数据））
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteFile(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Quality_InspectionFileManage_Delete");
            //string strsql = @"DELETE Prod_InspectionInputGRNFileManage WHERE Id=" + idString;
            //ComMethod.EditBySql(strsql, null);
        }

        /// <summary>
        /// 删除上传的数据 （SYS_UpLoadFile表数据（IQC来料检查中上传的数据））
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>        
        public void DeleteSysUpLoadFileFile(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "uspUpLoadFileDelete");
        }

        #region 入库单打印/重新打印入库单
        /// <summary>
        /// 入库单打印/重新打印入库单
        /// </summary>
        /// <returns></returns>
        public byte[] GetMaterialStoragePrintPdfByte(int intId, string strXmlFilePath, string strImgPath)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@MaterialStorageId",SqlDbType.Int)
            };
            parms[0].Value = intId;

            DataSet ds = ComMethod.GetListDataSet("upsMaterialStoragePrint", parms, "dtMaterialStorageForm");

            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        /// <summary>
        ///入库单 Prod_MaterialStorage 打印人信息记录。
        /// </summary>
        /// <param name="entity">MaterialIQC 实体对象。</param>
        public void MaterialStorageEdit(int intId, int isRePrint, string printer, string rePrinter)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaterialStorageId", SqlDbType.Int),
                new SqlParameter("@isRePrint", SqlDbType.Int),
                new SqlParameter("@Printer", SqlDbType.NVarChar,50),
                new SqlParameter("@RePrinter", SqlDbType.NVarChar,50)
            };
            parms[0].Value = intId;
            parms[1].Value = isRePrint;
            parms[2].Value = printer;
            parms[3].Value = rePrinter;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveMaterialStorage", parms);
        }

        #endregion

        #region 根据GRN获取检验单号
        /// <summary>
        /// 根据GRN获取检验单号
        /// </summary>
        /// <param name="GRN"></param>
        /// <returns></returns>
        public string GetIQCOrder(string GRN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@IQCOrder",SqlDbType.VarChar,50)
            };
            parms[0].Value = GRN;
            parms[1].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetIQCOrder", 2000000, parms);
            return Convert.ToString(parms[1].Value);
        }
        #endregion

        #region 记录IQC送检单打印信息

        /// <summary>
        /// 记录送检单打印补打情况
        /// </summary>
        /// <param name="inspectionId"></param>
        /// <param name="printType"></param>
        /// <param name="userName"></param>
        public void ReceivePrintRecord(long inspectionId, int printType, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@InspectionId",SqlDbType.BigInt),
                new SqlParameter("@PrintType",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar)
            };

            parms[0].Value = inspectionId;
            parms[1].Value = printType;
            parms[2].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReceivePrintRecord", parms);
        }

        #endregion


        /// <summary>
        /// IQC接收
        /// </summary>
        /// <param name="entity"></param>
        public void IQCRecive(MaterialIQCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar,20)
                };
            parms[0].Value = entity.InspectionId;
            parms[1].Value = entity.ReciveBy;
            ComMethod.Edit("uspIQCRecive", parms);
        }

        /// <summary>
        /// 验证IQC检验是否已经接收
        /// </summary>
        /// <param name="entity"></param>
        public void ValidateIQCRecived(MaterialIQCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@UserName", SqlDbType.VarChar,20)
                };
            parms[0].Value = entity.InspectionId;
            parms[1].Value = entity.ReciveBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidateIQCRecived", parms);
        }

        /// <summary>
        /// IQC审核
        /// </summary>
        /// <param name="entity"></param>
        public void IQCVerify(MaterialIQCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@VerifyBy", SqlDbType.VarChar,20),
                    new SqlParameter("@Auditing", SqlDbType.NVarChar,50)
                };
            parms[0].Value = entity.InspectionId;
            parms[1].Value = entity.VerifyBy;
            parms[2].Value = entity.Auditing;
            ComMethod.Edit("uspIQCVerify", parms);
        }

        /// <summary>
        /// 分页获取 MRB单 信息
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialIQCCount">materialIQC 总数。</param>
        /// <returns>MRB单 列表</returns>
        public IList<MaterialIQCInfo> GetMRBList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwIQCMRBList";
            //主键
            string strKey = "InspectionId";
            //查询栏位字串
            string strColumns = @"InspectionId,InspectionNo,MRBNo,MRBStatus,MRBStatusName,AttendPerson,AttendDateTime,MRBVerifyBy,MRBVerifyTime,Auditing,CloseCaseBy,CloseCaseTime,DealRemark,ManageResult,ManageResultName,QualifiedQty,FledQty";
            var list = ComMethod.GetComList<MaterialIQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        /// <summary>
        /// 根据IQC Id 获取IQC检验单信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public MaterialIQCInfo GetEntity(MaterialIQCInfo entity)
        {
            var sql = @"SELECT InspectionId,  InspectionNo,  POCode,  DeliverNo,  DeliverDtlId,  ItemId,  ItemCode,  SuplierCode,  InspectionResult, 
                             InspectionUser,  InspectionQty,  QualifiedQty, StatusName ,UrgentName,  Remark,  CreateBy,  CreateDateTime,  ModifyBy, 
                             ModifyDateTime,  IsGRN, ItemName, VendorName, SendSample, SendSampleName, IsFile, ManageResult, AttendDateTime, AttendPerson
                            ,CheckType,HaveGRN,Site,ItemSpec ,POrder ,OkQty,NgQty,CheckDate,POTypeName,SOCode,CategoryOne,CategoryTwo,CategoryThree,InspectionStartTime,ReciveBy,ReciveTime,VerifyBy,VerifyTime
                            ,MRBNo,MRBStatus,Auditing
                        FROM vwProdMaterialIQCList WHERE InspectionId = @InspectionId";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionId", SqlDbType.Int)
            };
            parms[0].Value = entity.InspectionId;
            var list = ComMethod.GetListBySql<MaterialIQCInfo>(sql, parms);
            if (list != null && list.Count > 0)
            {
                return list[0];
            }
            return null;
        }

        /// <summary>
        /// MRB审核
        /// </summary>
        /// <param name="entity"></param>
        public void MRBVerify(MaterialIQCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@VerifyBy", SqlDbType.VarChar,20)
                };
            parms[0].Value = entity.InspectionId;
            parms[1].Value = entity.MRBVerifyBy;
            ComMethod.Edit("uspIQCMRBVerify", parms);
        }
        /// <summary>
        /// 获取MRB明细信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public IList<MaterialIQCInfo> GetMRBGRNList(MaterialIQCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int)
                };
            parms[0].Value = entity.InspectionId;
            return ComMethod.GetList<MaterialIQCInfo>("uspGetMRBGrnList", parms);
        }

        /// <summary>
        /// MRB结案
        /// </summary>
        /// <param name="entity"></param>
        public void RMBCloseCase(MaterialIQCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@DealRemark", SqlDbType.NVarChar,200),
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar,50)
                };
            parms[0].Value = entity.InspectionId;
            parms[1].Value = entity.DealRemark;
            parms[2].Value = entity.CloseCaseBy;
            ComMethod.Edit("uspRMBCloseCase", parms);
        }
        /// <summary>
        /// 删除IQC检验单
        /// </summary>
        /// <param name="entity"></param>
        public void DeleteIQC(MaterialIQCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar,50)
                };
            parms[0].Value = entity.InspectionId;
            parms[1].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteIQC", parms);
        }


        /// <summary>
        /// IQC合格率及不良分布看板—IQC来料合格率
        /// </summary>
        /// <returns></returns>
        public DataTable GetIQCPassRateAndBadDistributionKanbanInCome()
        {
            return ComMethod.GetDataTableList("uspGetIQCPassRateAndBadDistributionKanbanInCome", null);
        }

        /// <summary>
        /// IQC合格率及不良分布看板—来料不良分布
        /// </summary>
        /// <returns></returns>
        public DataTable GetIQCPassRateAndBadDistributionKanbanNGDistribute()
        {
            return ComMethod.GetDataTableList("uspGetIQCPassRateAndBadDistributionKanbanNGDistribute", null);
        }


        /// <summary>
        /// 删除IQC检验单
        /// </summary>
        /// <param name="entity"></param>
        public void CheckMRBEndDal(string QCOrder, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@Inspection", SqlDbType.VarChar,50),
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar,50)
                };
            parms[0].Value = QCOrder;
            parms[1].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckMRBEndSing", parms);
        }

        /// <summary>
        /// MRB撤回
        /// </summary>
        /// <param name="entity"></param>
        public void MRBWithdraw(MaterialIQCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@WithdrawBy", SqlDbType.VarChar,20)
                };
            parms[0].Value = entity.InspectionId;
            parms[1].Value = entity.MRBVerifyBy;
            ComMethod.Edit("uspIQCMRBWithdraw", parms);
        }

        public string GetReceiveOrderBySNDal(string grnCode, int choosePageId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@GRNNo",SqlDbType.NVarChar,50),
                  new SqlParameter("@ChoosePageId",SqlDbType.Int),

            };
            parms[0].Value = grnCode;
            parms[1].Value = choosePageId;
            return ComMethod.GetList("uspGetReceiveOrderBySN", parms);
        }

        /// <summary>
        /// PC&PDA调拨入库
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string PDASaveTransferIn(int TransfersId, string TransfersNo, string UserName, string TransferDtlMaterial, string TransferInShelfGRN)
        {
            var msg = string.Empty;
            string erpTransferInNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.TransferStorage;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@TransfersId", TransfersId);
                    dp.Add("@TransfersNo", TransfersNo);
                    dp.Add("@UserName", UserName);
                    dp.Add("@TransferDtlMaterial", TransferDtlMaterial);
                    dp.Add("@TransferInShelfGRN", TransferInShelfGRN);
                    reader = conn.ExecuteReader("uspSaveTransferIn", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);

                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);
                    if (isWriteBack)
                    {
                        if (dtWrite == null || dtWrite.Rows.Count <= 0)
                        {
                            msg = "未获取到需要回写ERP数据";
                            throw new Exception(msg);
                        }
                        var mesNo = dtWrite.Rows[0]["billCode"].ToString();//MES调拨单号

                        //调用接口
                        ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, mesNo, UserName, dtEnterTime, dtAfterExecProcTime);

                        logList.Add(new WriteBackLogInfo
                        {
                            WriteBackCode = em.ToString(),
                            ERPMsg = info.Msg,
                            ERPResult = info.Result ? 1 : 0,
                            ERPNo = info.ERPNo,
                            MESBillNo = mesNo,
                            WriteBackData = info.SendInfo,
                            ReceiveData = info.ReceiveData,
                            EnterTime = dtEnterTime,
                            AfterExecProcTime = dtAfterExecProcTime,
                            AfterExecERPTime = info.dtAfterExecERPTime,
                            CreateDateTime = DateTime.Now
                        });

                        if (!info.Result)
                        {
                            //回写失败
                            throw new Exception(info.Msg);
                        }
                        else
                        {
                            erpTransferInNo = info.ERPNo;
                        }

                    }
                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw ex;
                }
                finally
                {
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    foreach (var log in logList)
                    {
                        WriteBackERP.AddWriteBackLog(conn, log);
                    }
                    conn.Close();
                }
            }
            return erpTransferInNo;
        }

    }
}