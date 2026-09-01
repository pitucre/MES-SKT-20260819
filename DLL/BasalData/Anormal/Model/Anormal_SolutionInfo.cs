using System;

namespace SKT.LeanMES.Anormal.Model
{
    [Serializable]
    public class Anormal_SolutionInfo
    {
        private Int32 recordId;
        private Int32 anormalId;
        private DateTime actionTime;
        private String solution;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private String actionPerson;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Anormal_SolutionInfo 类的新实例。
        /// </summary>
        public Anormal_SolutionInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Anormal_SolutionInfo 类的新实例。
        /// </summary>
        /// <param name="recordId"></param>
        /// <param name="anormalId">异常ID</param>
        /// <param name="actionTime">处理异常的时间</param>
        /// <param name="solution">异常解决方案</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        /// <param name="actionPerson"></param>
        public Anormal_SolutionInfo(Int32 recordId, Int32 anormalId, DateTime actionTime, String solution, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark, 
            String actionPerson)
        {
            this.recordId = recordId;
            this.anormalId = anormalId;
            this.actionTime = actionTime;
            this.solution = solution;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.actionPerson = actionPerson;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 RecordId
        {
            get { return this.recordId; }
            set { this.recordId = value; }
        }

        /// <summary>
        /// 获取或设置异常ID
        /// </summary>
        public Int32 AnormalId
        {
            get { return this.anormalId; }
            set { this.anormalId = value; }
        }

        /// <summary>
        /// 获取或设置处理异常的时间
        /// </summary>
        public DateTime ActionTime
        {
            get { return this.actionTime; }
            set { this.actionTime = value; }
        }

        /// <summary>
        /// 获取或设置异常解决方案
        /// </summary>
        public String Solution
        {
            get { return this.solution; }
            set { this.solution = value; }
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
        /// 获取或设置
        /// </summary>
        public String ActionPerson
        {
            get { return this.actionPerson; }
            set { this.actionPerson = value; }
        }
    }
}