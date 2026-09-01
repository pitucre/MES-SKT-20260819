using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Resource.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Resource.BLL
{
    public class LineSet
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LineSet 信息。
        /// </summary>
        /// <param name="entity">LineSet 实体对象。</param>
        public Int32 Edit(LineSetInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineSetId", SqlDbType.Int),
                new SqlParameter("@LineSetDate", SqlDbType.Date),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ShiftId", SqlDbType.Int),
                new SqlParameter("@Principal", SqlDbType.Int),
                new SqlParameter("@StandardHuman", SqlDbType.Decimal),
                new SqlParameter("@ActualHuman", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Seccipal", SqlDbType.Int)
            };

            parms[0].Value = entity.LineSetId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.LineSetDate;
            parms[2].Value = entity.LineId;
            parms[3].Value = entity.ShiftId;
            parms[4].Value = entity.Principal;
            parms[5].Value = entity.StandardHuman;
            parms[6].Value = entity.ActualHuman;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.ModifyBy;
            parms[9].Value = entity.Seccipal;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LineSet_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LineSetId 字符串删除 LineSet 信息。
        /// </summary>
        /// <param name="idString">LineSetId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LineSet_Delete", parms);
        }

        /// <summary>
        /// 根据 LineSetId 获取实体信息。
        /// </summary>
        /// <param name="lineSetId">LineSetId。</param>
        /// <returns>LineSet 实体对象。</returns>
        public LineSetInfo GetInfo(Int32 lineSetId)
        {
            LineSetInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lineSetId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LineSet_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LineSetInfo(rdr.GetInt32(0), rdr.GetDateTime(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9),
                        rdr.GetDateTime(10));
                    entity.LineName = rdr.GetString(11);
                    entity.CName = rdr.GetString(12);
                    entity.ShiftName = rdr.GetString(13);
                    entity.Seccipal = rdr.GetInt32(14);
                    entity.CSecName = rdr.GetString(15);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LineSet 实体对象。</returns>
        public LineSetInfo GetInfo(String fieldValue)
        {
            LineSetInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LineSet_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LineSetInfo(rdr.GetInt32(0), rdr.GetDateTime(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9),
                        rdr.GetDateTime(10));
                    entity.LineName = rdr.GetString(11);
                    entity.CName = rdr.GetString(12);
                    entity.ShiftName = rdr.GetString(13);
                    entity.Seccipal = rdr.GetInt32(14);
                    entity.CSecName = rdr.GetString(15);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 LineSet 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lineSetCount">lineSet 总数。</param>
        /// <returns>LineSet 列表。</returns>
        public List<LineSetInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LineSetInfo> list = new List<LineSetInfo>();
            LineSetInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetLineSetList", "LineSetId",
                "[LineSetId], [LineSetDate], [LineId], [ShiftId], [Principal], [StandardHuman], [ActualHuman], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],LineName,CName,ShiftName,Seccipal,CSecName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LineSetInfo(rdr.GetInt32(0), rdr.GetDateTime(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9),
                        rdr.GetDateTime(10));
                    entity.LineName = rdr.GetString(11);
                    entity.CName = rdr.GetString(12);
                    entity.ShiftName = rdr.GetString(13);
                    entity.Seccipal = rdr.GetInt32(14);
                    entity.CSecName = rdr.GetString(15);
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
