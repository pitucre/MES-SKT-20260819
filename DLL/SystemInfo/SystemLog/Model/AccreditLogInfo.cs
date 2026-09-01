using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.SystemLog.Model
{
    public class AccreditLogInfo
    {
        private Int32 logId;
        private String userNo;
        private String userName;
        private String logContent;
        private DateTime createDateTime;

        private String logType;
        private String moduleName;
        private String pageName;
        private String oederNo;
        private String operation;
        private String resName;
        private String station;

        /// <summary>
        /// 初始化 SKT.LeanMES.AccreditLogInfo.Model 类的新实例。
        /// </summary>
        public AccreditLogInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.AccreditLogInfo.Model 类的新实例。
        /// </summary>
        /// <param name="logId"></param>
        /// <param name="userNo"></param>
        /// <param name="userName"></param>
        /// <param name="logContent"></param>
        /// <param name="createDateTime"></param>
        public AccreditLogInfo(Int32 logId, String userNo, String userName, String logContent, DateTime createDateTime)
        {
            this.logId = logId;
            this.userNo = userNo;
            this.userName = userName;
            this.logContent = logContent;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置行号
        /// </summary>
        public Int32 LogId
        {
            get { return this.logId; }
            set { this.logId = value; }
        }

        /// <summary>
        /// 获取或设置用户工号
        /// </summary>
        public String UserNo
        {
            get { return this.userNo; }
            set { this.userNo = value; }
        }
        /// <summary>
        /// 获取或设置用户名称
        /// </summary>
        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }
        /// <summary>
        /// 获取或设置授权内容
        /// </summary>
        public String LogContent
        {
            get { return this.logContent; }
            set { this.logContent = value; }
        }

        /// <summary>
        /// 获取或设置操作时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置日志类型
        /// </summary>
        public String LogType
        {
            get { return this.logType; }
            set { this.logType = value; }
        }
        /// <summary>
        /// 获取或设置模块名称
        /// </summary>
        public String ModuleName
        {
            get { return this.moduleName; }
            set { this.moduleName = value; }
        }
        /// <summary>
        /// 获取或设置功能菜单
        /// </summary>
        public String PageName
        {
            get { return this.pageName; }
            set { this.pageName = value; }
        }
        /// <summary>
        /// 获取或设置单号
        /// </summary>
        public String OederNo
        {
            get { return this.oederNo; }
            set { this.oederNo = value; }
        }
        /// <summary>
        /// 获取或设置操作描述
        /// </summary>
        public String Operation
        {
            get { return this.operation; }
            set { this.operation = value; }
        }
        /// <summary>
        /// 获取或设置资源
        /// </summary>
        public String ResName
        {
            get { return this.resName; }
            set { this.resName = value; }
        }
        /// <summary>
        /// 获取或设置工位
        /// </summary>
        public String Station
        {
            get { return this.station; }
            set { this.station = value; }
        }
    }
}
