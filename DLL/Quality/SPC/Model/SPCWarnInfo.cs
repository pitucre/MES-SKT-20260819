using System;

namespace SKT.LeanMES.SPC.Model
{
    [Serializable]
    public class SPCWarnInfo
    {
        private Int32 sPCWarnId;
        private Int32 sPCTaskId;
        private String sPCWarnMsg;
        private DateTime warnTime;
        private String reson;
        private String dealDesc;
        private String dealBy;
        private DateTime dealTime;
        private String createBy;
        public string TaskName { get; set; }
        public string ItemName { get; set; }
        public string LineName { get; set; }
        public string Station { get; set; }
        
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SPCWarnInfo 类的新实例。
        /// </summary>
        public SPCWarnInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SPCWarnInfo 类的新实例。
        /// </summary>
        /// <param name="sPCWarnId"></param>
        /// <param name="sPCTaskId">SPC任务ID</param>
        /// <param name="sPCWarnMsg">SPC预警信息</param>
        /// <param name="warnTime">报警时间</param>
        /// <param name="reson">报警原因</param>
        /// <param name="dealDesc">处理过程描述</param>
        /// <param name="dealBy">处理人</param>
        /// <param name="dealTime">处理时间</param>
        /// <param name="createBy">创建人</param>
        public SPCWarnInfo(Int32 sPCWarnId, Int32 sPCTaskId, String sPCWarnMsg, DateTime warnTime, 
            String reson, String dealDesc, String dealBy, DateTime dealTime, String createBy)
        {
            this.sPCWarnId = sPCWarnId;
            this.sPCTaskId = sPCTaskId;
            this.sPCWarnMsg = sPCWarnMsg;
            this.warnTime = warnTime;
            this.reson = reson;
            this.dealDesc = dealDesc;
            this.dealBy = dealBy;
            this.dealTime = dealTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SPCWarnId
        {
            get { return this.sPCWarnId; }
            set { this.sPCWarnId = value; }
        }

        /// <summary>
        /// 获取或设置SPC任务ID
        /// </summary>
        public Int32 SPCTaskId
        {
            get { return this.sPCTaskId; }
            set { this.sPCTaskId = value; }
        }

        /// <summary>
        /// 获取或设置SPC预警信息
        /// </summary>
        public String SPCWarnMsg
        {
            get { return this.sPCWarnMsg; }
            set { this.sPCWarnMsg = value; }
        }

        /// <summary>
        /// 获取或设置报警时间
        /// </summary>
        public DateTime WarnTime
        {
            get { return this.warnTime; }
            set { this.warnTime = value; }
        }

        /// <summary>
        /// 获取或设置报警原因
        /// </summary>
        public String Reson
        {
            get { return this.reson; }
            set { this.reson = value; }
        }

        /// <summary>
        /// 获取或设置处理过程描述
        /// </summary>
        public String DealDesc
        {
            get { return this.dealDesc; }
            set { this.dealDesc = value; }
        }

        /// <summary>
        /// 获取或设置处理人
        /// </summary>
        public String DealBy
        {
            get { return this.dealBy; }
            set { this.dealBy = value; }
        }

        /// <summary>
        /// 获取或设置处理时间
        /// </summary>
        public DateTime DealTime
        {
            get { return this.dealTime; }
            set { this.dealTime = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }
    }
}