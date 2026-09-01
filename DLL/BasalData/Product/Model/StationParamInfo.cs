using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class StationParamInfo
    {
        private Int32 stationParamId;
        private Int32 itemId;
        private Int32 stationId;
        private String paramName;
        private String paramValue;
        private Int32 paramSeq;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        private String itemName;
        private String station;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StationParamInfo 类的新实例。
        /// </summary>
        public StationParamInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StationParamInfo 类的新实例。
        /// </summary>
        /// <param name="stationParamId"></param>
        /// <param name="itemId">产品ID</param>
        /// <param name="stationId">工位ID</param>
        /// <param name="paramName">参数名称</param>
        /// <param name="paramValue">参数值</param>
        /// <param name="paramSeq">参数排序</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public StationParamInfo(Int32 stationParamId, Int32 itemId, Int32 stationId, String paramName, 
            String paramValue, Int32 paramSeq, String createBy, DateTime createDateTime, String modifyBy, 
            DateTime modifyDateTime,String itemName,String station)
        {
            this.stationParamId = stationParamId;
            this.itemId = itemId;
            this.stationId = stationId;
            this.paramName = paramName;
            this.paramValue = paramValue;
            this.paramSeq = paramSeq;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.itemName = itemName;
            this.station = station;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationParamId
        {
            get { return this.stationParamId; }
            set { this.stationParamId = value; }
        }

        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置工位ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置参数名称
        /// </summary>
        public String ParamName
        {
            get { return this.paramName; }
            set { this.paramName = value; }
        }

        /// <summary>
        /// 获取或设置参数值
        /// </summary>
        public String ParamValue
        {
            get { return this.paramValue; }
            set { this.paramValue = value; }
        }

        /// <summary>
        /// 获取或设置参数排序
        /// </summary>
        public Int32 ParamSeq
        {
            get { return this.paramSeq; }
            set { this.paramSeq = value; }
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
        /// <summary>
        /// 产品名称
        /// </summary>
        public String ItemName
        {
            get { return itemName; }
            set { itemName = value; }
        }
        /// <summary>
        /// 工位
        /// </summary>
        public String Station
        {
            get { return station; }
            set { station = value; }
        }
    }
}