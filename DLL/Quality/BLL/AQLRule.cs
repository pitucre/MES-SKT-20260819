using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
//using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Quality.BLL
{
    public class AQLRule
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AQLRule 信息。
        /// </summary>
        /// <param name="entity">AQLRule 实体对象。</param>
        public Int32 Edit(AQLRuleInfo entity, List<AQLRuleMemberInfo> list)
        {


            DataTable table = new DataTable();
            DataColumn dtc = new DataColumn("ALQRuleMemberId", typeof(int));
            table.Columns.Add(dtc);
            dtc = new DataColumn("LotLetter", typeof(string)); ;
            table.Columns.Add(dtc);
            dtc = new DataColumn("SamplingValue", typeof(string));
            table.Columns.Add(dtc);
            dtc = new DataColumn("ACValue", typeof(string));
            table.Columns.Add(dtc);
            dtc = new DataColumn("REValue", typeof(string));
            table.Columns.Add(dtc);



            for (int i = 0; i < list.Count; i++)
            {
                DataRow row = table.NewRow();
                row["ALQRuleMemberId"] = list[i].AQLRuleMemberId;
                row["LotLetter"] = list[i].LotLetter;
                row["SamplingValue"] = list[i].SamplingValue;
                row["ACValue"] = list[i].ACValue;
                row["REValue"] = list[i].REValue;
                table.Rows.Add(row);

            }




            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AQLRuleId", SqlDbType.Int),
                new SqlParameter("@AQLRuleTypeId", SqlDbType.Int),
                new SqlParameter("@RuleName", SqlDbType.NVarChar, 50),
                new SqlParameter("@RuleDescription", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreaterBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@DataTable", SqlDbType.Structured)
            };

            parms[0].Value = entity.AQLRuleId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AQLRuleTypeId;
            parms[2].Value = entity.RuleName;
            parms[3].Value = entity.RuleDescription;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.CreaterBy;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = table;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_AQLRule_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AQLRuleId 字符串删除 AQLRule 信息。
        /// </summary>
        /// <param name="idString">AQLRuleId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_AQLRule_Delete", parms);
        }

        /// <summary>
        /// 根据 AQLRuleId 获取实体信息。
        /// </summary>
        /// <param name="aQLRuleId">AQLRuleId。</param>
        /// <returns>AQLRule 实体对象。</returns>
        public AQLRuleInfo GetInfo(Int32 aQLRuleId)
        {
            AQLRuleInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = aQLRuleId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_AQLRule_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AQLRuleInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AQLRule 实体对象。</returns>
        public AQLRuleInfo GetInfo(String fieldValue)
        {
            AQLRuleInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_AQLRule_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AQLRuleInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AQLRule 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="aQLRuleCount">aQLRule 总数。</param>
        /// <returns>AQLRule 列表。</returns>
        public List<AQLRuleInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = "AQLRuleId,AQLRuleTypeId,RuleName,RuleDescription,Remark,CreaterBy,CreateDate,ModifyBy,ModifyDate,AQLRuleTypeName";
            return ComMethod.GetComList<AQLRuleInfo>(ref this.recordCount, startRow, maxRows, "vwGetAQLRule", string.Empty, columns, sortExpression, searchSettings);
           /* List<AQLRuleInfo> list = new List<AQLRuleInfo>();
            AQLRuleInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, @"Quality_AQLRule a INNER JOIN dbo.Quality_AQLRuleType b ON a.AQLRuleTypeId = b.AQLRuleTypeId LEFT JOIN SYS_Users m1 ( NOLOCK ) ON RTRIM(LTRIM(a.CreaterBy)) = m1.UserName
            LEFT JOIN SYS_Users m2(NOLOCK) ON RTRIM(LTRIM(a.ModifyBy)) = m2.UserName", "AQLRuleId",
                "[AQLRuleId], a.[AQLRuleTypeId], [RuleName], [RuleDescription], a.[Remark],ISNULL(m1.CName, '') AS [CreaterBy], a.[CreateDate], ISNULL(m2.CName, '') AS [ModifyBy], a.[ModifyDate],AQLRuleTypeName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AQLRuleInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8));
                    entity.AQLRuleTypeName = rdr.GetString(9);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;*/
        }

        /// <summary>
        /// 获取检验水平列表
        /// </summary>
        /// <returns></returns>
        public List<AQLLotSizeInfo> GetAQLLotSizeList()
        {
           return CommonHelper.BLL.ComMethod.GetListBySql<AQLLotSizeInfo>("select * from vwGetLotSizeList", null);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}