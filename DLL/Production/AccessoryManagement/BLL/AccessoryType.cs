using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.AccessoryManagement.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.AccessoryManagement.BLL
{
    public class AccessoryType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AccessoryType 信息。
        /// </summary>
        /// <param name="entity">AccessoryType 实体对象。</param>
        public Int32 Edit(AccessoryTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AccessoryTypeId", SqlDbType.Int),
                new SqlParameter("@AccessoryTypeName", SqlDbType.VarChar, 50),
                new SqlParameter("@ThawTime", SqlDbType.Float),
                new SqlParameter("@LeaveUnusedTime", SqlDbType.Float),
                new SqlParameter("@UseTime", SqlDbType.Float),
                new SqlParameter("@StirTime", SqlDbType.Float),
                new SqlParameter("@StirIdleTime", SqlDbType.Float),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@StirQty", SqlDbType.Int)
            };

            parms[0].Value = entity.AccessoryTypeId;
            parms[1].Value = entity.AccessoryTypeName;
            parms[2].Value = entity.ThawTime;
            parms[3].Value = entity.LeaveUnusedTime;
            parms[4].Value = entity.UseTime;
            parms[5].Value = entity.StirTime;
            parms[6].Value = entity.StirIdleTime;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.StirQty;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryType_Edit", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 根据 AccessoryTypeId 字符串删除 AccessoryType 信息。
        /// </summary>
        /// <param name="idString">AccessoryTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryType_Delete", parms);
        }

        /// <summary>
        /// 根据 AccessoryTypeId 获取实体信息。
        /// </summary>
        /// <param name="accessoryTypeId">AccessoryTypeId。</param>
        /// <returns>AccessoryType 实体对象。</returns>
        public AccessoryTypeInfo GetInfo(Int32 accessoryTypeId)
        {
            AccessoryTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = accessoryTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDouble(2), rdr.GetDouble(3), rdr.GetDouble(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDouble(7), rdr.GetDouble(8), rdr.GetInt32(9));
                }
                rdr.Close();
            } 

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AccessoryType 实体对象。</returns>
        public AccessoryTypeInfo GetInfo(String fieldValue)
        {
            AccessoryTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDouble(2), rdr.GetDouble(3), rdr.GetDouble(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDouble(7), rdr.GetDouble(8), rdr.GetInt32(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AccessoryType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="accessoryTypeCount">accessoryType 总数。</param>
        /// <returns>AccessoryType 列表。</returns>
        public List<AccessoryTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AccessoryTypeInfo> list = new List<AccessoryTypeInfo>();
            AccessoryTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_AccessoryType", "AccessoryTypeId",////Prod_AccessoryType
                "[AccessoryTypeId], [AccessoryTypeName], [ThawTime], [LeaveUnusedTime], [UseTime], [CreateBy], [CreateTime],[StirTime],[StirIdleTime],[StirQty],ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AccessoryTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDouble(2), rdr.GetDouble(3), rdr.GetDouble(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDouble(7), rdr.GetDouble(8), rdr.GetInt32(9));

                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime"))) {
                        entity.ModifyBy = rdr["ModifyBy"].ToString();
                        entity.ModifyTime =Convert.ToDateTime(rdr["ModifyTime"]);
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