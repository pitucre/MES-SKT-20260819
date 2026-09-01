using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Warehouse.Model
{
    /// <summary>
    /// 销售备货明细
    /// </summary>
    public class WarehouseCpOutStockDtlInfo: WarehouseCpOutStockDtlMemberInfo
    {
        /// <summary>
        /// 标示
        /// </summary>
        public int SalOrderDtlID { get; set; }
        /// <summary>
        /// 关联主表标示
        /// </summary>
        public int SalOrderID { get; set; }
        /// <summary>
        /// 销售订单号
        /// </summary>
        public string SalOrderNo { get; set; }
        /// <summary>
        /// 物料编码
        /// </summary>
        public string ItemCode { get; set; }
        /// <summary>
        /// 物料id
        /// </summary>
        public int ItemID { get; set; }
        /// <summary>
        /// 物料名称
        /// </summary>
        public string ItemName { get; set; }
        /// <summary>
        /// 计划出货量
        /// </summary>
        public decimal PlanQty { get; set; }
        /// <summary>
        /// 扫描备货量
        /// </summary>
        public decimal CurrentQty { get; set; }
        /// <summary>
        /// 车牌号
        /// </summary>
        public string CarNo { get; set; }
        /// <summary>
        /// 货柜号
        /// </summary>
        public string ContainerNo { get; set; }
        /// <summary>
        /// 封号
        /// </summary>
        public string SealNo { get; set; }
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
        public string CustomerOrder { get; set; }
        public string SalorderItem { get; set; }
        /// <summary>
        /// 仓库
        /// </summary>
        public string CWhName { get; set; }
        /// <summary>
        /// 仓库编码
        /// </summary>
        public string WhCode { get; set; }

        /// <summary>
        /// 客户料号
        /// </summary>
        public string CPN { get; set; }
    }
    /// <summary>
    /// 扫描明细
    /// </summary>
    public class WarehouseCpOutStockDtlMemberInfo
    {
        /// <summary>
        /// 标示
        /// </summary>
        public int ID { get; set; }
        /// <summary>
        /// 关联备货单表详情表
        /// </summary>
        public int SalOrderDtlID { get; set; }
        /// <summary>
        /// 条码类型-1 GRN, 0 SN,1 卡通箱,2 栈板
        /// </summary>
        public int ScanType { get; set; }
        /// <summary>
        /// 条码
        /// </summary>
        public string Number { get; set; }
        /// <summary>
        /// 数量
        /// </summary>
        public decimal Qty { get; set; }
        /// <summary>
        /// 扫描人
        /// </summary>
        public string CreateBy { get; set; }
        /// <summary>
        /// 扫描时间
        /// </summary>
        public DateTime CreateDateTime { get; set; }
        /// <summary>
        /// 卡通箱号
        /// </summary>
        public string CartonCode { get; set; }
        /// <summary>
        /// SN、GRN
        /// </summary>
        public string Code { get; set; }
    }
    /// <summary>
    /// 出货明细
    /// </summary>
    public class WarehouseCpOutStockDtlMemberInfoOutput
    {
        /// <summary>
        /// 备货单号
        /// </summary>
        public string DNCode { get; set; }
        /// <summary>
        /// 栈板号码
        /// </summary>
        public string PalletNo { get; set; }
        /// <summary>
        /// 客户条码
        /// </summary>
        public string CustomerSN { get; set; }
        /// <summary>
        /// 批次号
        /// </summary>
        public string QcLotNo { get; set; }

        
        /// <summary>
        /// 数量
        /// </summary>
        public int Qty { get; set; }
        /// <summary>
        /// 扫描人
        /// </summary>
        public string CreateBy { get; set; }
        /// <summary>
        /// 扫描时间
        /// </summary>
        public DateTime CreateDateTime { get; set; }
        /// <summary>
        /// 卡通箱号
        /// </summary>
        public string CartonNo { get; set; }
        /// <summary>
        /// SN、GRN
        /// </summary>
        public string SerialNumber { get; set; }
    }

    /// <summary>
    /// 可用GRN信息
    /// </summary>
    public class WarehouseGrnMember
    {
        /// <summary>
        /// GRN
        /// </summary>
        public string GRN { get; set; }

        /// <summary>
        /// 生产日期
        /// </summary>
        public string ProudctData { get; set;}

        /// <summary>
        /// 货位
        /// </summary>
        public string CBarCode { get; set; }

        /// <summary>
        /// 数量
        /// </summary>
        public decimal Qty { get; set;}
    }
}
