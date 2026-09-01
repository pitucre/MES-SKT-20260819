using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 备货表
    /// </summary>
    public class ERPProdSalOrderInfo
    {
        ///// <summary>
        ///// SalOrderID
        ///// </summary>
        //public int SalOrderID { get; set; }

        /// <summary>
        /// 备货单编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string DNCode { get; set; }

        /// <summary>
        /// 备货计划时间
        /// </summary>
        public DateTime SalOrderDate { get; set; }

        /// <summary>
        /// 客户编码
        /// </summary>
        public string CusCode { get; set; }

        ///// <summary>
        ///// 客户名称
        ///// </summary>
        //public string CusName { get; set; }

        ///// <summary>
        ///// 交货地址
        ///// </summary>
        //public string Address { get; set; }

        /// <summary>
        /// １备货中２备货完成３已检验４已出货５取消
        /// </summary>
        public int Status { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifyDateTime { get; set; }

        ///// <summary>
        ///// 出货确认人
        ///// </summary>
        //public string FinishBy { get; set; }

        ///// <summary>
        ///// 出货确认时间
        ///// </summary>
        //public DateTime FinishDateTime { get; set; }

        ///// <summary>
        ///// 回传ERP状态
        ///// </summary>
        //public int BackERPStatus { get; set; }

        ///// <summary>
        ///// 回传ERP时间
        ///// </summary>
        //public DateTime BackERPDateTime { get; set; }

        ///// <summary>
        ///// 备货确认人
        ///// </summary>
        //public string StockConfirmBy { get; set; }

        ///// <summary>
        ///// 备货确认时间
        ///// </summary>
        //public DateTime StockConfirmTime { get; set; }

        /// <summary>
        /// ERP销售出库单Id
        /// </summary>
        public string ERPId { get; set; }

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

        /// <summary>
        /// 采购单明细信息
        /// </summary>
        [MappingPropertyAttribute(FieldIgnore = true)]
        public List<ERPProdSalOrderDtlInfo> Details { get; set; }
    }


}