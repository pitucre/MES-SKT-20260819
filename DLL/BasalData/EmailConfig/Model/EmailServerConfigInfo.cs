using System;

namespace SKT.LeanMES.EmailConfig.Model
{
    [Serializable]
    public class EmailServerConfigInfo
    {
        private Int32 id;
        private String mailServerName;
        private String mailServertype;
        private Int32 port;
        private String userName;
        private String pWD;
        private String mailAddress;

        /// <summary>
        /// 初始化 SKT.LeanMES.EmailConfig.Model.EmailServerConfigInfo 类的新实例。
        /// </summary>
        public EmailServerConfigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.EmailConfig.Model.EmailServerConfigInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="mailServerName">邮箱服务器地址</param>
        /// <param name="mailServertype">邮箱服务器类型</param>
        /// <param name="port">邮箱服务器端口</param>
        /// <param name="userName">邮箱登录用户名</param>
        /// <param name="pWD">邮箱登录密码</param>
        /// <param name="mailAddress">邮箱地址</param>
        public EmailServerConfigInfo(Int32 id, String mailServerName, String mailServertype, Int32 port, 
            String userName, String pWD, String mailAddress)
        {
            this.id = id;
            this.mailServerName = mailServerName;
            this.mailServertype = mailServertype;
            this.port = port;
            this.userName = userName;
            this.pWD = pWD;
            this.mailAddress = mailAddress;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置邮箱服务器地址
        /// </summary>
        public String MailServerName
        {
            get { return this.mailServerName; }
            set { this.mailServerName = value; }
        }

        /// <summary>
        /// 获取或设置邮箱服务器类型
        /// </summary>
        public String MailServertype
        {
            get { return this.mailServertype; }
            set { this.mailServertype = value; }
        }

        /// <summary>
        /// 获取或设置邮箱服务器端口
        /// </summary>
        public Int32 Port
        {
            get { return this.port; }
            set { this.port = value; }
        }

        /// <summary>
        /// 获取或设置邮箱登录用户名
        /// </summary>
        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }

        /// <summary>
        /// 获取或设置邮箱登录密码
        /// </summary>
        public String PWD
        {
            get { return this.pWD; }
            set { this.pWD = value; }
        }

        /// <summary>
        /// 获取或设置邮箱地址
        /// </summary>
        public String MailAddress
        {
            get { return this.mailAddress; }
            set { this.mailAddress = value; }
        }
    }
}