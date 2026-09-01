using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SDP.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SDP.BLL
{
    public class RouteDetailDataSourceParam
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） RouteDetailDataSourceParam 信息。
        /// </summary>
        /// <param name="entity">RouteDetailDataSourceParam 实体对象。</param>
        public Int32 Edit(RouteDetailDataSourceParamInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RouteDetailDataSourceParamID", SqlDbType.Int),
                new SqlParameter("@RouteDetailDataSourceID", SqlDbType.Int),
                new SqlParameter("@ParamName", SqlDbType.VarChar, 20),
                new SqlParameter("@ParamType", SqlDbType.VarChar, 20),
                new SqlParameter("@ControlId", SqlDbType.VarChar, 100),
                new SqlParameter("@ParamValue", SqlDbType.VarChar, 100)
            };

            parms[0].Value = entity.RouteDetailDataSourceParamID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.RouteDetailDataSourceID;
            parms[2].Value = entity.ParamName;
            parms[3].Value = entity.ParamType;
            parms[4].Value = entity.ControlId;
            parms[5].Value = entity.ParamValue;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_RouteDetailDataSourceParam_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 RouteDetailDataSourceParamId 字符串删除 RouteDetailDataSourceParam 信息。
        /// </summary>
        /// <param name="idString">RouteDetailDataSourceParamId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_RouteDetailDataSourceParam_Delete", parms);
        }

        /// <summary>
        /// 根据 RouteDetailDataSourceParamId 获取实体信息。
        /// </summary>
        /// <param name="routeDetailDataSourceParamId">RouteDetailDataSourceParamId。</param>
        /// <returns>RouteDetailDataSourceParam 实体对象。</returns>
        public RouteDetailDataSourceParamInfo GetInfo(Int32 routeDetailDataSourceParamId)
        {
            RouteDetailDataSourceParamInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = routeDetailDataSourceParamId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_RouteDetailDataSourceParam_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new RouteDetailDataSourceParamInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>RouteDetailDataSourceParam 实体对象。</returns>
        public RouteDetailDataSourceParamInfo GetInfo(String fieldValue)
        {
            RouteDetailDataSourceParamInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_RouteDetailDataSourceParam_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new RouteDetailDataSourceParamInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="rdId"></param>
        /// <returns></returns>
        public DataTable GetRDParamSourceByrdId(List<int> rdIds)
        {
            string sqlText = " SELECT * FROM [SDP_RouteDetailDataSourceParam] where [RouteDetailDataSourceID] in (" + string.Join(",",rdIds) + ")";           

            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sqlText);
        }

        public int Delete(string RouteDetailDataSourceID)
        {
            string sqlText = " DELETE FROM [SDP_RouteDetailDataSourceParam] where [RouteDetailDataSourceID] in (" + RouteDetailDataSourceID + ")";

            return SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sqlText);
        }

        /// <summary>
        /// 分页获取 RouteDetailDataSourceParam 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="routeDetailDataSourceParamCount">routeDetailDataSourceParam 总数。</param>
        /// <returns>RouteDetailDataSourceParam 列表。</returns>
        public List<RouteDetailDataSourceParamInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<RouteDetailDataSourceParamInfo> list = new List<RouteDetailDataSourceParamInfo>();
            RouteDetailDataSourceParamInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SDP_RouteDetailDataSourceParam", "RouteDetailDataSourceParamId",
                "[RouteDetailDataSourceParamID], [RouteDetailDataSourceID], [ParamName], [ParamType], [ControlId], [ParamValue]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new RouteDetailDataSourceParamInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));

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