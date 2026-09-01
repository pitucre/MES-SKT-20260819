using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class InspectionOrderMemberInfo
    {
        private Int32 iOMemberId;
        private Int32 iOrderId;
        private String serialNumber;
        private Int32 itemId;
        private Int32 qty;
        private String inspectionResult;
        private String dealResult;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionOrderMemberInfo 类的新实例。
        /// </summary>
        public InspectionOrderMemberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionOrderMemberInfo 类的新实例。
        /// </summary>
        /// <param name="iOMemberId"></param>
        /// <param name="iOrderId"></param>
        /// <param name="serialNumber">序列号</param>
        /// <param name="itemId">产品Id</param>
        /// <param name="qty"></param>
        /// <param name="inspectionResult">验检结果(与检验准标得出的结果暂时未用到)</param>
        /// <param name="dealResult">处理结果</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public InspectionOrderMemberInfo(Int32 iOMemberId, Int32 iOrderId, String serialNumber, Int32 itemId, 
            Int32 qty, String inspectionResult, String dealResult, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.iOMemberId = iOMemberId;
            this.iOrderId = iOrderId;
            this.serialNumber = serialNumber;
            this.itemId = itemId;
            this.qty = qty;
            this.inspectionResult = inspectionResult;
            this.dealResult = dealResult;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 IOMemberId
        {
            get { return this.iOMemberId; }
            set { this.iOMemberId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 IOrderId
        {
            get { return this.iOrderId; }
            set { this.iOrderId = value; }
        }

        /// <summary>
        /// 获取或设置序列号
        /// </summary>
        public String SerialNumber
        {
            get { return this.serialNumber; }
            set { this.serialNumber = value; }
        }

        /// <summary>
        /// 获取或设置产品Id
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置验检结果(与检验准标得出的结果暂时未用到)
        /// </summary>
        public String InspectionResult
        {
            get { return this.inspectionResult; }
            set { this.inspectionResult = value; }
        }

        /// <summary>
        /// 获取或设置处理结果
        /// </summary>
        public String DealResult
        {
            get { return this.dealResult; }
            set { this.dealResult = value; }
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
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}