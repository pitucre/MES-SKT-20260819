using System;

namespace SKT.LeanMES.Station.Model
{
    [Serializable]
    public class PhaseInfo
    {
        private Int32 phaseID;
        private String phaseName;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.PhaseInfo 类的新实例。
        /// </summary>
        public PhaseInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.PhaseInfo 类的新实例。
        /// </summary>
        /// <param name="phaseID"></param>
        /// <param name="phaseName">生产阶段名</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public PhaseInfo(Int32 phaseID, String phaseName, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.phaseID = phaseID;
            this.phaseName = phaseName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PhaseID
        {
            get { return this.phaseID; }
            set { this.phaseID = value; }
        }

        /// <summary>
        /// 获取或设置生产阶段名
        /// </summary>
        public String PhaseName
        {
            get { return this.phaseName; }
            set { this.phaseName = value; }
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
    }
}