using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 采购单明细项记录表
    /// </summary>
    public class ERPERPPurOrderDtlInfo
    {
        /// <summary>
        /// 工厂编号(MES集团多工厂标示,如ERP无该标示所有表统一传“1”)
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        /// <summary>
        /// 订单明细ID
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string AutoID { get; set; }
        /// <summary>
        /// ERP采购单明细Id
        /// </summary>
        public string ErpAutoID { get; set; }
        
        ///// <summary>
        ///// 采购订单ID	关联主表标示
        ///// </summary>
        //public int POID { get; set; }

        ///// <summary>
        ///// POType
        ///// </summary>
        //public int POType { get; set; }

        /// <summary>
        /// 采购订单编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string POCode { get; set; }

        /// <summary>
        /// 采购数量
        /// </summary>
        public decimal PURQty { get; set; }

        ///// <summary>
        ///// 计划到货数量
        ///// </summary>
        //public decimal RecQty { get; set; }

        /// <summary>
        /// 入库数量
        /// </summary>
        public decimal InStkQty { get; set; }

        ///// <summary>
        ///// 每次已扫描数量
        ///// </summary>
        //public decimal AScanQty { get; set; }

        ///// <summary>
        ///// 产品ID 关联产品标示
        ///// </summary>
        //public int ItemID { get; set; }

        /// <summary>
        /// 产品编号 关联产品标示
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

        /// <summary>
        /// 单位
        /// </summary>
        public string UOM { get; set; }

        /// <summary>
        /// 计划到货日期
        /// </summary>
        public DateTime PlanDate { get; set; }

        ///// <summary>
        ///// 确认日期
        ///// </summary>
        //public DateTime AffirmDate { get; set; }

        ///// <summary>
        ///// TaxRate
        ///// </summary>
        //public float TaxRate { get; set; }

        ///// <summary>
        ///// TotalPriceTC
        ///// </summary>
        //public float TotalPriceTC { get; set; }

        ///// <summary>
        ///// TotalMnyTC
        ///// </summary>
        //public float TotalMnyTC { get; set; }

        ///// <summary>
        ///// NetPriceTC
        ///// </summary>
        //public float NetPriceTC { get; set; }

        ///// <summary>
        ///// NetMnyTC
        ///// </summary>
        //public float NetMnyTC { get; set; }

        ///// <summary>
        ///// MES在其中的明细状态(1:未收料 2:已收料)
        ///// </summary>
        //public int PStatus { get; set; }

        ///// <summary>
        ///// SourceTranType
        ///// </summary>
        //public int SourceTranType { get; set; }

        /// <summary>
        /// U8采购单明细Id
        /// </summary>
        public long SourceInterID { get; set; }

        ///// <summary>
        ///// SourceBillNo
        ///// </summary>
        //public string SourceBillNo { get; set; }

        ///// <summary>
        ///// SOCode
        ///// </summary>
        //public string SOCode { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime { get; set; }

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
        ///// 读取时间(Insert时间)
        ///// </summary>
        //public DateTime InsertDateTime { get; set; }

        ///// <summary>
        ///// 修改时间
        ///// </summary>
        //public DateTime UpdateDateTime { get; set; }

        ///// <summary>
        ///// 是否有效:0表示无效,1表示有效
        ///// </summary>
        //public bool IsActive { get; set; }

        ///// <summary>
        ///// ModifyTime
        ///// </summary>
        //public string ModifyTime { get; set; }

        ///// <summary>
        ///// 品牌名称
        ///// </summary>
        //public string BrandName { get; set; }

        ///// <summary>
        ///// 单价
        ///// </summary>
        //public decimal UnitPrice { get; set; }

        ///// <summary>
        ///// 总 价
        ///// </summary>
        //public decimal TotalPrice { get; set; }

        ///// <summary>
        ///// 交期
        ///// </summary>
        //public DateTime DeliveryDate { get; set; }

        ///// <summary>
        ///// 打印完成状态1:完成
        ///// </summary>
        //public bool PrintStatus { get; set; }

        ///// <summary>
        ///// 已打印数量
        ///// </summary>
        //public decimal PrintQty { get; set; }

        ///// <summary>
        ///// 已退料数量
        ///// </summary>
        //public decimal ReturnQty { get; set; }

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
        /// 已到货数量（来源ERP）
        /// </summary>
        public decimal? RecieveQty { get; set; }

        /// <summary>
        /// 验退数量（来源ERP）
        /// </summary>
        public decimal? IQCRejectQty { get; set; }

        /// <summary>
        /// 仓退数量（来源ERP）
        /// </summary>
        public decimal? WHRejectQty { get; set; }
    }
}