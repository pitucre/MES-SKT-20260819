using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SDP.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SDP.BLL
{
    public class DataSource 
    {       
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） DataSource 信息。
        /// </summary>
        /// <param name="entity">DataSource 实体对象。</param>
        public Int32 Edit(DataSourceInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DataSourceID", SqlDbType.Int),
                new SqlParameter("@DataSourceName", SqlDbType.VarChar, 20),
                new SqlParameter("@DataSourceDesc", SqlDbType.VarChar, 200),
                new SqlParameter("@DataSourceType", SqlDbType.VarChar, 20),
                new SqlParameter("@SQLType", SqlDbType.VarChar, 20),
                new SqlParameter("@SQLInfo", SqlDbType.VarChar, -1),
                new SqlParameter("@Paramters", SqlDbType.VarChar, 2000),
                new SqlParameter("@TabColumn", SqlDbType.VarChar, 2000),
                new SqlParameter("@UseType", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.DataSourceID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.DataSourceName;
            parms[2].Value = entity.DataSourceDesc;
            parms[3].Value = entity.DataSourceType;
            parms[4].Value = entity.SQLType;
            parms[5].Value = entity.SQLInfo;
            parms[6].Value = entity.Paramters;
            parms[7].Value = entity.TabColumn;
            parms[8].Value = entity.UseType;
            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_DataSource_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 DataSourceId 字符串删除 DataSource 信息。
        /// </summary>
        /// <param name="idString">DataSourceId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_DataSource_Delete", parms);
        }

        /// <summary>
        /// 根据 DataSourceId 获取实体信息。
        /// </summary>
        /// <param name="dataSourceId">DataSourceId。</param>
        /// <returns>DataSource 实体对象。</returns>
        public DataSourceInfo GetInfo(Int32 dataSourceId)
        {
            DataSourceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = dataSourceId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_DataSource_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    string paramter = rdr.GetValue(6) == DBNull.Value ? "" : rdr.GetString(6);
                    string tabColumn = rdr.GetValue(7) == DBNull.Value ? "" : rdr.GetString(7);
                    entity = new DataSourceInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), paramter, tabColumn, rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>DataSource 实体对象。</returns>
        public DataSourceInfo GetInfo(String fieldValue)
        {
            DataSourceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_DataSource_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    string paramter = rdr.GetValue(6) == DBNull.Value ? "" : rdr.GetString(6);
                    string tabColumn = rdr.GetValue(7) == DBNull.Value ? "" : rdr.GetString(7);
                    entity = new DataSourceInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), paramter, tabColumn, rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 获取所有的数据源
        /// </summary>
        /// <returns></returns>
        public DataTable GetAll(string where)
        {
            string sqlText = " SELECT * FROM SDP_DataSource ";
            if (!string.IsNullOrEmpty(where))
            {
                sqlText += "where " + where;
            }
            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sqlText);
        }

        public DataSourceInfo GetInfoByRdSourceId(int RDDataSourceId)
        {
            string sqlText = @" SELECT B.* FROM SDP_RouteDetailDataSource A INNER JOIN dbo.SDP_DataSource B ON A.DataSourceID = B.DataSourceID
                                    WHERE A.RouteDetailDataSourceID =@RouteDetailDataSourceID ";

            DataSourceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RouteDetailDataSourceID", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = RDDataSourceId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlText, parms))
            {
                if (rdr.Read())
                {
                    string paramter = rdr.GetValue(6) == DBNull.Value ? "" : rdr.GetString(6);
                    string tabColumn = rdr.GetValue(7) == DBNull.Value ? "" : rdr.GetString(7);
                    entity = new DataSourceInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), paramter, tabColumn, rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 DataSource 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="dataSourceCount">dataSource 总数。</param>
        /// <returns>DataSource 列表。</returns>
        public List<DataSourceInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DataSourceInfo> list = new List<DataSourceInfo>();
            DataSourceInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SDP_DataSource", "DataSourceId",
                "[DataSourceID], [DataSourceName], [DataSourceDesc], [DataSourceType], [SQLType], [SQLInfo], [Paramters], [TabColumn]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    string paramter = rdr.GetValue(6) == DBNull.Value ? "" : rdr.GetString(6);
                    string tabColumn = rdr.GetValue(7) == DBNull.Value ? "" : rdr.GetString(7);
                    entity = new DataSourceInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), paramter, tabColumn, rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12));

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