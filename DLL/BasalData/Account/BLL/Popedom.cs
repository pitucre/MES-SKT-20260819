using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.Account.Model;
using SKT.Common.DAL.Marshal;

namespace SKT.Common.Account.BLL
{
    public class Popedom
    {
        /// <summary>
        /// 根据权限组获取权限
        /// </summary>
        /// <param name="popedomGroup"></param>
        /// <param name="isSupper"></param>
        /// <returns></returns>
        public List<PopedomInfo> GetByPopedomGroup(int popedomGroup, bool isSupper, String ConnStr="")
        {
            List<PopedomInfo> list = new List<PopedomInfo>();
            PopedomInfo item = null;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@PopedomGroup", SqlDbType.Int), 
                new SqlParameter("@IsSupper", SqlDbType.Bit) };

            parameters[0].Value = popedomGroup;
            parameters[1].Value = isSupper;
            using (SqlDataReader reader = SQLHelper.ExecuteReaderStoredProcedure(!string.IsNullOrEmpty(ConnStr)? ConnStr:SQLHelper.MESConnString, "SYS_Popedom_GetByPopedomGroup", parameters))
            {
                while (reader.Read())
                {
                    item = new PopedomInfo();
                    item.Popedom = reader.GetInt32(0);
                    item.Name = reader.GetString(1);
                    item.Description = reader.GetString(2);
                    item.Flag = reader.GetInt32(3);
                    list.Add(item);
                }
                reader.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据用户ID和权限组获取权限
        /// </summary>
        /// <param name="popedomGroup"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public List<PopedomInfo> GetByPopedomGroupAndUserId(int popedomGroup, int userId)
        {
            List<PopedomInfo> list = new List<PopedomInfo>();
            PopedomInfo entity = null;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@PopedomGroup", SqlDbType.Int), 
                new SqlParameter("@UserId", SqlDbType.Int) };

            parameters[0].Value = popedomGroup;
            parameters[1].Value = userId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Popedom_GetByPopedomGroupAndUserId", parameters))
            {
                while (rdr.Read())
                {
                    entity = new PopedomInfo();
                    entity.Popedom = rdr.GetInt32(0);
                    entity.Name = rdr.GetString(1);
                    entity.Description = rdr.GetString(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据用户ID获取权限
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public List<PopedomInfo> GetPopedomByUserId(int userId)
        {
            List<PopedomInfo> list = new List<PopedomInfo>();
            PopedomInfo entity = null;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@UserId", SqlDbType.Int) };

            parameters[0].Value = userId;
            using (SqlDataReader reader = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Popedom_GetPopedomByUserId", parameters))
            {
                while (reader.Read())
                {
                    entity = new PopedomInfo();
                    entity.Popedom = reader.GetInt32(0);
                    entity.Name = reader.GetString(1);
                    entity.Description = reader.GetString(2);
                    entity.IsSupper = reader.GetBoolean(3);
                    entity.SubSystemName = reader.GetString(4);
                    entity.ModuleName = reader.GetString(5);
                    list.Add(entity);
                }
                reader.Close();
            }
            return list;
        }
    }
}
