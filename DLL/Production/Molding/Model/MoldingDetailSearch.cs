using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Molding.Model
{
    [Serializable]
    public class MoldingDetailSearch
    {
        ///这个类只是用于成型明细查询页面

        public MoldingDetailSearch() { }

        /// <summary>
        /// 序号
        /// </summary>
        public int ProcessNo { set; get; }

        /// <summary>
        /// 工单
        /// </summary>
        public string OrderNO { set; get; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ProdItemCode { set; get; }

        /// <summary>
        /// Grn编码
        /// </summary>
        public string UseGRN { set; get; }

        /// <summary>
        /// 加工时间
        /// </summary>
        public DateTime CreateTime { set; get; }

        /// <summary>
        /// 班组
        /// </summary>
        public string Group { set; get; }

        /// <summary>
        /// 工位
        /// </summary>
        public string Station { set; get; }

        /// <summary>
        /// 物料编码
        /// </summary>
        public string TargetItemCode { set; get; }

        /// <summary>
        /// 批次号
        /// </summary>
        public string LotCode { set; get; }

        /// <summary>
        /// 加工前物料编码
        /// </summary>
        public string SourceItemCode { set; get; }

        /// <summary>
        /// 合格数量
        /// </summary>
        public decimal UseQty { set; get; }

        /// <summary>
        /// 设备编码
        /// </summary>
        public string EquipmentNo { set; get; }

        /// <summary>
        /// 重量
        /// </summary>
        public decimal Weight { set; get; }

        /// <summary>
        /// 库位
        /// </summary>
        public string Location { set; get; }

        /// <summary>
        /// 描述
        /// </summary>
        public string Remark { set; get; }

        /// <summary>
        /// 操作人
        /// </summary>
        public string CName { set; get; }

        /// <summary>
        /// 烧录类型
        /// </summary>
        public string MoldingType { set; get; }
    }
}
