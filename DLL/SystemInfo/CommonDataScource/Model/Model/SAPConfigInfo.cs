using System;

namespace SKT.LeanMES.CommonDataSource.Model
{
    [Serializable]
    public class SAPConfigInfo
    {
        private Int32 iD;
        private String sAPHost;
        private String sAPClient;
        private String sAPUser;
        private String sAPPwd;
        private String sAPNumber;
        private String sAPLang;
        private String mESHost;
        private String mESUser;
        private String mESPwd;
        private String mESDBName;
        private String mESTimeout;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ConfigInfo 类的新实例。
        /// </summary>
        public SAPConfigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ConfigInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="sAPHost"></param>
        /// <param name="sAPClient"></param>
        /// <param name="sAPUser">SAP用户</param>
        /// <param name="sAPPwd">SAP密码</param>
        /// <param name="sAPNumber"></param>
        /// <param name="sAPLang"></param>
        /// <param name="mESHost"></param>
        /// <param name="mESUser"></param>
        /// <param name="mESPwd"></param>
        /// <param name="mESDBName"></param>
        /// <param name="mESTimeout"></param>
        public SAPConfigInfo(Int32 iD, String sAPHost, String sAPClient, String sAPUser, 
            String sAPPwd, String sAPNumber, String sAPLang, String mESHost, String mESUser, 
            String mESPwd, String mESDBName, String mESTimeout)
        {
            this.iD = iD;
            this.sAPHost = sAPHost;
            this.sAPClient = sAPClient;
            this.sAPUser = sAPUser;
            this.sAPPwd = sAPPwd;
            this.sAPNumber = sAPNumber;
            this.sAPLang = sAPLang;
            this.mESHost = mESHost;
            this.mESUser = mESUser;
            this.mESPwd = mESPwd;
            this.mESDBName = mESDBName;
            this.mESTimeout = mESTimeout;
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
        public String SAPHost
        {
            get { return this.sAPHost; }
            set { this.sAPHost = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SAPClient
        {
            get { return this.sAPClient; }
            set { this.sAPClient = value; }
        }

        /// <summary>
        /// 获取或设置SAP用户
        /// </summary>
        public String SAPUser
        {
            get { return this.sAPUser; }
            set { this.sAPUser = value; }
        }

        /// <summary>
        /// 获取或设置SAP密码
        /// </summary>
        public String SAPPwd
        {
            get { return this.sAPPwd; }
            set { this.sAPPwd = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SAPNumber
        {
            get { return this.sAPNumber; }
            set { this.sAPNumber = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SAPLang
        {
            get { return this.sAPLang; }
            set { this.sAPLang = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MESHost
        {
            get { return this.mESHost; }
            set { this.mESHost = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MESUser
        {
            get { return this.mESUser; }
            set { this.mESUser = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MESPwd
        {
            get { return this.mESPwd; }
            set { this.mESPwd = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MESDBName
        {
            get { return this.mESDBName; }
            set { this.mESDBName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MESTimeout
        {
            get { return this.mESTimeout; }
            set { this.mESTimeout = value; }
        }
    }
}