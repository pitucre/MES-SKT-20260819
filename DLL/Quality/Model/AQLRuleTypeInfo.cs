using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class AQLRuleTypeInfo
    {
        private Int32 aqlRuleTypeId;
        private String aqlRuleTypeName;
        private String aqlRuleTypeList;
        private String remark;
        private String createrBy;
        private DateTime createDate;
        private String modifyBy;
        private DateTime modifyDate;

        /// <summary>
        /// 初始化 SKT.MES.Model.AQLRuleTypeInfo 类的新实例。
        /// </summary>
        public AQLRuleTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.AQLRuleTypeInfo 类的新实例。
        /// </summary>
        /// <param name="aqlRuleTypeId"></param>
        /// <param name="aqlRuleTypeName"></param>
        /// <param name="aqlRuleTypeList"></param>
        /// <param name="remark"></param>
        /// <param name="createrBy"></param>
        /// <param name="createDate"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDate"></param>
        public AQLRuleTypeInfo(Int32 aqlRuleTypeId, String aqlRuleTypeName, String aqlRuleTypeList, String remark, 
            String createrBy, DateTime createDate, String modifyBy, DateTime modifyDate)
        {
            this.aqlRuleTypeId = aqlRuleTypeId;
            this.aqlRuleTypeName = aqlRuleTypeName;
            this.aqlRuleTypeList = aqlRuleTypeList;
            this.remark = remark;
            this.createrBy = createrBy;
            this.createDate = createDate;
            this.modifyBy = modifyBy;
            this.modifyDate = modifyDate;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AqlRuleTypeId
        {
            get { return this.aqlRuleTypeId; }
            set { this.aqlRuleTypeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AqlRuleTypeName
        {
            get { return this.aqlRuleTypeName; }
            set { this.aqlRuleTypeName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AqlRuleTypeList
        {
            get { return this.aqlRuleTypeList; }
            set { this.aqlRuleTypeList = value; }
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
        /// 获取或设置
        /// </summary>
        public String CreaterBy
        {
            get { return this.createrBy; }
            set { this.createrBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDate
        {
            get { return this.createDate; }
            set { this.createDate = value; }
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
        public DateTime ModifyDate
        {
            get { return this.modifyDate; }
            set { this.modifyDate = value; }
        }
    }
}