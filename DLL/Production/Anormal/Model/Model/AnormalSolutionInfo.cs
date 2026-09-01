using System;

namespace SKT.LeanMES.ProdAnormal.Model
{
    [Serializable]
    public class AnormalSolutionInfo
    {
        private Int32 solutionId;
        private Int32 anormalId;
        private String actionPerson;
        private String solution;
        private DateTime actionTime;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private Double abnormalTimeLength;
        private String abnormalUnit;
        private Decimal effectPerson;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AnormalSolutionInfo 类的新实例。
        /// </summary>
        public AnormalSolutionInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AnormalSolutionInfo 类的新实例。
        /// </summary>
        /// <param name="solutionId"></param>
        /// <param name="anormalId">异常ID</param>
        /// <param name="actionPerson">异常处理人</param>
        /// <param name="solution">异常解决方案</param>
        /// <param name="actionTime">处理异常的时间</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        /// <param name="abnormalTimeLength"></param>
        /// <param name="abnormalUnit"></param>
        /// <param name="effectPerson">影响人数</param>
        public AnormalSolutionInfo(Int32 solutionId, Int32 anormalId, String actionPerson, String solution, 
            DateTime actionTime, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, 
            String remark, Double abnormalTimeLength, String abnormalUnit, Decimal effectPerson)
        {
            this.solutionId = solutionId;
            this.anormalId = anormalId;
            this.actionPerson = actionPerson;
            this.solution = solution;
            this.actionTime = actionTime;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.abnormalTimeLength = abnormalTimeLength;
            this.abnormalUnit = abnormalUnit;
            this.effectPerson = effectPerson;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SolutionId
        {
            get { return this.solutionId; }
            set { this.solutionId = value; }
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
        /// 获取或设置异常处理人
        /// </summary>
        public String ActionPerson
        {
            get { return this.actionPerson; }
            set { this.actionPerson = value; }
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
        /// 获取或设置处理异常的时间
        /// </summary>
        public DateTime ActionTime
        {
            get { return this.actionTime; }
            set { this.actionTime = value; }
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

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double AbnormalTimeLength
        {
            get { return this.abnormalTimeLength; }
            set { this.abnormalTimeLength = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AbnormalUnit
        {
            get { return this.abnormalUnit; }
            set { this.abnormalUnit = value; }
        }

        /// <summary>
        /// 获取或设置影响人数
        /// </summary>
        public Decimal EffectPerson
        {
            get { return this.effectPerson; }
            set { this.effectPerson = value; }
        }
    }
}