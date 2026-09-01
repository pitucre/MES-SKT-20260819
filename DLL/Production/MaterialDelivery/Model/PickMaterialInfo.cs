using System;

namespace SKT.LeanMES.MaterialDelivery.Model
{
    [Serializable]
    public class PickMaterialInfo
    {
        private Int32 pickId;
        private String pickCode;
        private Int32 lineId;
        private Int32 orderId;
        private Int32 flag;
        private Decimal qty;
        private Int32 status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        

        private String lineName;
        private String orderNo;
        public String EdgeName { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.PickMaterialInfo 类的新实例。
        /// </summary>
        public PickMaterialInfo()
        {
        }
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.PickMaterialInfo 类的新实例。
        /// </summary>
        /// <param name="pickId"></param>
        /// <param name="pickCode"></param>
        /// <param name="lineId"></param>
        /// <param name="orderId"></param>
        /// <param name="flag"></param>
        /// <param name="qty"></param>
        /// <param name="status"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public PickMaterialInfo(Int32 pickId, String pickCode, Int32 lineId, Int32 orderId, Int32 flag,Decimal qty,Int32 status,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.pickId = pickId;
            this.pickCode = pickCode;
            this.lineId = lineId;
            this.orderId = orderId;
            this.flag = flag;
            this.qty = qty;
            this.status = status;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置主键编号
        /// </summary>
        public Int32 PickId
        {
            get { return this.pickId; }
            set { this.pickId = value; }
        }

        /// <summary>
        /// 获取或设置分捡单号
        /// </summary>
        public String PickCode
        {
            get { return this.pickCode; }
            set { this.pickCode = value; }
        }

        /// <summary>
        /// 获取或设置线别
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置工单
        /// </summary>
        public Int32 OrderId
        {
            get { return this.orderId; }
            set { this.orderId = value; }
        }
        /// <summary>
        /// 是否已发料，0为未发，1为已发，默认为0
        /// </summary>
        public Int32 Flag
        {
            get { return this.flag; }
            set { this.flag = value; }
        }
        /// <summary>
        /// 套数(即产线中的经济批值)
        /// </summary>
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }
        /// <summary>
        /// 叫料状态，1.正常，显示为绿色；2.急，显示为黄色；3.紧急，显示为红色
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
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
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置产线名
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }
        /// <summary>
        /// 工单号
        /// </summary>
        public String OrderNo
        {
            get { return this.orderNo; }
            set { this.orderNo = value; }
        }
    }
}