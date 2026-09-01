using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.DictionaryData.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.DictionaryData.BLL
{
    public class UnitTransfor
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） UnitTransfor 信息。
        /// </summary>
        /// <param name="entity">UnitTransfor 实体对象。</param>
        public Int32 Edit(UnitTransforInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UnitTransforID", SqlDbType.Int),
                new SqlParameter("@UnitID", SqlDbType.Int),
                new SqlParameter("@TransforUnitID", SqlDbType.Int),
                new SqlParameter("@TransforData", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.UnitTransforID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.UnitID;
            parms[2].Value = entity.TransforUnitID;
            parms[3].Value = entity.TransforData;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_UnitTransfor_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 UnitTransforId 字符串删除 UnitTransfor 信息。
        /// </summary>
        /// <param name="idString">UnitTransforId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String UnitName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UnitName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = UnitName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_UnitTransfor_Delete", parms);
        }

        /// <summary>
        /// 根据 UnitTransforId 获取实体信息。
        /// </summary>
        /// <param name="unitTransforId">UnitTransforId。</param>
        /// <returns>UnitTransfor 实体对象。</returns>
        public UnitTransforInfo GetInfo(Int32 unitTransforId)
        {
            UnitTransforInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = unitTransforId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_UnitTransfor_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new UnitTransforInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>UnitTransfor 实体对象。</returns>
        public UnitTransforInfo GetInfo(String fieldValue)
        {
            UnitTransforInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_UnitTransfor_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new UnitTransforInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>UnitTransfor 实体对象。</returns>
        public UnitTransforInfo GetUnitTransforInfo(int UnitID, int TransforUnitID)
        {
            UnitTransforInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UnitID", SqlDbType.Int),
                new SqlParameter("@TransforUnitID", SqlDbType.Int)
            };

            parms[0].Value = UnitID;
            parms[1].Value = TransforUnitID;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetUnitTransfor", parms))
            {
                if (rdr.Read())
                {
                    entity = new UnitTransforInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 UnitTransfor 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="unitTransforCount">unitTransfor 总数。</param>
        /// <returns>UnitTransfor 列表。</returns>
        public List<UnitTransforInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<UnitTransforInfo> list = new List<UnitTransforInfo>();
            UnitTransforInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwUnitTransfor", "UnitTransforId",
                "[UnitTransforID], [UnitID], [TransforUnitID], [TransforData], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [UnitName], [TransforUnitName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new UnitTransforInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                    entity.UintName = rdr.GetString(8);
                    entity.TransforUnitName = rdr.GetString(9);

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