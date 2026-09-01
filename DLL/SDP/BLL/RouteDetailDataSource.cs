using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SDP.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SDP.BLL
{
    public class RouteDetailDataSource
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） RouteDetailDataSource 信息。
        /// </summary>
        /// <param name="entity">RouteDetailDataSource 实体对象。</param>
        public Int32 Edit(RouteDetailDataSourceInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RouteDetailDataSourceID", SqlDbType.Int),
                new SqlParameter("@RouteId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@DataSourceID", SqlDbType.Int),
                new SqlParameter("@RouteDetailDataSourceName", SqlDbType.VarChar, 20),
                new SqlParameter("@RDID", SqlDbType.Int)
            };

            parms[0].Value = entity.RouteDetailDataSourceID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.RouteId;
            parms[2].Value = entity.StationId;
            parms[3].Value = entity.DataSourceID;
            parms[4].Value = entity.RouteDetailDataSourceName;
            parms[5].Value = entity.RDId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_RouteDetailDataSource_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 RouteDetailDataSourceId 字符串删除 RouteDetailDataSource 信息。
        /// </summary>
        /// <param name="idString">RouteDetailDataSourceId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_RouteDetailDataSource_Delete", parms);
        }

        /// <summary>
        /// 根据 RouteDetailDataSourceId 获取实体信息。
        /// </summary>
        /// <param name="routeDetailDataSourceId">RouteDetailDataSourceId。</param>
        /// <returns>RouteDetailDataSource 实体对象。</returns>
        public RouteDetailDataSourceInfo GetInfo(Int32 routeDetailDataSourceId)
        {
            RouteDetailDataSourceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = routeDetailDataSourceId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_RouteDetailDataSource_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new RouteDetailDataSourceInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), rdr.GetInt32(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>RouteDetailDataSource 实体对象。</returns>
        public RouteDetailDataSourceInfo GetInfo(String fieldValue)
        {
            RouteDetailDataSourceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_RouteDetailDataSource_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new RouteDetailDataSourceInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), rdr.GetInt32(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据ID查询路由所有数据源
        /// </summary>
        /// <param name="rdId"></param>
        /// <returns></returns>
        public DataTable GetRDSourceByrdId(int stationId,int routeId)
        {
            string sqlText = " SELECT * FROM vwRouteDetailDataSource where RouteId=@RouteId AND StationId=@StationId";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RouteId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int)
            };
            parms[0].Value = routeId;
            parms[1].Value = stationId;

            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sqlText, parms);
        }

        /// <summary>
        /// 分页获取 RouteDetailDataSource 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="routeDetailDataSourceCount">routeDetailDataSource 总数。</param>
        /// <returns>RouteDetailDataSource 列表。</returns>
        public List<RouteDetailDataSourceInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<RouteDetailDataSourceInfo> list = new List<RouteDetailDataSourceInfo>();
            RouteDetailDataSourceInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SDP_RouteDetailDataSource", "RouteDetailDataSourceId",
                "[RouteDetailDataSourceID], [RouteId], [StationId], [DataSourceID], [RouteDetailDataSourceName], [RD_ID]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new RouteDetailDataSourceInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), rdr.GetInt32(5));

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
        /// 获取所有的数据源
        /// </summary>
        /// <returns></returns>
        public DataTable GetAll(string where)
        {
            string sqlText = @" SELECT A.* FROM SDP_RouteDetailDataSource A
                INNER JOIN dbo.SDP_DataSource B ON A.DataSourceID = B.DataSourceID ";
            if (!string.IsNullOrEmpty(where))
            {
                sqlText += "where " + where;
            }
            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sqlText);
        }
    }
}