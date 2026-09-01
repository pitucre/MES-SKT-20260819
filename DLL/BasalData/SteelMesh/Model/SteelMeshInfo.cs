using System;

namespace SKT.LeanMES.SteelMesh.Model
{
    [Serializable]
    public class SteelMeshInfo
    {
        private Int32 steelId;
        private String steelName;
        private String steelCode;
        private String position;

        private Int32 codeType;
        private Decimal thick;
        private Int32 vendor;
        private DateTime enterFactory;
        private String vendorBarcode;
        private Int32 useCount;

        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyTime;
        private String remark;

        private String vendorName;
        private Int32 outPeople;
        private Int32 inPeople;

        private String outName;
        private String inName;

        private Int32 standarLive;
        public String CurPosition { get; set; }
        public Int32 SteelStatus { get; set; }
        public Int32 InOrOut { get; set; }
        public Int32 WarningTime { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.SteelMesh.Model.SteelMeshInfo 类的新实例。
        /// </summary>
        public SteelMeshInfo()
        {
        }
        public SteelMeshInfo(Int32 steelId, String steelName, String steelCode, String position,
            Int32 codeType, Decimal thick, Int32 vendor, DateTime enterFactory, String vendorBarcode, Int32 useCount, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyTime, String remark)
        {
            this.steelId = steelId;
            this.steelName = steelName;
            this.steelCode = steelCode;
            this.position = position;

            this.codeType = codeType;
            this.thick = thick;
            this.vendor = vendor;
            this.enterFactory = enterFactory;
            this.vendorBarcode = vendorBarcode;
            this.useCount = useCount;

            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyTime = modifyTime;
            this.remark = remark;

        }
        /// <summary>
        /// 初始化 SKT.LeanMES.SteelMesh.Model.SteelMeshInfo 类的新实例。
        /// </summary>
        /// <param name="steelId">主键</param>
        /// <param name="steelName">钢网名称</param>
        /// <param name="steelCode">钢网编号</param>
        /// <param name="position">备用字段1</param>
        /// <param name="temp2">备用字段2</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyTime">修改时间</param>
        /// <param name="remark">备注</param>
        public SteelMeshInfo(Int32 steelId, String steelName, String steelCode, String position,
            Int32 codeType, Decimal thick, Int32 vendor, DateTime enterFactory, String vendorBarcode, Int32 useCount, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyTime, String remark, Int32 standarLive)
        {
            this.steelId = steelId;
            this.steelName = steelName;
            this.steelCode = steelCode;
            this.position = position;

            this.codeType = codeType;
            this.thick = thick;
            this.vendor = vendor;
            this.enterFactory = enterFactory;
            this.vendorBarcode = vendorBarcode;
            this.useCount = useCount;

            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyTime = modifyTime;
            this.remark = remark;

            this.standarLive = standarLive;
        }
        /// <summary>
        /// 获取或设置主键
        /// </summary>
        public Int32 SteelId
        {
            get { return this.steelId; }
            set { this.steelId = value; }
        }

        /// <summary>
        /// 获取或设置钢网名称
        /// </summary>
        public String SteelName
        {
            get { return this.steelName; }
            set { this.steelName = value; }
        }

        /// <summary>
        /// 获取或设置钢网编号
        /// </summary>
        public String SteelCode
        {
            get { return this.steelCode; }
            set { this.steelCode = value; }
        }

        /// <summary>
        /// 获取或设置备用字段1
        /// </summary>
        public String Position
        {
            get { return this.position; }
            set { this.position = value; }
        }

        /// <summary>
        /// 获取或设置类型
        /// </summary>
        public Int32 CodeType
        {
            get { return this.codeType; }
            set { this.codeType = value; }
        }

        /// <summary>
        /// 获取或设置厚度
        /// </summary>
        public Decimal Thick
        {
            get { return this.thick; }
            set { this.thick = value; }
        }
        /// <summary>
        /// 获取或设置供应商
        /// </summary>
        public Int32 Vendor
        {
            get { return this.vendor; }
            set { this.vendor = value; }
        }
        /// <summary>
        /// 获取或设置入厂时间
        /// </summary>
        public DateTime EnterFactory
        {
            get { return this.enterFactory; }
            set { this.enterFactory = value; }
        }
        /// <summary>
        /// 获取或设置厂商条码编号
        /// </summary>
        public String VendorBarcode
        {
            get { return this.vendorBarcode; }
            set { this.vendorBarcode = value; }
        }
        /// <summary>
        /// 使用次数
        /// </summary>
        public Int32 UseCount
        {
            get { return this.useCount; }
            set { this.useCount = value; }
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
        public DateTime ModifyTime
        {
            get { return this.modifyTime; }
            set { this.modifyTime = value; }
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
        /// 供应商名称
        /// </summary>
        public String VendorName
        {
            get { return this.vendorName; }
            set { this.vendorName = value; }
        }
        public Int32 OutPeople
        {
            get { return this.outPeople; }
            set { this.outPeople = value; }
        }
        public Int32 InPeople
        {
            get { return this.inPeople; }
            set { this.inPeople = value; }
        }
        public String OutName
        {
            get { return this.outName; }
            set { this.outName = value; }
        }
        public String InName
        {
            get { return this.inName; }
            set { this.inName = value; }
        }
        public Int32 StandarLive
        {
            get { return this.standarLive; }
            set { this.standarLive = value; }
        }
    }
}