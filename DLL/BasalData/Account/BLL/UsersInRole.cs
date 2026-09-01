using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Account.Model;

namespace SKT.Common.Account.BLL
{
    public class UsersInRole
    {
        /// <summary>
        /// 分配用户给角色
        /// </summary>
        /// <param name="roleId"></param>
        /// <param name="userIdString"></param>
        public void AssignUsersToRole(int roleId, string userIdString, string ConnStr = "")
        {
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@RoleId", SqlDbType.Int), 
                new SqlParameter("@UserIdString", SqlDbType.VarChar, 200) };

            parameters[0].Value = roleId;
            parameters[1].Value = userIdString;
            SQLHelper.ExecuteNonQueryStoredProcedure(!string.IsNullOrEmpty(ConnStr)? ConnStr:SQLHelper.MESConnString, "SYS_UsersInRole_AssignUsersToRole", parameters);
        }

        /// <summary>
        /// 根据角色ID获取用户信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="roleId"></param>
        /// <param name="userCount"></param>
        /// <returns></returns>
        public List<MembershipInfo> GetUsersByRoleId(int startRow, int maxRows, int roleId, out int userCount)
        {
            List<MembershipInfo> list = new List<MembershipInfo>();
            MembershipInfo entity = null;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@StartRow", SqlDbType.Int), 
                new SqlParameter("@MaxRows", SqlDbType.Int), 
                new SqlParameter("@RoleId", SqlDbType.Int), 
                new SqlParameter("@UsersCount", SqlDbType.Int) };

            parameters[0].Value = startRow;
            parameters[1].Value = maxRows;
            parameters[2].Value = roleId;
            parameters[3].Direction = ParameterDirection.ReturnValue;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_UsersInRole_GetUsersByRoleId", parameters))
            {
                while (rdr.Read())
                {
                    entity = new MembershipInfo();
                    entity.UserId = rdr.GetInt32(0);
                    entity.UserName = rdr.GetString(1);
                    entity.EmployeeCName = rdr.GetString(2);
                    entity.EmployeeEName = rdr.GetString(3);
                    entity.Sex = rdr.GetInt32(4);
                    entity.Phone = rdr.GetString(5);
                    entity.Email = rdr.GetString(6);
                    entity.EmployeeId = rdr.GetInt32(7);
                    entity.EmployeeNo = rdr.GetString(8);
                    entity.DepartNo = rdr.GetString(9);
                    entity.DepartName = rdr.GetString(10);
                    entity.CreateBy = rdr.GetString(11);
                    entity.CreateDateTime = rdr.GetDateTime(12);
                    entity.ModifyBy = rdr.GetString(13);
                    entity.ModifyDateTime = rdr.GetDateTime(14);

                    list.Add(entity);
                }
                rdr.Close();
            }
            userCount = Convert.ToInt32(parameters[3].Value);
            return list;
        }

        /// <summary>
        /// 从角色中删除用户
        /// </summary>
        /// <param name="roleId"></param>
        /// <param name="userIdString"></param>
        /// <param name="userName"></param>
        public void RemoveUsersFromRole(int roleId, string userIdString, string userName,string ConnStr="")
        {
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@RoleId", SqlDbType.Int), 
                new SqlParameter("@UserIdString", SqlDbType.VarChar, 100), 
                new SqlParameter("@Operator", SqlDbType.NVarChar, 20) };

            parameters[0].Value = roleId;
            parameters[1].Value = userIdString;
            parameters[2].Value = userName;

            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_UsersInRole_RemoveUsersFromRole", parameters);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_UsersInRole_RemoveUsersFromRole", parameters);
            }
        }

        /// <summary>
        /// 分配角色给用户
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="roleIdString"></param>
        public void AssignRolesToUser(int userId, string roleIdString, string ConnStr = "")
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@RoleIdString",SqlDbType.VarChar,200)
            };

            parms[0].Value = userId;
            parms[1].Value = roleIdString;

            if (!string.IsNullOrEmpty(ConnStr))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "SYS_UsersInRole_AssignRolesToUser", parms);
            }
            else
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_UsersInRole_AssignRolesToUser", parms);
            }
            
        }
    }
}
