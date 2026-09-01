using System;

namespace SKT.LeanMES.Maintenance.Model
{
    [Serializable]
    public class MaintenanceRelationInfo
    {
        private Int32 relationId;
        private Int32 planId;
        private Int32 demoId;
        private Int32 isDone;
        private Int32 isCheck;
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.MaintenanceRelationInfo 类的新实例。
        /// </summary>
        public MaintenanceRelationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.MaintenanceRelationInfo 类的新实例。
        /// </summary>
        /// <param name="relationId">主键id</param>
        /// <param name="planId">计划id</param>
        /// <param name="demoId">保养项目id</param>
        public MaintenanceRelationInfo(Int32 relationId, Int32 planId, Int32 demoId, Int32 isDone, Int32 isCheck)
        {
            this.relationId = relationId;
            this.planId = planId;
            this.demoId = demoId;
            this.isDone = isDone;
            this.isCheck = isCheck;
        }

        /// <summary>
        /// 获取或设置主键id
        /// </summary>
        public Int32 RelationId
        {
            get { return this.relationId; }
            set { this.relationId = value; }
        }

        /// <summary>
        /// 获取或设置计划id
        /// </summary>
        public Int32 PlanId
        {
            get { return this.planId; }
            set { this.planId = value; }
        }

        /// <summary>
        /// 获取或设置保养项目id
        /// </summary>
        public Int32 DemoId
        {
            get { return this.demoId; }
            set { this.demoId = value; }
        }
        /// <summary>
        /// 获取或设置是否已做保养
        /// </summary>
        public Int32 IsDone
        {
            get { return this.isDone; }
            set { this.isDone = value; }
        }
        /// <summary>
        /// 获取或设置是否已确认
        /// </summary>
        public Int32 IsCheck
        {
            get { return this.isCheck; }
            set { this.isCheck = value; }
        }
    }
}