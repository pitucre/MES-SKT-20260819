using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.DataPush
{
    /// <summary>
    /// ERP数据分发配置表
    /// </summary>
    public class ERPDataPushConfigInfo
    {
        /// <summary>
        /// ERP数据分发配置表Id
        /// </summary>
        public int DataPushConfigId { get; set; }

        /// <summary>
        /// 同步编码（对应ERP_Sync表SyncCode）
        /// </summary>
        public string SyncCode { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        public string FactoryCode { get; set; }

        /// <summary>
        /// 最后分发时间（ERP_Json表中的CreateDateTime字段）
        /// </summary>
        public DateTime? LastSyncTime { get; set; }

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