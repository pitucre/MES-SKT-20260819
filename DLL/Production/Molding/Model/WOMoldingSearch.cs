using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Molding.Model
{
    [Serializable]
    public class WOMoldingSearch
    {
        ///这个类只是用于成型工单查询页面

        public WOMoldingSearch() { }

        /// <summary>
        /// 序号
        /// </summary>
        public Int64 RowIndex { set; get; }


        /// <summary>
        /// 工单
        /// </summary>
        public string OrderNO { set; get; }

        /// <summary>
        /// 原物料编码
        /// </summary>
        public string SourceItemCode { set; get; }

        /// <summary>
        /// 工位
        /// </summary>
        public string Station { set; get; }


        /// <summary>
        /// 加工后物料编码
        /// </summary>
        public string TargetItemCode { set; get; }

        /// <summary>
        /// 物料规格
        /// </summary>
        public string TargetItemSpec { set; get; }

        /// <summary>
        /// 物料名称
        /// </summary>
        public string TargetItemName { set; get; }


        /// <summary>
        /// 
        /// </summary>
        public decimal Usage { set; get; }

        /// <summary>
        /// 工单数量
        /// </summary>
        public int Qty_to_Build { set; get; }

        /// <summary>
        /// 应加工数量
        /// </summary>
        public decimal MustWorkQty { set; get; }

        /// <summary>
        /// 已生产数量
        /// </summary>
        public decimal AlreadyQty { set; get; }


        /// <summary>
        /// 未加工数量
        /// </summary>
        public decimal NeedWorkQty { set; get; }
    }
}
