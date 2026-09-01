using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.SPC.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.SPC.BLL
{
    public class SPCGraph
    {
        /// <summary>
        /// 获取任务、项目信息
        /// </summary>
        /// <param name="spcTaskId"></param>
        /// <returns></returns>
        public SPCGraphInfo GetGraphInfo(int spcTaskId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SPCTaskId", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = spcTaskId;

            return ComMethod.Get<SPCGraphInfo>("uspGetSPCTaskInfo", parms);
        }

        /// <summary>
        /// 返回XbarR图表数据
        /// </summary>
        /// <param name="spcTaskId"></param>
        /// <returns></returns>
        public string[] GetXbarRGraphData(int spcTaskId, int spliceQty)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SPCTaskId", SqlDbType.Int),
                new SqlParameter("@SpliceQty", SqlDbType.Int)
            };
            StringBuilder strBulider = new StringBuilder();
            StringBuilder strDate = new StringBuilder();

            parms[0].Value = spcTaskId;
            parms[1].Value = spliceQty;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetXBarRGraphData", parms))
            {
                while (rdr.Read())
                {
                    strBulider.Append(rdr.GetDecimal(0).ToString());
                    strBulider.Append(",");

                    strDate.Append(Convert.ToDateTime(rdr["CollectionTime"]).ToString("yyyy-MM-dd HH:mm:ss")).Append(",");
                }
            }
            string graphData = strBulider.ToString();
            string date = strDate.ToString();
            if (graphData != "")
            {
                graphData = graphData.Substring(0, graphData.Length - 1);
                date = date.TrimEnd(',');
            }

            List<string> list = new List<string>() { graphData, date };

            return list.ToArray();
        }

        /// <summary>
        /// 执行XbarR控制图预警
        /// </summary>
        /// <param name="spcTaskId">任务ID</param>
        /// <param name="spcWarnMsg">预警消息</param>
        /// <param name="warnProc">预警执行存储过程</param>
        public void XbarRGraphWarn(int spcTaskId, string spcWarnMsg, string warnProc,string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SPCTaskId", SqlDbType.Int),
                new SqlParameter("@SPCWarnMsg", SqlDbType.VarChar),
                new SqlParameter("@UserName", SqlDbType.VarChar)   
            };
           
            parms[0].Value = spcTaskId;
            parms[1].Value = spcWarnMsg;
            parms[2].Value = userName;

            ComMethod.Edit(warnProc, parms);
        }

        /// <summary>
        /// 获取PChart数据源
        /// </summary>
        /// <param name="spcTaskId"></param>
        /// <returns></returns>
        public List<SPCPChartInfo> GetNPChartGraphData(int spcTaskId)
        {
            List<SPCPChartInfo> list = new List<SPCPChartInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SPCTaskId", SqlDbType.Int)                 
            };

            parms[0].Value = spcTaskId;

            list = ComMethod.GetList<SPCPChartInfo>("uspGetNPChartGraphData", parms);

            return list;
        }

        /// <summary>
        /// 获取PChart数据源
        /// </summary>
        /// <param name="spcTaskId"></param>
        /// <returns></returns>
        public List<SPCPChartInfo> GetCChartGraphData(int spcTaskId,int isFirstQuery,string queryTime)
        {
            List<SPCPChartInfo> list = new List<SPCPChartInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SPCTaskId", SqlDbType.Int),
                new SqlParameter("@IsFirstQuery", SqlDbType.Int),
                new SqlParameter("@QueryTime", SqlDbType.VarChar),
            };

            parms[0].Value = spcTaskId;
            parms[0].Value = isFirstQuery;
            parms[0].Value = queryTime;

            list = ComMethod.GetList<SPCPChartInfo>("uspGetNPChartGraphData_New", parms);

            return list;
        }

        /// <summary>
        /// 获取UChart数据源
        /// </summary>
        /// <param name="spcTaskId"></param>
        /// <returns></returns>
        public List<SPCPChartInfo> GetUChartGraphData(int spcTaskId)
        {
            List<SPCPChartInfo> list = new List<SPCPChartInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SPCTaskId", SqlDbType.Int)                 
            };

            parms[0].Value = spcTaskId;

            list = ComMethod.GetList<SPCPChartInfo>("uspGetUChartGraphData", parms);

            return list;
        }
    }
}
