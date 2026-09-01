using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 报废单主表
    /// </summary>
    public class ERPProdScrapInfo
    {
        ///// <summary>
        ///// 报废单主表
        ///// </summary>
        //public int ERPProdScrapId { get; set; }

        /// <summary>
        /// 报废单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string ScrapNo { get; set; }

        /// <summary>
        /// DepCode
        /// </summary>
        public string DepCode { get; set; }

        ///// <summary>
        ///// 状态(0-待报废，1-报废中，2-报废完成)
        ///// </summary>
        //public int Statue { get; set; }

        /// <summary>
        /// 报废原因
        /// </summary>
        public string Remark { get; set; }

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
        ///// 报废单审核人ID
        ///// </summary>
        //public int Auditing { get; set; }

        ///// <summary>
        ///// 报废单审核时间
        ///// </summary>
        //public DateTime AuditingDate { get; set; }

        /// <summary>
        /// 仓库编码
        /// </summary>
        public string Whouse { get; set; }

        ///// <summary>
        ///// 结束报废申请人
        ///// </summary>
        //public string EndUser { get; set; }

        ///// <summary>
        ///// EndDate
        ///// </summary>
        //public DateTime EndDate { get; set; }

        /// <summary>
        /// 工厂编码
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
        ///// 同步标识（0：未同步 1：已同步 2：重复数据，不同步）
        ///// </summary>
        //public int ERPSyncFlag { get; set; }

        ///// <summary>
        ///// 同步到MES正式表时间
        ///// </summary>
        //public DateTime ERPSyncDateTime { get; set; }

        /// <summary>
        /// 报废单明细信息表
        /// </summary>
        [MappingPropertyAttribute(FieldIgnore = true)]
        public List<ERPProdScrapDtlInfo> Details { get; set; }
    }

}