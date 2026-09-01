using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.NCCode.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.NCCode.BLL
{
    public class DataType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） DataType 信息。
        /// </summary>
        /// <param name="entity">DataType 实体对象。</param>
        public Int32 Edit(DataTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DataTypeId", SqlDbType.Int),
                new SqlParameter("@Category", SqlDbType.VarChar, 20),
                new SqlParameter("@Data_Type_Name", SqlDbType.VarChar, 30),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@Validation_Activity", SqlDbType.VarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.DataTypeId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Category;
            parms[2].Value = entity.Data_Type_Name;
            parms[3].Value = entity.Description;
            parms[4].Value = entity.Validation_Activity;
            parms[5].Value = entity.Remark;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_DataType_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 DataTypeId 字符串删除 DataType 信息。
        /// </summary>
        /// <param name="idString">DataTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_DataType_Delete", parms);
        }

        /// <summary>
        /// 根据 DataTypeId 获取实体信息。
        /// </summary>
        /// <param name="dataTypeId">DataTypeId。</param>
        /// <returns>DataType 实体对象。</returns>
        public DataTypeInfo GetInfo(Int32 dataTypeId)
        {
            DataTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = dataTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_DataType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DataTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>DataType 实体对象。</returns>
        public DataTypeInfo GetInfo(String fieldValue)
        {
            DataTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_DataType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DataTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 DataType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="dataTypeCount">dataType 总数。</param>
        /// <returns>DataType 列表。</returns>
        public List<DataTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DataTypeInfo> list = new List<DataTypeInfo>();
            DataTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_DataType", "DataTypeId",
                "[DataTypeId], [Category], [Data_Type_Name], [Description], [Validation_Activity], [Remark], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new DataTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));

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