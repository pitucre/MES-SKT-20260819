using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class LoadingListTable
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LoadingListTable 信息。
        /// </summary>
        /// <param name="entity">LoadingListTable 实体对象。</param>
        public Int32 Edit(LoadingListTableInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LoadingListTableId", SqlDbType.Int),
                new SqlParameter("@TableName", SqlDbType.NVarChar, 50),
                new SqlParameter("@TableDesc", SqlDbType.NVarChar, 200),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@EnableFlag", SqlDbType.Int)
            };

            parms[0].Value = entity.LoadingListTableId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.TableName;
            parms[2].Value = entity.TableDesc;
            parms[3].Value = entity.ModifyBy;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.EnableFlag;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingListTable_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LoadingListTableId 字符串删除 LoadingListTable 信息。
        /// </summary>
        /// <param name="idString">LoadingListTableId 字符串。</param>
        /// <returns>日志内容。</returns>
        //public void Delete(String idString, String userName)
        //{
        //    SqlParameter[] parms = new SqlParameter[]{
        //        new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
        //        new SqlParameter("@UserName", SqlDbType.VarChar, 20)
        //    };

        //    parms[0].Value = idString;
        //    parms[1].Value = userName;

        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingListTable_Delete", parms);
        //}

        /// <summary>
        /// 根据 LoadingListTableId 获取实体信息。
        /// </summary>
        /// <param name="loadingListTableId">LoadingListTableId。</param>
        /// <returns>LoadingListTable 实体对象。</returns>
        public LoadingListTableInfo GetInfo(Int32 loadingListTableId)
        {
            LoadingListTableInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = loadingListTableId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingListTable_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LoadingListTableInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LoadingListTable 实体对象。</returns>
        public LoadingListTableInfo GetInfo(String fieldValue)
        {
            LoadingListTableInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingListTable_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LoadingListTableInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 LoadingListTable 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="loadingListTableCount">loadingListTable 总数。</param>
        /// <returns>LoadingListTable 列表。</returns>
        public List<LoadingListTableInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadingListTableInfo> list = new List<LoadingListTableInfo>();
            LoadingListTableInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_LoadingListTable", "LoadingListTableId",////Prod_LoadingListTable
                "[LoadingListTableId], [TableName], [TableDesc], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [EnableFlag]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadingListTableInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8));

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