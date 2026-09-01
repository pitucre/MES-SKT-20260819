using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class MaterialRequestMemberInfo
    {
        private Int32 materialRequestMemberId;
        private Int32 materialRequestId;
        private Int32 itemId;
        private Decimal requestQty;
        private Decimal responseQty;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialRequestMemberInfo 类的新实例。
        /// </summary>
        public MaterialRequestMemberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialRequestMemberInfo 类的新实例。
        /// </summary>
        /// <param name="materialRequestMemberId"></param>
        /// <param name="materialRequestId">领料单ID</param>
        /// <param name="itemId">物料ID</param>
        /// <param name="requestQty">请领数量</param>
        /// <param name="responseQty">实发数量</param>
        /// <param name="remark">备注</param>
        public MaterialRequestMemberInfo(Int32 materialRequestMemberId, Int32 materialRequestId, Int32 itemId, Decimal requestQty, 
            Decimal responseQty, String remark)
        {
            this.materialRequestMemberId = materialRequestMemberId;
            this.materialRequestId = materialRequestId;
            this.itemId = itemId;
            this.requestQty = requestQty;
            this.responseQty = responseQty;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MaterialRequestMemberId
        {
            get { return this.materialRequestMemberId; }
            set { this.materialRequestMemberId = value; }
        }

        /// <summary>
        /// 获取或设置领料单ID
        /// </summary>
        public Int32 MaterialRequestId
        {
            get { return this.materialRequestId; }
            set { this.materialRequestId = value; }
        }

        /// <summary>
        /// 获取或设置物料ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置请领数量
        /// </summary>
        public Decimal RequestQty
        {
            get { return this.requestQty; }
            set { this.requestQty = value; }
        }

        /// <summary>
        /// 获取或设置实发数量
        /// </summary>
        public Decimal ResponseQty
        {
            get { return this.responseQty; }
            set { this.responseQty = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}