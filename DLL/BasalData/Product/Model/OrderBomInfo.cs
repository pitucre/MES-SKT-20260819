using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class OrderBomInfo
    {
        private dynamic orderBomID;
        private dynamic orderNo;
        private dynamic assSequence;
        private dynamic itemID;
        private dynamic assOperationID;
        private dynamic refDes;
        private dynamic compCount;
        private dynamic perNum;
        private dynamic dataTypeID;
        private dynamic isReplacement;
        private dynamic isCustomize;
        private dynamic customID;
        private dynamic createBy;
        private dynamic createDateTime;
        private dynamic modifyBy;
        private dynamic modifyDateTime;
        private dynamic remark;
        public dynamic ItemCode { get; set; }
        public dynamic ItemName { get; set; }
        public dynamic UnitType { get; set; }
        public dynamic CustName { get; set; }
        public dynamic CustCode { get; set; }
        public dynamic Operation { get; set; }
        public dynamic DataTypeName { get; set; }
        public int TotalNum { get; set; }
        public int EndNum { get; set; }
        public int SumOutNum { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.OrderBomInfo 类的新实例。
        /// </summary>
        public OrderBomInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.OrderBomInfo 类的新实例。
        /// </summary>
        /// <param name="rID"></param>
        /// <param name="orderNo">工单</param>
        /// <param name="assSequence">物料排序</param>
        /// <param name="itemID">物料ID</param>
        /// <param name="assOperationID">操作工位ID</param>
        /// <param name="refDes">物料位置</param>
        /// <param name="compCount">需要数量</param>
        /// <param name="perNum">每次用量</param>
        /// <param name="dataTypeID">数据类型ID</param>
        /// <param name="isReplacement">是否为替代料</param>
        /// <param name="isCustomize">是否客户指定用料</param>
        /// <param name="customID">客户指定用料时客户ID</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        /// <param name="isMESadd"></param>
        public OrderBomInfo(Int32 orderBomID, String orderNo, float assSequence, Int32 itemID, 
            Int32 assOperationID, String refDes, Double compCount, Double perNum, Int32 dataTypeID, 
            Boolean isReplacement, Boolean isCustomize, Int32 customID, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.orderBomID = orderBomID;
            this.orderNo = orderNo;
            this.assSequence = assSequence;
            this.itemID = itemID;
            this.assOperationID = assOperationID;
            this.refDes = refDes;
            this.compCount = compCount;
            this.perNum = perNum;
            this.dataTypeID = dataTypeID;
            this.isReplacement = isReplacement;
            this.isCustomize = isCustomize;
            this.customID = customID;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public dynamic OrderBomID
        {
            get { return this.orderBomID; }
            set { this.orderBomID = value; }
        }

        /// <summary>
        /// 获取或设置工单
        /// </summary>
        public dynamic OrderNo
        {
            get { return this.orderNo; }
            set { this.orderNo = value; }
        }

        /// <summary>
        /// 获取或设置物料排序
        /// </summary>
        public dynamic AssSequence
        {
            get { return this.assSequence; }
            set { this.assSequence = value; }
        }

        /// <summary>
        /// 获取或设置物料ID
        /// </summary>
        public dynamic ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置操作工位ID
        /// </summary>
        public dynamic AssOperationID
        {
            get { return this.assOperationID; }
            set { this.assOperationID = value; }
        }

        /// <summary>
        /// 获取或设置物料位置
        /// </summary>
        public dynamic RefDes
        {
            get { return this.refDes; }
            set { this.refDes = value; }
        }

        /// <summary>
        /// 获取或设置需要数量
        /// </summary>
        public dynamic CompCount
        {
            get { return this.compCount; }
            set { this.compCount = value; }
        }

        /// <summary>
        /// 获取或设置每次用量
        /// </summary>
        public dynamic PerNum
        {
            get { return this.perNum; }
            set { this.perNum = value; }
        }

        /// <summary>
        /// 获取或设置数据类型ID
        /// </summary>
        public dynamic DataTypeID
        {
            get { return this.dataTypeID; }
            set { this.dataTypeID = value; }
        }

        /// <summary>
        /// 获取或设置是否为替代料
        /// </summary>
        public dynamic IsReplacement
        {
            get { return this.isReplacement; }
            set { this.isReplacement = value; }
        }

        /// <summary>
        /// 获取或设置是否客户指定用料
        /// </summary>
        public dynamic IsCustomize
        {
            get { return this.isCustomize; }
            set { this.isCustomize = value; }
        }

        /// <summary>
        /// 获取或设置客户指定用料时客户ID
        /// </summary>
        public dynamic CustomID
        {
            get { return this.customID; }
            set { this.customID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public dynamic CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public dynamic CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public dynamic ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public dynamic ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public dynamic Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }


    }
}