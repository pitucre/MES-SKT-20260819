using System;

namespace SKT.LeanMES.SDP.Model
{
    [Serializable]
    public class ActivityInfo
    {
        private Int32 id;
        private String routeId;
        private String stationId;
        private String controlId;
        private String controlName;
        private String controlType;
        private String eventType;
        private String eventName;
        private String sortNo;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ActivityInfo 类的新实例。
        /// </summary>
        public ActivityInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ActivityInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="routeId"></param>
        /// <param name="stationId"></param>
        /// <param name="controlId"></param>
        /// <param name="controlName"></param>
        /// <param name="controlType"></param>
        /// <param name="eventType"></param>
        /// <param name="eventName"></param>
        /// <param name="sortNo"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public ActivityInfo(Int32 id, String routeId, String stationId, String controlId,
            String controlName, String controlType, String eventType, String eventName, String sortNo,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.id = id;
            this.routeId = routeId;
            this.stationId = stationId;
            this.controlId = controlId;
            this.controlName = controlName;
            this.controlType = controlType;
            this.eventType = eventType;
            this.eventName = eventName;
            this.sortNo = sortNo;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RouteId
        {
            get { return this.routeId; }
            set { this.routeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ControlId
        {
            get { return this.controlId; }
            set { this.controlId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ControlName
        {
            get { return this.controlName; }
            set { this.controlName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ControlType
        {
            get { return this.controlType; }
            set { this.controlType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String EventType
        {
            get { return this.eventType; }
            set { this.eventType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String EventName
        {
            get { return this.eventName; }
            set { this.eventName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SortNo
        {
            get { return this.sortNo; }
            set { this.sortNo = value; }
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