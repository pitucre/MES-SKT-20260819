using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ERP
{
    /// <summary>
    /// 回写枚举
    /// </summary>
    public enum WriteBackEnum
    {
        /// <summary>
        /// 仓库收料
        /// </summary>
        WarehouseReceipt,

        /// <summary>
        /// 成品入库
        /// </summary>
        FinishStorage,

        /// <summary>
        /// 物料入库
        /// </summary>
        MaterialStorage,

        /// <summary>
        /// IQC退料
        /// </summary>
        IQCReturn,

        /// <summary>
        /// 调拨入库
        /// </summary>
        TransferStorage,

        /// <summary>
        /// 寄售调拨
        /// </summary>
        TransferConsignSale,

        ///// <summary>
        ///// 生产领料
        ///// </summary>
        //ProductApply,

        ///// <summary>
        ///// 物料调拨
        ///// </summary>
        //MaterialTransfer,

        ///// <summary>
        ///// 成品调拨
        ///// </summary>
        //FinishTransfer,

        /// <summary>
        /// 仓库备料
        /// </summary>
        MaterialPrepare,

        /// <summary>
        /// 其它入库、受托加工入库
        /// </summary>
        OtherStorage,

        /// <summary>
        /// 杂收入库
        /// </summary>
        MaterialMixStorage,

        /// <summary>
        /// 仓库退供应商
        /// </summary>
        WarehouseReturnSupplier,

        /// <summary>
        /// 生产退料
        /// </summary>
        ProductReturn,

        /// <summary>
        /// 销售出库
        /// </summary>
        SaleExWarehouse,

        ///// <summary>
        ///// 产成品领料出库
        ///// </summary>
        //FinishApply

        /// <summary>
        /// 杂发单入库审核
        /// </summary>
        MiscellaneousOutStorage,

        /// <summary>
        /// 杂收单入库审核
        /// </summary>
        MiscellaneousInStorage,

        /// <summary>
        /// 形态转换单
        /// </summary>
        FormChangeCheck,
        /// <summary>
        /// 成品退货审核
        /// </summary>
        FinishedProductReturnReview,

        /// <summary>
        /// 盘点单
        /// </summary>
        InventoryList,

        /// <summary>
        /// 其它入库
        /// </summary>
        OtherWarehousing,

        /// <summary>
        /// 报废出库
        /// </summary>
        ScrapStorage
    }

    /// <summary>
    /// 回写结果枚举
    /// </summary>
    public enum ERPResultEnum
    {

        /// <summary>
        /// 不进行回写
        /// </summary>
        NoWrite = -1,

        /// <summary>
        /// 回写失败
        /// </summary>
        NG = 0,

        /// <summary>
        /// 回写成功
        /// </summary>
        OK = 1,
    }
}
