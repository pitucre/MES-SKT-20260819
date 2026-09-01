using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ESOP.Model
{
       [Serializable]
       public class FtpServerConfigInfo
       {

           private String ftpServerName;
           private String ftpServertype;
           private String userName;
           private String pWD;
           private String ftpStoreLocation;

           /// <summary>
           /// 初始化 SKT.LeanMES.FtpConfig.Model.FtpServerConfigInfo 类的新实例。
           /// </summary>
           public FtpServerConfigInfo()
           {
           }

           /// <summary>
           /// 初始化 SKT.LeanMES.FtpConfig.Model.FtpServerConfigInfo 类的新实例。
           /// </summary>
           /// <param name="id"></param>
           /// <param name="ftpServerName">邮箱服务器地址</param>
           /// <param name="ftpServertype">邮箱服务器类型</param>
           /// <param name="port">邮箱服务器端口</param>
           /// <param name="userName">邮箱登录用户名</param>
           /// <param name="pWD">邮箱登录密码</param>
           /// <param name="ftpStoreLocation">邮箱地址</param>
           public FtpServerConfigInfo( String ftpServerName, String ftpServertype, 
               String userName, String pWD, String ftpStoreLocation)
           {
               this.ftpServerName = ftpServerName;
               this.ftpServertype = ftpServertype;
               this.userName = userName;
               this.pWD = pWD;
               this.ftpStoreLocation = ftpStoreLocation;
           }


           /// <summary>
           /// 获取或设置邮箱服务器地址
           /// </summary>
           public String FtpServerName
           {
               get { return this.ftpServerName; }
               set { this.ftpServerName = value; }
           }

           /// <summary>
           /// 获取或设置邮箱服务器类型
           /// </summary>
           public String FtpServertype
           {
               get { return this.ftpServertype; }
               set { this.ftpServertype = value; }
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
           public String FtpStoreLocation
           {
               get { return this.ftpStoreLocation; }
               set { this.ftpStoreLocation = value; }
           }
       }
}
