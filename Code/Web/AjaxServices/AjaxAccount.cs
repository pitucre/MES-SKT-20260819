using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using AjaxPro;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;
using SKT.Common.Framework.Model;
using SKT.Common.Framework.BLL;
using System.Text;
using Systems.Web;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxAccount:IRequiresSessionState
    {
        /// <summary>
        /// 获取打印机分组名称
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public void EditUserPrinterGroup(int userId, List<string> list)
        {
            try
            {
                new SKT.LeanMES.Labels.BLL.Printer().EditUserPrinterGroup(userId, list, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 获取打印机分组名称
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<string> GetGroupName()
        {
            try
            {
                return new SKT.LeanMES.Labels.BLL.Printer().GetGroupName();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return new List<string>();
        }
        /// <summary>
        /// 获取用户关联的打印机分组名称
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<string> GetUserPrinterGroup(int userId)
        {
            try
            {
                return new SKT.LeanMES.Labels.BLL.Printer().GetUserPrinterGroup(userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return new List<string>();
        }
        /// <summary>
        /// 编辑用户
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public Int32 UserEdit(MembershipInfo entity, string roleIdStr, string userRolesStr,string IsGroup="")
        {
            Int32 userId = -1;
            try
            {
                if (entity.UserId < 1)
                {
                    entity.Password = WebHelper.DesDecrypt(entity.Password);
                    GlobarParameter.Model.GlobarParameterInfo info = new GlobarParameter.BLL.GlobarParameter().GetInfo("MandatoryPassword");
                    GlobarParameter.Model.GlobarParameterInfo info2 = new GlobarParameter.BLL.GlobarParameter().GetInfo("Windows密码强度");
                    if (info2 != null && info2.ParaValue == "1")
                    {
                        if (!Regex.IsMatch(entity.Password, @"^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"))
                        {
                            throw new Exception("密码必须由字母和数字组成,至少有一个大写,一个小写,长度最少是8位");
                        }
                    }
                    //else if (info != null && info.ParaValue == "是")
                    //{
                    //    if (!Regex.IsMatch(entity.Password, @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"))
                    //    {
                    //        throw new Exception("密码必须由字母和数字组成长度6到16位");
                    //    }
                    //}
                }
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                }
                userId = (new Users()).Edit(entity,ConnStr);
                //因为当前允许负增
                //if (userId > -1)
                //{
                if (userRolesStr != "")
                {
                    (new Common.Account.BLL.Role()).RemoveRolesFromUser(userId, userRolesStr, AccountController.GetCurrentUser().UserName,ConnStr);
                }
                (new UsersInRole()).AssignRolesToUser(userId, roleIdStr,ConnStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return userId;
        }

        /// <summary>
        /// 初始化用户密码
        /// </summary>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void InitPassword(Int32 userId)
        {
            try
            {
                (new Users()).InitPassword(userId, AccountController.GetCurrentUser().UserName, null);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 解锁用户
        /// </summary>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void UnlockUser(Int32 userId,string IsGroup = "")
        {
            try
            {
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                }
                (new Users()).UnlockUser(userId, AccountController.GetCurrentUser().UserName,ConnStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 注销用户
        /// </summary>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void LogoffUser(Int32 userId,string IsGroup = "")
        {
            try
            {
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                }
                (new Users()).LogoffUser(userId, AccountController.GetCurrentUser().UserName, !string.IsNullOrEmpty(ConnStr) ? ConnStr : "");
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 编辑角色
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Int32 RoleEdit(RoleInfo entity,string IsGroup = "")
        {
            int roleId = -1;
            try
            {
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                }
                roleId = (new Common.Account.BLL.Role()).Edit(entity, ConnStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return roleId;
        }

        /// <summary>
        /// 获取角色列表
        /// </summary>
        /// <param name="strWhere"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<RoleInfo> GetRoleList(string strWhere,string IsGroup="")
        {
            List<RoleInfo> list = null;

            try
            {
                Common.Model.SearchSettings searchSettings = null;

                if (strWhere.Trim() != "")
                {
                    searchSettings = new Common.Model.SearchSettings();
                    strWhere = " RoleName like '%" + strWhere + "%' ";
                    searchSettings.ExtensionCondition = strWhere;
                }

                if (IsGroup == "1")
                {
                    list = (new Common.Account.BLL.Role()).GetAllGroup(0, -1, "RoleName", searchSettings);
                }
                else {
                    list = (new Common.Account.BLL.Role()).GetAll(0, -1, "RoleName", searchSettings);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取子系统
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<SubSystemInfo> GetSubSystemAll()
        {
            List<SubSystemInfo> list = null;
            try
            {
                list = (new SubSystem()).GetAll();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return list;
        }

        /// <summary>
        /// 根据子系统获取模块
        /// </summary>
        /// <param name="subsystemName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ModuleInfo> GetModuleBySubSystem(string subsystemName)
        {
            List<ModuleInfo> list = null;
            try
            {
                list = (new Module()).GetBySubSystem(subsystemName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 根据模块获取页面
        /// </summary>
        /// <param name="moduleName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PageInfo> GetPagesByModule(string moduleName)
        {
            List<PageInfo> list = null;
            try
            {
                list = (new Page()).GetByModule(AccountController.GetCurrentUser().UserId, moduleName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 根据页面获取按钮
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ButtonInfo> GetButtonsByPages(string pageName)
        {
            List<ButtonInfo> list = null;
            try
            {
                list = (new Button()).GetByPage(pageName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 分配权限给角色
        /// </summary>
        /// <param name="roleId"></param>
        /// <param name="popedomString"></param>
        [AjaxMethod]
        public void AssignPopodomToRole(Int32 roleId, String popedomString, String IsGroup)
        {
            try
            {
                string ConnStr = "";
                Common.Account.BLL.Role role = new Common.Account.BLL.Role();
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                    role.AssignPopedomToRole(roleId, popedomString, ConnStr);
                }
                else {
                    role.AssignPopedomToRole(roleId, popedomString);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 导出权限用户
        /// </summary>
        /// <param name="popedom"></param>
        /// <returns></returns>
        [AjaxMethod]
        public String[] ExportPopedomUser(Int32 popedom,string IsGroup)
        {
            String[] reportSource = new String[3];
            StringBuilder sb = new StringBuilder();
            List<MembershipInfo> list = null;

            try
            {
                sb.Append("角色名");
                sb.Append("\t");
                sb.Append("用户名");
                sb.Append("\n");
                ////string ConnStr = "";
                if (IsGroup == "1")
                {
                    /////ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                    list = (new Common.Account.BLL.Users()).GetPopedomUsersSub(0, -1, popedom);
                }
                else {
                    list = (new Common.Account.BLL.Users()).GetPopedomUsers(0, -1, popedom);
                }
                foreach (MembershipInfo entity in list)
                {
                    sb.Append(entity.RoleName);
                    sb.Append("\t");
                    sb.Append(entity.UserName);
                    sb.Append("\n");
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            reportSource[0] = sb.ToString();
            reportSource[1] = (list.Count + 1).ToString();
            reportSource[2] = "2";

            return reportSource;
        }

        /// <summary>
        /// 分配角色给用户
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="roleIdString"></param>
        [AjaxMethod]
        public void AssignRolesToUser(Int32 userId, String roleIdString, String IsGroup)
        {
            try
            {
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                    (new UsersInRole()).AssignRolesToUser(userId, roleIdString, ConnStr);
                }
                else {
                    (new UsersInRole()).AssignRolesToUser(userId, roleIdString);
                }  
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 移除用户的角色
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="roleIdString"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void RemoveRolesFromUser(Int32 userId, String roleIdString, String userName, String IsGroup)
        {
            try
            {
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                    (new Common.Account.BLL.Role()).RemoveRolesFromUser(userId, roleIdString, userName,ConnStr);
                }
                else {
                    (new Common.Account.BLL.Role()).RemoveRolesFromUser(userId, roleIdString, userName);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 分配用户给角色
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="roleIdString"></param>
        [AjaxMethod]
        public void AssignUserToRole(Int32 roleId, String userIdString,String IsGroup)
        {
            try
            {
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                    (new UsersInRole()).AssignUsersToRole(roleId, userIdString, ConnStr);
                    //写入日志
                    SaveLoginLog(roleId, userIdString, "分配", ConnStr);
                }
                else {
                    (new UsersInRole()).AssignUsersToRole(roleId, userIdString);
                    //写入日志
                    SaveLoginLog(roleId, userIdString, "分配");
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 移除角色中的用户
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="roleIdString"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void RemoveUsersFromRole(Int32 roleId, String userIdString, String userName, String IsGroup)
        {
            try
            {
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                    (new Common.Account.BLL.Role()).RemoveUsersFromRole(roleId, userIdString, userName, ConnStr);
                    //写入日志
                    SaveLoginLog(roleId, userIdString, "移除", ConnStr);
                }
                else {
                    (new Common.Account.BLL.Role()).RemoveUsersFromRole(roleId, userIdString, userName);
                    //写入日志
                    SaveLoginLog(roleId, userIdString, "移除");
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据用户id获取所有角色以及用户所拥有的角色
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<RoleInfo> GetRoleListByUserId(int userId, string IsGroup = "")
        {
            List<RoleInfo> list = null;
            try
            {
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                }
                list = (new SKT.Common.Account.BLL.Role()).GetRolesByUserId(0, 0, userId,ConnStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public String CharacterToPinyin(string characterStr)
        {
            AppCode.Utility.CharacterToPinyin characterToPinyin = new AppCode.Utility.CharacterToPinyin();
            return characterToPinyin.convertCh(characterStr);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="oldPwd"></param>
        /// <param name="newPwd"></param>
        [AjaxMethod]
        public void ChangePwd(int userId, string oldPwd, string newPwd,string IsGroup = "")
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(oldPwd))
                    oldPwd = WebHelper.DesDecrypt(oldPwd);
                newPwd = WebHelper.DesDecrypt(newPwd);
                GlobarParameter.Model.GlobarParameterInfo entity = new GlobarParameter.BLL.GlobarParameter().GetInfo("MandatoryPassword");
                GlobarParameter.Model.GlobarParameterInfo entity2 = new GlobarParameter.BLL.GlobarParameter().GetInfo("Windows密码强度");
                if (entity2 != null && entity2.ParaValue == "1")
                {
                    if (!Regex.IsMatch(newPwd, @"^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"))
                    {
                        throw new Exception("密码必须由字母和数字组成,至少有一个大写,一个小写,长度最少是8位");
                    }
                }
                //else if (entity != null && entity.ParaValue == "是")
                //{
                //    if (!Regex.IsMatch(newPwd, @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"))
                //    {
                //        throw new Exception("密码必须由字母和数字组成长度6到16位");
                //    }
                //}
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                }
                if (userId == -1)
                {
                    userId = AccountController.GetCurrentUser().UserId;
                    (new SKT.Common.Account.BLL.Users()).ChangePassword(userId, oldPwd, newPwd, AccountController.GetCurrentUser().UserName,ConnStr);
                }
                else
                {
                    (new SKT.Common.Account.BLL.Users()).InitPassword(userId, AccountController.GetCurrentUser().UserName, newPwd,ConnStr);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 修改个人资料
        /// </summary>
        /// <param name="membershipInfo">用户信息实体</param>
        [AjaxMethod]
        public void EditProfile(MembershipInfo membershipInfo)
        {
            if (AccountController.GetCurrentUser(true) == null)
            {
                throw new Exception("timeout");
            }
            try
            {
                (new Users()).EditProfile(membershipInfo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 修改个人资料
        /// </summary>
        /// <param name="membershipInfo">用户信息实体</param>
        [AjaxMethod]
        public void EditProfile2(MembershipInfo membershipInfo)
        {
            if (AccountController.GetCurrentUser(true) == null)
            {
                throw new Exception("timeout");
            }
            try
            {
                (new Users()).EditProfile2(membershipInfo);
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
        public static MembershipInfo GetByName(string userName)
        {
            return (new Users()).GetByName(userName);
        }

        /// <summary>
        /// 初始化用户信息
        /// </summary>
        /// <param name="userXml"></param>
        [AjaxMethod]
        public void UserImport(string userXml, string IsGroup = "")
        {
            string userName = string.Empty;
            SqlParameter[] parms = new SqlParameter[]{
                            new SqlParameter("@UserName", SqlDbType.VarChar,30),
                            new SqlParameter("@UserXml", SqlDbType.NVarChar)
                            };
            userName = AccountController.GetCurrentUser().UserName;
            try
            {
                parms[0].Value = userName;
                parms[1].Value = userXml;

                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                }
                if (!string.IsNullOrEmpty(ConnStr))
                {
                    SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "uspImportUsers", parms);
                }
                else {
                    SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "uspImportUsers", parms);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据用户ID获取用户所拥有的权限
        /// </summary>
        /// <param name="userId">用户ID</param>
        [AjaxMethod]
        public string GetPopedomByUserId(int userId)
        {
            string r = "";
            try
            {
                Common.Account.BLL.Popedom bll = new Common.Account.BLL.Popedom();
                List<PopedomInfo> list = bll.GetPopedomByUserId(userId);

                string[] result = (from PopedomInfo p in list
                                   select p.SubSystemName).Distinct().ToArray();
                r = string.Join(",", result).ToString();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return r;
        }

        /// <summary>
        /// 根据用户ID获取用户所拥有的权限 zx add20171219
        /// </summary>
        /// <param name="userId">用户ID</param>
        [AjaxMethod]
        public string GetPopedomNameByUserId(int userId, string subSystemName)
        {
            string r = "";
            try
            {
                Common.Account.BLL.Popedom bll = new Common.Account.BLL.Popedom();
                List<PopedomInfo> list = bll.GetPopedomByUserId(userId);

                string[] result = (from PopedomInfo p in list
                                   where p.SubSystemName == (subSystemName == "" ? p.SubSystemName : subSystemName)
                                   select p.Name).Distinct().ToArray();
                r = string.Join(",", result).ToString();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return r;
        }

        //获取当前用户访问的IP地址 
        [AjaxMethod]
        public string GetClientIPByUserId(int userId)
        {
            string clientIP = "";
            try
            {
                clientIP = CommonMethod.GetCurrentClientIP(userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return clientIP;
        }
        /// <summary>
        /// 获取user信息
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        [AjaxMethod]
        public MembershipInfo GetUserInfo(int userid)
        {
            try
            {
                return (new SKT.Common.Account.BLL.Users()).GetUserInfo(userid);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 当前登录用户修改密码
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="oldPwd"></param>
        /// <param name="newPwd"></param>
        [AjaxMethod]
        public void ChangeCurrentUserPwd(string oldPwd, string newPwd, string IsGroup = "")
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(oldPwd))
                    oldPwd = WebHelper.DesDecrypt(oldPwd);
                newPwd = WebHelper.DesDecrypt(newPwd);
                GlobarParameter.Model.GlobarParameterInfo entity = new GlobarParameter.BLL.GlobarParameter().GetInfo("MandatoryPassword");
                GlobarParameter.Model.GlobarParameterInfo entity2 = new GlobarParameter.BLL.GlobarParameter().GetInfo("Windows密码强度");
                if (entity2 != null && entity2.ParaValue == "1")
                {
                    if (!Regex.IsMatch(newPwd, @"^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"))
                    {
                        throw new Exception("密码必须由字母和数字组成,至少有一个大写,一个小写,长度最少是8位");
                    }
                }
                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                }

                int userId = AccountController.GetCurrentUser().UserId;
                (new SKT.Common.Account.BLL.Users()).ChangePassword(userId, oldPwd, newPwd, AccountController.GetCurrentUser().UserName, ConnStr);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        protected void SaveLoginLog(Int32 roleId, String userIdString, String OperationType,string ConnStr="")
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@RoleId", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar,50),
                new SqlParameter("@UserIdString", SqlDbType.VarChar,1000),
                new SqlParameter("@OperationType", SqlDbType.VarChar,50),
            };
            parms[0].Value = roleId;
            parms[1].Value = AccountController.GetCurrentUser().UserName;
            parms[2].Value = userIdString;
            parms[3].Value = OperationType;
            SQLHelper.ExecuteNonQueryStoredProcedure(!string.IsNullOrEmpty(ConnStr)? ConnStr:SQLHelper.MESConnString, "uspSaveAssignUsersToRoleleLog", parms);
        }

    }
}