using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class PreAssemblyContainer
    {
        private Int32 recordCount = 0;
       

        /// <summary>
        /// 分页获取 PreAssemblyContainer 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="preAssemblyContainerCount">preAssemblyContainer 总数。</param>
        /// <returns>PreAssemblyContainer 列表。</returns>
        public List<PreAssemblyContainerInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PreAssemblyContainerInfo> list = new List<PreAssemblyContainerInfo>();
            PreAssemblyContainerInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_PreAssemblyContainer", "ID",
                "[ID], [ContainerNO], [ModelNO], [OrderNO], [PartNO], [LotNO], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PreAssemblyContainerInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetInt32(7));

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