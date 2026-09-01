using System;

namespace SKT.LeanMES.CommonDataSource.Model
{
    [Serializable]
    public class ExeclogInfo
    {
        private Int32 iD;
        private String funcName;
        private String paramName;
        private String paramValue;
        private String sapCode;
        private String sapMsg;
        private String mesMsg;
        private String execUser;
        private DateTime createDate;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ExeclogInfo 类的新实例。
        /// </summary>
        public ExeclogInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ExeclogInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="funcName"></param>
        /// <param name="paramName"></param>
        /// <param name="paramValue"></param>
        /// <param name="sapCode"></param>
        /// <param name="sapMsg"></param>
        /// <param name="mesMsg"></param>
        /// <param name="execUser"></param>
        /// <param name="createDate">创建人</param>
        public ExeclogInfo(Int32 iD, String funcName, String paramName, String paramValue, 
            String sapCode, String sapMsg, String mesMsg, String execUser, DateTime createDate)
        {
            this.iD = iD;
            this.funcName = funcName;
            this.paramName = paramName;
            this.paramValue = paramValue;
            this.sapCode = sapCode;
            this.sapMsg = sapMsg;
            this.mesMsg = mesMsg;
            this.execUser = execUser;
            this.createDate = createDate;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FuncName
        {
            get { return this.funcName; }
            set { this.funcName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ParamName
        {
            get { return this.paramName; }
            set { this.paramName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ParamValue
        {
            get { return this.paramValue; }
            set { this.paramValue = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SapCode
        {
            get { return this.sapCode; }
            set { this.sapCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SapMsg
        {
            get { return this.sapMsg; }
            set { this.sapMsg = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MesMsg
        {
            get { return this.mesMsg; }
            set { this.mesMsg = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ExecUser
        {
            get { return this.execUser; }
            set { this.execUser = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public DateTime CreateDate
        {
            get { return this.createDate; }
            set { this.createDate = value; }
        }
    }
}