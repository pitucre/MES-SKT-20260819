using System;

namespace SKT.LeanMES.DataDistribution.Model
{
    [Serializable]
    public class YDataDistributionOrgnizationInfo
    {
        public YDataDistributionOrgnizationInfo() { }
        public YDataDistributionOrgnizationInfo(Int32 Id, string departNo, string departName)
        {
            this.Id = Id;
            this.departNo = departNo;
            this.departName = departName;
        }
        private Int32 Id;
        private string departNo;
        private string departName;
        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 ID
        {
            get { return this.Id; }
            set { this.Id = value; }
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
