using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using Systems.Web;
using SKT.Common.Account.Model;
using SKT.Common.Account.BLL;
using SKT.Common.Model;
using AjaxPro;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Utility;

namespace SKT.LeanMES.Web
{
    /// <summary>
    /// Summary description for AccountController
    /// </summary>
    public static class AccountController
    {
        /// <summary>
        /// 用户登录。
        /// </summary>
        /// <param name="userName">用户名。</param>
        /// <param name="password">密码。</param>
        /// <returns>登录结果</returns>
        public static LoginResult Login(String userName, String password, bool loginFromClient)
        {
            LoginResult loginResult = AccountManager.Login(userName, password, HttpContext.Current, loginFromClient);
            return loginResult;
        }

        /// <summary>
        /// 获取当前登录用户的信息。
        /// </summary>
        /// <returns>当前登录用户的实体对象。</returns>
        public static MembershipInfo GetCurrentUser()
        {
            return AccountManager.GetCurrentUser(HttpContext.Current);
        }

        /// <summary>
        /// 获取当前登录用户的信息。
        /// </summary>
        /// <returns>当前登录用户的实体对象。</returns>
        public static MembershipInfo GetCurrentUser(bool noRedirect)
        {
            return AccountManager.GetCurrentUser(HttpContext.Current, noRedirect);
        }

        /// <summary>
        /// 退出登录。
        /// </summary>
        [AjaxPro.AjaxMethod(AjaxPro.HttpSessionStateRequirement.ReadWrite)]
        public static void Logout()
        {
            MembershipInfo userInfo = AccountController.GetCurrentUser() as MembershipInfo;
            try
            {
                if (userInfo != null)
                {
                    (new Users()).LogoffUser(userInfo.UserId, "");
                }

                FormsAuthentication.SignOut();
                HttpContext.Current.Session.Clear();
                HttpContext.Current.Session.Abandon();
                CommonMethod.LoginLog(0, "退出系统成功！", userInfo.UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 获取当前登录用户的信息。
        /// </summary>
        /// <returns>当前登录用户的实体对象。</returns>
        [AjaxMethod]
        public static MembershipInfo GetCurrentUserInfo()
        {
            return AccountManager.GetCurrentUser(HttpContext.Current);
        }

        /// <summary>
        /// 检查是否有此操作权限
        /// </summary>
        /// <param name="methodName">方法名称</param>
        /// <param name="userId">用户ID</param>
        /// <returns></returns>
        public static bool CheckUserPopedom(string methodName, int userId)
        {
            SqlParameter[] paras = new SqlParameter[]
             {
                new SqlParameter("@MethodName",SqlDbType.NVarChar),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@IsHasPopedom",SqlDbType.Bit),
             };

            paras[0].Value = methodName;
            paras[1].Value = userId;
            paras[2].Value = 1;
            paras[2].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckUserPopedom", paras);
            return Convert.ToBoolean(paras[2].Value);
        }
        /// <summary>
        /// 检查是否有此操作权限
        /// </summary>
        /// <param name="methodName">方法名称</param>
        /// <param name="userId">用户ID</param>
        /// <returns></returns>
        public static bool CheckUserPopedomName(int userId, string name)
        {
            SqlParameter[] paras = new SqlParameter[]
             {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@Name",SqlDbType.VarChar,50),
             };

            paras[0].Value = userId;
            paras[1].Value = name;
            using (SqlDataReader reader = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, @"
            if exists(select 1 from SYS_Popedom where name= @Name)
            begin            
                SELECT count(1) qty FROM dbo.SYS_UsersInRole AS a 
                INNER JOIN dbo.SYS_PopedomInRole AS b ON b.RoleId = a.RoleId
                INNER JOIN dbo.SYS_Popedom AS c ON b.Popedom = c.Popedom
                WHERE a.UserId = @UserId and c.Name = @Name
            end
            else 
            begin
                select 1 qty
            end", paras))
            {
                if (reader.Read())
                {
                    return Convert.ToInt32(reader["qty"]) > 0;
                }
            }
            return false;
        }


        private static Dictionary<string, bool> IsNeedDic = new Dictionary<string, bool>();
        /// <summary>
        /// 检查当前页面是否需要登录后才可以操作
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        public static bool CheckIsNeedLogin(string pageName)
        {
            if (IsNeedDic.ContainsKey(pageName))
                return IsNeedDic[pageName];
            SqlParameter[] paras = new SqlParameter[]
             {
                new SqlParameter("@PageName",SqlDbType.NVarChar),
                new SqlParameter("@IsNeedLogin",SqlDbType.Bit),
             };

            paras[0].Value = pageName;
            paras[1].Value = 1;
            paras[1].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckIsNeedLogin", paras);
            IsNeedDic[pageName] = Convert.ToBoolean(paras[1].Value);
            return IsNeedDic[pageName];
        }
        /// <summary>
        /// 时间戳开始时间
        /// </summary>
        public static DateTime StartTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1));

        /// <summary>
        /// /获取license信息
        /// </summary>
        /// <returns></returns>
        public static dynamic GetLicenseInfo(HttpContext context)
        {
            if (context == null) {
                return null;
            }
            //
            dynamic licenseInfo = new System.Dynamic.ExpandoObject();
            licenseInfo.LicenseType = -1;
            licenseInfo.LineQty = -1;
            licenseInfo.UserQty = -1;
            licenseInfo.OnlineUserQty = 0;
            if (context != null && context.Application != null)
            {
                if (context.Application["LineQty"] != null)
                {
                    licenseInfo.LineQty = Convert.ToInt32(context.Application["LineQty"]);
                }
                if (context.Application["UserQty"] != null)
                {
                    licenseInfo.UserQty = Convert.ToInt32(context.Application["UserQty"]);
                }
                //设置类型(0：产线授权 1：用户并发授权 2：服务器授权 -1：未知授权)
                if (licenseInfo.LineQty > 0)
                {
                    licenseInfo.LicenseType = 0;
                }
                else if (licenseInfo.UserQty > 0)
                {
                    licenseInfo.LicenseType = 1;
                }
                else if (licenseInfo.LineQty == 0 && licenseInfo.UserQty == 0)
                {
                    licenseInfo.LicenseType = 2;
                }
                else
                {
                    licenseInfo.LicenseType = -1;
                }
                licenseInfo.OnlineUserQty = new SKT.Common.Account.BLL.Users().GetOnlineUserCount();
            }
            return licenseInfo;
        }
    }
}
