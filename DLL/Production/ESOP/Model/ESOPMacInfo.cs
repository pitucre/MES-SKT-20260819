using System;

namespace SKT.LeanMES.ESOP.Model
{
    [Serializable]
    public class ESOPMacInfo
    {
        private Int32 eSOPMacId;
        private String mAC;
        private String macName;
        private Int32 stationId;
        private Int32 resourceId;
        private Boolean isSwitch;
        private String remark;

        public string Station { get; set; }
        public string ResName { get; set; }
        public string LineName { get; set; }

        public Boolean IsDefault { get; set; }

        public string CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string ModifyBy { get; set; }
        public DateTime ModifyDateTime { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ESOPMacInfo 类的新实例。
        /// </summary>
        public ESOPMacInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ESOPMacInfo 类的新实例。
        /// </summary>
        /// <param name="eSOPMacId"></param>
        /// <param name="mAC">机器MAC地址</param>
        /// <param name="macName">设备名称</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="resourceId">资源ID</param>
        /// <param name="isSwitch">是否允许前台切换工序： 0：否  、1：是</param>
        /// <param name="remark">备注</param>
        public ESOPMacInfo(Int32 eSOPMacId, String mAC, String macName, Int32 stationId,
            Int32 resourceId, Boolean isSwitch, String remark)
        {
            this.eSOPMacId = eSOPMacId;
            this.mAC = mAC;
            this.macName = macName;
            this.stationId = stationId;
            this.resourceId = resourceId;
            this.isSwitch = isSwitch;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ESOPMacId
        {
            get { return this.eSOPMacId; }
            set { this.eSOPMacId = value; }
        }

        /// <summary>
        /// 获取或设置机器MAC地址
        /// </summary>
        public String MAC
        {
            get { return this.mAC; }
            set { this.mAC = value; }
        }

        /// <summary>
        /// 获取或设置设备名称
        /// </summary>
        public String MacName
        {
            get { return this.macName; }
            set { this.macName = value; }
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
        /// 获取或设置资源ID
        /// </summary>
        public Int32 ResourceId
        {
            get { return this.resourceId; }
            set { this.resourceId = value; }
        }

        /// <summary>
        /// 获取或设置是否允许前台切换工序： 0：否  、1：是
        /// </summary>
        public Boolean IsSwitch
        {
            get { return this.isSwitch; }
            set { this.isSwitch = value; }
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
