using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class InspectionOrderInfo
    {
        private Int32 iOrderId;
        private String itemCode;
        private Int32 inspectionTypeId;
        private String inspectionOrderNo;
        private String sourceTarget;
        private Int32 targetType;
        private String dealResult;
        private String inspectionResult;
        private Int32 inspectionQty;
        private Int32 qualifiedQty;
        private String inspectionUser;
        private DateTime startDatetime;
        private DateTime endDatetime;
        private Int32 statue;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private String statueResult;

        //add jacky.cheng 2016.5.26
        private Int32 checkedQty;
        private Int32 waitCheckQty;
        private Int32 amount;

        public string InspectionTypeName { get; set; }
        public string DealResultRemark { get; set; }
        public string ItemName { get; set; }
        public string AuditResult { get; set; }
        public string UploadFile { get; set; } //文件上传路径
        public string AuditRemark { get; set; }//审核备注
        public string FileName { get; set; }   //文件名称

        public string VendorCode { get; set; }
        public string VendorName { get; set; }

        public string OrderNo { get; set; }
        public int OrderQty { get; set; }
        public string LineName { get; set; }
        public string Station { get; set; }
        public string Class { get; set; }
        public string SendMan { get; set; }
        public int SampleQty { get; set; }
        public string ProjectAffirmRemark { get; set; }
        public string ProjectAffirmBy { get; set; }
        public int ProjectAffirmStatus { get; set; }
        public string ProjectAffirmStatusName { get; set; }

        public int GroupAffirmStatus { get; set; }
        public string GroupAffirmStatusName { get; set; }
        public string GroupAffirmBy { get; set; }
        public string GroupAffirmRemark { get; set; }
        public int AuditStatus { get; set; }
        public string AuditBy { get; set; }
        public string InspectionTemplateName { get; set; }

        public string AuditStatusName { get; set; }

        public string SoftwareVersion { get; set; }
        public string NavigationVersion { get; set; }
        public string MCUVersion { get; set; }
        public string MapVersion { get; set; }
        public string BluetoothName { get; set; }
        public string HardwareVersion { get; set; }
        public string BluetoothVersion { get; set; }
        public string CDBoxMPEG { get; set; }
        public string CDBoxMCU { get; set; }
        public string Version776 { get; set; }
        public string AQLName { get; set; }
        public string LineName2 { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionOrderInfo 类的新实例。
        /// </summary>
        public InspectionOrderInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionOrderInfo 类的新实例。
        /// </summary>
        /// <param name="iOrderId"></param>
        /// <param name="itemCode"></param>
        /// <param name="inspectionTypeId">1:IQC检验单  2:OQC检验单</param>
        /// <param name="inspectionOrderNo"></param>
        /// <param name="sourceTarget">单号</param>
        /// <param name="targetType">1:采购单 2:到货单 3:IQC检验单</param>
        /// <param name="dealResult">处理结果</param>
        /// <param name="inspectionResult">验检结果</param>
        /// <param name="inspectionQty">检验单的数量</param>
        /// <param name="qualifiedQty">合格数量</param>
        /// <param name="inspectionUser">检验人</param>
        /// <param name="startDatetime">检验开始时间</param>
        /// <param name="endDatetime">检验结束时间</param>
        /// <param name="statue"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public InspectionOrderInfo(Int32 iOrderId, String itemCode, Int32 inspectionTypeId, String inspectionOrderNo, 
            String sourceTarget, Int32 targetType, String dealResult, String inspectionResult, Int32 inspectionQty, 
            Int32 qualifiedQty, String inspectionUser, DateTime startDatetime, DateTime endDatetime, Int32 statue, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.iOrderId = iOrderId;
            this.itemCode = itemCode;
            this.inspectionTypeId = inspectionTypeId;
            this.inspectionOrderNo = inspectionOrderNo;
            this.sourceTarget = sourceTarget;
            this.targetType = targetType;
            this.dealResult = dealResult;
            this.inspectionResult = inspectionResult;
            this.inspectionQty = inspectionQty;
            this.qualifiedQty = qualifiedQty;
            this.inspectionUser = inspectionUser;
            this.startDatetime = startDatetime;
            this.endDatetime = endDatetime;
            this.statue = statue;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 IOrderId
        {
            get { return this.iOrderId; }
            set { this.iOrderId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 获取或设置1:IQC检验单  2:OQC检验单
        /// </summary>
        public Int32 InspectionTypeId
        {
            get { return this.inspectionTypeId; }
            set { this.inspectionTypeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String InspectionOrderNo
        {
            get { return this.inspectionOrderNo; }
            set { this.inspectionOrderNo = value; }
        }

        /// <summary>
        /// 获取或设置单号
        /// </summary>
        public String SourceTarget
        {
            get { return this.sourceTarget; }
            set { this.sourceTarget = value; }
        }

        /// <summary>
        /// 获取或设置1:采购单 2:到货单 3:IQC检验单
        /// </summary>
        public Int32 TargetType
        {
            get { return this.targetType; }
            set { this.targetType = value; }
        }

        /// <summary>
        /// 获取或设置处理结果
        /// </summary>
        public String DealResult
        {
            get { return this.dealResult; }
            set { this.dealResult = value; }
        }

        /// <summary>
        /// 获取或设置验检结果
        /// </summary>
        public String InspectionResult
        {
            get { return this.inspectionResult; }
            set { this.inspectionResult = value; }
        }

        /// <summary>
        /// 获取或设置检验单的数量
        /// </summary>
        public Int32 InspectionQty
        {
            get { return this.inspectionQty; }
            set { this.inspectionQty = value; }
        }

        /// <summary>
        /// 获取或设置合格数量
        /// </summary>
        public Int32 QualifiedQty
        {
            get { return this.qualifiedQty; }
            set { this.qualifiedQty = value; }
        }

        /// <summary>
        /// 获取或设置检验人
        /// </summary>
        public String InspectionUser
        {
            get { return this.inspectionUser; }
            set { this.inspectionUser = value; }
        }

        /// <summary>
        /// 获取或设置检验开始时间
        /// </summary>
        public DateTime StartDatetime
        {
            get { return this.startDatetime; }
            set { this.startDatetime = value; }
        }

        /// <summary>
        /// 获取或设置检验结束时间
        /// </summary>
        public DateTime EndDatetime
        {
            get { return this.endDatetime; }
            set { this.endDatetime = value; }
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

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        /// <summary>
        /// 状态结果
        /// </summary>
        public String StatueResult
        {
            get { return statueResult; }
            set { statueResult = value; }
        }
        /// <summary>
        /// 已检数量
        /// </summary>
        public Int32 CheckedQty
        {
            get { return checkedQty; }
            set { checkedQty = value; }
        }
        /// <summary>
        /// 待检数量
        /// </summary>
        public Int32 WaitCheckQty
        {
            get { return waitCheckQty; }
            set { waitCheckQty = value; }
        }
        /// <summary>
        /// 总数
        /// </summary>
        public Int32 Amount
        {
            get { return amount; }
            set { amount = value; }
        }

        public int ResourceId { get; set; }

        public string InspectionSelectType { get; set; }

        public int SystemType { get; set; }

        public string CPN {  get; set; }

        public DateTime? SYDate {  get; set; }

        public DateTime? JYDate{ get; set; }

        public int Result {  get; set; }

        /// <summary>
        /// 模具编码
        /// </summary>
        public string MoudleCode { get; set; }

        /// <summary>
        /// 烘料温度设定
        /// </summary>
        public string DryingMaterialTemperature { get; set; }

        /// <summary>
        /// 热流道温度设定
        /// </summary>
        public string HotRunnerTemperature { get; set; }

        /// <summary>
        /// 料管温度1
        /// </summary>
        public string BarrelTemperature1 { get; set; }

        /// <summary>
        /// 料管温度2
        /// </summary>
        public string BarrelTemperature2 { get; set; }

        /// <summary>
        /// 料管温度3
        /// </summary>
        public string BarrelTemperature3 { get; set; }

        /// <summary>
        /// 料管温度4
        /// </summary>
        public string BarrelTemperature4 { get; set; }

        /// <summary>
        /// 料管温度5
        /// </summary>
        public string BarrelTemperature5 { get; set; }

        /// <summary>
        /// 模具温度(依实测)-动模
        /// </summary>
        public string MoldTemperatureDynamic { get; set; }

        /// <summary>
        /// 模具温度(依实测)-静模
        /// </summary>
        public string MoldTemperatureStatic { get; set; }

        /// <summary>
        /// 原料编码
        /// </summary>
        public string MaterialItemCode { get; set; }

        /// <summary>
        /// 原料名称
        /// </summary>
        public string MaterialItemName { get; set; }

        /// <summary>
        /// 原料规格
        /// </summary>
        public string MaterialItemSpec { get; set; }

        /// <summary>
        /// 原料批次号
        /// </summary>
        public string MaterialItemLot { get; set; }
    }
}