using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class IQCBatchInfo
    {
        private Int32 iQCBatchId;
        private String iQCBatchNO;
        private Int32 auditResult;
        private String pO;
        private Int32 itemId;
        private String remark;
        private String memo;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;
        private Int32 iQCType;

        private String itemName;
        private String itemCode;

        private Int32 checkedQty;
        private Int32 waitCheckQty;
        private Int32 amount;

        private Int32 currentItemId;

        private Int32 vouchRowNO;
        private Int32 autoId;
        private String itemDesc;
        private String specification;
        private String units;
        private Double qty;
        private Double qualifiedQty;
        private string flagName;
        private string isNeedPrintcChar;
        private string isVendorPrintChar;
        private Double printGrnQty;
        private Double gRNGetQty;
        private string manageResult;
        private string manageResult_CN;
        private string venCode;
        private string venName;
        private Double pAQty;
        private Double eRPQty;
        private Double storageQty;
        /// <summary>
        /// 已打印数量 陆文元 20106-02-23加
        /// </summary>
        private int printedQty;
        public int PrintedQty
        {
            get { return printedQty; }
            set { printedQty = value; }
        }
        /// <summary>
        /// 初始化 SKT.MES.Model.BATCHInfo 类的新实例。
        /// </summary>
        public IQCBatchInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.BATCHInfo 类的新实例。
        /// </summary>
        /// <param name="iQCBatchId">iQCBatchId号</param>
        /// <param name="iQCBatchNO">送检批次号</param>
        /// <param name="auditResult">批次抽检结果：-1 : 未完成 1：批过；2：批退 3：让步通过</param>
        /// <param name="pO">采购单号</param>
        /// <param name="itemId">物料ID</param>
        /// <param name="remark">备注</param>
        /// <param name="memo">备用字段</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改者</param>
        /// <param name="iQCType">检验单类型</param>
        public IQCBatchInfo(Int32 iQCBatchId, String iQCBatchNO, Int32 auditResult, String pO,
            Int32 itemId, String remark, String memo, DateTime createDateTime, String createBy,
            DateTime modifyDateTime, String modifyBy, Int32 iQCType)
        {
            this.iQCBatchId = iQCBatchId;
            this.iQCBatchNO = iQCBatchNO;
            this.auditResult = auditResult;
            this.pO = pO;
            this.itemId = itemId;
            this.remark = remark;
            this.memo = memo;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.iQCType = iQCType;
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.BATCHInfo 类的新实例。
        /// </summary>
        /// <param name="iQCBatchId">iQCBatchId号</param>
        /// <param name="iQCBatchNO">送检批次号</param>
        /// <param name="auditResult">批次抽检结果：-1 : 未完成 1：批过；2：批退 3：让步通过</param>
        /// <param name="pO">采购单号</param>
        /// <param name="itemName">物料名</param>
        /// <param name="iQCType">抽检单抽检类型</param>
        /// <param name="memo">备用字段</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public IQCBatchInfo(Int32 iQCBatchId, String iQCBatchNO, Int32 auditResult, String pO,
            String itemName, Int32 iQCType, String memo, DateTime createDateTime, String createBy)
        {
            this.iQCBatchId = iQCBatchId;
            this.iQCBatchNO = iQCBatchNO;
            this.auditResult = auditResult;
            this.pO = pO;
            this.itemName = itemName;
            this.iQCType = iQCType;
            this.memo = memo;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }


        /// <summary>
        /// 获取或设置IQCBatchId号
        /// </summary>
        public Int32 IQCBatchId
        {
            get { return this.iQCBatchId; }
            set { this.iQCBatchId = value; }
        }

        /// <summary>
        /// 获取或设置送检批次号
        /// </summary>
        public String IQCBatchNO
        {
            get { return this.iQCBatchNO; }
            set { this.iQCBatchNO = value; }
        }

        /// <summary>
        /// 获取或设置批次抽检结果：-1 : 未完成 0：批过；1：批退 2：让步通过
        /// </summary>
        public Int32 AuditResult
        {
            get { return this.auditResult; }
            set { this.auditResult = value; }
        }

        /// <summary>
        /// 获取或设置采购单号
        /// </summary>
        public String PO
        {
            get { return this.pO; }
            set { this.pO = value; }
        }

        /// <summary>
        /// 获取或设置物料ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
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
        /// 获取或设置备用字段
        /// </summary>
        public String Memo
        {
            get { return this.memo; }
            set { this.memo = value; }
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
        /// 获取或设置创建者
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
        /// 获取或设置修改者
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }


        /// <summary>
        /// 获取或设置抽检单类型 -1 未知 1 全检  2 抽检  3 免检
        /// </summary>
        public Int32 IQCType
        {
            get { return this.iQCType; }
            set { this.iQCType = value; }
        }

        /// <summary>
        /// 获取或设置物料名
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 获取或设置物料名
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 已检数量
        /// </summary>
        public Int32 CheckedQty
        {
            get { return this.checkedQty; }
            set { this.checkedQty = value; }
        }

        /// <summary>
        /// 待检数量
        /// </summary>
        public Int32 WaitCheckQty
        {
            get { return this.waitCheckQty; }
            set { this.waitCheckQty = value; }
        }

        /// <summary>
        /// 检验总数
        /// </summary>
        public Int32 Amount
        {
            get { return this.amount; }
            set { this.amount = value; }
        }


        /// <summary>
        /// 获取或设置物料ID 用于比较
        /// </summary>
        public Int32 CurrentItemId
        {
            get { return this.currentItemId; }
            set { this.currentItemId = value; }
        }

        /// <summary>
        /// 获取 到货单明细 中的行号
        /// </summary>
        public Int32 VouchRowNO
        {
            get { return this.vouchRowNO; }
            set { this.vouchRowNO = value; }
        }


        /// <summary>
        /// 获取 到货单明细 中的记录Id
        /// </summary>
        public Int32 AutoId
        {
            get { return this.autoId; }
            set { this.autoId = value; }
        }

        /// <summary>
        /// 物料描述
        /// </summary>
        public String ItemDesc
        {
            get { return this.itemDesc; }
            set { this.itemDesc = value; }
        }

        /// <summary>
        /// 规格
        /// </summary>
        public String Specification
        {
            get { return this.specification; }
            set { this.specification = value; }
        }

        /// <summary>
        /// 单位
        /// </summary>
        public String Units
        {
            get { return this.units; }
            set { this.units = value; }
        }

        /// <summary>
        /// 数量
        /// </summary>
        public Double Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }
        /// <summary>
        /// 状态
        /// </summary>
        public string FlagName
        {
            get { return this.flagName; }
            set { this.flagName = value; }
        }

        public Double QualifiedQty
        {
            get { return this.qualifiedQty; }
            set { this.qualifiedQty = value; }
        }
        /// <summary>
        /// 是否厂商打条码
        /// </summary>
        public string IsNeedPrintcChar
        {
            get { return this.isNeedPrintcChar; }
            set { this.isNeedPrintcChar = value; }
        }
        /// <summary>
        /// 是否供应商打条码
        /// </summary>
        public string IsVendorPrintChar
        {
            get { return this.isVendorPrintChar; }
            set { this.isVendorPrintChar = value; }

        }
        /// <summary>
        /// GRN条码数
        /// </summary>
        public Double PrintGrnQty
        {
            get { return this.printGrnQty; }
            set { this.printGrnQty = value; }
        }

        /// <summary>
        /// GRN条码数
        /// </summary>
        public Double GRNGetQty
        {
            get { return this.gRNGetQty; }
            set { this.gRNGetQty = value; }
        }

        /// <summary>
        /// 处理结果
        /// </summary>
        public string ManageResult
        {
            get { return this.manageResult; }
            set { this.manageResult = value; }
        }

        /// <summary>
        /// 处理结果
        /// </summary>
        public string ManageResult_CN
        {
            get { return this.manageResult_CN; }
            set { this.manageResult_CN = value; }
        }

        /// <summary>
        /// 供应商代码
        /// </summary>
        public string VenCode
        {
            get { return this.venCode; }
            set { this.venCode = value; }
        }


        /// <summary>
        /// 供应商名称
        /// </summary>
        public string VenName
        {
            get { return this.venName; }
            set { this.venName = value; }
        }
        /// <summary>
        /// ERP同步过来的检验合格数
        /// </summary>
        public Double PAQty
        {
            get { return this.pAQty; }
            set { this.pAQty = value; }
        }

        /// <summary>
        /// 已入库数量
        /// </summary>
        public Double ERPQty
        {
            get { return this.eRPQty; }
            set { this.eRPQty = value; }
        }


        /// <summary>
        /// 入库数量
        /// </summary>
        public Double StorageQty
        {
            get { return this.storageQty; }
            set { this.storageQty = value; }
        }





    }

    /// <summary>
    /// 检验单抽检结果
    /// </summary>
    public enum AuditResult
    {
        /// <summary>
        /// 未完成
        /// </summary>
        NotComplete = -1,

        /// <summary>
        /// 批次通过
        /// </summary>
        BatchPass = 1,

        /// <summary>
        /// 批次退货
        /// </summary>
        BatchReturn = 2,

        /// <summary>
        /// 免检
        /// </summary>
        ConcessionUse = 3
    }


    /// <summary>
    /// 检验单抽检类型
    /// </summary>
    public enum IQCType
    {
        /// <summary>
        /// 未知
        /// </summary>
        Unknown = -1,

        /// <summary>
        /// 全检
        /// </summary>
        AllCheck = 1,

        /// <summary>
        /// 抽检
        /// </summary>
        PartCheck = 2,

        /// <summary>
        /// 免检
        /// </summary>
        ExemptionCheck = 3
    }
}