using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.AccessoryManagement.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.AccessoryManagement.BLL
{
    public class AccessoryChambrierenRecordLogic
    {
        private int recordCount = 0;
        /// <summary>
        /// 分页获取 Accessory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="accessoryCount">accessory 总数。</param>
        /// <returns>Accessory 列表。</returns>
        public List<AccessoryChambrierenRecord> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {

            List<AccessoryChambrierenRecord> list = new List<AccessoryChambrierenRecord>();
            //表名或者视图
            string strTb = "vwAccessoryChambrierenRecord";
            //主键
            string strKey = "ACRId";
            //查询栏位字串
            string strColumns = @"[ACRId]
                                  ,[ACRSerialNumber]
                                  ,[ACRTypeID]
                                  ,[ACRTypeName]
                                  ,[ACRStartTime]
                                  ,[ACRStopTime]
                                  ,[ACRCount]
                                  ,[ACRStatus]
                                  ,[CreateBy]
                                  ,[CreateTime]
                                  ,[ACRRem],[ItemCode],[ItemName]";
            list = ComMethod.GetComList<AccessoryChambrierenRecord>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
