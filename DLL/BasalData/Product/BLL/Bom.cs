using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Product.BLL
{
    public class Bom
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Bom 信息。
        /// </summary>
        /// <param name="entity">Bom 实体对象。</param>
        public Int32  Edit(BomInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BomId", SqlDbType.Int),
                new SqlParameter("@BomName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Revision", SqlDbType.VarChar, 10),
                new SqlParameter("@BomDesc", SqlDbType.NVarChar, 50),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@IsCurrentRev", SqlDbType.Bit),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.BomId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.BomName;
            parms[2].Value = entity.Revision;
            parms[3].Value = entity.BomDesc;
            parms[4].Value = entity.Status;
            parms[5].Value = entity.IsCurrentRev;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Bom_Edit", parms);

            return Convert.ToInt32(parms[0].Value);
        }

        /// <summary>
        /// 根据 BomId 字符串删除 Bom 信息。
        /// </summary>
        /// <param name="idString">BomId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Bom_Delete", parms);
        }

        /// <summary>
        /// 根据 BomId 获取实体信息。
        /// </summary>
        /// <param name="bomId">BomId。</param>
        /// <returns>Bom 实体对象。</returns>
        public BomInfo GetInfo(Int32 bomId)
        {
            BomInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = bomId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Bom_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new BomInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetBoolean(5), rdr.GetInt32(6), rdr.GetBoolean(7), rdr.GetDateTime(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));

                    entity.IsMESadd = rdr.GetString(15);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Bom 实体对象。</returns>
        public BomInfo GetInfo(String fieldValue)
        {
            BomInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Bom_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new BomInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetBoolean(5), rdr.GetInt32(6), rdr.GetBoolean(7), rdr.GetDateTime(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));

                    entity.IsMESadd = rdr.GetString(15);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Bom 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="bomCount">bom 总数。</param>
        /// <returns>Bom 列表。</returns>
        public List<BomInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<BomInfo> list = new List<BomInfo>();
            BomInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_BomStatus", "BomID",
                "[BomId], [BomName], [Revision], [BomDesc], [Status], [IsCurrentRev], [CopiedFromBomID], [HasBeenReleased], [EffStartDate], [EffEndDate], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[BomStatus_Choose], IsMESadd", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new BomInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetBoolean(5), rdr.GetInt32(6), rdr.GetBoolean(7), rdr.GetDateTime(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));
                    entity.BomStatus_Choose = rdr.GetString(15); //for choose BOMStatus

                    entity.IsMESadd = rdr.GetString(16);

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