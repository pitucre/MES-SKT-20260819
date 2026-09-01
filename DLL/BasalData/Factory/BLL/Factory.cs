using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Factory.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Factory.BLL
{
    public class Factory
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Factory 信息。
        /// </summary>
        /// <param name="entity">Factory 实体对象。</param>
        public Int32 Edit(FactoryInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FactoryID", SqlDbType.Int),
                new SqlParameter("@FactoryName", SqlDbType.NVarChar, 50),
                new SqlParameter("@FactoryCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@ChkIsDefaultFactory", SqlDbType.Int),
                new SqlParameter("@TypeId", SqlDbType.Int),
            };

            parms[0].Value = entity.FactoryID;
            parms[1].Value = entity.FactoryName;
            parms[2].Value = entity.FactoryCode;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.Remark;
            parms[6].Value = entity.ChkIsDefaultFactory;
            parms[7].Value = entity.TypeId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Factory_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 FactoryId 字符串删除 Factory 信息。
        /// </summary>
        /// <param name="idString">FactoryId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Factory_Delete", parms);
        }

        /// <summary>
        /// 根据 FactoryId 获取实体信息。
        /// </summary>
        /// <param name="factoryId">FactoryId。</param>
        /// <returns>Factory 实体对象。</returns>
        public FactoryInfo GetInfo(Int32 factoryId)
        {
            FactoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = factoryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Factory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FactoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Factory 实体对象。</returns>
        public FactoryInfo GetInfo(String fieldValue)
        {
            FactoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Factory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FactoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Factory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="factoryCount">factory 总数。</param>
        /// <returns>Factory 列表。</returns>
        public List<FactoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FactoryInfo> list = new List<FactoryInfo>();
            FactoryInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_Factory", "FactoryID",////Basal_Factory
                "[FactoryID], [FactoryName], [FactoryCode], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[ChkIsDefaultFactory]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new FactoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8));
                    entity.IsDefaultFactory = entity.ChkIsDefaultFactory == 1 ? "是" : "否";
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