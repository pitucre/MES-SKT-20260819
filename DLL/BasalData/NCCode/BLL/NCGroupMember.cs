using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.NCCode.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.NCCode.Model
{
    public class NCGroupMember
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 分页获取 NCGroupMember 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="nCGroupMemberCount">nCGroupMember 总数。</param>
        /// <returns>NCGroupMember 列表。</returns>
        public List<NCGroupMemberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<NCGroupMemberInfo> list = new List<NCGroupMemberInfo>();
            NCGroupMemberInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwNCGroupMemberInfo", "NCGroupMemberId",
              "[NCGroupMemberId],[NCGroupId],[NCCodeId],[NCCode],[NCGroupName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new NCGroupMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2));
                    entity.NCCode = rdr.GetString(3);
                    entity.GroupName = rdr.GetString(4);
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