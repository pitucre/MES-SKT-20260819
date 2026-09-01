using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Warning.Model
{
    [Serializable]
    public class WarningHistoryInfo
    {
        private Int32 warHistoryId;
        private String orderNo;
        private String lineName;
        private String warningName;
        private String warningType;
        private Int32 ratio;
        private Int32 ncNum;
        private String weekType;
        private String oneSolve;
        private String towSolve;
        private String threeSolve;
        private Int32 status;
        private String closeBy;
        private DateTime closeDateTime;
        private DateTime createDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.WarningHistoryInfo 类的新实例。
        /// </summary>
        public WarningHistoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.WarningHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="warHistoryId"></param>
        /// <param name="orderNo"></param>
        /// <param name="lineName"></param>
        /// <param name="warningName">警报名称</param>
        /// <param name="warningType">警报类型</param>
        /// <param name="ratio">良率</param>
        /// <param name="ncNum">不良现象数</param>
        /// <param name="weekType">周期类型: DAY,WEEK</param>
        /// <param name="oneSolve">一级处理方案</param>
        /// <param name="towSolve">二级处理方案</param>
        /// <param name="threeSolve">三级处理方案</param>
        /// <param name="status">状态 ：1 一级预警中, 2 二级预警中,3 三级预警中, 4已关闭 </param>
        /// <param name="closeBy">关闭人</param>
        /// <param name="closeDateTime">关闭时间</param>
        /// <param name="createDateTime"></param>
        public WarningHistoryInfo(Int32 warHistoryId, String orderNo, String lineName, String warningName,
            String warningType, Int32 ratio, Int32 ncNum, String weekType, String oneSolve,
            String towSolve, String threeSolve, Int32 status, String closeBy, DateTime closeDateTime,
            DateTime createDateTime)
        {
            this.warHistoryId = warHistoryId;
            this.orderNo = orderNo;
            this.lineName = lineName;
            this.warningName = warningName;
            this.warningType = warningType;
            this.ratio = ratio;
            this.ncNum = ncNum;
            this.weekType = weekType;
            this.oneSolve = oneSolve;
            this.towSolve = towSolve;
            this.threeSolve = threeSolve;
            this.status = status;
            this.closeBy = closeBy;
            this.closeDateTime = closeDateTime;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 WarHistoryId
        {
            get { return this.warHistoryId; }
            set { this.warHistoryId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String OrderNo
        {
            get { return this.orderNo; }
            set { this.orderNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
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
        /// 获取或设置警报类型
        /// </summary>
        public String WarningType
        {
            get { return this.warningType; }
            set { this.warningType = value; }
        }

        /// <summary>
        /// 获取或设置良率
        /// </summary>
        public Int32 Ratio
        {
            get { return this.ratio; }
            set { this.ratio = value; }
        }

        /// <summary>
        /// 获取或设置不良现象数
        /// </summary>
        public Int32 NcNum
        {
            get { return this.ncNum; }
            set { this.ncNum = value; }
        }

        /// <summary>
        /// 获取或设置周期类型: DAY,WEEK
        /// </summary>
        public String WeekType
        {
            get { return this.weekType; }
            set { this.weekType = value; }
        }

        /// <summary>
        /// 获取或设置一级处理方案
        /// </summary>
        public String OneSolve
        {
            get { return this.oneSolve; }
            set { this.oneSolve = value; }
        }

        /// <summary>
        /// 获取或设置二级处理方案
        /// </summary>
        public String TowSolve
        {
            get { return this.towSolve; }
            set { this.towSolve = value; }
        }

        /// <summary>
        /// 获取或设置三级处理方案
        /// </summary>
        public String ThreeSolve
        {
            get { return this.threeSolve; }
            set { this.threeSolve = value; }
        }

        /// <summary>
        /// 获取或设置状态 ：1 一级预警中, 2 二级预警中,3 三级预警中, 4已关闭 
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置关闭人
        /// </summary>
        public String CloseBy
        {
            get { return this.closeBy; }
            set { this.closeBy = value; }
        }

        /// <summary>
        /// 获取或设置关闭时间
        /// </summary>
        public DateTime CloseDateTime
        {
            get { return this.closeDateTime; }
            set { this.closeDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }
    }
}
