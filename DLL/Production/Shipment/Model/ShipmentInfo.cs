using System;

namespace SKT.LeanMES.Shipment.Model
{
    [Serializable]
    public class ShipmentInfo
    {
        private Int32 shipmentId;
        private String orderNO;
        private Int32 itemId;
        private Decimal qty;
        private DateTime shipDate;
        private Byte state;
        private String remark;
        private String auditBy;
        private DateTime auditDateTime;
        private String rejectBy;
        private DateTime rejectDateTime;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ShipmentInfo 类的新实例。
        /// </summary>
        public ShipmentInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ShipmentInfo 类的新实例。
        /// </summary>
        /// <param name="shipmentId"></param>
        /// <param name="orderNO">订单号</param>
        /// <param name="itemId">产品</param>
        /// <param name="qty">订单数量</param>
        /// <param name="shipDate">发货日期</param>
        /// <param name="state">状态(1：未审核  2：已审核  3：已发货)</param>
        /// <param name="remark"></param>
        /// <param name="auditBy">审核人</param>
        /// <param name="auditDateTime">审核时间</param>
        /// <param name="rejectBy">弃审人</param>
        /// <param name="rejectDateTime">弃审时间</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public ShipmentInfo(Int32 shipmentId, String orderNO, Int32 itemId, Decimal qty, 
            DateTime shipDate, Byte state, String remark, String auditBy, DateTime auditDateTime, 
            String rejectBy, DateTime rejectDateTime, String createBy, DateTime createDateTime, String modifyBy, 
            DateTime modifyDateTime)
        {
            this.shipmentId = shipmentId;
            this.orderNO = orderNO;
            this.itemId = itemId;
            this.qty = qty;
            this.shipDate = shipDate;
            this.state = state;
            this.remark = remark;
            this.auditBy = auditBy;
            this.auditDateTime = auditDateTime;
            this.rejectBy = rejectBy;
            this.rejectDateTime = rejectDateTime;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ShipmentId
        {
            get { return this.shipmentId; }
            set { this.shipmentId = value; }
        }

        /// <summary>
        /// 获取或设置订单号
        /// </summary>
        public String OrderNO
        {
            get { return this.orderNO; }
            set { this.orderNO = value; }
        }

        /// <summary>
        /// 获取或设置产品
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置订单数量
        /// </summary>
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }
        public string QtyStr { get; set; }

        /// <summary>
        /// 获取或设置发货日期
        /// </summary>
        public DateTime ShipDate
        {
            get { return this.shipDate; }
            set { this.shipDate = value; }
        }

        /// <summary>
        /// 获取或设置状态(1：未审核  2：已审核  3：已发货)
        /// </summary>
        public Byte State
        {
            get { return this.state; }
            set { this.state = value; }
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
        /// 获取或设置审核人
        /// </summary>
        public String AuditBy
        {
            get { return this.auditBy; }
            set { this.auditBy = value; }
        }

        /// <summary>
        /// 获取或设置审核时间
        /// </summary>
        public DateTime AuditDateTime
        {
            get { return this.auditDateTime; }
            set { this.auditDateTime = value; }
        }

        /// <summary>
        /// 获取或设置弃审人
        /// </summary>
        public String RejectBy
        {
            get { return this.rejectBy; }
            set { this.rejectBy = value; }
        }

        /// <summary>
        /// 获取或设置弃审时间
        /// </summary>
        public DateTime RejectDateTime
        {
            get { return this.rejectDateTime; }
            set { this.rejectDateTime = value; }
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

        public string ShipDateStr { get; set; }
    }
}