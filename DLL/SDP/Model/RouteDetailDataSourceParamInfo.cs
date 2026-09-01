using System;

namespace SKT.LeanMES.SDP.Model
{
    [Serializable]
    public class RouteDetailDataSourceParamInfo
    {
        private Int32 routeDetailDataSourceParamID;
        private Int32 routeDetailDataSourceID;
        private String paramName;
        private String paramType;
        private String controlId;
        private String paramValue;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.RouteDetailDataSourceParamInfo 类的新实例。
        /// </summary>
        public RouteDetailDataSourceParamInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.RouteDetailDataSourceParamInfo 类的新实例。
        /// </summary>
        /// <param name="routeDetailDataSourceParamID"></param>
        /// <param name="routeDetailDataSourceID"></param>
        /// <param name="paramName"></param>
        /// <param name="paramType"></param>
        /// <param name="controlId"></param>
        /// <param name="paramValue"></param>
        public RouteDetailDataSourceParamInfo(Int32 routeDetailDataSourceParamID, Int32 routeDetailDataSourceID, String paramName, String paramType, 
            String controlId, String paramValue)
        {
            this.routeDetailDataSourceParamID = routeDetailDataSourceParamID;
            this.routeDetailDataSourceID = routeDetailDataSourceID;
            this.paramName = paramName;
            this.paramType = paramType;
            this.controlId = controlId;
            this.paramValue = paramValue;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 RouteDetailDataSourceParamID
        {
            get { return this.routeDetailDataSourceParamID; }
            set { this.routeDetailDataSourceParamID = value; }
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
        public String ParamName
        {
            get { return this.paramName; }
            set { this.paramName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ParamType
        {
            get { return this.paramType; }
            set { this.paramType = value; }
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
        public String ParamValue
        {
            get { return this.paramValue; }
            set { this.paramValue = value; }
        }
    }
}