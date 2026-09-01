using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.Common.DAL.Marshal;
using SKT.Common.Framework.Model;
using SKT.LeanMES.Kanban.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxFramework
    {
        /// <summary>
        /// 获取指定子系统的已被授权的模块
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="subSystemName">系统模块名称</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ModuleInfo> GetWarranttedModulesBySubSystem(int userId,string subSystemName)
        {
            List<ModuleInfo> list = new List<ModuleInfo>();
            ModuleInfo entity = new ModuleInfo();
            try
            {
                System.Data.SqlClient.SqlParameter[] parms = new System.Data.SqlClient.SqlParameter[]{
                    new System.Data.SqlClient.SqlParameter("@UserId",System.Data.SqlDbType.Int,4),
                    new System.Data.SqlClient.SqlParameter("@SubSystem",System.Data.SqlDbType.VarChar,100),
                };
                parms[0].Value = userId;
                parms[1].Value = subSystemName;
                
                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Framework_Modules_GetWarranttedModulesBySubSystem", parms))
                {
                    while (rdr.Read())
                    {
                        entity = new ModuleInfo();
                        entity.Name = Convert.ToString(rdr["Name"]);
                        entity.SubSystem = Convert.ToString(rdr["SubSystem"]);
                        entity.Icon = Convert.ToString(rdr["Icon"]);
                        entity.Sequence = Convert.ToInt32(rdr["Sequence"]);
                        entity.Popedom = Convert.ToInt32(rdr["Popedom"]);
                        entity.Flag = Convert.ToInt32(rdr["Flag"]);

                        list.Add(entity);
                    }
                    rdr.Close();
                }
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        /// <summary>
        /// 获取指定模块的已被授权的页面
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="moduleInfoName">系统模块名称</param>
        /// <param name="inMenu">系统模块名称</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PageInfo> GetWarranttedPagesByModule(int userId, string moduleInfoName,bool inMenu)
        {
            List<PageInfo> list = new List<PageInfo>();
            PageInfo entity = new PageInfo();
            try
            {
                System.Data.SqlClient.SqlParameter[] parms = new System.Data.SqlClient.SqlParameter[]{
                    new System.Data.SqlClient.SqlParameter("@UserId",System.Data.SqlDbType.Int,4),
                    new System.Data.SqlClient.SqlParameter("@Module",System.Data.SqlDbType.VarChar,100),
                    new System.Data.SqlClient.SqlParameter("@InMenu",System.Data.SqlDbType.Bit),
                };
                parms[0].Value = userId;
                parms[1].Value = moduleInfoName;
                parms[2].Value = inMenu; 
                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Framework_Pages_GetWarranttedPagesByModule", parms))
                {
                    while (rdr.Read())
                    {
                        entity = new PageInfo();
                        entity.Name = Convert.ToString(rdr["Name"]);
                        entity.Module = Convert.ToString(rdr["Module"]);
                        entity.Icon = Convert.ToString(rdr["Icon"]);
                        entity.Sequence = Convert.ToInt32(rdr["Sequence"]);
                        entity.Popedom = Convert.ToInt32(rdr["Popedom"]);
                        entity.Url = Convert.ToString(rdr["Url"]);
                        entity.Flag = Convert.ToInt32(rdr["Flag"]);
                        list.Add(entity);
                    }
                    rdr.Close();
                }
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }
    }
}