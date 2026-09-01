using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.CommonDataSource.Model
{
    /// <summary>
    /// ERP同步日志表
    /// </summary>
    [Serializable]
    public class ERPSyncLogInfo
    {
        /// <summary>
        /// ERP同步日志表Id
        /// </summary>
        public int SyncLogId { get; set; }

        /// <summary>
        /// 同步编码（关联ERP_Sync表SyncCode字段），此字段可能为空
        /// </summary>
        public string SyncCode { get; set; }

        /// <summary>
        /// 同步的存储过程名称
        /// </summary>
        public string SyncProcName { get; set; }

        /// <summary>
        /// 同步结果（0：失败 1：成功）
        /// </summary>
        public int? SyncResult { get; set; }

        /// <summary>
        /// 同步消息（成功时为NULL,失败时显示失败原因）
        /// </summary>
        public string SyncMsg { get; set; }

        /// <summary>
        /// 单据号（按单据号(如：采购单、工单等)同步时，按记录此值，后台自动同步或手动执行时不按单号同步时，此字段值为空）
        /// </summary>
        public string BillNo { get; set; }

        /// <summary>
        /// 查询ERP表或视图—开始时间（ERP最后更新时间字段）
        /// </summary>
        public DateTime? QueryStartTime { get; set; }

        /// <summary>
        /// 查询ERP表或视图—截止时间（ERP最后更新时间字段）
        /// </summary>
        public DateTime? QueryEndTime { get; set; }

        /// <summary>
        /// 新增行数
        /// </summary>
        public int? InsertRowCount { get; set; }

        /// <summary>
        /// 更新行数
        /// </summary>
        public int? UpdateRowCount { get; set; }

        /// <summary>
        /// 删除行数
        /// </summary>
        public int? DeleteRowCount { get; set; }

        /// <summary>
        /// 同步开始时间（用于记录当次同步耗时）
        /// </summary>
        public DateTime? StartSyncTime { get; set; }

        /// <summary>
        /// 同步结束时间（用于记录当次同步耗时）
        /// </summary>
        public DateTime? EndSyncTime { get; set; }

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
        /// 同步结果（0：失败 1：成功）
        /// </summary>
        public string SyncResultName { get; set; }

        /// <summary>
        /// 同步名称
        /// </summary>
        public string SyncName { get; set; }

        #endregion
    }
}
