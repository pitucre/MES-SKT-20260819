using System;

namespace SKT.LeanMES.Container.Model
{
    [Serializable]
    public class DIPPackagingPlanInfo
    {
        private Int32 dPPId;
        private Int32 fid;
        private Int32 lineId;
        private Int32 orderId;
        private String orderNO;
        private Int32 itemId;
        private String itemCode;
        private String itemDes;
        private Int32 planQty;
        private DateTime planDatiTime;
        private Int32 status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.DIPPackagingPlanInfo 类的新实例。
        /// </summary>
        public DIPPackagingPlanInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.DIPPackagingPlanInfo 类的新实例。
        /// </summary>
        /// <param name="dPPId">主键</param>
        /// <param name="fid">楼层Id</param>
        /// <param name="lineId">线体Id</param>
        /// <param name="orderId">工单Id</param>
        /// <param name="orderNO">工单</param>
        /// <param name="itemId">料ID</param>
        /// <param name="itemCode">料号</param>
        /// <param name="itemDes">产品描述</param>
        /// <param name="planQty">计划生产数据</param>
        /// <param name="planDatiTime">计划时间</param>
        /// <param name="status">状态</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark"></param>
        public DIPPackagingPlanInfo(Int32 dPPId, Int32 fid, Int32 lineId, Int32 orderId, 
            String orderNO, Int32 itemId, String itemCode, String itemDes, Int32 planQty, 
            DateTime planDatiTime, Int32 status, String createBy, DateTime createDateTime, String modifyBy, 
            DateTime modifyDateTime, String remark)
        {
            this.dPPId = dPPId;
            this.fid = fid;
            this.lineId = lineId;
            this.orderId = orderId;
            this.orderNO = orderNO;
            this.itemId = itemId;
            this.itemCode = itemCode;
            this.itemDes = itemDes;
            this.planQty = planQty;
            this.planDatiTime = planDatiTime;
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
        public Int32 DPPId
        {
            get { return this.dPPId; }
            set { this.dPPId = value; }
        }

        /// <summary>
        /// 获取或设置楼层Id
        /// </summary>
        public Int32 Fid
        {
            get { return this.fid; }
            set { this.fid = value; }
        }

        /// <summary>
        /// 获取或设置线体Id
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置工单Id
        /// </summary>
        public Int32 OrderId
        {
            get { return this.orderId; }
            set { this.orderId = value; }
        }

        /// <summary>
        /// 获取或设置工单
        /// </summary>
        public String OrderNO
        {
            get { return this.orderNO; }
            set { this.orderNO = value; }
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
        /// 获取或设置料号
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 获取或设置产品描述
        /// </summary>
        public String ItemDes
        {
            get { return this.itemDes; }
            set { this.itemDes = value; }
        }

        /// <summary>
        /// 获取或设置计划生产数据
        /// </summary>
        public Int32 PlanQty
        {
            get { return this.planQty; }
            set { this.planQty = value; }
        }

        /// <summary>
        /// 获取或设置计划时间
        /// </summary>
        public DateTime PlanDatiTime
        {
            get { return this.planDatiTime; }
            set { this.planDatiTime = value; }
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
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        /// <summary>
        /// 楼层名
        /// </summary>
        public string FName { set; get; }
        /// <summary>
        /// 产品名
        /// </summary>
        public string ItemName { set; get; }

        public string LineName { set; get; }
    }
}