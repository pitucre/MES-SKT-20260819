using System;

namespace SKT.LeanMES.Container.Model
{
    [Serializable]
    public class PackagingAttachmentOrderInfo
    {
        private Int32 pAOId;
        private Int32 prodOrderID;
        private Int32 itemId;
        private String description;
        private Decimal quantity;
        private Int32 status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PackagingAttachmentOrderInfo 类的新实例。
        /// </summary>
        public PackagingAttachmentOrderInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PackagingAttachmentOrderInfo 类的新实例。
        /// </summary>
        /// <param name="pAOId">主键</param>
        /// <param name="prodOrderID">工单ID</param>
        /// <param name="itemId">料ID</param>
        /// <param name="description">描述</param>
        /// <param name="quantity">数量</param>
        /// <param name="status">状态</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人 </param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public PackagingAttachmentOrderInfo(Int32 pAOId, Int32 prodOrderID, Int32 itemId, String description, 
            Decimal quantity, Int32 status, String createBy, DateTime createDateTime, String modifyBy, 
            DateTime modifyDateTime, String remark)
        {
            this.pAOId = pAOId;
            this.prodOrderID = prodOrderID;
            this.itemId = itemId;
            this.description = description;
            this.quantity = quantity;
            this.status = status;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置主键
        /// </summary>
        public Int32 PAOId
        {
            get { return this.pAOId; }
            set { this.pAOId = value; }
        }

        /// <summary>
        /// 获取或设置工单ID
        /// </summary>
        public Int32 ProdOrderID
        {
            get { return this.prodOrderID; }
            set { this.prodOrderID = value; }
        }

        /// <summary>
        /// 获取或设置料ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
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
        /// 获取或设置数量
        /// </summary>
        public Decimal Quantity
        {
            get { return this.quantity; }
            set { this.quantity = value; }
        }

        /// <summary>
        /// 获取或设置状态
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
        /// 工单号
        /// </summary>
        public string OrderNO { set; get; }
        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { set; get; }
        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { set; get; }
    }
}