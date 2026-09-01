using System;

namespace SKT.LeanMES.Station.Model
{
    [Serializable]
    public class StationInfo
    {
        private Int32 stationId;
        private String station;
        private String stationDesc;
        private Int32 stationTypeId;
        private Int32 stationStatus;
        private Int32 stationResTypeId;
        private Int32 stationDefaultResId;
        private String stationRevision;
        private Boolean stationIsCurrentRev;
        private String remark;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;
        private Int32 tmplID;
        private Int32 moduleId;

        private string opeType;
        private string resTypeName;
        private string resName;
        private string statusStr;
        private string tempName;
        private string moduleName;

        public String ShortLetter { get; set; }
        /// <summary>
        /// 认证号
        /// </summary>
        public String certification { get; set; }
        //是否为采集工序
        public int IsCollectStation { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.StationInfo 类的新实例。
        /// </summary>
        public StationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.StationInfo 类的新实例。
        /// </summary>
        /// <param name="stationId"></param>
        /// <param name="station">操作工位名称</param>
        /// <param name="stationDesc">操作工位描述</param>
        /// <param name="stationTypeId">操作工位类型</param>
        /// <param name="stationStatus">状态(Releasable可用Hold锁定)</param>
        /// <param name="stationResTypeId">资源类型</param>
        /// <param name="stationDefaultResId">默认资源</param>
        /// <param name="stationRevision">版本</param>
        /// <param name="stationIsCurrentRev">是否当前版本</param>
        /// <param name="remark"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="tmplID"></param>
        public StationInfo(Int32 stationId, String station, String stationDesc, Int32 stationTypeId, 
            Int32 stationStatus, Int32 stationResTypeId, Int32 stationDefaultResId, String stationRevision, Boolean stationIsCurrentRev, 
            String remark, DateTime createDateTime, String createBy, DateTime modifyDateTime, String modifyBy, 
            Int32 tmplID)
        {
            this.stationId = stationId;
            this.station = station;
            this.stationDesc = stationDesc;
            this.stationTypeId = stationTypeId;
            this.stationStatus = stationStatus;
            this.stationResTypeId = stationResTypeId;
            this.stationDefaultResId = stationDefaultResId;
            this.stationRevision = stationRevision;
            this.stationIsCurrentRev = stationIsCurrentRev;
            this.remark = remark;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.tmplID = tmplID;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置操作工位名称
        /// </summary>
        public String Station
        {
            get { return this.station; }
            set { this.station = value; }
        }

        /// <summary>
        /// 获取或设置操作工位描述
        /// </summary>
        public String StationDesc
        {
            get { return this.stationDesc; }
            set { this.stationDesc = value; }
        }

        /// <summary>
        /// 获取或设置操作工位类型
        /// </summary>
        public Int32 StationTypeId
        {
            get { return this.stationTypeId; }
            set { this.stationTypeId = value; }
        }

        /// <summary>
        /// 获取或设置状态(Releasable可用Hold锁定)
        /// </summary>
        public Int32 StationStatus
        {
            get { return this.stationStatus; }
            set { this.stationStatus = value; }
        }

        /// <summary>
        /// 获取或设置资源类型
        /// </summary>
        public Int32 StationResTypeId
        {
            get { return this.stationResTypeId; }
            set { this.stationResTypeId = value; }
        }

        /// <summary>
        /// 获取或设置默认资源
        /// </summary>
        public Int32 StationDefaultResId
        {
            get { return this.stationDefaultResId; }
            set { this.stationDefaultResId = value; }
        }

        /// <summary>
        /// 获取或设置版本
        /// </summary>
        public String StationRevision
        {
            get { return this.stationRevision; }
            set { this.stationRevision = value; }
        }

        /// <summary>
        /// 获取或设置是否当前版本
        /// </summary>
        public Boolean StationIsCurrentRev
        {
            get { return this.stationIsCurrentRev; }
            set { this.stationIsCurrentRev = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
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
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
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
        public Int32 TmplID
        {
            get { return this.tmplID; }
            set { this.tmplID = value; }
        }
        public String OpeType
        {
            get { return this.opeType; }
            set { this.opeType = value; }
        }

        public String ResTypeName
        {
            get { return this.resTypeName; }
            set { this.resTypeName = value; }
        }

        public String ResName
        {
            get { return this.resName; }
            set { this.resName = value; }
        }

        public String StatusStr
        {
            get { return this.statusStr; }
            set { this.statusStr = value; }
        }
        public String TempName
        {
            get { return this.tempName; }
            set { this.tempName = value; }
        }
        public Int32 ModuleId
        {
            set { this.moduleId = value; }
            get { return this.moduleId; }
        }

        public string ModuleName
        {
            set { this.moduleName = value; }
            get { return this.moduleName; }
        }
    }
}