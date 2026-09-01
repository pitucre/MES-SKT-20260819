using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class MaterialRequisitionInfo
    {
        private String site;
        private Int32 wOInterId;
        private String wONo;
        private Int32 matReqInterId;
        private String matReqNo;
        private Int32 rowId;
        private String itemCode;
        private String itemName;
        private String itemModel;
        private String unit;
        private Decimal qtyScrap;
        private Decimal scrapFactor;
        private Decimal qtyMust;
        private Decimal qty;
        private Decimal stockQty;
        private Int32 stationId;
        private String stationName;
        private DateTime sendItemDate;
        private Decimal discardQty;
        private Decimal wIPQty;
        private Decimal qtySupply;
        private String remark;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime lastUpdateTime;
        private String remark1;
        private Int32 reserved1;
        private DateTime reserved2;
        private Decimal reserved3;
        private String reserved4;
        private String reserved5;
        private String reserved6;
        private String reserved7;
        private String reserved8;
        private Boolean reserved9;
        private Double reserved10;
        private Int32 matReqId;

        private Int32 erpItemId;

        public Int32 ErpItemId
        {
            get { return erpItemId; }
            set { erpItemId = value; }
        }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialRequisitionInfo 类的新实例。
        /// </summary>
        public MaterialRequisitionInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialRequisitionInfo 类的新实例。
        /// </summary>
        /// <param name="site">工厂代码</param>
        /// <param name="wOInterId">工单内码</param>
        /// <param name="wONo">工单编号</param>
        /// <param name="matReqInterId">领料单内码</param>
        /// <param name="matReqNo">领料单编号</param>
        /// <param name="rowId">行号</param>
        /// <param name="itemCode">物料代码</param>
        /// <param name="itemName">物料名称</param>
        /// <param name="itemModel">物料规格</param>
        /// <param name="unit">单位</param>
        /// <param name="qtyScrap">单位用量</param>
        /// <param name="scrapFactor">损耗率</param>
        /// <param name="qtyMust">计划发料数量</param>
        /// <param name="qty">选单数量</param>
        /// <param name="stockQty">已领数量</param>
        /// <param name="stationId">工位</param>
        /// <param name="stationName"></param>
        /// <param name="sendItemDate">计划发料日期</param>
        /// <param name="discardQty">报废数量</param>
        /// <param name="wIPQty">在制品数量</param>
        /// <param name="qtySupply">补料数量</param>
        /// <param name="remark">备注</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="lastUpdateTime">最后一次修改时间</param>
        /// <param name="remark1">备注</param>
        /// <param name="reserved1">预留字段INT</param>
        /// <param name="reserved2">预留字段DateTime</param>
        /// <param name="reserved3">预留字段Decimal</param>
        /// <param name="reserved4">预留字段nvarchar</param>
        /// <param name="reserved5">预留字段nvarchar</param>
        /// <param name="reserved6">预留字段nvarchar</param>
        /// <param name="reserved7">预留字段nvarchar</param>
        /// <param name="reserved8"></param>
        /// <param name="reserved9">预留字段bit</param>
        /// <param name="reserved10">预留字段float</param>
        /// <param name="matReqId"></param>
        public MaterialRequisitionInfo(String site, Int32 wOInterId, String wONo, Int32 matReqInterId, 
            String matReqNo, Int32 rowId, String itemCode, String itemName, String itemModel, 
            String unit, Decimal qtyScrap, Decimal scrapFactor, Decimal qtyMust, Decimal qty, 
            Decimal stockQty, Int32 stationId, String stationName, DateTime sendItemDate, Decimal discardQty, 
            Decimal wIPQty, Decimal qtySupply, String remark, DateTime createDateTime, String createBy, 
            DateTime modifyDateTime, String modifyBy, DateTime lastUpdateTime, String remark1, Int32 reserved1, 
            DateTime reserved2, Decimal reserved3, String reserved4, String reserved5, String reserved6, 
            String reserved7, String reserved8, Boolean reserved9, Double reserved10, Int32 matReqId)
        {
            this.site = site;
            this.wOInterId = wOInterId;
            this.wONo = wONo;
            this.matReqInterId = matReqInterId;
            this.matReqNo = matReqNo;
            this.rowId = rowId;
            this.itemCode = itemCode;
            this.itemName = itemName;
            this.itemModel = itemModel;
            this.unit = unit;
            this.qtyScrap = qtyScrap;
            this.scrapFactor = scrapFactor;
            this.qtyMust = qtyMust;
            this.qty = qty;
            this.stockQty = stockQty;
            this.stationId = stationId;
            this.stationName = stationName;
            this.sendItemDate = sendItemDate;
            this.discardQty = discardQty;
            this.wIPQty = wIPQty;
            this.qtySupply = qtySupply;
            this.remark = remark;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.lastUpdateTime = lastUpdateTime;
            this.remark1 = remark1;
            this.reserved1 = reserved1;
            this.reserved2 = reserved2;
            this.reserved3 = reserved3;
            this.reserved4 = reserved4;
            this.reserved5 = reserved5;
            this.reserved6 = reserved6;
            this.reserved7 = reserved7;
            this.reserved8 = reserved8;
            this.reserved9 = reserved9;
            this.reserved10 = reserved10;
            this.matReqId = matReqId;
        }

        /// <summary>
        /// 获取或设置工厂代码
        /// </summary>
        public String Site
        {
            get { return this.site; }
            set { this.site = value; }
        }

        /// <summary>
        /// 获取或设置工单内码
        /// </summary>
        public Int32 WOInterId
        {
            get { return this.wOInterId; }
            set { this.wOInterId = value; }
        }

        /// <summary>
        /// 获取或设置工单编号
        /// </summary>
        public String WONo
        {
            get { return this.wONo; }
            set { this.wONo = value; }
        }

        /// <summary>
        /// 获取或设置领料单内码
        /// </summary>
        public Int32 MatReqInterId
        {
            get { return this.matReqInterId; }
            set { this.matReqInterId = value; }
        }

        /// <summary>
        /// 获取或设置领料单编号
        /// </summary>
        public String MatReqNo
        {
            get { return this.matReqNo; }
            set { this.matReqNo = value; }
        }

        /// <summary>
        /// 获取或设置行号
        /// </summary>
        public Int32 RowId
        {
            get { return this.rowId; }
            set { this.rowId = value; }
        }

        /// <summary>
        /// 获取或设置物料代码
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 获取或设置物料名称
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 获取或设置物料规格
        /// </summary>
        public String ItemModel
        {
            get { return this.itemModel; }
            set { this.itemModel = value; }
        }

        /// <summary>
        /// 获取或设置单位
        /// </summary>
        public String Unit
        {
            get { return this.unit; }
            set { this.unit = value; }
        }

        /// <summary>
        /// 获取或设置单位用量
        /// </summary>
        public Decimal QtyScrap
        {
            get { return this.qtyScrap; }
            set { this.qtyScrap = value; }
        }

        /// <summary>
        /// 获取或设置损耗率
        /// </summary>
        public Decimal ScrapFactor
        {
            get { return this.scrapFactor; }
            set { this.scrapFactor = value; }
        }

        /// <summary>
        /// 获取或设置计划发料数量
        /// </summary>
        public Decimal QtyMust
        {
            get { return this.qtyMust; }
            set { this.qtyMust = value; }
        }

        /// <summary>
        /// 获取或设置选单数量
        /// </summary>
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置已领数量
        /// </summary>
        public Decimal StockQty
        {
            get { return this.stockQty; }
            set { this.stockQty = value; }
        }

        /// <summary>
        /// 获取或设置工位
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String StationName
        {
            get { return this.stationName; }
            set { this.stationName = value; }
        }

        /// <summary>
        /// 获取或设置计划发料日期
        /// </summary>
        public DateTime SendItemDate
        {
            get { return this.sendItemDate; }
            set { this.sendItemDate = value; }
        }

        /// <summary>
        /// 获取或设置报废数量
        /// </summary>
        public Decimal DiscardQty
        {
            get { return this.discardQty; }
            set { this.discardQty = value; }
        }

        /// <summary>
        /// 获取或设置在制品数量
        /// </summary>
        public Decimal WIPQty
        {
            get { return this.wIPQty; }
            set { this.wIPQty = value; }
        }

        /// <summary>
        /// 获取或设置补料数量
        /// </summary>
        public Decimal QtySupply
        {
            get { return this.qtySupply; }
            set { this.qtySupply = value; }
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
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
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
        /// 获取或设置最后一次修改时间
        /// </summary>
        public DateTime LastUpdateTime
        {
            get { return this.lastUpdateTime; }
            set { this.lastUpdateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark1
        {
            get { return this.remark1; }
            set { this.remark1 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段INT
        /// </summary>
        public Int32 Reserved1
        {
            get { return this.reserved1; }
            set { this.reserved1 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段DateTime
        /// </summary>
        public DateTime Reserved2
        {
            get { return this.reserved2; }
            set { this.reserved2 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段Decimal
        /// </summary>
        public Decimal Reserved3
        {
            get { return this.reserved3; }
            set { this.reserved3 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段nvarchar
        /// </summary>
        public String Reserved4
        {
            get { return this.reserved4; }
            set { this.reserved4 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段nvarchar
        /// </summary>
        public String Reserved5
        {
            get { return this.reserved5; }
            set { this.reserved5 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段nvarchar
        /// </summary>
        public String Reserved6
        {
            get { return this.reserved6; }
            set { this.reserved6 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段nvarchar
        /// </summary>
        public String Reserved7
        {
            get { return this.reserved7; }
            set { this.reserved7 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Reserved8
        {
            get { return this.reserved8; }
            set { this.reserved8 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段bit
        /// </summary>
        public Boolean Reserved9
        {
            get { return this.reserved9; }
            set { this.reserved9 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段float
        /// </summary>
        public Double Reserved10
        {
            get { return this.reserved10; }
            set { this.reserved10 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MatReqId
        {
            get { return this.matReqId; }
            set { this.matReqId = value; }
        }
    }
}