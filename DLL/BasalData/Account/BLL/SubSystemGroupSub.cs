using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.Common.Framework.Model;
using SKT.Common.Model;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data;
using SKT.LeanMES.Report.Model;

namespace SKT.Common.Account.BLL
{
    public class SubSystemGroupSub
    {
        /// <summary>
        /// 获取子厂子系统信息
        /// </summary>
        public List<SubSystemInfo> GetAll(string ConnStr)
        {
            List<SubSystemInfo> list = new List<SubSystemInfo>();
            using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "Framework_SubSystems_GetAll", new SqlParameter[0]))
            {
                while (sqlDataReader.Read())
                {
                    list.Add(new SubSystemInfo(sqlDataReader.GetString(0), sqlDataReader.GetString(1), sqlDataReader.GetInt32(2), sqlDataReader.GetInt32(3), sqlDataReader.GetString(4), sqlDataReader.GetDateTime(5), sqlDataReader.GetString(6), sqlDataReader.GetDateTime(7), sqlDataReader.GetInt32(8)));
                }
                sqlDataReader.Close();
            }
            return list;
        }
        /// <summary>
        /// 获取子厂模块
        /// </summary>
        /// <param name="subSystem"></param>
        /// <returns></returns>
        public List<ModuleInfo> GetBySubSystem(string subSystem,string ConnStr)
        {
            List<ModuleInfo> list = new List<ModuleInfo>();
            SqlParameter[] array = new SqlParameter[]
            {
               new SqlParameter("@SubSystem", SqlDbType.VarChar, 100)
            };
            array[0].Value = subSystem;
            using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "Framework_Modules_GetBySubSystem", array))
            {
                while (sqlDataReader.Read())
                {
                    ModuleInfo item = new ModuleInfo
                    {
                        Name = sqlDataReader.GetString(0),
                        Icon = sqlDataReader.GetString(1),
                        Sequence = sqlDataReader.GetInt32(2),
                        Popedom = sqlDataReader.GetInt32(3),
                        Flag = sqlDataReader.GetInt32(4)
                    };
                    list.Add(item);
                }
                sqlDataReader.Close();
            }
            return list;
        }

        /// <summary>
        /// 子厂根据用户id,subSystem获取相关数据
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="subSystemName"></param>
        /// <param name="cultureType"></param>
        /// <returns></returns>
        public List<ReportInfo> GetModuleResources(int userId, string subSystemName, string cultureType, String ConnStr)
        {
            List<ReportInfo> list = new List<ReportInfo>();
            ReportInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@SubSystemName",SqlDbType.VarChar,100),
                new SqlParameter("@CultureType",SqlDbType.VarChar,20)
            };

            parms[0].Value = userId;
            parms[1].Value = subSystemName;
            parms[2].Value = cultureType;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "uspGetModuleResources", parms))
            {
                while (rdr.Read())
                {
                    entity = new ReportInfo();
                    entity.RTModuleName = rdr.GetString(0);
                    entity.RTModuleCNValue = rdr.GetString(1);
                    entity.RTResourcesType = rdr.GetInt32(2);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
    }
}
