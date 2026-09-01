using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Kanban.BLL;
using SKT.LeanMES.Kanban.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for DjProductionKanbanData
    /// </summary>
    public class EnergyMonitoringKanBanData : IHttpHandler, IRequiresSessionState
    {
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            context.Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            context.Response.ContentType = "text/plain";
            string orderno = string.Empty;
            string jsonStr = string.Empty;
            string WhCode = string.Empty;
            var api = context.Request["api"];
            switch (api)
            {
                case "DjListData":
                    //预警记录列表
                    GetDjProductionPlanListData(context);
                    break;
                case "GetTemplateData1":
                    //获取第一个模块数据
                    GetTemplateData1(context);
                    break;
                case "GetTemplateData2":
                    //获取第二个模块数据
                    GetTemplateData2(context);
                    break;
                case "GetTemplateData3":
                    //获取第三个模块数据
                    GetTemplateData3(context);
                    break;
                case "GetTemplateData4":
                    //获取第四个模块数据
                    GetTemplateData4(context);
                    break;
                case "GetTemplateData5":
                    //获取第五个模块数据
                    GetTemplateData5(context);
                    break;
                case "GetTemplateData6":
                    //获取第六个模块数据
                    GetTemplateData6(context);
                    break;
                case "GetTemplateData7":
                    //获取第七个模块数据
                    GetTemplateData7(context);
                    break;
                case "GetEnergyTableData":
                    //获取第七个模块数据
                    GetEnergyTableData(context);
                    break;
                case "GetTemplateData8":
                    //获取第八个模块数据
                    GetTemplateData8(context);
                    break;
            }
            context.Response.Flush();
            context.Response.End();
        }
        public void GetTemplateData8(HttpContext context)
        {
            DataSet ds = new DataSet();

            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspGetEnergyMonitoringTemplateData8";

                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                sqlcon.Close();
                sqlcon.Dispose();
            }
            ProductionDataInfo result = new ProductionDataInfo();
            List<string> xAxis = new List<string>();
            List<string> listOutput = new List<string>();
            List<string> listDesigned = new List<string>();
            List<List<string>> series = new List<List<string>>();
            DataTable dt = ds.Tables[0];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                xAxis.Add(dt.Rows[i][0].ToString());
                listDesigned.Add(dt.Rows[i][1].ToString());
                listOutput.Add(dt.Rows[i][2].ToString());
            }

            series.Add(listDesigned);
            series.Add(listOutput);
            result.Echarts = new KanBanChartInfo();
            result.Echarts.Axis = xAxis;
            result.Echarts.Series = series;
            string jsonStr = JsonConvert.SerializeObject(result);
            context.Response.Write(jsonStr);
        }
        public void GetEnergyTableData(HttpContext context)
        {
            List<DjEnergyTableInfo> list = new List<DjEnergyTableInfo>();
            DjEnergyTableInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEnergyMonitoringKanBanTableData"))
            {
                while (rdr.Read())
                {
                    entity = new DjEnergyTableInfo();
                    entity.NowEnergy = rdr["NowEnergy"].ToString();
                    entity.NowCurrentIA = rdr["NowCurrentIA"].ToString();
                    entity.NowCurrentIB = rdr["NowCurrentIB"].ToString();
                    entity.NowCurrentIC = rdr["NowCurrentIC"].ToString();
                    entity.NowVoltageUA = rdr["NowVoltageUA"].ToString();
                    entity.NowVoltageUB = rdr["NowVoltageUB"].ToString();
                    entity.NowVoltageUC = rdr["NowVoltageUC"].ToString();
                    entity.NowAllNH = rdr["NowAllNH"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string result = JsonConvert.SerializeObject(list);
            context.Response.Write(result);
        }

        public void GetTemplateData1(HttpContext context)
        {
            List<DjProductionAnormalCountInfo> list = new List<DjProductionAnormalCountInfo>();
            DjProductionAnormalCountInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEnergyMonitoringTemplateData1"))
            {
                while (rdr.Read())
                {
                    entity = new DjProductionAnormalCountInfo();
                    entity.TimeName = rdr["TimeName"].ToString();
                    entity.TimeCount = rdr["TimeCount"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string result = JsonConvert.SerializeObject(list);
            context.Response.Write(result);
        }

        public void GetTemplateData2(HttpContext context)
        {
            List<DjProductionAnormalCountInfo> list = new List<DjProductionAnormalCountInfo>();
            DjProductionAnormalCountInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEnergyMonitoringTemplateData2"))
            {
                while (rdr.Read())
                {
                    entity = new DjProductionAnormalCountInfo();
                    entity.TimeName = rdr["TimeName"].ToString();
                    entity.TimeCount = rdr["TimeCount"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string result = JsonConvert.SerializeObject(list);
            context.Response.Write(result);
        }

        public void GetTemplateData3(HttpContext context)
        {
            List<DjProductionAnormalCountInfo> list = new List<DjProductionAnormalCountInfo>();
            DjProductionAnormalCountInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEnergyMonitoringTemplateData3"))
            {
                while (rdr.Read())
                {
                    entity = new DjProductionAnormalCountInfo();
                    entity.TimeName = rdr["TimeName"].ToString();
                    entity.TimeCount = rdr["TimeCount"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string result = JsonConvert.SerializeObject(list);
            context.Response.Write(result);
        }

        public void GetTemplateData4(HttpContext context)
        {
            List<DjProductionAnormalCountInfo> list = new List<DjProductionAnormalCountInfo>();
            DjProductionAnormalCountInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEnergyMonitoringTemplateData4"))
            {
                while (rdr.Read())
                {
                    entity = new DjProductionAnormalCountInfo();
                    entity.TimeName = rdr["TimeName"].ToString();
                    entity.TimeCount = rdr["TimeCount"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string result = JsonConvert.SerializeObject(list);
            context.Response.Write(result);
        }

        public void GetTemplateData5(HttpContext context)
        {
            List<DjProductionAnormalCountInfo> list = new List<DjProductionAnormalCountInfo>();
            DjProductionAnormalCountInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEnergyMonitoringTemplateData5"))
            {
                while (rdr.Read())
                {
                    entity = new DjProductionAnormalCountInfo();
                    entity.TimeName = rdr["TimeName"].ToString();
                    entity.TimeCount = rdr["TimeCount"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string result = JsonConvert.SerializeObject(list);
            context.Response.Write(result);
        }

        public void GetTemplateData6(HttpContext context)
        {
            List<DjProductionAnormalCountInfo> list = new List<DjProductionAnormalCountInfo>();
            DjProductionAnormalCountInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEnergyMonitoringTemplateData6"))
            {
                while (rdr.Read())
                {
                    entity = new DjProductionAnormalCountInfo();
                    entity.TimeName = rdr["TimeName"].ToString();
                    entity.TimeCount = rdr["TimeCount"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string result = JsonConvert.SerializeObject(list);
            context.Response.Write(result);
        }

        public void GetTemplateData7(HttpContext context)
        {
            List<DjProductionAnormalCountInfo> list = new List<DjProductionAnormalCountInfo>();
            DjProductionAnormalCountInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEnergyMonitoringTemplateData7"))
            {
                while (rdr.Read())
                {
                    entity = new DjProductionAnormalCountInfo();
                    entity.TimeName = rdr["TimeName"].ToString();
                    entity.TimeCount = rdr["TimeCount"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string result = JsonConvert.SerializeObject(list);
            context.Response.Write(result);
        }

        //生产计划列表
        public void GetDjProductionPlanListData(HttpContext context)
        {
            List<DjProductionQualityInfo> list = new List<DjProductionQualityInfo>();
            DjProductionQualityInfo2 result = null;
            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspGetEnergyMonitoringKanBanListData";

                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                if (ds != null)
                {
                    result = new DjProductionQualityInfo2();
                    result.List = new List<DjProductionQualityInfo>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        result.List.Add(new DjProductionQualityInfo()
                        {
                            TimeName = DisStr(row["TimeName"]),
                            EqumentName = DisStr(row["EqumentName"]),
                            MissgeData = DisStr(row["MissgeData"])
                        });
                    }
                }
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(result);
            context.Response.Write(jsonStr);
        }


        //仪表盘数据实体
        internal class DjProductionGaugeInfo
        {
            public decimal outFirstRate { get; set; }
            public decimal outOEERate { get; set; }
            public decimal outAchievedRate { get; set; }
        }

        //通用实体
        internal class DjProductionCommonInfo
        {
            public string Name { get; set; }
            public string Qty { get; set; }
        }

        //OEE综合分布
        public void GetOEEDistribute(HttpContext context)
        {
            List<DjProductionCommonInfo> list = new List<DjProductionCommonInfo>();
            DjProductionCommonInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetDjProductionOEEDistribute"))
            {
                while (rdr.Read())
                {
                    entity = new DjProductionCommonInfo();
                    entity.Name = rdr["Name"].ToString();
                    entity.Qty = rdr["Qty"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string result = JsonConvert.SerializeObject(list);
            context.Response.Write(result);
        }

        //安灯异常信息
        public void GetSafeLightAbnormal(HttpContext context)
        {
            List<DjProductionCommonInfo> list = new List<DjProductionCommonInfo>();
            DjProductionCommonInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetDjProductionSafeLightAbnormal"))
            {
                while (rdr.Read())
                {
                    entity = new DjProductionCommonInfo();
                    entity.Name = rdr["Name"].ToString();
                    entity.Qty = rdr["Qty"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string result = JsonConvert.SerializeObject(list);
            context.Response.Write(result);
        }
        int DisInt(object obj)
        {
            if (obj == null)
                return 0;
            try
            {
                return Convert.ToInt32(obj);
            }
            catch
            {
                return 0;
            }
        }
        string DisStr(object obj)
        {
            if (obj == null)
                return "-";
            return obj.ToString();
        }

        internal class DjEnergyTableInfo
        {
            public string NowEnergy { get; set; }
            public string NowCurrentIA { get; set; }
            public string NowCurrentIB { get; set; }
            public string NowCurrentIC { get; set; }
            public string NowVoltageUA { get; set; }
            public string NowVoltageUB { get; set; }
            public string NowVoltageUC { get; set; }
            public string NowAllNH { get; set; }
        }


        //品质看板列表实体
        internal class DjProductionQualityInfo
        {
            public string TimeName { get; set; }
            public string EqumentName { get; set; }
            public string MissgeData { get; set; }
        }
        internal class DjProductionQualityInfo2
        {
            public string AuditUser { get; set; }
            public string AuditResult { get; set; }
            public string NewDOPOKRate { get; set; }
            public string NGCount { get; set; }
            public string AnormalCount { get; set; }
            public string NGRemark { get; set; }
            public List<DjProductionQualityInfo> List { get; set; }
        }

        //周度一次合格率实体
        internal class DjProductionAnormalCountInfo
        {
            public string TimeName { get; set; }
            public string TimeCount { get; set; }
        }





    }
}