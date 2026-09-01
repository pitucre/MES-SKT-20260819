using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Management.Instrumentation;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentRepair
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public Int32 Edit(EquipmentRepairInfo entity,string actionname)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentRepairId", SqlDbType.Int),
                new SqlParameter("@RepairNo", SqlDbType.VarChar, 50),
                new SqlParameter("@EqCode", SqlDbType.VarChar, 50),
                new SqlParameter("@RepairDesc", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@RepairBy", SqlDbType.VarChar, 50),
                new SqlParameter("@RepairTime", SqlDbType.DateTime),
                new SqlParameter("@RepairSTime", SqlDbType.DateTime),
                new SqlParameter("@RepairETime", SqlDbType.DateTime),
                new SqlParameter("@HandleContent", SqlDbType.VarChar, 500),
                new SqlParameter("@PartContent", SqlDbType.VarChar, 500),
                new SqlParameter("@Reserve1", SqlDbType.VarChar, 50),
                new SqlParameter("@Reserve2", SqlDbType.VarChar, 50),
                new SqlParameter("@Reserve3", SqlDbType.VarChar, 50),
                new SqlParameter("@Actionname", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.EquipmentRepairId;
            parms[1].Value = entity.RepairNo;
            parms[2].Value = entity.EqCode;
            parms[3].Value = entity.RepairDesc;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.Status;
            parms[6].Value = entity.RepairBy;
            parms[7].Value = entity.RepairTime == DateTime.MinValue? Convert.ToDateTime("1900-01-01") : entity.RepairTime;
            parms[8].Value = entity.RepairSTime == DateTime.MinValue ? Convert.ToDateTime("1900-01-01") : entity.RepairSTime;
            parms[9].Value = entity.RepairETime == DateTime.MinValue ? Convert.ToDateTime("1900-01-01") : entity.RepairETime;
            parms[10].Value = entity.HandleContent;
            parms[11].Value = entity.PartContent;
            parms[12].Value = entity.Reserve1;
            parms[13].Value = entity.Reserve2;
            parms[14].Value = entity.Reserve3;
            parms[15].Value = actionname;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentRepair_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// PDA设备报修—保存
        /// </summary>
        /// <param name="entity">EquipmentRepairInfo 实体对象。</param>
        public List<EquipmentRepairInfo_JXN> Edit(EquipmentRepairInfo_JXN entity)
        {
            List<EquipmentRepairInfo_JXN> list = new List<EquipmentRepairInfo_JXN>();
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 50) { Value = entity.EquipmentCode },
                new SqlParameter("@AnormalDesc", SqlDbType.NVarChar, 1000) { Value = entity.AnormalDesc },
               // new SqlParameter("@AnormalTypeName", SqlDbType.NVarChar, 100) { Value = entity.AnormalTypeName },
                new SqlParameter("@StationId", SqlDbType.Int) { Value = entity.StationId },
                new SqlParameter("@AnormalImg", SqlDbType.VarChar, 500) { Value = entity.AnormalImg ?? string.Empty },
                new SqlParameter("@UrgencyFlag", SqlDbType.Int) { Value = entity.UrgencyFlag },
                new SqlParameter("@StopFlag", SqlDbType.Int) { Value = entity.StopFlag },
                new SqlParameter("@FaultLocation", SqlDbType.NVarChar, 50) { Value = entity.FaultLocation },
                new SqlParameter("@FaultCause", SqlDbType.NVarChar, 50) { Value = entity.FaultCause },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspEquipmentRepairEdit", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentRepairInfo_JXN();
                    entity.RepairNo = Convert.ToString(rdr["RepairNo"]);
                    entity.RepairName = Convert.ToString(rdr["RepairName"]);
                    entity.RepairBy = Convert.ToString(rdr["RepairBy"]);
                    entity.Phone = Convert.ToString(rdr["Phone"]);
                    list.Add(entity);


                }
                rdr.Close();
            }
            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentRepairEdit", parms);
            return list;
        }
        /// <summary>
        /// PDA设备验收—根据设备编码获取维修完成但未验收的信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public EquipmentRepairInfo_JXN GetEquipmentRepairWaitAccept(EquipmentRepairInfo_JXN entity)
        {
            string proc = "uspGetEquipmentRepairWaitAccept";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar,50)
            };
            parms[0].Value = entity.EquipmentCode;
            return ComMethod.Get<EquipmentRepairInfo_JXN>(proc, parms, SQLHelper.MESConnString);
        }
        /// <summary>
        /// 分页获取 EquipmentRepair 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>EquipmentRepair 列表。</returns>
        public List<EquipmentRepairInfo_JXN> GetRepairAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string tbOrView = @"vwGetEquipmentRepair";
            string columns = "EquipmentRepairId,RepairNo,EquipmentCode,AnormalDesc,AnormalImg,Status,RepairBy,RepairStartTime,RepairEndTime,HandleContent,PartContent,Reserve1,Reserve2,Reserve3,RepairTime,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,PartNo,PartQty,AcceptRemark,UrgencyFlag,RepairFunction,StationId,AcceptBy,AcceptTime,AuditBy,AuditTime,StopFlag,StatusName,UrgencyName,StopFlagName,EquipmentName,Station,StopHour,RepairHour,ExternalRepairRemark,CreateName,RepairName,AcceptName,AuditName,FaultLocation,FaultCause";
            return ComMethod.GetComList<EquipmentRepairInfo_JXN>(ref this.recordCount, startRow, maxRows, tbOrView, "EquipmentRepairId", columns, sortExpression, searchSettings);
        }
        /// <summary>
        /// 获取维修设备信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public EquipmentRepairInfo_JXN GetInfo(EquipmentRepairInfo_JXN entity)
        {
            string sql = @"SELECT 
                               EquipmentRepairId,RepairNo,EquipmentCode,AnormalDesc,AnormalImg,Status,RepairBy,RepairStartTime,RepairEndTime,HandleContent,PartContent,Reserve1,Reserve2,Reserve3,RepairTime,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,PartNo,PartQty,AcceptRemark,UrgencyFlag,RepairFunction,StationId,AcceptBy,AcceptTime,AuditBy,AuditTime,StopFlag,StatusName,UrgencyName,StopFlagName,EquipmentName,Station,StopHour,RepairHour,ExternalRepairRemark,CreateName,RepairName,AcceptName,AuditName,FaultLocation,FaultCause,RepairImg1,EquipmentTypeName
                           FROM vwGetEquipmentRepair
                           WHERE ";

            SqlParameter[] parms = null;
            if (!string.IsNullOrEmpty(entity.RepairNo))
            {
                //根据单号查询
                sql += " RepairNo = @RepairNo";
                parms = new SqlParameter[]
                {
                    new SqlParameter("@RepairNo", SqlDbType.VarChar,50) { Value = entity.RepairNo }
                };
            }
            else
            {
                //根据Id查询
                sql += " EquipmentRepairId = @EquipmentRepairId";
                parms = new SqlParameter[]
                {
                    new SqlParameter("@EquipmentRepairId", SqlDbType.Int) { Value = entity.EquipmentRepairId }
                };
            }
            return ComMethod.GetBySql<EquipmentRepairInfo_JXN>(sql, parms);
        }
        /// <summary>
        /// 根据设备编码获取维修中但未验收的信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public EquipmentRepairInfo_JXN GetEquipmentRepair(EquipmentRepairInfo_JXN entity)
        {
            string sql = @"SELECT
                               ber.EquipmentRepairId, ber.RepairNo, ber.EquipmentCode, ber.AnormalDesc, ber.AnormalImg, ber.Status,ber.RepairBy, ber.RepairStartTime, ber.RepairEndTime, ber.HandleContent, ber.PartContent, ber.Reserve1, ber.Reserve2, ber.Reserve3, ber.RepairTime, ber.CreateBy, ber.CreateDateTime, ber.ModifyBy, ber.ModifyDateTime, ber.PartNo, ber.PartQty,
                               ber.UrgencyFlag,CASE ber.UrgencyFlag WHEN 0 THEN '低' WHEN 1 THEN '中' WHEN 2 THEN '高' ELSE '' END UrgencyName,ISNULL(ber.ExternalRepairRemark,'') ExternalRepairRemark,CASE ber.StopFlag WHEN 0 THEN '否' WHEN 1 THEN '是' ELSE '' END StopFlagName,
                               bs.Station,ISNULL(bl.LineName,'') LineName,
                               sm.CName CreateName,sm.Phone CreatePhone,ber.FaultLocation,ber.FaultCause
                           FROM dbo.Basal_EquipmentRepair_JXN ber
                           INNER JOIN dbo.Basal_Equipment be ON ber.EquipmentCode = be.EquipmentCode
						   LEFT JOIN dbo.Basal_Line bl ON be.LineId = bl.LineId
						   LEFT JOIN dbo.Basal_Station bs ON ber.StationId = bs.StationId
                           LEFT JOIN dbo.SYS_Users su ON ber.CreateBy = su.UserName
                           LEFT JOIN dbo.SYS_Membership sm ON su.UserId = sm.UserId
                           WHERE ber.Status IN(0,1,3) AND ber.EquipmentCode = @EquipmentCode;";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar,50)
            };
            parms[0].Value = entity.EquipmentCode;
            return ComMethod.GetBySql<EquipmentRepairInfo_JXN>(sql, parms);
        }
        /// <summary>
        /// PDA设备维修—开始维修/报废/外修/维修完成/验收/拒收
        /// </summary>
        /// <param name="entity">EquipmentRepairInfo 实体对象。</param>
        public void EquipmentRepairOperate(EquipmentRepairInfo_JXN entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@RepairNo", SqlDbType.VarChar, 4000) { Value = entity.RepairNo },
                new SqlParameter("@Flag", SqlDbType.Int) { Value = entity.Flag },
              //  new SqlParameter("@AnormalTypeName", SqlDbType.NVarChar,50) { Value = entity.AnormalTypeName },
                new SqlParameter("@PartNo", SqlDbType.VarChar, 50) { Value = entity.PartNo ?? string.Empty },
                new SqlParameter("@PartQty", SqlDbType.Decimal) { Value = entity.PartQty ?? 0 },
                new SqlParameter("@ExternalRepairRemark", SqlDbType.NVarChar, 500) { Value = entity.ExternalRepairRemark ?? string.Empty },
                new SqlParameter("@AcceptRemark", SqlDbType.NVarChar, 500) { Value = entity.AcceptRemark ?? string.Empty },
                new SqlParameter("@FaultLocation", SqlDbType.NVarChar, 50) { Value = entity.FaultLocation },
                new SqlParameter("@FaultCause", SqlDbType.NVarChar, 50) { Value = entity.FaultCause },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
                new SqlParameter("@RepairImg1", SqlDbType.VarChar, 500) { Value = entity.RepairImg1 },
                
            };


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentRepair", parms);
        }
        /// <summary>
        /// 设备维修—编辑
        /// </summary>
        /// <param name="entity">EquipmentRepairInfo 实体对象。</param>
        public void EquipmentRepairFunctionEdit(EquipmentRepairInfo_JXN entity)
        {
            string sql = "UPDATE ber SET ber.RepairFunction = @RepairFunction,ber.ModifyBy = @ModifyBy,ber.ModifyDateTime = GETDATE() FROM dbo.Basal_EquipmentRepair_JXN ber WHERE ber.EquipmentRepairId = @EquipmentRepairId";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentRepairId", SqlDbType.Int) { Value = entity.EquipmentRepairId },
                new SqlParameter("@RepairFunction", SqlDbType.NVarChar, 2000) { Value = entity.RepairFunction },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            ComMethod.EditBySql(sql, parms);
        }
        /// <summary>
        /// 设备绑定关系备件
        /// </summary>
        /// <param name="entity"></param>
        public void IsBind(string partNo, string EquipmentCode)
        {
         
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@PartNo", SqlDbType.NVarChar,2000) { Value =partNo },
                new SqlParameter("@EquipmentCode", SqlDbType.NVarChar,2000) { Value =EquipmentCode }
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentAndPartIsBind", parms);
        }
        /// <summary>
        /// 检验设备号是否存在未完成的维修单
        /// </summary>
        /// <param name="eqCode"></param>
        /// <returns></returns>
        public int CheckEquimentRepair(string eqCode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@EqumentCode", SqlDbType.VarChar,50),
                    new SqlParameter("@Result",SqlDbType.Int,4)
                };
            parms[0].Value = eqCode;
            parms[1].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckEquimentRepair", parms);

            return Convert.ToInt32(parms[1].Value);
        }

        /// <summary>
        /// 获取维修单号 
        /// </summary>
        /// <returns></returns>
        public string GetEquipmentRepairNo(int serialNumberType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@NextNumberType", SqlDbType.Int),
                    new SqlParameter("@ItemId", SqlDbType.Int),
                    new SqlParameter("@WOID", SqlDbType.Int),
                    new SqlParameter("@SN",SqlDbType.VarChar,50)
                };
            parms[0].Value = serialNumberType;
            parms[1].Value = -1;
            parms[2].Value = -1;
            parms[3].Value = -1;
            parms[3].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateItemSN", parms);

            return parms[3].Value.ToString();
        }
        /// <summary>
        /// 根据 EquipmentRepairId 字符串删除 EquipmentRepair 信息。
        /// </summary>
        /// <param name="idString">EquipmentRepairId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentRepair_Delete", parms);
        }

        /// <summary>
        /// 根据 EquipmentRepairId 获取实体信息。
        /// </summary>
        /// <param name="equipmentRepairId">EquipmentRepairId。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public EquipmentRepairInfo GetInfo(Int32 equipmentRepairId)
        {
            EquipmentRepairInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentRepairId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentRepair_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentRepairInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14));
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.RepairTime = Convert.ToDateTime(rdr["RepairTime"]);
                    entity.StatusName = Convert.ToString(rdr["StatusName"]);
                    entity.CreateByCName = Convert.ToString(rdr["CreateByCName"]);
                    entity.RepairByCName = Convert.ToString(rdr["RepairByCName"]);
                    entity.ConfirmUserCName = Convert.ToString(rdr["ConfirmUserCName"]);
                    entity.ConfirmUser = Convert.ToString(rdr["ConfirmUser"]);
                    entity.ConfirmDateTime = Convert.ToDateTime(rdr["ConfirmDateTime"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public EquipmentRepairInfo GetInfo(String fieldValue)
        {
            EquipmentRepairInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentRepair_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentRepairInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14));
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.RepairTime = Convert.ToDateTime(rdr["RepairTime"]);
                    entity.StatusName = Convert.ToString(rdr["StatusName"]);
                    entity.CreateByCName = Convert.ToString(rdr["CreateByCName"]);
                    entity.RepairByCName = Convert.ToString(rdr["RepairByCName"]);
                    entity.ConfirmUserCName = Convert.ToString(rdr["ConfirmUserCName"]);
                    entity.ConfirmUser = Convert.ToString(rdr["ConfirmUser"]);
                    entity.ConfirmDateTime = Convert.ToDateTime(rdr["ConfirmDateTime"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentRepair 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentRepairCount">equipmentRepair 总数。</param>
        /// <returns>EquipmentRepair 列表。</returns>
        public List<EquipmentRepairInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentRepairInfo> list = new List<EquipmentRepairInfo>();
            EquipmentRepairInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_EquipmentRepair", "EquipmentRepairId",
                "[EquipmentRepairId], [RepairNo], [EqCode], [RepairDesc], [CreateBy], [CreateDateTime], [Status], [RepairBy], [RepairSTime], [RepairETime], [HandleContent], [PartContent], [Reserve1], [Reserve2], [Reserve3],RepairTime,ConfirmUser,ConfirmDateTime,StatusName,EquipmentName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentRepairInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14));
                    entity.RepairTime = rdr.GetDateTime(15);
                    entity.ConfirmUser = rdr.GetString(16);
                    entity.ConfirmDateTime = rdr.GetDateTime(17);
                    entity.StatusName = rdr.GetString(18);
                    entity.EquipmentName = rdr.GetString(19);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取设备与维修记录关联表信息zx 20171019。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentItemRelationCount">equipmentItemRelation 总数。</param>
        /// <returns>EquipmentItemRelation 列表。</returns>
        public List<EquipmentRepairInfo> GetAllEquiment(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentRepairInfo> list = new List<EquipmentRepairInfo>();
            EquipmentRepairInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[Basal_EquipmentRepair_JXN] A LEFT JOIN dbo.Basal_Equipment B ON A.EquipmentCode = b.EquipmentCode LEFT JOIN Sys_Organization C ON  B.CareDepNo = c.DepartNo", "EquipmentRepairId",
                "[EquipmentRepairId], [RepairNo], A.[EquipmentCode], [AnormalDesc], A.[CreateBy], A.[CreateDateTime], a.[Status], [RepairBy], [RepairStartTime], [RepairEndTime], [HandleContent], [PartContent], [Reserve1], [Reserve2], [Reserve3],RepairTime,B.EquipmentName,c.DepartName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {

                while (rdr.Read())
                {
                    entity = new EquipmentRepairInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.IsDBNull(9) ? DateTime.MinValue : rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14));
                    entity.StatusName = entity.Status == 1 ? "进行中" : "完成";
                    entity.RepairTime = rdr.IsDBNull(15)?DateTime.MinValue: rdr.GetDateTime(15);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.DepositoryDep = Convert.ToString(rdr["DepartName"]);
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
        /// 获取维修履历
        /// </summary>
        /// <param name="equipmentCode">设备编码</param>
        public List<EquipmentRepairInfo_JXN> GetMaintenanceHistory(string equipmentCode)
        {
            const string sql = @"SELECT TOP 50 AnormalDesc, FaultAnalysis, RepairContent, CreateName, CreateDateTime FROM vwGetEquipmentRepair
                                    WHERE EquipmentCode LIKE '%' + @EquipmentCode + '%'";

            var parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 50) { Value = equipmentCode }
            };

            return ComMethod.GetListBySql<EquipmentRepairInfo_JXN>(sql, parms);
        }
    }
}