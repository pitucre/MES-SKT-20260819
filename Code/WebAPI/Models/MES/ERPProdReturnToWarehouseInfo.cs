using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 退料到仓库表
    /// </summary>
    public class ERPProdReturnToWarehouseInfo
    {
        ///// <summary>
        ///// 表格行号
        ///// </summary>
        //public int ReturnToWarehouseID { get; set; }

        /// <summary>
        /// 退料单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string ReturnOrderNo { get; set; }

        ///// <summary>
        ///// 产品Id
        ///// </summary>
        //public int ItemID { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

        /// <summary>
        /// 工单号
        /// </summary>
        public string ProdOrderNo { get; set; }

        ///// <summary>
        ///// 部门Id
        ///// </summary>
        //public int? DeptID { get; set; }

        /// <summary>
        /// 退料数量
        /// </summary>
        public decimal? ReturnQty { get; set; }

        ///// <summary>
        ///// 目前接收数量
        ///// </summary>
        //public decimal? ReceiveQty { get; set; }

        ///// <summary>
        ///// 0,未完成，1，完成，-1，取消
        ///// </summary>
        //public int? FinishStatus { get; set; }

        ///// <summary>
        ///// 备注
        ///// </summary>
        //public string Remark { get; set; }

        ///// <summary>
        ///// Default_1
        ///// </summary>
        //public string Default_1 { get; set; }

        ///// <summary>
        ///// Default_2
        ///// </summary>
        //public string Default_2 { get; set; }

        ///// <summary>
        ///// Default_3
        ///// </summary>
        //public string Default_3 { get; set; }

        ///// <summary>
        ///// Default_4
        ///// </summary>
        //public string Default_4 { get; set; }

        ///// <summary>
        ///// Default_5
        ///// </summary>
        //public string Default_5 { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string UpdateBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }

        ///// <summary>
        ///// ERPState
        ///// </summary>
        //public int? ERPState { get; set; }

        ///// <summary>
        ///// MESState
        ///// </summary>
        //public int? MESState { get; set; }

        ///// <summary>
        ///// ERPReBillID
        ///// </summary>
        //public int? ERPReBillID { get; set; }

        ///// <summary>
        ///// 仓库Id
        ///// </summary>
        //public int? WhID { get; set; }

        /// <summary>
        /// 行号
        /// </summary>
        public string SourceInterId { get; set; }

        ///// <summary>
        ///// SourceBillNo
        ///// </summary>
        //public string SourceBillNo { get; set; }

        ///// <summary>
        ///// SourceEntryID
        ///// </summary>
        //public string SourceEntryID { get; set; }

        ///// <summary>
        ///// 供应商编码
        ///// </summary>
        //public string VenCode { get; set; }

        ///// <summary>
        ///// ERP单号
        ///// </summary>
        //public string ERPRetNO { get; set; }

        ///// <summary>
        ///// 0:已申请 1：已清点 2：已退料
        ///// </summary>
        //public int? Status { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        public string FactoryCode { get; set; }

        /// <summary>
        /// 部门编码
        /// </summary>
        public string DepCode { get; set; }

        
        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int ERPOperateType { get; set; }


        /// <summary>
        /// 仓库编码（来源ERP）
        /// </summary>
        public string CWhCode { get; set; }

        /// <summary>
        /// 批次号（来源ERP）
        /// </summary>
        public string LotCode { get; set; }
    }
}