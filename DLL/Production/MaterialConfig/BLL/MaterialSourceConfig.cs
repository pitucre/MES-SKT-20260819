using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaterialConfig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.MaterialConfig.BLL
{
    public class MaterialSourceConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialSourceConfig 信息。
        /// </summary>
        /// <param name="entity">MaterialSourceConfig 实体对象。</param>
        public Int32 Edit(MaterialSourceConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@ConfigTypeId", SqlDbType.Int),
                new SqlParameter("@ConfigType", SqlDbType.VarChar, 50),
                new SqlParameter("@ChoosePageId", SqlDbType.Int),
                new SqlParameter("@ChoosePageName", SqlDbType.VarChar, 50),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200)
            };

            parms[0].Value = entity.ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ConfigTypeId;
            parms[2].Value = entity.ConfigType;
            parms[3].Value = entity.ChoosePageId;
            parms[4].Value = entity.ChoosePageName;
            parms[5].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSourceConfig_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MaterialSourceConfigId 字符串删除 MaterialSourceConfig 信息。
        /// </summary>
        /// <param name="idString">MaterialSourceConfigId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSourceConfig_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialSourceConfigId 获取实体信息。
        /// </summary>
        /// <param name="materialSourceConfigId">MaterialSourceConfigId。</param>
        /// <returns>MaterialSourceConfig 实体对象。</returns>
        public MaterialSourceConfigInfo GetInfo(Int32 materialSourceConfigId)
        {
            MaterialSourceConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialSourceConfigId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSourceConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialSourceConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialSourceConfig 实体对象。</returns>
        public MaterialSourceConfigInfo GetInfo(String fieldValue)
        {
            MaterialSourceConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSourceConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialSourceConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        //获取仓库配置信息
        public string GetMaterialSysConfig(Int32 configTypeId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@ConfigTypeId",SqlDbType.Int)
            };
            parms[0].Value = configTypeId;
            return ComMethod.GetList("uspGetMaterialSysConfig", parms);
        }

        /// <summary>
        /// 分页获取 MaterialSourceConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialSourceConfigCount">materialSourceConfig 总数。</param>
        /// <returns>MaterialSourceConfig 列表。</returns>
        public List<MaterialSourceConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialSourceConfigInfo> list = new List<MaterialSourceConfigInfo>();
            MaterialSourceConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_MaterialSourceConfig", "MaterialSourceConfigId",
                "[ID], [ConfigTypeId], [ConfigType], [ChoosePageId], [ChoosePageName], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialSourceConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5));

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