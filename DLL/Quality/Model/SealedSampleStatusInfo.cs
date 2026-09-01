using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class SealedSampleStatusInfo
    {
        private Int32 sampleStatusId;
        private String status;
        private String statusDesc;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SealedSampleStatusInfo 类的新实例。
        /// </summary>
        public SealedSampleStatusInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SealedSampleStatusInfo 类的新实例。
        /// </summary>
        /// <param name="sampleStatusId">封样件ID</param>
        /// <param name="status">封样件状态</param>
        /// <param name="statusDesc">封样件描述</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public SealedSampleStatusInfo(Int32 sampleStatusId, String status, String statusDesc, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.sampleStatusId = sampleStatusId;
            this.status = status;
            this.statusDesc = statusDesc;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置封样件ID
        /// </summary>
        public Int32 SampleStatusId
        {
            get { return this.sampleStatusId; }
            set { this.sampleStatusId = value; }
        }

        /// <summary>
        /// 获取或设置封样件状态
        /// </summary>
        public String Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置封样件描述
        /// </summary>
        public String StatusDesc
        {
            get { return this.statusDesc; }
            set { this.statusDesc = value; }
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
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}
