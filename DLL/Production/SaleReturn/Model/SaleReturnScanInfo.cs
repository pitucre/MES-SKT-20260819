using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SaleReturn.Model
{
    /// <summary>
    /// 成品退货扫描条码信息表（扫描什么保存什么，扫描的SN保存在Prod_SaleReturnSN表）
    /// </summary>
    [Serializable]
    public class SaleReturnScanInfo
    {
        /// <summary>
        /// 成品退货扫描条码信息表Id
        /// </summary>
        public int SaleReturnScanId { get; set; }

        /// <summary>
        /// 销退单号
        /// </summary>
        public string SaleReturnNo { get; set; }

        /// <summary>
        /// 销退单行号
        /// </summary>
        public int? SaleReturnRowId { get; set; }

        /// <summary>
        /// 条码类型（0 SN，3 客户SN，1 卡通箱，2 栈板 ，-1 GRN）
        /// </summary>
        public int? ScanType { get; set; }

        /// <summary>
        /// 条码
        /// </summary>
        public string BarCode { get; set; }

        /// <summary>
        /// 数量
        /// </summary>
        public decimal? Qty { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }


        /// <summary>
        /// 销退单行号
        /// </summary>
        public string SaleReturnRowName { get; set; }

        /// <summary>
        /// 条码类型（0 SN，3 客户SN，1 卡通箱，2 栈板 ，-1 GRN）
        /// </summary>
        public string ScanTypeName { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// 产品规格
        /// </summary>
        public string ItemSpec { get; set; }
        
        /// <summary>
        /// 库位条码
        /// </summary>
        public string CBarCode { get; set; }
    }
}
