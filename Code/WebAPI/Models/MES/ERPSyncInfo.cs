using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebAPI.Models.Enum;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// ERP同步信息表
    /// </summary>
    [Serializable]
    public class ERPSyncInfo
    {
        /// <summary>
        /// ERP同步信息表Id
        /// </summary>
        public int SyncId { get; set; }

        /// <summary>
        /// 同步编码
        /// </summary>
        public string SyncCode { get; set; }

        /// <summary>
        /// 同步名称
        /// </summary>
        public string SyncName { get; set; }

        /// <summary>
        /// 全表同步标识（0：否(按最后修改时间增量同步) 1：是(ERP源表中没有最后修改时间时，只能全表同步) 2：非全表同步、非增量同步，只能按单号同步）
        /// </summary>
        public int? IsFullSync { get; set; }

        /// <summary>
        /// 是否初始化完成（-1 全表同步，不需要初始化 0：否 1：是）
        /// </summary>
        public int? InitCompleteFlag { get; set; }

        /// <summary>
        /// 同步递增量，单位：天，（比如：同步工单BOM等大表时，数据量很大，需要按时间递增同步，当InitCompleteFlag字段值为1时，就不需要再按时间递增取数据了）
        /// </summary>
        public int? IncrementalValue { get; set; }

        /// <summary>
        /// 最后一次同步结果（-1：未同步 0：失败 1：成功）
        /// </summary>
        public int? LastSyncResult { get; set; }

        /// <summary>
        /// 最后一次同步消息
        /// </summary>
        public string LastSyncMsg { get; set; }

        /// <summary>
        /// 最后同步时间
        /// </summary>
        public DateTime? LastSyncTime { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 是否启用（0：否 1：是）
        /// </summary>
        public int? EnableFlag { get; set; }

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

        /// <summary>
        /// API
        /// </summary>
        public string Api { get; set; }

        /// <summary>
        /// MES中间库表名
        /// </summary>
        public string MiddleTableName { get; set; }

        /// <summary>
        /// 对应的同步存储过程
        /// </summary>
        public string SyncProcedure { get; set; }


        /// <summary>
        /// 同步方式
        /// </summary>
        public SyncTypeEnum SyncType { get; set; }

        /// <summary>
        /// 是否根据单号同步
        /// </summary>
        public bool SyncByBillNo { get; set; }


        /// <summary>
        /// 数据库时间
        /// </summary>
        public DateTime CurrentDBTime { get; set; }

        /// <summary>
        /// 是否需要根据工厂代码进行同步 0：否 1：是（WebApi用到此字段，一般单据类需要根据工厂代码进行同步，如果当前站点是总部，则不需要不管此字段值配置为什么，都需要进行同步）
        /// </summary>
        public int SyncByFactroyCodeFlag { get; set; }
    }

   
}