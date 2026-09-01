using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 工单表
    /// </summary>
    public class ERPProdOrderInfo
    {
        ///// <summary>
        ///// 工单ID
        ///// </summary>
        //public int ProdOrderID { get; set; }

        /// <summary>
        /// 工单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string OrderNO { get; set; }

        /// <summary>
        /// 工单类型(1:normal  2:RMA 3:Rework 4：委托加工 5：受托加工 6：重复生产)
        /// </summary>
        public int OrderType { get; set; }

        /// <summary>
        /// 工单状态 Releasable = 1, Hold = 2, Done = 3, Closed = 4
        /// </summary>
        public int Status { get; set; }

        /// <summary>
        /// 优先级
        /// </summary>
        public int Priority { get; set; }

        ///// <summary>
        ///// 产品ID
        ///// </summary>
        //public int ItemId { get; set; }

        ///// <summary>
        ///// 物料BOMID
        ///// </summary>
        //public int BOMId { get; set; }

        ///// <summary>
        ///// 是否拥有工单专用BOM，对应ERP_Prod_OrderBOM(0：没有)
        ///// </summary>
        //public int PrivacyBOMFlag { get; set; }

        ///// <summary>
        ///// 是否拥有工单的产品参数（ERP_Prod_OrderParam）
        ///// </summary>
        //public int PrivacyItemParamFlag { get; set; }

        ///// <summary>
        ///// 是否拥有工单的工序工艺参数（ERP_Prod_OrderParam）
        ///// </summary>
        //public int PrivacyOpeParamFlag { get; set; }

        ///// <summary>
        ///// 路由ID
        ///// </summary>
        //public int RouterId { get; set; }

        ///// <summary>
        ///// 客户ID
        ///// </summary>
        //public int CustomerID { get; set; }

        ///// <summary>
        ///// 客户订单
        ///// </summary>
        //public string CustomerOrder { get; set; }

        ///// <summary>
        ///// 客户订单数量
        ///// </summary>
        //public int CustomerOrderQty { get; set; }

        ///// <summary>
        ///// 工单已排程到线上的数量
        ///// </summary>
        //public int Qty_to_Line { get; set; }

        /// <summary>
        /// 工单数量
        /// </summary>
        public int Qty_to_Build { get; set; }

   



        ///// <summary>
        ///// 工单已释放数量
        ///// </summary>
        //public int Qty_Released { get; set; }

        ///// <summary>
        ///// 工单已完成数量
        ///// </summary>
        //public int Qty_Done { get; set; }

        /// <summary>
        /// 工单报废数量
        /// </summary>
        public int Qty_Scrapped { get; set; }

        /// <summary>
        /// 工单释放日期
        ///// </summary>
        //public DateTime Release_date { get; set; }

        /// <summary>
        /// 工单计划开始时间
        /// </summary>
        public DateTime Planned_Start_Time { get; set; }

        /// <summary>
        /// 工单计划完成时间
        /// </summary>
        public DateTime Planned_Completed_Date { get; set; }

        ///// <summary>
        ///// 工单排产 开始时间
        ///// </summary>
        //public DateTime Scheduled_Start_Date { get; set; }

        ///// <summary>
        ///// 工单排产 结束时间
        ///// </summary>
        //public DateTime Scheduled_Completed_Time { get; set; }

        ///// <summary>
        ///// 实际开始时间
        ///// </summary>
        //public DateTime Actual_Start_Date { get; set; }

        ///// <summary>
        ///// 实际完成时间
        ///// </summary>
        //public DateTime Actual_Completed_Date { get; set; }

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

        /// <summary>
        /// 工厂代码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string Site { get; set; }

        ///// <summary>
        ///// 已生成的包装箱数量
        ///// </summary>
        //public int Qty_GenerateBoxNO { get; set; }

        ///// <summary>
        ///// 生成的拼板数
        ///// </summary>
        //public int GeneratedPanelQty { get; set; }

        ///// <summary>
        ///// 置换条码数量
        ///// </summary>
        //public int Qty_ReplaceSN { get; set; }

        ///// <summary>
        ///// 是否MES新增的工单 1 是
        ///// </summary>
        //public bool IsMESadd { get; set; }

        ///// <summary>
        ///// 来源单类型
        ///// </summary>
        //public int SourceTranType { get; set; }

        ///// <summary>
        ///// 来源单ID
        ///// </summary>
        //public int SourceInterId { get; set; }

        /// <summary>
        /// 来源单单号
        /// </summary>        
        public string SourceBillNo { get; set; }

        /// <summary>
        /// ERP工单ID
        /// </summary>
        public string ERPMOID { get; set; }

        ///// <summary>
        ///// ERP的工单状态
        ///// </summary>
        //public int ERPStatus { get; set; }

        ///// <summary>
        ///// ERP的工单类型
        ///// </summary>
        //public int ERPMOType { get; set; }

        ///// <summary>
        ///// 掩码规则ID（用于验证相关条码是否合理）
        ///// </summary>
        //public int MaskId { get; set; }

        ///// <summary>
        ///// Qty_Input
        ///// </summary>
        //public int Qty_Input { get; set; }

        ///// <summary>
        ///// ERPItemId
        ///// </summary>
        //public int ERPItemId { get; set; }

        ///// <summary>
        ///// ERPBOMId
        ///// </summary>
        //public int ERPBOMId { get; set; }

        ///// <summary>
        ///// ERPCustomerID
        ///// </summary>
        //public int ERPCustomerID { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

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
        /// 工单BOM明细信息
        /// </summary>
        [MappingPropertyAttribute(FieldIgnore = true)]
        public List<ERPProdOrderBomInfo> Details { get; set; }


        ///// <summary>
        ///// 工单类型(1:一般工单，2:委外工单，3：拆件式工单，4：返工工单)  ERP有两个字段，组合到一起传，MOM对应一个字段
        ///// </summary>
        //public string OrderTypeName { get; set; }


        /// <summary>
        /// 机台号
        /// </summary>
        public string MachineNumber { get; set; }


        /// <summary>
        /// 工单BOM版本号
        /// </summary>
        public string BomVersion { get; set; }

    }
}
