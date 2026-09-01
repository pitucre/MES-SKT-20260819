using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Station.Model
{
    [Serializable]
    public class StationTestCountInfo
    {
        private Int32 stationTestCountId;
        private Int32 stationId;
        private String station;
        private Int32 maxTestCount;
        private String description;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private Int32 itemId;
        private Int32  maxpassTimes;
        private Int32 maxfailTimes;
        private String itemCode;


        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StationTestCountInfo 类的新实例。
        /// </summary>
        public StationTestCountInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StationTestCountInfo 类的新实例。
        /// </summary>
        /// <param name="stationTestCountId"></param>
        /// <param name="stationId">工序ID</param>
        /// <param name="maxTestCount">最大测试次数</param>
        public StationTestCountInfo(Int32 stationTestCountId, Int32 stationId, Int32 maxTestCount,
            String description, String createBy, String modifyBy)
        {
            this.stationTestCountId = stationTestCountId;
            this.stationId = stationId;
            this.maxTestCount = maxTestCount;
            this.description = description;
            this.createBy = createBy;
            this.modifyBy = modifyBy;
        }


        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MaxPassTimes
        {
            get { return this.maxpassTimes; }
            set { this.maxpassTimes = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MaxFailTimes
        {
            get { return this.maxfailTimes; }
            set { this.maxfailTimes = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationTestCountId
        {
            get { return this.stationTestCountId; }
            set { this.stationTestCountId = value; }
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
        /// 获取或设置工序
        /// </summary>
        public String Station
        {
            get { return this.station; }
            set { this.station = value; }
        }

        /// <summary>
        /// 获取或设置最大测试次数
        /// </summary>
        public Int32 MaxTestCount
        {
            get { return this.maxTestCount; }
            set { this.maxTestCount = value; }
        }

        /// <summary>
        /// 获取或设置描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
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
    }
}
