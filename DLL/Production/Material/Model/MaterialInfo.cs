using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class MaterialInfo
    {
        private Int32 materialId;
        private Int32 factoryCode;
        private String materialNO;
        private String materialName;
        private String materialModel;
        private Int32 statusCode;
        private String status;
        private DateTime createDateTime;
        private String createBy;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private String remark1;
        private String remark2;
        private String remark3;
        private String remark4;
        private String remark5;
        private String remark6;
        private String remark7;

        private Int32 receiveType;
        private Boolean isScanGRN;
        private String poCode;
        private String userName;
        private Int32 urgentLevel;

        public string StatusName { get; set; }
        public String ReturnOrderNo { get; set; }
        public String DepartName { get; set; }
        public string CreateDateTime { get; set; }
        public String ItemCode { get; set; }
        public string ItemName { get; set; }
        public int ItemId { get; set; }
        public decimal ReturnQty { get; set; }
        public decimal ReceiveQty { get; set; }
        public string UpdateTime { get; set; }
        public int DeptID { set; get; }
        public int ItemNum { set; get; }
        public string StatusDesc { set; get; }
        public string UpdateBy { set; get; }
        public string ModifyDateTime { set; get; }
        /// <summary>
        /// GRBJson字串
        /// </summary>
        public String POTabDtl { get; set; }
        public dynamic ERPReBillID { get; set; }
        public dynamic SourceBillNo { get; set; }
        public dynamic CWhName { get; set; }
        public dynamic ProdOrderNo { get; set; }
        public dynamic VendorName { get; set; }
        public dynamic VendorCode { get; set; }
        public dynamic RtvDtlID { get; set; }
        public dynamic ReturnOrder { get; set; }
        public dynamic ReturnDate { get; set; }
        public dynamic FinishStatus { get; set; }
        public dynamic SourceEntryID { get; set; }
        public dynamic AutoID { get; set; }
        public Int64 InspectionId { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialInfo 类的新实例。
        /// </summary>
        public MaterialInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialInfo 类的新实例。
        /// </summary>
        /// <param name="materialId">自动增长列</param>
        /// <param name="factoryCode">工厂代码 1001深圳，1002惠州</param>
        /// <param name="materialNO">物料代码</param>
        /// <param name="materialName">物料名称</param>
        /// <param name="materialModel">物料规格型号</param>
        /// <param name="statusCode">物料状态代码</param>
        /// <param name="status">物料状态</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        /// <param name="remark1">备用字段</param>
        /// <param name="remark2">备用字段</param>
        /// <param name="remark3">备用字段</param>
        /// <param name="remark4">备用字段</param>
        /// <param name="remark5">备用字段</param>
        /// <param name="remark6">备用字段</param>
        /// <param name="remark7">备用字段</param>
        public MaterialInfo(Int32 materialId, Int32 factoryCode, String materialNO, String materialName, 
            String materialModel, Int32 statusCode, String status, DateTime createDateTime, String createBy, 
            String modifyBy, DateTime modifyDateTime, String remark, String remark1, String remark2, 
            String remark3, String remark4, String remark5, String remark6, String remark7)
        {
            this.materialId = materialId;
            this.factoryCode = factoryCode;
            this.materialNO = materialNO;
            this.materialName = materialName;
            this.materialModel = materialModel;
            this.statusCode = statusCode;
            this.status = status;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.remark1 = remark1;
            this.remark2 = remark2;
            this.remark3 = remark3;
            this.remark4 = remark4;
            this.remark5 = remark5;
            this.remark6 = remark6;
            this.remark7 = remark7;
        }


        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ReceiveType
        {
            get { return this.receiveType; }
            set { this.receiveType = value; }
        }

        public Boolean IsScanGRN
        {
            get { return this.isScanGRN; }
            set { this.isScanGRN = value; }
        }

        public String PoCode
        {
            get { return this.poCode; }
            set { this.poCode = value; }
        }

        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }

        public Int32 UrgentLevel
        {
            get { return this.urgentLevel; }
            set { this.urgentLevel = value; }
        }
        /// <summary>
        /// 获取或设置自动增长列
        /// </summary>
        public Int32 MaterialId
        {
            get { return this.materialId; }
            set { this.materialId = value; }
        }

        /// <summary>
        /// 获取或设置工厂代码 1001深圳，1002惠州
        /// </summary>
        public Int32 FactoryCode
        {
            get { return this.factoryCode; }
            set { this.factoryCode = value; }
        }

        /// <summary>
        /// 获取或设置物料代码
        /// </summary>
        public String MaterialNO
        {
            get { return this.materialNO; }
            set { this.materialNO = value; }
        }

        /// <summary>
        /// 获取或设置物料名称
        /// </summary>
        public String MaterialName
        {
            get { return this.materialName; }
            set { this.materialName = value; }
        }

        /// <summary>
        /// 获取或设置物料规格型号
        /// </summary>
        public String MaterialModel
        {
            get { return this.materialModel; }
            set { this.materialModel = value; }
        }

        /// <summary>
        /// 获取或设置物料状态代码
        /// </summary>
        public Int32 StatusCode
        {
            get { return this.statusCode; }
            set { this.statusCode = value; }
        }

        /// <summary>
        /// 获取或设置物料状态
        /// </summary>
        public String Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        ///// <summary>
        ///// 获取或设置创建时间
        ///// </summary>
        //public DateTime CreateDateTime
        //{
        //    get { return this.createDateTime; }
        //    set { this.createDateTime = value; }
        //}

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        ///// <summary>
        ///// 获取或设置修改时间
        ///// </summary>
        //public DateTime ModifyDateTime
        //{
        //    get { return this.modifyDateTime; }
        //    set { this.modifyDateTime = value; }
        //}

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置备用字段
        /// </summary>
        public String Remark1
        {
            get { return this.remark1; }
            set { this.remark1 = value; }
        }

        /// <summary>
        /// 获取或设置备用字段
        /// </summary>
        public String Remark2
        {
            get { return this.remark2; }
            set { this.remark2 = value; }
        }

        /// <summary>
        /// 获取或设置备用字段
        /// </summary>
        public String Remark3
        {
            get { return this.remark3; }
            set { this.remark3 = value; }
        }

        /// <summary>
        /// 获取或设置备用字段
        /// </summary>
        public String Remark4
        {
            get { return this.remark4; }
            set { this.remark4 = value; }
        }

        /// <summary>
        /// 获取或设置备用字段
        /// </summary>
        public String Remark5
        {
            get { return this.remark5; }
            set { this.remark5 = value; }
        }

        /// <summary>
        /// 获取或设置备用字段
        /// </summary>
        public String Remark6
        {
            get { return this.remark6; }
            set { this.remark6 = value; }
        }

        /// <summary>
        /// 获取或设置备用字段
        /// </summary>
        public String Remark7
        {
            get { return this.remark7; }
            set { this.remark7 = value; }
        }

        /// <summary>
        /// 修改时间
        /// </summary>
        public string ModifyByTime2 { get; set; }
    }
}