using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
   

    /// <summary>
    /// 同步基类
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class BasalSyncInfo<T> where T : class
    {
        ///// <summary>
        ///// 同步编码（Warehouse:仓库信息,Customer:客户信息,Supplier:供应商信息,Department:部门信息,User:用户信息,Item:产品信息,ItemBom:产品Bom信息,ItemBomChild:产品Bom明细信息,SubsItem:替代料信息,Order:工单信息,OrderBom:工单Bom明细信息,PoCode:采购单信息,PoCodeDetail:采购单明细信息,Transfer:调拨单信息,TransferDetail:调拨单明细信息,SaleOrder:销售出库单信息,SaleOrderDetail:销售出库单明细信息,ReturnOrder:退料单信息,ReturnOrderDetail:退料单明细信息,Apply:领料单信息,ApplyDetail:领料单明细信息,CustomerItem:客户产品信息）
        ///// </summary>
        //public string SyncCode { get; set; }

        ///// <summary>
        ///// 操作类型（0：新增 1：修改 2：删除）
        ///// </summary>
        //public OperateType ERPOperateType { get; set; }

        /// <summary>
        /// 立即同步标识（0：异步同步 1：立即同步）
        /// </summary>
        public int SyncNowFlag { get; set; }

        /// <summary>
        /// 数据集合
        /// </summary>
        public List<T> List { get; set; }


        ///// <summary>
        ///// 同步时，不需要传递此参数
        ///// </summary>
        //public List<string> ListBillNo { get; set; }
    }
}