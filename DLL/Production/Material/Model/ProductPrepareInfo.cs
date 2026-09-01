using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ProductPrepareInfo
    {
        private Int64 productPrepareId;
        private String factoryCode;
        private String productPrepareNo;
        private Int32 orderType;
        private String sourceNo;
        private Int64 whID;
        private String whCode;
        private String venCode;
        private String cusCode;
        private String personCode;
        private String depCode;
        private String chkPerson;
        private String wherson;
        private Int32 statue;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public Int64 ID { set; get; }
        public String Code { set; get; }
        public DateTime Date { set; get; }
        public String RdType { set; get; }
        public String ProductDtl { set; get; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProductPrepareInfo 类的新实例。
        /// </summary>
        public ProductPrepareInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProductPrepareInfo 类的新实例。
        /// </summary>
        /// <param name="productPrepareId"></param>
        /// <param name="factoryCode"></param>
        /// <param name="productPrepareNo"></param>
        /// <param name="orderType"></param>
        /// <param name="sourceNo"></param>
        /// <param name="whID"></param>
        /// <param name="whCode"></param>
        /// <param name="venCode"></param>
        /// <param name="cusCode"></param>
        /// <param name="personCode"></param>
        /// <param name="depCode"></param>
        /// <param name="chkPerson"></param>
        /// <param name="wherson"></param>
        /// <param name="statue"></param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public ProductPrepareInfo(Int64 productPrepareId, String factoryCode, String productPrepareNo, Int32 orderType, 
            String sourceNo, Int64 whID, String whCode, String venCode, String cusCode, 
            String personCode, String depCode, String chkPerson, String wherson, Int32 statue, 
            String remark, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.productPrepareId = productPrepareId;
            this.factoryCode = factoryCode;
            this.productPrepareNo = productPrepareNo;
            this.orderType = orderType;
            this.sourceNo = sourceNo;
            this.whID = whID;
            this.whCode = whCode;
            this.venCode = venCode;
            this.cusCode = cusCode;
            this.personCode = personCode;
            this.depCode = depCode;
            this.chkPerson = chkPerson;
            this.wherson = wherson;
            this.statue = statue;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 ProductPrepareId
        {
            get { return this.productPrepareId; }
            set { this.productPrepareId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FactoryCode
        {
            get { return this.factoryCode; }
            set { this.factoryCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ProductPrepareNo
        {
            get { return this.productPrepareNo; }
            set { this.productPrepareNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 OrderType
        {
            get { return this.orderType; }
            set { this.orderType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SourceNo
        {
            get { return this.sourceNo; }
            set { this.sourceNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 WhID
        {
            get { return this.whID; }
            set { this.whID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String WhCode
        {
            get { return this.whCode; }
            set { this.whCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String VenCode
        {
            get { return this.venCode; }
            set { this.venCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CusCode
        {
            get { return this.cusCode; }
            set { this.cusCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PersonCode
        {
            get { return this.personCode; }
            set { this.personCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DepCode
        {
            get { return this.depCode; }
            set { this.depCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ChkPerson
        {
            get { return this.chkPerson; }
            set { this.chkPerson = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Wherson
        {
            get { return this.wherson; }
            set { this.wherson = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Statue
        {
            get { return this.statue; }
            set { this.statue = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}