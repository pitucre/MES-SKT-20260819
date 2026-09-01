using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.MaterialDelivery.Model;

namespace SKT.LeanMES.MaterialDelivery.BLL
{
    public class EdgeLine
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EdgeLine 信息。
        /// </summary>
        /// <param name="entity">EdgeLine 实体对象。</param>
        public Int32 Edit(EdgeLineInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EdgeId", SqlDbType.Int),
                new SqlParameter("@EdgeName", SqlDbType.NVarChar, 50),
                new SqlParameter("@LineIdStr", SqlDbType.NVarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200)
            };

            parms[0].Value = entity.EdgeId;
            parms[1].Value = entity.EdgeName;
            parms[2].Value = entity.LineIdStr;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_EdgeLine_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 EdgeLineId 字符串删除 EdgeLine 信息。
        /// </summary>
        /// <param name="idString">EdgeLineId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_EdgeLine_Delete", parms);
        }

        /// <summary>
        /// 根据 EdgeLineId 获取实体信息。
        /// </summary>
        /// <param name="edgeLineId">EdgeLineId。</param>
        /// <returns>EdgeLine 实体对象。</returns>
        public EdgeLineInfo GetInfo(Int32 edgeLineId)
        {
            EdgeLineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = edgeLineId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_EdgeLine_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EdgeLineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2),rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EdgeLine 实体对象。</returns>
        public EdgeLineInfo GetInfo(String fieldValue)
        {
            EdgeLineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_EdgeLine_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EdgeLineInfo(rdr.GetInt32(0), rdr.GetString(1),rdr.GetString(2),rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EdgeLine 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="edgeLineCount">edgeLine 总数。</param>
        /// <returns>EdgeLine 列表。</returns>
        public List<EdgeLineInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EdgeLineInfo> list = new List<EdgeLineInfo>();
            EdgeLineInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_EdgeLine", "EdgeId",
                "[EdgeId], [EdgeName],[LineIdStr],[CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EdgeLineInfo(rdr.GetInt32(0), rdr.GetString(1),rdr.GetString(2),rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取线边仓现存量
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<EdgeLineInfo> GetLineEdgeList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EdgeLineInfo> list = new List<EdgeLineInfo>();
            EdgeLineInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetLineEdgeList", "EdgeId",
                "[EdgeId], [EdgeName],[LineIdStr],[CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[SerialNumber],[BalanceQty]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EdgeLineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    entity.SerialNumber = rdr.GetString(8);
                    entity.BalanceQty = rdr.GetDecimal(9);
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