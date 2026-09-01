using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{    /// <summary>
    /// 货架库位表
    /// </summary>
    public class ERPBasalWarehouseLocationInfo
    {
        ///// <summary>
        ///// 自增长编号
        ///// </summary>
        //public int WarehouseLocationId { get; set; }

        /// <summary>
        /// 储位编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string cStoreCode { get; set; }

        /// <summary>
        /// 储位名称
        /// </summary>
        public string cStoreName { get; set; }

        /// <summary>
        /// 货位编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string cPosCode { get; set; }

        /// <summary>
        /// 货位名称
        /// </summary>
        public string cPosName { get; set; }

        ///// <summary>
        ///// 仓库属性,S:一般性仓库,W: 在制品仓库
        ///// </summary>
        //public string CProperty { get; set; }

        /// <summary>
        /// cWhCode
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string cWhCode { get; set; }

        ///// <summary>
        ///// 发料顺序
        ///// </summary>
        //public string MOrder { get; set; }

        ///// <summary>
        ///// 发货顺序
        ///// </summary>
        //public string POrder { get; set; }

        ///// <summary>
        ///// 编码级次
        ///// </summary>
        //public int iPosGrade { get; set; }

        ///// <summary>
        ///// 是否末级
        ///// </summary>
        //public int bPosEnd { get; set; }

        /// <summary>
        /// 对应条形码编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string cBarCode { get; set; }

        /// <summary>
        /// 最大体积
        /// </summary>
        //public decimal iMaxCubage { get; set; }

        ///// <summary>
        ///// 最大重量
        ///// </summary>
        //public decimal iMaxWeight { get; set; }

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
        /// 备注信息
        /// </summary>
        public string Remark { get; set; }

        ///// <summary>
        ///// 仓库Id
        ///// </summary>
        //public int cWhId { get; set; }

        ///// <summary>
        ///// 工厂编号
        ///// </summary>
        //[MappingPropertyAttribute(AllowEmpty = false)]
        //public string FactoryCode { get; set; }

        /// <summary>
        /// 是否有效:0表示无效,1表示有效
        /// </summary>
        public bool IsActive { get; set; }

        ///// <summary>
        ///// ERP货位表的ID
        ///// </summary>
        //public string ERPPosID { get; set; }

        ///// <summary>
        ///// 存放产品是否唯一
        ///// </summary>
        //public int ProductIsOnly { get; set; }

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