using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class OrderParamInfo
    {
        private Int32 orderParamId;
        private String orderNo;
        private Int32 itemId;
        private Int32 stationId;
        private String paramName;
        private String paramValue;
        private Int32 paramSeq;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public string Station { get; set; }
        public string StationDesc { get; set; }
        public string ItemName { get; set; }
        public string ItemCode { get; set; }
        
        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.OrderParamInfo 类的新实例。
        /// </summary>
        public OrderParamInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.OrderParamInfo 类的新实例。
        /// </summary>
        /// <param name="orderParamId"></param>
        /// <param name="orderNo"></param>
        /// <param name="itemId"></param>
        /// <param name="stationId"></param>
        /// <param name="paramName"></param>
        /// <param name="paramValue"></param>
        /// <param name="paramSeq"></param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public OrderParamInfo(Int32 orderParamId, String orderNo, Int32 itemId, Int32 stationId, 
            String paramName, String paramValue, Int32 paramSeq, String remark, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.orderParamId = orderParamId;
            this.orderNo = orderNo;
            this.itemId = itemId;
            this.stationId = stationId;
            this.paramName = paramName;
            this.paramValue = paramValue;
            this.paramSeq = paramSeq;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 OrderParamId
        {
            get { return this.orderParamId; }
            set { this.orderParamId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String OrderNo
        {
            get { return this.orderNo; }
            set { this.orderNo = value; }
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
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
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
        public String ParamValue
        {
            get { return this.paramValue; }
            set { this.paramValue = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ParamSeq
        {
            get { return this.paramSeq; }
            set { this.paramSeq = value; }
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