using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.CommonDataSource.Model
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
        /// 全表同步标识（0：否(按最后修改时间增量同步) 1：是(ERP源表中没有最后修改时间时，只能全表同步)）
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


        #region 扩展字段

        /// <summary>
        /// 全表同步标识（0：否(按最后修改时间增量同步) 1：是(ERP源表中没有最后修改时间时，只能全表同步)）
        /// </summary>
        public string FullSyncName { get; set; }

        /// <summary>
        /// 是否初始化完成（-1 全表同步，不需要初始化 0：否 1：是）
        /// </summary>
        public string InitCompleteFlagName { get; set; }

        /// <summary>
        /// 最后一次同步结果（-1：未同步 0：失败 1：成功）
        /// </summary>
        public string LastSyncResultName { get; set; }

        #endregion
    }
}
