using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Warning.Model
{
    [Serializable]
    public class WarningInfo
    {
        private Int32 warningId;
        private String warningName;
        private Int32 warningGroup;
        private Int32 warningType;
        private String warningTypeName;
        private String warningDesc;
        private Int32 warningLevel;
        private Int32 cycleType;
        private Int32 cycleTime;
        private Int32 preWarning;
        private String execProcedures;
        private Int32 messageType;
        private String recipientLevel1;
        private String recipientLevelNames1;
        private String receiveContent1;
        private String recipientLevel2;
        private String recipientLevelNames2;
        private String receiveContent2;
        private String recipientLevel3;
        private String recipientLevelNames3;
        private String receiveContent3;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private Int32 ncNum;
        private Int32 ratio;
        private Int32 linId;
        private Int32 intervalTime1;
        private Int32 intervalTime2;
        private String solution1;
        private Int32 solve1;
        private String solution2;
        private Int32 solve2;
        private String solution3;
        private Int32 solve3;
        private Int32 ratioNum;

        public decimal WarningVal { get; set; }
        public Int32 RatioNum
        {
            get { return this.ratioNum; }
            set { this.ratioNum = value; }
        }


        private String lineName;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.WarningInfo 类的新实例。
        /// </summary>
        public WarningInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.WarningInfo 类的新实例。
        /// </summary>
        /// <param name="warningId">警报ID</param>
        /// <param name="warningName">警报名称</param>
        /// <param name="warningType">警报类型</param>
        /// <param name="warningDesc">警报描述</param>
        /// <param name="warningLevel">警报等级</param>
        /// <param name="cycleType">周期类型：0 - 按次；1 - 按分；2 - 按时；3 - 按天；4 - 按周；5 - 按月；6 - 按年</param>
        /// <param name="cycleTime">间隔频率</param>
        /// <param name="preWarning">提前预警时间：0 - 不提前预警</param>
        /// <param name="execProcedures">执行的存储过程</param>
        /// <param name="messageType">消息通知类型：1 - 短信；2 - Email</param>
        /// <param name="recipientLevel1">一级接收人</param>
        /// <param name="receiveContent1">一级接收人接收内容</param>
        /// <param name="recipientLevel2">二级接收人</param>
        /// <param name="receiveContent2">二级接收人接收内容</param>
        /// <param name="recipientLevel3">三级接收人</param>
        /// <param name="receiveContent3">三级接收人接收内容</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public WarningInfo(Int32 warningId, String warningName, Int32 warningType, String warningDesc,
            Int32 warningLevel, Int32 cycleType, Int32 cycleTime, Int32 preWarning, String execProcedures,
            Int32 messageType, String recipientLevel1, String receiveContent1, String recipientLevel2, String receiveContent2,
            String recipientLevel3, String receiveContent3, String createBy, DateTime createDateTime, String modifyBy,
            DateTime modifyDateTime, String remark, Int32 ncNum, Int32 ratio, Int32 linId, Int32 intervalTime1, Int32 intervalTime2,
            String solution1, Int32 solve1, String solution2, Int32 solve2, String solution3, Int32 solve3)
        {
            this.warningId = warningId;
            this.warningName = warningName;
            this.warningType = warningType;
            this.warningDesc = warningDesc;
            this.warningLevel = warningLevel;
            this.cycleType = cycleType;
            this.cycleTime = cycleTime;
            this.preWarning = preWarning;
            this.execProcedures = execProcedures;
            this.messageType = messageType;
            this.recipientLevel1 = recipientLevel1;
            this.receiveContent1 = receiveContent1;
            this.recipientLevel2 = recipientLevel2;
            this.receiveContent2 = receiveContent2;
            this.recipientLevel3 = recipientLevel3;
            this.receiveContent3 = receiveContent3;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.ncNum = ncNum;
            this.ratio = ratio;
            this.linId = linId;
            this.intervalTime1 = intervalTime1;
            this.intervalTime2 = intervalTime2;
            this.solution1 = solution1;
            this.solve1 = solve1;
            this.solution2 = solution2;
            this.solve2 = solve2;
            this.solution3 = solution3;
            this.solve3 = solve3;
        }

        /// <summary>
        /// 获取或设置警报ID
        /// </summary>
        public Int32 WarningId
        {
            get { return this.warningId; }
            set { this.warningId = value; }
        }

        /// <summary>
        /// 获取或设置警报名称
        /// </summary>
        public String WarningName
        {
            get { return this.warningName; }
            set { this.warningName = value; }
        }

        /// <summary>
        /// 获取或设置警报分组:1 - 系统警报；2 - 生产警报；3 - 品质警报。
        /// </summary>
        public Int32 WarningGroup
        {
            get { return this.warningGroup; }
            set { this.warningGroup = value; }
        }

        /// <summary>
        /// 获取或设置警报类型
        /// </summary>
        public Int32 WarningType
        {
            get { return this.warningType; }
            set { this.warningType = value; }
        }

        /// <summary>
        /// 获取或设置警报类型
        /// </summary>
        public String WarningTypeName
        {
            get { return this.warningTypeName; }
            set { this.warningTypeName = value; }
        }

        /// <summary>
        /// 获取或设置警报描述
        /// </summary>
        public String WarningDesc
        {
            get { return this.warningDesc; }
            set { this.warningDesc = value; }
        }

        /// <summary>
        /// 获取或设置警报等级
        /// </summary>
        public Int32 WarningLevel
        {
            get { return this.warningLevel; }
            set { this.warningLevel = value; }
        }

        /// <summary>
        /// 获取或设置周期类型：0 - 按次；1 - 按分；2 - 按时；3 - 按天；4 - 按周；5 - 按月；6 - 按年
        /// </summary>
        public Int32 CycleType
        {
            get { return this.cycleType; }
            set { this.cycleType = value; }
        }

        /// <summary>
        /// 获取或设置间隔频率
        /// </summary>
        public Int32 CycleTime
        {
            get { return this.cycleTime; }
            set { this.cycleTime = value; }
        }

        /// <summary>
        /// 获取或设置提前预警时间:0 - 不提前预警
        /// </summary>
        public Int32 PreWarning
        {
            get { return this.preWarning; }
            set { this.preWarning = value; }
        }

        /// <summary>
        /// 获取或设置执行的存储过程
        /// </summary>
        public String ExecProcedures
        {
            get { return this.execProcedures; }
            set { this.execProcedures = value; }
        }

        /// <summary>
        /// 获取或设置消息通知类型：1 - 短信；2 - Email
        /// </summary>
        public Int32 MessageType
        {
            get { return this.messageType; }
            set { this.messageType = value; }
        }

        /// <summary>
        /// 获取或设置一级接收人ID
        /// </summary>
        public String RecipientLevel1
        {
            get { return this.recipientLevel1; }
            set { this.recipientLevel1 = value; }
        }

        /// <summary>
        /// 获取或设置一级接收人
        /// </summary>
        public String RecipientLevelNames1
        {
            get { return this.recipientLevelNames1; }
            set { this.recipientLevelNames1 = value; }
        }

        /// <summary>
        /// 获取或设置一级接收人接收内容
        /// </summary>
        public String ReceiveContent1
        {
            get { return this.receiveContent1; }
            set { this.receiveContent1 = value; }
        }

        /// <summary>
        /// 获取或设置二级接收人ID
        /// </summary>
        public String RecipientLevel2
        {
            get { return this.recipientLevel2; }
            set { this.recipientLevel2 = value; }
        }

        /// <summary>
        /// 获取或设置二级接收人
        /// </summary>
        public String RecipientLevelNames2
        {
            get { return this.recipientLevelNames2; }
            set { this.recipientLevelNames2 = value; }
        }

        /// <summary>
        /// 获取或设置二级接收人接收内容
        /// </summary>
        public String ReceiveContent2
        {
            get { return this.receiveContent2; }
            set { this.receiveContent2 = value; }
        }

        /// <summary>
        /// 获取或设置三级接收人ID
        /// </summary>
        public String RecipientLevel3
        {
            get { return this.recipientLevel3; }
            set { this.recipientLevel3 = value; }
        }

        /// <summary>
        /// 获取或设置三级接收人
        /// </summary>
        public String RecipientLevelNames3
        {
            get { return this.recipientLevelNames3; }
            set { this.recipientLevelNames3 = value; }
        }

        /// <summary>
        /// 获取或设置三级接收人接收内容
        /// </summary>
        public String ReceiveContent3
        {
            get { return this.receiveContent3; }
            set { this.receiveContent3 = value; }
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
        /// 不良现象数
        /// </summary>
        public Int32 NcNum
        {
            get { return this.ncNum; }
            set { this.ncNum = value; }
        }

        /// <summary>
        /// 不良lv
        /// </summary>
        public Int32 Ratio
        {
            get { return this.ratio; }
            set { this.ratio = value; }
        }

        /// <summary>
        ///线别ID
        /// </summary>
        public Int32 LineId
        {
            get { return this.linId; }
            set { this.linId = value; }
        }

        /// <summary>
        ///间隔时间1
        /// </summary>
        public Int32 IntervalTime1
        {
            get { return this.intervalTime1; }
            set { this.intervalTime1 = value; }
        }

        /// <summary>
        ///间隔时间2
        /// </summary>
        public Int32 IntervalTime2
        {
            get { return this.intervalTime2; }
            set { this.intervalTime2 = value; }
        }

        /// <summary>
        ///线别名称
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }

        /// <summary>
        ///第一级解决方案
        /// </summary>
        public String Solution1
        {
            get { return this.solution1; }
            set { this.solution1 = value; }
        }

        /// <summary>
        ///第一级解决方案是否解决
        /// </summary>
        public Int32 Solve1
        {
            get { return this.solve1; }
            set { this.solve1 = value; }
        }

        /// <summary>
        ///第二级解决方案
        /// </summary>
        public String Solution2
        {
            get { return this.solution2; }
            set { this.solution2 = value; }
        }

        /// <summary>
        ///第二级解决方案是否解决
        /// </summary>
        public Int32 Solve2
        {
            get { return this.solve2; }
            set { this.solve2 = value; }
        }

        /// <summary>
        ///第三级解决方案
        /// </summary>
        public String Solution3
        {
            get { return this.solution3; }
            set { this.solution3 = value; }
        }

        /// <summary>
        ///第三级解决方案是否解决
        /// </summary>
        public Int32 Solve3
        {
            get { return this.solve3; }
            set { this.solve3 = value; }
        }
    }
}
