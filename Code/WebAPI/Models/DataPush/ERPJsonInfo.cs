using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.DataPush
{
    /// <summary>
    /// ERP Json信息表（记录ERP每次调用MON WebAPI传入的原始JSON，也会通过此表进行数据分发）
    /// </summary>
    public class ERPJsonInfo
    {
        /// <summary>
        /// ERP Json信息表Id
        /// </summary>
        public int JsonId { get; set; }

        /// <summary>
        /// 同步编码（对应ERP_Sync表SyncCode）
        /// </summary>
        public string SyncCode { get; set; }

        /// <summary>
        /// ERP传入的原始JSON
        /// </summary>
        public string ERPJson { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        public string FactoryCode { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

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
    }

}