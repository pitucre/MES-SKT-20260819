using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Allowance.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Allowance.BLL
{
    public class Allowance
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Allowance 信息。
        /// </summary>
        /// <param name="entity">Allowance 实体对象。</param>
        public Int32 Edit(int AllowanceId, int txtUserID, string txtwages, string CreateBy, string ModifyBy, string txtRemark, string txtUserName, string txtOutputAllowance)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AllowanceId", SqlDbType.Int),
                new SqlParameter("@UserID", SqlDbType.Int),
                new SqlParameter("@wages", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500),
                new SqlParameter("@UserName", SqlDbType.NVarChar, 50),
                new SqlParameter("@OutputAllowance", SqlDbType.Decimal)
            };

            parms[0].Value = AllowanceId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = txtUserID;
            parms[2].Value = txtwages;
            parms[3].Value = CreateBy;
            parms[4].Value = ModifyBy;
            parms[5].Value = txtRemark;
            parms[6].Value = txtUserName;
            parms[7].Value = txtOutputAllowance;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Allowance_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AllowanceId 字符串删除 Allowance 信息。
        /// </summary>
        /// <param name="idString">AllowanceId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Allowance_Delete", parms);
        }

        /// <summary>
        /// 根据 AllowanceId 获取实体信息。
        /// </summary>
        /// <param name="allowanceId">AllowanceId。</param>
        /// <returns>Allowance 实体对象。</returns>
        public AllowanceInfo GetInfo(Int32 allowanceId)
        {
            AllowanceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = allowanceId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Allowance_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AllowanceInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDecimal(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    entity.UserName = Convert.ToString(rdr.GetString(8));
                    entity.OutputAllowance = Convert.ToDecimal(rdr[9]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Allowance 实体对象。</returns>
        public AllowanceInfo GetInfo(String fieldValue)
        {
            AllowanceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Allowance_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AllowanceInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDecimal(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    entity.UserName = Convert.ToString(rdr.GetString(8));
                    entity.OutputAllowance = Convert.ToDecimal(rdr[9]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Allowance 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="allowanceCount">allowance 总数。</param>
        /// <returns>Allowance 列表。</returns>
        public List<AllowanceInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AllowanceInfo> list = new List<AllowanceInfo>();
            AllowanceInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwAllowance", "AllowanceId",
                "[AllowanceId], [UserID], [wages], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],UserName,OutputAllowance", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AllowanceInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDecimal(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    entity.UserName = Convert.ToString(rdr[8]);
                    entity.OutputAllowance = Convert.ToDecimal(rdr[9]);
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

        /// <summary>
        /// 导入津贴信息
        /// </summary>
        /// <param name="dtFiboCom"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public int Import(DataTable dtAllowance, string userName)
        {
            int count = 0;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@dtAllowance", SqlDbType.Structured),
                 new SqlParameter("@userName", SqlDbType.NVarChar,50)
            };
            parms[0].Value = dtAllowance;
            parms[1].Value = userName;
            count = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAllowance_Import", parms);
            return count;
        }
    }
}