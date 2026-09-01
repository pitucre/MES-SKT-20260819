using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class ItemBomInfo
    {
        private Int32 itemBomId;
        private String organizationCode;
        private String bomName;
        private String version;
        private Boolean isCurrentVer;
        private Int32 eRP_BomId;
        private String eRP_BomNumber;
        private Int32 itemId;
        private String itemCode;
        private String itemName;
        private DateTime createDate;
        private String description;
        private DateTime insertDateTime;
        private DateTime updateDateTime;
        private Int32 source;
        private String site;
        private Int32 state;
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

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ItemBomInfo 类的新实例。
        /// </summary>
        public ItemBomInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ItemBomInfo 类的新实例。
        /// </summary>
        /// <param name="itemBomId">产品BOM主件ID</param>
        /// <param name="organizationCode">ERP组织代码</param>
        /// <param name="bomName">Bom 名称 （产品编码+’-’+版本号）</param>
        /// <param name="version">版本号</param>
        /// <param name="isCurrentVer">是否为当前版本</param>
        /// <param name="eRP_BomId">ERP BomdID</param>
        /// <param name="eRP_BomNumber">ERP Bom编码</param>
        /// <param name="itemId">产品ID</param>
        /// <param name="itemCode">产品编码</param>
        /// <param name="itemName">产品名称</param>
        /// <param name="createDate">建档日期</param>
        /// <param name="description">BOM 描述</param>
        /// <param name="insertDateTime">插入时间</param>
        /// <param name="updateDateTime">更新时间</param>
        /// <param name="source">产品BOM来源：1、ERP下载 2、MES导入 3、MES创建</param>
        /// <param name="site">工厂编码</param>
        /// <param name="state">产品Bom状态：0、停用；1、启用</param>
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
        public ItemBomInfo(Int32 itemBomId, String organizationCode, String bomName, String version,
            Boolean isCurrentVer, Int32 eRP_BomId, String eRP_BomNumber, Int32 itemId, String itemCode,
            String itemName, DateTime createDate, String description, DateTime insertDateTime, DateTime updateDateTime,
            Int32 source, String site, Int32 state, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime, Boolean default_1, Int32 default_2, Int32 default_3,
            String default_4, String default_5, String default_6, String default_7, String default_8,
            String default_9, String default_10, Int32 mESState, Int32 eRPState)
        {
            this.itemBomId = itemBomId;
            this.organizationCode = organizationCode;
            this.bomName = bomName;
            this.version = version;
            this.isCurrentVer = isCurrentVer;
            this.eRP_BomId = eRP_BomId;
            this.eRP_BomNumber = eRP_BomNumber;
            this.itemId = itemId;
            this.itemCode = itemCode;
            this.itemName = itemName;
            this.createDate = createDate;
            this.description = description;
            this.insertDateTime = insertDateTime;
            this.updateDateTime = updateDateTime;
            this.source = source;
            this.site = site;
            this.state = state;
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
        /// 获取或设置产品BOM主件ID
        /// </summary>
        public Int32 ItemBomId
        {
            get { return this.itemBomId; }
            set { this.itemBomId = value; }
        }

        /// <summary>
        /// 获取或设置ERP组织代码
        /// </summary>
        public String OrganizationCode
        {
            get { return this.organizationCode; }
            set { this.organizationCode = value; }
        }

        /// <summary>
        /// 获取或设置Bom 名称 （产品编码+’-’+版本号）
        /// </summary>
        public String BomName
        {
            get { return this.bomName; }
            set { this.bomName = value; }
        }

        /// <summary>
        /// 获取或设置版本号
        /// </summary>
        public String Version
        {
            get { return this.version; }
            set { this.version = value; }
        }

        /// <summary>
        /// 获取或设置是否为当前版本
        /// </summary>
        public Boolean IsCurrentVer
        {
            get { return this.isCurrentVer; }
            set { this.isCurrentVer = value; }
        }

        /// <summary>
        /// 获取或设置ERP BomdID
        /// </summary>
        public Int32 ERP_BomId
        {
            get { return this.eRP_BomId; }
            set { this.eRP_BomId = value; }
        }

        /// <summary>
        /// 获取或设置ERP Bom编码
        /// </summary>
        public String ERP_BomNumber
        {
            get { return this.eRP_BomNumber; }
            set { this.eRP_BomNumber = value; }
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
        /// 获取或设置建档日期
        /// </summary>
        public DateTime CreateDate
        {
            get { return this.createDate; }
            set { this.createDate = value; }
        }

        /// <summary>
        /// 获取或设置BOM 描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
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
        /// 获取或设置产品BOM来源：1、ERP下载 2、MES导入 3、MES创建
        /// </summary>
        public Int32 Source
        {
            get { return this.source; }
            set { this.source = value; }
        }

        /// <summary>
        /// 获取或设置工厂编码
        /// </summary>
        public String Site
        {
            get { return this.site; }
            set { this.site = value; }
        }

        /// <summary>
        /// 获取或设置产品Bom状态：0、停用；1、启用
        /// </summary>
        public Int32 State
        {
            get { return this.state; }
            set { this.state = value; }
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
    }
}
