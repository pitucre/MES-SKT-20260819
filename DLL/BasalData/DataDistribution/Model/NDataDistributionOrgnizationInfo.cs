using System;

namespace SKT.LeanMES.DataDistribution.Model
{
    [Serializable]
    public class NDataDistributionOrgnizationInfo
    {
        public NDataDistributionOrgnizationInfo() { }
        public NDataDistributionOrgnizationInfo(Int32 organizationId, string departNo, string departName)
        {
            this.organizationId = organizationId;
            this.departNo = departNo;
            this.departName = departName;
        }
        private Int32 organizationId;
        private string departNo;
        private string departName;
        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 OrganizationId
        {
            get { return this.organizationId; }
            set { this.organizationId = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String DepartNo
        {
            get { return this.departNo; }
            set { this.departNo = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String DepartName
        {
            get { return this.departName; }
            set { this.departName = value; }
        }
    }
}
