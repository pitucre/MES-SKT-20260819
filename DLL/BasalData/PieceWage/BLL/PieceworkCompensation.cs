using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.PieceWage.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.PieceWage.BLL
{
    public class PieceworkCompensation
    {
        private Int32 recordCount = 0;
       
        /// <summary>
        /// 新增数据
        /// </summary>
        /// <param name="strJson"></param>
        public Int32 Edit(PieceworkCompensationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PieceworkCompensationID", SqlDbType.Int),
                new SqlParameter("@PieceCountingTime", SqlDbType.DateTime),
                new SqlParameter("@UserID", SqlDbType.Int),
                new SqlParameter("@wage", SqlDbType.Decimal),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.PieceworkCompensationID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.PieceCountingTime;
            parms[2].Value = entity.UserID;
            parms[3].Value = entity.Wage;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_PieceworkCompensation_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PieceworkCompensationId 字符串删除 PieceworkCompensation 信息。
        /// </summary>
        /// <param name="idString">PieceworkCompensationId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_PieceworkCompensation_Delete", parms);
        }

        /// <summary>
        /// 根据 PieceworkCompensationId 获取实体信息。
        /// </summary>
        /// <param name="pieceworkCompensationId">PieceworkCompensationId。</param>
        /// <returns>PieceworkCompensation 实体对象。</returns>
        public PieceworkCompensationInfo GetInfo(Int32 pieceworkCompensationId)
        {
            PieceworkCompensationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = pieceworkCompensationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_PieceworkCompensation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PieceworkCompensationInfo(rdr.GetInt32(0), rdr.GetDateTime(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6));
                    entity.Username = rdr.GetString(7);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PieceworkCompensation 实体对象。</returns>
        public PieceworkCompensationInfo GetInfo(String fieldValue)
        {
            PieceworkCompensationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_PieceworkCompensation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PieceworkCompensationInfo(rdr.GetInt32(0), rdr.GetDateTime(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6));
                    entity.Username = rdr.GetString(7);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 PieceworkCompensation 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="pieceworkCompensationCount">pieceworkCompensation 总数。</param>
        /// <returns>PieceworkCompensation 列表。</returns>
        public List<PieceworkCompensationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PieceworkCompensationInfo> list = new List<PieceworkCompensationInfo>();
            PieceworkCompensationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwPieceworkCompensation", "PieceworkCompensationId",
                "[PieceworkCompensationID], [PieceCountingTime], [UserID], [wage], [Remark], [CreateBy], [CreateDateTime],UserName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PieceworkCompensationInfo(rdr.GetInt32(0), rdr.GetDateTime(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6));
                    entity.Username = rdr.GetString(7);

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