using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Schedule.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Schedule.BLL
{
    public class SchedulingLockMaterial
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SchedulingLockMaterial 信息。
        /// </summary>
        /// <param name="entity">SchedulingLockMaterial 实体对象。</param>
        public void Edit(SchedulingLockMaterialInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@MaterialCode", SqlDbType.NVarChar, 60),
                new SqlParameter("@MaterialName", SqlDbType.NVarChar, 60),
                new SqlParameter("@CurStockQty", SqlDbType.Decimal),
                new SqlParameter("@LockQty", SqlDbType.Decimal),
                new SqlParameter("@UpdateDateTime", SqlDbType.DateTime),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.MaterialCode;
            parms[2].Value = entity.MaterialName;
            parms[3].Value = entity.CurStockQty;
            parms[4].Value = entity.LockQty;
            parms[5].Value = entity.UpdateDateTime;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_SchedulingLockMaterial_Edit", parms);

        }

        /// <summary>
        /// 根据 SchedulingLockMaterialId 获取实体信息。
        /// </summary>
        /// <param name="schedulingLockMaterialId">SchedulingLockMaterialId。</param>
        /// <returns>SchedulingLockMaterial 实体对象。</returns>
        public SchedulingLockMaterialInfo GetInfo(Int32 schedulingLockMaterialId)
        {
            SchedulingLockMaterialInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = schedulingLockMaterialId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_SchedulingLockMaterial_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulingLockMaterialInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDecimal(3), rdr.GetDecimal(4), 
                        rdr.GetDateTime(5), rdr.GetString(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SchedulingLockMaterial 实体对象。</returns>
        public SchedulingLockMaterialInfo GetInfo(String fieldValue)
        {
            SchedulingLockMaterialInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_SchedulingLockMaterial_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulingLockMaterialInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDecimal(3), rdr.GetDecimal(4), 
                        rdr.GetDateTime(5), rdr.GetString(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SchedulingLockMaterial 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="schedulingLockMaterialCount">schedulingLockMaterial 总数。</param>
        /// <returns>SchedulingLockMaterial 列表。</returns>
        public List<SchedulingLockMaterialInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SchedulingLockMaterialInfo> list = new List<SchedulingLockMaterialInfo>();
            SchedulingLockMaterialInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_SchedulingLockMaterial", "SchedulingLockMaterialId",
                "[Id], [MaterialCode], [MaterialName], [CurStockQty], [LockQty], [UpdateDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SchedulingLockMaterialInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDecimal(3), rdr.GetDecimal(4), 
                        rdr.GetDateTime(5), rdr.GetString(6));

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