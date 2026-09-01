using System;

namespace SKT.LeanMES.Plan.Model
{
    [Serializable]
    public class PlanTypeInfo
    {
        private Int32 planTypeId;
        private String planTypeName;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PlanTypeInfo 类的新实例。
        /// </summary>
        public PlanTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PlanTypeInfo 类的新实例。
        /// </summary>
        /// <param name="planTypeId"></param>
        /// <param name="planTypeName">生产计划类别名称</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public PlanTypeInfo(Int32 planTypeId, String planTypeName, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.planTypeId = planTypeId;
            this.planTypeName = planTypeName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PlanTypeId
        {
            get { return this.planTypeId; }
            set { this.planTypeId = value; }
        }

        /// <summary>
        /// 获取或设置生产计划类别名称
        /// </summary>
        public String PlanTypeName
        {
            get { return this.planTypeName; }
            set { this.planTypeName = value; }
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
    }
}