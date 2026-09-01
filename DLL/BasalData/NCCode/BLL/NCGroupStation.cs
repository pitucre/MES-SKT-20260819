using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.NCCode.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.NCCode.BLL
{
    public class NCGroupStation
    {
        private Int32 recordCount = 0; 
        
        /// <summary>
        /// 分页获取 NCGroupStation 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="nCGroupStationCount">nCGroupStation 总数。</param>
        /// <returns>NCGroupStation 列表。</returns>
        public List<NCGroupStationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<NCGroupStationInfo> list = new List<NCGroupStationInfo>();
            NCGroupStationInfo entity = null;
        
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwNCGroupStationInfo", "NCGroupStationId",
               "[NCGroupStationId], [StationId],[NCGroupId],[NCGroupName],[StationName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new NCGroupStationInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2));
                    entity.GroupName = rdr.GetString(3);
                    entity.StationName = rdr.GetString(4);
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