using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaterialDelivery.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.Common.Utility;

namespace SKT.LeanMES.MaterialDelivery.BLL
{
    public class MaterialPrepare
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialPrepare 信息。
        /// </summary>
        /// <param name="entity">MaterialPrepare 实体对象。</param>
        public Int32 Edit(MaterialPrepareInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PrepareId", SqlDbType.Int),
                new SqlParameter("@PrepareNO", SqlDbType.NVarChar, 50),
                new SqlParameter("@ScheduleId", SqlDbType.Int),
                new SqlParameter("@RequestDate", SqlDbType.DateTime),
                new SqlParameter("@STATUS", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@GetPerson", SqlDbType.VarChar, 20),
                new SqlParameter("@GetDateTime", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.PrepareId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.PrepareNO;
            parms[2].Value = entity.ScheduleId;
            parms[3].Value = entity.RequestDate;
            parms[4].Value = entity.STATUS;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.GetPerson;
            parms[7].Value = entity.GetDateTime;
            parms[8].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialPrepare_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MaterialPrepareId 字符串删除 MaterialPrepare 信息。
        /// </summary>
        /// <param name="idString">MaterialPrepareId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialPrepare_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialPrepareId 获取实体信息。
        /// </summary>
        /// <param name="materialPrepareId">MaterialPrepareId。</param>
        /// <returns>MaterialPrepare 实体对象。</returns>
        public MaterialPrepareInfo GetInfo(Int32 materialPrepareId)
        {
            MaterialPrepareInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialPrepareId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialPrepare_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialPrepareInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetDecimal(5), TypeHelper.ToString(rdr.GetDateTime(6)), rdr.GetInt32(7),
                        rdr.GetString(8), TypeHelper.ToString(rdr.GetDateTime(9)), rdr.GetString(10), TypeHelper.ToString(rdr.GetDateTime(11)), rdr.GetString(12),
                        TypeHelper.ToString(rdr.GetDateTime(13)));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialPrepare 实体对象。</returns>
        public MaterialPrepareInfo GetInfo(String fieldValue)
        {
            MaterialPrepareInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialPrepare_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialPrepareInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), TypeHelper.ToString(rdr.GetDateTime(3)), rdr.GetInt32(4), 
                        rdr.GetString(5), TypeHelper.ToString(rdr.GetDateTime(6)), rdr.GetString(7), TypeHelper.ToString(rdr.GetDateTime(8)), rdr.GetString(9), 
                        TypeHelper.ToString(rdr.GetDateTime(10)));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaterialPrepare 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialPrepareCount">materialPrepare 总数。</param>
        /// <returns>MaterialPrepare 列表。</returns>
        public List<MaterialPrepareInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialPrepareInfo> list = new List<MaterialPrepareInfo>();
            MaterialPrepareInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwPrepareMaterial", "PrepareId",
                "[PrepareId], [PrepareNO], [ProdOrderNO], [SectionCode], [ProductCode], [RequestQty], [RequestDate], [STATUS], [CreateBy], [CreateDateTime], [GetPerson], [GetDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialPrepareInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetDecimal(5), TypeHelper.ToString(rdr.GetDateTime(6)), rdr.GetInt32(7), 
                        rdr.GetString(8), TypeHelper.ToString(rdr.GetDateTime(9)), rdr.GetString(10), TypeHelper.ToString(rdr.GetDateTime(11)), rdr.GetString(12), 
                        TypeHelper.ToString(rdr.GetDateTime(13)));

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