using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;
using Newtonsoft.Json;
using NPOI.HPSF;
using SKT.LeanMES.Order.BLL;
using SKT.LeanMES.Order.Model;
using SKT.LeanMES.Plan.BLL;
using SKT.LeanMES.Plan.Model;
using SKT.LeanMES.Resource.Model;
using SKT.LeanMES.Web.AppCode.Utility;

//using MSProject = Microsoft.Office.Interop.MSProject;


namespace SKT.LeanMES.Web.Handler
{
    /// <summary>  
    /// GANT_MSTServer 的摘要说明  
    /// </summary>  
    public class GANT_MSTServer : IHttpHandler, IRequiresSessionState
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

            context.Response.ContentType = "application/json";
            string action = context.Request["action"];

            switch (action)
            {

                case "GetProjectOrder"://查询数据 工单维度甘特图
                    GetProjectOrderNo(context);
                    break;
                case "GetProjectOrderExcel"://查询数据 工单维度甘特图
                    GetProjectOrderNoExcel(context);
                    break;
                case "GetProjectLine"://查询数据  线别维度甘特图
                    GetProjectLine(context);
                    break;

                case "GetProjectLineExcel"://查询数据  线别维度甘特图
                    GetProjectLineExcel(context);
                    break;
                case "GetProjectOrder2"://查询数据 旧方法  
                    GetProjectOrderNo2(context);
                    break;
                //case "GetProjectResource":
                //    GetProjectReource(context);
                //    break;

                //case "GetGanttData"://查询数据  
                //    GetGanttData(context);
                //    break;

                //case "ExportMpp"://导出MSProject  
                //    ExportMpp(context);
                //    break;

                //case "ExportMppExt"://导出MSProject  
                //    ExportMppExt(context);
                //    break;

                //case "DownloadMpp"://下载MSProject  
                //    DownloadMpp(context);
                //    break;

                default:
                    {
                        var result = "{\"error\":发生错误}";
                        context.Response.Write(result);
                    }
                    break;
            }
        }




        #region 取得工单甘特图数  
        private void GetProjectOrderNo(HttpContext context)
        {
            ProjectData projectData = new ProjectData();
            string orderNo = context.Request["orderNo"] != "" ? context.Request["orderNo"] : "";
            int orderId = context.Request["orderId"] != "-1" ? Convert.ToInt32(context.Request["orderId"]) : -1;
            string startDate = context.Request["startDate"] != "" ? context.Request["startDate"] : DateTime.Now.ToString("yyyy-MM-dd");
            string endDate = context.Request["endDate"] != "" ? context.Request["endDate"] : DateTime.Now.AddDays(30).ToString("yyyy-MM-dd");
            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.MESConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspGetOrderGanttData";

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@ProdOrderId",
                    SqlDbType = SqlDbType.Int,
                    Value = orderId
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@OrderNo",
                    SqlDbType = SqlDbType.VarChar,
                    Value = orderNo
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@StartDate",
                    SqlDbType = SqlDbType.DateTime,
                    Value = startDate
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@EndDate",
                    SqlDbType = SqlDbType.DateTime,
                    Value = endDate
                });
                
                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                List<Object> list = new List<object>();
                int level = 0;
                TaskData taskData;

                if (ds != null && ds.Tables.Count == 1)
                {

                    foreach (DataRow r in ds.Tables[0].Rows)
                    {
                        level = Convert.ToInt32(r["level"]);
                        taskData = new TaskData();
                        taskData.id = -1 * Convert.ToInt32(r["Id"]);
                        taskData.name = Convert.ToString(r["OrderNo"]);
                        taskData.progress = Convert.ToInt32(r["Progress"]);
                        taskData.progressByWorklog = false;
                        taskData.relevance = 0;
                        taskData.type = "";
                        taskData.typeId = "";
                        taskData.description = Convert.ToString(r["Qty_to_Build"]);
                        taskData.code = Convert.ToString(r["LineName"]);
                        taskData.level = level;

                        switch (Convert.ToInt32(r["Status"]))
                        {
                            case 1:
                                taskData.status = "STATUS_ACTIVE";
                                break;
                            case 2:
                                taskData.status = "STATUS_SUSPENDED";
                                break;
                            case 3:
                                taskData.status = "STATUS_DONE";
                                break;
                            default:
                                taskData.status = "STATUS_UNDEFINED";
                                break;
                        }

                        taskData.depends = "";
                        taskData.statusdesc = Convert.ToString(r["StatusDesc"]);
                        taskData.canWrite = level == 0 ? true : false; ;
                        taskData.start = ToMillisecondDate(Convert.ToDateTime(r["StartDate"]));
                        taskData.duration = 0;
                        taskData.end = ToMillisecondDate(Convert.ToDateTime(r["EndDate"]));
                        taskData.startIsMilestone = false;
                        taskData.endIsMilestone = false;
                        taskData.collapsed = false;
                        taskData.assigs = list;
                        taskData.hasChild = level == 0 ? true : false;
                        taskData.startTime = Convert.ToString(r["StartDate"]);
                        taskData.endTime = Convert.ToString(r["EndDate"]);
                        projectData.tasks.Add(taskData);
                    }
                }

            }


            string ret = "";
            string jsonStr = JsonConvert.SerializeObject(projectData);
            ret = GetObjectToJSONResult("ok", jsonStr);
            context.Response.Write(ret);
        }

        private void GetProjectOrderNoExcel(HttpContext context)
        {

            string orderNo = context.Request["orderNo"] != "" ? context.Request["orderNo"] : "";
            int orderId = context.Request["orderId"] != "-1" ? Convert.ToInt32(context.Request["orderId"]) : -1;
            string startDate = context.Request["startDate"] != "" ? context.Request["startDate"] : DateTime.Now.ToString("yyyy-MM-dd");
            string endDate = context.Request["endDate"] != "" ? context.Request["endDate"] : DateTime.Now.AddDays(30).ToString("yyyy-MM-dd");

            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.MESConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspGetOrderGanttDataExcel";

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@ProdOrderId",
                    SqlDbType = SqlDbType.Int,
                    Value = orderId
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@OrderNo",
                    SqlDbType = SqlDbType.VarChar,
                    Value = orderNo
                });

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@StartDate",
                    SqlDbType = SqlDbType.DateTime,
                    Value = startDate
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@EndDate",
                    SqlDbType = SqlDbType.DateTime,
                    Value = endDate
                });

                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                if (ds != null && ds.Tables.Count == 1)
                {

                    DataTable table = ds.Tables[0];
                    var r = new Random();
                    var rf = "";
                    for (var j = 0; j < 10; j++)
                    {
                        rf = r.Next(int.MaxValue).ToString();
                    }


                    context.Response.Clear();
                    context.Response.ContentType = "text/csv";
                    context.Response.ContentEncoding = Encoding.UTF8;   
                    context.Response.AppendHeader("Content-Disposition",
                        "attachment; filename=" + HttpUtility.UrlEncode("工单排产计划图") + DateTime.Now.ToString("yyyyMMddhhmmss") + ".xls");
                    context.Response.HeaderEncoding = Encoding.UTF8;
                    context.Response.BinaryWrite(Encoding.UTF8.GetPreamble());

                  
                    foreach (DataColumn column in table.Columns)
                    {
                        context.Response.Write(column.ColumnName + ",");
                        //context.Response.Write(column.ColumnName + "(" + column.DataType + "),");   
                    }

                    context.Response.Write(Environment.NewLine);
                    double test; DateTime dtTest;

                    foreach (DataRow row in table.Rows)
                    {
                        for (var i = 0; i < table.Columns.Count; i++)
                        {

                            if (double.TryParse(row[i].ToString(), out test))
                            {
                                context.Response.Write("=");
                                context.Response.Write("\"" + row[i].ToString() + "\",");
                            }
                            else if (DateTime.TryParse(row[i].ToString(), out dtTest))
                            {
                                //context.Response.Write("\"" + Convert.ToDateTime(row[i]).ToString("yyyy-MM-dd") + "\",");
                                context.Response.Write("=\"" + row[i].ToString() + "\",");
                            }
                            else
                            {
                                context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                            }
                        }
                        context.Response.Write(Environment.NewLine);
                    }

                    context.Response.End();
                    context.Response.Write(context.Response.OutputStream);


                }

            }



        }



        private void GetProjectLine(HttpContext context)
        {
            ProjectData projectData = new ProjectData();
            string name = context.Request["name"] != "" ? context.Request["name"] : "";
            int type = context.Request["type"] != "-1" ? Convert.ToInt32(context.Request["type"]) : 1;
            string startDate = context.Request["startDate"] != "" ? context.Request["startDate"] : DateTime.Now.ToString("yyyy-MM-dd");
            string endDate = context.Request["endDate"] != "" ? context.Request["endDate"] : DateTime.Now.AddDays(30).ToString("yyyy-MM-dd");

            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.MESConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspGetLineGanttData";

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Type",
                    SqlDbType = SqlDbType.Int,
                    Value = type
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Name",
                    SqlDbType = SqlDbType.VarChar,
                    Value = name
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@StartDate",
                    SqlDbType = SqlDbType.DateTime,
                    Value = startDate
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@EndDate",
                    SqlDbType = SqlDbType.DateTime,
                    Value = endDate
                });
                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                List<Object> list = new List<object>();
                int level = 0;
                TaskData taskData;

                if (ds != null && ds.Tables.Count == 1)
                {

                    foreach (DataRow r in ds.Tables[0].Rows)
                    {
                        level = Convert.ToInt32(r["level"]);
                        taskData = new TaskData();
                        taskData.id = -1 * Convert.ToInt32(r["Id"]);
                        taskData.name = Convert.ToString(r["LineName"]);
                        taskData.progress = Convert.ToInt32(r["Progress"]);
                        taskData.progressByWorklog = false;
                        taskData.relevance = 0;
                        taskData.type = "";
                        taskData.typeId = "";
                        taskData.description = Convert.ToString(r["Qty_to_Build"]);
                        taskData.code = Convert.ToString(r["OrderNo"]);
                        taskData.level = level;

                        switch (Convert.ToInt32(r["Status"]))
                        {
                            case 1:
                                taskData.status = "STATUS_ACTIVE";
                                break;
                            case 2:
                                taskData.status = "STATUS_SUSPENDED";
                                break;
                            case 3:
                                taskData.status = "STATUS_DONE";
                                break;
                            default:
                                taskData.status = "STATUS_UNDEFINED";
                                break;
                        }

                        taskData.depends = "";
                        taskData.statusdesc = Convert.ToString(r["StatusDesc"]);
                        taskData.canWrite = level == 0 ? true : false; ;
                        taskData.start = ToMillisecondDate(Convert.ToDateTime(r["StartDate"]));
                        taskData.duration = 0;
                        taskData.end = ToMillisecondDate(Convert.ToDateTime(r["EndDate"]));
                        taskData.startIsMilestone = false;
                        taskData.endIsMilestone = false;
                        taskData.collapsed = false;
                        taskData.assigs = list;
                        taskData.hasChild = level == 0 ? true : false;
                        taskData.startTime = Convert.ToString(r["StartDate"]);
                        taskData.endTime = Convert.ToString(r["EndDate"]);
                        projectData.tasks.Add(taskData);
                    }
                }
            }
            string ret = "";
            string jsonStr = JsonConvert.SerializeObject(projectData);
            ret = GetObjectToJSONResult("ok", jsonStr);
            context.Response.Write(ret);
        }

        private void GetProjectLineExcel(HttpContext context)
        {

            string name = context.Request["name"] != "" ? context.Request["name"] : "";
            int type = context.Request["type"] != "-1" ? Convert.ToInt32(context.Request["type"]) : 1;
            string startDate = context.Request["startDate"] != "" ? context.Request["startDate"] : DateTime.Now.ToString("yyyy-MM-dd");
            string endDate = context.Request["endDate"] != "" ? context.Request["endDate"] : DateTime.Now.AddDays(30).ToString("yyyy-MM-dd");


            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.MESConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspGetLineGanttDataExcel";

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Type",
                    SqlDbType = SqlDbType.Int,
                    Value = type
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Name",
                    SqlDbType = SqlDbType.VarChar,
                    Value = name
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@StartDate",
                    SqlDbType = SqlDbType.DateTime,
                    Value = startDate
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@EndDate",
                    SqlDbType = SqlDbType.DateTime,
                    Value = endDate
                });
                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                if (ds != null && ds.Tables.Count == 1)
                {

                    DataTable table = ds.Tables[0];
                    var r = new Random();
                    var rf = "";
                    for (var j = 0; j < 10; j++)
                    {
                        rf = r.Next(int.MaxValue).ToString();
                    }


                    context.Response.Clear();
                    context.Response.ContentType = "text/csv";
                    context.Response.ContentEncoding = Encoding.UTF8;
                    context.Response.AppendHeader("Content-Disposition",
                        "attachment; filename=" + HttpUtility.UrlEncode("资源排产计划图") + DateTime.Now.ToString("yyyyMMddhhmmss") + ".xls");
                    context.Response.HeaderEncoding = Encoding.UTF8;
                    context.Response.BinaryWrite(Encoding.UTF8.GetPreamble());


                    foreach (DataColumn column in table.Columns)
                    {
                        context.Response.Write(column.ColumnName + ",");
                        //context.Response.Write(column.ColumnName + "(" + column.DataType + "),");   
                    }

                    context.Response.Write(Environment.NewLine);
                    double test; DateTime dtTest;

                    foreach (DataRow row in table.Rows)
                    {
                        for (var i = 0; i < table.Columns.Count; i++)
                        {

                            if (double.TryParse(row[i].ToString(), out test))
                            {
                                context.Response.Write("=");
                                context.Response.Write("\"" + row[i].ToString() + "\",");
                            }
                            else if (DateTime.TryParse(row[i].ToString(), out dtTest))
                            {
                                //context.Response.Write("\"" + Convert.ToDateTime(row[i]).ToString("yyyy-MM-dd") + "\",");
                                context.Response.Write("=\"" + row[i].ToString() + "\",");
                            }
                            else
                            {
                                context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                            }
                        }
                        context.Response.Write(Environment.NewLine);
                    }

                    context.Response.End();
                    context.Response.Write(context.Response.OutputStream);


                }

            }
           
        }
        private void GetProjectOrderNo2(HttpContext context)
        {
            List<GanttItem> projectData = new List<GanttItem>();
            string orderNo = context.Request["orderNo"] != "" ? context.Request["orderNo"] : "";
            int orderId = context.Request["orderId"] != "-1" ? Convert.ToInt32(context.Request["orderId"]) : -1;

            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.MESConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspGetOrderGanttDataTwo";

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@ProdOrderId",
                    SqlDbType = SqlDbType.Int,
                    Value = orderId
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@OrderNo",
                    SqlDbType = SqlDbType.VarChar,
                    Value = orderNo
                });
                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                Values values;
                List<Values> listvList = null;
                GanttItem item = new GanttItem();
                if (ds != null && ds.Tables.Count == 2)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                    {

                        item = new GanttItem();
                        item.name = Convert.ToString(r["OrderNo"]);
                        item.desc = Convert.ToString(r["Progress"]) + "%";
                        listvList = new List<Values>();
                        foreach (DataRow tb in ds.Tables[1].Rows)
                        {

                            if (Convert.ToInt32(r["ProdOrderID"]) == Convert.ToInt32(tb["ProdOrderID"]))
                            {
                                values = new Values();
                                values.from = DateToTicks(Convert.ToDateTime(tb["StartDate"])).ToString();
                                values.to = DateToTicks(Convert.ToDateTime(tb["EndDate"])).ToString();
                                values.desc = "<b>排产单号：" + Convert.ToString(tb["OrderNo"]) + "</b><br><b>排产数量：" + Convert.ToDecimal(tb["Qty_to_Build"]) + "</b><br><b>计划时间：</b>" + Convert.ToString(tb["StartDate"]) + " - " + Convert.ToString(tb["EndDate"]);
                                values.label = Convert.ToString(tb["OrderNo"]);
                                switch (Convert.ToInt32(tb["Status"]))
                                {
                                    case 1:
                                        values.customClass = "ganttOrange";
                                        break;
                                    case 2:
                                        values.customClass = "ganttOrange";
                                        break;
                                    case 3:
                                        values.customClass = "ganttGreen";
                                        break;
                                    case 4:
                                        values.customClass = "ganttRed";
                                        break;
                                    default:
                                        values.customClass = "ganttOrange";
                                        break;
                                }
                                listvList.Add(values);
                            }
                        }
                        item.values = listvList;
                        projectData.Add(item);

                    }
                }
            }

            string jsonStr = JsonConvert.SerializeObject(projectData);
            jsonStr = GetObjectToJSONResult("ok", jsonStr);
            context.Response.Write(jsonStr);
        }

        public string DateToTicks(DateTime? time)
        {
            return "/Date(" + (((time.HasValue ? time.Value.Ticks : DateTime.Parse("1990-01-01 09:00:00").Ticks) - 621355968000000000) / 10000).ToString() + ")/";
        }

        public static string ToMillisecondDateTwo(DateTime dt)
        {
            return "/Date(" + ((dt.Date.ToUniversalTime().Ticks - 621355968000000000) / 10000000).ToString() + ")/";
        }
        ///// <summary>
        ///// /根据工单获取甘特图
        ///// </summary>
        ///// <param name="monthPlanInfos"></param>
        ///// <returns></returns>
        //private ProjectData ConvertToGanttDataOrder(List<LinePlanInfo> monthPlanInfos)
        //{
        //    ProjectData prjData = new ProjectData();
        //    LinePlan simulationPlanBll = new LinePlan();
        //    int id = 1;
        //    SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
        //    List<LinePlanInfo> resultDayList = null;
        //    TaskData taskData;
        //    List<Object> list = new List<object>();

        //    List<LinePlanInfo> resultOrder = null;
        //    List<LinePlanInfo> resultDay = null;
        //    DateTime maxFPlanCommitDate;
        //    monthPlanInfos.GroupBy(m => m.OrderNo)
        //        .Select(k => new {Name = k.Key});
        //    resultDayList = simulationPlanBll.GetAll(0, Int32.MaxValue, "FPlanCommitDate", searchSettings);
        //    foreach (LinePlanInfo model in monthPlanInfos)
        //    {

        //        taskData = new TaskData();
        //        taskData.id = -1 * id;
        //        id++;
        //        taskData.name = model.OrderNo;
        //        taskData.code = model.FPlanCommitDate.ToString();
        //        taskData.level = 0;
        //        taskData.status = "STATUS_SUSPENDED";
        //        switch (3)
        //        {
        //            case 1:
        //                taskData.status = "STATUS_FAILED";
        //                break;
        //            case 2:
        //                taskData.status = "STATUS_ACTIVE";
        //                break;
        //            case 3:
        //                taskData.status = "STATUS_SUSPENDED";
        //                break;
        //            case 4:
        //                taskData.status = "STATUS_DONE";
        //                break;
        //            default:
        //                taskData.status = "STATUS_UNDEFINED";
        //                break;
        //        }
        //        //searchSettings.ExtensionCondition = "  FInterID=" + model.ProdOrderID;

        //        resultDay = monthPlanInfos.Where(p => p.FInterID == model.FInterID).ToList();
        //        maxFPlanCommitDate=resultDay.Max(x => x.FPlanCommitDate);

        //        //resultDay = simulationPlanBll.GetPlanOrderAll(0, 50, "", searchSettings);
        //        taskData.canWrite = true;
        //        taskData.start = ToMillisecondDate(model.FPlanCommitDate);
        //        //long end = ToMillisecondDate(model.PlanTimeEnd);
        //        taskData.duration = resultDay == null ? 0 : resultDay.Count;
        //        taskData.end = ToMillisecondDate(maxFPlanCommitDate); 
        //        taskData.startIsMilestone = true;
        //        taskData.endIsMilestone = true;
        //        taskData.collapsed = true;
        //        taskData.assigs = list;
        //        taskData.hasChild = true;
        //        taskData.depends = "";
        //        taskData.description = "";
        //        if (model.FQty > 0 && model.FStockQty>0)
        //        {
        //            taskData.progress = Convert.ToInt32(model.FQty*100/model.FStockQty); //进度值，例:65%的话值是65  
        //        }
        //        else
        //        {
        //            taskData.progress = 0;
        //        }

        //        prjData.tasks.Add(taskData);

        //        if (resultDay != null)
        //        {
        //            for (int i = 0; i < resultDay.Count; i++)
        //            {

        //                taskData = new TaskData();
        //                taskData.id = -1 * id;
        //                id++;
        //                taskData.name = resultDay[i].ResName + "(" + Convert.ToInt32(resultDay[i].FStockQty) + ")";
        //                taskData.code = resultDay[i].FBILLNO.ToString();
        //                taskData.level = 1;
        //                taskData.status = "STATUS_SUSPENDED";
        //                //switch (3)
        //                //{
        //                //    case 1:
        //                //        taskData.status = "STATUS_FAILED";
        //                //        break;
        //                //    case 2:
        //                //        taskData.status = "STATUS_ACTIVE";
        //                //        break;
        //                //    case 3:
        //                //        taskData.status = "STATUS_SUSPENDED";
        //                //        break;
        //                //    case 4:
        //                //        taskData.status = "STATUS_DONE";
        //                //        break;
        //                //    default:
        //                //        taskData.status = "STATUS_UNDEFINED";
        //                //        break;
        //                //}
        //                taskData.canWrite = true;
        //                taskData.start = ToMillisecondDate(Convert.ToDateTime(resultDay[i].FPlanCommitDate));

        //                taskData.duration = CountWorkDays(Convert.ToDateTime(resultDay[i].FPlanCommitDate), Convert.ToDateTime(resultDay[i].FPlanFinishDate));
        //                taskData.end = ToMillisecondDate(Convert.ToDateTime(resultDay[i].FPlanFinishDate)); ;
        //                taskData.startIsMilestone = true;
        //                taskData.endIsMilestone = false;
        //                taskData.collapsed = true;
        //                taskData.assigs = list;
        //                taskData.hasChild = false;
        //                taskData.depends = "";
        //                taskData.description = "";
        //                taskData.progress = 10;//进度值，例:65%的话值是65  
        //                prjData.tasks.Add(taskData);

        //                //searchSettings.ExtensionCondition = " Did=" + resultDay[i].Did;
        //                //resultResources = simulationPlanBll.GetPlanDayResourceList(0, 50, "", searchSettings);
        //                //if (resultResources != null)
        //                //{
        //                //    for (int j = 0; j < resultResources.Count; j++)
        //                //    {
        //                //        taskData = new TaskData();
        //                //        taskData.id = -1 * id;
        //                //        id++;
        //                //        taskData.name = resultResources[j].ResName + "(" + resultResources[j].ActualYield + ")";
        //                //        taskData.code = resultResources[j].Dc_ID.ToString();
        //                //        taskData.level = 2;
        //                //        switch (3)
        //                //        {
        //                //            case 1:
        //                //                taskData.status = "STATUS_FAILED";
        //                //                break;
        //                //            case 2:
        //                //                taskData.status = "STATUS_ACTIVE";
        //                //                break;
        //                //            case 3:
        //                //                taskData.status = "STATUS_SUSPENDED";
        //                //                break;
        //                //            case 4:
        //                //                taskData.status = "STATUS_DONE";
        //                //                break;
        //                //            default:
        //                //                taskData.status = "STATUS_UNDEFINED";
        //                //                break;
        //                //        }
        //                //        taskData.canWrite = true;
        //                //        taskData.start = ToMillisecondDate(Convert.ToDateTime(resultDay[i].TimeDay));

        //                //        taskData.duration = CountWorkDays(Convert.ToDateTime(resultDay[i].TimeDay), Convert.ToDateTime(resultDay[i].TimeDay));
        //                //        taskData.end = ToMillisecondDate(Convert.ToDateTime(resultDay[i].TimeDay)); ;
        //                //        taskData.startIsMilestone = true;
        //                //        taskData.endIsMilestone = false;
        //                //        taskData.collapsed = false;
        //                //        taskData.assigs = list;
        //                //        taskData.hasChild = true;
        //                //        taskData.depends = "";
        //                //        taskData.description = "";
        //                //        taskData.progress = 10;//进度值，例:65%的话值是65  
        //                //        prjData.tasks.Add(taskData);

        //                //    }
        //                //}
        //            }

        //        }
        //    }


        //    return prjData;
        //}
        #endregion

        #region 取得资源甘特图
        private void GetProjectReource(HttpContext context)
        {
            string ret = "";
            try
            {
                int resourceId = context.Request["ResourceId"] != "" ? Convert.ToInt32(context.Request["ResourceId"]) : -1;
                LeanMES.Resource.BLL.Resource bll = new LeanMES.Resource.BLL.Resource();
                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                if (resourceId != -1)
                {
                    searchSettings.ExtensionCondition += " ResourceId=" + resourceId;
                }

                List<ResourceInfo> result = bll.GetAll(0, 100, "", searchSettings);
                ProjectData prjData = null;
                if (result != null)
                {
                    //prjData = ConvertToGanttDataResource(result);
                }
                ret = JsonConvert.SerializeObject(prjData);
                ret = GetObjectToJSONResult("ok", ret);



            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            context.Response.Write(ret);
        }

        ///// <summary>
        ///// 根据资源获取甘特图
        ///// </summary>
        ///// <param name="monthPlanInfos"></param>
        ///// <returns></returns>
        //private ProjectData ConvertToGanttDataResource(List<ResourceInfo> monthPlanInfos)
        //{
        //    ProjectData prjData = new ProjectData();
        //    LinePlan simulationPlanBll = new LinePlan();
        //    int id = 1;
        //    SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

        //    List<DemoSchedulingInfo> resultDay = null;
        //    List<PlanDayResource> resultResources = null;
        //    TaskData taskData;
        //    List<Object> list = new List<object>();
        //    foreach (ResourceInfo model in monthPlanInfos)
        //    {
        //        taskData = new TaskData();
        //        taskData.id = -1 * id;
        //        id++;
        //        taskData.name = model.ResName ;
        //        taskData.code = model.ResourceId.ToString();
        //        taskData.level = 0;
        //        taskData.status = "STATUS_SUSPENDED";
        //        //switch (3)
        //        //{
        //        //    case 1:
        //        //        taskData.status = "STATUS_FAILED";
        //        //        break;
        //        //    case 2:
        //        //        taskData.status = "STATUS_ACTIVE";
        //        //        break;
        //        //    case 3:
        //        //        taskData.status = "STATUS_SUSPENDED";
        //        //        break;
        //        //    case 4:
        //        //        taskData.status = "STATUS_DONE";
        //        //        break;
        //        //    default:
        //        //        taskData.status = "STATUS_UNDEFINED";
        //        //        break;
        //        //}


        //        resultDay = simulationPlanBll.GetResouceDayList(model.ItemId,model.ResourceId.ToString());
        //        //resultDay = simulationPlanBll.GetPlanOrderAll(0, 50, "", searchSettings);
        //        taskData.canWrite = true;
        //        taskData.start = ToMillisecondDate(DateTime.Now);
        //        //long end = ToMillisecondDate(model.PlanTimeEnd);
        //        taskData.duration = resultDay == null ? 0 : resultDay.Count;
        //        taskData.end = ToMillisecondDate(DateTime.Now); ;
        //        taskData.startIsMilestone = true;
        //        taskData.endIsMilestone = false;
        //        taskData.collapsed = true;
        //        taskData.assigs = list;
        //        taskData.hasChild = true;
        //        taskData.depends = "";
        //        taskData.description = "";
        //        taskData.progress = 0 ;//进度值，例:65%的话值是65  
        //        prjData.tasks.Add(taskData);

        //        if (resultDay != null)
        //        {
        //            for (int i = 0; i < resultDay.Count; i++)
        //            {

        //                taskData = new TaskData();
        //                taskData.id = -1 * id;
        //                id++;
        //                taskData.name = resultDay[i].OrderNo + "   (" + Convert.ToInt32(resultDay[i].PlanNum) + ")";
        //                taskData.code = resultDay[i].ResourceId.ToString();
        //                taskData.level = 1;
        //                taskData.status = "STATUS_SUSPENDED";
        //                //switch (3)
        //                //{
        //                //    case 1:
        //                //        taskData.status = "STATUS_FAILED";
        //                //        break;
        //                //    case 2:
        //                //        taskData.status = "STATUS_ACTIVE";
        //                //        break;
        //                //    case 3:
        //                //        taskData.status = "STATUS_SUSPENDED";
        //                //        break;
        //                //    case 4:
        //                //        taskData.status = "STATUS_DONE";
        //                //        break;
        //                //    default:
        //                //        taskData.status = "STATUS_UNDEFINED";
        //                //        break;
        //                //}
        //                taskData.canWrite = true;
        //                taskData.start = ToMillisecondDate(Convert.ToDateTime(resultDay[i].StartPlanTime));

        //                taskData.duration = CountWorkDays(Convert.ToDateTime(resultDay[i].StartPlanTime), Convert.ToDateTime(resultDay[i].EndPlanTime));
        //                taskData.end = ToMillisecondDate(Convert.ToDateTime(resultDay[i].EndPlanTime)); ;
        //                taskData.startIsMilestone = true;
        //                taskData.endIsMilestone = false;
        //                taskData.collapsed = true;
        //                taskData.assigs = list;
        //                taskData.hasChild = true;
        //                taskData.depends = "";
        //                taskData.description = "";
        //                taskData.progress = 0;// Convert.ToInt32(resultDay[i].PlanNum * 100 / resultDay[i].ActualCapacity); ;//进度值，例:65%的话值是65  
        //                prjData.tasks.Add(taskData);

        //            }

        //        }
        //    }


        //    return prjData;
        //}
        #endregion

        //private ProjectData convertToGanttData(List<MonthPlanInfo> monthPlanInfos)
        //{
        //    ProjectData prjData = new ProjectData();
        //    SimulationPlan simulationPlanBll=new SimulationPlan();
        //    int id = 1;
        //    SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
        //    List<MonthPlanDay> resultDayList = null;
        //    resultDayList = simulationPlanBll.GetAll(0, 50, "", searchSettings);
        //    List<MonthPlanDay> resultDay = null;
        //    List<PlanDayResource> resultResources = null;
        //    TaskData taskData;
        //    List<Object> list=new List<object>();
        //    foreach (MonthPlanInfo model in monthPlanInfos)
        //    {
        //        taskData = new TaskData();
        //        taskData.id = -1 * id;
        //        id++;
        //        taskData.name = model.ItemName+"("+model.ProducedNum+")";
        //        taskData.code = model.Bid.ToString();
        //        taskData.level = 0;
        //        taskData.status = "STATUS_SUSPENDED";
        //        //switch (3)
        //        //{
        //        //    case 1:
        //        //        taskData.status = "STATUS_FAILED";
        //        //        break;
        //        //    case 2:
        //        //        taskData.status = "STATUS_ACTIVE";
        //        //        break;
        //        //    case 3:
        //        //        taskData.status = "STATUS_SUSPENDED";
        //        //        break;
        //        //    case 4:
        //        //        taskData.status = "STATUS_DONE";
        //        //        break;
        //        //    default:
        //        //        taskData.status = "STATUS_UNDEFINED";
        //        //        break;
        //        //}

        //        //searchSettings.ExtensionCondition = " Bid=" + model.Bid;
        //        resultDay = resultDayList.Where(p => p.Bid == model.Bid).ToList();
        //        taskData.canWrite = true;
        //        taskData.start = ToMillisecondDate(model.PlanTimeStart);
        //        //long end = ToMillisecondDate(model.PlanTimeEnd);
        //        taskData.duration = resultDay==null?0:resultDay.Count;
        //        taskData.end = ToMillisecondDate(model.PlanTimeEnd); ;
        //        taskData.startIsMilestone = true;
        //        taskData.endIsMilestone = false;
        //        taskData.collapsed = true;
        //        taskData.assigs = list;
        //        taskData.hasChild = true;
        //        taskData.depends = "";
        //        taskData.description = "";
        //        if (model.Number > 0)
        //        {
        //            taskData.progress = Convert.ToInt32(model.ProducedNum*100/model.Number); //进度值，例:65%的话值是65  
        //        }
        //        else
        //        {
        //            taskData.progress = 0;
        //        }

        //        prjData.tasks.Add(taskData);

        //        if (resultDay != null)
        //        {
        //            for (int i = 0; i < resultDay.Count; i++)
        //            {

        //                taskData = new TaskData();
        //                taskData.id = -1 * id;
        //                id++;
        //                taskData.name = resultDay[i].TimeDay+ "(" + resultDay[i].ActualYield+ ")";
        //                taskData.code = resultDay[i].Did.ToString();
        //                taskData.level = 1;
        //                taskData.status = "STATUS_SUSPENDED";
        //                //switch (3)
        //                //{
        //                //    case 1:
        //                //        taskData.status = "STATUS_FAILED";
        //                //        break;
        //                //    case 2:
        //                //        taskData.status = "STATUS_ACTIVE";
        //                //        break;
        //                //    case 3:
        //                //        taskData.status = "STATUS_SUSPENDED";
        //                //        break;
        //                //    case 4:
        //                //        taskData.status = "STATUS_DONE";
        //                //        break;
        //                //    default: 
        //                //        taskData.status = "STATUS_UNDEFINED";
        //                //        break;
        //                //}
        //                taskData.canWrite = true;
        //                taskData.start = ToMillisecondDate(Convert.ToDateTime(resultDay[i].TimeDay));

        //                taskData.duration = CountWorkDays(Convert.ToDateTime(resultDay[i].TimeDay), Convert.ToDateTime(resultDay[i].TimeDay));
        //                taskData.end = ToMillisecondDate(Convert.ToDateTime(resultDay[i].TimeDay)); ;
        //                taskData.startIsMilestone = true;
        //                taskData.endIsMilestone = false;
        //                taskData.collapsed = true;
        //                taskData.assigs = list;
        //                taskData.hasChild = true;
        //                taskData.depends = "";
        //                taskData.description = "";
        //                taskData.progress = 10;//进度值，例:65%的话值是65  
        //                prjData.tasks.Add(taskData);

        //                searchSettings.ExtensionCondition = " Did=" + resultDay[i].Did;
        //                resultResources = simulationPlanBll.GetPlanDayResourceList(0, 50, "", searchSettings);
        //                if (resultResources != null)
        //                {
        //                    for (int j = 0; j < resultResources.Count; j++)
        //                    {
        //                        taskData = new TaskData();
        //                        taskData.id = -1 * id;
        //                        id++;
        //                        taskData.name = resultResources[j].ResName + "(" + resultResources[j].ActualYield + ")";
        //                        taskData.code = resultResources[j].Dc_ID.ToString();
        //                        taskData.level = 2;
        //                        taskData.status = "STATUS_SUSPENDED";
        //                        //switch (3)
        //                        //{
        //                        //    case 1:
        //                        //        taskData.status = "STATUS_FAILED";
        //                        //        break;
        //                        //    case 2:
        //                        //        taskData.status = "STATUS_ACTIVE";
        //                        //        break;
        //                        //    case 3:
        //                        //        taskData.status = "STATUS_SUSPENDED";
        //                        //        break;
        //                        //    case 4:
        //                        //        taskData.status = "STATUS_DONE";
        //                        //        break;
        //                        //    default:
        //                        //        taskData.status = "STATUS_UNDEFINED";
        //                        //        break;
        //                        //}
        //                        taskData.canWrite = true;
        //                        taskData.start = ToMillisecondDate(Convert.ToDateTime(resultDay[i].TimeDay));

        //                        taskData.duration = CountWorkDays(Convert.ToDateTime(resultDay[i].TimeDay), Convert.ToDateTime(resultDay[i].TimeDay));
        //                        taskData.end = ToMillisecondDate(Convert.ToDateTime(resultDay[i].TimeDay)); ;
        //                        taskData.startIsMilestone = true;
        //                        taskData.endIsMilestone = false;
        //                        taskData.collapsed = true;
        //                        taskData.assigs = list;
        //                        taskData.hasChild = true;
        //                        taskData.depends = "";
        //                        taskData.description = "";
        //                        taskData.progress = 10;//进度值，例:65%的话值是65  
        //                        prjData.tasks.Add(taskData);

        //                    }
        //                }
        //            }

        //        }
        //    }


        //    return prjData;
        //}

        private static readonly DateTime StartTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1)).Date;
        private static long ToMillisecondDate(DateTime dt)
        {
            //DateTime date = dt.Value;
            //return Convert.ToInt64((date.Date - StartTime.Date).TotalSeconds * 1000);
            DateTime startTime = TimeZoneInfo.ConvertTime(new DateTime(1970, 1, 1, 8, 0, 0, 0), TimeZoneInfo.Local);
            long t = (dt.Ticks - startTime.Ticks) / 10000;   //除10000调整为13位
            return t;

        }
        private static DateTime ConvertToDateTime(long timeSpan)
        {
            DateTime dt = StartTime.AddSeconds(timeSpan / 1000);
            return dt;
        }

        private static int CountWorkDays(DateTime start, DateTime end)
        {
            TimeSpan ts1 = end.Subtract(start);//TimeSpan得到dt1和dt2的时间间隔  
            int countday = ts1.Days;//获取两个日期间的总天数  
            int workkdays = 0;//工作日  
            //循环用来扣除总天数中的双休日  
            for (int i = 0; i < countday; i++)
            {
                DateTime tempdt = start.Date.AddDays(i);
                //if (tempdt.DayOfWeek != System.DayOfWeek.Saturday && tempdt.DayOfWeek != System.DayOfWeek.Sunday)
                //{
                //    workkdays++;
                //}
                workkdays++;
            }

            return workkdays;
        }

        public static string GetObjectToJSONResult(string status, string data)
        {
            ResultJson resultJson = new ResultJson();
            resultJson.Statue = status;
            resultJson.Data = data;
            return JsonConvert.SerializeObject(resultJson);

        }
        private static DateTime CountEndDateTime(DateTime start, long duration)
        {
            DateTime dtEnd = start;
            long count = duration;
            while (count > 0)
            {
                dtEnd = dtEnd.AddDays(1);
                if (dtEnd.DayOfWeek != System.DayOfWeek.Saturday && dtEnd.DayOfWeek != System.DayOfWeek.Sunday)
                {
                    count--;
                }
            }

            return dtEnd;
        }

        private class ProjectData
        {
            public List<TaskData> tasks;

            public int selectedRow;

            public bool canWrite;

            public bool canWriteOnParent;

            public ProjectData()
            {
                selectedRow = 0;
                canWrite = false;
                canWriteOnParent = false;

                tasks = new List<TaskData>();
            }
        }
        private class TaskData
        {
            public int id { get; set; }
            public string name { get; set; }
            public string code { get; set; }
            public int level { get; set; }
            public string status { get; set; }
            public bool canWrite { get; set; }
            public long start { get; set; }
            public long duration { get; set; }
            public long end { get; set; }
            public bool startIsMilestone { get; set; }
            public bool endIsMilestone { get; set; }
            public bool collapsed { get; set; }
            public List<object> assigs { get; set; }
            public string depends { get; set; }
            public bool hasChild { get; set; }
            public string description { get; set; }
            public decimal progress { get; set; }
            public string type { get; set; }
            public string statusdesc { get; set; }
            public string typeId { get; set; }
            public bool progressByWorklog { get; set; }

            public int relevance { get; set; }


            public string startTime { get; set; }

            public string endTime { get; set; }
            public TaskData()
            {
                code = "";
                level = 0;
                canWrite = false;
                assigs = new List<object>();
                hasChild = false;
            }
        }

        public class ResultJson
        {
            public string Statue { get; set; }
            public string Data { get; set; }
        }


        public class Values
        {


            /// <summary>
            /// 
            /// </summary>
            public string from { get; set; }
            /// <summary>
            /// 
            /// </summary>
            public string to { get; set; }
            /// <summary>
            /// 
            /// </summary>
            public string desc { get; set; }
            /// <summary>
            /// 
            /// </summary>
            public string customClass { get; set; }
            /// <summary>
            /// 
            /// </summary>
            public string label { get; set; }
        }

        public class GanttItem
        {
            /// <summary>
            /// 
            /// </summary>
            public string name { get; set; }
            /// <summary>
            /// 
            /// </summary>
            public string desc { get; set; }
            /// <summary>
            /// 
            /// </summary>
            public List<Values> values { get; set; }
        }




        //#region 导出MPP  
        //private void ExportMpp(HttpContext context)
        //{
        //    string ret = "";

        //    try
        //    {
        //        string KDJHNO = Operate.getParameter(context, "KDJHNO") != "" ? Operate.getParameter(context, "KDJHNO") : "";

        //        string strMPPNAME = "开店任务_" + KDJHNO + "_" + DateTime.Now.ToString("yyyy_MM_dd_hh_mm_ss") + ".mpp";
        //        string strDirectory = context.Server.MapPath("~/tempfile");
        //        string strFullName = strDirectory + "/" + strMPPNAME;

        //        checkAndCreatePath(strDirectory);
        //        //string DataJson = Operate.getParameter(context, "JSON_DATA") != "" ? Operate.getParameter(context, "JSON_DATA") : "";  
        //        //ProjectData prjData = JsonHelper.Deserialize<ProjectData>(DataJson);  
        //        //createMppFromJson(strFullName, prjData);  

        //        NRSS.BLL.XMK_Z_KDJH bll = new NRSS.BLL.XMK_Z_KDJH();
        //        List<NRSS.Model.XMK_Z_KDJH_GANTT> lstModels = bll.GetListForGantt(KDJHNO);

        //        createMppFromDB(strFullName, lstModels);

        //        ret = Operate.getJSONResult("ok", strMPPNAME);
        //    }
        //    catch (Exception ex)
        //    {
        //        ret = Operate.getJSONResult("error", "导出失败：" + ex.Message);
        //    }

        //    context.Response.Write(ret);
        //}
        //private void ExportMppExt(HttpContext context)
        //{
        //    string ret = "";

        //    try
        //    {
        //        string BASENO = Operate.getParameter(context, "BASENO") != "" ? Operate.getParameter(context, "BASENO") : "";
        //        string ItemName = Operate.getParameter(context, "ItemName") != "" ? Operate.getParameter(context, "ItemName") : "";
        //        string PBDATE_FROM = Operate.getParameter(context, "PBDATE_FROM") != "" ? Operate.getParameter(context, "PBDATE_FROM") : "";
        //        string PBDATE_TO = Operate.getParameter(context, "PBDATE_TO") != "" ? Operate.getParameter(context, "PBDATE_TO") : "";
        //        string DEPT = Operate.getParameter(context, "DEPT") != "" ? Operate.getParameter(context, "DEPT") : "";

        //        if (!string.IsNullOrEmpty(ItemName))
        //        {
        //            ItemName = HttpUtility.UrlDecode(ItemName);
        //        }
        //        if (!string.IsNullOrEmpty(DEPT))
        //        {
        //            DEPT = HttpUtility.UrlDecode(DEPT);
        //        }

        //        NRSS.BLL.XMK_Z_KDJH bll = new NRSS.BLL.XMK_Z_KDJH();

        //        List<NRSS.Model.XMK_Z_KDJH_GANTT> lstModels = bll.GetListForGanttExt(BASENO, ItemName, PBDATE_FROM, PBDATE_TO, DEPT);


        //        string strMPPNAME = "开店任务_" + BASENO + "_" + DateTime.Now.ToString("yyyy_MM_dd_hh_mm_ss") + ".mpp";
        //        string strDirectory = context.Server.MapPath("~/tempfile");
        //        string strFullName = strDirectory + "/" + strMPPNAME;

        //        checkAndCreatePath(strDirectory);
        //        //string DataJson = Operate.getParameter(context, "JSON_DATA") != "" ? Operate.getParameter(context, "JSON_DATA") : "";  
        //        //ProjectData prjData = JsonHelper.Deserialize<ProjectData>(DataJson);  
        //        //createMppFromJson(strFullName, prjData);  

        //        createMppFromDB(strFullName, lstModels);

        //        ret = Operate.getJSONResult("ok", strMPPNAME);
        //    }
        //    catch (Exception ex)
        //    {
        //        ret = Operate.getJSONResult("error", "导出失败：" + ex.Message);
        //    }

        //    context.Response.Write(ret);
        //}
        //private void createMppFromJson(string prjFileName, ProjectData prjData)
        //{
        //    MSProject.ApplicationClass prj = null;
        //    int i = 0;
        //    try
        //    {
        //        Object missing = Type.Missing;
        //        prj = new MSProject.ApplicationClass();
        //        MSProject.PjFileFormat format = MSProject.PjFileFormat.pjMPP;//format定义     

        //        prj.Visible = false;
        //        prj.FileNew(Type.Missing, Type.Missing, Type.Missing, false);
        //        MSProject.Project myProject = prj.ActiveProject;
        //        MSProject.Task task = null;

        //        if (prjData != null && prjData.tasks != null)
        //        {
        //            for (i = 0; i < prjData.tasks.Count; i++)
        //            {
        //                TaskData srcData = prjData.tasks[i];
        //                srcData.name = srcData.name.Replace('\n', ' ');
        //                task = myProject.Tasks.Add(srcData.name, (i + 1));
        //                DateTime dtStart = ConvertToDateTime(srcData.start);
        //                task.Start = dtStart;
        //                task.Finish = CountEndDateTime(dtStart, srcData.duration);
        //                //task.Duration = srcData.duration;  
        //                task.PercentComplete = srcData.progress;
        //                if (srcData.level > 0)
        //                {
        //                    task.OutlineLevel = (short)srcData.level;
        //                }
        //            }

        //        }
        //        //task = myProject.Tasks.Add("zhi", 1);  
        //        //task.Start = "2008-8-1";  
        //        //task.Finish = "2008-8-18";  
        //        //task.SetField(MSProject.PjField.pjTaskNotes, "Task1");  

        //        //task = null;  
        //        //task = myProject.Tasks.Add("wenzhixing", 2);  
        //        //task.Start = "2008-8-8";  
        //        //task.Finish = "2008-8-28";  
        //        //task.ActualStart = "2008-9-8 8:00";  
        //        //task.ActualFinish = "2008-9-28 17:00";  
        //        //task.OutlineLevel = 2;  
        //        //task.SetField(MSProject.PjField.pjTaskResourceNames, "wenzhi");  

        //        //task = null;  
        //        //task = myProject.Tasks.Add("wen", 3);  
        //        //task.Start = "2008-8-11";  
        //        //task.Finish = "2008-8-18";  
        //        //task.SetField(MSProject.PjField.pjTaskNotes, "Task2");  
        //        //task.Notes += "hehe";  
        //        //task.OutlineLevel = 1;  

        //        //task = null;  
        //        //task = myProject.Tasks.Add("wen", 4);  
        //        //task.Start = "2008-8-18";  
        //        //task.Finish = "2008-8-28";  
        //        //task.OutlineLevel = 2;  
        //        //task.SetField(MSProject.PjField.pjTaskResourceNames, "wenzhi");  

        //        prj.FileSaveAs(prjFileName, format
        //                        , Type.Missing, false, Type.Missing, Type.Missing, Type.Missing
        //                        , Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing
        //                        , Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);
        //    }
        //    catch (Exception ex)
        //    {

        //        throw new Exception("[任务行(" + (i + 1) + ")]" + ex.Message);
        //    }
        //    finally
        //    {
        //        if (prj != null)
        //        {
        //            try
        //            {
        //                prj.FileClose(MSProject.PjSaveType.pjDoNotSave);
        //                prj.Quit(MSProject.PjSaveType.pjDoNotSave);
        //            }
        //            catch { }
        //        }
        //    }
        //}
        //private void createMppFromDB(string prjFileName, List<NRSS.Model.XMK_Z_KDJH_GANTT> lstModels)
        //{
        //    MSProject.ApplicationClass prj = null;
        //    int i = 0;
        //    try
        //    {
        //        Object missing = Type.Missing;
        //        prj = new MSProject.ApplicationClass();
        //        MSProject.PjFileFormat format = MSProject.PjFileFormat.pjMPP;//format定义     

        //        prj.Visible = false;
        //        prj.FileNew(Type.Missing, Type.Missing, Type.Missing, false);
        //        MSProject.Project myProject = prj.ActiveProject;
        //        MSProject.Task task = null;

        //        Dictionary<int, int> dicIndex = new Dictionary<int, int>();
        //        Dictionary<int, short> dicTaskLevel = new Dictionary<int, short>();
        //        NRSS.Model.XMK_Z_KDJH_GANTT model = null;
        //        if (lstModels != null && lstModels.Count > 0)
        //        {
        //            for (i = 0; i < lstModels.Count; i++)
        //            {
        //                model = lstModels[i];
        //                model.JHNAME = model.JHNAME.Replace('\n', ' ');
        //                model.DEPT = model.DEPT.Replace('\n', ' ');

        //                task = myProject.Tasks.Add(model.JHNAME, Type.Missing);
        //                task.Start = model.PBDATE.Value;
        //                task.Finish = model.PEDATE.Value;
        //                if (model.ISFINISH == 1 || model.PERATE >= 100)
        //                {
        //                    if (model.BDATE != null && model.EDATE != null)
        //                    {
        //                        task.ActualStart = model.BDATE.Value;
        //                        task.ActualFinish = model.EDATE.Value;
        //                    }
        //                }

        //                task.PercentComplete = model.PERATE;

        //                short level = 1;
        //                if (model.PNO != null)
        //                {
        //                    if (dicTaskLevel.ContainsKey(model.PNO.Value))
        //                    {
        //                        short iParentLevel = dicTaskLevel[model.PNO.Value];
        //                        level = iParentLevel;
        //                        level++;
        //                    }
        //                }
        //                if (!dicTaskLevel.ContainsKey(model.JHNO))
        //                {
        //                    dicTaskLevel.Add(model.JHNO, level);
        //                }

        //                if (level > 0)
        //                {
        //                    task.OutlineLevel = level;
        //                }

        //                task.SetField(MSProject.PjField.pjTaskResourceNames, model.DEPT + "(" + model.DUSER + ")");

        //                if (!dicIndex.ContainsKey(model.JHNO))
        //                {
        //                    dicIndex.Add(model.JHNO, i);
        //                }
        //            }

        //            for (i = 0; i < lstModels.Count; i++)
        //            {
        //                model = lstModels[i];

        //                if (!string.IsNullOrEmpty(model.QZJH))
        //                {
        //                    string[] arrQZNO = model.QZJH.Split(',');
        //                    foreach (string preNO in arrQZNO)
        //                    {
        //                        int iPreNO = int.Parse(preNO);
        //                        if (dicIndex.ContainsKey(iPreNO))
        //                        {
        //                            int index = dicIndex[iPreNO];
        //                            string JHNAME = lstModels[index].JHNAME;
        //                            //myProject.Tasks[i].Parent.Add(JHNAME, Type.Missing);  
        //                            //myProject.Tasks[i].Predecessors = myProject.Tasks[index].ID.ToString();  

        //                            myProject.Tasks[i + 1].TaskDependencies.Add(myProject.Tasks[index + 1], MSProject.PjTaskLinkType.pjFinishToStart, Type.Missing);
        //                        }
        //                    }
        //                }
        //            }
        //        }

        //        prj.FileSaveAs(prjFileName, format
        //                        , Type.Missing, false, Type.Missing, Type.Missing, Type.Missing
        //                        , Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing
        //                        , Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);
        //    }
        //    catch (Exception ex)
        //    {

        //        throw new Exception("[任务行(" + (i + 1) + ")]" + ex.Message);
        //    }
        //    finally
        //    {
        //        if (prj != null)
        //        {
        //            try
        //            {
        //                prj.FileClose(MSProject.PjSaveType.pjDoNotSave);
        //                prj.Quit(MSProject.PjSaveType.pjDoNotSave);
        //            }
        //            catch { }
        //        }
        //    }
        //}
        //private void DownloadMpp(HttpContext context)
        //{
        //    string ret = "";

        //    try
        //    {
        //        string fileName = Operate.getParameter(context, "FILE") != "" ? Operate.getParameter(context, "FILE") : "";
        //        string filePath = context.Server.MapPath("~/tempfile/" + fileName);

        //        downloadMSProject(context, fileName, filePath);
        //    }
        //    catch (Exception ex)
        //    {
        //        ret = Operate.getJSONResult("error", ex.Message);
        //    }
        //}

        //private void downloadMSProject(HttpContext context, string fileName, string strFullPath)
        //{
        //    // 取得下载文件  
        //    string strFileName = fileName;

        //    {
        //        context.Response.Buffer = true;
        //        context.Response.Clear();

        //        context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
        //        context.Response.ContentType = "application/ms-project;charset=gb2312";

        //        string downFile = System.IO.Path.GetFileName(strFileName);
        //        string EncodeFileName = HttpUtility.UrlEncode(downFile, System.Text.Encoding.UTF8);
        //        context.Response.AddHeader("Content-Disposition", "attachment;filename=" + EncodeFileName + ";");
        //        context.Response.BinaryWrite(System.IO.File.ReadAllBytes(strFullPath));//返回文件数据给客户端下载  
        //        context.Response.Flush();

        //        HttpContext.Current.ApplicationInstance.CompleteRequest();
        //    }
        //}

        //private void checkAndCreatePath(string path)
        //{
        //    if (!Directory.Exists(path))
        //    {
        //        Directory.CreateDirectory(path);
        //    }
        //}
        //#endregion
    }
}