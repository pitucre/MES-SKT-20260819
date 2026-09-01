using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class DeliverInfo
    {
        private Int32 deliverId;
        private String deliverNo;
        private String venderNo;
        private Int32 deliState;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.DeliverInfo 类的新实例。
        /// </summary>
        public DeliverInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.DeliverInfo 类的新实例。
        /// </summary>
        /// <param name="deliverId">送货单ID</param>
        /// <param name="deliverNo">送货单号</param>
        /// <param name="venderNo">供应商编号</param>
        /// <param name="deliState">送货单状态--0-草稿夹，1-送出，2-收货，3-作废</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public DeliverInfo(Int32 deliverId, String deliverNo, String venderNo, Int32 deliState, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.deliverId = deliverId;
            this.deliverNo = deliverNo;
            this.venderNo = venderNo;
            this.deliState = deliState;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置送货单ID
        /// </summary>
        public Int32 DeliverId
        {
            get { return this.deliverId; }
            set { this.deliverId = value; }
        }

        /// <summary>
        /// 获取或设置送货单号
        /// </summary>
        public String DeliverNo
        {
            get { return this.deliverNo; }
            set { this.deliverNo = value; }
        }

        /// <summary>
        /// 获取或设置供应商编号
        /// </summary>
        public String VenderNo
        {
            get { return this.venderNo; }
            set { this.venderNo = value; }
        }

        /// <summary>
        /// 获取或设置送货单状态--0-草稿夹，1-送出，2-收货，3-作废
        /// </summary>
        public Int32 DeliState
        {
            get { return this.deliState; }
            set { this.deliState = value; }
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
        /// <summary>
        /// 送或项Json字串
        /// </summary>
        public string tbDtl { get; set; }

        /// <summary>
        /// GRBJson字串
        /// </summary>
        public string tbGRNDtl { get; set; }
    }
}