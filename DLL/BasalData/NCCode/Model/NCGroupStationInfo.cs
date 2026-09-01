using System;

namespace SKT.LeanMES.NCCode.Model
{
    [Serializable]
    public class NCGroupStationInfo
    {
        private Int32 nCGroupStationId;
        private Int32 stationId;
        private Int32 nCGroupId;
        private string stationName;
        private string groupName;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.NCGroupStationInfo 类的新实例。
        /// </summary>
        public NCGroupStationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.NCGroupStationInfo 类的新实例。
        /// </summary>
        /// <param name="nCGroupStationId">Unique Identifier</param>
        /// <param name="stationId">工位表ID</param>
        /// <param name="nCGroupId">不良代码组ID</param>
        public NCGroupStationInfo(Int32 nCGroupStationId, Int32 stationId, Int32 nCGroupId)
        {
            this.nCGroupStationId = nCGroupStationId;
            this.stationId = stationId;
            this.nCGroupId = nCGroupId;
        }

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 NCGroupStationId
        {
            get { return this.nCGroupStationId; }
            set { this.nCGroupStationId = value; }
        }

        /// <summary>
        /// 获取或设置工位表ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置不良代码组ID
        /// </summary>
        public Int32 NCGroupId
        {
            get { return this.nCGroupId; }
            set { this.nCGroupId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string GroupName
        {
            get { return this.groupName; }
            set { this.groupName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string StationName
        {
            get { return this.stationName; }
            set { this.stationName = value; }
        }
    }
}