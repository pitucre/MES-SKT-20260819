using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SMT.BLL
{
    public class TransferMaterial
    {
        #region SMT工单转料
               
        /// <summary>
        /// 获取工单转料原工单
        /// </summary>
        /// <returns></returns>
        public Dictionary<int, string> GetOrderList()
        {
            Dictionary<int, string> dic = new Dictionary<int, string>();

            string sql = @"SELECT LinePlanId,FBILLNO FROM dbo.Prod_LinePlan WHERE State IN(1,3)";
             
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, null))
            {
                while (rdr.Read())
                {
                    dic.Add(rdr.GetInt32(0), rdr.GetString(1));
                }
                rdr.Close();
            }
            return dic;
        }

        /// <summary>
        /// 获取工单转料原工单
        /// </summary>
        /// <returns></returns>
        public Dictionary<int, string> GetTOPOrderList(string where)
        {
            Dictionary<int, string> dic = new Dictionary<int, string>();

            string sql = @"SELECT TOP 20 LinePlanId,FBILLNO FROM dbo.Prod_LinePlan WHERE State IN(1,3) " + where;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, null))
            {
                while (rdr.Read())
                {
                    dic.Add(rdr.GetInt32(0), rdr.GetString(1));
                }
                rdr.Close();
            }
            return dic;
        }

        /// <summary>
        /// 获取工单转料目标工单
        /// </summary>
        /// <param name="linePlanId"></param>
        /// <returns></returns>
        public Dictionary<int, string> GetTargetOrderList(int linePlanId)
        {
            Dictionary<int, string> dic = new Dictionary<int, string>();
            
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@LinePlanId",SqlDbType.Int)
            };
            param[0].Value = linePlanId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetChangePlanOrderList", param))
            {
                while (rdr.Read())
                {
                    dic.Add(rdr.GetInt32(0), rdr.GetString(1));
                }
                rdr.Close();
            }
            return dic;
        }

        /// <summary>
        /// SMT排产工单转料
        /// </summary>
        /// <param name="linePlanId"></param>
        /// <param name="targetLinePlanId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        public void ChangeSMTMaterial(int linePlanId,int targetLinePlanId,int userId,string userName,bool isChangeMuMap)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@LinePlanId",SqlDbType.Int),
                new SqlParameter("@TargetLinePlanId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
                new SqlParameter("@IsChangeMuMap",SqlDbType.Bit)
            };
            param[0].Value = linePlanId;
            param[1].Value = targetLinePlanId;
            param[2].Value = userId;
            param[3].Value = userName;
            param[4].Value = isChangeMuMap;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspChangeSMTMaterial", param);
        }

        #endregion
    }
}
