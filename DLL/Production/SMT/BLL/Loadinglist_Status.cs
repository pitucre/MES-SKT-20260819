using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;


namespace SKT.LeanMES.SMT.BLL
{
    public class LIST_Status
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LIST_Status 信息。
        /// </summary>
        /// <param name="entity">LIST_Status 实体对象。</param>
        public Int32 Edit(LIST_StatusInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@id", SqlDbType.Int),
                new SqlParameter("@Description", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.Description;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "LOADING_LIST_StatusEdit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LIST_StatusId 字符串删除 LIST_Status 信息。
        /// </summary>
        /// <param name="idString">LIST_StatusId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "LOADING_LIST_StatusDelete", parms);
        }

        /// <summary>
        /// 根据 LIST_StatusId 获取实体信息。
        /// </summary>
        /// <param name="lIST_StatusId">LIST_StatusId。</param>
        /// <returns>LIST_Status 实体对象。</returns>
        public LIST_StatusInfo GetInfo(Int32 lIST_StatusId)
        {
            LIST_StatusInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lIST_StatusId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "LOADING_LIST_StatusGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LIST_StatusInfo(rdr.GetInt32(0), rdr.GetString(1));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LIST_Status 实体对象。</returns>
        public LIST_StatusInfo GetInfo(String fieldValue)
        {
            LIST_StatusInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "LOADING_LIST_StatusGetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 LIST_Status 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lIST_StatusCount">lIST_Status 总数。</param>
        /// <returns>LIST_Status 列表。</returns>
        public List<LIST_StatusInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LIST_StatusInfo> list = new List<LIST_StatusInfo>();
            LIST_StatusInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_LoadingListStatus", "id",
                "[id], [Description]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LIST_StatusInfo(rdr.GetInt32(0), rdr.GetString(1));

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


        ////public List<LIST_StatusInfo> GetAll(int p, int p_2, string p_3, global::SKT.Common.Model.SearchSettings searchSettings)
        ////{
        ////    throw new NotImplementedException();
        ////}

        //public List<LIST_StatusInfo> GetAll(int p, int p_2, string p_3, global::SKT.Common.Model.SearchSettings searchSettings)
        //{
        //    throw new NotImplementedException();
        //}
    }
}