using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class SupplierExameContentResultInfo
    {
        private Int32 supplierExameContentResultID;
        private Int32 supplierExameResultID;
        private Int32 supplierExameID;
        private Int32 supplierExameContentId;
        private String supplierExameName;
        private String supplierExameType;
        private String supplierExameCompute;
        private Decimal grades;
        private Decimal weightGrades;
        private Int32 sorting;
        private String createBy;
        private DateTime createDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierExameContentResultInfo 类的新实例。
        /// </summary>
        public SupplierExameContentResultInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierExameContentResultInfo 类的新实例。
        /// </summary>
        /// <param name="supplierExameContentResultID">考核项结果ID</param>
        /// <param name="supplierExameResultID">考核结果ID</param>
        /// <param name="supplierExameID"></param>
        /// <param name="supplierExameContentId">考核内容ID</param>
        /// <param name="supplierExameName">考核项名称</param>
        /// <param name="supplierExameType">考核项方式(手填，自动)</param>
        /// <param name="supplierExameCompute">考核项计算方式</param>
        /// <param name="grades">得分</param>
        /// <param name="weightGrades">权重得分</param>
        /// <param name="sorting">排序</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        public SupplierExameContentResultInfo(Int32 supplierExameContentResultID, Int32 supplierExameResultID, Int32 supplierExameID, Int32 supplierExameContentId, 
            String supplierExameName, String supplierExameType, String supplierExameCompute, Decimal grades, Decimal weightGrades, 
            Int32 sorting, String createBy, DateTime createDateTime)
        {
            this.supplierExameContentResultID = supplierExameContentResultID;
            this.supplierExameResultID = supplierExameResultID;
            this.supplierExameID = supplierExameID;
            this.supplierExameContentId = supplierExameContentId;
            this.supplierExameName = supplierExameName;
            this.supplierExameType = supplierExameType;
            this.supplierExameCompute = supplierExameCompute;
            this.grades = grades;
            this.weightGrades = weightGrades;
            this.sorting = sorting;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置考核项结果ID
        /// </summary>
        public Int32 SupplierExameContentResultID
        {
            get { return this.supplierExameContentResultID; }
            set { this.supplierExameContentResultID = value; }
        }

        /// <summary>
        /// 获取或设置考核结果ID
        /// </summary>
        public Int32 SupplierExameResultID
        {
            get { return this.supplierExameResultID; }
            set { this.supplierExameResultID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SupplierExameID
        {
            get { return this.supplierExameID; }
            set { this.supplierExameID = value; }
        }

        /// <summary>
        /// 获取或设置考核内容ID
        /// </summary>
        public Int32 SupplierExameContentId
        {
            get { return this.supplierExameContentId; }
            set { this.supplierExameContentId = value; }
        }

        /// <summary>
        /// 获取或设置考核项名称
        /// </summary>
        public String SupplierExameName
        {
            get { return this.supplierExameName; }
            set { this.supplierExameName = value; }
        }

        /// <summary>
        /// 获取或设置考核项方式(手填，自动)
        /// </summary>
        public String SupplierExameType
        {
            get { return this.supplierExameType; }
            set { this.supplierExameType = value; }
        }

        /// <summary>
        /// 获取或设置考核项计算方式
        /// </summary>
        public String SupplierExameCompute
        {
            get { return this.supplierExameCompute; }
            set { this.supplierExameCompute = value; }
        }

        /// <summary>
        /// 获取或设置得分
        /// </summary>
        public Decimal Grades
        {
            get { return this.grades; }
            set { this.grades = value; }
        }

        /// <summary>
        /// 获取或设置权重得分
        /// </summary>
        public Decimal WeightGrades
        {
            get { return this.weightGrades; }
            set { this.weightGrades = value; }
        }

        /// <summary>
        /// 获取或设置排序
        /// </summary>
        public Int32 Sorting
        {
            get { return this.sorting; }
            set { this.sorting = value; }
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

        public int AssessmentWeight { set; get; }

        public string ExameDate { set; get; }

        public string VendorCode { set; get; }

        public string VendorName { set; get; }
    }
}