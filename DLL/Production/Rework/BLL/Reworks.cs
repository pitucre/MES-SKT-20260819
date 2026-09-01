using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Data;
using System.Data.SqlClient;

namespace SKT.LeanMES.Rework.BLL
{
    public class Reworks
    {
        /// <summary>
        /// 生产中的返工
        /// </summary>
        /// <param name="prodId">工单Id</param>
        /// <param name="opeId">返回的工位Id</param>
        /// <param name="sn">主机号</param>
        /// <param name="userId">用户</param>
        /// <param name="tag">1 工单整批返工 2 主机返工</param>
        public string[] InProductionRework(int prodId, int opeId, string sn, int userId, int tag,int isUnAss)
        {
            string[] arr = new string[5];

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ProdId", SqlDbType.Int),
                new SqlParameter("@OpeId", SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@Tag",SqlDbType.Int),
                new SqlParameter("@IsUnAss",SqlDbType.Bit)
            };

            parms[0].Value = prodId;
            parms[1].Value = opeId;
            parms[2].Value = sn;
            parms[3].Value = userId;
            parms[4].Value = tag;
            parms[5].Value = isUnAss;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspBatchRework", parms))
            {
                if (tag == 2)
                {
                    if (rdr.HasRows)
                    {
                        rdr.Read();

                        arr[0] = rdr.GetString(0);
                        arr[1] = rdr.GetString(1);
                        arr[2] = rdr.GetString(2);
                        arr[3] = rdr.GetString(3);
                        arr[4] = rdr.GetDateTime(4).ToString();
                    }
                }

                rdr.Close();
            }

            return arr;
        }


        /// <summary>
        /// 成品返工
        /// </summary>
        /// <param name="prodId">工单Id</param>
        /// <param name="reProdId">返工工单Id</param>
        /// <param name="sn">主机号</param>
        /// <param name="userId">用户</param>
        /// <param name="tag">1 工单整批返工 2 主机返工</param>
        public string[] FinishedProductRework(int prodId, int reProdId, string sn, int userId, int tag)
        {
            string[] arr = new string[4];

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ProdId", SqlDbType.Int),
                new SqlParameter("@ReProdId", SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.NVarChar,60),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@Tag",SqlDbType.Int)
            };

            parms[0].Value = prodId;
            parms[1].Value = reProdId;
            parms[2].Value = sn;
            parms[3].Value = userId;
            parms[4].Value = tag;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspFinishedProductRework", parms))
            {
                if (tag == 2)
                {
                    if (rdr.HasRows)
                    {
                        rdr.Read();

                        arr[0] = rdr.GetString(0);
                        arr[1] = rdr.GetString(1);
                        arr[2] = rdr.GetString(2);
                        arr[3] = rdr.GetDateTime(3).ToString();
                    }
                }

                rdr.Close();
            }

            return arr;
        }
    }
}
