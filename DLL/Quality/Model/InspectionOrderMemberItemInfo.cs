using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class InspectionOrderMemberItemInfo
    {
        private Int32 iOMItemId;
        private Int32 iOrderId;
        private Int32 iOMemberId;
        private String inspectionItemName;
        private String standardMaxValue;
        private String standardMinValue;
        private String inspectionAccording;
        private String specialRequest;
        private String inspectionValue;
        private String inspectionResult;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        public int SamplingCount;
        public int RecordCount;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionOrderMemberItemInfo 类的新实例。
        /// </summary>
        public InspectionOrderMemberItemInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionOrderMemberItemInfo 类的新实例。
        /// </summary>
        /// <param name="iOMItemId"></param>
        /// <param name="iOrderId"></param>
        /// <param name="iOMemberId"></param>
        /// <param name="inspectionItemName">检验项目名称</param>
        /// <param name="standardMaxValue">最大值</param>
        /// <param name="standardMinValue">最小值</param>
        /// <param name="inspectionAccording"></param>
        /// <param name="specialRequest"></param>
        /// <param name="inspectionValue"></param>
        /// <param name="inspectionResult"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public InspectionOrderMemberItemInfo(Int32 iOMItemId, Int32 iOrderId, Int32 iOMemberId, String inspectionItemName, 
            String standardMaxValue, String standardMinValue, String inspectionAccording, String specialRequest, String inspectionValue, 
            String inspectionResult, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, 
            String remark)
        {
            this.iOMItemId = iOMItemId;
            this.iOrderId = iOrderId;
            this.iOMemberId = iOMemberId;
            this.inspectionItemName = inspectionItemName;
            this.standardMaxValue = standardMaxValue;
            this.standardMinValue = standardMinValue;
            this.inspectionAccording = inspectionAccording;
            this.specialRequest = specialRequest;
            this.inspectionValue = inspectionValue;
            this.inspectionResult = inspectionResult;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 IOMItemId
        {
            get { return this.iOMItemId; }
            set { this.iOMItemId = value; }
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
        public Int32 IOMemberId
        {
            get { return this.iOMemberId; }
            set { this.iOMemberId = value; }
        }

        /// <summary>
        /// 获取或设置检验项目名称
        /// </summary>
        public String InspectionItemName
        {
            get { return this.inspectionItemName; }
            set { this.inspectionItemName = value; }
        }

        /// <summary>
        /// 获取或设置最大值
        /// </summary>
        public String StandardMaxValue
        {
            get { return this.standardMaxValue; }
            set { this.standardMaxValue = value; }
        }

        /// <summary>
        /// 获取或设置最小值
        /// </summary>
        public String StandardMinValue
        {
            get { return this.standardMinValue; }
            set { this.standardMinValue = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String InspectionAccording
        {
            get { return this.inspectionAccording; }
            set { this.inspectionAccording = value; }
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
        /// 获取或设置
        /// </summary>
        public String InspectionValue
        {
            get { return this.inspectionValue; }
            set { this.inspectionValue = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String InspectionResult
        {
            get { return this.inspectionResult; }
            set { this.inspectionResult = value; }
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
    }
}