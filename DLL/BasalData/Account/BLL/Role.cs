using System;
using System.Collections.Generic;
using System.Text;
using SKT.Common.Account.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Web.SessionState;

namespace SKT.Common.Account.BLL
{
    public class Role:IRequiresSessionState
    {
        /// <summary>
        /// 角色记录数
        /// </summary>
        private int rolesCount = 0;

        /// <summary>
        /// 编辑角色信息
        /// </summary>
        /// <param name="roleInfo"></param>
        /// <param name="operatorName"></param>
        public Int32 Edit(RoleInfo roleInfo, string ConnStr = "")
        {
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@RoleId", SqlDbType.Int), 
                new SqlParameter("@RoleName", SqlDbType.NVarChar, 50), 
                new SqlParameter("@Description", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsSupper", SqlDbType.Bit),
                new SqlParameter("@CreateBy", SqlDbType.VarChar,20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar,20)
            };

            parameters[0].Value = roleInfo.RoleID;
            parameters[0].Direction = ParameterDirection.InputOutput;
            parameters[1].Value = roleInfo.RoleName;
            parameters[2].Value = roleInfo.Description;
            parameters[3].Value = roleInfo.IsSupper;
            parameters[4].Value = roleInfo.CreateBy;
            parameters[5].Value = roleInfo.ModifyBy;

            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_Role_Edit", parameters);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Role_Edit", parameters);
            }
            return Convert.ToInt32(parameters[0].Value);
        }

        /// <summary>
        /// 删除角色
        /// </summary>
        /// <param name="roleIdString">要删除的角色ID</param>
        /// <param name="userName">操作人员</param>
        public void DeleteByIdString(string roleIdString, string userName,string ConnStr = "")
        {
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@RoleIdString", SqlDbType.VarChar, 1000), 
                new SqlParameter("@LogContent", SqlDbType.NVarChar, 2000) };

            parameters[0].Value = roleIdString;
            parameters[1].Direction = ParameterDirection.Output;

            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_Role_DeleteByRoleId", parameters);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Role_DeleteByRoleId", parameters);
            }
        }

        /// <summary>
        /// 分页获取角色信息
        /// </summary>
        /// <param name="startRow">开始行</param>
        /// <param name="maxRows">最大行</param>
        /// <param name="sortExpression">排序条件</param>
        /// <param name="searchSettings">搜索条件</param>
        /// <returns>返回角色列表</returns>
        public List<RoleInfo> GetAll(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            List<RoleInfo> list = new List<RoleInfo>();
            SqlParameter[] parameters = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_Role", "RoleId",////SYS_Role
                    "[RoleId],[RoleName],[Description],[CreateDateTime],[CreateBy],[ModifyDateTime],[ModifyBy],[Remark],[IsSupper]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parameters))
            {
                while (rdr.Read())
                {
                    list.Add(new RoleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                            rdr.GetDateTime(5), rdr.GetString(6), rdr.GetString(7), rdr.GetBoolean(8)));

                }
                rdr.Close();
            }
            this.rolesCount = Convert.ToInt32(parameters[parameters.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 子厂分页获取角色信息
        /// </summary>
        /// <param name="startRow">开始行</param>
        /// <param name="maxRows">最大行</param>
        /// <param name="sortExpression">排序条件</param>
        /// <param name="searchSettings">搜索条件</param>
        /// <returns>返回角色列表</returns>
        public List<RoleInfo> GetAllSub(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            List<RoleInfo> list = new List<RoleInfo>();
            string ConnStr = Convert.ToString(System.Web.HttpContext.Current.Session["ConnStr"]);
            SqlParameter[] parameters = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_Role", "RoleId",////SYS_Role
                    "[RoleId],[RoleName],[Description],[CreateDateTime],[CreateBy],[ModifyDateTime],[ModifyBy],[Remark],[IsSupper]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "Common_GetPageRecords", parameters))
            {
                while (rdr.Read())
                {
                    list.Add(new RoleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                            rdr.GetDateTime(5), rdr.GetString(6), rdr.GetString(7), rdr.GetBoolean(8)));

                }
                rdr.Close();
            }
            this.rolesCount = Convert.ToInt32(parameters[parameters.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 分页获取角色信息
        /// </summary>
        /// <param name="startRow">开始行</param>
        /// <param name="maxRows">最大行</param>
        /// <param name="sortExpression">排序条件</param>
        /// <param name="searchSettings">搜索条件</param>
        /// <returns>返回角色列表</returns>
        public List<RoleInfo> GetAllGroup(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            List<RoleInfo> list = new List<RoleInfo>();
            SqlParameter[] parameters = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SYS_Role", "RoleId",
                    "[RoleId],[RoleName],[Description],[CreateDateTime],[CreateBy],[ModifyDateTime],[ModifyBy],[Remark],[IsSupper]", searchSettings, sortExpression);
            string ConnStr = Convert.ToString(System.Web.HttpContext.Current.Session["ConnStr"]); 
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "Common_GetPageRecords", parameters))
            {
                while (rdr.Read())
                {
                    list.Add(new RoleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                            rdr.GetDateTime(5), rdr.GetString(6), rdr.GetString(7), rdr.GetBoolean(8)));

                }
                rdr.Close();
            }
            this.rolesCount = Convert.ToInt32(parameters[parameters.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 根据角色ID获取角色信息
        /// </summary>
        /// <param name="roleId">角色ID</param>
        /// <returns>返回角色实体</returns>
        public RoleInfo GetInfo(int roleId,string ConnStr = "")
        {
            RoleInfo info = null;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@FieldValue", SqlDbType.NVarChar,50),
                new SqlParameter("@IsByID",SqlDbType.Bit)
            };

            parameters[0].Value = roleId;
            parameters[1].Value = true;

            if (string.IsNullOrEmpty(ConnStr))
            {
                ConnStr = SQLHelper.MESConnString;
            }
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "SYS_Role_GetInfo", parameters))
            {
                if (rdr.Read())
                {
                    info = new RoleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                            rdr.GetDateTime(5), rdr.GetString(6), rdr.GetString(7), rdr.GetBoolean(8));
                }
                rdr.Close();
            }
            return info;
        }

        /// <summary>
        /// 根据角色名字获取角色信息
        /// </summary>
        /// <param name="fieldValue">角色</param>
        /// <returns>返回角色实体</returns>
        public RoleInfo GetInfo(string fieldValue,string ConnStr = "")
        {
            RoleInfo info = null;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@FieldValue", SqlDbType.NVarChar,50),
                new SqlParameter("@IsByID",SqlDbType.Bit)
            };

            parameters[0].Value = fieldValue;
            parameters[1].Value = false;
            if (string.IsNullOrEmpty(ConnStr))
            {
                ConnStr = SQLHelper.MESConnString;
            }
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "SYS_Role_GetInfo", parameters))
            {
                if (rdr.Read())
                {
                    info = new RoleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                            rdr.GetDateTime(5), rdr.GetString(6), rdr.GetString(7), rdr.GetBoolean(8));
                }
                rdr.Close();
            }
            return info;
        }

        /// <summary>
        /// 分配权限给角色
        /// </summary>
        /// <param name="roleId">角色ID</param>
        /// <param name="popedomString">权限</param>
        public void AssignPopedomToRole(int roleId, string popedomString,string ConnStr = "")
        {
            (new PopedomInRole()).AssignPopedomToRole(roleId, popedomString,ConnStr);
        }


        /// <summary>
        /// 根据角色ID获取权限
        /// </summary>
        /// <param name="roleId">角色ID</param>
        /// <returns>返回角色和权限信息</returns>
        public List<RoleInfo> GetPopedomByRoleId(int roleId, string ConnStr = "")
        {
            PopedomInRole roles = new PopedomInRole();
            return roles.GetPopedomByRoleId(roleId, ConnStr);
        }

        /// <summary>
        /// 根据用户ID获取用户所拥有的角色
        /// </summary>
        /// <param name="startRow">开始行</param>
        /// <param name="maxRows">最大行</param>
        /// <param name="userId">用户ID</param>
        /// <returns>返回用户所拥有的角色列表</returns>
        public List<RoleInfo> GetRolesByUserId(int startRow, int maxRows, int userId,string ConnStr = "")
        {
            List<RoleInfo> list = new List<RoleInfo>();
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@StartRow", SqlDbType.Int), 
                new SqlParameter("@MaxRows", SqlDbType.Int), 
                new SqlParameter("@UserId", SqlDbType.Int), 
                new SqlParameter("@RolesCount", SqlDbType.Int) };

            parameters[0].Value = startRow;
            parameters[1].Value = maxRows;
            parameters[2].Value = userId;
            parameters[3].Direction = ParameterDirection.ReturnValue;
            if (string.IsNullOrEmpty(ConnStr))
            {
                ConnStr = SQLHelper.MESConnString;
            }
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "SYS_Role_GetRoleByUserId", parameters))
            {
                while (rdr.Read())
                {
                    list.Add(new RoleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                            rdr.GetDateTime(5), rdr.GetString(6), rdr.GetString(7), rdr.GetBoolean(8)));
                }
                rdr.Close();
            }
            this.rolesCount = Convert.ToInt32(parameters[3].Value);
            return list;
        }

        /// <summary>
        /// 获取角色记录数
        /// </summary>
        /// <param name="searchSettings">查询条件</param>
        /// <returns>返回记录数</returns>
        public int GetCount(SearchSettings searchSettings)
        {
            return this.rolesCount;
        }

        /// <summary>
        /// 移除指定用户的指定角色
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="roleIdString">角色ID字符串</param>
        /// <param name="userName">操作人员</param>
        public void RemoveRolesFromUser(int userId, string roleIdString, string userName,string ConnStr = "")
        {
            UsersInRole roles = new UsersInRole();
            string[] strArray = roleIdString.Split(new char[] { ',' });
            for (int i = 0; i < strArray.Length; i++)
            {
                roles.RemoveUsersFromRole(Convert.ToInt32(strArray[i]), Convert.ToString(userId), userName, ConnStr);
            }
        }

        /// <summary>
        /// 移除指定角色中的指定用户
        /// </summary>
        /// <param name="roleId">角色ID</param>
        /// <param name="userIdString">用户ID字符串</param>
        /// <param name="userName">操作人员</param>
        public void RemoveUsersFromRole(int roleId, string userIdString, string userName,string ConnStr = "")
        {
            new UsersInRole().RemoveUsersFromRole(roleId, userIdString, userName, ConnStr);
        }


        /// <summary>
        /// 分配角色给用户
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="roleIdString">角色</param>
        public void AssignRolesToUser(int userId, string roleIdString)
        {
            UsersInRole roles = new UsersInRole();

            string[] strArray = roleIdString.Split(new char[] { ',' });
            for (int i = 0; i < strArray.Length; i++)
            {
                roles.AssignUsersToRole(Convert.ToInt32(strArray[i]), Convert.ToString(userId));
            }
        }

        /// <summary>
        /// 分配用户给角色
        /// </summary>
        /// <param name="roleId">角色ID</param>
        /// <param name="userIdString">用户</param>
        public void AssignUsersToRole(int roleId, string userIdString)
        {
            new UsersInRole().AssignUsersToRole(roleId, userIdString);
        }

        /// <summary>
        /// 检查角色是否有用户
        /// </summary>
        /// <param name="roleId">角色ID</param>
        /// <returns>该角色有用户返回true, 否则返回false</returns>
        public bool CheckHasUsers(int roleId)
        {
            UsersInRole roles = new UsersInRole();
            int userCount = 0;
            roles.GetUsersByRoleId(0, 1, roleId, out userCount);
            return (userCount > 0);
        }

    }
}
