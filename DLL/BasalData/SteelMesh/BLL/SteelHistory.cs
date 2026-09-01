using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.SteelMesh.Model;

namespace SKT.LeanMES.SteelMesh.BLL
{
    public class SteelHistory
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SteelHistory 信息。
        /// </summary>
        /// <param name="entity">SteelHistory 实体对象。</param>
        public Int32 Edit(SteelHistoryInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SteelHistoryId", SqlDbType.Int),
                new SqlParameter("@SteelId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@OperateType", SqlDbType.Int),
                new SqlParameter("@SteelType", SqlDbType.Int),
                new SqlParameter("@Operator", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200)
            };

            parms[0].Value = entity.SteelHistoryId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SteelId;
            parms[2].Value = entity.LineId;
            parms[3].Value = entity.OperateType;
            parms[4].Value = entity.SteelType;
            parms[5].Value = entity.Operator;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SteelHistory_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SteelHistoryId 字符串删除 SteelHistory 信息。
        /// </summary>
        /// <param name="idString">SteelHistoryId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SteelHistory_Delete", parms);
        }

        /// <summary>
        /// 根据 SteelHistoryId 获取实体信息。
        /// </summary>
        /// <param name="steelHistoryId">SteelHistoryId。</param>
        /// <returns>SteelHistory 实体对象。</returns>
        public SteelHistoryInfo GetInfo(Int32 steelHistoryId)
        {
            SteelHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = steelHistoryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SteelHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SteelHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SteelHistory 实体对象。</returns>
        public SteelHistoryInfo GetInfo(String fieldValue)
        {
            SteelHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SteelHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SteelHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SteelHistory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="steelHistoryCount">steelHistory 总数。</param>
        /// <returns>SteelHistory 列表。</returns>
        public List<SteelHistoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SteelHistoryInfo> list = new List<SteelHistoryInfo>();
            SteelHistoryInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSteelHistory", "SteelHistoryId",
                "[SteelHistoryId], [SteelCode], [SteelName], [SteelCategory], [LineName], [OperateType], [SteelType], [CName], [CreateDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SteelHistoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="strWhere">查询条件</param>
        /// <returns></returns>
        public DataTable ImportToExcel(int Status,String beginDateTime, String endDateTime)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@BeginCreateTime", SqlDbType.NVarChar),
                new SqlParameter("@EndCreateTime", SqlDbType.NVarChar)
            };
            parms[0].Value = Status;
            parms[1].Value = beginDateTime;
            parms[2].Value = endDateTime;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Prod_ImportToExcel", parms);
        }


        public List<SteelNetUpLineInfo> GetSteelHistory(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SteelNetUpLineInfo> list = new List<SteelNetUpLineInfo>();
            SteelNetUpLineInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_SteelNetUpLine", "HistoryID",
                @"HistoryID,EquipmentName,EquipmentCode,EquipmentType,OrderNO,Qty_to_Build,UPLineUser,UPLineTime,Status,DownLineUser,DownLineTime,ClearUser,
                    CliearTime,Tension,CheckResult", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while(rdr.Read())
                {
                    entity = new SteelNetUpLineInfo();
                    entity.HistoryID=Convert.ToInt64(rdr["HistoryID"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentType = Convert.ToString(rdr["EquipmentType"]);
                    entity.OrderNO = Convert.ToString(rdr["OrderNO"]);
                    entity.Qty_to_Build = Convert.ToInt32(rdr["Qty_to_Build"]);
                    entity.UPLineUser = Convert.ToString(rdr["UPLineUser"]);
                    entity.UPLineTime = Convert.ToDateTime(rdr["UPLineTime"]);
                    entity.Status = Convert.ToString(rdr["Status"]);
                    entity.DownLineUser = Convert.ToString(rdr["DownLineUser"]);
                    entity.DownLineTime = Convert.ToString(rdr["DownLineTime"]);
                    entity.ClearUser = Convert.ToString(rdr["ClearUser"]);
                    entity.ClearTime = Convert.ToString(rdr["CliearTime"]);
                    entity.Tension = Convert.ToString(rdr["Tension"]);
                    entity.CheckResult = Convert.ToString(rdr["CheckResult"]);

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

    }
}