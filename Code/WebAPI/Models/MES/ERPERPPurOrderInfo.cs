using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebAPI.Models.ERP;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 采购单主表
    /// </summary>
   [Serializable]
    public class ERPERPPurOrderInfo
    {

        /// <summary>
        /// 工厂编号(MES集团多工厂标示,如ERP无该标示所有表统一传“1”)
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        /// <summary>
        /// ERP采购订单ID
        /// </summary>
        public string POID { get; set; }

        /// <summary>
        /// 采购订单编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string POCode { get; set; }

        /// <summary>
        /// 单据日期
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public DateTime PurDate { get; set; }

        /// <summary>
        /// 采购类型	"1.采购订单2.委外订单,3.客供料"
        /// </summary>
        public int POType { get; set; }

        ///// <summary>
        ///// 供应商ID 关联供应链标示
        ///// </summary>
        //public int VenID { get; set; }

        /// <summary>
        /// 供应商编码 关联供应链标示
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string VenCode { get; set; }

        ///// <summary>
        ///// 业务类型,1为外购采购订单,2为委外加工订单,3.客供料
        ///// </summary>
        //public int BusType { get; set; }

        ///// <summary>
        ///// 送货地址
        ///// </summary>
        //public string ADDRESS { get; set; }

        ///// <summary>
        ///// 是否保税
        ///// </summary>
        //public int BondedType { get; set; }

        ///// <summary>
        ///// 业务员
        ///// </summary>
        //public string PersonCode { get; set; }

        ///// <summary>
        ///// 部门
        ///// </summary>
        //public string DepCode { get; set; }

        /// <summary>
        /// 建档日期
        /// </summary>
        public DateTime CreateDateTime { get; set; }

        ///// <summary>
        ///// MES采购订单状态：1:正常
        ///// </summary>
        //public int PStatus { get; set; }

        /// <summary>
        /// 变更日期 
        /// </summary>
        public DateTime ModifyDateTime { get; set; }

        ///// <summary>
        ///// 备注
        ///// </summary>
        //public string Remark { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public DateTime Default_1 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public DateTime Default_2 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public decimal Default_3 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public decimal Default_4 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_5 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_6 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_7 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_8 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_9 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_10 { get; set; }

        ///// <summary>
        ///// 是否供应商已经交期确认（0：没有 1：有）
        ///// </summary>
        //public bool IsPeriod { get; set; }

        ///// <summary>
        ///// 读取时间(Insert时间)
        ///// </summary>
        //public DateTime InsertDateTime { get; set; }

        ///// <summary>
        ///// 修改时间
        ///// </summary>
        //public DateTime UpdateDateTime { get; set; }

        ///// <summary>
        ///// ModifyTime
        ///// </summary>
        //public string ModifyTime { get; set; }

        ///// <summary>
        ///// 项目编号
        ///// </summary>
        //public string ProjectNo { get; set; }

        ///// <summary>
        ///// 下单日期
        ///// </summary>
        //public DateTime OrderDate { get; set; }

        ///// <summary>
        ///// 税率
        ///// </summary>
        //public decimal TaxRate { get; set; }

        ///// <summary>
        ///// 含税合计
        ///// </summary>
        //public decimal TaxRateTotal { get; set; }

        ///// <summary>
        ///// 付款条件
        ///// </summary>
        //public string PaymentTerms { get; set; }

        ///// <summary>
        ///// 交付方式
        ///// </summary>
        //public string PaymentMethod { get; set; }

        ///// <summary>
        ///// 交货地址
        ///// </summary>
        //public string DeliveryAddress { get; set; }

        ///// <summary>
        ///// 自动增长ID
        ///// </summary>
        //public int PurOrderId { get; set; }

        ///// <summary>
        ///// IsMesAdd
        ///// </summary>
        //public int IsMesAdd { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        ///// <summary>
        ///// 收货方式
        ///// </summary>
        //public string ReceiveType { get; set; }

        /// <summary>
        /// 是否关闭状态  9为未关闭  10为已关闭
        /// </summary>
        public int OpenDataStatus { get; set; }

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
        public List<ERPERPPurOrderDtlInfo> Details { get; set; }

    }
}