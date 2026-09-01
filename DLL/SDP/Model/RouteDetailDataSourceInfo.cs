using System;

namespace SKT.LeanMES.SDP.Model
{
    [Serializable]
    public class RouteDetailDataSourceInfo
    {
        private Int32 routeDetailDataSourceID;
        private Int32 rd_ID;
        private Int32 routeId;
        private Int32 stationId;
        private Int32 dataSourceID;
        private String routeDetailDataSourceName;
        
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.RouteDetailDataSourceInfo 类的新实例。
        /// </summary>
        public RouteDetailDataSourceInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.RouteDetailDataSourceInfo 类的新实例。
        /// </summary>
        /// <param name="routeDetailDataSourceID"></param>
        /// <param name="routeId"></param>
        /// <param name="stationId"></param>
        /// <param name="dataSourceID"></param>
        /// <param name="routeDetailDataSourceName"></param>
        public RouteDetailDataSourceInfo(Int32 routeDetailDataSourceID, Int32 routeId, Int32 stationId, Int32 dataSourceID, 
            String routeDetailDataSourceName,Int32 rdId)
        {
            this.routeDetailDataSourceID = routeDetailDataSourceID;
            this.routeId = routeId;
            this.stationId = stationId;
            this.dataSourceID = dataSourceID;
            this.routeDetailDataSourceName = routeDetailDataSourceName;
            this.rd_ID = rdId;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 RouteDetailDataSourceID
        {
            get { return this.routeDetailDataSourceID; }
            set { this.routeDetailDataSourceID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 RouteId
        {
            get { return this.routeId; }
            set { this.routeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        public Int32 RDId
        {
            get { return this.rd_ID; }
            set { this.rd_ID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 DataSourceID
        {
            get { return this.dataSourceID; }
            set { this.dataSourceID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RouteDetailDataSourceName
        {
            get { return this.routeDetailDataSourceName; }
            set { this.routeDetailDataSourceName = value; }
        }
    }
}