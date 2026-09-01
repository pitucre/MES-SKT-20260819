using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaterialConfig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.MaterialConfig.BLL
{
    public class MaterialSysConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialSysConfig 信息。
        /// </summary>
        /// <param name="entity">MaterialSysConfig 实体对象。</param>
        public void Edit(MaterialSysConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@ConfigTypeId", SqlDbType.Int),
                new SqlParameter("@ConfigType", SqlDbType.VarChar, 50),
                new SqlParameter("@ConfigResult", SqlDbType.NVarChar,-1),
                new SqlParameter("@ConfigDesc", SqlDbType.VarChar, 50),
                new SqlParameter("@IsGlobal", SqlDbType.Bit),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@Moudle", SqlDbType.Int),
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.ConfigTypeId;
            parms[2].Value = entity.ConfigType;
            parms[3].Value = entity.ConfigResult;
            parms[4].Value = entity.ConfigDesc;
            parms[5].Value = entity.IsGlobal;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.UserName;
            parms[8].Value = entity.Moudle;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSysConfig_Edit", parms);

        }

        /// <summary>
        /// 根据 MaterialSysConfigId 字符串删除 MaterialSysConfig 信息。
        /// </summary>
        /// <param name="idString">MaterialSysConfigId 字符串。</param>
        /// <param name="userName"></param>
        /// <param name="moudle">操作模块 主要为了记录操作日志（0：仓库管理>仓库数据配置>仓库配置列表  1：生产管理>生产数据配置>生产数据设置）</param>
        public void Delete(String idString, String userName, int moudle)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@Moudle", SqlDbType.Int),
            };

            parms[0].Value = idString;
            parms[1].Value = userName;
            parms[2].Value = moudle;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSysConfig_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialSysConfigId 获取实体信息。
        /// </summary>
        /// <param name="materialSysConfigId">MaterialSysConfigId。</param>
        /// <returns>MaterialSysConfig 实体对象。</returns>
        public MaterialSysConfigInfo GetInfo(Int32 materialSysConfigId)
        {
            MaterialSysConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialSysConfigId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSysConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialSysConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetBoolean(5), rdr.GetString(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialSysConfig 实体对象。</returns>
        public MaterialSysConfigInfo GetInfo(String fieldValue)
        {
            MaterialSysConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSysConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialSysConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetBoolean(5), rdr.GetString(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaterialSysConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialSysConfigCount">materialSysConfig 总数。</param>
        /// <returns>MaterialSysConfig 列表。</returns>
        public List<MaterialSysConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialSysConfigInfo> list = new List<MaterialSysConfigInfo>();
            MaterialSysConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_MaterialSysConfig", "ID",////Prod_MaterialSysConfig
                "[ID], [ConfigTypeId], [ConfigType], [ConfigResult], [ConfigDesc], [IsGlobal], [Remark],ISNULL(CreateBy,'') AS CreateBy,ISNULL(CreateDateTime,GETDATE()) AS CreateDateTime,ISNULL(ModifyBy,'') AS ModifyBy,ISNULL(ModifyDateTime,GETDATE()) AS ModifyDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialSysConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetBoolean(5), rdr.GetString(6));
                    entity.CreateBy = rdr.GetString(7);
                    entity.CreateDateTime = rdr.GetDateTime(8);
                    entity.ModifyBy = rdr.GetString(9);
                    entity.ModifyDateTime = rdr.GetDateTime(10);
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