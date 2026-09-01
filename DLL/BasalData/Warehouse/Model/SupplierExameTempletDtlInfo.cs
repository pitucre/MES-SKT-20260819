using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class SupplierExameTempletDtlInfo
    {
        private Int32 iD;
        private Int32 supplierExameTempletID;
        private String supplierExameName;
        private String supplierExameType;
        private String supplierExameCompute;
        private Decimal assessmentWeight;
        private Int32 supplierExameContentId;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierExameTempletDtlInfo 类的新实例。
        /// </summary>
        public SupplierExameTempletDtlInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierExameTempletDtlInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="supplierExameTempletID">考核模板ID</param>
        /// <param name="supplierExameName">考核项名称</param>
        /// <param name="supplierExameType">考核项计算方式</param>
        /// <param name="supplierExameCompute">考核项计算方法(存储过程)</param>
        /// <param name="assessmentWeight">考核项权重</param>
        /// <param name="supplierExameContentId">考核项ID</param>
        public SupplierExameTempletDtlInfo(Int32 iD, Int32 supplierExameTempletID, String supplierExameName, String supplierExameType, 
            String supplierExameCompute, Decimal assessmentWeight, Int32 supplierExameContentId)
        {
            this.iD = iD;
            this.supplierExameTempletID = supplierExameTempletID;
            this.supplierExameName = supplierExameName;
            this.supplierExameType = supplierExameType;
            this.supplierExameCompute = supplierExameCompute;
            this.assessmentWeight = assessmentWeight;
            this.supplierExameContentId = supplierExameContentId;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置考核模板ID
        /// </summary>
        public Int32 SupplierExameTempletID
        {
            get { return this.supplierExameTempletID; }
            set { this.supplierExameTempletID = value; }
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
        /// 获取或设置考核项计算方式
        /// </summary>
        public String SupplierExameType
        {
            get { return this.supplierExameType; }
            set { this.supplierExameType = value; }
        }

        /// <summary>
        /// 获取或设置考核项计算方法(存储过程)
        /// </summary>
        public String SupplierExameCompute
        {
            get { return this.supplierExameCompute; }
            set { this.supplierExameCompute = value; }
        }

        /// <summary>
        /// 获取或设置考核项权重
        /// </summary>
        public Decimal AssessmentWeight
        {
            get { return this.assessmentWeight; }
            set { this.assessmentWeight = value; }
        }

        /// <summary>
        /// 获取或设置考核项ID
        /// </summary>
        public Int32 SupplierExameContentId
        {
            get { return this.supplierExameContentId; }
            set { this.supplierExameContentId = value; }
        }
    }
}