using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class PurOrderInfo
    {
        private String factoryCode;
        private String pOID;
        private String pOCode;
        private DateTime purDate;
        private Int32 pOType;
        private Int32 venID;
        private String venCode;
        private Int32 busType;
        private String aDDRESS;
        private Int32 bondedType;
        private String personCode;
        private String depCode;
        private DateTime createDate;
        private Int32 pStatus;
        private DateTime modifyDate;
        private String remark;
        private DateTime default_1;
        private DateTime default_2;
        private Decimal default_3;
        private Decimal default_4;
        private String default_5;
        private String default_6;
        private String default_7;
        private String default_8;
        private String default_9;
        private String default_10;
        private Boolean isPeriod;
        private DateTime insertDateTime;
        private DateTime updateDateTime;
        private String modifyTime;
        private String vendorName;
        private String venUserName;
        private String venPhone;
        private String projectNo;
        private DateTime orderDate;
        private Decimal taxRate;
        private Decimal taxRateTotal;
        private String paymentTerms;
        private String paymentMethod;
        private String deliveryAddress;
        private int isMesAdd;
        private string createBy;
        private string modifyBy;



        public String VendorAddress { get; set; }
        public Int64 PurOrderId { get; set; }

        public String ReceiveType { get; set; }
        public String POTypeName { get; set; }

        /// <summary>
        /// 【创建人】显示中文名
        /// </summary>
        public string CreateByCName { get; set; }
        /// <summary>
        /// 交期维护
        /// </summary>
        public string SupplierDelivery { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public int OpenDataStatus { get; set; }
        /// <summary>
        /// 状态中文
        /// </summary>
        public string OpenDataStatusName { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PurOrderInfo 类的新实例。
        /// </summary>
        public PurOrderInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PurOrderInfo 类的新实例。
        /// </summary>
        /// <param name="factoryCode">工厂编号(MES集团多工厂标示,如ERP无该标示所有表统一传“1”)</param>
        /// <param name="pOID">采购订单ID</param>
        /// <param name="pOCode">采购订单编号</param>
        /// <param name="purDate">单据日期</param>
        /// <param name="pOType">采购类型	"1.采购订单2.委外订单"</param>
        /// <param name="venID">供应商ID 关联供应链标示</param>
        /// <param name="venCode">供应商编码 关联供应链标示</param>
        /// <param name="busType">业务类型</param>
        /// <param name="aDDRESS">送货地址</param>
        /// <param name="bondedType">是否保税</param>
        /// <param name="personCode">业务员</param>
        /// <param name="depCode">部门</param>
        /// <param name="createDate">建档日期</param>
        /// <param name="pStatus">MES采购订单状态：</param>
        /// <param name="modifyDate">变更日期 </param>
        /// <param name="remark">备注</param>
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
        /// <param name="isPeriod">是否供应商已经交期确认（0：没有 1：有）</param>
        /// <param name="insertDateTime">读取时间(Insert时间)</param>
        /// <param name="updateDateTime">修改时间</param>
        /// <param name="modifyTime"></param>
        /// <param name="vendorName">供应商名称</param>
        /// <param name="venUserName">供应商联系人</param>
        /// <param name="venPhone">供应商电话</param>
        /// <param name="projectNo">项目编号</param>
        /// <param name="orderDate">下单日期</param>
        /// <param name="taxRate">税率</param>
        /// <param name="taxRateTotal">含税合计</param>
        /// <param name="paymentTerms">付款条件</param>
        /// <param name="paymentMethod">交付方式</param>
        /// <param name="deliveryAddress">交货地址</param>
        public PurOrderInfo(String factoryCode, String pOID, String pOCode, DateTime purDate,
            Int32 pOType, Int32 venID, String venCode, Int32 busType, String aDDRESS,
            Int32 bondedType, String personCode, String depCode, DateTime createDate, Int32 pStatus,
            DateTime modifyDate, String remark, DateTime default_1, DateTime default_2, Decimal default_3,
            Decimal default_4, String default_5, String default_6, String default_7, String default_8,
            String default_9, String default_10, Boolean isPeriod, DateTime insertDateTime, DateTime updateDateTime,
            String modifyTime, String vendorName, String venUserName, String venPhone, String projectNo,
            DateTime orderDate, Decimal taxRate, Decimal taxRateTotal, String paymentTerms, String paymentMethod,
            String deliveryAddress, int isMesAdd)
        {
            this.factoryCode = factoryCode;
            this.pOID = pOID;
            this.pOCode = pOCode;
            this.purDate = purDate;
            this.pOType = pOType;
            this.venID = venID;
            this.venCode = venCode;
            this.busType = busType;
            this.aDDRESS = aDDRESS;
            this.bondedType = bondedType;
            this.personCode = personCode;
            this.depCode = depCode;
            this.createDate = createDate;
            this.pStatus = pStatus;
            this.modifyDate = modifyDate;
            this.remark = remark;
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
            this.isPeriod = isPeriod;
            this.insertDateTime = insertDateTime;
            this.updateDateTime = updateDateTime;
            this.modifyTime = modifyTime;
            this.vendorName = vendorName;
            this.venUserName = venUserName;
            this.venPhone = venPhone;
            this.projectNo = projectNo;
            this.orderDate = orderDate;
            this.taxRate = taxRate;
            this.taxRateTotal = taxRateTotal;
            this.paymentTerms = paymentTerms;
            this.paymentMethod = paymentMethod;
            this.deliveryAddress = deliveryAddress;
            this.isMesAdd = isMesAdd;
        }

        /// <summary>
        /// 获取或设置工厂编号(MES集团多工厂标示,如ERP无该标示所有表统一传“1”)
        /// </summary>
        public String FactoryCode
        {
            get { return this.factoryCode; }
            set { this.factoryCode = value; }
        }

        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }



        /// <summary>
        /// 获取或设置采购订单ID
        /// </summary>
        public String POID
        {
            get { return this.pOID; }
            set { this.pOID = value; }
        }

        /// <summary>
        /// 获取或设置采购订单编号
        /// </summary>
        public String POCode
        {
            get { return this.pOCode; }
            set { this.pOCode = value; }
        }

        /// <summary>
        /// 获取或设置单据日期
        /// </summary>
        public DateTime PurDate
        {
            get { return this.purDate; }
            set { this.purDate = value; }
        }

        /// <summary>
        /// 获取或设置采购类型	"1.采购订单2.委外订单"
        /// </summary>
        public Int32 POType
        {
            get { return this.pOType; }
            set { this.pOType = value; }
        }


        /// <summary>
        /// 来源 0 ERP 1 MES
        /// </summary>
        public int IsMesAdd
        {
            get { return this.isMesAdd; }
            set { this.isMesAdd = value; }
        }
        /// <summary>
        /// 获取或设置供应商ID 关联供应链标示
        /// </summary>
        public Int32 VenID
        {
            get { return this.venID; }
            set { this.venID = value; }
        }

        /// <summary>
        /// 获取或设置供应商编码 关联供应链标示
        /// </summary>
        public String VenCode
        {
            get { return this.venCode; }
            set { this.venCode = value; }
        }

        /// <summary>
        /// 获取或设置业务类型
        /// </summary>
        public Int32 BusType
        {
            get { return this.busType; }
            set { this.busType = value; }
        }

        /// <summary>
        /// 获取或设置送货地址
        /// </summary>
        public String ADDRESS
        {
            get { return this.aDDRESS; }
            set { this.aDDRESS = value; }
        }

        /// <summary>
        /// 获取或设置是否保税
        /// </summary>
        public Int32 BondedType
        {
            get { return this.bondedType; }
            set { this.bondedType = value; }
        }

        /// <summary>
        /// 获取或设置业务员
        /// </summary>
        public String PersonCode
        {
            get { return this.personCode; }
            set { this.personCode = value; }
        }

        /// <summary>
        /// 获取或设置部门
        /// </summary>
        public String DepCode
        {
            get { return this.depCode; }
            set { this.depCode = value; }
        }

        /// <summary>
        /// 获取或设置建档日期
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDate; }
            set { this.createDate = value; }
        }

        /// <summary>
        /// 获取或设置MES采购订单状态：
        /// </summary>
        public Int32 PStatus
        {
            get { return this.pStatus; }
            set { this.pStatus = value; }
        }

        /// <summary>
        /// 获取或设置变更日期 
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDate; }
            set { this.modifyDate = value; }
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
        /// 获取或设置预留字段
        /// </summary>
        public DateTime Default_1
        {
            get { return this.default_1; }
            set { this.default_1 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public DateTime Default_2
        {
            get { return this.default_2; }
            set { this.default_2 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public Decimal Default_3
        {
            get { return this.default_3; }
            set { this.default_3 = value; }
        }

        /// <summary>
        /// 获取或设置预留字段
        /// </summary>
        public Decimal Default_4
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
        /// 获取或设置是否供应商已经交期确认（0：没有 1：有）
        /// </summary>
        public Boolean IsPeriod
        {
            get { return this.isPeriod; }
            set { this.isPeriod = value; }
        }

        /// <summary>
        /// 获取或设置读取时间(Insert时间)
        /// </summary>
        public DateTime InsertDateTime
        {
            get { return this.insertDateTime; }
            set { this.insertDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime UpdateDateTime
        {
            get { return this.updateDateTime; }
            set { this.updateDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyTime
        {
            get { return this.modifyTime; }
            set { this.modifyTime = value; }
        }

        /// <summary>
        /// 获取或设置供应商名称
        /// </summary>
        public String VendorName
        {
            get { return this.vendorName; }
            set { this.vendorName = value; }
        }

        /// <summary>
        /// 获取或设置供应商联系人
        /// </summary>
        public String VenUserName
        {
            get { return this.venUserName; }
            set { this.venUserName = value; }
        }

        /// <summary>
        /// 获取或设置供应商电话
        /// </summary>
        public String VenPhone
        {
            get { return this.venPhone; }
            set { this.venPhone = value; }
        }

        /// <summary>
        /// 获取或设置项目编号
        /// </summary>
        public String ProjectNo
        {
            get { return this.projectNo; }
            set { this.projectNo = value; }
        }

        /// <summary>
        /// 获取或设置下单日期
        /// </summary>
        public DateTime OrderDate
        {
            get { return this.orderDate; }
            set { this.orderDate = value; }
        }

        /// <summary>
        /// 获取或设置税率
        /// </summary>
        public Decimal TaxRate
        {
            get { return this.taxRate; }
            set { this.taxRate = value; }
        }

        /// <summary>
        /// 获取或设置含税合计
        /// </summary>
        public Decimal TaxRateTotal
        {
            get { return this.taxRateTotal; }
            set { this.taxRateTotal = value; }
        }

        /// <summary>
        /// 获取或设置付款条件
        /// </summary>
        public String PaymentTerms
        {
            get { return this.paymentTerms; }
            set { this.paymentTerms = value; }
        }

        /// <summary>
        /// 获取或设置交付方式
        /// </summary>
        public String PaymentMethod
        {
            get { return this.paymentMethod; }
            set { this.paymentMethod = value; }
        }

        /// <summary>
        /// 获取或设置交货地址
        /// </summary>
        public String DeliveryAddress
        {
            get { return this.deliveryAddress; }
            set { this.deliveryAddress = value; }
        }


        /// <summary>
        /// 订单号
        /// </summary>
        public int CustomerOrderID { get; set; }
        public string IsMesAddName { get; set; }

        //上传文件的类
        public class FileInfo
        {
            /// <summary>
            /// 文件ID
            /// </summary>
            public int FileID { get; set; }

            /// <summary>
            /// 文件属性
            /// </summary>
            public string FileType { get; set; }

            /// <summary>
            /// 数据类型
            /// </summary>
            public string RowType { get; set; }

            /// <summary>
            /// 文件名称
            /// </summary>
            public string FileName { get; set; }

            /// <summary>
            /// 上传人
            /// </summary>
            public string CreateBy { get; set; }

            /// <summary>
            /// 上传时间
            /// </summary>
            public string CreateDateTime { get; set; }

            /// <summary>
            /// 保存名称
            /// </summary>
            public string FileSaveName { get; set; }
            /// <summary>
            /// 文件版本
            /// </summary>
            public string FileVersion { set; get; }
            /// <summary>
            /// 来源
            /// </summary>
            
        }
    }
}
