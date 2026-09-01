using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.MSD.Model;

namespace SKT.LeanMES.MSD.BLL
{
   public class MsdOperation
    {

        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取MSD 物料信息资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>Item 列表。</returns>
        public List<MsdOperationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MsdOperationInfo> list = new List<MsdOperationInfo>();
            MsdOperationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vWGetMsdOperationInfo", "Oid",
                @"Oid ,
            SerialNumber ,
            ItemCode ,
            ItemName ,
            ItemSpec,
            ContainerCode ,
            ContainerName ,
            OperateDes,
            OperateTime,
            Remark ,
            OperateUser"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MsdOperationInfo();
                    entity.Oid = Convert.ToInt32(rdr["Oid"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemSpec = Convert.ToString(rdr["ItemSpec"]);
                    entity.SerialNumber = Convert.ToString(rdr["SerialNumber"]); 
                    entity.OperateTime = Convert.ToDateTime(rdr["OperateTime"]);
                    entity.ContainerCode = Convert.ToString(rdr["ContainerCode"]);
                    entity.ContainerName = Convert.ToString(rdr["ContainerName"]);
                    entity.OperateUser = Convert.ToString(rdr["OperateUser"]);
                    entity.OperateDes = Convert.ToString(rdr["OperateDes"]);
                    entity.OperateUser = Convert.ToString(rdr["OperateUser"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
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
