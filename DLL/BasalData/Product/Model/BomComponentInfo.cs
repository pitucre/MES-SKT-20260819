using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class BomComponentInfo
    {
        private Int32 bomComponentId;
        private Int32 bomId;
        private Double assSequence;
        private Int32 itemID;
        private Int32 assOperationID;
        private String refDes;
        private String pOLine;
        private Double compCount;
        private Int32 dataTypeID;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String itemName;
        private String operationName;
        private String dataTypeName;

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.BomComponentInfo 类的新实例。
        /// </summary>
        public BomComponentInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.BomComponentInfo 类的新实例。
        /// </summary>
        /// <param name="bomComponentId">BOM Component Unique Identifier</param>
        /// <param name="bomId">BOM.BomComponentId。</param>
        /// <param name="assSequence">组装或者添加的顺序。</param>
        /// <param name="itemID">元件或者子板对应Item的ID，Item.ItemID</param>
        /// <param name="assOperationID">操作工位ID。Operation.OperID</param>
        /// <param name="refDes">元件位置。</param>
        /// <param name="pOLine">对应客户PO的Line Number</param>
        /// <param name="compCount">该元件或者子板需组装的数量。</param>
        /// <param name="dataTypeID">元件或者子板组装时选定的数据类型ID。DATA_TYPE.TID</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        /// <param name="remark">备注。</param>
        public BomComponentInfo(Int32 bomComponentId, Int32 bomId, Double assSequence, Int32 itemID, 
            Int32 assOperationID, String refDes, String pOLine, Double compCount, Int32 dataTypeID, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.bomComponentId = bomComponentId;
            this.bomId = bomId;
            this.assSequence = assSequence;
            this.itemID = itemID;
            this.assOperationID = assOperationID;
            this.refDes = refDes;
            this.pOLine = pOLine;
            this.compCount = compCount;
            this.dataTypeID = dataTypeID;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置BOM Component Unique Identifier
        /// </summary>
        public Int32 BomComponentId
        {
            get { return this.bomComponentId; }
            set { this.bomComponentId = value; }
        }

        /// <summary>
        /// 获取或设置BOM.BomComponentId。
        /// </summary>
        public Int32 BomId
        {
            get { return this.bomId; }
            set { this.bomId = value; }
        }

        /// <summary>
        /// 获取或设置组装或者添加的顺序。
        /// </summary>
        public Double AssSequence
        {
            get { return this.assSequence; }
            set { this.assSequence = value; }
        }

        /// <summary>
        /// 获取或设置元件或者子板对应Item的ID，Item.ItemID
        /// </summary>
        public Int32 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置操作工位ID。Operation.OperID
        /// </summary>
        public Int32 AssOperationID
        {
            get { return this.assOperationID; }
            set { this.assOperationID = value; }
        }

        /// <summary>
        /// 获取或设置元件位置。
        /// </summary>
        public String RefDes
        {
            get { return this.refDes; }
            set { this.refDes = value; }
        }

        /// <summary>
        /// 获取或设置对应客户PO的Line Number
        /// </summary>
        public String POLine
        {
            get { return this.pOLine; }
            set { this.pOLine = value; }
        }

        /// <summary>
        /// 获取或设置该元件或者子板需组装的数量。
        /// </summary>
        public Double CompCount
        {
            get { return this.compCount; }
            set { this.compCount = value; }
        }

        /// <summary>
        /// 获取或设置元件或者子板组装时选定的数据类型ID。DATA_TYPE.TID
        /// </summary>
        public Int32 DataTypeID
        {
            get { return this.dataTypeID; }
            set { this.dataTypeID = value; }
        }

        /// <summary>
        /// 获取或设置创建人。
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间。
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人。
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间。
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注。
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        public String OperationName
        {
            get { return this.operationName; }
            set { this.operationName = value; }
        }

        public String DataTypeName
        {
            get { return this.dataTypeName; }
            set { this.dataTypeName = value; }
        }

        private string itemCode;

        public string ItemCode
        {
            get { return itemCode; }
            set { itemCode = value; }
        }
        private string isMESadd;

        public string IsMESadd
        {
            get { return isMESadd; }
            set { isMESadd = value; }
        }

    }
}