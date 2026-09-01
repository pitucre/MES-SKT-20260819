using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//
using SKT.LeanMES.PackPrint.Model;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.PackPrint.BLL
{
    public class ShipmentListPartName
    {
        private Int32 recordCount = 0;  
        /// <summary>
        /// 分页获取NC_Phenomen资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="cODECount">cODE 总数。</param>
        /// <returns>NC_Phenomen 列表。</returns>
        public List<ShipmentListPartNameInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShipmentListPartNameInfo> list = new List<ShipmentListPartNameInfo>();
            ShipmentListPartNameInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_ShipmentListPartName", "PartNameId",
                "partNameId, partName, partSeq, remark, ModifyDateTime,modifyby, createDateTime, createBy", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {                   
                    entity = new ShipmentListPartNameInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        //取总记录数，不能删除
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}