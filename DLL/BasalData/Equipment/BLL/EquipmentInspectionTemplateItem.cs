using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentInspectionTemplateItem
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionTemplateItem 信息。
        /// </summary>
        /// <param name="entity">InspectionTemplateItem 实体对象。</param>
        public Int32 Edit(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionTemplateItemId", SqlDbType.Int),
                new SqlParameter("@InspectionTemplateId", SqlDbType.Int),
                new SqlParameter("@EquipmentInspectionType", SqlDbType.NVarChar),
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar),
                new SqlParameter("@EquipmentTypeID", SqlDbType.Int),
                new SqlParameter("@MaintainWay", SqlDbType.Int),
                new SqlParameter("@CycleType", SqlDbType.Int),
                new SqlParameter("@Prewarning", SqlDbType.Int),
                new SqlParameter("@CycleTime", SqlDbType.Int),
                new SqlParameter("@OperionUser", SqlDbType.NVarChar),
                new SqlParameter("@ExceptionReportingId", SqlDbType.Int),
                new SqlParameter("@LastTime", SqlDbType.DateTime),
                new SqlParameter("@MaintainTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar),
            };

            parms[0].Direction = ParameterDirection.InputOutput;
            ComMethod.Edit<EquipmentInspectionTemplateItemInfo>(strJson, "Equipment_InspectionTemplateItem_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 InspectionTemplateItemId 字符串删除 InspectionTemplateItem 信息。
        /// </summary>
        /// <param name="idString">InspectionTemplateItemId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Equipment_InspectionTemplateItem_Delete");
        }

        /// <summary>
        /// 根据 InspectionTemplateItemId 获取实体信息。
        /// </summary>
        /// <param name="inspectionTemplateItemId">InspectionTemplateItemId。</param>
        /// <returns>InspectionTemplateItem 实体对象。</returns>
        public EquipmentInspectionTemplateItemInfo GetInfo(Int32 inspectionTemplateItemId)
        {
            return ComMethod.GetInfo<EquipmentInspectionTemplateItemInfo>(inspectionTemplateItemId, "Equipment_InspectionTemplateItem_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionTemplateItem 实体对象。</returns>
        public EquipmentInspectionTemplateItemInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<EquipmentInspectionTemplateItemInfo>(fieldValue, "Equipment_InspectionTemplateItem_GetInfo");
        }

        /// <summary>
        /// 分页获取 InspectionTemplateItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionTemplateItemCount">inspectionTemplateItem 总数。</param>
        /// <returns>InspectionTemplateItem 列表。</returns>
        public List<EquipmentInspectionTemplateItemInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentInspectionTemplateItemInfo> list = new List<EquipmentInspectionTemplateItemInfo>();
            //表名或者视图
            string strTb = "vwEquipmentInspectionTemplateItem";
            //主键
            string strKey = "InspectionTemplateItemId";
            //查询栏位字串
            string strColumns = @"[InspectionTemplateItemId], [InspectionTemplateId], [EquipmentInspectionType], [EquipmentCode], 
                [EquipmentName], [EquipmentTypeID], [EquipmentTypeName], [MaintainWay],CycleType,Prewarning,
                CycleTime,OperionUser,OperionUserName, ExceptionReportingId, ExceptionReportingName, LastTime, MaintainTime,CreateBy,CreateDateTime,ModifyBy,
                ModifyDateTime,MaintainWayStr,CycleTypeStr,ReportingUserName,InspectionTemplateName,PrewarningStr";
            list = ComMethod.GetComList<EquipmentInspectionTemplateItemInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 分页获取 InspectionTemplateItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionTemplateItemCount">inspectionTemplateItem 总数。</param>
        /// <returns>InspectionTemplateItem 列表。</returns>
        public List<EquipmentInspectionInfo> GetAllEquipmentInspectionList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentInspectionInfo> list = new List<EquipmentInspectionInfo>();
            //表名或者视图
            string strTb = "vwEquipmentInspectionList";
            //主键
            string strKey = "InspectionId";
            //查询栏位字串
            string strColumns = @"[InspectionId], [InspectionNo], [EquipmentCode], [EquipmentName], 
                [EquipmentTypeName], [Status], [StatusName], [Station],LineName,CreateDateTime,
                InspectionUserEmployeeNo,InspectionUserCName,InspectionUser, InspectionResultName, InspectionTime, OpertionUserCName, OpertionUser,InspectionResult,
                AuditUser,AuditUserName,AuditResult,AuditResultName,AuditDateTime,AuditRemark,JoinInspectionNo,SecondAuditUserName,SecondAuditResult,SecondAuditDate,SecondAuditNote";
            list = ComMethod.GetComList<EquipmentInspectionInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 分页获取 InspectionTemplateItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionTemplateItemCount">inspectionTemplateItem 总数。</param>
        /// <returns>InspectionTemplateItem 列表。</returns>
        public List<EquipmentInspectionInfo> GetAllEquipmentInspectionHistoryList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentInspectionInfo> list = new List<EquipmentInspectionInfo>();
            //表名或者视图
            string strTb = "vwEquipmentInspectionHistoryList";
            //主键
            string strKey = "InspectionId";
            //查询栏位字串
            string strColumns = @"[InspectionId], [InspectionNo], [EquipmentCode], [EquipmentName], 
                [EquipmentTypeName], [Status], [StatusName], [Station],LineName,CreateDateTime,
                InspectionUserEmployeeNo,InspectionUserCName,InspectionUser, InspectionResultName, InspectionTime, OpertionUserCName, OpertionUser,InspectionResult,HistoryOptionUserName,HistoryOptionType,HistoryOptionDate";
            list = ComMethod.GetComList<EquipmentInspectionInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 获取设备保养信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public EquipmentInspectionInfo GetEquipmentMaintenanceInfo(EquipmentInspectionInfo entity)
        {
            string sql = @"SELECT
                                    [InspectionId], [InspectionNo], [EquipmentCode], [EquipmentName], 
                                    [EquipmentTypeName], [Status], [StatusName], [Station],LineName,CreateDateTime,
                                    InspectionUserEmployeeNo,InspectionUserCName,InspectionUser, InspectionResultName, InspectionTime, OpertionUserCName, OpertionUser,InspectionResult,CycleType,WorkShift,WorkShiftName
                           FROM vwEquipmentInspectionList";

            SqlParameter[] parms = null;
            if (!string.IsNullOrWhiteSpace(entity.InspectionNo))
            {
                //根据检验单号查询
                sql += " WHERE InspectionNo = @InspectionNo";
                parms = new SqlParameter[]
                {
                    new SqlParameter("@InspectionNo", SqlDbType.VarChar, 50) { Value = entity.InspectionNo },
                };
            }
            else
            {
                //根据检验单Id查询
                sql += " WHERE InspectionId = @InspectionId";
                parms = new SqlParameter[]
                {
                    new SqlParameter("@InspectionId", SqlDbType.Int) { Value = entity.InspectionId },
                };
            }
            return ComMethod.GetBySql<EquipmentInspectionInfo>(sql, parms);
        }

        /// <summary>
        /// 根据检验单Id获取检验项信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<EquipmentInspectionTemplateDetailInfo> GetEquipmentInspectionTemplateDetail(EquipmentInspectionTemplateDetailInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionOrderId", SqlDbType.Int) { Value = entity.InspectionId },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            return ComMethod.GetList<EquipmentInspectionTemplateDetailInfo>("uspGetInspectionTemplateDetail", parms);
        }

        /// <summary>
        /// IQC来料检验—更新检验结果
        /// </summary>
        /// <param name="entity"></param>
        public EquipmentInspectionTemplateDetailInfo UpdateInspectionItemResult(EquipmentInspectionTemplateDetailInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionOrderOATemplateDetailId", SqlDbType.Int) { Value = entity.InspectionOrderOATemplateDetailId },
                new SqlParameter("@Result", SqlDbType.Int) { Value = entity.Result },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUpdateInspectionItemResult", parms);
            return ComMethod.Get<EquipmentInspectionTemplateDetailInfo>("uspUpdateInspectionItemResult", parms);
        }

        /// <summary>
        /// 上传文件
        /// </summary>
        public void UploadTemplateItemFile(EquipmentInspectionInfo entity, int inspectionOrderOATemplateDetailId, int fileType, string inspectionFileName, string inspectionFileUrl)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionId", SqlDbType.Int) { Value = entity.InspectionId },
                new SqlParameter("@InspectionOrderOATemplateDetailId", SqlDbType.Int) { Value = inspectionOrderOATemplateDetailId },
                new SqlParameter("@FileType", SqlDbType.Int) { Value = fileType },
                new SqlParameter("@InspectionFileName", SqlDbType.VarChar, 500) { Value = inspectionFileName },
                new SqlParameter("@InspectionFileUrl", SqlDbType.VarChar, 500) { Value = inspectionFileUrl },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50) { Value = entity.ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentInspectionFileEdit", parms);
        }
        /// <summary>
        /// 设备点检模板，检验明细上传文件
        /// </summary>
        public void EquipmentTemplateItemFileUpload(int InspectionTemplateId, int InspectionItemId, string inspectionFileName, string inspectionFileUrl, string ModifyBy)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionTemplateId", SqlDbType.Int) { Value = InspectionTemplateId },
                new SqlParameter("@InspectionItemId", SqlDbType.Int) { Value = InspectionItemId },
                new SqlParameter("@InspectionFileName", SqlDbType.VarChar, 500) { Value = inspectionFileName },
                new SqlParameter("@InspectionFileUrl", SqlDbType.VarChar, 500) { Value = inspectionFileUrl },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50) { Value = ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentTemplateItemFileUploadEdit", parms);
        }

        /// <summary>
        /// 设备保养—检验完成
        /// </summary>
        /// <param name="entity"></param>
        public void InspectionEquipmentComplete(EquipmentInspectionInfo entity, int flag)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionOrderId", SqlDbType.Int) { Value = entity.InspectionId },
                new SqlParameter("@WorkShift", SqlDbType.Int) { Value = entity.WorkShift },
                new SqlParameter("@InspectionResult", SqlDbType.Int) { Value = entity.InspectionResult },
                new SqlParameter("@Instrument", SqlDbType.NVarChar, 500) { Value = entity.Instrument },
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500) { Value = entity.Remark },
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20) { Value = entity.ModifyBy },
                new SqlParameter("@Flag", SqlDbType.Int) { Value = flag },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspInspectionEquipmentComplete", parms);
        }

        /// <summary>
        /// 设备保养—设备停机，无需保养
        /// </summary>
        /// <param name="entity"></param>
        public void InspectionEquipmentNoMaintenance(EquipmentInspectionInfo entity, string ids)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionOrderIds", SqlDbType.VarChar, 4000) { Value = ids },
                new SqlParameter("@InspectionType", SqlDbType.Int) { Value = 12 },
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20) { Value = entity.ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspInspectionEquipmentNoMaintenance", parms);
        }

        /// <summary>
        /// 获取设备保养单PDF报表文档--获取PDF字符流
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public byte[] GetEquipmentMaintenancePdfByte(int intId, string strXmlFilePath, string strImgPath)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionOrderId", SqlDbType.Int),
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar,20),
                };
            parms[0].Value = intId;
            parms[1].Value = string.Empty;

            var ds = ComMethod.GetListDataSet("uspGetEquipmentMaintenanceInfo", parms, "dtMaintenance");

            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        /// <summary>
        /// 更改检验项备注
        /// </summary>
        /// <param name="entity"></param>
        public int UpdateInspectionItemRemark(EquipmentInspectionTemplateDetailInfo entity)
        {
            string sql = @"UPDATE qod SET qod.Remark = @Remark,qod.ModifyBy = @ModifyBy,qod.ModifyDateTime = GETDATE()
            FROM dbo.Quality_InspectionOrderOATemplateDetail qod 
            INNER JOIN dbo.Prod_EquipmentInspectionTemplate qot ON qod.InspectionOrderOATemplateId = qot.InspectionTemplateId
            WHERE qod.InspectionOrderOATemplateDetailId = @InspectionOrderOATemplateDetailId;";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@Remark", SqlDbType.NVarChar,500) { Value = entity.Remark },
                new SqlParameter("@InspectionOrderOATemplateDetailId", SqlDbType.Int) { Value = entity.InspectionOrderOATemplateDetailId },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            return SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sql, parms);
        }

        /// <summary>
        /// 更改设备保养检验项备注和判定结果
        /// </summary>
        /// <param name="entity"></param>
        public int UpdateMaintenanceDemoSubDesc(EquipmentInspectionTemplateDetailInfo entity)
        {
            //string sql = @"UPDATE C SET C.[Description] = @Description
            //    FROM Prod_MaintenanceRelation AS A inner JOIN
            //    Prod_MaintenanceDemo AS B ON A.DemoId=B.DemoId
            //    INNER JOIN dbo.Prod_MaintenanceDemoSub AS C ON C.DemoId = B.DemoId AND a.DemoSubId = c.DemoSubId
            //    WHERE A.EId=@EId AND c.DemoId = @DemoId AND c.DemoSubId = @DemoSubId ;";
            //SqlParameter[] parms = new SqlParameter[]
            //{
            //    new SqlParameter("@Eid",SqlDbType.Int) { Value = entity.Eid },
            //    new SqlParameter("@DemoId",  SqlDbType.Int ) { Value = entity.DemoId },
            //    new SqlParameter("@DemoSubId", SqlDbType.Int) { Value = entity.DemoSubId },
            //    new SqlParameter("@Description",SqlDbType.NVarChar,500) { Value = entity.Description },
            //};
            //return SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sql, parms);

            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@Eid",SqlDbType.Int) { Value = entity.Eid },
                new SqlParameter("@DemoId",  SqlDbType.Int ) { Value = entity.DemoId },
                new SqlParameter("@DemoSubId", SqlDbType.Int) { Value = entity.DemoSubId },
                new SqlParameter("@Type", SqlDbType.Int) { Value = 1 },
                new SqlParameter("@IsDone", SqlDbType.Int) { Value = entity.IsDone },
                new SqlParameter("@Description",SqlDbType.NVarChar,500) { Value = entity.Description },
            };
            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUpdateMDS", parms);
        }

        /// <summary>
        /// 更改设备保养判定结果
        /// </summary>
        /// <param name="entity"></param>
        public int UpdateMaintenanceDemoSubIsDone(EquipmentInspectionTemplateDetailInfo entity)
        {
            //string sql = @"UPDATE A SET A.IsDone = @IsDone
            //    FROM Prod_MaintenanceRelation AS A inner JOIN
            //    Prod_MaintenanceDemo AS B ON A.DemoId=B.DemoId
            //    INNER JOIN dbo.Prod_MaintenanceDemoSub AS C ON C.DemoId = B.DemoId AND a.DemoSubId = c.DemoSubId
            //    WHERE A.EId=@EId AND c.DemoId = @DemoId AND c.DemoSubId = @DemoSubId ;";
            //SqlParameter[] parms = new SqlParameter[]
            //{
            //    new SqlParameter("@Eid", SqlDbType.Int) { Value = entity.Eid },
            //    new SqlParameter("@DemoId", SqlDbType.Int) { Value = entity.DemoId },
            //    new SqlParameter("@DemoSubId", SqlDbType.Int) { Value = entity.DemoSubId },
            //    new SqlParameter("@IsDone", SqlDbType.Int) { Value = entity.IsDone },
            //};
            //return SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sql, parms);
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@Eid",SqlDbType.Int) { Value = entity.Eid },
                new SqlParameter("@DemoId",  SqlDbType.Int ) { Value = entity.DemoId },
                new SqlParameter("@DemoSubId", SqlDbType.Int) { Value = entity.DemoSubId },
                new SqlParameter("@Type", SqlDbType.Int) { Value = 2 },
                new SqlParameter("@IsDone", SqlDbType.Int) { Value = entity.IsDone },
                new SqlParameter("@Description",SqlDbType.NVarChar,500) { Value = entity.Description },
            };
            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUpdateMDS", parms);
        }
        /// <summary>
        /// IQC—结果录入—获取检验单检验项信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public EquipmentInspectionTemplateDetailInfo GetInspectionOrderOATemplateDetailInfo(EquipmentInspectionTemplateDetailInfo entity)
        {
            string sql = @"SELECT 
	                            qod.InspectionOrderOATemplateDetailId,qod.InspectionOrderOATemplateId,qod.InspectionTypeName,qod.AQLRuleName,qod.InspectionItemName,qod.InspectionCycle,qod.InspectionMethod,
	                            qod.DataType,qod.MinValueFlag,qod.MaxValueFlag,qod.AvgValueFlag,qod.FixResultFlag,qod.StandardValue,qod.Unit,qod.OutPutDataFlag,qod.OutPutImageFlag,qod.OutPutFileFlag,qod.SamplingQty,
	                            qod.TestBy,qod.TestEquipment,qod.InspectionData,qod.MinValue,qod.MaxValue,qod.AvgValue,qod.InspectionImageName,qod.InspectionImageUrl,qod.InspectionFileName,qod.InspectionFileUrl,qod.InspectionItemQty,qod.InspectionItemNGQty,qod.Result,
	                            qod.Remark,qod.InspectionNGImageName,qod.InspectionNGImageUrl,qod.RowNum,
                                qod.InspectionItemRecordTime,qod.IPQCResult,qod.IPQCConfirmTime,qod.IPQCRemark,qod.IPQCConfirmBy,qod.InspectionItemType,qod.SampleType
                            FROM dbo.Quality_InspectionOrderOATemplateDetail qod 
                            INNER JOIN dbo.Prod_EquipmentInspectionTemplate qot ON qod.InspectionOrderOATemplateId = qot.InspectionTemplateId
                            WHERE qod.InspectionOrderOATemplateDetailId = @InspectionOrderOATemplateDetailId";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionOrderOATemplateDetailId", SqlDbType.Int){ Value = entity.InspectionOrderOATemplateDetailId },
            };

            parms[0].Value = entity.InspectionOrderOATemplateDetailId;
            return ComMethod.GetBySql<EquipmentInspectionTemplateDetailInfo>(sql, parms);
        }
        /// <summary>
        /// 设备保养—结果录入—获取检验信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public EquipmentInspectionTemplateDetailInfo GetMintenanceOATemplateDetailInfo(EquipmentInspectionTemplateDetailInfo entity)
        {
            string sql = @"SELECT A.RelationId InspectionOrderOATemplateDetailId,(  CASE WHEN ISNUMERIC(C.DemoSubCode) = 1 THEN CAST(C.DemoSubCode AS int) ELSE 0 END  )   AS InspectionOrderOATemplateId, C.DemoSubName InspectionItemName, ISNULL(CAST(C.InspectionMethodId AS VARCHAR(20)), '') InspectionMethod, ISNULL(C.InspectionMethodId, 0) FixResultFlag
            , ISNULL(C.UnitName, '') Unit, A.IsDone Result, ISNULL(d.InspectionMethodValue, '') StandardValue, CAST(-1 AS DECIMAL(18,0)) MaxValue, CAST(-1 AS DECIMAL(18,0)) MinValue, CAST(-1 AS DECIMAL(18,0)) AvgValue
            FROM Prod_MaintenanceRelation AS A
            INNER JOIN Prod_MaintenanceDemo AS B ON A.DemoId=B.DemoId
            INNER JOIN dbo.Prod_MaintenanceDemoSub AS C ON C.DemoId=B.DemoId AND A.DemoSubId=C.DemoSubId
            INNER JOIN Prod_MaintenancePlanRelation AS d ON d.PlanId = A.PlanId AND d.DemoId = A.DemoId AND d.DemoSubId = A.DemoSubId
            WHERE A.RelationId = @InspectionOrderOATemplateDetailId;";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionOrderOATemplateDetailId", SqlDbType.Int){ Value = entity.InspectionOrderOATemplateDetailId},
            };

            parms[0].Value = entity.InspectionOrderOATemplateDetailId;
            return ComMethod.GetBySql<EquipmentInspectionTemplateDetailInfo>(sql, parms);
        }

        /// <summary>
        /// IQC—结果录入—获取检验单检验项已检验的SN信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<InspectionOrderSNInfo> GetInspectionOrderSN(EquipmentInspectionTemplateDetailInfo entity)
        {
            string sql = @"SELECT
                               qsn.InspectionOrderSNId, qsn.InspectionOrderId, qsn.InspectionNo, qsn.InspectionOrderOATemplateDetailId, qsn.SerialNumber, qsn.InputValue, qsn.Result, qsn.NcCode, qsn.Remark,
                               qsn.DeleteFlag, qsn.CreateBy, qsn.CreateTime, qsn.ModifyBy, qsn.ModifyTime , ISNULL(qsn.CalcWay,-1) CalcWay, ISNULL(qsn.InputValue1,'') InputValue1, ISNULL(qsn.InputValue2,'') InputValue2
                           FROM dbo.Quality_InspectionOrderSN qsn
                           WHERE qsn.DeleteFlag = 0 AND qsn.InspectionOrderOATemplateDetailId = @InspectionOrderOATemplateDetailId";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionOrderOATemplateDetailId", SqlDbType.Int){ Value = entity.InspectionOrderOATemplateDetailId },
            };

            parms[0].Value = entity.InspectionOrderOATemplateDetailId;
            return ComMethod.GetListBySql<InspectionOrderSNInfo>(sql, parms);
        }

        /// <summary>
        /// 设备保养—结果录入—获取检验单检验项已检验的SN信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<InspectionOrderSNInfo> GetMintenanceOrderSN(EquipmentInspectionTemplateDetailInfo entity)
        {
            string sql = @"SELECT
                               qsn.MintenanceOrderSNId, qsn.MintenanceOrderId, qsn.MintenanceNo, qsn.MintenanceOrderOATemplateDetailId, qsn.SerialNumber, qsn.InputValue, qsn.Result, qsn.NcCode, qsn.Remark,
                               qsn.DeleteFlag, qsn.CreateBy, qsn.CreateTime, qsn.ModifyBy, qsn.ModifyTime , ISNULL(qsn.CalcWay,-1) CalcWay, ISNULL(qsn.InputValue1,'') InputValue1, ISNULL(qsn.InputValue2,'') InputValue2
                           FROM dbo.Quality_MintenanceOrderSN qsn
                           WHERE qsn.DeleteFlag = 0 AND qsn.MintenanceOrderOATemplateDetailId = @InspectionOrderOATemplateDetailId";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionOrderOATemplateDetailId", SqlDbType.Int){ Value = entity.InspectionOrderOATemplateDetailId },
            };

            parms[0].Value = entity.InspectionOrderOATemplateDetailId;
            return ComMethod.GetListBySql<InspectionOrderSNInfo>(sql, parms);
        }

        /// <summary>
        /// 设备保养—结果录入—保存GRN检验记录
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="dt"></param>
        public void SaveMintenanceGRN(EquipmentInspectionTemplateDetailInfo entity, DataTable dt)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                        new SqlParameter("@InspectionOrderOATemplateDetailId", SqlDbType.Int) { Value = entity.InspectionOrderOATemplateDetailId },
                        new SqlParameter("@InspectionGRN", SqlDbType.Structured) { Value = dt },
                        new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveMintenanceGRN", parms);
        }


        /// <summary>
        /// IQC—结果录入—保存GRN检验记录
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="dt"></param>
        public void SaveInspectionGRN(EquipmentInspectionTemplateDetailInfo entity, DataTable dt)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                        new SqlParameter("@InspectionOrderOATemplateDetailId", SqlDbType.Int) { Value = entity.InspectionOrderOATemplateDetailId },
                        new SqlParameter("@InspectionGRN", SqlDbType.Structured) { Value = dt },
                        new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveInspectionGRN", parms);
        }

        /// <summary>
        /// IQC—清除GRN检验记录
        /// </summary>
        /// <param name="entity"></param>
        public void DeleteInspectionGRN(EquipmentInspectionTemplateDetailInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@InspectionOrderOATemplateDetailId", SqlDbType.Int) { Value = entity.InspectionOrderOATemplateDetailId },
                new SqlParameter("@UpdateResultFlag", SqlDbType.Int) { Value = 1 },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteInspectionGRN", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


    }
}