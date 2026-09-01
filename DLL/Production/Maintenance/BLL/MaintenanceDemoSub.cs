using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Maintenance.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Maintenance.BLL
{
    public class MaintenanceDemoSub
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaintenanceDemoSub 信息。
        /// </summary>
        /// <param name="entity">MaintenanceDemoSub 实体对象。</param>
        public Int32 Edit(MaintenanceDemoSubInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DemoSubId", SqlDbType.Int),
                new SqlParameter("@DemoId", SqlDbType.Int),
                new SqlParameter("@DemoSubCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@DemoSubName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200)
            };

            parms[0].Value = entity.DemoSubId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.DemoId;
            parms[2].Value = entity.DemoSubCode;
            parms[3].Value = entity.DemoSubName;
            parms[4].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceDemoSub_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MaintenanceDemoSubId 字符串删除 MaintenanceDemoSub 信息。
        /// </summary>
        /// <param name="idString">MaintenanceDemoSubId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceDemoSub_Delete", parms);
        }

        /// <summary>
        /// 根据 MaintenanceDemoSubId 获取实体信息。
        /// </summary>
        /// <param name="maintenanceDemoSubId">MaintenanceDemoSubId。</param>
        /// <returns>MaintenanceDemoSub 实体对象。</returns>
        public List<MaintenanceDemoSubInfo> GetInfo(Int32 demoId)
        {
            List<MaintenanceDemoSubInfo> list = new List<MaintenanceDemoSubInfo>();
            MaintenanceDemoSubInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DemoId", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = demoId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetDemoSubList", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaintenanceDemoSubInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4));
                    entity.SaveFileName = rdr["SaveFileName"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}