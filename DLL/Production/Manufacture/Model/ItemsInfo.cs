using System;

namespace SKT.LeanMES.Manufacture.Model
{
    [Serializable]
    public class ItemsInfo
    {
        private Int32 itemID;
        private String itemName;
        private String itemRev;
        private String description;
        private String cPN;
        private Int32 customerID;
        private String cPR;
        private Int32 status;
        private Int32 projectID;
        private Int32 itemType;
        private Int32 routerID;
        private Int32 bOMID;
        private Double lotSize;
        private Double maxUsageAsComp;
        private Int32 qtyRestriction;
        private Double qtyMultiplier;
        private Boolean isCurrentRev;
        private Boolean isPanel;
        private Boolean isCPSFC;
        private Boolean isRoHS;
        private Int32 dCOAssembly;
        private Int32 dCORemoval;
        private Int32 dCOInveRec;
        private Boolean recInveWhenAss;
        private Int32 vMGroup;
        private Boolean trackableComp;
        private Int32 itemGroupID;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private string projectName;
        private string customerName;
        private string routerName;
        private string bomName;
        private string dataTypeName;

        private string itemType_Choose;
        private string itemStatus_Choose;

        private string itemGroupName;
        private string insertUserName;
        private string removeUserName;
        private string insertOperation;
        private string removeOperation;
        private string insertTime;
        private string removeTime;
        private bool isRemoved;

        private string itemGroupDesc;

        private Int32 parentNumber;
        private Int32 childrenNumber;
        private String itemCode;

        //add by wenshun,显示的物料历史信息中增加物料的LotCode，DateCode
        private string lotCode;
        private string dateCode;

        private String partsNO;
        private String newPartsNO;
        private String newItemName;
        private String grn;

        // add hongqing wang 2015-6-25
        private String iqcBatchNO;
        private Decimal qty;

        //add by wenshun.wang 2017-04-19
        private string serialNumber;
        private string vendorName;
        public string CreateTimeStr  { get; set; }
        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.ITEMInfo 类的新实例。
        /// </summary>
        public ItemsInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.ITEMInfo 类的新实例。
        /// </summary>
        /// <param name="itemID"></param>
        /// <param name="itemName">产品名称。</param>
        /// <param name="itemRev">产品版本。</param>
        /// <param name="description">产品描述。</param>
        /// <param name="cPN">客户料号。</param>
        /// <param name="customerID">客户</param>
        /// <param name="cPR">客户料号版本。</param>
        /// <param name="status">产品状态。</param>
        /// <param name="projectID">项目ID。</param>
        /// <param name="itemType">产品类型。</param>
        /// <param name="routerID">路由ID。</param>
        /// <param name="bOMID">BOM ID。</param>
        /// <param name="lotSize"></param>
        /// <param name="maxUsageAsComp"></param>
        /// <param name="qtyRestriction"></param>
        /// <param name="qtyMultiplier"></param>
        /// <param name="isCurrentRev">是否当前版本。</param>
        /// <param name="isPanel">是否是拼版。</param>
        /// <param name="isCPSFC">是否是客户提供SFC。</param>
        /// <param name="isRoHS">是否通过无铅认证。</param>
        /// <param name="dCOAssembly">组装收集的数据</param>
        /// <param name="dCORemoval">移除时收集数据。</param>
        /// <param name="dCOInveRec">收货时收集数据</param>
        /// <param name="recInveWhenAss">组装时做收录。</param>
        /// <param name="vMGroup">验证规则</param>
        /// <param name="trackableComp">是否是可追踪组件。</param>
        /// <param name="itemGroupID">产品组ID</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        /// <param name="remark">备注。</param>
        public ItemsInfo(Int32 itemID, String itemName, String itemRev, String description, 
            String cPN, Int32 customerID, String cPR, Int32 status, Int32 projectID, 
            Int32 itemType, Int32 routerID, Int32 bOMID, Double lotSize, Double maxUsageAsComp, 
            Int32 qtyRestriction, Double qtyMultiplier, Boolean isCurrentRev, Boolean isPanel, Boolean isCPSFC, 
            Boolean isRoHS, Int32 dCOAssembly, Int32 dCORemoval, Int32 dCOInveRec, Boolean recInveWhenAss, 
            Int32 vMGroup, Boolean trackableComp, Int32 itemGroupID, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.itemID = itemID;
            this.itemName = itemName;
            this.itemRev = itemRev;
            this.description = description;
            this.cPN = cPN;
            this.customerID = customerID;
            this.cPR = cPR;
            this.status = status;
            this.projectID = projectID;
            this.itemType = itemType;
            this.routerID = routerID;
            this.bOMID = bOMID;
            this.lotSize = lotSize;
            this.maxUsageAsComp = maxUsageAsComp;
            this.qtyRestriction = qtyRestriction;
            this.qtyMultiplier = qtyMultiplier;
            this.isCurrentRev = isCurrentRev;
            this.isPanel = isPanel;
            this.isCPSFC = isCPSFC;
            this.isRoHS = isRoHS;
            this.dCOAssembly = dCOAssembly;
            this.dCORemoval = dCORemoval;
            this.dCOInveRec = dCOInveRec;
            this.recInveWhenAss = recInveWhenAss;
            this.vMGroup = vMGroup;
            this.trackableComp = trackableComp;
            this.itemGroupID = itemGroupID;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置产品名称。
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 获取或设置产品版本。
        /// </summary>
        public String ItemRev
        {
            get { return this.itemRev; }
            set { this.itemRev = value; }
        }

        /// <summary>
        /// 获取或设置产品描述。
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置客户料号。
        /// </summary>
        public String CPN
        {
            get { return this.cPN; }
            set { this.cPN = value; }
        }

        /// <summary>
        /// 获取或设置客户
        /// </summary>
        public Int32 CustomerID
        {
            get { return this.customerID; }
            set { this.customerID = value; }
        }

        /// <summary>
        /// 获取或设置客户料号版本。
        /// </summary>
        public String CPR
        {
            get { return this.cPR; }
            set { this.cPR = value; }
        }

        /// <summary>
        /// 获取或设置产品状态。
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置项目ID。
        /// </summary>
        public Int32 ProjectID
        {
            get { return this.projectID; }
            set { this.projectID = value; }
        }

        /// <summary>
        /// 获取或设置产品类型。
        /// </summary>
        public Int32 ItemType
        {
            get { return this.itemType; }
            set { this.itemType = value; }
        }

        /// <summary>
        /// 获取或设置路由ID。
        /// </summary>
        public Int32 RouterID
        {
            get { return this.routerID; }
            set { this.routerID = value; }
        }

        /// <summary>
        /// 获取或设置BOM ID。
        /// </summary>
        public Int32 BOMID
        {
            get { return this.bOMID; }
            set { this.bOMID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double LotSize
        {
            get { return this.lotSize; }
            set { this.lotSize = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double MaxUsageAsComp
        {
            get { return this.maxUsageAsComp; }
            set { this.maxUsageAsComp = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 QtyRestriction
        {
            get { return this.qtyRestriction; }
            set { this.qtyRestriction = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double QtyMultiplier
        {
            get { return this.qtyMultiplier; }
            set { this.qtyMultiplier = value; }
        }

        /// <summary>
        /// 获取或设置是否当前版本。
        /// </summary>
        public Boolean IsCurrentRev
        {
            get { return this.isCurrentRev; }
            set { this.isCurrentRev = value; }
        }

        /// <summary>
        /// 获取或设置是否是拼版。
        /// </summary>
        public Boolean IsPanel
        {
            get { return this.isPanel; }
            set { this.isPanel = value; }
        }

        /// <summary>
        /// 获取或设置是否是客户提供SFC。
        /// </summary>
        public Boolean IsCPSFC
        {
            get { return this.isCPSFC; }
            set { this.isCPSFC = value; }
        }

        /// <summary>
        /// 获取或设置是否通过无铅认证。
        /// </summary>
        public Boolean IsRoHS
        {
            get { return this.isRoHS; }
            set { this.isRoHS = value; }
        }

        /// <summary>
        /// 获取或设置组装收集的数据
        /// </summary>
        public Int32 DCOAssembly
        {
            get { return this.dCOAssembly; }
            set { this.dCOAssembly = value; }
        }

        /// <summary>
        /// 获取或设置移除时收集数据。
        /// </summary>
        public Int32 DCORemoval
        {
            get { return this.dCORemoval; }
            set { this.dCORemoval = value; }
        }

        /// <summary>
        /// 获取或设置收货时收集数据
        /// </summary>
        public Int32 DCOInveRec
        {
            get { return this.dCOInveRec; }
            set { this.dCOInveRec = value; }
        }

        /// <summary>
        /// 获取或设置组装时做收录。
        /// </summary>
        public Boolean RecInveWhenAss
        {
            get { return this.recInveWhenAss; }
            set { this.recInveWhenAss = value; }
        }

        /// <summary>
        /// 获取或设置验证规则
        /// </summary>
        public Int32 VMGroup
        {
            get { return this.vMGroup; }
            set { this.vMGroup = value; }
        }

        /// <summary>
        /// 获取或设置是否是可追踪组件。
        /// </summary>
        public Boolean TrackableComp
        {
            get { return this.trackableComp; }
            set { this.trackableComp = value; }
        }

        /// <summary>
        /// 获取或设置产品组ID
        /// </summary>
        public Int32 ItemGroupID
        {
            get { return this.itemGroupID; }
            set { this.itemGroupID = value; }
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

        public String ProjectName
        {
            get { return this.projectName; }
            set { this.projectName = value; }
        }

        public String CustomerName
        {
            get { return this.customerName; }
            set { this.customerName = value; }
        }

        public String RouterName
        {
            get { return this.routerName; }
            set { this.routerName = value; }
        }

        public String BomName
        {
            get { return this.bomName; }
            set { this.bomName = value; }
        }

        public String DataTypeName
        {
            get { return this.dataTypeName; }
            set { this.dataTypeName = value; }
        }

        public string ItemType_Choose
        {
            get { return itemType_Choose; }
            set { itemType_Choose = value; }
        }
        public string ItemStatus_Choose
        {
            get { return itemStatus_Choose; }
            set { itemStatus_Choose = value; }
        }


        /// <summary>
        /// 分组名
        /// </summary>
        public string ItemGroupName
        {
            get { return itemGroupName; }
            set { itemGroupName = value; }
        }

        /// <summary>
        /// 添加者
        /// </summary>
        public string InsertUserName
        {
            get { return insertUserName; }
            set { insertUserName = value; }
        }

        /// <summary>
        /// 移除者
        /// </summary>
        public string RemoveUserName
        {
            get { return removeUserName; }
            set { removeUserName = value; }
        }

        /// <summary>
        /// 添加工位
        /// </summary>
        public string InsertOperation
        {
            get { return insertOperation; }
            set { insertOperation = value; }
        }

        /// <summary>
        /// 移除工位
        /// </summary>
        public string RemoveOperation
        {
            get { return removeOperation; }
            set { removeOperation = value; }
        }

        /// <summary>
        /// 添加时间
        /// </summary>
        public string InsertTime
        {
            get { return insertTime; }
            set { insertTime = value; }
        }

        /// <summary>
        /// 移除时间
        /// </summary>
        public string RemoveTime
        {
            get { return removeTime; }
            set { removeTime = value; }
        }

        /// <summary>
        /// 是否移除
        /// </summary>
        public bool IsRemoved
        {
            get { return isRemoved; }
            set { isRemoved = value; }
        }

        /// <summary>
        /// 获取分组描述
        /// </summary>
        public string ItemGroupDesc
        {
            get { return itemGroupDesc; }
            set { itemGroupDesc = value; }
        }
        /// <summary>
        /// 拼版数目
        /// </summary>
        public Int32 ParentNumber
        {
            get { return parentNumber; }
            set { parentNumber = value; }
        }
        /// <summary>
        /// 子板个数
        /// </summary>
        public Int32 ChildrenNumber
        {
            get { return childrenNumber; }
            set { childrenNumber = value; }
        }

        /// <summary>
        /// 产品编码
        /// </summary>
        public String ItemCode
        {
            get { return itemCode; }
            set { itemCode = value; }
        }

        /// <summary>
        /// 批次号
        /// </summary>
        public string LotCode
        {
            get { return lotCode; }
            set { lotCode = value; }
        }

        /// <summary>
        /// 生产日期
        /// </summary>
        public string DateCode
        {
            get { return dateCode; }
            set { dateCode = value; }
        }

        /// <summary>
        /// 部件编码
        /// </summary>
        public String PartsNO
        {
            get { return partsNO; }
            set { partsNO = value; }
        }

        /// <summary>
        /// 新部件编码
        /// </summary>
        public String NewPartsNO
        {
            get { return newPartsNO; }
            set { newPartsNO = value; }
        }

        /// <summary>
        /// 新部件名
        /// </summary>
        public String NewItemName
        {
            get { return newItemName; }
            set { newItemName = value; }
        }

        /// <summary>
        /// 部件所属GRN
        /// </summary>
        public String GRN
        {
            get { return grn; }
            set { grn = value; }
        }

        /// <summary>
        /// IQC检验单号
        /// </summary>
        /// <returns></returns>
        public String IqcBatchNO
        { 
            get { return iqcBatchNO; }
            set { iqcBatchNO = value; }
        }

        /// <summary>
        /// Qty 数量
        /// </summary>
        /// <returns></returns>
        public Decimal Qty
        {
            get { return qty; }
            set { qty = value; }
        }

        /// <summary>
        /// 物料序列号
        /// </summary>
        public string SerialNumber
        {
            get { return serialNumber; }
            set { serialNumber = value; }
        }

        /// <summary>
        /// 物料供应商
        /// </summary>
        public string VendorName
        {
            get { return vendorName; }
            set { vendorName = value; }
        }
    }
}