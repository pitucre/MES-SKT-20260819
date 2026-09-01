using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class ItemInfo
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
        private Int32 bomId;
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


        private string itemType_Choose;
        private string itemStatus_Choose;


        private string projectName;
        private string customerName;
        private string bomName;
        private string dataTypeName;

        private Int32 parentNumber;
        private Int32 childrenNumber;
        /// <summary>
        /// add by weixia on 2015/4/28
        /// </summary>
        private Int32 iQCType;
        private String units;
        private String iQCTypeName;
        private Decimal minPackQty;
        private String routerName;

        //add by Alen 2015-07-10
        private String itemCode;
        private String site;

        private int putStation;//投入站
        private int yieldStation;//产出站

        //add by wenshun 2016/12/02
        private string factoryName;

        private string itemSpec;
        public string FactoryName
        {
            get { return this.factoryName; }
            set { this.factoryName = value; }
        }
        public String IsMESadd { get; set; }

        public String Site
        {
            get { return this.site; }
            set { this.site = value; }
        }
        //add by sam gan 2015-08-25
        private Int32 steelId;

        /// <summary>
        /// 型号
        /// </summary>
        public String ItemModel{ get;set;}

        /// <summary>
        /// 标贴固件版本
        /// </summary>
        public String LabelFirmware { get; set; }

        //add by zhiman.yuan 2016-11-2
        public String CategoryOne { get; set; }//大类
        public String CategoryTwo { get; set; }//中类
        public String CategoryThree { get; set; }//小类

        //add by zhiman.yuan 2016-11-9
        public Boolean IsMSD { get; set; }//是否MSD物料
        public String MSL { get; set; }//湿度等级
        public int FloorLife { get; set; }//暴露时长（小时）
        public int ShelfLife { get; set; }//存储期限（月）
        public int BakeCount { get; set; }//烘烤次数

        //add by zhiman.yuan 2017-3-28
        public int MaskId { get; set; }//掩码组ID 
        public string MaskGroupName { get; set; }//掩码组名称

        //add by 黄亮 2016-09-07
        public Int32 ItemTypeID { get; set; } //物料类型ID
        public String ItemTypeName { get; set; }//物料类型名称
        public String ItemTypeCode { get; set; }//物料类型编码
        //add by BirongLiang 2016-11-17
        public Int32 Qty { get; set; } //
        public dynamic PerNum { get; set; }//
        public dynamic OutQty { get; set; }//
        public dynamic SumQty { get; set; }//
        public DateTime RequireTime { get;set;}
        public string OrderNO { get; set; }
        public dynamic States { get; set; }
        public int RecordID { get; set; }
        public int OperationId { get; set; }
        public int ResId { get; set; }
        public string Station { set; get; }   
        /// <summary>
        /// 是否需要打印
        /// </summary>
        private int isNeedPrint;

        public Boolean IsPanelPrint { get; set; }

        public string ABCClass { get; set; }
        public int IssueWay { get; set; }
        public int IsNeedPrint
        {
            get { return isNeedPrint; }
            set { isNeedPrint = value; }
        }
        /// <summary>
        /// 产品是否可超发
        /// </summary>
        private Boolean isItemOver;

        public Boolean IsItemOver
        {
            get { return isItemOver; }
            set { isItemOver = value; }
        }

        /// <summary>
        /// 生产面别
        /// </summary>
        public int ProductionFace { get; set; }
      
        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.ItemInfo 类的新实例。
        /// </summary>
        public ItemInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.ItemInfo 类的新实例。
        /// </summary>
        /// <param name="itemID"></param>
        /// <param name="itemName">产品名称</param>
        /// <param name="itemRev">产品版本</param>
        /// <param name="description">产品描述</param>
        /// <param name="cPN">客户料号</param>
        /// <param name="customerID">客户ID，对应CUSTOMER.CustomerID</param>
        /// <param name="cPR">客户料号版本。Customer Part Revision</param>
        /// <param name="status">产品状态。Releasable,Frozen, On Hold, Obsoleted</param>
        /// <param name="projectID">项目ID。对应PROJECT.ProjectId</param>
        /// <param name="itemType">产品类型（Manufactured（制造产品，如PCBA）,Purchased（购买产品，如元器件等）, Manufactured/Purchased（两种类型兼有） ）</param>
        /// <param name="routerID">绑定路由ID，对应ROUTER.RouterId</param>
        /// <param name="bomId">绑定的BOM ID,对应BOM.BomId</param>
        /// <param name="lotSize">当产品是Process Lot或者是Panel的时候，需指定Lot Size，也就是同一个条码绑定多少个产品</param>
        /// <param name="maxUsageAsComp">这个是指最多可用次数</param>
        /// <param name="qtyRestriction">限定数量</param>
        /// <param name="qtyMultiplier"></param>
        /// <param name="isCurrentRev">是否当前版本。</param>
        /// <param name="isPanel">是否是拼版。</param>
        /// <param name="isCPSFC">是否是客户提供SFC。</param>
        /// <param name="isRoHS">是否通过无铅认证。</param>
        /// <param name="dCOAssembly">组装收集的数据</param>
        /// <param name="dCORemoval">移除时收集数据。</param>
        /// <param name="dCOInveRec">收货时收集数据</param>
        /// <param name="recInveWhenAss">收货时收集数据</param>
        /// <param name="vMGroup">验证规则</param>
        /// <param name="trackableComp">是否是可追踪组件。</param>
        /// <param name="itemGroupID">产品组ID</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        /// <param name="remark">备注。</param>
        public ItemInfo(Int32 itemID, String itemName, String itemRev, String description, 
            String cPN, Int32 customerID, String cPR, Int32 status, Int32 projectID, 
            Int32 itemType, Int32 routerID, Int32 bomId, Double lotSize, Double maxUsageAsComp, 
            Int32 qtyRestriction, Double qtyMultiplier, Boolean isCurrentRev, Boolean isPanel, Boolean isCPSFC, 
            Boolean isRoHS, Int32 dCOAssembly, Int32 dCORemoval, Int32 dCOInveRec, Boolean recInveWhenAss, 
            Int32 vMGroup, Boolean trackableComp, Int32 itemGroupID, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, String remark )
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
            this.bomId = bomId;
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
        /// 获取或设置
        /// </summary>
        public Int32 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置产品名称
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 获取或设置产品版本
        /// </summary>
        public String ItemRev
        {
            get { return this.itemRev; }
            set { this.itemRev = value; }
        }

        /// <summary>
        /// 获取或设置产品描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置客户料号
        /// </summary>
        public String CPN
        {
            get { return this.cPN; }
            set { this.cPN = value; }
        }

        /// <summary>
        /// 获取或设置客户ID，对应CUSTOMER.CustomerID
        /// </summary>
        public Int32 CustomerID
        {
            get { return this.customerID; }
            set { this.customerID = value; }
        }

        /// <summary>
        /// 获取或设置客户料号版本。Customer Part Revision
        /// </summary>
        public String CPR
        {
            get { return this.cPR; }
            set { this.cPR = value; }
        }

        /// <summary>
        /// 获取或设置产品状态。Releasable,Frozen, On Hold, Obsoleted
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置项目ID。对应PROJECT.ProjectId
        /// </summary>
        public Int32 ProjectID
        {
            get { return this.projectID; }
            set { this.projectID = value; }
        }

        /// <summary>
        /// 获取或设置产品类型（Manufactured（制造产品，如PCBA）,Purchased（购买产品，如元器件等）, Manufactured/Purchased（两种类型兼有） ）
        /// </summary>
        public Int32 ItemType
        {
            get { return this.itemType; }
            set { this.itemType = value; }
        }

        /// <summary>
        /// 获取或设置绑定路由ID，对应ROUTER.RouterId
        /// </summary>
        public Int32 RouterID
        {
            get { return this.routerID; }
            set { this.routerID = value; }
        }

        /// <summary>
        /// 获取或设置绑定的BOM ID,对应BOM.BomId
        /// </summary>
        public Int32 BomId
        {
            get { return this.bomId; }
            set { this.bomId = value; }
        }

        /// <summary>
        /// 获取或设置当产品是Process Lot或者是Panel的时候，需指定Lot Size，也就是同一个条码绑定多少个产品
        /// </summary>
        public Double LotSize
        {
            get { return this.lotSize; }
            set { this.lotSize = value; }
        }

        /// <summary>
        /// 获取或设置这个是指最多可用次数
        /// </summary>
        public Double MaxUsageAsComp
        {
            get { return this.maxUsageAsComp; }
            set { this.maxUsageAsComp = value; }
        }

        /// <summary>
        /// 获取或设置限定数量
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
        /// 获取或设置收货时收集数据
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
        /// <summary>
        /// 获取或设置备注。
        /// </summary>
        public String Units
        {
            get { return this.units; }
            set { this.units = value; }
        }
        /// <summary>
        /// 获取或设置备注。
        /// </summary>
        public Int32 IQCType
        {
            get { return this.iQCType; }
            set { this.iQCType = value; }
        }
        /// <summary>
        /// 获取或设置备注。
        /// </summary>
        public String IQCTypeName
        {
            get { return this.iQCTypeName; }
            set { this.iQCTypeName = value; }
        }
        public Decimal MinPackQty
        {
            get { return this.minPackQty; }
            set { this.minPackQty = value; }
        }
        public String RouterName
        {
            get { return this.routerName; }
            set { this.routerName = value; }
        }

        /// <summary>
        /// 产品编码
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        ///  产品规格
        /// </summary>
        public String ItemSpec
        {
            get { return this.itemSpec; }
            set { this.itemSpec = value; }
        }
        public bool IsRemoved { get; set; }
        public string RemoveUserName { get; set; }
        public string RemoveOperation { get; set; }
        public string RemoveTime { get; set; }

        public Int32 SteelId
        {
            get { return this.steelId; }
            set { this.steelId = value; }
        }

        /// <summary>
        /// 投入站
        /// </summary>
        public int PutStation
        {
            get { return putStation; }
            set { this.putStation = value; }
        }

        /// <summary>
        /// 产出站
        /// </summary>
        public int YieldStation
        {
            get { return yieldStation; }
            set { this.yieldStation = value; }
        }

        /*******老化  zcl*****/
        /// <summary>
        /// 老化方式  0 产品 1 老化架
        /// </summary>
        public int AgeingType { get; set; }
        /// <summary>
        /// 老化时长
        /// </summary>
        public decimal AgeingTime { get; set; }
        /// <summary>
        /// 保质期方案Id
        /// </summary>
        public int ExpirationDateId { get; set; }
        /// <summary>
        /// 保质期方案名称
        /// </summary>
        public string ExpirationDateName { get; set; }

        /// <summary>
        /// 产品排产优先级
        /// </summary>
        public int Priority { get; set; }

        /// <summary>
        /// 是否上传实验报告
        /// </summary>
        public bool IsUpTestExport { get; set; }

        /// <summary>
        /// 是否上传出货报告
        /// </summary>
        public bool IsShipmentReport { get; set; }

        /// <summary>
        /// 是否SMT行业
        /// </summary>
        public bool IsSmt { get; set; }

        /// <summary>
        /// SMT行业
        /// </summary>
        public string SmtIndustry { get; set; }
        /// <summary>
        /// 成品最小数量（批量）
        /// </summary>
        public Decimal QcMinNum { get; set; }

        /// <summary>
        /// 采集模式(1:单件,2:批次)
        /// </summary>
        public int AcquisitionMode { get; set; }

        /// <summary>
        /// 采集模式
        /// </summary>
        public string AcquisitionModeString { get; set; }
        /// <summary>
        /// 采集模式
        /// </summary>
        public string AcquisitionModeName { get; set; }

        /// <summary>
        /// 是否高级批次
        /// </summary>
        public int IsSeniorBatch { get; set; }

        /// <summary>
        /// 是否高级批次
        /// </summary>
        public string IsSeniorBatchName { get; set; }

        /// <summary>
        /// 颜色
        /// </summary>
        public string Colour { get; set; }

        /// <summary>
        /// 材质
        /// </summary>
        public string TextureOfMaterial { get; set; }

        /// <summary>
        /// 阻燃等级
        /// </summary>
        public string FlameRetardantLevel { get; set; }
        /// <summary>
        /// 是否料把
        /// </summary>
        public bool IsMaterialHandle { get; set; }

        public int OverFinshType { get; set; }

        public decimal OverRate { get; set; }

        public decimal OverQty { get; set; }


        /// <summary>
        /// 原料料号编码
        /// </summary>
        public string MaterialPartNumberCode { get; set; }
        /// <summary>
        /// 料把编码
        /// </summary>
        public string MaterialHandleNumberCode { get; set; }
        /// <summary>
        /// 碎料料号编码
        /// </summary>
        public string ScrapMaterialNumberCode { get; set; }
    }
}