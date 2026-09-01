using System;
using System.Collections.Generic;
using System.Text;
using SKT.LeanMES.Quality.Model;
using SKT.Common.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Quality.BLL
{
    public class AQLRuleMember
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 AQLRuleMember 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="aQLRuleMemberCount">aQLRuleMember 总数。</param>
        /// <returns>AQLRuleMember 列表。</returns>
        public List<AQLRuleMemberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AQLRuleMemberInfo> list = new List<AQLRuleMemberInfo>();
            AQLRuleMemberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Quality_AQLRuleMember", "AQLRuleMemberId",
                "[AQLRuleMemberId], [AQLRuleId], [SamplingValue],  [ACValue], [REValue], [CreaterBy], [CreateDate], [ModifyBy], [ModifyDate],[LotLetter]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AQLRuleMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8));
                    entity.LotLetter = rdr.GetString(9);
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