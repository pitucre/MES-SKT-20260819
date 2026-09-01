using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 备货明细信息表（产品）
    /// </summary>
    public class ERPProdSalOrderDtlInfo
    {
        ///// <summary>
        ///// 备货明细信息表（产品）Id
        ///// </summary>
        //public int SalOrderDtlID { get; set; }

        ///// <summary>
        ///// 备货单Id（关联Prod_SalOrder表SalOrderID）
        ///// </summary>
        //public int SalOrderID { get; set; }

        /// <summary>
        /// 销售单号
        /// </summary>
        public string SalOrderNo { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

        ///// <summary>
        ///// 产品Id
        ///// </summary>
        //public int ItemID { get; set; }

        /// <summary>
        /// 计划出货量
        /// </summary>
        public decimal PlanQty { get; set; }

        ///// <summary>
        ///// 当前备货量
        ///// </summary>
        //public decimal CurrentQty { get; set; }

        ///// <summary>
        ///// 车牌号
        ///// </summary>
        //public string CarNo { get; set; }

        ///// <summary>
        ///// 货柜号 
        ///// </summary>
        //public string ContainerNo { get; set; }

        ///// <summary>
        ///// 封条号 
        ///// </summary>
        //public string SealNo { get; set; }

        ///// <summary>
        ///// 备注
        ///// </summary>
        //public string Remark { get; set; }

        /// <summary>
        /// 项次
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string SalorderItem { get; set; }

        ///// <summary>
        ///// 客户订单号
        ///// </summary>
        //public string CustomerOrder { get; set; }

        /// <summary>
        /// 仓库编码
        /// </summary>
        public string WhCode { get; set; }

        /// <summary>
        /// ERP备货单明细Id
        /// </summary>
        public string ERPId { get; set; }

        /// <summary>
        /// 备货单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string DNCode { get; set; }

        /// <summary>
        /// 公司编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int ERPOperateType { get; set; }


        ///// <summary>
        ///// 数据插入时间
        ///// </summary>
        //public DateTime ERPInsertDateTime { get; set; }

        ///// <summary>
        ///// 同步表示（0：未同步 1：已同步 2：重复数据，不同步）
        ///// </summary>
        //public int ERPSyncFlag { get; set; }

        ///// <summary>
        ///// 同步到MES正式表时间
        ///// </summary>
        //public DateTime ERPSyncDateTime { get; set; }
    }

}