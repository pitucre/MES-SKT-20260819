using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.Common.Account.Model;
using SKT.Common.Utility;
using System.Runtime.InteropServices;


namespace SKT.Common.Account.BLL
{
    public class Users
    {
        private Int32 recordCount = 0;
        private MembershipInfo loginUsersInfo = null;

        //add by Alen 2018-01-03
        private int datediff_time = 5;//在线用户刷新时间，默认5分钟轮询一次，超过5分钟的强制下线。为了考虑到用户网络延时等原因，将时间间隔由1分钟延长到5分钟
        private string datediff_unit = "n";//轮询时间单位，默认是"分钟"；
        private int concurrentUserTimeout = Convert.ToInt32(ConfigHelper.GetAppConfig("ConcurrentUserTimeout") ?? "5");      //并发用户的超时时间
        private bool isCheckSupplierUser = (ConfigHelper.GetAppConfig("IsCheckSupplierUser") ?? "0") == "1";          //是否检查供应商用户

        /// <summary>
        /// 编辑用户
        /// </summary>
        /// <param name="entity"></param>
        /// <returns>返回新创建的用户ID</returns>
        public Int32 Edit(MembershipInfo entity, string ConnStr = "")
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar,20),
                new SqlParameter("@LoweredUserName",SqlDbType.NVarChar,20),
                new SqlParameter("@Password",SqlDbType.VarChar,50),
                new SqlParameter("@EmployeeNo",SqlDbType.VarChar,20),
                new SqlParameter("@EmployeeCName",SqlDbType.NVarChar,50),
                new SqlParameter("@EmployeeEName",SqlDbType.VarChar,50),
                new SqlParameter("@DepartNo",SqlDbType.VarChar,20),
                new SqlParameter("@DepartName",SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                new SqlParameter("@ModifyBy",SqlDbType.VarChar,20),
                new SqlParameter("@Sex",SqlDbType.Int),
                new SqlParameter("@Phone",SqlDbType.VarChar,20),
                new SqlParameter("@Email",SqlDbType.VarChar,50),
                new SqlParameter("@Status",SqlDbType.Int),
                new SqlParameter("@UserType",SqlDbType.Int),
                new SqlParameter("@DepartId",SqlDbType.Int),
                new SqlParameter("@WechatNumber",SqlDbType.VarChar),
                new SqlParameter("@DingTalkUserId",SqlDbType.VarChar) { Value = entity.DingTalkUserId },
                new SqlParameter("@IsHandle",SqlDbType.Bit){ Value = entity.IsHandle }
                /* 
                 //Add By Alen 2015-08-25
                 //Modify By Alen 2016-02-02
                 //同兴达增加多工厂
                new SqlParameter("@Site",SqlDbType.VarChar,20)
                 */
            };

            parms[0].Value = entity.UserId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.UserName;
            parms[2].Value = entity.UserName.ToLower();
            parms[3].Value = EncryptHelper.Encrypt(entity.Password.ToString());
            parms[4].Value = entity.EmployeeNo;
            parms[5].Value = entity.EmployeeCName;
            parms[6].Value = entity.EmployeeEName;
            parms[7].Value = entity.DepartNo;
            parms[8].Value = entity.DepartName;
            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.Sex;
            parms[12].Value = entity.Phone;
            parms[13].Value = entity.Email;
            parms[14].Value = entity.UserStatus;
            parms[15].Value = entity.UserType;
            parms[16].Value = entity.DepartId;
            parms[17].Value = entity.WechatNumber;
            
            /*
            //Add By Alen 2015-08-25
            //Modify By Alen 2016-02-02
            //同兴达增加多工厂
            parms[17].Value = entity.Site;
             */
            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_Users_Edit", parms);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Users_Edit", parms);
            }
            return Convert.ToInt32(parms[0].Value);
        }

        /// <summary>
        /// 编辑用户
        /// </summary>
        /// <param name="entity"></param>
        /// <returns>返回新创建的用户ID</returns>
        public void EditProfile(MembershipInfo entity, string ConnStr = "")
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar,20),
                new SqlParameter("@LoweredUserName",SqlDbType.NVarChar,20),
                new SqlParameter("@Password",SqlDbType.VarChar,50),
                new SqlParameter("@EmployeeNo",SqlDbType.VarChar,20),
                new SqlParameter("@EmployeeCName",SqlDbType.NVarChar,50),
                new SqlParameter("@EmployeeEName",SqlDbType.VarChar,50),
                new SqlParameter("@DepartNo",SqlDbType.VarChar,20),
                new SqlParameter("@DepartName",SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                new SqlParameter("@ModifyBy",SqlDbType.VarChar,20),
                new SqlParameter("@Sex",SqlDbType.Int),
                new SqlParameter("@Phone",SqlDbType.VarChar,20),
                new SqlParameter("@Email",SqlDbType.VarChar,50),
                new SqlParameter("@DepartId",SqlDbType.Int),
                new SqlParameter("@Linage",SqlDbType.Int),
                new SqlParameter("@RemindInterval",SqlDbType.Int)
            };

            parms[0].Value = entity.UserId;
            parms[1].Value = entity.UserName;
            parms[2].Value = entity.UserName.ToLower();
            parms[3].Value = "";
            parms[4].Value = entity.EmployeeNo;
            parms[5].Value = entity.EmployeeCName;
            parms[6].Value = entity.EmployeeEName;
            parms[7].Value = entity.DepartNo;
            parms[8].Value = entity.DepartName;
            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.Sex;
            parms[12].Value = entity.Phone;
            parms[13].Value = entity.Email;
            parms[14].Value = entity.DepartId;
            parms[15].Value = entity.Linage;
            parms[16].Value = entity.RemindInterval;

            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_Users_EditProfile", parms);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Users_EditProfile", parms);
            }
        }


        /// <summary>
        /// 编辑用户
        /// </summary>
        /// <param name="entity"></param>
        /// <returns>返回新创建的用户ID</returns>
        public void EditProfile2(MembershipInfo entity, string ConnStr = "")
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int) { Value=entity.UserId},
                new SqlParameter("@UserName",SqlDbType.NVarChar,20){ Value=entity.UserName},
                new SqlParameter("@LoweredUserName",SqlDbType.NVarChar,20){ Value=entity.UserName.ToLower()},
                new SqlParameter("@EmployeeCName",SqlDbType.NVarChar,50){ Value=entity.EmployeeCName},
                new SqlParameter("@EmployeeEName",SqlDbType.VarChar,50){ Value=entity.EmployeeEName},
                new SqlParameter("@ModifyBy",SqlDbType.VarChar,20){ Value=entity.ModifyBy},
                new SqlParameter("@Sex",SqlDbType.Int){ Value=entity.Sex},
                new SqlParameter("@Phone",SqlDbType.VarChar,20){ Value=entity.Phone},
                new SqlParameter("@Email",SqlDbType.VarChar,50){ Value=entity.Email},
                new SqlParameter("@Linage",SqlDbType.Int){ Value=entity.Linage},
                new SqlParameter("@RemindInterval",SqlDbType.Int){ Value=entity.RemindInterval}
            };

            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_Users_EditProfile2", parms);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Users_EditProfile2", parms);
            }
        }


        /// <summary>
        /// 删除用户
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="username"></param>
        public void Delete(String idString, String username, string ConnStr = "")
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@IdString",SqlDbType.VarChar,1000),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = idString;
            parms[1].Value = username;

            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_Users_Delete", parms);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Users_Delete", parms);
            }
        }

        /// <summary>
        /// 分页获取用户资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="uSERCount">uSER 总数。</param>
        /// <returns>USER 列表。</returns>
        public List<MembershipInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MembershipInfo> list = new List<MembershipInfo>();
            MembershipInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwUserMembership ", "UserId",
                @"UserId,CName,EName,Sex,Phone,Email,EmployeeId,EmployeeNo,DepartNo,DepartName,UserName, IsApproved, IsLockedOut, Status, UserType, DepartId,IsOnline,
                WechatNumber,ModifyDateTime,ModifyBy,CreateBy,CreateDateTime", searchSettings, sortExpression);
            //, a.Site
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MembershipInfo();
                    entity.UserId = rdr.GetInt32(0);
                    entity.EmployeeCName = rdr.GetString(1);
                    entity.EmployeeEName = rdr.GetString(2);
                    entity.Sex = rdr.GetInt32(3);
                    entity.Phone = rdr.GetString(4);
                    entity.Email = rdr.GetString(5);
                    entity.EmployeeId = rdr.GetInt32(6);
                    entity.EmployeeNo = rdr.GetString(7);
                    entity.DepartNo = rdr.GetString(8);
                    entity.DepartName = rdr.GetString(9);
                    entity.UserName = rdr.GetString(10);
                    entity.IsApproved = rdr.GetBoolean(11);
                    entity.IsLockedOut = rdr.GetBoolean(12);
                    entity.UserStatus = rdr.GetInt32(13);
                    entity.UserType = rdr.GetInt32(14);
                    entity.DepartId = rdr.GetInt32(15);
                    entity.IsOnline = rdr.GetBoolean(16);
                    entity.WechatNumber = rdr.GetString(17);
                    entity.ModifyBy = rdr.GetString(19);
                    entity.ModifyDateTime = rdr.GetDateTime(18);
                    entity.CreateBy = rdr.GetString(20);
                    entity.CreateDateTime = rdr.GetDateTime(21);
                    /*
                    //Add By Alen 2015-08-25
                    //同兴达增加多工厂
                    entity.Site = rdr.GetString(16);
                     * */

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 账套分页获取用户资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="uSERCount">uSER 总数。</param>
        /// <returns>USER 列表。</returns>
        public List<MembershipInfo> GetAllSub(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MembershipInfo> list = new List<MembershipInfo>();
            MembershipInfo entity = null;
            string ConnStr = Convert.ToString(System.Web.HttpContext.Current.Session["ConnStr"]);
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwUserMembership ", "UserId",
                "UserId,CName,EName,Sex,Phone,Email,EmployeeId,EmployeeNo,DepartNo,DepartName,UserName, IsApproved, IsLockedOut, Status, UserType, DepartId,IsOnline,WechatNumber", searchSettings, sortExpression);
            //, a.Site
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MembershipInfo();
                    entity.UserId = rdr.GetInt32(0);
                    entity.EmployeeCName = rdr.GetString(1);
                    entity.EmployeeEName = rdr.GetString(2);
                    entity.Sex = rdr.GetInt32(3);
                    entity.Phone = rdr.GetString(4);
                    entity.Email = rdr.GetString(5);
                    entity.EmployeeId = rdr.GetInt32(6);
                    entity.EmployeeNo = rdr.GetString(7);
                    entity.DepartNo = rdr.GetString(8);
                    entity.DepartName = rdr.GetString(9);
                    entity.UserName = rdr.GetString(10);
                    entity.IsApproved = rdr.GetBoolean(11);
                    entity.IsLockedOut = rdr.GetBoolean(12);
                    entity.UserStatus = rdr.GetInt32(13);
                    entity.UserType = rdr.GetInt32(14);
                    entity.DepartId = rdr.GetInt32(15);
                    entity.IsOnline = rdr.GetBoolean(16);
                    entity.WechatNumber = rdr.GetString(17);
                    /*
                    //Add By Alen 2015-08-25
                    //同兴达增加多工厂
                    entity.Site = rdr.GetString(16);
                     * */

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取用户记录数
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="userName">用户名</param>
        /// <param name="password">加密后的密码</param>
        /// <returns></returns>
        public LoginResult UserLogin(string userName, string password, bool loginFromClient, int userCount)
        {

            MembershipInfo userInfo = this.GetByName(userName);
            if (userInfo == null)
            {
                return LoginResult.InvalidUser;
            }
            if (userInfo.IsLockedOut)
            {
                return LoginResult.Locked;
            }
            if (!userInfo.IsApproved)
            {
                return LoginResult.UnApproved;
            }
            int userId = userInfo.UserId;

            //check user license
            if (userCount > 0
               && userId != -1
               && (userInfo.UserType == -1 || (userInfo.UserType != -1 && isCheckSupplierUser)))  //系统用户或者需要检查的供应商用户
            {
                int onlineUserCount = this.GetOnlineUserCount();
                if (onlineUserCount >= userCount)
                {
                    userInfo = null;
                    return LoginResult.InvalidLicenseUserCount;
                }

                //check user is online
                bool userIsOnline = this.CheckUserIsOnline(userId);
                if (userIsOnline)
                {
                    userInfo = null;
                    return LoginResult.UserIsOnline;
                }
            }

            LoginResult result = this.ValidatePassword(userId, password);
            if (result != LoginResult.Success)
            {
                userInfo = null;
                return result;
            }

            if (userCount > 0 && userId != -1)
            {
                this.ChangeUserOnlineState(userId, loginFromClient);
            }

            this.loginUsersInfo = userInfo;
            return LoginResult.Success;
        }

        /// <summary>
        /// 用户登录，带客户端IP登录
        /// </summary>
        /// <param name="userName">用户名</param>
        /// <param name="password">加密后的密码</param>
        /// <returns></returns>
        public LoginResult UserLogin(string userName, string password, bool loginFromClient, int userCount, string clientIP)
        {

            MembershipInfo userInfo = this.GetByName(userName);
            if (userInfo == null)
            {
                return LoginResult.InvalidUser;
            }
            if (userInfo.IsLockedOut)
            {
                return LoginResult.Locked;
            }
            if (!userInfo.IsApproved)
            {
                return LoginResult.UnApproved;
            }
            int userId = userInfo.UserId;

            //check user license
            if (userCount > 0
                && userId != -1
                && (userInfo.UserType == -1 || (userInfo.UserType != -1 && isCheckSupplierUser)))  //系统用户或者需要检查的供应商用户
            {
                int onlineUserCount = this.GetOnlineUserCount();
                if (onlineUserCount >= userCount)
                {
                    userInfo = null;
                    return LoginResult.InvalidLicenseUserCount;
                }

                //check user is online
                bool userIsOnline = this.CheckUserIsOnline(userId, clientIP);
                if (userIsOnline)
                {
                    userInfo = null;
                    return LoginResult.UserIsOnline;
                }
            }

            LoginResult result = this.ValidatePassword(userId, password);
            if (result != LoginResult.Success)
            {
                userInfo = null;
                return result;
            }

            if (userCount > 0 && userId != -1)
            {
                this.ChangeUserOnlineState(userId, loginFromClient);
            }

            this.loginUsersInfo = userInfo;
            return LoginResult.Success;
        }

        /// <summary>
        /// 根据登录名取得用户信息
        /// </summary>
        /// <param name="userName">用户登录名</param>
        /// <returns>返回用户信息实体</returns>
        public MembershipInfo GetByName(string userName)
        {
            MembershipInfo entity = null;
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };
            parameters[0].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Users_GetByName", parameters))
            {
                if (rdr.Read())
                {
                    entity = new MembershipInfo();

                    entity.UserId = rdr.GetInt32(0);
                    entity.EmployeeCName = rdr.GetString(1);
                    entity.EmployeeEName = rdr.GetString(2);
                    entity.Sex = rdr.GetInt32(3);
                    entity.Phone = rdr.GetString(4);
                    entity.Email = rdr.GetString(5);
                    entity.EmployeeId = rdr.GetInt32(6);
                    entity.EmployeeNo = rdr.GetString(7);
                    entity.DepartNo = rdr.GetString(8);
                    entity.DepartName = rdr.GetString(9);
                    entity.UserName = rdr.GetString(10);
                    entity.IsApproved = rdr.GetBoolean(11);
                    entity.IsLockedOut = rdr.GetBoolean(12);
                    entity.Linage = rdr.GetInt32(13);
                    entity.RemindInterval = rdr.GetInt32(14);
                    entity.RecentItems = rdr.GetString(15);
                    entity.UserStatus = rdr.GetInt32(16);
                    entity.UserType = rdr.GetInt32(17);
                    entity.DepartId = rdr.GetInt32(18);
                    entity.LastLoginDate = rdr.GetDateTime(19);
                    entity.LastActivityDate = rdr.GetDateTime(20);
                    /*
                    //Add By Alen 2015-08-25
                    //同兴达增加多工厂
                    entity.Site = rdr.GetString(19);
                     * */
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <param name="userName">用户登录名</param>
        /// <returns>返回用户信息实体</returns>
        public MembershipInfo GetInfo(int userId, string ConnStr = "")
        {
            MembershipInfo entity = null;
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@FieldValue", SqlDbType.VarChar, 20),
                new SqlParameter("@IsById", SqlDbType.Bit)
            };
            parameters[0].Value = userId;
            parameters[1].Value = true;
            if (string.IsNullOrEmpty(ConnStr))
            {
                ConnStr = SQLHelper.MESConnString;
            }
            ////using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Users_GetInfo", parameters))
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "SYS_Users_GetInfo", parameters))
            {
                if (rdr.Read())
                {
                    entity = new MembershipInfo();

                    entity.UserId = rdr.GetInt32(0);
                    entity.EmployeeCName = rdr.GetString(1);
                    entity.EmployeeEName = rdr.GetString(2);
                    entity.Sex = rdr.GetInt32(3);
                    entity.Phone = rdr.GetString(4);
                    entity.Email = rdr.GetString(5);
                    entity.EmployeeId = rdr.GetInt32(6);
                    entity.EmployeeNo = rdr.GetString(7);
                    entity.DepartNo = rdr.GetString(8);
                    entity.DepartName = rdr.GetString(9);
                    entity.UserName = rdr.GetString(10);
                    entity.IsApproved = rdr.GetBoolean(11);
                    entity.IsLockedOut = rdr.GetBoolean(12);
                    entity.Linage = rdr.GetInt32(13);
                    entity.RemindInterval = rdr.GetInt32(14);
                    entity.RecentItems = rdr.GetString(15);
                    entity.UserStatus = rdr.GetInt32(16);
                    entity.UserType = rdr.GetInt32(17);
                    entity.DepartId = rdr.GetInt32(18);
                    entity.WechatNumber = rdr.GetString(19);
                    entity.Password = rdr.GetString(20);
                    entity.DingTalkUserId = rdr["DingTalkUserId"]?.ToString();
                    entity.IsHandle = Convert.ToBoolean(rdr["IsHandle"]);
                    

                    /* Service Now 增加CustomerName属性，关联SN_Customer表，MES中不需要
                    entity.CustomerName = rdr.GetString(19);
                     * */
                    /*
                    //Add By Alen 2015-08-25
                    //同兴达增加多工厂
                    entity.Site = rdr.GetString(19);
                     * */
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <param name="userName">用户登录名</param>
        /// <returns>返回用户信息实体</returns>
        public MembershipInfo GetInfo(string fieldValue, string ConnStr = "")
        {
            MembershipInfo entity = null;
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@FieldValue", SqlDbType.VarChar, 20),
                new SqlParameter("@IsById", SqlDbType.Bit)
            };
            parameters[0].Value = fieldValue;
            parameters[1].Value = false;
            if (string.IsNullOrEmpty(ConnStr))
            {
                ConnStr = SQLHelper.MESConnString;
            }
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "SYS_Users_GetInfo", parameters))
            {
                if (rdr.Read())
                {
                    entity = new MembershipInfo();

                    entity.UserId = rdr.GetInt32(0);
                    entity.EmployeeCName = rdr.GetString(1);
                    entity.EmployeeEName = rdr.GetString(2);
                    entity.Sex = rdr.GetInt32(3);
                    entity.Phone = rdr.GetString(4);
                    entity.Email = rdr.GetString(5);
                    entity.EmployeeId = rdr.GetInt32(6);
                    entity.EmployeeNo = rdr.GetString(7);
                    entity.DepartNo = rdr.GetString(8);
                    entity.DepartName = rdr.GetString(9);
                    entity.UserName = rdr.GetString(10);
                    entity.IsApproved = rdr.GetBoolean(11);
                    entity.IsLockedOut = rdr.GetBoolean(12);
                    entity.Linage = rdr.GetInt32(13);
                    entity.RemindInterval = rdr.GetInt32(14);
                    entity.RecentItems = rdr.GetString(15);
                    entity.UserStatus = rdr.GetInt32(16);
                    entity.UserType = rdr.GetInt32(17);
                    entity.DepartId = rdr.GetInt32(18);
                    entity.WechatNumber = rdr.GetString(19);
                    entity.DingTalkUserId = rdr["DingTalkUserId"]?.ToString();
                    entity.IsHandle = Convert.ToBoolean(rdr["IsHandle"]);
                    /*
                    //Add By Alen 2015-08-25
                    //同兴达增加多工厂
                    entity.Site = rdr.GetString(19);
                     * */
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 获取在线用户数
        /// </summary>
        /// <returns></returns>
        public List<MembershipInfo> GetOnlineUserList()
        {
            List<MembershipInfo> list = new List<MembershipInfo>();
            //
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@Timeout",SqlDbType.Int)
            };
            parameters[0].Value = concurrentUserTimeout;
            string str = @"
                SELECT U.UserId,U.UserName,M.CName,M.EName,M.EmployeeNo,U.LastVisitTime
	            FROM SYS_Users U WITH(NOLOCK)
		            INNER JOIN SYS_Membership M WITH(NOLOCK) ON U.UserId =M.UserId
                WHERE U.IsOnline =1 
                    AND DATEADD(MINUTE,@Timeout,U.LastVisitTime) >= GETDATE() ";
            if (!isCheckSupplierUser)
            {
                str += " AND M.UserType = -1";
            }
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, str, parameters))
            {
                while (rdr.Read())
                {
                    MembershipInfo entity = new MembershipInfo();
                    entity.UserId = rdr.GetInt32(0);
                    entity.UserName = rdr.GetString(1);
                    entity.EmployeeCName = rdr.GetString(2);
                    entity.EmployeeEName = rdr.GetString(3);
                    entity.EmployeeNo = rdr.GetString(4);
                    entity.LastVisitTime = rdr.GetDateTime(5);
                    list.Add(entity);
                }
            }
            return list;
        }

        /// <summary>
        /// 获取在线用户数目
        /// </summary>
        /// <returns></returns>
        public int GetOnlineUserCount()
        {
            int onlineUserCount = 0;
            //
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@Timeout",SqlDbType.Int)
            };
            parameters[0].Value = concurrentUserTimeout;
            string str = @"
                SELECT COUNT(1) AS Num 
	            FROM SYS_Users U WITH(NOLOCK)
		            INNER JOIN SYS_Membership M WITH(NOLOCK) ON U.UserId =M.UserId
                WHERE U.IsOnline =1 
                    AND DATEADD(MINUTE,@Timeout,U.LastVisitTime) >= GETDATE() ";
            if (!isCheckSupplierUser)
            {
                str += " AND M.UserType = -1";
            }
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, str, parameters))
            {
                if (rdr.Read())
                {
                    onlineUserCount = rdr.GetInt32(0);
                }
                rdr.Close();
            }
            return onlineUserCount;
        }

        /// <summary>
        /// 检查用户是否在线
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public bool CheckUserIsOnline(int userId)
        {
            bool userIsOnline = false;
            StringBuilder str = new StringBuilder();

            str.Append("select UserId ");
            str.Append(" from [SYS_UsersOnline]");
            str.Append(" where UserId = @UserId ");

            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@UserId",SqlDbType.Int)
            };
            parameters[0].Value = userId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, str.ToString(), parameters))
            {
                if (rdr.Read())
                {
                    userIsOnline = true;
                }
                rdr.Close();
            }
            return userIsOnline;
        }

        /// <summary>
        /// 检查用户是否在线
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public bool CheckUserIsOnline(int userId, string clientIP)
        {
            bool userIsOnline = false;
            StringBuilder str = new StringBuilder();

            str.Append("select UserId ");
            str.Append(" from [SYS_UsersOnline]");
            str.Append(" where UserId = @UserId ");
            str.Append(" and ClientIP <> @ClientIP ");//同一个IP，同一个用户可以同时多次登录

            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@ClientIP",SqlDbType.VarChar,50)
            };
            parameters[0].Value = userId;
            parameters[1].Value = clientIP;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, str.ToString(), parameters))
            {
                if (rdr.Read())
                {
                    userIsOnline = true;
                }
                rdr.Close();
            }
            return userIsOnline;
        }

        /// <summary>
        /// 验证用户登录
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="password">密码</param>
        /// <returns>返回登录结果。</returns>
        public LoginResult ValidatePassword(int userId, string password)
        {
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@Password", SqlDbType.VarChar, 50) };

            parameters[0].Value = userId;
            parameters[1].Value = password;
            switch (Convert.ToInt32(SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "SYS_Users_ValidatePassword", parameters)))
            {
                case -1:
                    return LoginResult.InvalidMembership;

                case 0:
                    return LoginResult.InvalidPassword;

                case 1:
                    return LoginResult.Success;
            }
            return LoginResult.InvalidPassword;
        }

        /// <summary>
        /// 更改用户在线状态
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="loginFromClient"></param>
        public void ChangeUserOnlineState(int userId, bool loginFromClient)
        {
            StringBuilder str = new StringBuilder();
            str.Append("INSERT INTO SYS_UsersOnline(UserId,LastCallTime,Flag)");
            str.Append(" VALUES(@UserId,@LastLoginTime,@LoginFromClient) ");
            str.Append(" UPDATE SYS_Users SET IsOnline = 1 WHERE UserId = @UserId ");
            SqlParameter[] parametrs = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@LastLoginTime",SqlDbType.DateTime),
                new SqlParameter("@LoginFromClient",SqlDbType.Bit)
            };

            parametrs[0].Value = userId;
            parametrs[1].Value = DateTime.Now;
            parametrs[2].Value = loginFromClient;

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, str.ToString(), parametrs);
        }

        /// <summary>
        /// 更改用户在线状态
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="loginFromClient"></param>
        public void ChangeUserOnlineState(int userId, bool loginFromClient, string clientIP)
        {
            StringBuilder str = new StringBuilder();
            str.Append("IF NOT EXISTS(SELECT TOP 1 1 FROM SYS_UsersOnline WHERE UserId = @UserId AND ClientIP = @ClientIP)");
            str.Append("BEGIN");
            str.Append("INSERT INTO SYS_UsersOnline(UserId,LastCallTime,Flag,ClientIP)");
            str.Append(" VALUES(@UserId,GETDATE(),@LoginFromClient,@ClientIP) ");
            str.Append("END");
            str.Append(" UPDATE SYS_Users SET IsOnline = 1 WHERE UserId = @UserId ");
            SqlParameter[] parametrs = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@LoginFromClient",SqlDbType.Bit),
                new SqlParameter("@ClientIP",SqlDbType.VarChar,50)
            };

            parametrs[0].Value = userId;
            parametrs[1].Value = loginFromClient;
            parametrs[2].Value = clientIP;

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, str.ToString(), parametrs);
        }

        /// <summary>
        /// 获取当前登录的用户信息实体
        /// </summary>
        /// <returns></returns>
        public MembershipInfo GetLoginUser()
        {
            return this.loginUsersInfo;
        }

        /// <summary>
        /// 更新用户在线时间
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public bool AjaxPolling(int userId)
        {
            bool userIsOnline = true;
            StringBuilder str = new StringBuilder();
            str.Append(" DECLARE @RowCount INT ");
            str.Append(" UPDATE SYS_UsersOnline ");
            str.Append(" SET LastCallTime = GetDate() ");
            str.Append(" WHERE UserId = @UserId ");
            str.Append(" SET @RowCount = @@ROWCOUNT ");
            str.Append(" UPDATE SYS_Users SET IsOnline = 0 FROM SYS_Users AS A INNER JOIN SYS_UsersOnline AS B ON A.UserId = B.UserId WHERE DATEDIFF(" + datediff_unit + ",LastCallTime,GetDate()) > " + datediff_time.ToString() + " ");
            //   str.Append(" DELETE FROM SYS_UsersOnline WHERE DATEDIFF(" + datediff_unit + ",LastCallTime,GetDate()) > " + datediff_time.ToString() + " ");
            str.Append(" SELECT @RowCount ");

            SqlParameter[] parametrs = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int)
            };

            parametrs[0].Value = userId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, str.ToString(), parametrs))
            {
                if (rdr.Read())
                {
                    if (rdr.GetInt32(0) == 0)
                    {
                        userIsOnline = false;
                    }
                }
                rdr.Close();
            }
            return userIsOnline;
        }

        /// <summary>
        /// 获取在线用户
        /// </summary>
        /// <returns></returns>
        public List<MembershipInfo> GetOnlineUsers()
        {
            List<MembershipInfo> list = new List<MembershipInfo>();
            MembershipInfo userInfo = null;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "SYS_Users_GetOnlineUsers", null))
            {
                while (rdr.Read())
                {
                    userInfo = new MembershipInfo();
                    userInfo.UserId = rdr.GetInt32(0);
                    userInfo.UserName = rdr.GetString(1);
                    userInfo.EmployeeCName = rdr.GetString(2);
                    userInfo.EmployeeEName = rdr.GetString(3);
                    userInfo.Sex = rdr.GetInt32(4);
                    userInfo.Phone = rdr.GetString(5);
                    userInfo.Email = rdr.GetString(6);
                    userInfo.EmployeeNo = rdr.GetString(7);
                    userInfo.DepartId = rdr.GetInt32(8);
                    userInfo.DepartNo = rdr.GetString(9);
                    userInfo.DepartName = rdr.GetString(10);
                    userInfo.UserType = rdr.GetInt32(11);

                    list.Add(userInfo);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 注销用户
        /// </summary>
        /// <param name="userId"></param>
        public void LogoffUser(int userId, string userName, string ConnStr = "")
        {
            StringBuilder str = new StringBuilder();
            str.Append(" DELETE FROM SYS_UsersOnline WHERE UserId = @UserId ");
            //    str.Append(" DELETE FROM SYS_UsersOnline WHERE DATEDIFF(" + datediff_unit + ",LastCallTime,GetDate()) > " + datediff_time.ToString() + " ");
            str.Append(" UPDATE SYS_Users SET IsOnline = 0 WHERE UserId = @UserId ");
            SqlParameter[] parametrs = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int)
            };
            parametrs[0].Value = userId;
            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryText(ConnStr, str.ToString(), parametrs);
            }
            else
            {
                SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, str.ToString(), parametrs);
            }
        }

        /// <summary>
        /// 检查用户权限
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="popedom"></param>
        /// <returns></returns>
        public static bool CheckUserIsWarrantted(int userId, int popedom)
        {
            bool flag = false;
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@Popedom", SqlDbType.Int) };

            parameters[0].Value = userId;
            parameters[1].Value = popedom;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Users_UserIsWarrantted", parameters))
            {
                if (rdr.Read())
                {
                    flag = true;
                }
                rdr.Close();
            }
            return flag;
        }

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="oldpassword"></param>
        /// <param name="newpassword"></param>
        /// <param name="userName"></param>
        public void ChangePassword(int userId, string oldpassword, string newpassword, string userName, string ConnStr = "")
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@OldPassword",SqlDbType.VarChar,50),
                new SqlParameter("@NewPassword",SqlDbType.VarChar,50),
                new SqlParameter("@IsInitPassword",SqlDbType.Bit),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = userId;
            parms[1].Value = SKT.Common.Utility.EncryptHelper.Encrypt(oldpassword.ToString());
            parms[2].Value = SKT.Common.Utility.EncryptHelper.Encrypt(newpassword.ToString());
            parms[3].Value = false;
            parms[4].Value = userName;

            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_Users_UpdatePassword", parms);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Users_UpdatePassword", parms);
            }
        }

        /// <summary>
        /// 重置用户密码
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        public void InitPassword(int userId, string userName, string pwd, string ConnStr = "")
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@OldPassword",SqlDbType.VarChar,50),
                new SqlParameter("@NewPassword",SqlDbType.VarChar,50),
                new SqlParameter("@IsInitPassword",SqlDbType.Bit),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = userId;
            parms[1].Value = "";
            parms[2].Value = (String.IsNullOrEmpty(pwd) ? SKT.Common.Utility.EncryptHelper.Encrypt("123456") : SKT.Common.Utility.EncryptHelper.Encrypt(pwd.ToString()));
            parms[3].Value = true;
            parms[4].Value = userName;

            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_Users_UpdatePassword", parms);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Users_UpdatePassword", parms);
            }
        }

        /// <summary>
        /// 解锁锁定的用户
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        public void UnlockUser(int userId, string userName, string ConnStr = "")
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = userId;
            parms[1].Value = userName;
            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_Users_UnlockUser", parms);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Users_UnlockUser", parms);
            }
        }
        /// <summary>
        /// 获取权限用户
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="popedom"></param>
        /// <returns></returns>
        public List<MembershipInfo> GetPopedomUsers(int startRow, int maxRows, int popedom)
        {
            List<MembershipInfo> list = new List<MembershipInfo>();
            MembershipInfo info = null;
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@StartRow", SqlDbType.Int),
                new SqlParameter("@MaxRows", SqlDbType.Int),
                new SqlParameter("@Popedom", SqlDbType.Int),
                new SqlParameter("@UsersCount", SqlDbType.Int) };

            parameters[0].Value = startRow;
            parameters[1].Value = maxRows;
            parameters[2].Value = popedom;
            parameters[3].Direction = ParameterDirection.ReturnValue;
            using (SqlDataReader reader = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_PopedomInRole_GetPopedomUsers", parameters))
            {
                while (reader.Read())
                {
                    info = new MembershipInfo();
                    info.RoleName = reader.GetString(0);
                    info.UserName = reader.GetString(1);
                    info.UserId = reader.GetInt32(2);
                    list.Add(info);
                }
                reader.Close();
            }
            this.recordCount = Convert.ToInt32(parameters[3].Value);
            return list;
        }
        /// <summary>
        /// 子厂获取权限用户
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="popedom"></param>
        /// <returns></returns>
        public List<MembershipInfo> GetPopedomUsersSub(int startRow, int maxRows, int popedom)
        {
            List<MembershipInfo> list = new List<MembershipInfo>();
            MembershipInfo info = null;
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@StartRow", SqlDbType.Int),
                new SqlParameter("@MaxRows", SqlDbType.Int),
                new SqlParameter("@Popedom", SqlDbType.Int),
                new SqlParameter("@UsersCount", SqlDbType.Int) };

            parameters[0].Value = startRow;
            parameters[1].Value = maxRows;
            parameters[2].Value = popedom;
            parameters[3].Direction = ParameterDirection.ReturnValue;
            string ConnStr = Convert.ToString(System.Web.HttpContext.Current.Session["ConnStr"]);
            using (SqlDataReader reader = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "SYS_PopedomInRole_GetPopedomUsers", parameters))
            {
                while (reader.Read())
                {
                    info = new MembershipInfo();
                    info.RoleName = reader.GetString(0);
                    info.UserName = reader.GetString(1);
                    info.UserId = reader.GetInt32(2);
                    list.Add(info);
                }
                reader.Close();
            }
            this.recordCount = Convert.ToInt32(parameters[3].Value);
            return list;
        }

        /// <summary>
        /// 获取权限用户数
        /// </summary>
        /// <param name="popedom"></param>
        /// <returns></returns>
        public int GetPopedomUsersCount(int popedom)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 获取用户错误密码次数
        /// </summary>
        /// <param name="username">用户名</param>
        /// <returns>用户错误密码次数</returns>
        public int GetFailedPasswordCount(string username)
        {
            int failedPasswordCount = 0;
            SqlParameter[] parms = new SqlParameter[]{
               new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = username;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Users_GetFailedPasswordCount", parms))
            {
                if (rdr.Read())
                {
                    failedPasswordCount = rdr.GetInt32(0);
                }
                rdr.Close();
            }
            return failedPasswordCount;
        }

        /// <summary>
        /// 更新用户最后访问时间
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="lastVisitTime">最后的访问时间</param>
        /// <returns></returns>
        public bool UpdateLastVistTime(int userId)
        {
            SqlParameter[] paras = new SqlParameter[]
             {
                new SqlParameter("@UserId",SqlDbType.Int),
             };

            paras[0].Value = userId;
            int i = SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, @"
                UPDATE A SET 
                    A.LastVisitTime= GETDATE()
                FROM SYS_Users A 
                WHERE A.UserId=@UserId", paras);
            if (i > 0)
                return true;
            return false;
        }

        //部门人员
        public List<MembershipInfo> GetUserByOrganizationId(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            List<MembershipInfo> list = new List<MembershipInfo>();
            SqlParameter[] array = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vmGetUserByOrganization", "MembershipId", "[MembershipId],[UserId],[CName],[EName],[Sex],[Phone],[Email],[EmployeeNo],[DepartName],ModifyBy,ModifyDateTime", searchSettings, sortExpression);
            using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", array))
            {
                while (sqlDataReader.Read())
                {
                    list.Add(new MembershipInfo
                    {
                        MembershipId = sqlDataReader.GetInt32(0),
                        UserId = sqlDataReader.GetInt32(1),
                        EmployeeCName = sqlDataReader.GetString(2),
                        EmployeeEName = sqlDataReader.GetString(3),
                        Sex = sqlDataReader.GetInt32(4),
                        Phone = sqlDataReader.GetString(5),
                        Email = sqlDataReader.GetString(6),
                        EmployeeNo = sqlDataReader.GetString(7),
                        DepartName = sqlDataReader.GetString(8),
                        ModifyBy = sqlDataReader.GetString(9),
                        ModifyDateTime = sqlDataReader.GetDateTime(10)
                    });
                }
                sqlDataReader.Close();
            }
            this.recordCount = Convert.ToInt32(array[array.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取user信息
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        public MembershipInfo GetUserInfo(int userid)
        {
          MembershipInfo entity = new MembershipInfo();
            SqlParameter parms = new SqlParameter("@UserId", userid);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "select * from vmUserinfo where userid =@UserId ", parms))
            {
                if (rdr.Read())
                {
                    entity.UserId = rdr.GetInt32(0);
                    entity.EmployeeCName = rdr.GetString(1);
                    entity.EmployeeEName = rdr.GetString(2);
                    entity.Sex = rdr.GetInt32(3);
                    entity.Phone = rdr.GetString(4);
                    entity.Email = rdr.GetString(5);
                    entity.EmployeeId = rdr.GetInt32(6);
                    entity.EmployeeNo = rdr.GetString(7);
                    entity.DepartNo = rdr.GetString(8) == "'" ? "" : rdr.GetString(8);
                    entity.DepartName = rdr.GetString(9) == "'" ? "" : rdr.GetString(9);
                    entity.UserName = rdr.GetString(10);
                    entity.IsApproved = rdr.GetBoolean(11);
                    entity.IsLockedOut = rdr.GetBoolean(12);
                    entity.UserStatus = rdr.GetInt32(13);
                    entity.UserType = rdr.GetInt32(14);
                    entity.DepartId = rdr.GetInt32(15);
                    entity.CreateDateTime = rdr.GetDateTime(16);
                    //entity.RoleName = rdr.GetString(17);
                   // entity.Workshift = rdr.GetString(18);
                }
                rdr.Close();
            }
            return entity;
        }
    }
}
