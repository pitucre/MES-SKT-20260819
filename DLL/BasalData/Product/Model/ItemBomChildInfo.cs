using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class ItemBomChildInfo
    {
        private Int32 itemBomChildId;
        private Int32 itemBomId;
        private Int32 itemId;
        private String itemCode;
        private String itemName;
        private String itemLevel;
        private Decimal qty;
        private String units;
        private String usePosition;
        private Boolean isFictitious;
        private DateTime insertDateTime;
        private DateTime updateDateTime;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private Boolean default_1;
        private Int32 default_2;
        private Int32 default_3;
        private String default_4;
        private String default_5;
        private String default_6;
        private String default_7;
        private String default_8;
        private String default_9;
        private String default_10;
        private Int32 mESState;
        private Int32 eRPState;

        public string Station { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ItemBomChildInfo 类的新实例。
        /// </summary>
        public ItemBomChildInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ItemBomChildInfo 类的新实例。
        /// </summary>
        /// <param name="itemBomChildId">产品BOM子表ID</param>
        /// <param name="itemBomId">产品BOM 主表ID</param>
        /// <param name="itemId">产品ID</param>
        /// <param name="itemCode">产品编码</param>
        /// <param name="itemName">产品名称</param>
        /// <param name="itemLevel">产品阶次</param>
        /// <param name="qty">单位用量</param>
        /// <param name="units">单位</param>
        /// <param name="usePosition">物料使用位置</param>
        /// <param name="isFictitious">是否虚拟件：0、非虚拟件 ；1、虚拟件</param>
        /// <param name="insertDateTime">插入时间</param>
        /// <param name="updateDateTime">更新时间</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="default_1">预留字段</param>
        /// <param name="default_2">预留字段</param>
        /// <param name="default_3">预留字段</param>
        /// <param name="default_4">预留字段</param>
        /// <param name="default_5">预留字段</param>
        /// <param name="default_6">预留字段</param>
        /// <param name="default_7">预留字段</param>
        /// <param name="default_8">预留字段</param>
        /// <param name="default_9">预留字段</param>
        /// <param name="default_10">预留字段</param>
        /// <param name="mESState">MES调用状态（9调用，10调用失败）</param>
        /// <param name="eRPState">ERP传入状态（0新增；1修改；2删除）</param>
        public ItemBomChildInfo(Int32 itemBomChildId, Int32 itemBomId, Int32 itemId, String itemCode,
            String itemName, String itemLevel, Decimal qty, String units, String usePosition,
            Boolean isFictitious, DateTime insertDateTime, DateTime updateDateTime, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime, Boolean default_1, Int32 default_2, Int32 default_3,
            String default_4, String default_5, String default_6, String default_7, String default_8,
            String default_9, String default_10, Int32 mESState, Int32 eRPState)
        {
            this.itemBomChildId = itemBomChildId;
            this.itemBomId = itemBomId;
            this.itemId = itemId;
            this.itemCode = itemCode;
            this.itemName = itemName;
            this.itemLevel = itemLevel;
            this.qty = qty;
            this.units = units;
            this.usePosition = usePosition;
            this.isFictitious = isFictitious;
            this.insertDateTime = insertDateTime;
            this.updateDateTime = updateDateTime;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.default_1 = default_1;
            this.default_2 = default_2;
            this.default_3 = default_3;
            this.default_4 = default_4;
            this.default_5 = default_5;
            this.default_6 = default_6;
            this.default_7 = default_7;
            this.default_8 = default_8;
            this.default_9 = default_9;
            this.default_10 = default_10;
            this.mESState = mESState;
            this.eRPState = eRPState;
        }

        /// <summary>
        /// 获取或设置产品BOM子表ID
        /// </summary>
        public Int32 ItemBomChildId
        {
            get { return this.itemBomChildId; }
            set { this.itemBomChildId = value; }
        }

        /// <summary>
        /// 获取或设置产品BOM 主表ID
        /// </summary>
        public Int32 ItemBomId
        {
            get { return this.itemBomId; }
            set { this.itemBomId = value; }
        }

        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置产品编码
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
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
        /// 获取或设置产品阶次
        /// </summary>
        public String ItemLevel
        {
            get { return this.itemLevel; }
            set { this.itemLevel = value; }
        }

        /// <summary>
        /// 获取或设置单位用量
        /// </summary>
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置单位
        /// </summary>
        public String Units
        {
            get { return this.units; }
            set { this.units = value; }
        }

        /// <summary>
        /// 获取或设置物料使用位置
        /// </summary>
        public String UsePosition
        {
            get { return this.usePosition; }
            set { this.usePosition = value; }
        }

        /// <summary>
        /// 获取或设置是否虚拟件：0、非虚拟件 ；1、虚拟件
        /// </summary>
        public Boolean IsFictitious
        {
            get { return this.isFictitious; }
            set { this.isFictitious = value; }
        }

        /// <summary>
        /// 获取或设置插入时间
        /// </summary>
        public DateTime InsertDateTime
        {
            get { return this.insertDateTime; }
            set { this.insertDateTime = value; }
        }

        /// <summary>
        /// 获取或设置更新时间
        /// </summary>
        public DateTime UpdateDateTime
        {
            get { return this.updateDateTime; }
            set { this.updateDateTime = value; }
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
        /// 获取或设置预留字段
        /// </summary>
        public Boolean Default_1
        {
            get { return this.default_1; }
            set { this.default_1 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public Int32 Default_2
        {
            get { return this.default_2; }
            set { this.default_2 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public Int32 Default_3
        {
            get { return this.default_3; }
            set { this.default_3 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public String Default_4
        {
            get { return this.default_4; }
            set { this.default_4 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public String Default_5
        {
            get { return this.default_5; }
            set { this.default_5 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public String Default_6
        {
            get { return this.default_6; }
            set { this.default_6 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public String Default_7
        {
            get { return this.default_7; }
            set { this.default_7 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public String Default_8
        {
            get { return this.default_8; }
            set { this.default_8 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public String Default_9
        {
            get { return this.default_9; }
            set { this.default_9 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public String Default_10
        {
            get { return this.default_10; }
            set { this.default_10 = value; }
        }

        /// <summary>
        /// 获取或设置MES调用状态（9调用，10调用失败）
        /// </summary>
        public Int32 MESState
        {
            get { return this.mESState; }
            set { this.mESState = value; }
        }

        /// <summary>
        /// 获取或设置ERP传入状态（0新增；1修改；2删除）
        /// </summary>
        public Int32 ERPState
        {
            get { return this.eRPState; }
            set { this.eRPState = value; }
        }


        /// <summary>
        /// GRN Id
        /// </summary>
        public int MaterialUnitID { get; set; }

        /// <summary>
        /// GRN
        /// </summary>
        public string SerialNumber { get; set; }

        /// <summary>
        /// 规格
        /// </summary>
        public string ItemSpec { get; set; }

        /// <summary>
        /// 工单Id
        /// </summary>
        public int ProdOrderId { get; set; }

        /// <summary>
        /// 特征码
        /// </summary>
        public string FeatureCode { get; set; }
    }
}
