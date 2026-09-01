using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Manufacture.Model
{
    public class PDAWarehouseInfo
    {
        /// <summary>
        /// 入库
        /// </summary>
        public WarehouseStorageInfo storageInfo { get; set; }
        /// <summary>
        /// 出货
        /// </summary>
        public WarehouseOutStockInfo outStockInfo { get; set; }
        /// <summary>
        /// 产品基础信息
        /// </summary>
        public VUnitHistoryInfo productInfo { get; set; }


    }

    /// <summary>
    /// 出货信息
    /// </summary>
    public class WarehouseOutStockInfo
    {
        /// <summary>
        /// 出货单号
        /// </summary>
        public string DNCode { get; set; }
        /// <summary>
        /// 出货人
        /// </summary>
        public string CName { get; set; }
        /// <summary>
        /// 出货时间
        /// </summary>
        public DateTime FinishDateTime { get; set; }
    }
    /// <summary>
    /// 成品入库信息
    /// </summary>
    public class WarehouseStorageInfo
    {
        /// <summary>
        /// 工单号
        /// </summary>
        public string WorkOrderNo { get; set; }
        /// <summary>
        /// 入库单号
        /// </summary>
        public string InStockNo { get; set; }
        /// <summary>
        /// 物料编码
        /// </summary>
        public string ItemCode { get; set; }
        /// <summary>
        /// 物料名称
        /// </summary>
        public string ItemName { get; set; }
        /// <summary>
        /// 仓库编码
        /// </summary>
        public string CWhCode { get; set; }
        /// <summary>
        /// 仓库名称
        /// </summary>
        public string CWhName { get; set; }
        /// <summary>
        /// 入库人
        /// </summary>
        public string CreateBy { get; set; }
        /// <summary>
        /// 入库时间
        /// </summary>
        public DateTime CreateDateTime { get; set; }
        /// <summary>
        /// 规格
        /// </summary>
        public string ItemModel { get; set; }
        /// <summary>
        /// 库位条码
        /// </summary>
        public string BarCode { get; set; }
        /// <summary>
        /// 客户编码
        /// </summary>
        public string CustomerSN { get; set; }
    }
    public class StockInfo
    {
        public class WarehouseCpOutStockInfo
        {
            /// <summary>
            /// 标示
            /// </summary>
            public int SalOrderID { get; set; }
            /// <summary>
            /// 销售单号
            /// </summary>
            public string DNCode { get; set; }
            /// <summary>
            /// 销售日期
            /// </summary>
            public DateTime SalOrderDate { get; set; }
            /// <summary>
            /// 客户编码
            /// </summary>
            /// <returns></returns>
            public string CusCode { get; set; }
            /// <summary>
            /// 客户名称
            /// </summary>
            /// <returns></returns>
            public string CusName { get; set; }
            /// <summary>
            /// 地址
            /// </summary>
            /// <returns></returns>
            public string Address { get; set; }
            /// <summary>
            /// --状态 ０末备货１备货中２备货完成３已检验４已出货５取消
            /// </summary>
            public int Status { get; set; }
            /// <summary>
            /// --创建人（备货人）
            /// </summary>
            public string CreateBy { get; set; }
            /// <summary>
            /// --创建时间
            /// </summary>
            public DateTime CreateDateTime { get; set; }
            /// <summary>
            /// 确认人
            /// </summary>
            /// <returns></returns>
            public string ModifyBy { get; set; }
            /// <summary>
            /// 确认时间
            /// </summary>
            /// <returns></returns>
            public DateTime ModifyDateTime { get; set; }
            /// <summary>
            /// 完成人（出货人）
            /// </summary>
            /// <returns></returns>
            public string FinishBy { get; set; }
            /// <summary>
            /// 确认人
            /// </完成时间>
            /// <returns></returns>
            public DateTime FinishDateTime { get; set; }
            /// <summary>
            /// 回传ERP状态
            /// </summary>
            public int BackERPStatus { get; set; }
            /// <summary>
            /// 回传ERP时间
            /// </summary>
            public DateTime BackERPDateTime { get; set; }
        }
        public class WarehouseCpOutStockDtlInfo : WarehouseCpOutStockDtlMemberInfo
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
    }
}
