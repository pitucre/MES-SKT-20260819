/*
 * 修改时间： 2017-10-10
 * 修改人： Alen Liu 
 * 修改标识： Alen Liu 2017-10-10
 * 修改内容：
 *          1、增大权限分配时字段长度，修复在权限分配时如果权限过多导致字符截断的问题；
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using SKT.Common.Account.Model;
using SKT.Common.DAL.Marshal;

namespace SKT.Common.Account.BLL
{
    public class PopedomInRole
    {
        /// <summary>
        /// 分配权限给角色
        /// </summary>
        /// <param name="roleId"></param>
        /// <param name="popedomString"></param>
        public void AssignPopedomToRole(int roleId, string popedomString,string ConnStr = "")
        {
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@RoleId", SqlDbType.Int), 
                new SqlParameter("@Popedom", SqlDbType.VarChar, -1) };//Modify By Alen 2017-10-10 增大权限分配时字段长度，修复在权限分配时如果权限过多导致字符截断的问题。

            parameters[0].Value = roleId;
            parameters[1].Value = popedomString;
            SQLHelper.ExecuteNonQueryStoredProcedure(!string.IsNullOrEmpty(ConnStr)? ConnStr:SQLHelper.MESConnString, "SYS_PopedomInRole_AssignPopedomToRole", parameters);
        }

        /// <summary>
        /// 根据角色ID获取权限
        /// </summary>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public List<RoleInfo> GetPopedomByRoleId(int roleId, string ConnStr = "")
        {
            List<RoleInfo> list = new List<RoleInfo>();
            RoleInfo entity = null;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@RoleId", SqlDbType.Int) };

            parameters[0].Value = roleId;

            using (SqlDataReader reader = SQLHelper.ExecuteReaderStoredProcedure(!string.IsNullOrEmpty(ConnStr) ? ConnStr : SQLHelper.MESConnString, "SYS_PopedomInRole_GetPopedomByRoleId", parameters))
            {
                while (reader.Read())
                {
                    entity = new RoleInfo();
                    entity.RoleID = reader.GetInt32(0);
                    entity.Popedom = reader.GetInt32(1);
                    list.Add(entity);
                }
                reader.Close();
            }
            return list;
        }
    }
}
