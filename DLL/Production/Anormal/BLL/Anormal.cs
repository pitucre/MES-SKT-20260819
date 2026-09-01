using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.ProdAnormal.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.ComponentModel;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.ProdAnormal.BLL
{
    public class Anormal
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Anormal 信息。
        /// </summary>
        /// <param name="entity">Anormal 实体对象。</param>
        public Int32 Edit(AnormalInfo2 entity, bool isSendMsg= false,int flag = 0)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AnormalId", SqlDbType.Int),
                new SqlParameter("@AnormalTypeId", SqlDbType.Int),
                new SqlParameter("@AnormalObject", SqlDbType.NVarChar, 500),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@OpeId", SqlDbType.Int),
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@Owner", SqlDbType.NVarChar, 50),
                new SqlParameter("@DeptId", SqlDbType.VarChar, 50),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@StartTime", SqlDbType.DateTime),
                new SqlParameter("@EndTime", SqlDbType.DateTime),
                new SqlParameter("@Descriptions", SqlDbType.NVarChar, 500),
                new SqlParameter("@IsLineStop", SqlDbType.Bit),
                new SqlParameter("@LineStopTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@Shift", SqlDbType.Int),
                new SqlParameter("@RCCA", SqlDbType.VarChar, 200),
                new SqlParameter("@ActionPerson",SqlDbType.NVarChar,30),
                new SqlParameter("@Solution",SqlDbType.NVarChar,500),
                new SqlParameter("@ActionTime",SqlDbType.DateTime),
                new SqlParameter("@AbnormalTimeLength",SqlDbType.Float),
                new SqlParameter("@AbnormalUnit",SqlDbType.NVarChar,20),
                new SqlParameter("@EffectPerson",SqlDbType.Decimal,18),
                new SqlParameter("@TempSolution", SqlDbType.NVarChar),
                new SqlParameter("@PermanentSolution", SqlDbType.NVarChar),
                new SqlParameter("@CauseAnalysis", SqlDbType.NVarChar),
                new SqlParameter("@PushInformation", SqlDbType.NVarChar),

                new SqlParameter("@AbnormalDocumentNo", SqlDbType.NVarChar),
                new SqlParameter("@OrderQty", SqlDbType.Int),
                new SqlParameter("@ProductIntoQty", SqlDbType.Int),
                new SqlParameter("@BadQty", SqlDbType.Int),
                new SqlParameter("@BadRate", SqlDbType.Decimal,18),
                new SqlParameter("@MachineModel", SqlDbType.NVarChar),
                new SqlParameter("@Source", SqlDbType.NVarChar),
                new SqlParameter("@IPQCConfirmer", SqlDbType.NVarChar),
                new SqlParameter("@PECauseAnalysisMan", SqlDbType.NVarChar),
                new SqlParameter("@PECauseAnalysisTime", SqlDbType.DateTime),
                new SqlParameter("@AnormalItemCode", SqlDbType.NVarChar),
                new SqlParameter("@AnormalItemName", SqlDbType.NVarChar),
                new SqlParameter("@TempTreatmentScheme", SqlDbType.NVarChar),
                new SqlParameter("@InventoryMaterialHandlingMethod", SqlDbType.NVarChar),
                new SqlParameter("@OutputHandlingMethod", SqlDbType.NVarChar),
                new SqlParameter("@PackedHandlingMethod", SqlDbType.NVarChar),
                new SqlParameter("@TempHandler", SqlDbType.NVarChar),
                new SqlParameter("@TempHandleTime", SqlDbType.DateTime),
                new SqlParameter("@FinalBadRate", SqlDbType.Decimal),
                new SqlParameter("@DutyDept", SqlDbType.NVarChar),
                new SqlParameter("@DutyMan", SqlDbType.NVarChar),
                new SqlParameter("@QEConfirmer", SqlDbType.NVarChar),
                new SqlParameter("@QEConfirmTime", SqlDbType.DateTime),
                new SqlParameter("@ImproveMaker", SqlDbType.NVarChar),
                new SqlParameter("@ImproveTime", SqlDbType.DateTime),
                new SqlParameter("@CountermeasureTracking", SqlDbType.NVarChar),
                new SqlParameter("@Closed", SqlDbType.NVarChar),
                new SqlParameter("@QAFinalConfirm", SqlDbType.NVarChar),
                new SqlParameter("@QAFinalConfirmTime", SqlDbType.DateTime),
                new SqlParameter("@Supplier", SqlDbType.NVarChar),
                new SqlParameter("@Supervisor",SqlDbType.NVarChar,20),
                new SqlParameter("@SolutionFinished",SqlDbType.BigInt),
                new SqlParameter("@AbnormalProposer",SqlDbType.NVarChar),
                new SqlParameter("@IsSendMsg",SqlDbType.Bit),
                new SqlParameter("@AnormalNameId",SqlDbType.Int),
                new SqlParameter("@Flag", SqlDbType.Int) { Value = flag }
        };

            parms[0].Value = entity.AnormalId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AnormalTypeId;
            parms[2].Value = entity.AnormalObject;
            parms[3].Value = entity.LineId;
            parms[4].Value = entity.OpeId;
            parms[5].Value = entity.UserId;
            parms[6].Value = entity.Owner;
            parms[7].Value = entity.DeptId;
            parms[8].Value = entity.Status;
            parms[9].Value = entity.StartTime;
            parms[10].Value = entity.EndTime;
            parms[11].Value = entity.Descriptions;
            parms[12].Value = entity.IsLineStop;
            parms[13].Value = entity.LineStopTime;
            parms[14].Value = entity.CreateBy;
            parms[15].Value = entity.ModifyBy;
            parms[16].Value = entity.Remark;
            parms[17].Value = entity.Shift;
            parms[18].Value = entity.RCCA;
            parms[19].Value = entity.ActionPerson;
            parms[20].Value = entity.Solution;
            parms[21].Value = entity.ActionTime;
            parms[22].Value = entity.AbnormalTimeLength;
            parms[23].Value = entity.AbnormalUnit;
            parms[24].Value = entity.EffectPerson;
            parms[25].Value = entity.TempSolution;
            parms[26].Value = entity.PermanentSolution;
            parms[27].Value = entity.CauseAnalysis;
            parms[28].Value = entity.PushInformation;

            parms[29].Value = entity.AbnormalDocumentNo;
            parms[30].Value = entity.OrderQty;
            parms[31].Value = entity.ProductIntoQty;
            parms[32].Value = entity.BadQty;
            parms[33].Value = entity.BadRate;
            parms[34].Value = entity.MachineModel;
            parms[35].Value = entity.Source;
            parms[36].Value = entity.IPQCConfirmer;
            parms[37].Value = entity.PECauseAnalysisMan;
            parms[38].Value = entity.PECauseAnalysisTime;
            parms[39].Value = entity.AnormalItemCode;
            parms[40].Value = entity.AnormalItemName;
            parms[41].Value = entity.TempTreatmentScheme;
            parms[42].Value = entity.InventoryMaterialHandlingMethod;
            parms[43].Value = entity.OutputHandlingMethod;
            parms[44].Value = entity.PackedHandlingMethod;
            parms[45].Value = entity.TempHandler;
            parms[46].Value = entity.TempHandleTime;
            parms[47].Value = entity.FinalBadRate;
            parms[48].Value = entity.DutyDept;
            parms[49].Value = entity.DutyMan;
            parms[50].Value = entity.QEConfirmer;
            parms[51].Value = entity.QEConfirmTime;
            parms[52].Value = entity.ImproveMaker;
            parms[53].Value = entity.ImproveTime;
            parms[54].Value = entity.CountermeasureTracking;
            parms[55].Value = entity.Closed;
            parms[56].Value = entity.QAFinalConfirm;
            parms[57].Value = entity.QAFinalConfirmTime;
            parms[58].Value = entity.Supplier;
            parms[59].Value = entity.Supervisor;
            parms[60].Value = entity.SolutionFinished;
            parms[61].Value = entity.AbnormalProposer;
            parms[62].Value = isSendMsg;
            parms[63].Value = entity.AnormalNameId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Anormal_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AnormalId 字符串删除 Anormal 信息。
        /// </summary>
        /// <param name="idString">AnormalId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Anormal_Delete", parms);
        }

        /// <summary>
        /// 根据 tabletestId 获取实体信息。
        /// </summary>
        /// <param name="tabletestId">tabletestId。</param>
        /// <returns>tabletest 实体对象。</returns>
        public AnormalInfo2 GetInfo(Int32 tabletestId)
        {
            AnormalInfo2 entity = new AnormalInfo2(); ;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = tabletestId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Anormal_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity.AnormalId = rdr.GetInt32(0);
                    entity.AnormalTypeId = rdr.GetInt32(1);
                    entity.AnormalObject = rdr.GetString(2);
                    entity.LineId = rdr.GetInt32(3);
                    entity.OpeId = rdr.GetInt32(4);
                    entity.UserId = rdr.GetInt32(5);
                    entity.Owner = rdr.GetString(6);
                    entity.DeptId = rdr.GetString(7);
                    entity.Status = rdr.GetInt32(8);
                    entity.StartTime = ComMethod.FromDatabase<DateTime?>(rdr["StartTime"]);
                    entity.EndTime = ComMethod.FromDatabase<DateTime?>(rdr["EndTime"]);
                    entity.Descriptions = rdr.GetString(11);
                    entity.IsLineStop = rdr.GetBoolean(12);
                    entity.LineStopTime = ComMethod.FromDatabase<DateTime?>(rdr["LineStopTime"]);
                    entity.CreateBy = rdr.GetString(14);
                    entity.CreateDateTime = ComMethod.FromDatabase<DateTime?>(rdr["CreateDateTime"]);
                    entity.Remark = rdr.GetString(16);
                    entity.Shift = rdr.GetInt32(17);
                    entity.RCCA = rdr.GetString(18);
                    entity.SolutionId = rdr.GetInt32(19);
                    entity.ActionPerson = rdr.GetString(20);
                    entity.Solution = rdr.GetString(21);
                    entity.ActionTime = ComMethod.FromDatabase<DateTime?>(rdr["ActionTime"]);
                    entity.AbnormalTimeLength = rdr.GetDouble(23);
                    entity.AbnormalUnit = rdr.GetString(24);
                    entity.EffectPerson = rdr.GetDecimal(25);
                    entity.AnormalTypeCode = rdr.GetString(26);
                    entity.AnormalTypeName = rdr.GetString(27);
                    entity.Station = rdr.GetString(28);
                    entity.CName = rdr.GetString(29);
                    entity.LineName = rdr.GetString(30);

                    entity.DeptName = rdr.GetString(31);
                    entity.AuditPerson = rdr.GetString(32);
                    entity.AuditTime = ComMethod.FromDatabase<DateTime?>(rdr["AuditTime"]);
                    entity.AuditRemark = rdr.GetString(34);
                    entity.TempSolution = rdr.GetString(35);
                    entity.PermanentSolution = rdr.GetString(36);
                    entity.CauseAnalysis = rdr.GetString(37);
                    entity.PushInformation = rdr.GetString(38);


                    entity.AbnormalDocumentNo = rdr.GetString(39);
                    entity.OrderQty = rdr.GetInt32(40);
                    entity.ProductIntoQty = rdr.GetInt32(41);
                    entity.BadQty = rdr.GetInt32(42);
                    entity.BadRate = rdr.GetDecimal(43);
                    entity.MachineModel = rdr.GetString(44);
                    entity.Source = rdr.GetString(45);
                    entity.IPQCConfirmer = rdr.GetString(46);
                    entity.PECauseAnalysisMan = rdr.GetString(47);
                    entity.PECauseAnalysisTime = ComMethod.FromDatabase<DateTime?>(rdr["PECauseAnalysisTime"]);
                    entity.AnormalItemCode = rdr.GetString(49);
                    entity.AnormalItemName = rdr.GetString(50);
                    entity.TempTreatmentScheme = rdr.GetInt32(51);
                    entity.InventoryMaterialHandlingMethod = rdr.GetInt32(52);
                    entity.OutputHandlingMethod = rdr.GetInt32(53);
                    entity.PackedHandlingMethod = rdr.GetInt32(54);
                    entity.TempHandler = rdr.GetString(55);
                    entity.TempHandleTime = ComMethod.FromDatabase<DateTime?>(rdr["TempHandleTime"]);
                    entity.FinalBadRate = rdr.GetDecimal(57);
                    entity.DutyDept = rdr.GetString(58);
                    entity.DutyMan = rdr.GetString(59);
                    entity.QEConfirmer = rdr.GetString(60);
                    entity.QEConfirmTime = ComMethod.FromDatabase<DateTime?>(rdr["QEConfirmTime"]);
                    entity.ImproveMaker = rdr.GetString(62);
                    entity.ImproveTime = ComMethod.FromDatabase<DateTime?>(rdr["ImproveTime"]);
                    entity.CountermeasureTracking = rdr.GetString(64);
                    entity.Closed = rdr.GetInt32(65);
                    entity.QAFinalConfirm = rdr.GetString(66);
                    entity.QAFinalConfirmTime = ComMethod.FromDatabase<DateTime?>(rdr["QAFinalConfirmTime"]);
                    entity.Supplier = rdr.GetString(68);
                    entity.Supervisor = rdr.GetString(69);
                    entity.AbnormalProposer = Convert.ToString(rdr["AbnormalProposer"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.ModifyDateTime = ComMethod.FromDatabase<DateTime?>(rdr["ModifyDateTime"]);
                    entity.AnormalNameId = Convert.ToInt32(rdr["AnormalNameId"]);
                    entity.AnormalName = Convert.ToString(rdr["AnormalName"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>tabletest 实体对象。</returns>
        public AnormalInfo2 GetInfo(String fieldValue)
        {
            AnormalInfo2 entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Anormal_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity.AnormalId = rdr.GetInt32(0);
                    entity.AnormalTypeId = rdr.GetInt32(1);
                    entity.AnormalObject = rdr.GetString(2);
                    entity.LineId = rdr.GetInt32(3);
                    entity.OpeId = rdr.GetInt32(4);
                    entity.UserId = rdr.GetInt32(5);
                    entity.Owner = rdr.GetString(6);
                    entity.DeptId = rdr.GetString(7);
                    entity.Status = rdr.GetInt32(8);
                    entity.StartTime = ComMethod.FromDatabase<DateTime?>(rdr["StartTime"]);
                    entity.EndTime = ComMethod.FromDatabase<DateTime?>(rdr["EndTime"]);
                    entity.Descriptions = rdr.GetString(11);
                    entity.IsLineStop = rdr.GetBoolean(12);
                    entity.LineStopTime = ComMethod.FromDatabase<DateTime?>(rdr["LineStopTime"]);
                    entity.CreateBy = rdr.GetString(14);
                    entity.CreateDateTime = ComMethod.FromDatabase<DateTime?>(rdr["CreateDateTime"]);
                    entity.Remark = rdr.GetString(16);
                    entity.Shift = rdr.GetInt32(17);
                    entity.RCCA = rdr.GetString(18);
                    entity.SolutionId = rdr.GetInt32(19);
                    entity.ActionPerson = rdr.GetString(20);
                    entity.Solution = rdr.GetString(21);
                    entity.ActionTime = ComMethod.FromDatabase<DateTime?>(rdr["ActionTime"]);
                    entity.AbnormalTimeLength = rdr.GetDouble(23);
                    entity.AbnormalUnit = rdr.GetString(24);
                    entity.EffectPerson = rdr.GetDecimal(25);
                    entity.AnormalTypeCode = rdr.GetString(26);
                    entity.AnormalTypeName = rdr.GetString(27);
                    entity.Station = rdr.GetString(28);
                    entity.CName = rdr.GetString(29);
                    entity.LineName = rdr.GetString(30);

                    entity.DeptName = rdr.GetString(31);
                    entity.AuditPerson = rdr.GetString(32);
                    entity.AuditTime = ComMethod.FromDatabase<DateTime?>(rdr["AuditTime"]);
                    entity.AuditRemark = rdr.GetString(34);
                    entity.TempSolution = rdr.GetString(35);
                    entity.PermanentSolution = rdr.GetString(36);
                    entity.CauseAnalysis = rdr.GetString(37);
                    entity.PushInformation = rdr.GetString(38);

                    entity.AbnormalDocumentNo = rdr.GetString(39);
                    entity.OrderQty = rdr.GetInt32(40);
                    entity.ProductIntoQty = rdr.GetInt32(41);
                    entity.BadQty = rdr.GetInt32(42);
                    entity.BadRate = rdr.GetDecimal(43);
                    entity.MachineModel = rdr.GetString(44);
                    entity.Source = rdr.GetString(45);
                    entity.IPQCConfirmer = rdr.GetString(46);
                    entity.PECauseAnalysisMan = rdr.GetString(47);
                    entity.PECauseAnalysisTime = ComMethod.FromDatabase<DateTime?>(rdr["PECauseAnalysisTime"]);
                    entity.AnormalItemCode = rdr.GetString(49);
                    entity.AnormalItemName = rdr.GetString(50);
                    entity.TempTreatmentScheme = rdr.GetInt32(51);
                    entity.InventoryMaterialHandlingMethod = rdr.GetInt32(52);
                    entity.OutputHandlingMethod = rdr.GetInt32(53);
                    entity.PackedHandlingMethod = rdr.GetInt32(54);
                    entity.TempHandler = rdr.GetString(55);
                    entity.TempHandleTime = ComMethod.FromDatabase<DateTime?>(rdr["TempHandleTime"]);
                    entity.FinalBadRate = rdr.GetDecimal(57);
                    entity.DutyDept = rdr.GetString(58);
                    entity.DutyMan = rdr.GetString(59);
                    entity.QEConfirmer = rdr.GetString(60);
                    entity.QEConfirmTime = ComMethod.FromDatabase<DateTime?>(rdr["QEConfirmTime"]);
                    entity.ImproveMaker = rdr.GetString(62);
                    entity.ImproveTime = ComMethod.FromDatabase<DateTime?>(rdr["ImproveTime"]);
                    entity.CountermeasureTracking = rdr.GetString(64);
                    entity.Closed = rdr.GetInt32(65);
                    entity.QAFinalConfirm = rdr.GetString(66);
                    entity.QAFinalConfirmTime = ComMethod.FromDatabase<DateTime?>(rdr["QAFinalConfirmTime"]);
                    entity.Supplier = rdr.GetString(68);
                    entity.AbnormalProposer = Convert.ToString(rdr["AbnormalProposer"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.ModifyDateTime = ComMethod.FromDatabase<DateTime?>(rdr["ModifyDateTime"]);
                    entity.AnormalNameId = Convert.ToInt32(rdr["AnormalNameId"]);
                    entity.AnormalName = Convert.ToString(rdr["AnormalName"]);

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 tabletest 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="tabletestCount">tabletest 总数。</param>
        /// <returns>tabletest 列表。</returns>
        public List<AnormalInfo2> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AnormalInfo2> list = new List<AnormalInfo2>();
            AnormalInfo2 entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwAnormal", "AnormalId",
                "[AnormalId], [AnormalTypeId], [AnormalObject], [LineId], [OpeId], [UserId], [Owner], [DeptId], [Status], [StartTime], [EndTime], [Descriptions], [IsLineStop], [LineStopTime], [CreateBy], [CreateDateTime], [Remark], [Shift], [RCCA], [SolutionId], [ActionPerson], [Solution], [ActionTime], [AbnormalTimeLength], [AbnormalUnit], [EffectPerson], [AnormalTypeCode], [AnormalTypeName], [Station], [CName], [LineName], [DeptName],[AbnormalDocumentNo],AbnormalProposer,ModifyBy,ModifyDateTime,AnormalNameId,AnormalName,ResponseBy,ResponseTime,ProcessTimeLength,BoardFlag,CompleteBy,CompleteTime,CloseTimeLength,BoardFlagName,StatusName,IsLineStopName,AnormalContract,IsSend", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity=new AnormalInfo2();
                    entity.AnormalId = rdr.GetInt32(0);
                    entity.AnormalTypeId = rdr.GetInt32(1);
                    entity.AnormalObject = rdr.GetString(2);
                    entity.LineId = rdr.GetInt32(3);
                    entity.OpeId = rdr.GetInt32(4);
                    entity.UserId = rdr.GetInt32(5);
                    entity.Owner = rdr.GetString(6);
                    entity.DeptId = rdr.GetString(7);
                    entity.Status = rdr.GetInt32(8);
                    entity.StartTime = ComMethod.FromDatabase<DateTime?>(rdr["StartTime"]);
                    entity.EndTime = ComMethod.FromDatabase<DateTime?>(rdr["EndTime"]);
                    entity.Descriptions = rdr.GetString(11);
                    entity.IsLineStop = rdr.GetBoolean(12);
                    entity.LineStopTime = ComMethod.FromDatabase<DateTime?>(rdr["LineStopTime"]);
                    entity.CreateBy = rdr.GetString(14);
                    entity.CreateDateTime = ComMethod.FromDatabase<DateTime?>(rdr["CreateDateTime"]);
                    entity.Remark = rdr.GetString(16);
                    entity.Shift = rdr.GetInt32(17);
                    entity.RCCA = rdr.GetString(18);
                    entity.SolutionId = rdr.GetInt32(19);
                    entity.ActionPerson = rdr.GetString(20);
                    entity.Solution = rdr.GetString(21);
                    entity.ActionTime = ComMethod.FromDatabase<DateTime?>(rdr["ActionTime"]);
                    entity.AbnormalTimeLength = rdr.GetDouble(23);
                    entity.AbnormalUnit = rdr.GetString(24);
                    entity.EffectPerson = rdr.GetDecimal(25);
                    entity.AnormalTypeCode = rdr.GetString(26);
                    entity.AnormalTypeName = rdr.GetString(27);
                    entity.Station = rdr.GetString(28);
                    entity.CName = rdr.GetString(29);
                    entity.LineName = rdr.GetString(30);

                    entity.DeptName = rdr.GetString(31);
                    entity.AbnormalDocumentNo = rdr.GetString(32);
                    entity.AbnormalProposer = Convert.ToString(rdr["AbnormalProposer"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.ModifyDateTime = ComMethod.FromDatabase<DateTime?>(rdr["ModifyDateTime"]);
                    entity.AnormalNameId = Convert.ToInt32(rdr["AnormalNameId"]);
                    entity.AnormalName = Convert.ToString(rdr["AnormalName"]);
                    entity.IsLineStopName = Convert.ToString(rdr["IsLineStopName"]);
                    entity.ProcessTimeLength = Convert.ToDecimal(rdr["ProcessTimeLength"]);
                    entity.CloseTimeLength = Convert.ToDecimal(rdr["CloseTimeLength"]);
                    entity.StatusName = Convert.ToString(rdr["StatusName"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        /// <summary>
        /// 根据工单id获取获取已投产数、不良数、不良率
        /// </summary>
        /// <param name="orderid">orderId。</param>
        public List<AnormalInfo2> GetStatistic(Int32 orderId)
        {
            AnormalInfo2 entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
            };

            parms[0].Value = orderId;

            List<AnormalInfo2> list = new List<AnormalInfo2>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetGetStatisticByOrderId", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalInfo2();
                    entity.ProductIntoQty = rdr.GetInt32(0);
                    entity.BadQty = rdr.GetInt32(1);
                    entity.BadRate = rdr.GetDecimal(2);
                }
                rdr.Close();

                list.Add(entity);
            }
            return list;
        }

        /// <summary>
        /// 获取异常处理人员信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public AnormalProcessConfigInfo GetAnormalProcessConfig(AnormalProcessConfigInfo entity)
        {
            string sql = @" SELECT
	                            vw.AnormalProcessConfigId,vw.LineId,vw.AnormalGroupId,vw.ProcessBy,vw.ProcessByName,vw.CompleteBy,vw.CompleteByName,vw.CreateBy,vw.CreateDateTime,vw.ModifyBy,vw.ModifyDateTime,vw.LineName,vw.LineCode,vw.AnormalGroupName,vw.ExpirationTime 
                            FROM dbo.vwGetAnormalProcessConfig vw
                            WHERE vw.AnormalProcessConfigId = @AnormalProcessConfigId";

            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@AnormalProcessConfigId", SqlDbType.Int) { Value = entity.AnormalProcessConfigId },
            };
            return ComMethod.GetBySql<AnormalProcessConfigInfo>(sql, parms);
        }

        /// <summary>
        /// 分页获取 异常处理人员 列表数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<AnormalProcessConfigInfo> GetAnormalProcessConfigList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = "AnormalProcessConfigId,LineId,AnormalGroupId,ProcessBy,ProcessByName,CompleteBy,CompleteByName,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,LineName,LineCode,AnormalGroupName,AnormalContract";
            return ComMethod.GetComList<AnormalProcessConfigInfo>(ref this.recordCount, startRow, maxRows, "vwGetAnormalProcessConfig", string.Empty, columns, sortExpression, searchSettings);
        }


        /// <summary>
        /// 异常处理人员列表-新增、编辑
        /// </summary>
        /// <param name="entity"></param>
        public void AnormalProcessConfigEdit(AnormalProcessConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@AnormalProcessConfigId", SqlDbType.Int) { Value = entity.AnormalProcessConfigId },
                new SqlParameter("@LineId", SqlDbType.Int) { Value = entity.LineId },
                new SqlParameter("@AnormalGroupId", SqlDbType.Int) { Value = entity.AnormalGroupId },
                new SqlParameter("@ProcessBy", SqlDbType.VarChar) { Value = entity.ProcessBy },
                new SqlParameter("@ProcessByName", SqlDbType.NVarChar) { Value = entity.ProcessByName },
                new SqlParameter("@CompleteBy", SqlDbType.VarChar) { Value = entity.CompleteBy },
                new SqlParameter("@CompleteByName", SqlDbType.NVarChar) { Value = entity.CompleteByName },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar) { Value = entity.ModifyBy },
                new SqlParameter("@ExpirationTime", SqlDbType.Decimal) { Value = entity.ExpirationTime },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAnormalProcessConfigEdit", parms);
        }

        /// <summary>
        /// 异常处理人员列表-删除
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="ids"></param>
        public void AnormalProcessConfigDelete(AnormalProcessConfigInfo entity, string ids)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@AnormalProcessConfigIds", SqlDbType.VarChar) { Value = ids },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar) { Value = entity.ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAnormalProcessConfigDelete", parms);
        }
    }
}