using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SDP.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SDP.BLL
{
    public class Activity
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 获取路由步骤线段
        /// </summary>
        /// <returns></returns>
        public List<RouteDetail> GetRouteDetail(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<RouteDetail> list = new List<RouteDetail>();
            RouteDetail entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwRouterDetail", "RD_ID",
                "RD_ID,R_ID,Incoming_OpeID AS StationId,R_Name,R_Description,Station,StationDesc,TmplID,ModuleId,StationType", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new RouteDetail(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5),
                        rdr.GetString(6), rdr.GetInt32(7), (rdr.GetValue(8) as int?));
                    entity.StationType = rdr.GetString(9);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public DataTable GetRouteDetailByrdId(int rdId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RD_ID", SqlDbType.Int)};
            parms[0].Value = rdId;
            string sql = "Select RD_ID,R_ID,Incoming_OpeID AS StationId,R_Name,R_Description,Station,StationDesc,TmplID,ModuleId from vwRouterDetail where RD_ID=@RD_ID";
           return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, parms);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="activityId"></param>
        /// <returns></returns>
        public List<ActivityInfo> GetInfo(Int32 RouteId,Int32 StationId)
        {
            List<ActivityInfo> list = new List<ActivityInfo>();
            ActivityInfo entity;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RouteId", SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int)};
            parms[0].Value = RouteId;
            parms[1].Value = StationId;

            string sql = @"SELECT Id,RouteId,StationId,ControlId,ControlName,ControlType,EventType,EventName,SortNo,CreateBy,CreateDateTime,ModifyBy,
                            ModifyDateTime FROM dbo.SDP_Activity WHERE RouteId=@RouteId AND StationId=@StationId Order BY Id";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                while (rdr.Read())
                {
                    string modify = rdr.GetValue(11) == DBNull.Value ? "" : rdr.GetString(11);
                    DateTime modifyTime = rdr.GetValue(12) == DBNull.Value ? DateTime.MinValue : rdr.GetDateTime(12);
                    entity = new ActivityInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), modify, modifyTime);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 编辑（添加或更新） Activity 信息。
        /// </summary>
        /// <param name="entity">Activity 实体对象。</param>
        public Int32 Edit(ActivityInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@RouteId", SqlDbType.NVarChar, 50),
                new SqlParameter("@StationId", SqlDbType.NVarChar, 50),
                new SqlParameter("@ControlId", SqlDbType.NVarChar, 50),
                new SqlParameter("@ControlName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ControlType", SqlDbType.NVarChar, 50),
                new SqlParameter("@EventType", SqlDbType.NVarChar, 50),
                new SqlParameter("@EventName", SqlDbType.NVarChar, 50),
                new SqlParameter("@SortNo", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.Id;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.RouteId;
            parms[2].Value = entity.StationId;
            parms[3].Value = entity.ControlId;
            parms[4].Value = entity.ControlName;
            parms[5].Value = entity.ControlType;
            parms[6].Value = entity.EventType;
            parms[7].Value = entity.EventName;
            parms[8].Value = entity.SortNo;
            parms[9].Value = entity.CreateBy;
            if (entity.ModifyBy == null)
            {
                parms[10].Value = DBNull.Value;
            }
            else
            {
                parms[10].Value = entity.ModifyBy;
            }

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_Activity_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ActivityId 字符串删除 Activity 信息。
        /// </summary>
        /// <param name="idString">ActivityId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_Activity_Delete", parms);
        }

        /// <summary>
        /// 根据 ActivityId 获取实体信息。
        /// </summary>
        /// <param name="activityId">ActivityId。</param>
        /// <returns>Activity 实体对象。</returns>
        public ActivityInfo GetInfo(Int32 activityId)
        {
            ActivityInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = activityId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_Activity_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    string modify = rdr.GetValue(11) == DBNull.Value ? "" : rdr.GetString(11);
                    DateTime modifyTime = rdr.GetValue(12) == DBNull.Value ? DateTime.MinValue : rdr.GetDateTime(12);
                    entity = new ActivityInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), modify, modifyTime);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Activity 实体对象。</returns>
        public ActivityInfo GetInfo(String fieldValue)
        {
            ActivityInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_Activity_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    string modify = rdr.GetValue(11) == DBNull.Value ? "" : rdr.GetString(11);
                    DateTime modifyTime = rdr.GetValue(12) == DBNull.Value ? DateTime.MinValue : rdr.GetDateTime(12);
                    entity = new ActivityInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), modify, modifyTime);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Activity 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="activityCount">activity 总数。</param>
        /// <returns>Activity 列表。</returns>
        public List<ActivityInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ActivityInfo> list = new List<ActivityInfo>();
            ActivityInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SDP_Activity", "ActivityId",
                "[Id], [RouteId], [StationId], [ControlId], [ControlName], [ControlType], [EventType], [EventName], [SortNo], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    string modify = rdr.GetValue(11) == DBNull.Value ? "" : rdr.GetString(11);
                    DateTime modifyTime = rdr.GetValue(12) == DBNull.Value ? DateTime.MinValue : rdr.GetDateTime(12);
                    entity = new ActivityInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), modify, modifyTime);

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


        public ActivityInfo GetActivityInfo(int rdId,string controlId,string eventType)
        {
            ActivityInfo entity = null;
            string sql = @"SELECT A.* FROM dbo.SDP_Activity A
                    INNER JOIN dbo.Basal_RouterDetail B 
                    ON A.RouteId = B.R_ID AND A.StationId = B.Incoming_OpeID 
                    where B.RD_ID = @rdId AND A.ControlId=@ControlId AND A.EventType=@EventType ";

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@rdId", SqlDbType.Int),
                new SqlParameter("@ControlId", SqlDbType.NVarChar),
                new SqlParameter("@EventType", SqlDbType.NVarChar),
            };

            parms[0].Value = rdId;
            parms[1].Value = controlId;
            parms[2].Value = eventType;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                if (rdr.Read())
                {
                    string modify = rdr.GetValue(11) == DBNull.Value ? "" : rdr.GetString(11);
                    DateTime modifyTime = rdr.GetValue(12) == DBNull.Value ? DateTime.MinValue : rdr.GetDateTime(12);
                    entity = new ActivityInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), modify, modifyTime);
                }
                rdr.Close();
            }
            return entity;
        }
    }
}