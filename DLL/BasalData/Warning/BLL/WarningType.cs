using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Warning.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;


namespace SKT.LeanMES.Warning.BLL
{
    public class WarningType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarningType 信息。
        /// </summary>
        /// <param name="entity">WarningType 实体对象。</param>
        public Int32 Edit(WarningTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarningTypeId", SqlDbType.Int),
                new SqlParameter("@WarningTypeName", SqlDbType.NVarChar, 50),
                new SqlParameter("@WarningTypeValue", SqlDbType.Decimal),
                new SqlParameter("@WarningGroup", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.WarningTypeId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.WarningTypeName;
            parms[2].Value = entity.WarningTypeValue;
            parms[3].Value = entity.WarningGroup;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_WarningType_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WarningTypeId 字符串删除 WarningType 信息。
        /// </summary>
        /// <param name="idString">WarningTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_WarningType_Delete", parms);
        }

        /// <summary>
        /// 根据 WarningTypeId 获取实体信息。
        /// </summary>
        /// <param name="warningTypeId">WarningTypeId。</param>
        /// <returns>WarningType 实体对象。</returns>
        public WarningTypeInfo GetInfo(Int32 warningTypeId)
        {
            WarningTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = warningTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_WarningType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarningTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDecimal(2), rdr.GetInt32(3), rdr.GetString(4),
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
        /// <returns>WarningType 实体对象。</returns>
        public WarningTypeInfo GetInfo(String fieldValue)
        {
            WarningTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_WarningType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarningTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDecimal(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 WarningType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warningTypeCount">warningType 总数。</param>
        /// <returns>WarningType 列表。</returns>
        public List<WarningTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarningTypeInfo> list = new List<WarningTypeInfo>();
            WarningTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_WarningType", "WarningTypeId",////SYS_WarningType
                "[WarningTypeId], [WarningTypeName], [WarningTypeValue], [WarningGroup], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarningTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDecimal(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));

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

        public List<WarningTypeInfo> GetWarningTypeListByGroupId(int groupId)
        {
            List<WarningTypeInfo> list = new List<WarningTypeInfo>();
            WarningTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarningGroup", SqlDbType.Int)
            };

            parms[0].Value = groupId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "Select WarningTypeId, WarningTypeName, WarningTypeValue, WarningGroup, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime, Remark from SYS_WarningType where WarningGroup = @WarningGroup", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarningTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDecimal(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
    }
}
