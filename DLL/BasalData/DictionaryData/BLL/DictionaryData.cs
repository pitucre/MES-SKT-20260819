using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.DictionaryData.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.DictionaryData.BLL
{
    public class DictionaryData
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） DictionaryData 信息。
        /// </summary>
        /// <param name="entity">DictionaryData 实体对象。</param>
        public Int32 Edit(DictionaryDataInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DictionaryDataID", SqlDbType.Int),
                new SqlParameter("@Code", SqlDbType.NVarChar, 20),
                new SqlParameter("@Name", SqlDbType.NVarChar, 20),
                new SqlParameter("@DicProperty", SqlDbType.NVarChar, 20),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@Value", SqlDbType.VarChar, 30),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.DictionaryDataID;
            parms[1].Value = entity.Code;
            parms[2].Value = entity.Name;
            parms[3].Value = entity.DicProperty;
            parms[4].Value = entity.Description;
            parms[5].Value = entity.Value;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_DictionaryData_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 DictionaryDataId 字符串删除 DictionaryData 信息。
        /// </summary>
        /// <param name="idString">DictionaryDataId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_DictionaryData_Delete", parms);
        }

        /// <summary>
        /// 根据 DictionaryDataId 获取实体信息。
        /// </summary>
        /// <param name="dictionaryDataId">DictionaryDataId。</param>
        /// <returns>DictionaryData 实体对象。</returns>
        public DictionaryDataInfo GetInfo(Int32 dictionaryDataId)
        {
            DictionaryDataInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = dictionaryDataId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_DictionaryData_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DictionaryDataInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }
       
        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>DictionaryData 实体对象。</returns>
        public DictionaryDataInfo GetInfo(String fieldValue, string dicProperty)
        {
            DictionaryDataInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit),
                new SqlParameter("@DicProperty", SqlDbType.NVarChar,20)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;
            parms[2].Value = dicProperty;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_DictionaryData_GetInfoNew", parms))
            {
                if (rdr.Read())
                {
                    entity = new DictionaryDataInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>DictionaryData 实体对象。</returns>
        public DictionaryDataInfo GetInfo(String fieldValue)
        {
            DictionaryDataInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_DictionaryData_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DictionaryDataInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 DictionaryData 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="dictionaryDataCount">dictionaryData 总数。</param>
        /// <returns>DictionaryData 列表。</returns>
        public List<DictionaryDataInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DictionaryDataInfo> list = new List<DictionaryDataInfo>();
            DictionaryDataInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_DictionaryData", "DictionaryDataId",////SYS_DictionaryData
                "[DictionaryDataID], [Name], [Description], [Value], [Remark], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy],DicProperty", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new DictionaryDataInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.DicProperty = rdr.GetString(9);
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