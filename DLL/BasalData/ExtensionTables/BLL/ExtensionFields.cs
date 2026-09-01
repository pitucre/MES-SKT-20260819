using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.ExtensionTables.Model;

namespace SKT.LeanMES.ExtensionTables.BLL
{
    public class ExtensionFields
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ExtensionFields 信息。
        /// </summary>
        /// <param name="entity">ExtensionFields 实体对象。</param>
        public Int32 Edit(ExtensionFieldsInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExtensionFieldsId", SqlDbType.Int),
                new SqlParameter("@TableName", SqlDbType.VarChar, 50),
                new SqlParameter("@ExtensionFieldName", SqlDbType.VarChar, 50),
                new SqlParameter("@ExtensionFieldDescription", SqlDbType.NVarChar, 50),
                new SqlParameter("@ExtensionFieldType", SqlDbType.VarChar, 50),
                new SqlParameter("@ExtensionFieldIsAllowNull", SqlDbType.Bit),
                new SqlParameter("@Sequence", SqlDbType.Int),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ExtensionFieldsId;
            parms[1].Value = entity.TableName;
            parms[2].Value = entity.ExtensionFieldName;
            parms[3].Value = entity.ExtensionFieldDescription;
            parms[4].Value = entity.ExtensionFieldType;
            parms[5].Value = entity.ExtensionFieldIsAllowNull;
            parms[6].Value = entity.Sequence;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ExtensionFields_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ExtensionFieldsId 字符串删除 ExtensionFields 信息。
        /// </summary>
        /// <param name="idString">ExtensionFieldsId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ExtensionFields_Delete", parms);
        }

        /// <summary>
        /// 根据 ExtensionFieldsId 获取实体信息。
        /// </summary>
        /// <param name="extensionFieldsId">ExtensionFieldsId。</param>
        /// <returns>ExtensionFields 实体对象。</returns>
        public ExtensionFieldsInfo GetInfo(Int32 extensionFieldsId)
        {
            ExtensionFieldsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = extensionFieldsId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ExtensionFields_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ExtensionFieldsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetBoolean(5), rdr.GetInt32(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ExtensionFields 实体对象。</returns>
        public ExtensionFieldsInfo GetInfo(String fieldValue)
        {
            ExtensionFieldsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ExtensionFields_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ExtensionFieldsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetBoolean(5), rdr.GetInt32(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ExtensionFields 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="extensionFieldsCount">extensionFields 总数。</param>
        /// <returns>ExtensionFields 列表。</returns>
        public List<ExtensionFieldsInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ExtensionFieldsInfo> list = new List<ExtensionFieldsInfo>();
            ExtensionFieldsInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_ExtensionFields", "ExtensionFieldsId",////Basal_ExtensionFields
                "[ExtensionFieldsId], [TableName], [ExtensionFieldName], [ExtensionFieldDescription], [ExtensionFieldType], [ExtensionFieldIsAllowNull], [Sequence], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ExtensionFieldsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetBoolean(5), rdr.GetInt32(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetString(11));

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