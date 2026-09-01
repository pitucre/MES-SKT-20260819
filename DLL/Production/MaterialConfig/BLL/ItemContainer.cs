using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaterialConfig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.MaterialConfig.BLL
{
    public class ItemContainer
    {
        private Int32 recordCount = 0;
       
        /// <summary>
        /// 分页获取 MaterialSysConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialSysConfigCount">materialSysConfig 总数。</param>
        /// <returns>MaterialSysConfig 列表。</returns>
        public List<ItemContainerInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemContainerInfo> list = new List<ItemContainerInfo>();
            //表名或者视图
            string strTb = "vwItemContainList";
            //主键
            string strKey = "ContainerId";

            sortExpression = "CreateDateTime";
            //查询栏位字串
            string strColumns = @" ContainerId, ItemCode, ItemName, Remark, CreateBy, CreateDateTime, UpdateBy, UpdateDateTime ";
            list = ComMethod.GetComList<ItemContainerInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}