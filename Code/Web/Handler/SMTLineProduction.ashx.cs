using Newtonsoft.Json;
using SKT.LeanMES.Kanban.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// SMTLineProduction 的摘要说明
    /// </summary>
    public class SMTLineProduction : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            SqlInjectableHelper.Validation(context);

            context.Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            context.Response.ContentType = "text/plain";

            string type = context.Request["Type"];
            int lineId = DisInt(context.Request["LineId"]);
            int workshopId = DisInt(context.Request["WorkshopId"]);

            switch (type)
            {
                case "ProductionData":
                    ProductionData(lineId, workshopId, context);
                    break;
                case "ProductionUPH":
                    ProductionUPH(lineId, workshopId, context);
                    break;
                case "ProductionTop5NC":
                    ProductionTop5NC(workshopId, context);
                    break;
                case "SynthesizeData":
                    SynthesizeData(context);
                    break;

                case "PersonnelEffciencyData":
                    PersonnelEffciencyData(-1, -1, context);
                    break;
            }
            context.Response.Flush();
            context.Response.End();
        }

        void PersonnelEffciencyData(int lineId, int workshopId, HttpContext context)
        {
            DataSet ds = new DataSet();

            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspGetPersonnelEfficiencyKanBanData";

                
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }                

                sqlcon.Close();
                sqlcon.Dispose();                
            }
            string jsonStr = JsonConvert.SerializeObject(ds);
            context.Response.Write(jsonStr);
        }


        void ProductionData(int lineId, int workshopId, HttpContext context)
        {
            ProductionDataInfo result = null;

            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspSMTLineProduction";

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@LineId",
                    SqlDbType = SqlDbType.Int,
                    Value = lineId
                });
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@WorkshopId",
                    SqlDbType = SqlDbType.Int,
                    Value = workshopId
                });

                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                if (ds != null && ds.Tables.Count == 2)
                {
                    result = new ProductionDataInfo();
                    result.SumDesigned = DisInt(ds.Tables[1].Rows[0]["SumDesigned"]);
                    result.SumInput = DisInt(ds.Tables[1].Rows[0]["SumInput"]);
                    result.SumOutput = DisInt(ds.Tables[1].Rows[0]["SumOutput"]);
                    result.SumDefects = DisInt(ds.Tables[1].Rows[0]["SumDefects"]);
                    result.AllInput = DisInt(ds.Tables[1].Rows[0]["AllInput"]);
                    result.AllOutput = DisInt(ds.Tables[1].Rows[0]["AllOutput"]);
                    result.AllDefects = DisInt(ds.Tables[1].Rows[0]["AllDefects"]);
                    result.SumQtyToBuild = DisInt(ds.Tables[1].Rows[0]["SumQtyToBuild"]);
                    //result.SumDiffSecond = DisInt(ds.Tables[1].Rows[0]["SumDiffSecond"]);
                    //result.SumAbnormalTime = DisDecimal(ds.Tables[1].Rows[0]["SumAbnormalTime"]);
                    result.SumBottleneckHours = DisDecimal(ds.Tables[1].Rows[0]["SumBottleneckHours"]);
                    //result.NoDefects = DisInt(ds.Tables[1].Rows[0]["NoDefects"]);
                    result.SumActualNumber = DisInt(ds.Tables[1].Rows[0]["SumActualNumber"]);
                    result.OEE = DisDecimal(ds.Tables[1].Rows[0]["OEE"]);
                    result.UPPH = DisDecimal(ds.Tables[1].Rows[0]["UPPH"]);
                    result.Progress = DisDecimal(ds.Tables[1].Rows[0]["Progress"]);
                    result.IEEfficiency = DisDecimal(ds.Tables[1].Rows[0]["IEEfficiency"]);
                    result.FPY = DisDecimal(ds.Tables[1].Rows[0]["FPY"]);
                    result.List = new List<SMTLineProductionInfo>();

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        result.List.Add(new SMTLineProductionInfo()
                        {
                            LineName = DisStr(row["LineName"]),
                            OrderNo = DisStr(row["OrderNo"]),
                            CustomerOrder = DisStr(row["CustomerOrder"]),
                            ItemCode = DisStr(row["ItemCode"]),
                            ItemName = DisStr(row["ItemName"]),
                            Surface = DisStr(row["Surface"]),
                            Designed = DisInt(row["Designed"]),
                            Input = DisInt(row["Input"]),
                            Output = DisInt(row["Output"]),
                            Defects = DisInt(row["Defects"]),
                            AllOutput = DisInt(row["AllOutput"]),
                            AllDefects = DisInt(row["AllDefects"]),
                            QtyToBuild = DisInt(row["Qty_to_Build"]),
                            //CycleTime = DisDecimal(row["CycleTime"]),
                            StandardCapacity = DisDecimal(row["StandardCapacity"]),
                            BottleneckHours = DisInt(row["BottleneckHours"]),
                            AllInput= DisInt(row["AllInput"]),
                            //DiffSecond = DisInt(row["DiffSecond"]),
                            Status = DisInt(row["AllOutput"]) >= DisInt(row["Qty_to_Build"]) ? "已完成" : "正在生产"//DisInt(row["Status"]) > 0 ? "正在生产" : "已完成"
                        });
                    }
                }
            }

            //计算计划产能值
            if (workshopId > 0 && result.List != null && result.List.Count > 0)
            {
                List<string> xAxis = new List<string>();
                List<string> listRate = new List<string>();
                List<string> listOutput = new List<string>();
                List<string> listDesigned = new List<string>();
                List<List<string>> series = new List<List<string>>();

                var query = from a in result.List
                            group a by new { a.LineName } into b
                            orderby b.Key.LineName
                            select new
                            {
                                LineName = b.Key.LineName,
                                Designed = b.Sum(t => t.Designed),
                                Output = b.Sum(t => t.Output),
                                StandardCapacity = b.Sum(t => t.StandardCapacity)
                            };
                foreach (var t in query)
                {
                    xAxis.Add(t.LineName);
                    listRate.Add(t.Designed > 0 ? (t.Output / Convert.ToDecimal(t.Designed) * 100).ToString("0.00") : "0");
                    listOutput.Add(t.Output.ToString());
                    listDesigned.Add(t.Designed.ToString());
                    //series.Add(new List<int>() { t.Designed, t.Output });
                }
                series.Add(listDesigned);
                series.Add(listOutput);
                series.Add(listRate);
                result.Echarts = new KanBanChartInfo();
                result.Echarts.Axis = xAxis;
                result.Echarts.Series = series;
            }
            string jsonStr = JsonConvert.SerializeObject(result);
            context.Response.Write(jsonStr);
        }

        void SynthesizeData(HttpContext context)
        {
            KanBanChartInfo t = new KanBanChartInfo();

            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspSynthesizeData";

                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                if (ds != null && ds.Tables.Count == 2)
                {
                    List<string> xAxis = new List<string>();
                    List<string> legend = new List<string>();
                    List<string> contrast = new List<string>();
                    List<ProductionDataUPHInfo> datas = new List<ProductionDataUPHInfo>();
                    List<ProductionDataUPHInfo> singleDatas = new List<ProductionDataUPHInfo>();
                    List<List<ProductionDataUPHInfo>> series = new List<List<ProductionDataUPHInfo>>();

                    foreach (DataRow r in ds.Tables[1].Rows)
                    {
                        datas.Add(new ProductionDataUPHInfo()
                        {
                            TimePoint = r["TimePoint"].ToString(),
                            ItemId = DisInt(r["ItemId"]),
                            ItemCode = r["ItemCode"].ToString(),
                            ItemName = r["ItemName"].ToString(),
                            Surface = r["Surface"].ToString(),
                            SumOutput = DisInt(r["SumOutput"]),
                            SumDesigned = DisInt(r["SumDesigned"]),
                            Defects = DisInt(r["Defects"]),
                            StandardCapacity = DisInt(r["StandardCapacity"])
                        });
                    }

                    /*筛选唯一(产品+面别)*/
                    var querySingle = from a in datas
                                      group a by new { a.ItemId, a.Surface } into b
                                      select new
                                      {
                                          ItemId = b.Key.ItemId,
                                          ItemName = b.Min(p => p.ItemName),
                                          Surface = b.Key.Surface
                                      };
                    foreach (var q in querySingle)
                    {
                        legend.Add(q.ItemName);
                        //legend.Add(!string.IsNullOrEmpty(q.Surface) ? string.Concat(q.ItemCode, "-", q.Surface) : q.ItemCode);
                    }

                    foreach (DataRow tp in ds.Tables[0].Rows)
                    {
                        string rolledYield = "0";
                        List<ProductionDataUPHInfo> timePointDatas = new List<ProductionDataUPHInfo>();

                        /*计算x坐标值*/
                        xAxis.Add(tp["TimePoint"].ToString());

                        /*计算直通率(当前时段的白板数/当前时间断的总产量)*/
                        var queryRolledYield = from a in datas
                                               where string.Concat(a.TimePoint.Substring(8, 2), "时") == tp["TimePoint"].ToString()
                                               group a by new { a.TimePoint } into b
                                               orderby b.Key.TimePoint
                                               select new
                                               {
                                                   TimePoint = b.Key.TimePoint,
                                                   SumOutput = b.Sum(p => p.SumOutput),
                                                   Defects = b.Sum(p => p.Defects)
                                               };
                        foreach (var q in queryRolledYield)
                        {
                            rolledYield = (q.SumOutput > 0 ? (q.SumOutput - q.Defects) / q.SumOutput * 100 : 0).ToString("0.00");
                            break;
                        }
                        contrast.Add(rolledYield);

                        /*填充时间段对应的机型计划产能*/
                        foreach (var q in querySingle)
                        {
                            //每一个时间段都得对应数据，所以此处必须初始对象。
                            var newTimePoint = new ProductionDataUPHInfo()
                            {
                                ItemId = q.ItemId,
                                ItemName = q.ItemName,
                                Surface = q.Surface
                            };

                            var queryTimePoint = from a in datas
                                                 where a.ItemId == q.ItemId && a.Surface == q.Surface && string.Concat(a.TimePoint.Substring(8, 2), "时") == tp["TimePoint"].ToString()
                                                 select a;
                            foreach (var timePoint in queryTimePoint)
                            {
                                newTimePoint = timePoint;
                                break;
                            }
                            timePointDatas.Add(newTimePoint);
                        }
                        series.Add(timePointDatas);
                    }
                    t.Axis = xAxis;         //x轴数据(0-23小时段)
                    t.Series = series;      //时间段里机型对应的产出和产能
                    t.Legen = legend;       //机型+"达成率"+"直通率"
                    t.Contrast = contrast;  //直通率
                    t.AxisIndex = xAxis.IndexOf(DateTime.Now.Hour.ToString().PadLeft(2, '0').PadRight(3, '时')); //当前时间(h)对应的时间段，会在x轴中标绿色表示
                }
            }
            string jsonStr = JsonConvert.SerializeObject(t);
            context.Response.Write(jsonStr);
        }

        void ProductionUPH(int lineId, int workshopId, HttpContext context)
        {
            KanBanChartInfo t = new KanBanChartInfo();

            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspSMTLineProductionUPH";

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@LineId",
                    SqlDbType = SqlDbType.Int,
                    Value = lineId
                });

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@WorkshopId",
                    SqlDbType = SqlDbType.Int,
                    Value = workshopId
                });

                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                if (ds != null && ds.Tables.Count == 2)
                {
                    List<string> xAxis = new List<string>();
                    List<string> legend = new List<string>();
                    List<ProductionDataUPHInfo> datas = new List<ProductionDataUPHInfo>();
                    List<ProductionDataUPHInfo> singleDatas = new List<ProductionDataUPHInfo>();
                    List<List<ProductionDataUPHInfo>> series = new List<List<ProductionDataUPHInfo>>();

                    foreach (DataRow r in ds.Tables[1].Rows)
                    {
                        datas.Add(new ProductionDataUPHInfo()
                        {
                            TimePoint = r["TimePoint"].ToString(),
                            ItemId = DisInt(r["ItemId"]),
                            ItemCode = r["ItemCode"].ToString(),
                            ItemName = r["ItemName"].ToString(),
                            Surface = r["Surface"].ToString(),
                            SumOutput = DisInt(r["SumOutput"]),
                            Defects = DisInt(r["Defects"]),
                            StandardCapacity = DisInt(r["StandardCapacity"])
                        });
                    }

                    /*筛选唯一(产品+面别)*/
                    var querySingle = from a in datas
                                      group a by new { a.ItemId, a.Surface } into b
                                      select new
                                      {
                                          ItemId = b.Key.ItemId,
                                          ItemName = b.Min(p => p.ItemName),
                                          Surface = b.Key.Surface
                                      };
                    foreach (var q in querySingle)
                    {
                        legend.Add(q.ItemName);
                    }

                    //找到唯一的数据(机型+板面)
                    //var dataGroups = datas.GroupBy(d => new { d.ItemCode, d.Surface });
                    //foreach (var item in dataGroups)
                    //{
                    //    foreach (var ic in item)
                    //    {
                    //        singleDatas.Add(ic);
                    //        legend.Add(ic.ItemCode);
                    //        break;
                    //    }
                    //}

                    foreach (DataRow tp in ds.Tables[0].Rows)
                    {
                        var timePointDatas = new List<ProductionDataUPHInfo>();

                        /*计算x坐标值*/
                        xAxis.Add(tp["TimePoint"].ToString().TrimStart('0'));

                        /*填充时间段对应的机型计划产能*/
                        foreach (var q in querySingle)
                        {
                            //每一个时间段都得对应数据，所以此处必须初始对象。
                            var newTimePoint = new ProductionDataUPHInfo() { ItemId = q.ItemId, ItemName = q.ItemName, Surface = q.Surface };

                            var queryTimePoint = from a in datas
                                                 where a.ItemId == q.ItemId && a.Surface == q.Surface && string.Concat(a.TimePoint.Substring(6, 2), "日",
                                                 a.TimePoint.Substring(8, 2), "时") == tp["TimePoint"].ToString()
                                                 select a;
                            foreach (var timePoint in queryTimePoint)
                            {
                                newTimePoint = timePoint;
                                break;
                            }
                            timePointDatas.Add(newTimePoint);
                        }
                        series.Add(timePointDatas);
                    }
                    t.Axis = xAxis;
                    t.Series = series;
                    t.Legen = legend;
                }
            }
            string jsonStr = JsonConvert.SerializeObject(t);
            context.Response.Write(jsonStr);
        }

        void ProductionTop5NC(int workshopId, HttpContext context)
        {
            KanBanChartInfo t = new KanBanChartInfo();

            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspTop5NC";

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@WorkshopId",
                    SqlDbType = SqlDbType.Int,
                    Value = workshopId
                });

                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }
                if (ds != null && ds.Tables.Count == 1)
                {
                    List<string> xAxis = new List<string>();
                    List<string> series = new List<string>();

                    foreach (DataRow r in ds.Tables[0].Rows)
                    {
                        xAxis.Add(r["NCCode"].ToString());
                        series.Add(r["Total"].ToString());
                    }

                    t.Axis = xAxis;
                    t.Series = series;
                    //t.Legen = legend;
                }
            }
            string jsonStr = JsonConvert.SerializeObject(t);
            context.Response.Write(jsonStr);
        }

        string DisStr(object obj)
        {
            if (obj == null)
                return "-";
            return obj.ToString();
        }

        decimal DisDecimal(object obj)
        {
            if (obj == null)
                return 0;
            try
            {
                return Convert.ToDecimal(obj);
            }
            catch
            {
                return 0;
            }
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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

    internal class ProductionDataInfo
    {
        /// <summary>
        /// 总计划数
        /// </summary>
        public int SumDesigned { get; set; }

        /// <summary>
        /// 总投入数
        /// </summary>
        public int SumInput { get; set; }

        /// <summary>
        /// 总产出数
        /// </summary>
        public int SumOutput { get; set; }

        /// <summary>
        /// 总不良数
        /// </summary>
        public int SumDefects { get; set; }

        /// <summary>
        /// 总生产时间(从投入到产出的花费时间。单位：秒)
        /// </summary>
        public int SumDiffSecond { get; set; }

        /// <summary>
        /// 总瓶颈工时
        /// </summary>
        public decimal SumBottleneckHours { get; set; }

        /// <summary>
        /// 总异常工时
        /// </summary>
        public decimal SumAbnormalTime { get; set; }

        /// <summary>
        /// 总实到人数
        /// </summary>
        public decimal SumActualNumber { get; set; }

        /// <summary>
        /// 白板数(无不良)
        /// </summary>
        public int NoDefects { get; set; }

        /// <summary>
        /// 设备OEE
        /// </summary>
        public decimal OEE { get; set; }
        /// <summary>
        /// 生产进度
        /// </summary>
        public decimal Progress { get; set; }
        /// <summary>
        /// UPPH人均时产能
        /// </summary>
        public decimal UPPH { get; set; }
        /// <summary>
        /// IE效率
        /// </summary>
        public decimal IEEfficiency { get; set; }
        /// <summary>
        /// 直通率
        /// </summary>
        public decimal FPY { get; set; }

        public List<SMTLineProductionInfo> List { get; set; }
        public KanBanChartInfo Echarts { get; set; }
        /// <summary>
        /// 产出数
        /// </summary>
        public int AllOutput { get; set; }

        /// <summary>
        /// 不良数
        /// </summary>
        public int AllDefects { get; set; }
        /// <summary>
        /// 工单数量
        /// </summary>
        public int SumQtyToBuild { get; set; }
        /// <summary>
        /// 总投入数
        /// </summary>
        public int AllInput { get; set; }
    }

    internal class SMTLineProductionInfo
    {
        /// <summary>
        /// 产线名称
        /// </summary>
        public string LineName { get; set; }

        /// <summary>
        /// 工单号
        /// </summary>
        public string OrderNo { get; set; }

        /// <summary>
        /// 产品编号
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// 面别
        /// </summary>
        public string Surface { get; set; }

        /// <summary>
        /// 计划数
        /// </summary>
        public int Designed { get; set; }

        /// <summary>
        /// 投入数
        /// </summary>
        public int Input { get; set; }

        /// <summary>
        /// 产出数
        /// </summary>
        public int Output { get; set; }

        /// <summary>
        /// 不良数
        /// </summary>
        public int Defects { get; set; }

        /// <summary>
        /// 标准工时
        /// </summary>
        public decimal CycleTime { get; set; }

        /// <summary>
        /// 标准产能
        /// </summary>
        public decimal StandardCapacity { get; set; }

        /// <summary>
        /// 瓶颈工时
        /// </summary>
        public int BottleneckHours { get; set; }

        /// <summary>
        /// 异常工时
        /// </summary>
        public int AbnormalTime { get; set; }

        /// <summary>
        /// 生产花费时间
        /// </summary>
        public int DiffSecond { get; set; }

        /// <summary>
        /// 生产状态
        /// </summary>
        public string Status { get; set; }
        /// <summary>
        /// 客户订单
        /// </summary>
        public string CustomerOrder { get; set; }
        /// <summary>
        /// 产出数
        /// </summary>
        public int AllOutput { get; set; }

        /// <summary>
        /// 不良数
        /// </summary>
        public int AllDefects { get; set; }
        /// <summary>
        /// 工单数量
        /// </summary>
        public int QtyToBuild { get; set; }

        /// <summary>
        /// 总投入数
        /// </summary>
        public int AllInput { get; set; }
    }

    internal class ProductionDataUPHInfo
    {
        public string TimePoint { get; set; }
        public int ItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string Surface { get; set; }
        public int SumOutput { get; set; }
        public int SumDesigned { get; set; }
        public int Defects { get; set; }
        public int StandardCapacity { get; set; }
    }
}