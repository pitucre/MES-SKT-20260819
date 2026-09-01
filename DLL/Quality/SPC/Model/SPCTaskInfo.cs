using System;

namespace SKT.LeanMES.SPC.Model
{
    [Serializable]
    public class SPCTaskInfo
    {
        private Int32 sPCTaskId;
        private Int32 sPCProjectId;
        private String taskName;
        private String taskDesc;
        private Int32 itemId;
        private Int32 lineId;
        private Int32 stationId;
        private Boolean isRefeshData;
        private Decimal refeshInterval;
        private Decimal uSL;
        private Decimal lSL;
        private String units;
        private String sPCGetDataProc;
        private String sPCActionProc;
        private String sPCAGraphProc;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        public string ProjectName { get; set; }
        public string GraphType { get; set; }
        public string Station { get; set; }
        public string LineName { get; set; }
        public string ItemCode { get; set; }

        public int SpcId { get; set; }
        public string TestValue { get; set; }
        public string TestResult { get; set; }
        public string TestWay { get; set; }
        public DateTime TestDataTime { get; set; }


        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SPCTaskInfo 类的新实例。
        /// </summary>
        public SPCTaskInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SPCTaskInfo 类的新实例。
        /// </summary>
        /// <param name="sPCTaskId"></param>
        /// <param name="sPCProjectId">SPC项目ID</param>
        /// <param name="taskName">任务名称</param>
        /// <param name="taskDesc">任务描述</param>
        /// <param name="itemId">产品编码</param>
        /// <param name="lineId">线别ID</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="isRefeshData">是否使用时钟自动刷新数据</param>
        /// <param name="refeshInterval">时钟刷新间隔（分钟）</param>
        /// <param name="uSL">规格上线</param>
        /// <param name="lSL">规格下线</param>
        /// <param name="units">单位</param>
        /// <param name="sPCGetDataProc">任务数据源获取存储过程名称</param>
        /// <param name="sPCActionProc">报警后执行的存储过程</param>
        /// <param name="sPCAGraphProc">图表页面获取数据的存储过程</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public SPCTaskInfo(Int32 sPCTaskId, Int32 sPCProjectId, String taskName, String taskDesc,
            Int32 itemId, Int32 lineId, Int32 stationId, Boolean isRefeshData, Decimal refeshInterval,
            Decimal uSL, Decimal lSL, String units, String sPCGetDataProc, String sPCActionProc,
            String sPCAGraphProc, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.sPCTaskId = sPCTaskId;
            this.sPCProjectId = sPCProjectId;
            this.taskName = taskName;
            this.taskDesc = taskDesc;
            this.itemId = itemId;
            this.lineId = lineId;
            this.stationId = stationId;
            this.isRefeshData = isRefeshData;
            this.refeshInterval = refeshInterval;
            this.uSL = uSL;
            this.lSL = lSL;
            this.units = units;
            this.sPCGetDataProc = sPCGetDataProc;
            this.sPCActionProc = sPCActionProc;
            this.sPCAGraphProc = sPCAGraphProc;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SPCTaskId
        {
            get { return this.sPCTaskId; }
            set { this.sPCTaskId = value; }
        }

        /// <summary>
        /// 获取或设置SPC项目ID
        /// </summary>
        public Int32 SPCProjectId
        {
            get { return this.sPCProjectId; }
            set { this.sPCProjectId = value; }
        }

        /// <summary>
        /// 获取或设置任务名称
        /// </summary>
        public String TaskName
        {
            get { return this.taskName; }
            set { this.taskName = value; }
        }

        /// <summary>
        /// 获取或设置任务描述
        /// </summary>
        public String TaskDesc
        {
            get { return this.taskDesc; }
            set { this.taskDesc = value; }
        }

        /// <summary>
        /// 获取或设置产品编码
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
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
        /// 获取或设置工序ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置是否使用时钟自动刷新数据
        /// </summary>
        public Boolean IsRefeshData
        {
            get { return this.isRefeshData; }
            set { this.isRefeshData = value; }
        }

        /// <summary>
        /// 获取或设置时钟刷新间隔（分钟）
        /// </summary>
        public Decimal RefeshInterval
        {
            get { return this.refeshInterval; }
            set { this.refeshInterval = value; }
        }

        /// <summary>
        /// 获取或设置规格上线
        /// </summary>
        public Decimal USL
        {
            get { return this.uSL; }
            set { this.uSL = value; }
        }

        /// <summary>
        /// 获取或设置规格下线
        /// </summary>
        public Decimal LSL
        {
            get { return this.lSL; }
            set { this.lSL = value; }
        }

        /// <summary>
        /// 获取或设置单位
        /// </summary>
        public String Units
        {
            get { return this.units; }
            set { this.units = value; }
        }

        /// <summary>
        /// 获取或设置任务数据源获取存储过程名称
        /// </summary>
        public String SPCGetDataProc
        {
            get { return this.sPCGetDataProc; }
            set { this.sPCGetDataProc = value; }
        }

        /// <summary>
        /// 获取或设置报警后执行的存储过程
        /// </summary>
        public String SPCActionProc
        {
            get { return this.sPCActionProc; }
            set { this.sPCActionProc = value; }
        }

        /// <summary>
        /// 获取或设置图表页面获取数据的存储过程
        /// </summary>
        public String SPCAGraphProc
        {
            get { return this.sPCAGraphProc; }
            set { this.sPCAGraphProc = value; }
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
        /// 单位Id
        /// </summary>
        public int UnitId { get; set; }


        /// <summary>
        /// 单位
        /// </summary>
        public string Unit { get; set; }

        //是否曲线显示
        public Boolean IsCurve { get; set; }
    }
}