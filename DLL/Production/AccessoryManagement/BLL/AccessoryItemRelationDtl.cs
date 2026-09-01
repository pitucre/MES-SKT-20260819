using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.AccessoryManagement.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.AccessoryManagement.BLL
{
    public class AccessoryItemRelationDtl
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AccessoryItemRelationDtl 信息。
        /// </summary>
        /// <param name="entity">AccessoryItemRelationDtl 实体对象。</param>
        public Int32 Edit(AccessoryItemRelationDtlInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@Pid", SqlDbType.Int),
                new SqlParameter("@AccessoryCode", SqlDbType.VarChar, 50),
                new SqlParameter("@Value", SqlDbType.Decimal,18),
                new SqlParameter("@UnitName", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.Pid;
            parms[2].Value = entity.AccessoryCode;
            parms[3].Value = entity.Value;
            parms[4].Value = entity.UnitName;
            parms[5].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryItemRelationDtl_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AccessoryItemRelationDtlId 字符串删除 AccessoryItemRelationDtl 信息。
        /// </summary>
        /// <param name="idString">AccessoryItemRelationDtlId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryItemRelationDtl_Delete", parms);
        }

        /// <summary>
        /// 根据 AccessoryItemRelationDtlId 获取实体信息。
        /// </summary>
        /// <param name="accessoryItemRelationDtlId">AccessoryItemRelationDtlId。</param>
        /// <returns>AccessoryItemRelationDtl 实体对象。</returns>
        public AccessoryItemRelationDtlInfo GetInfo(Int32 accessoryItemRelationDtlId)
        {
            AccessoryItemRelationDtlInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = accessoryItemRelationDtlId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryItemRelationDtl_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryItemRelationDtlInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AccessoryItemRelationDtl 实体对象。</returns>
        public AccessoryItemRelationDtlInfo GetInfo(String fieldValue)
        {
            AccessoryItemRelationDtlInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryItemRelationDtl_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryItemRelationDtlInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AccessoryItemRelationDtl 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="accessoryItemRelationDtlCount">accessoryItemRelationDtl 总数。</param>
        /// <returns>AccessoryItemRelationDtl 列表。</returns>
        public List<AccessoryItemRelationDtlInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AccessoryItemRelationDtlInfo> list = new List<AccessoryItemRelationDtlInfo>();
            AccessoryItemRelationDtlInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_AccessoryItemRelationDtl", "Id",
                "[Id], [Pid], [AccessoryCode], cast([Value] as real) Value, [UnitName], [CreateBy], [CreateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AccessoryItemRelationDtlInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), Convert.ToDecimal(rdr["Value"]), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6));

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