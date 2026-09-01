using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class WarehouseLocationInfo
    {
        private Int32 warehouseLocationId;
        private String cStoreCode;
        private String cStoreName;
        private String cPosCode;
        private String cPosName;
        private String cProperty;
        private Int32 wMSWarehouseId;
        private String mOrder;
        private String pOrder;
        private Int16 iPosGrade;
        private Int16 bPosEnd;
        private String cBarCode;
        private Decimal iMaxCubage;
        private Decimal iMaxWeight;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private String cWhCode;
        private String cWhName;
        private int productIsOnly;

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseLocationInfo 类的新实例。
        /// </summary>
        public WarehouseLocationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseLocationInfo 类的新实例。
        /// </summary>
        /// <param name="warehouseLocationId">自增长编号</param>
        /// <param name="cStoreCode">储位编号</param>
        /// <param name="cStoreName">储位名称</param>
        /// <param name="cPosCode">货位编码</param>
        /// <param name="cPosName">货位名称</param>
        /// <param name="cProperty">仓库属性,S:一般性仓库,W: 在制品仓库</param>
        /// <param name="wMSWarehouseId">仓库id</param>
        /// <param name="mOrder">发料顺序</param>
        /// <param name="pOrder">发货顺序</param>
        /// <param name="iPosGrade">编码级次</param>
        /// <param name="bPosEnd">是否末级</param>
        /// <param name="cBarCode">对应条形码编码</param>
        /// <param name="iMaxCubage">最大体积</param>
        /// <param name="iMaxWeight">最大重量</param>
        /// <param name="createBy">创建用户ID</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改用户</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注信息</param>
        /// <param name="cWhCode">仓库编号</param>
        /// <param name="cWhName">仓库名称</param>
        /// <param name="productIsOnly">存放产品是否唯一</param>
        public WarehouseLocationInfo(Int32 warehouseLocationId, String cStoreCode, String cStoreName, String cPosCode,
            String cPosName, String cProperty, Int32 wMSWarehouseId, String mOrder, String pOrder,
            Int16 iPosGrade, Int16 bPosEnd, String cBarCode, Decimal iMaxCubage, Decimal iMaxWeight,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark, String cWhCode, String cWhName, int productIsOnly)
        {
            this.warehouseLocationId = warehouseLocationId;
            this.cStoreCode = cStoreCode;
            this.cStoreName = cStoreName;
            this.cPosCode = cPosCode;
            this.cPosName = cPosName;
            this.cProperty = cProperty;
            this.wMSWarehouseId = wMSWarehouseId;
            this.cWhCode = cWhCode;
            this.mOrder = mOrder;
            this.pOrder = pOrder;
            this.iPosGrade = iPosGrade;
            this.bPosEnd = bPosEnd;
            this.cBarCode = cBarCode;
            this.iMaxCubage = iMaxCubage;
            this.iMaxWeight = iMaxWeight;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;

            this.cWhCode = cWhCode;
            this.cWhName = cWhName;
            this.productIsOnly = productIsOnly;
        }

        /// <summary>
        /// 获取或设置自增长编号
        /// </summary>
        public Int32 WarehouseLocationId
        {
            get { return this.warehouseLocationId; }
            set { this.warehouseLocationId = value; }
        }

        /// <summary>
        /// 获取或设置储位编号
        /// </summary>
        public String CStoreCode
        {
            get { return this.cStoreCode; }
            set { this.cStoreCode = value; }
        }

        /// <summary>
        /// 获取或设置储位名称
        /// </summary>
        public String CStoreName
        {
            get { return this.cStoreName; }
            set { this.cStoreName = value; }
        }

        /// <summary>
        /// 获取或设置货位编码
        /// </summary>
        public String CPosCode
        {
            get { return this.cPosCode; }
            set { this.cPosCode = value; }
        }

        /// <summary>
        /// 获取或设置货位名称
        /// </summary>
        public String CPosName
        {
            get { return this.cPosName; }
            set { this.cPosName = value; }
        }

        /// <summary>
        /// 获取或设置仓库属性,S:一般性仓库,W: 在制品仓库
        /// </summary>
        public String CProperty
        {
            get { return this.cProperty; }
            set { this.cProperty = value; }
        }

        /// <summary>
        /// 获取或设置仓库编码（新加）
        /// </summary>
        public Int32 WMSWarehouseId
        {
            get { return this.wMSWarehouseId; }
            set { this.wMSWarehouseId = value; }
        }

        /// <summary>
        /// 获取或设置发料顺序
        /// </summary>
        public String MOrder
        {
            get { return this.mOrder; }
            set { this.mOrder = value; }
        }

        /// <summary>
        /// 获取或设置发货顺序
        /// </summary>
        public String POrder
        {
            get { return this.pOrder; }
            set { this.pOrder = value; }
        }

        /// <summary>
        /// 获取或设置编码级次
        /// </summary>
        public Int16 IPosGrade
        {
            get { return this.iPosGrade; }
            set { this.iPosGrade = value; }
        }

        /// <summary>
        /// 获取或设置是否末级
        /// </summary>
        public Int16 BPosEnd
        {
            get { return this.bPosEnd; }
            set { this.bPosEnd = value; }
        }

        /// <summary>
        /// 获取或设置对应条形码编码
        /// </summary>
        public String CBarCode
        {
            get { return this.cBarCode; }
            set { this.cBarCode = value; }
        }

        /// <summary>
        /// 获取或设置最大体积
        /// </summary>
        public Decimal IMaxCubage
        {
            get { return this.iMaxCubage; }
            set { this.iMaxCubage = value; }
        }

        /// <summary>
        /// 获取或设置最大重量
        /// </summary>
        public Decimal IMaxWeight
        {
            get { return this.iMaxWeight; }
            set { this.iMaxWeight = value; }
        }

        /// <summary>
        /// 获取或设置创建用户ID
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
        /// 获取或设置修改用户
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
        /// 获取或设置备注信息
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 仓库编号
        /// </summary>
        public String CWhCode
        {
            get { return this.cWhCode; }
            set { this.cWhCode = value; }
        }

        /// <summary>
        /// 仓库名称
        /// </summary>
        public String CWhName
        {
            get { return this.cWhName; }
            set { this.cWhName = value; }
        }

        public int ProductIsOnly
        {
            get
            {
                return productIsOnly;
            }

            set
            {
                productIsOnly = value;
            }
        }

        public string LocationType { get; set; }
        public string ShiftCode { get; set; }
        /// <summary>
        /// 入库顺序
        /// </summary>
        public int InOrder { get; set; }
        /// <summary>
        /// AGV地标码
        /// </summary>
        public string AGVLandmarkCode { get; set; }
        /// <summary>
        /// 是否周转箱存放货位
        /// </summary>
        public int IsUniPakPos { get; set; }

    }
}