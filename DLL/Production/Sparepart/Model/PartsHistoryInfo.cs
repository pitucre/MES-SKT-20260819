using System;

namespace SKT.LeanMES.Sparepart.Model
{
    [Serializable]
    public class PartsHistoryInfo
    {
        private Int32 partsHistoryId;
        private Int32 partID;
        private Int32 operateType;
        private Decimal quantity;
        private Int32 outOrIn;
        private String requestor;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PartsHistoryInfo 类的新实例。
        /// </summary>
        public PartsHistoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PartsHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="partsHistoryId">出入库历史编号</param>
        /// <param name="partID">备件编号</param>
        /// <param name="operateType">操作类型,1为领用,2为维修,3为退货</param>
        /// <param name="quantity">数量</param>
        /// <param name="outOrIn"></param>
        /// <param name="requestor"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public PartsHistoryInfo(Int32 partsHistoryId, Int32 partID, Int32 operateType, Decimal quantity,
            Int32 outOrIn, String requestor, String createBy, DateTime createDateTime, String modifyBy,
            DateTime modifyDateTime, String remark)
        {
            this.partsHistoryId = partsHistoryId;
            this.partID = partID;
            this.operateType = operateType;
            this.quantity = quantity;
            this.outOrIn = outOrIn;
            this.requestor = requestor;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置出入库历史编号
        /// </summary>
        public Int32 PartsHistoryId
        {
            get { return this.partsHistoryId; }
            set { this.partsHistoryId = value; }
        }

        /// <summary>
        /// 获取或设置备件编号
        /// </summary>
        public Int32 PartID
        {
            get { return this.partID; }
            set { this.partID = value; }
        }

        /// <summary>
        /// 获取或设置操作类型,1为领用,2为维修,3为退货
        /// </summary>
        public Int32 OperateType
        {
            get { return this.operateType; }
            set { this.operateType = value; }
        }

        /// <summary>
        /// 获取或设置数量
        /// </summary>
        public Decimal Quantity
        {
            get { return this.quantity; }
            set { this.quantity = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 OutOrIn
        {
            get { return this.outOrIn; }
            set { this.outOrIn = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Requestor
        {
            get { return this.requestor; }
            set { this.requestor = value; }
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
        /// 部门Id
        /// </summary>
        public int DeparmentId { get; set; }
    }
}