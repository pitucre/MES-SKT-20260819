using System;

namespace SKT.LeanMES.SPC.Model
{
    [Serializable]
    public class SPCProjectInfo
    {
        private Int32 sPCProjectId;
        private String projectName;
        private String projectDesc;
        private String graphType;
        private Int32 sampleQty;
        private Int32 groupQty;
        private Int32 sampleDecimalPoint;
        private Boolean isShowCP;
        private Boolean isShowCPK;
        private Boolean isShowPP;
        private Boolean isShowPPK;
        private Int32 nCGroupId;
        private Int32 nCCodeIdA;
        private Int32 nCCodeIdB;
        private Int32 nCCodeIdC;
        private Int32 nCCodeIdD;
        private Int32 nCCodeIdE;
        private Boolean isWarnA;
        private Boolean isWarnB;
        private Boolean isWarnC;
        private Int32 warnCVal;
        private Boolean isWarnD;
        private Int32 warnDVal;
        private Boolean isWarnE;
        private Int32 warnEVal;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SPCProjectInfo 类的新实例。
        /// </summary>
        public SPCProjectInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SPCProjectInfo 类的新实例。
        /// </summary>
        /// <param name="sPCProjectId"></param>
        /// <param name="projectName">SPC项目名称</param>
        /// <param name="projectDesc">SPC项目描述</param>
        /// <param name="graphType">SPC图标类型</param>
        /// <param name="sampleQty">组内样本数</param>
        /// <param name="groupQty">每屏显示组数</param>
        /// <param name="sampleDecimalPoint">样本小数位数</param>
        /// <param name="isShowCP">是否显示CP（0：不显示，1：显示）</param>
        /// <param name="isShowCPK">是否显示CPK（0：不显示，1：显示）</param>
        /// <param name="isShowPP">是否显示PP（0：不显示，1：显示）</param>
        /// <param name="isShowPPK">是否显示PPK（0：不显示，1：显示）</param>
        /// <param name="dataTypeId">不良缺陷组别Id（Basal_DataType表Id）</param>
        /// <param name="nCCodeIdA">不良/缺陷A</param>
        /// <param name="nCCodeIdB">不良/缺陷B</param>
        /// <param name="nCCodeIdC">不良/缺陷C</param>
        /// <param name="nCCodeIdD">不良/缺陷D</param>
        /// <param name="nCCodeIdE">不良/缺陷E</param>
        /// <param name="isWarnA">(A超控)超越控制线是否报警</param>
        /// <param name="isWarnB">(B超规)超越规格线是否报警</param>
        /// <param name="isWarnC">(C预警)判异规则：n点在中线同一侧时是否报警</param>
        /// <param name="warnCVal">预警C设定的n点值</param>
        /// <param name="isWarnD">(D预警)判异规则：n点连续上升或者下降是否报警</param>
        /// <param name="warnDVal">预警D设定的n点值</param>
        /// <param name="isWarnE">(E预警)判异规则：n点上下交替是否报警</param>
        /// <param name="warnEVal">预警E设定的n点值</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public SPCProjectInfo(Int32 sPCProjectId, String projectName, String projectDesc, String graphType, 
            Int32 sampleQty, Int32 groupQty, Int32 sampleDecimalPoint, Boolean isShowCP, Boolean isShowCPK, 
            Boolean isShowPP, Boolean isShowPPK, Int32 dataTypeId, Int32 nCCodeIdA, Int32 nCCodeIdB, 
            Int32 nCCodeIdC, Int32 nCCodeIdD, Int32 nCCodeIdE, Boolean isWarnA, Boolean isWarnB, 
            Boolean isWarnC, Int32 warnCVal, Boolean isWarnD, Int32 warnDVal, Boolean isWarnE, 
            Int32 warnEVal, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.sPCProjectId = sPCProjectId;
            this.projectName = projectName;
            this.projectDesc = projectDesc;
            this.graphType = graphType;
            this.sampleQty = sampleQty;
            this.groupQty = groupQty;
            this.sampleDecimalPoint = sampleDecimalPoint;
            this.isShowCP = isShowCP;
            this.isShowCPK = isShowCPK;
            this.isShowPP = isShowPP;
            this.isShowPPK = isShowPPK;
            this.nCGroupId = dataTypeId;
            this.nCCodeIdA = nCCodeIdA;
            this.nCCodeIdB = nCCodeIdB;
            this.nCCodeIdC = nCCodeIdC;
            this.nCCodeIdD = nCCodeIdD;
            this.nCCodeIdE = nCCodeIdE;
            this.isWarnA = isWarnA;
            this.isWarnB = isWarnB;
            this.isWarnC = isWarnC;
            this.warnCVal = warnCVal;
            this.isWarnD = isWarnD;
            this.warnDVal = warnDVal;
            this.isWarnE = isWarnE;
            this.warnEVal = warnEVal;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SPCProjectId
        {
            get { return this.sPCProjectId; }
            set { this.sPCProjectId = value; }
        }

        /// <summary>
        /// 获取或设置SPC项目名称
        /// </summary>
        public String ProjectName
        {
            get { return this.projectName; }
            set { this.projectName = value; }
        }

        /// <summary>
        /// 获取或设置SPC项目描述
        /// </summary>
        public String ProjectDesc
        {
            get { return this.projectDesc; }
            set { this.projectDesc = value; }
        }

        /// <summary>
        /// 获取或设置SPC图标类型
        /// </summary>
        public String GraphType
        {
            get { return this.graphType; }
            set { this.graphType = value; }
        }

        /// <summary>
        /// 获取或设置组内样本数
        /// </summary>
        public Int32 SampleQty
        {
            get { return this.sampleQty; }
            set { this.sampleQty = value; }
        }

        /// <summary>
        /// 获取或设置每屏显示组数
        /// </summary>
        public Int32 GroupQty
        {
            get { return this.groupQty; }
            set { this.groupQty = value; }
        }

        /// <summary>
        /// 获取或设置样本小数位数
        /// </summary>
        public Int32 SampleDecimalPoint
        {
            get { return this.sampleDecimalPoint; }
            set { this.sampleDecimalPoint = value; }
        }

        /// <summary>
        /// 获取或设置是否显示CP（0：不显示，1：显示）
        /// </summary>
        public Boolean IsShowCP
        {
            get { return this.isShowCP; }
            set { this.isShowCP = value; }
        }

        /// <summary>
        /// 获取或设置是否显示CPK（0：不显示，1：显示）
        /// </summary>
        public Boolean IsShowCPK
        {
            get { return this.isShowCPK; }
            set { this.isShowCPK = value; }
        }

        /// <summary>
        /// 获取或设置是否显示PP（0：不显示，1：显示）
        /// </summary>
        public Boolean IsShowPP
        {
            get { return this.isShowPP; }
            set { this.isShowPP = value; }
        }

        /// <summary>
        /// 获取或设置是否显示PPK（0：不显示，1：显示）
        /// </summary>
        public Boolean IsShowPPK
        {
            get { return this.isShowPPK; }
            set { this.isShowPPK = value; }
        }

        /// <summary>
        /// 获取或设置不良缺陷组别Id（Basal_DataType表Id）
        /// </summary>
        public Int32 NCGroupId
        {
            get { return this.nCGroupId; }
            set { this.nCGroupId = value; }
        }

        /// <summary>
        /// 获取或设置不良/缺陷A
        /// </summary>
        public Int32 NCCodeIdA
        {
            get { return this.nCCodeIdA; }
            set { this.nCCodeIdA = value; }
        }

        /// <summary>
        /// 获取或设置不良/缺陷B
        /// </summary>
        public Int32 NCCodeIdB
        {
            get { return this.nCCodeIdB; }
            set { this.nCCodeIdB = value; }
        }

        /// <summary>
        /// 获取或设置不良/缺陷C
        /// </summary>
        public Int32 NCCodeIdC
        {
            get { return this.nCCodeIdC; }
            set { this.nCCodeIdC = value; }
        }

        /// <summary>
        /// 获取或设置不良/缺陷D
        /// </summary>
        public Int32 NCCodeIdD
        {
            get { return this.nCCodeIdD; }
            set { this.nCCodeIdD = value; }
        }

        /// <summary>
        /// 获取或设置不良/缺陷E
        /// </summary>
        public Int32 NCCodeIdE
        {
            get { return this.nCCodeIdE; }
            set { this.nCCodeIdE = value; }
        }

        /// <summary>
        /// 获取或设置(A超控)超越控制线是否报警
        /// </summary>
        public Boolean IsWarnA
        {
            get { return this.isWarnA; }
            set { this.isWarnA = value; }
        }

        /// <summary>
        /// 获取或设置(B超规)超越规格线是否报警
        /// </summary>
        public Boolean IsWarnB
        {
            get { return this.isWarnB; }
            set { this.isWarnB = value; }
        }

        /// <summary>
        /// 获取或设置(C预警)判异规则：n点在中线同一侧时是否报警
        /// </summary>
        public Boolean IsWarnC
        {
            get { return this.isWarnC; }
            set { this.isWarnC = value; }
        }

        /// <summary>
        /// 获取或设置预警C设定的n点值
        /// </summary>
        public Int32 WarnCVal
        {
            get { return this.warnCVal; }
            set { this.warnCVal = value; }
        }

        /// <summary>
        /// 获取或设置(D预警)判异规则：n点连续上升或者下降是否报警
        /// </summary>
        public Boolean IsWarnD
        {
            get { return this.isWarnD; }
            set { this.isWarnD = value; }
        }

        /// <summary>
        /// 获取或设置预警D设定的n点值
        /// </summary>
        public Int32 WarnDVal
        {
            get { return this.warnDVal; }
            set { this.warnDVal = value; }
        }

        /// <summary>
        /// 获取或设置(E预警)判异规则：n点上下交替是否报警
        /// </summary>
        public Boolean IsWarnE
        {
            get { return this.isWarnE; }
            set { this.isWarnE = value; }
        }

        /// <summary>
        /// 获取或设置预警E设定的n点值
        /// </summary>
        public Int32 WarnEVal
        {
            get { return this.warnEVal; }
            set { this.warnEVal = value; }
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
    }
}