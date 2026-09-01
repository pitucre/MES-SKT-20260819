using System;
using System.Web;
using SKT.Common.Model;
using SKT.Common.Account.BLL;
using System.Web.SessionState;
using SKT.Common.Account.Model;
using System.Xml;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Text;
using System.Security.Cryptography;
using System.IO;
using System.Configuration;
using System.Text.RegularExpressions;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for MobileAppLogin
    /// </summary>
    public class MobileAppLogin : Systems.Web.AccessPage, IHttpHandler, IRequiresSessionState
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {

            SqlInjectableHelper.Validation(context);

            //8位秘钥
            string msg = "";            

            string Key = "SKTMES001";
            context.Response.ContentType = "text/plain";
            string action = context.Request["Action"];
            string Organization = context.Request["Organization"];
            
            switch (action.ToLower())
            {
                case "gettime":
                    context.Response.Write((long)(DateTime.Now - AccountController.StartTime).TotalMilliseconds);
                    context.Response.End();
                    break;
                case "login":
                    if (HttpContext.Current.Request.RequestType.ToLower() == "get")
                    {
                        msg = "非法请求！";
                        context.Response.Write(msg);
                        context.Response.End();
                        break;
                    }
                    string username = context.Request["UserName"];
                    string pwd = context.Request["Pwd1"];
                    //Add By Alen 2017-06-16 在登录前更新数据库链接，将DAL中的static变量MESConnString更改为当前选择的数据库链接，从而实现多工厂
                    string multiplant = context.Request["multiplant"];
                    
                    if (!string.IsNullOrEmpty(multiplant))
                    {
                        string dblink = GetMultiDbLinks(multiplant, context);
                        if (string.IsNullOrEmpty(dblink))
                        {
                            msg = "登录失败，数据库链接配置错误！";
                        }
                        else
                        {
                            msg = "";
                            Common.DAL.Marshal.SQLHelper.MESConnString = dblink;
                            Common.DAL.Marshal.SQLHelper.ReportConnString = dblink;
                            Common.DAL.Marshal.SQLHelper.ReportConnStringNew = dblink;
                            Common.DAL.Marshal.SQLHelper.SYSConnString = dblink;
                        }
                    }
                    else
                    {
                        //ClearDBLinkCookie(context);
                    }

                    if (string.IsNullOrEmpty(msg))
                    {
                        msg = UserAppLogin(username, pwd, context);
                    }
                    context.Response.Write(msg);
                    break;
                case "checkonline":
                    msg = CheckSession(context);
                    context.Response.Write(msg);
                    break;
                case "logout":
                    msg = Logout(context);
                    context.Response.Write(msg);
                    break;
                case "changepwd":
                    msg = ChangePwd(context);
                    context.Response.Write(msg);
                    break;
                case "encryption":

                    string encryptionValue = DESEncrypt(context.Request["Pwd1"], Key);
                    encryptionValue = DESEncrypt(encryptionValue, Key.ToLower());
                    context.Response.Write(encryptionValue);
                    break;
                case "decryption":
                    string decryptionValue = DESDecrypt(context.Request["Pwd1"], Key.ToLower());
                    decryptionValue = DESDecrypt(decryptionValue, Key);
                    context.Response.Write(decryptionValue);
                    break;
                case "checkmesurl":
                    string MesUrl= context.Request["mesurl"];
                    msg = CheckMesUrl(context, MesUrl, Organization);
                    context.Response.Write(msg);
                    break;
                case "validatepwd":
                    string pwdV = context.Request["Pwd1"];
                    msg = ValidatePwd(pwdV);
                    context.Response.Write(msg);
                    break;
                default:
                    break;
            }

        }

        private int datediff_time = 5;//在线用户刷新时间，默认5分钟轮询一次，超过5分钟的强制下线。为了考虑到用户网络延时等原因，将时间间隔由1分钟延长到5分钟
        private string datediff_unit = "n";//轮询时间单位，默认是"分钟"；
        //add by weixia on 2018.4.9如果查询到在别的电脑有登陆记录，至今注销
        public void LogoffUser(int userId, string userName, string clientIP)
        {
            StringBuilder str = new StringBuilder();
            str.Append(" DELETE FROM SYS_UsersOnline WHERE UserId = @UserId ");
            str.Append(" DELETE FROM SYS_UsersOnline WHERE UserId = @UserId AND ClientIP <>@ClientIP  ");
            //  str.Append(" DELETE FROM SYS_UsersOnline WHERE DATEDIFF(" + datediff_unit + ",LastCallTime,GetDate()) > " + datediff_time.ToString() + " ");
            str.Append(" UPDATE SYS_Users SET IsOnline = 0 WHERE UserId = @UserId ");
            SqlParameter[] parametrs = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@ClientIP",SqlDbType.NVarChar,50)
            };
            parametrs[0].Value = userId;
            parametrs[1].Value = clientIP;

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, str.ToString(), parametrs);
        }

        //add by weixia on 2018.4.9 通过userName找到userId 
        private int getUserIdbyName(string userName)
        {
            int userId = -1;
            StringBuilder str = new StringBuilder();
            str.Append(" SELECT  UserId   FROM  dbo.SYS_Users  WHERE  UserName = @UserName ");
            SqlParameter[] parametrs = new SqlParameter[] {
                new SqlParameter("@UserName",SqlDbType.NVarChar,20)
            };
            parametrs[0].Value = userName;
            SqlDataReader reader = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, str.ToString(), parametrs);
            if (reader.Read())
            {
                userId = Convert.ToInt32(reader["UserId"]);
            }
            reader.Close();
            return userId;
        }

        //更新当前用户的ClientIP
        public void updateUserIP(int userId, string clientIP)
        {
            StringBuilder str = new StringBuilder();

            /*QiQuan.Zhong 20180427 判断SYS_UsersOnline是否存在USERID的记录，没有则插入*/
            bool isEXISTS = false;
            str.Append("select top 1 1 from SYS_UsersOnline  WHERE UserId  = @UserId ");
            SqlParameter[] para = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int)
            };
            para[0].Value = userId;
            using (SqlDataReader dr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, str.ToString(), para))
            {
                while (dr.Read())
                {
                    isEXISTS = true;
                }
            }
            if (isEXISTS == false)
            {
                Users user = new Users();
                user.ChangeUserOnlineState(userId, true);
            }
            /*QiQuan.Zhong 20180427 修改结束*/
            /*更新该用户最后一次进入时间*/
            str.Append(" UPDATE SYS_UsersOnline SET ClientIP = @ClientIP, LastCallTime = GetDate()  WHERE UserId  = @UserId  ");
            SqlParameter[] parametrs = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@ClientIP",SqlDbType.NVarChar,50)
            };
            parametrs[0].Value = userId;
            parametrs[1].Value = clientIP;

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, str.ToString(), parametrs);
        }

        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="username">用户名</param>
        /// <param name="pwd">密码明文</param>
        /// <param name="context">当前上下文</param>
        /// <returns>如果返回信息为空则登录成功</returns>
        private string UserAppLogin(string username, string pwd, HttpContext context)
        {
            int userId = getUserIdbyName(username);
            string clientIP = CommonMethod.GetClientIP();
            string loginMessage = "";
            string lmsg = "";
            try
            {
                pwd = WebHelper.DesDecrypt(pwd);
                LoginResult loginResult = AccountController.Login(username, SKT.Common.Utility.EncryptHelper.Encrypt(pwd), false);
                string Organization;
                switch (loginResult)
                {
                    case LoginResult.InvalidUser:
                        loginMessage = "登录失败，用户名或密码错误";
                        break;
                    case LoginResult.InvalidMembership:
                        loginMessage = "登录失败，用户名或密码错误";
                        break;
                    case LoginResult.InvalidPassword:
                        Users user = new Users();
                        int failedPasswordCount = user.GetFailedPasswordCount(username);
                        //Sperkey.Zhong 2018-12-12 读取‘最大允许输错密码次数’全局参数配置
                        int maxErrorCount = -1;
                        GlobarParameter.Model.GlobarParameterInfo entity = new GlobarParameter.BLL.GlobarParameter().GetInfo("FailedPasswordCount");
                        if (entity != null)
                        {
                            maxErrorCount = Convert.ToInt32(entity.ParaValue);
                        }
                        loginMessage = "登录失败，" + Resources.Common.Comma + String.Format(Resources.Messages.RemainChance, (maxErrorCount - failedPasswordCount).ToString());
                        break;
                    case LoginResult.Locked:
                        loginMessage = "登录失败，" + Resources.Messages.IsLockedOut;
                        break;
                    case LoginResult.InvalidLicenseUserCount:
                        loginMessage = "登录失败，" + Resources.Messages.FullOnlineUsers;
                        break;
                    case LoginResult.UserIsOnline:  //update by weixia on 2018.4.9
                        //如果在线，删除之前的user记录,重新存储数据，最后更新ClientIP
                        LogoffUser(userId, username, clientIP);
                        LoginResult test = AccountController.Login(username, SKT.Common.Utility.EncryptHelper.Encrypt(pwd), false);
                        if (test == LoginResult.InvalidPassword)
                        {
                            Users userNew = new Users();
                            int failedPasswordCountNew = userNew.GetFailedPasswordCount(username);
                            loginMessage = "登录失败，" + Resources.Common.Comma + String.Format(Resources.Messages.RemainChance, (5 - failedPasswordCountNew).ToString());
                            break;
                        }
                        else
                        {
                            Organization = context.Request["Organization"];
                            if (!string.IsNullOrEmpty(Organization) && Organization == "C0000")
                            {
                                //登陆是集团版账套
                                Session["GroupVersion"] = "1";
                            }
                            else if (!string.IsNullOrEmpty(Organization) && Organization != "C0000")
                            {
                                //登陆是集团版子账套
                                Session["GroupVersion"] = "2";
                            }
                            else
                            {
                                //登陆是标准版
                                Session["GroupVersion"] = "0";
                            }
                            updateUserIP(userId, clientIP);
                            lmsg = getSuccess(loginMessage, context, lmsg, username, userId);
                            break;
                        }
                    case LoginResult.Success:
                        lmsg = getSuccess(loginMessage, context, lmsg, username, userId);
                        Organization = context.Request["Organization"];
                        if (!string.IsNullOrEmpty(Organization) && Organization == "C0000")
                        {
                            //登陆是集团版账套
                            Session["GroupVersion"] = "1";
                        }
                        else if (!string.IsNullOrEmpty(Organization) && Organization != "C0000")
                        {
                            //登陆是集团版子账套
                            Session["GroupVersion"] = "2";
                        }
                        else
                        {
                            //登陆是标准版
                            Session["GroupVersion"] = "0";
                        }
                        updateUserIP(userId, clientIP);
                        break;
                    default:
                        break;
                }

                CommonMethod.LoginLog(1, (String.IsNullOrEmpty(loginMessage) ? lmsg : loginMessage), username);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(username, ex);
            }
            return loginMessage;
        }

        public string getSuccess(string loginMessage, HttpContext context, string lmsg, string username, int userId)
        {
            SKT.Common.Account.BLL.Users bll = new Users();
            loginMessage = "";
            lmsg = "登录成功!";
            //设置系统语言
            if (context.Request["lang"] != null || context.Request["lang"] != "")
            {
                HttpCookie cookieLang = new HttpCookie("lang");
                cookieLang.Value = context.Request["lang"];
                context.Response.Cookies.Add(cookieLang);
            }
            //记住我
            if (context.Request["rmb"] != null || context.Request["rmb"] != "")
            {
                //如果管理端选择记住我，则需要保存当前用户名到cookie中
                HttpCookie cookie = new HttpCookie("UserInfo");
                if (context.Request["rmb"] == "1")
                {
                    cookie.Values["UserName"] = username;
                    cookie.Expires = DateTime.Now.AddMonths(3);
                    context.Response.Cookies.Add(cookie);
                }
                else
                {
                    if (cookie != null)
                    {
                        cookie.Expires = DateTime.Now.AddDays(-1);
                        context.Response.Cookies.Add(cookie);
                    }
                }
            }
            return lmsg;
        }
        /// <summary>
        /// 检查MES URL与账套是否匹配
        /// </summary>
        /// <param name="context"></param>
        private string CheckMesUrl(HttpContext context,string MesUrl,string Organization)
        {
            string sql = string.Format("SELECT MesUrl FROM [view_Organization] WHERE DepartNo='{0}'",Organization);
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, null);
            if (dt != null && dt.Rows.Count > 0 && dt.Rows[0]["MesUrl"].ToString() == MesUrl)
            {
                return "";
            }
            else {
                return "选择账套有误，请重新选择！";
            }
        }
        /// <summary>
        /// 检查登陆密码是否符合规则
        /// </summary>
        /// <param name="context"></param>
        private string ValidatePwd(string pwdV)
        {
            GlobarParameter.Model.GlobarParameterInfo info = new GlobarParameter.BLL.GlobarParameter().GetInfo("MandatoryPassword");
            GlobarParameter.Model.GlobarParameterInfo info2 = new GlobarParameter.BLL.GlobarParameter().GetInfo("Windows密码强度");
            if (info2 != null && info2.ParaValue == "1")
            {
                if (!Regex.IsMatch(pwdV, @"^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"))
                {
                    return "密码必须由字母和数字组成,至少有一个大写,一个小写,长度最少是8位";
                }
            }
            //else if (info != null && info.ParaValue == "是")
            //{
            //    if (!Regex.IsMatch(pwdV, @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"))
            //    {
            //        return "密码必须由字母和数字组成长度6到16位";
            //    }
            //}
            return "";
        }
        /// <summary>
        /// 检查当前Session是否有效
        /// </summary>
        /// <param name="context"></param>
        /// <returns>如果Session有效则返回空，否则返回超时提示</returns>
        private string CheckSession(HttpContext context)
        {
            if (AccountController.GetCurrentUser(true) != null)
            {
                return "";
            }
            else
            {
                return "登录已超时";
            }
        }

        /// <summary>
        /// 退出
        /// </summary>
        /// <returns></returns>
        private string Logout(HttpContext context)
        {
            try
            {
                AccountController.Logout();
                return "";
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return ex.Message;
            }
        }

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        private string ChangePwd(HttpContext context)
        {
            string msg = "";
            MembershipInfo membershipInfo = AccountController.GetCurrentUser();
            try
            {
                string oldPwd = context.Request["Pwd"];
                string newPwd = context.Request["Pwd1"];
                Users user = new Users();
                user.ChangePassword(membershipInfo.UserId, oldPwd, newPwd, membershipInfo.UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return msg;
        }

        private string GetMultiDbLinks(string id, HttpContext context)
        {
            string dbLinksJsonString = "";

            try
            {

                //TO DO
                string dbLinkFilePath = Server.MapPath("~/DBLink.xml");
                XmlNode node = Utility.XmlHelper.GetXmlNodeByXpath(dbLinkFilePath, "//dblinks//dblink[@id='" + id + "']");//.GetXmlNodeListByXpath(dbLinkFilePath, "//dblinks//dblink");
                if (node == null)
                {
                    dbLinksJsonString = "";
                }
                else
                {
                    node = node.ChildNodes[1];
                    dbLinksJsonString = "server=" + node.Attributes["server"].Value
                                          + ";uid=" + node.Attributes["uid"].Value
                                          + ";pwd=" + node.Attributes["pwd"].Value
                                          + ";database=" + node.Attributes["dbname"].Value
                                          + ";timeout=" + node.Attributes["timeout"].Value
                                          + ";";

                    //将选择的数据库链接存储到cookie中
                    HttpCookie dblinkCookie = new HttpCookie("DBLink");
                    dblinkCookie["dbserver"] = node.Attributes["server"].Value + "[" + node.Attributes["dbname"].Value + "]";
                    dblinkCookie["site"] = context.Request["site"];
                    dblinkCookie["id"] = context.Request["multiplant"];
                    //string multiplant = context.Request["multiplant"];
                    dblinkCookie.Expires = DateTime.Now.AddHours(24);
                    context.Response.Cookies.Add(dblinkCookie);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            return dbLinksJsonString;
        }

        /// <summary>
        /// 清空多工厂数据库链接Cookie
        /// </summary>
        /// <param name="context"></param>
        private void ClearDBLinkCookie(HttpContext context)
        {
            HttpCookie dblinkCookie = new HttpCookie("DBLink");
            if (dblinkCookie != null)
            {
                dblinkCookie["dbserver"] = "";
                dblinkCookie["site"] = "";
                dblinkCookie["id"] = "";
                dblinkCookie.Expires = DateTime.Now.AddHours(-1);
                context.Response.Cookies.Add(dblinkCookie);
            }

            //Common.DAL.Marshal.SQLHelper.InitConnectString();
        }

        /// <summary>
        /// 
        /// </summary>
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        /// <summary>
        /// Des解密方法
        /// </summary>
        /// <param name="val"></param>
        /// <param name="key"></param>
        /// <param name="IV"></param>
        /// <returns></returns>
        public static string DESDecrypt(string val, string Key)
        {
            byte[] buffer1 = Encoding.Default.GetBytes(Key.Substring(0, 8));
            byte[] buffer2 = buffer1;
            DESCryptoServiceProvider provider1 = new DESCryptoServiceProvider();
            provider1.Mode = CipherMode.ECB;
            provider1.Key = buffer1;
            provider1.IV = buffer2;
            ICryptoTransform transform1 = provider1.CreateDecryptor(provider1.Key, provider1.IV);
            byte[] buffer3 = Convert.FromBase64String(val);
            MemoryStream stream1 = new MemoryStream();
            CryptoStream stream2 = new CryptoStream(stream1, transform1, CryptoStreamMode.Write);
            stream2.Write(buffer3, 0, buffer3.Length);
            stream2.FlushFinalBlock();
            stream2.Close();
            return Encoding.Default.GetString(stream1.ToArray());
        }

        /// <summary>
        /// Des加密方法
        /// </summary>
        /// <param name="val"></param>
        /// <param name="key"></param>
        /// <param name="IV"></param>
        /// <returns></returns>
        public static string DESEncrypt(string val, string Key)
        {
            byte[] buffer1 = Encoding.Default.GetBytes(Key.Substring(0, 8));
            byte[] buffer2 = buffer1;
            DESCryptoServiceProvider provider1 = new DESCryptoServiceProvider();
            provider1.Mode = CipherMode.ECB;
            provider1.Key = buffer1;
            provider1.IV = buffer2;
            ICryptoTransform transform1 = provider1.CreateEncryptor(provider1.Key, provider1.IV);
            byte[] buffer3 = Encoding.Default.GetBytes(val);
            MemoryStream stream1 = new MemoryStream();
            CryptoStream stream2 = new CryptoStream(stream1, transform1, CryptoStreamMode.Write);
            stream2.Write(buffer3, 0, buffer3.Length);
            stream2.FlushFinalBlock();
            stream2.Close();
            return Convert.ToBase64String(stream1.ToArray());
        }
    }
}