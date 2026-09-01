using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Synchronization.Model
{
    [Serializable]
    public class SynchronizationInfo
    {
        private Int32 synchID;
        private String storedProcedureName;
        private String businessName;
        private Int32 timeout;
        private String createBy;
        private DateTime createTime;
        private String modifyBy;
        private DateTime modifyTime;
        public int SyncID { get; set; }//手动同步ID
        public string SyncType { get; set; }//手动同步类型
        public string SyncContent { get; set; }//手动同步内容
        public DateTime CreateDateTime { get; set; }//创建时间
        public string DisposeDateTime { get; set; }//处理时间
        public string DisposeState { get; set; }//处理状态


        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SynchInfo 类的新实例。
        /// </summary>
        public SynchronizationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SynchInfo 类的新实例。
        /// </summary>
        /// <param name="synchID"></param>
        /// <param name="storedProcedureName">存储过程名字</param>
        /// <param name="businessName">业务名称</param>
        /// <param name="timeout">执行超时时间（单位：毫秒）</param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyTime"></param>
        public SynchronizationInfo(Int32 synchID, String storedProcedureName, String businessName, Int32 timeout,
            String createBy, DateTime createTime, String modifyBy, DateTime modifyTime)
        {
            this.synchID = synchID;
            this.storedProcedureName = storedProcedureName;
            this.businessName = businessName;
            this.timeout = timeout;
            this.createBy = createBy;
            this.createTime = createTime;
            this.modifyBy = modifyBy;
            this.modifyTime = modifyTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SynchID
        {
            get { return this.synchID; }
            set { this.synchID = value; }
        }

        /// <summary>
        /// 获取或设置存储过程名字
        /// </summary>
        public String StoredProcedureName
        {
            get { return this.storedProcedureName; }
            set { this.storedProcedureName = value; }
        }

        /// <summary>
        /// 获取或设置业务名称
        /// </summary>
        public String BusinessName
        {
            get { return this.businessName; }
            set { this.businessName = value; }
        }

        /// <summary>
        /// 获取或设置执行超时时间（单位：毫秒）
        /// </summary>
        public Int32 Timeout
        {
            get { return this.timeout; }
            set { this.timeout = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyTime
        {
            get { return this.modifyTime; }
            set { this.modifyTime = value; }
        }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }
    }
}
