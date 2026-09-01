using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Labels.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Labels.BLL
{
    public class LabelZPL
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LabelZPL 信息。
        /// </summary>
        /// <param name="entity">LabelZPL 实体对象。</param>
        public Int32 Edit(LabelZPLInfo entity, string ZplValues)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LabelZplId", SqlDbType.Int),
                new SqlParameter("@ZplName", SqlDbType.NVarChar, 20),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@ZplValues", SqlDbType.NVarChar,-1),
                new SqlParameter("@ZplType", SqlDbType.Int)
            };

            parms[0].Value = entity.LabelZplId;
            parms[1].Value = entity.ZplName;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.ModifyBy;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.Remark;
            parms[6].Value = ZplValues;
            parms[7].Value = entity.ZplType;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LabelZPL_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LabelZPLId 字符串删除 LabelZPL 信息。
        /// </summary>
        /// <param name="idString">LabelZPLId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LabelZPL_Delete", parms);
        }

        /// <summary>
        /// 根据 LabelZPLId 获取实体信息。
        /// </summary>
        /// <param name="labelZPLId">LabelZPLId。</param>
        /// <returns>LabelZPL 实体对象。</returns>
        public LabelZPLInfo GetInfo(Int32 labelZPLId)
        {
            LabelZPLInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = labelZPLId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_LabelZPL_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LabelZPLInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetString(7), rdr["ZplType"] == DBNull.Value ? 0 : rdr.GetInt32(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LabelZPL 实体对象。</returns>
        public LabelZPLInfo GetInfo(String fieldValue)
        {
            LabelZPLInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_LabelZPL_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LabelZPLInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetString(7), rdr.GetInt32(8));
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// add by weixia on 2015.4.29
        /// </summary>
        /// <param name="strZPLName"></param>
        /// <returns></returns>
        public DataTable GetZPLValueByName(String strZPLName)
        {
            SqlParameter[] parms = new SqlParameter[]
             {
                  new SqlParameter("@ZPLName",SqlDbType.VarChar)
             };
            parms[0].Value = strZPLName;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetZPLValueByName", parms);
        }

        /// <summary>
        /// 分页获取 LabelZPL 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="labelZPLCount">labelZPL 总数。</param>
        /// <returns>LabelZPL 列表。</returns>
        public List<LabelZPLInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LabelZPLInfo> list = new List<LabelZPLInfo>();
            LabelZPLInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_LabelZPL", "LabelZPLId",
                "[LabelZplId], [ZplName], [Description], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy], [Remark], [ZplType]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelZPLInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetString(7), rdr["ZplType"] == DBNull.Value ? 0 : rdr.GetInt32(8));

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