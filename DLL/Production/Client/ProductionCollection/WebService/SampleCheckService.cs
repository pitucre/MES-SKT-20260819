using SKT.Common.DAL.Marshal;
using SKT.LeanMES.ProductionCollection.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.WebService
{
    public class SampleCheckService
    {
        /// <summary>
        /// 样机测试接口
        /// </summary>
        /// <param name="msg"></param>
        /// <returns></returns>
        public string SampleCheckTest(string orderNumber, string sampleNumber, string station, string employeeCode, string resourceName, int isPass, string ncDescribes)
        {
            string msg = "";
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                    new SqlParameter("@orderNumber",SqlDbType.VarChar,200),
                    new SqlParameter("@sampleNumber",SqlDbType.VarChar,200),
                    new SqlParameter("@station",SqlDbType.VarChar,200),
                    new SqlParameter("@employeeCode",SqlDbType.VarChar,200),
                    new SqlParameter("@resourceName",SqlDbType.VarChar,200),
                    new SqlParameter("@IsPass",SqlDbType.Int),
                    new SqlParameter("@NCDescribes",SqlDbType.NVarChar,-1),
                    new SqlParameter("@Msg",SqlDbType.NVarChar,2000)
                };
                LaserCarvingOrderInfo entity = new LaserCarvingOrderInfo();
                param[0].Value = orderNumber;
                param[1].Value = sampleNumber;
                param[2].Value = station;
                param[3].Value = employeeCode;
                param[4].Value = resourceName;
                param[5].Value = isPass;
                param[6].Value = ncDescribes;
                param[7].Value = "";
                param[7].Direction = ParameterDirection.InputOutput;

                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSampleCheckTest", param))
                {
                    msg = param[7].Value.ToString();
                }
                return msg;
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
                return msg;
            }
        }
    }
}
