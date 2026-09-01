using System;

namespace SKT.LeanMES.Sparepart.Model
{
    [Serializable]
    public class SparepartInfo
    {
        private Int32 partId;
        private String partName;
        private String partNickName;
        private String partNO;
        private String partCategory;
        private String partMachine;
        private String partLocation;
        private String partBrand;
        private String partStandard;
        private String partParam;
        private Decimal partSafeQty;
        private int partQty;
        private int onLineQty;
        private int scrapQty;
        private int inStockQty;
        private String partUnit;
        private String createBy;
        private DateTime createDateTime;
        private DateTime factoryDate;
        private DateTime produceDate;
        private DateTime serviceLife;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private String scrapRemark;

        private Decimal quantity;
        private Int32 operateType;
        private String requestor;
        private Int32 outorin;
        public Int32 PartsHistoryId { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PartsInfo 类的新实例。
        /// </summary>
        public SparepartInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PartsInfo 类的新实例。
        /// </summary>
        /// <param name="partId">主键</param>
        /// <param name="partName">备件名</param>
        /// <param name="partNickName">备件别名</param>
        /// <param name="partNO">备件代码</param>
        /// <param name="partCategory">备件类别</param>
        /// <param name="partMachine">使用设备</param>
        /// <param name="partLocation">位置</param>
        /// <param name="partBrand">品牌</param>
        /// <param name="partStandard">规格</param>
        /// <param name="partParam">参数</param>
        /// <param name="partSafeQty">安全库存</param>
        /// <param name="partQty">当前库存</param>
        /// <param name="partUnit">单位</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public SparepartInfo(Int32 partId, String partName, String partNickName, String partNO,
            String partCategory, String partMachine, String partLocation, String partBrand, String partStandard,
            String partParam, Decimal partSafeQty, int partQty, String partUnit, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.partId = partId;
            this.partName = partName;
            this.partNickName = partNickName;
            this.partNO = partNO;
            this.partCategory = partCategory;
            this.partMachine = partMachine;
            this.partLocation = partLocation;
            this.partBrand = partBrand;
            this.partStandard = partStandard;
            this.partParam = partParam;
            this.partSafeQty = partSafeQty;
            this.partQty = partQty;
            this.partUnit = partUnit;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PartsInfo 类的新实例。
        /// </summary>
        /// <param name="partId">主键</param>
        /// <param name="partName">备件名</param>
        /// <param name="partNickName">备件别名</param>
        /// <param name="partNO">备件代码</param>
        /// <param name="partCategory">备件类别</param>
        /// <param name="partMachine">使用设备</param>
        /// <param name="partLocation">位置</param>
        /// <param name="partBrand">品牌</param>
        /// <param name="partStandard">规格</param>
        /// <param name="partParam">参数</param>
        /// <param name="partSafeQty">安全库存</param>
        /// <param name="partQty">当前库存</param>
        /// <param name="partUnit">单位</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public SparepartInfo(Int32 partId, String partName, String partNickName, String partNO,
            String partCategory, String partMachine, String partLocation, String partBrand, String partStandard,
            String partParam, Decimal partSafeQty, int partQty, String partUnit, String createBy, Decimal quantity,
            String operateType, String requestor, Int32 outorin, DateTime createDateTime)
        {
            this.partId = partId;
            this.partName = partName;
            this.partNickName = partNickName;
            this.partNO = partNO;
            this.partCategory = partCategory;
            this.partMachine = partMachine;
            this.partLocation = partLocation;
            this.partBrand = partBrand;
            this.partStandard = partStandard;
            this.partParam = partParam;
            this.partSafeQty = partSafeQty;
            this.partQty = partQty;
            this.partUnit = partUnit;
            this.createBy = createBy;
            this.quantity = Quantity;
            this.operateType = OperateType;
            this.requestor = Requestor;
            this.outorin = OutOrIn;
            this.createDateTime = createDateTime;
        }
        /// <summary>
        /// 获取或设置主键
        /// </summary>
        public Int32 PartId
        {
            get { return this.partId; }
            set { this.partId = value; }
        }

        /// <summary>
        /// 获取或设置备件名
        /// </summary>
        public String PartName
        {
            get { return this.partName; }
            set { this.partName = value; }
        }

        /// <summary>
        /// 获取或设置备件别名
        /// </summary>
        public String PartNickName
        {
            get { return this.partNickName; }
            set { this.partNickName = value; }
        }

        /// <summary>
        /// 获取或设置备件代码
        /// </summary>
        public String PartNO
        {
            get { return this.partNO; }
            set { this.partNO = value; }
        }

        /// <summary>
        /// 获取或设置备件类别
        /// </summary>
        public String PartCategory
        {
            get { return this.partCategory; }
            set { this.partCategory = value; }
        }

        /// <summary>
        /// 获取或设置使用设备
        /// </summary>
        public String PartMachine
        {
            get { return this.partMachine; }
            set { this.partMachine = value; }
        }

        /// <summary>
        /// 获取或设置位置
        /// </summary>
        public String PartLocation
        {
            get { return this.partLocation; }
            set { this.partLocation = value; }
        }

        /// <summary>
        /// 获取或设置品牌
        /// </summary>
        public String PartBrand
        {
            get { return this.partBrand; }
            set { this.partBrand = value; }
        }

        /// <summary>
        /// 获取或设置规格
        /// </summary>
        public String PartStandard
        {
            get { return this.partStandard; }
            set { this.partStandard = value; }
        }

        /// <summary>
        /// 获取或设置参数
        /// </summary>
        public String PartParam
        {
            get { return this.partParam; }
            set { this.partParam = value; }
        }

        /// <summary>
        /// 获取或设置安全库存
        /// </summary>
        public Decimal PartSafeQty
        {
            get { return this.partSafeQty; }
            set { this.partSafeQty = value; }
        }

        /// <summary>
        /// 获取或设置当前库存
        /// </summary>
        public int PartQty
        {
            get { return this.partQty; }
            set { this.partQty = value; }
        }

        /// <summary>
        /// 获取或设置单位
        /// </summary>
        public String PartUnit
        {
            get { return this.partUnit; }
            set { this.partUnit = value; }
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
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        public Decimal Quantity
        {
            get { return this.quantity; }
            set { this.quantity = value; }
        }
        public Int32 OperateType
        {
            get { return this.operateType; }
            set { this.operateType = value; }
        }
        public String Requestor
        {
            get { return this.requestor; }
            set { this.requestor = value; }
        }
        public Int32 OutOrIn
        {
            get { return this.outorin; }
            set { this.outorin = value; }
        }
        public string DepartName { get; set; }
        /// <summary>
        /// 厂商名称
        /// </summary>    
        public string VenName { get; set; }
        /// <summary>
        /// 供应商编码
        /// </summary>
        public string SupplierName { get; set; }

        public DateTime FactoryDate
        {
            get
            {
                return factoryDate;
            }

            set
            {
                factoryDate = value;
            }
        }

        public DateTime ProduceDate
        {
            get
            {
                return produceDate;
            }

            set
            {
                produceDate = value;
            }
        }

        public int OnLineQty
        {
            get
            {
                return onLineQty;
            }

            set
            {
                onLineQty = value;
            }
        }

        public int ScrapQty
        {
            get
            {
                return scrapQty;
            }

            set
            {
                scrapQty = value;
            }
        }

        public int InStockQty
        {
            get
            {
                return inStockQty;
            }

            set
            {
                inStockQty = value;
            }
        }

        public string ScrapRemark
        {
            get
            {
                return scrapRemark;
            }

            set
            {
                scrapRemark = value;
            }
        }

        public DateTime ServiceLife
        {
            get
            {
                return serviceLife;
            }

            set
            {
                serviceLife = value;
            }
        }
    }
}