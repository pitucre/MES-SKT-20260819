using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 工厂信息表
    /// </summary>
    public class ERPBasalFactoryInfo
    {
        ///// <summary>
        ///// 主键
        ///// </summary>
        //public int? FactoryID { get; set; }

        /// <summary>
        /// 工厂名
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryName { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string FactoryCode { get; set; }

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
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }

        ///// <summary>
        ///// 备注
        ///// </summary>
        //public string Remark { get; set; }

        ///// <summary>
        ///// ChkIsDefaultFactory
        ///// </summary>
        //public int? ChkIsDefaultFactory { get; set; }

        ///// <summary>
        ///// 公司/工厂类型： 1、工厂  2、公司
        ///// </summary>
        //public int? TypeId { get; set; }

        ///// <summary>
        ///// 工厂API地址（子工厂才需要设置，由总部WebApi通过定时任务，将数据分发到子工厂）
        ///// </summary>
        //public string Api { get; set; }

        /// <summary>
        /// 生产型企业标识（0：否 1：是）
        /// </summary>
        public int? ProductionFlag { get; set; }

        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int? ERPOperateType { get; set; }

        ///// <summary>
        ///// 数据插入时间
        ///// </summary>
        //public DateTime? ERPInsertDateTime { get; set; }

        ///// <summary>
        ///// 同步表示（0：未同步 1：已同步 2：重复数据，不同步）
        ///// </summary>
        //public int? ERPSyncFlag { get; set; }

        ///// <summary>
        ///// 同步到MES正式表时间
        ///// </summary>
        //public DateTime? ERPSyncDateTime { get; set; }
    }



}