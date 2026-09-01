using System;

namespace SKT.LeanMES.Station.Model
{
    [Serializable]
    public class ResourceInfo
    {
        private Int32 resourceId;
        private Int32 lineId;
        private String resName;
        private String resDescription;
        private Int32 resStatus;
        private String defaultOpt;
        private DateTime validStartTime;
        private DateTime validEndTime;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.ResourceInfo 类的新实例。
        /// </summary>
        public ResourceInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.ResourceInfo 类的新实例。
        /// </summary>
        /// <param name="resourceId">资源ID</param>
        /// <param name="lineId">线别ID</param>
        /// <param name="resName">资源名称</param>
        /// <param name="resDescription">资源描述</param>
        /// <param name="resStatus">资源状态(1.Enabled 2.Disabled 3.Hold 4.Scheduled Down 5.Unscheduled Down 6.Non-scheduled 7.Hold Consec NC 8.Hold SPC Viol 9.Hold SPC Warn 10.Hold Yield Rate 11.Unknown 12.Productive 13.Standby 14.Engineering)</param>
        /// <param name="defaultOpt">默认站位代号</param>
        /// <param name="validStartTime">起始时间</param>
        /// <param name="validEndTime">终止时间</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public ResourceInfo(Int32 resourceId, Int32 lineId, String resName, String resDescription, 
            Int32 resStatus, String defaultOpt, DateTime validStartTime, DateTime validEndTime, String createBy, 
            String modifyBy, String remark)
        {
            this.resourceId = resourceId;
            this.lineId = lineId;
            this.resName = resName;
            this.resDescription = resDescription;
            this.resStatus = resStatus;
            this.defaultOpt = defaultOpt;
            this.validStartTime = validStartTime;
            this.validEndTime = validEndTime;
            this.createBy = createBy;
            this.modifyBy = modifyBy;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置资源ID
        /// </summary>
        public Int32 ResourceId
        {
            get { return this.resourceId; }
            set { this.resourceId = value; }
        }

        /// <summary>
        /// 获取或设置线别ID
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置资源名称
        /// </summary>
        public String ResName
        {
            get { return this.resName; }
            set { this.resName = value; }
        }

        /// <summary>
        /// 获取或设置资源描述
        /// </summary>
        public String ResDescription
        {
            get { return this.resDescription; }
            set { this.resDescription = value; }
        }

        /// <summary>
        /// 获取或设置资源状态(1.Enabled 2.Disabled 3.Hold 4.Scheduled Down 5.Unscheduled Down 6.Non-scheduled 7.Hold Consec NC 8.Hold SPC Viol 9.Hold SPC Warn 10.Hold Yield Rate 11.Unknown 12.Productive 13.Standby 14.Engineering)
        /// </summary>
        public Int32 ResStatus
        {
            get { return this.resStatus; }
            set { this.resStatus = value; }
        }

        /// <summary>
        /// 获取或设置默认站位代号
        /// </summary>
        public String DefaultOpt
        {
            get { return this.defaultOpt; }
            set { this.defaultOpt = value; }
        }

        /// <summary>
        /// 获取或设置起始时间
        /// </summary>
        public DateTime ValidStartTime
        {
            get { return this.validStartTime; }
            set { this.validStartTime = value; }
        }

        /// <summary>
        /// 获取或设置终止时间
        /// </summary>
        public DateTime ValidEndTime
        {
            get { return this.validEndTime; }
            set { this.validEndTime = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}