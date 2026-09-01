using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 供应商信息表
    /// </summary>
    public class ERPBasalSupplierInfo
    {
        ///// <summary>
        ///// SupplierId
        ///// </summary>
        //public int SupplierId { get; set; }

        /// <summary>
        /// 供应商编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string VendorCode { get; set; }

        /// <summary>
        /// 供应商名称 
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string VendorName { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string Site { get; set; }

        /// <summary>
        /// 供应商简称
        /// </summary>
        public string VendorSort { get; set; }

        ///// <summary>
        ///// 描述
        ///// </summary>
        //public string Description { get; set; }

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
        ///// Remark
        ///// </summary>
        //public string Remark { get; set; }

        ///// <summary>
        ///// 供应商地址
        ///// </summary>
        //public string VendorAddress { get; set; }

        ///// <summary>
        ///// 供应商状态代码
        ///// </summary>
        //public int StatusNo { get; set; }

        ///// <summary>
        ///// 供应商状态
        ///// </summary>
        //public string Status { get; set; }

        /// <summary>
        /// 是否有效:0表示无效,1表示有效
        /// </summary>
        public bool IsActive { get; set; }

        ///// <summary>
        ///// 总公司编码(如非子公司默认与VenCode一样)
        ///// </summary>
        //public string VenHeadCode { get; set; }

        /// <summary>
        /// ERP供应商表的ID
        /// </summary>
        public string ERPVenID { get; set; }

        ///// <summary>
        ///// VenUserName
        ///// </summary>
        //public string VenUserName { get; set; }

        ///// <summary>
        ///// VenPhone
        ///// </summary>
        //public string VenPhone { get; set; }

        ///// <summary>
        ///// IsMesAdd
        ///// </summary>
        //public int IsMesAdd { get; set; }

        ///// <summary>
        ///// 是否上传出货报告
        ///// </summary>
        //public int IsShipmentReport { get; set; }

        ///// <summary>
        ///// 是否上传实验报告
        ///// </summary>
        //public int IsLaboratoryReport { get; set; }

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