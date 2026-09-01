using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.Enum
{

    public enum ApiEnum
    {
        /// <summary>
        /// 仓库信息
        /// </summary>
        Warehouse,

        /// <summary>
        /// 库位信息
        /// </summary>
        WarehouseLocation,


        /// <summary>
        /// 客户信息
        /// </summary>
        Customer,

        /// <summary>
        /// 供应商信息
        /// </summary>
        Supplier,

        /// <summary>
        /// 部门信息
        /// </summary>
        Department,

        /// <summary>
        /// 用户信息
        /// </summary>
        User,

        /// <summary>
        /// 物料分类信息
        /// </summary>
        ItemCategory,

        /// <summary>
        /// 产品信息
        /// </summary>
        Item,

        /// <summary>
        /// 产品Bom信息
        /// </summary>
        ItemBom,

        /// <summary>
        /// 产品Bom明细信息
        /// </summary>
        ItemBomChild,

        /// <summary>
        /// 替代料信息
        /// </summary>
        SubsItem,

        /// <summary>
        /// 工单信息
        /// </summary>
        Order,

        /// <summary>
        /// 工单Bom明细信息
        /// </summary>
        OrderBom,

        /// <summary>
        /// 采购单信息
        /// </summary>
        PoCode,

        /// <summary>
        /// 采购单明细信息
        /// </summary>
        PoCodeDetail,

        /// <summary>
        /// 送货单信息
        /// </summary>
        Deliver,

        /// <summary>
        /// 送货单明细信息
        /// </summary>
        DeliverDetail,

        /// <summary>
        /// 调拨单信息
        /// </summary>
        Transfer,

        /// <summary>
        /// 调拨单明细信息
        /// </summary>
        TransferDetail,

        /// <summary>
        /// 销售出库单信息
        /// </summary>
        SaleOrder,

        /// <summary>
        /// 销售出库单明细信息
        /// </summary>
        SaleOrderDetail,

        /// <summary>
        /// 退料单信息
        /// </summary>
        ReturnOrder,

        /// <summary>
        /// 退料单明细信息
        /// </summary>
        ReturnOrderDetail,

        /// <summary>
        /// 领料单信息
        /// </summary>
        Apply,

        /// <summary>
        /// 领料单明细信息
        /// </summary>
        ApplyDetail,

        /// <summary>
        /// 生产退料单信息
        /// </summary>
        ReturnToWarehouse,

        /// <summary>
        /// 销售退货单信息
        /// </summary>
        SaleReturn,

        /// <summary>
        /// 销售退货单明细信息
        /// </summary>
        SaleReturnDetail,

        /// <summary>
        /// 设备信息
        /// </summary>
        Equipment,

        /// <summary>
        /// 工厂信息
        /// </summary>
        Factory,
        /// <summary>
        /// GRN信息
        /// </summary>
        GRN,

        /// <summary>
        /// 报废单
        /// </summary>
        Scrap,

        /// <summary>
        /// 报废单明细信息
        /// </summary>
        ScrapDetail,

        /// <summary>
        /// 形态转换单信息
        /// </summary>
        FormChange,
        /// <summary>
        /// 形态转换单明细信息
        /// </summary>
        FormChangeDtl,
        /// <summary>
        /// 形态转换单明细信息(转换后)
        /// </summary>
        FormChangeDtled
    }
}