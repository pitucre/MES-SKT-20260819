using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class PurOrderDtlInfo
    {
        private String factoryCode;
        private String autoID;
        private Int64 pOID;
        private Int32 pOType;
        private String pOCode;
        private decimal pURQty;
        private decimal recQty;
        private decimal inStkQty;
        private decimal aScanQty;
        private Int32 itemID;
        private String itemCode;
        private String uOM;
        private DateTime planDate;
        private DateTime affirmDate;
        private Double taxRate;
        private Double totalPriceTC;
        private Double totalMnyTC;
        private Double netPriceTC;
        private Double netMnyTC;
        private Int32 pStatus;
        private Int32 sourceTranType;
        private Int32 sourceInterID;
        private String sourceBillNo;
        private String sOCode;
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
        private DateTime insertDateTime;
        private DateTime updateDateTime;
        private Boolean isActive;
        private String modifyTime;
        private String brandName;
        private Decimal unitPrice;
        private Decimal totalPrice;
        private DateTime deliveryDate;

        /// <summary>
        /// 行状态
        /// </summary>
        public int OpenDataStatus { set; get; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PurOrderDtlInfo 类的新实例。
        /// </summary>
        public PurOrderDtlInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PurOrderDtlInfo 类的新实例。
        /// </summary>
        /// <param name="factoryCode">工厂编号(MES集团多工厂标示,如ERP无该标示所有表统一传“1”)</param>
        /// <param name="autoID">订单明细ID</param>
        /// <param name="pOID">采购订单ID	关联主表标示</param>
        /// <param name="pOType"></param>
        /// <param name="pOCode">采购订单编号</param>
        /// <param name="pURQty">采购数量</param>
        /// <param name="recQty">计划到货数量</param>
        /// <param name="inStkQty">入库数量</param>
        /// <param name="aScanQty">每次已扫描数量</param>
        /// <param name="itemID">产品ID 关联产品标示</param>
        /// <param name="itemCode">产品编号 关联产品标示</param>
        /// <param name="uOM">单位</param>
        /// <param name="planDate">计划到货日期</param>
        /// <param name="affirmDate">确认日期</param>
        /// <param name="taxRate"></param>
        /// <param name="totalPriceTC"></param>
        /// <param name="totalMnyTC"></param>
        /// <param name="netPriceTC"></param>
        /// <param name="netMnyTC"></param>
        /// <param name="pStatus">MES在其中的明细状态(1:未收料 2:已收料)</param>
        /// <param name="sourceTranType"></param>
        /// <param name="sourceInterID"></param>
        /// <param name="sourceBillNo"></param>
        /// <param name="sOCode"></param>
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
        /// <param name="insertDateTime">读取时间(Insert时间)</param>
        /// <param name="updateDateTime">修改时间</param>
        /// <param name="isActive">是否有效:0表示无效,1表示有效</param>
        /// <param name="modifyTime"></param>
        /// <param name="brandName">品牌名称</param>
        /// <param name="unitPrice">单价</param>
        /// <param name="totalPrice">总 价</param>
        /// <param name="deliveryDate">交期</param>
        public PurOrderDtlInfo(String factoryCode, String autoID, Int32 pOID, Int32 pOType,
            String pOCode, decimal pURQty, decimal recQty, decimal inStkQty, Decimal aScanQty,
            Int32 itemID, String itemCode, String uOM, DateTime planDate, DateTime affirmDate,
            Double taxRate, Double totalPriceTC, Double totalMnyTC, Double netPriceTC, Double netMnyTC,
            Int32 pStatus, Int32 sourceTranType, Int32 sourceInterID, String sourceBillNo, String sOCode,
            DateTime modifyDate, String remark, DateTime default_1, DateTime default_2, Decimal default_3,
            Decimal default_4, String default_5, String default_6, String default_7, String default_8,
            String default_9, String default_10, DateTime insertDateTime, DateTime updateDateTime, Boolean isActive,
            String modifyTime, String brandName, Decimal unitPrice, Decimal totalPrice, DateTime deliveryDate)
        {
            this.factoryCode = factoryCode;
            this.autoID = autoID;
            this.pOID = pOID;
            this.pOType = pOType;
            this.pOCode = pOCode;
            this.pURQty = pURQty;
            this.recQty = recQty;
            this.inStkQty = inStkQty;
            this.aScanQty = aScanQty;
            this.itemID = itemID;
            this.itemCode = itemCode;
            this.uOM = uOM;
            this.planDate = planDate;
            this.affirmDate = affirmDate;
            this.taxRate = taxRate;
            this.totalPriceTC = totalPriceTC;
            this.totalMnyTC = totalMnyTC;
            this.netPriceTC = netPriceTC;
            this.netMnyTC = netMnyTC;
            this.pStatus = pStatus;
            this.sourceTranType = sourceTranType;
            this.sourceInterID = sourceInterID;
            this.sourceBillNo = sourceBillNo;
            this.sOCode = sOCode;
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
            this.insertDateTime = insertDateTime;
            this.updateDateTime = updateDateTime;
            this.isActive = isActive;
            this.modifyTime = modifyTime;
            this.brandName = brandName;
            this.unitPrice = unitPrice;
            this.totalPrice = totalPrice;
            this.deliveryDate = deliveryDate;
        }

        /// <summary>
        /// 获取或设置工厂编号(MES集团多工厂标示,如ERP无该标示所有表统一传“1”)
        /// </summary>
        public String FactoryCode
        {
            get { return this.factoryCode; }
            set { this.factoryCode = value; }
        }

        /// <summary>
        /// 获取或设置订单明细ID
        /// </summary>
        public String AutoID
        {
            get { return this.autoID; }
            set { this.autoID = value; }
        }

        /// <summary>
        /// 获取或设置采购订单ID	关联主表标示
        /// </summary>
        public Int64 POID
        {
            get { return this.pOID; }
            set { this.pOID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 POType
        {
            get { return this.pOType; }
            set { this.pOType = value; }
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
        /// 获取或设置采购数量
        /// </summary>
        public decimal PURQty
        {
            get { return this.pURQty; }
            set { this.pURQty = value; }
        }

        /// <summary>
        /// 获取或设置计划到货数量
        /// </summary>
        public decimal RecQty
        {
            get { return this.recQty; }
            set { this.recQty = value; }
        }

        /// <summary>
        /// 获取或设置入库数量
        /// </summary>
        public decimal InStkQty
        {
            get { return this.inStkQty; }
            set { this.inStkQty = value; }
        }

        /// <summary>
        /// 获取或设置每次已扫描数量
        /// </summary>
        public Decimal AScanQty
        {
            get { return this.aScanQty; }
            set { this.aScanQty = value; }
        }

        /// <summary>
        /// 获取或设置产品ID 关联产品标示
        /// </summary>
        public Int32 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置产品编号 关联产品标示
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 获取或设置产品编号 关联产品标示
        /// </summary>
        public string ItemName { get; set; }


        /// <summary>
        /// 获取或设置产品编号 关联产品标示
        /// </summary>
        public String Units { get; set; }

        /// <summary>
        /// 获取或设置产品编号 关联产品标示
        /// </summary>
        public string ItemSpec { get; set; }

        /// <summary>
        /// 获取或设置单位
        /// </summary>
        public String UOM
        {
            get { return this.uOM; }
            set { this.uOM = value; }
        }

        /// <summary>
        /// 获取或设置计划到货日期
        /// </summary>
        public DateTime PlanDate
        {
            get { return this.planDate; }
            set { this.planDate = value; }
        }

        /// <summary>
        /// 获取或设置确认日期
        /// </summary>
        public DateTime AffirmDate
        {
            get { return this.affirmDate; }
            set { this.affirmDate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double TaxRate
        {
            get { return this.taxRate; }
            set { this.taxRate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double TotalPriceTC
        {
            get { return this.totalPriceTC; }
            set { this.totalPriceTC = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double TotalMnyTC
        {
            get { return this.totalMnyTC; }
            set { this.totalMnyTC = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double NetPriceTC
        {
            get { return this.netPriceTC; }
            set { this.netPriceTC = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double NetMnyTC
        {
            get { return this.netMnyTC; }
            set { this.netMnyTC = value; }
        }

        /// <summary>
        /// 获取或设置MES在其中的明细状态(1:未收料 2:已收料)
        /// </summary>
        public Int32 PStatus
        {
            get { return this.pStatus; }
            set { this.pStatus = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SourceTranType
        {
            get { return this.sourceTranType; }
            set { this.sourceTranType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SourceInterID
        {
            get { return this.sourceInterID; }
            set { this.sourceInterID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SourceBillNo
        {
            get { return this.sourceBillNo; }
            set { this.sourceBillNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SOCode
        {
            get { return this.sOCode; }
            set { this.sOCode = value; }
        }

        /// <summary>
        /// 获取或设置变更日期 
        /// </summary>
        public DateTime ModifyDate
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
        /// 获取或设置是否有效:0表示无效,1表示有效
        /// </summary>
        public Boolean IsActive
        {
            get { return this.isActive; }
            set { this.isActive = value; }
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
        /// 获取或设置品牌名称
        /// </summary>
        public String BrandName
        {
            get { return this.brandName; }
            set { this.brandName = value; }
        }

   
      


        /// <summary>
        /// 获取或设置单价
        /// </summary>
        public Decimal UnitPrice
        {
            get { return this.unitPrice; }
            set { this.unitPrice = value; }
        }

        /// <summary>
        /// 获取或设置总 价
        /// </summary>
        public Decimal TotalPrice
        {
            get { return this.totalPrice; }
            set { this.totalPrice = value; }
        }

        /// <summary>
        /// 获取或设置交期
        /// </summary>
        public DateTime DeliveryDate
        {
            get { return this.deliveryDate; }
            set { this.deliveryDate = value; }
        }
    }
}
