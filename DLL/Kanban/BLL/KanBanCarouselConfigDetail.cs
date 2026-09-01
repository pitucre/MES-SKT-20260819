using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Kanban.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.BLL
{
    public class KanBanCarouselConfigDetail
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 KanBanCarouselConfigDetailInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialIQCCount">总数。</param>
        /// <returns>KanBanCarouselConfigDetailInfo 列表。</returns>
        public List<KanBanCarouselConfigDetailInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "dbo.KanBan_CarouselConfigDetail kcd INNER JOIN dbo.KanBan_CarouselConfig kcc ON kcc.CarouselConfigId = kcd.CarouselConfigId";
            //主键
            string strKey = "Sequence";
            //查询栏位字串
            string strColumns = @"kcd.CarouselConfigDetailId,kcd.CarouselConfigId,kcd.KanBanName,kcd.KanBanURL,kcd.Sequence,kcd.Remark,kcd.CreateBy,kcd.CreateDateTime,kcd.ModifyBy,kcd.ModifyDateTime,
                                  kcc.CarouselTime";
            var list = ComMethod.GetComList<KanBanCarouselConfigDetailInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
