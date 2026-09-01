using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Resource.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Resource.BLL
{
    public class ResourceCapacityManage
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 ResourceCapacityManage 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="resourceCount">resource 总数。</param>
        /// <returns>Resource 列表。</returns>
        public List<ResourceCapacityManageInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ResourceCapacityManageInfo> list = new List<ResourceCapacityManageInfo>();
            ResourceCapacityManageInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwResourceCapacityList", "ItemID",
                @"ItemID,ItemCode,ItemName,LineName,Face,Capacity,ResName,ShiftName,CapacityTimeUnit,CapacityCount,RestTimes,WorkTimes", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ResourceCapacityManageInfo();
                    entity.ItemId = Convert.ToInt32(rdr["ItemID"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.LineName = Convert.ToString(rdr["LineName"]);
                    entity.Face = Convert.ToString(rdr["Face"]);
                    entity.Capacity = Convert.ToInt32(rdr["Capacity"]);
                    entity.ResName = Convert.ToString(rdr["ResName"]);


                    entity.ShiftName = Convert.ToString(rdr["ShiftName"]);
                    entity.CapacityTimeUnit = Convert.ToString(rdr["CapacityTimeUnit"]);
                    entity.CapacityCount = Convert.ToInt32(rdr["CapacityCount"]);
                    entity.RestTimes = float.Parse(rdr["RestTimes"].ToString());
                    entity.WorkTimes = float.Parse(rdr["WorkTimes"].ToString());

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