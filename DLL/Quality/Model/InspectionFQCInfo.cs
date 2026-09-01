using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class InspectionFQCInfo
    {
        private Int64 inspectionFQCId;
        private String inspectionFQCNo;
        private Int32 stationId;
        private Int32 resourceId;
        private String itemId;
        private String sealantDate;
        private Decimal stationQty;
        private Decimal stationFactQty;
        private DateTime finishTime;
        private Int32 statue;
        private String result;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String printLv;
        private String proLine;
        private String inspectionUser;
        private String auditing;
        private DateTime checkDate;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionFQCInfo 类的新实例。
        /// </summary>
        public InspectionFQCInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionFQCInfo 类的新实例。
        /// </summary>
        /// <param name="inspectionFQCId">送检ID</param>
        /// <param name="inspectionFQCNo">送检批号</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="resourceId">资源ID</param>
        /// <param name="itemId">产品ID</param>
        /// <param name="sealantDate">封胶时间</param>
        /// <param name="stationQty">送检批数量</param>
        /// <param name="stationFactQty">实际送检批数量</param>
        /// <param name="finishTime">关批时间</param>
        /// <param name="statue">状态(0待关批,1已关批,2-处理中，3-已处理)</param>
        /// <param name="result">检查结果(Pass,Fail)</param>
        /// <param name="remark">备注</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="printLv">打印版本</param>
        /// <param name="proLine">生存线边</param>
        /// <param name="inspectionUser">检验员</param>
        /// <param name="auditing">审核</param>
        /// <param name="checkDate">检验日期</param>
        public InspectionFQCInfo(Int64 inspectionFQCId, String inspectionFQCNo, Int32 stationId, Int32 resourceId, 
            String itemId, String sealantDate, Decimal stationQty, Decimal stationFactQty, DateTime finishTime, 
            Int32 statue, String result, String remark, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, String printLv, String proLine, String inspectionUser, 
            String auditing, DateTime checkDate)
        {
            this.inspectionFQCId = inspectionFQCId;
            this.inspectionFQCNo = inspectionFQCNo;
            this.stationId = stationId;
            this.resourceId = resourceId;
            this.itemId = itemId;
            this.sealantDate = sealantDate;
            this.stationQty = stationQty;
            this.stationFactQty = stationFactQty;
            this.finishTime = finishTime;
            this.statue = statue;
            this.result = result;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.printLv = printLv;
            this.proLine = proLine;
            this.inspectionUser = inspectionUser;
            this.auditing = auditing;
            this.checkDate = checkDate;
        }

        /// <summary>
        /// 获取或设置送检ID
        /// </summary>
        public Int64 InspectionFQCId
        {
            get { return this.inspectionFQCId; }
            set { this.inspectionFQCId = value; }
        }

        /// <summary>
        /// 获取或设置送检批号
        /// </summary>
        public String InspectionFQCNo
        {
            get { return this.inspectionFQCNo; }
            set { this.inspectionFQCNo = value; }
        }

        /// <summary>
        /// 获取或设置工序ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置资源ID
        /// </summary>
        public Int32 ResourceId
        {
            get { return this.resourceId; }
            set { this.resourceId = value; }
        }

        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public String ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置封胶时间
        /// </summary>
        public String SealantDate
        {
            get { return this.sealantDate; }
            set { this.sealantDate = value; }
        }

        /// <summary>
        /// 获取或设置送检批数量
        /// </summary>
        public Decimal StationQty
        {
            get { return this.stationQty; }
            set { this.stationQty = value; }
        }

        /// <summary>
        /// 获取或设置实际送检批数量
        /// </summary>
        public Decimal StationFactQty
        {
            get { return this.stationFactQty; }
            set { this.stationFactQty = value; }
        }

        /// <summary>
        /// 获取或设置关批时间
        /// </summary>
        public DateTime FinishTime
        {
            get { return this.finishTime; }
            set { this.finishTime = value; }
        }

        /// <summary>
        /// 获取或设置状态(0待关批,1已关批,2-处理中，3-已处理)
        /// </summary>
        public Int32 Statue
        {
            get { return this.statue; }
            set { this.statue = value; }
        }

        /// <summary>
        /// 获取或设置检查结果(Pass,Fail)
        /// </summary>
        public String Result
        {
            get { return this.result; }
            set { this.result = value; }
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
        /// 获取或设置打印版本
        /// </summary>
        public String PrintLv
        {
            get { return this.printLv; }
            set { this.printLv = value; }
        }

        /// <summary>
        /// 获取或设置生存线边
        /// </summary>
        public String ProLine
        {
            get { return this.proLine; }
            set { this.proLine = value; }
        }

        /// <summary>
        /// 获取或设置检验员
        /// </summary>
        public String InspectionUser
        {
            get { return this.inspectionUser; }
            set { this.inspectionUser = value; }
        }

        /// <summary>
        /// 获取或设置审核
        /// </summary>
        public String Auditing
        {
            get { return this.auditing; }
            set { this.auditing = value; }
        }

        /// <summary>
        /// 获取或设置检验日期
        /// </summary>
        public DateTime CheckDate
        {
            get { return this.checkDate; }
            set { this.checkDate = value; }
        }

        /// <summary>
        /// 检验项列表
        /// </summary>
        public string CheckList { get; set; }
    }
}