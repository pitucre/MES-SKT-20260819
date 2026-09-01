using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;


namespace SKT.LeanMES.SMT.BLL
{
    public class FeederType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） FEEDERTYPE 信息。
        /// </summary>
        /// <param name="entity">FEEDERTYPE 实体对象。</param>
        public Int32 Edit(FeederTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@Name", SqlDbType.NVarChar, 50),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@Size", SqlDbType.Int),
                new SqlParameter("@Pitch", SqlDbType.Int),
                new SqlParameter("@Attrition", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Name;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.Size;
            parms[4].Value = entity.Pitch;
            parms[5].Value = entity.Attrition;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_FeederType_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 FEEDERTYPEId 字符串删除 FEEDERTYPE 信息。
        /// </summary>
        /// <param name="idString">FEEDERTYPEId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_FeederType_Delete", parms);
        }

        /// <summary>
        /// 根据 FEEDERTYPEId 获取实体信息。
        /// </summary>
        /// <param name="fEEDERTYPEId">FEEDERTYPEId。</param>
        /// <returns>FEEDERTYPE 实体对象。</returns>
        public FeederTypeInfo GetInfo(Int32 fEEDERTYPEId)
        {
            FeederTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fEEDERTYPEId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_FeederType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FeederTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FEEDERTYPE 实体对象。</returns>
        public FeederTypeInfo GetInfo(String fieldValue)
        {
            FeederTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_FeederType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 FEEDERTYPE 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="fEEDERTYPECount">fEEDERTYPE 总数。</param>
        /// <returns>FEEDERTYPE 列表。</returns>
        public List<FeederTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FeederTypeInfo> list = new List<FeederTypeInfo>();
            FeederTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_FeerderType a LEFT JOIN SYS_Users u ( NOLOCK ) ON RTRIM(LTRIM(a.ModifyBy)) = u.UserName", "ID",
                "[ID], [Name], [Description], [Size], [Pitch], [Attrition], ISNULL(u.CName, '') AS ModifyBy,a.ModifyDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new FeederTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5));
                    
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyDateTime")))
                    {
                        entity.ModifyBy = rdr.GetString(6);
                        entity.ModifyDateTime = rdr.GetDateTime(7);
                    }

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