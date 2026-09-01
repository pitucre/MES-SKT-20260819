using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Labels.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Labels.BLL
{
    public class LabelZPLValues
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LabelZPLValues 信息。
        /// </summary>
        /// <param name="entity">LabelZPLValues 实体对象。</param>
        public Int32 Edit(LabelZPLValuesInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LabelZplValuesId", SqlDbType.Int),
                new SqlParameter("@LabelZplId", SqlDbType.Int),
                new SqlParameter("@ZplIndex", SqlDbType.Int),
                new SqlParameter("@ZplValues", SqlDbType.VarChar, 250)
            };

            parms[0].Value = entity.LabelZplValuesId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.LabelZplId;
            parms[2].Value = entity.ZplIndex;
            parms[3].Value = entity.ZplValues;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LabelZPLValues_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LabelZPLValuesId 字符串删除 LabelZPLValues 信息。
        /// </summary>
        /// <param name="idString">LabelZPLValuesId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LabelZPLValues_Delete", parms);
        }

        /// <summary>
        /// 根据 LabelZPLValuesId 获取实体信息。
        /// </summary>
        /// <param name="labelZPLValuesId">LabelZPLValuesId。</param>
        /// <returns>LabelZPLValues 实体对象。</returns>
        public LabelZPLValuesInfo GetInfo(Int32 labelZPLValuesId)
        {
            LabelZPLValuesInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = labelZPLValuesId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_LabelZPLValues_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LabelZPLValuesInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LabelZPLValues 实体对象。</returns>
        public LabelZPLValuesInfo GetInfo(String fieldValue)
        {
            LabelZPLValuesInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_LabelZPLValues_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LabelZPLValuesInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 LabelZPLValues 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="labelZPLValuesCount">labelZPLValues 总数。</param>
        /// <returns>LabelZPLValues 列表。</returns>
        public List<LabelZPLValuesInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LabelZPLValuesInfo> list = new List<LabelZPLValuesInfo>();
            LabelZPLValuesInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_LabelZPLValues", "LabelZPLValuesId",
                "[LabelZplValuesId], [LabelZplId], [ZplIndex], [ZplValues]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelZPLValuesInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3));

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