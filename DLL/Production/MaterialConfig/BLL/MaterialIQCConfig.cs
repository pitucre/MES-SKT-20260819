using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaterialConfig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.MaterialConfig.BLL
{
    public class MaterialIQCConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialIQCConfig 信息。
        /// </summary>
        /// <param name="entity">MaterialIQCConfig 实体对象。</param>
        public void Edit(MaterialIQCConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@CheckTypeId", SqlDbType.Int),
                new SqlParameter("@CheckType", SqlDbType.VarChar, 50),
                new SqlParameter("@MaterialStatusId", SqlDbType.Int),
                new SqlParameter("@MaterialStatus", SqlDbType.VarChar, 50),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200),
                new SqlParameter("@IsStorage", SqlDbType.Bit),
                new SqlParameter("@UserName", SqlDbType.NVarChar, 20),
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.CheckTypeId;
            parms[2].Value = entity.CheckType;
            parms[3].Value = entity.MaterialStatusId;
            parms[4].Value = entity.MaterialStatus;
            parms[5].Value = entity.Remark;
            parms[6].Value = entity.IsStorage;
            parms[7].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialIQCConfig_Edit", parms);

        }

        /// <summary>
        /// 根据 MaterialIQCConfigId 字符串删除 MaterialIQCConfig 信息。
        /// </summary>
        /// <param name="idString">MaterialIQCConfigId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialIQCConfig_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialIQCConfigId 获取实体信息。
        /// </summary>
        /// <param name="materialIQCConfigId">MaterialIQCConfigId。</param>
        /// <returns>MaterialIQCConfig 实体对象。</returns>
        public MaterialIQCConfigInfo GetInfo(Int32 materialIQCConfigId)
        {
            MaterialIQCConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialIQCConfigId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialIQCConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialIQCConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5),rdr.GetBoolean(6),rdr.GetBoolean(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialIQCConfig 实体对象。</returns>
        public MaterialIQCConfigInfo GetInfo(String fieldValue)
        {
            MaterialIQCConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialIQCConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialIQCConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetBoolean(6), rdr.GetBoolean(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaterialIQCConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialIQCConfigCount">materialIQCConfig 总数。</param>
        /// <returns>MaterialIQCConfig 列表。</returns>
        public List<MaterialIQCConfigInfo> GetMaterialAllIQCStaus(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialIQCConfigInfo> list = new List<MaterialIQCConfigInfo>();
            MaterialIQCConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_MaterialIQCStatus", "ID",
                " [ID],[IQCStatus] ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialIQCConfigInfo();
                    entity.IQCStatusId = rdr.GetInt32(0);
                    entity.IQCStatus = rdr.GetString(1);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 MaterialIQCConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialIQCConfigCount">materialIQCConfig 总数。</param>
        /// <returns>MaterialIQCConfig 列表。</returns>
        public List<MaterialIQCConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialIQCConfigInfo> list = new List<MaterialIQCConfigInfo>();
            MaterialIQCConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_MaterialIQCConfig", "ID",
                "[ID], [CheckTypeId], [CheckType], [MaterialStatusId], [MaterialStatus], [Remark],[IsGlobal],[IsStorage],CreateBy,CreateDateTime,ModifyBy,ModifyDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialIQCConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetBoolean(6),rdr.GetBoolean(7));
                    entity.CreateBy = Convert.ToString(rdr[8]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr[9]);
                    entity.ModifyBy = Convert.ToString(rdr[10]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr[11]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 MRB相关的MaterialIQCConfig
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialIQCConfigCount">materialIQCConfig 总数。</param>
        /// <returns>MaterialIQCConfig 列表。</returns>
        public List<MaterialIQCConfigInfo> GetMRB(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialIQCConfigInfo> list = new List<MaterialIQCConfigInfo>();
            MaterialIQCConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_MaterialIQCConfig_MRB", "ID",
                "[ID], [CheckTypeId], [CheckType], [MaterialStatusId], [MaterialStatus], [Remark],[IsGlobal],[IsStorage],CreateBy,CreateDateTime,ModifyBy,ModifyDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialIQCConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetBoolean(6), rdr.GetBoolean(7));
                    entity.CreateBy = Convert.ToString(rdr[8]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr[9]);
                    entity.ModifyBy = Convert.ToString(rdr[10]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr[11]);
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