using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Material.BLL
{
    /// <summary>
    /// 急料管理
    /// </summary>
    public class UrgentMaterial
    {     
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） UrgentMaterial 信息。
        /// </summary>
        /// <param name="entity">UrgentMaterial 实体对象。</param>
        public Int32 Edit(UrgentMaterialInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UrgentMaterialId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50),
                new SqlParameter("@POCode", SqlDbType.VarChar, 50),
                new SqlParameter("@StarDateTime", SqlDbType.DateTime),
                new SqlParameter("@EndDateTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@UpdateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@Reserve", SqlDbType.VarChar, 50),
                new SqlParameter("@Reserve1", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.UrgentMaterialId;
            parms[1].Value = entity.ItemCode;
            parms[2].Value = entity.POCode;
            parms[3].Value = entity.StarDateTime;
            parms[4].Value = entity.EndDateTime;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.UpdateBy;
            parms[7].Value = entity.Reserve;
            parms[8].Value = entity.Reserve1;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_UrgentMaterial_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 UrgentMaterialId 字符串删除 UrgentMaterial 信息。
        /// </summary>
        /// <param name="idString">UrgentMaterialId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_UrgentMaterial_Delete", parms);
        }

        /// <summary>
        /// 根据 UrgentMaterialId 获取实体信息。
        /// </summary>
        /// <param name="urgentMaterialId">UrgentMaterialId。</param>
        /// <returns>UrgentMaterial 实体对象。</returns>
        public UrgentMaterialInfo GetInfo(Int32 urgentMaterialId)
        {
            UrgentMaterialInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = urgentMaterialId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_UrgentMaterial_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new UrgentMaterialInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>UrgentMaterial 实体对象。</returns>
        public UrgentMaterialInfo GetInfo(String fieldValue)
        {
            UrgentMaterialInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_UrgentMaterial_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new UrgentMaterialInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 UrgentMaterial 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="urgentMaterialCount">urgentMaterial 总数。</param>
        /// <returns>UrgentMaterial 列表。</returns>
        public List<UrgentMaterialInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<UrgentMaterialInfo> list = new List<UrgentMaterialInfo>();
            UrgentMaterialInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_UrgentMaterial", "UrgentMaterialId",////Prod_UrgentMaterial
                "[UrgentMaterialId], [ItemCode], [POCode], [StarDateTime], [EndDateTime], [CreateBy], [CreateDateTime], ISNULL([UpdateBy],'') AS [UpdateBy], ISNULL([UpdateDateTime],'') AS [UpdateDateTime],[Reserve], [Reserve1]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new UrgentMaterialInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetString(10));

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