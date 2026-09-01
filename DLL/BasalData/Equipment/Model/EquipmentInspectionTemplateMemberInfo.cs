using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentInspectionTemplateMemberInfo
    {
        private Int32 inspectionTemplateMemberId;
        private Int32 inspectionTemplateId;
        private Int32 inspectionItemId;
        private Int32 sorting;
        private String maxValue;
        private String minValue;
        private String specialRequest;
        private Decimal samplingRate;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private string testMethod;
        private string checkFashion;
        private string inspectionResult;

        /// <summary>
        /// 是否上传图片
        /// </summary>
        public int IsUpLoadImg { get; set; }
        public string InspectionItemName { get; set; }      //检验项目名字
        public int InspectionOrderQty { get; set; }         //检验单个数
        public string ItemCode { get; set; }                //检验产品Code
        public string InspectionOrderNo { get; set; }       //检验单No
        public string InspectionAccording { get; set; }
        public int IOrderId { get; set; }                   //检验单ID
        public int IOMItemId { get; set; }

        public int IsPercentage { get; set; }               //检验单ID
        public int AQLRuleId { get; set; }
        public string AQLRuleName { get; set; }
        public string InspectJuge { get; set; }             //判定标准

        public string InspectionValue { get; set; }             //输入值


        /// <summary>
        /// 工序
        /// </summary>
        public string SaveOpenName { get; set; }
        /// <summary>
        /// 文件
        /// </summary>
        public string FUrlString { get; set; }
        /// <summary>
        /// 图片
        /// </summary>
        public string PUrlString { get; set; }

        /// <summary>
        /// 工序Id
        /// </summary>
        public int OpenID { get; set; }
        /// <summary>
        /// 工序名
        /// </summary>
        public string OpenName { get; set; }


        /// <summary>
        /// 录入方式
        /// </summary>
        public int InspectionMethodId { get; set; }
        /// <summary>
        /// 判定标准值
        /// </summary>
        public string InspectionMethodValue { get; set; }
        /// <summary>
        /// 单位
        /// </summary>
        public string UnitName { get; set; }

        /// <summary>
        /// 公差单位
        /// </summary>
        public string OffsetUnitName { get; set; }

        /// <summary>
        /// 检验方式
        /// </summary>
        public string CheckFashion
        {

            get { return this.checkFashion; }
            set { this.checkFashion = value; }
        }

        /// <summary>
        /// 检验结果
        /// </summary>
        public string InspectionResult
        {
            get { return this.inspectionResult; }
            set { this.inspectionResult = value; }
        }

        //备注
        public string NoteText { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionTemplateMemberInfo 类的新实例。
        /// </summary>
        public EquipmentInspectionTemplateMemberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionTemplateMemberInfo 类的新实例。
        /// </summary>
        /// <param name="inspectionTemplateMemberId"></param>
        /// <param name="inspectionTemplateId"></param>
        /// <param name="inspectionItemId"></param>
        /// <param name="sorting"></param>
        /// <param name="maxValue">最大值</param>
        /// <param name="minValue">最小值</param>
        /// <param name="specialRequest"></param>
        /// <param name="samplingRate">采样率</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public EquipmentInspectionTemplateMemberInfo(Int32 inspectionTemplateMemberId, Int32 inspectionTemplateId, Int32 inspectionItemId, Int32 sorting,
            String maxValue, String minValue, String specialRequest, Decimal samplingRate, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.inspectionTemplateMemberId = inspectionTemplateMemberId;
            this.inspectionTemplateId = inspectionTemplateId;
            this.inspectionItemId = inspectionItemId;
            this.sorting = sorting;
            this.maxValue = maxValue;
            this.minValue = minValue;
            this.specialRequest = specialRequest;
            this.samplingRate = samplingRate;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;


        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 InspectionTemplateMemberId
        {
            get { return this.inspectionTemplateMemberId; }
            set { this.inspectionTemplateMemberId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 InspectionTemplateId
        {
            get { return this.inspectionTemplateId; }
            set { this.inspectionTemplateId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 InspectionItemId
        {
            get { return this.inspectionItemId; }
            set { this.inspectionItemId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Sorting
        {
            get { return this.sorting; }
            set { this.sorting = value; }
        }

        /// <summary>
        /// 获取或设置最大值
        /// </summary>
        public String MaxValue
        {
            get { return this.maxValue; }
            set { this.maxValue = value; }
        }

        /// <summary>
        /// 获取或设置最小值
        /// </summary>
        public String MinValue
        {
            get { return this.minValue; }
            set { this.minValue = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SpecialRequest
        {
            get { return this.specialRequest; }
            set { this.specialRequest = value; }
        }

        /// <summary>
        /// 获取或设置采样率
        /// </summary>
        public Decimal SamplingRate
        {
            get { return this.samplingRate; }
            set { this.samplingRate = value; }
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
        /// 测试方法
        /// </summary>
        public string TestMethod
        {
            get { return this.testMethod; }
            set { this.testMethod = value; }
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
    }
}