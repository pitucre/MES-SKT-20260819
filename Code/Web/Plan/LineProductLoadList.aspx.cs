using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using Newtonsoft.Json;
using SKT.LeanMES.Plan.BLL;
using SKT.LeanMES.Plan.Model;

namespace SKT.LeanMES.Web.Plan
{
    public partial class LineProductLoadList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof (LineProductLoadList));
            if (!this.IsPostBack)
            {
            }
        }


        /// <summary>
        /// 获取预排天数
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]

        public int GetPreviewDays()
        {
            int dayNum = 7;
            try
            {
                SKT.LeanMES.Plan.BLL.PreviewConfig bll = new SKT.LeanMES.Plan.BLL.PreviewConfig();
                PreviewConfigInfo result = bll.GetInfo();
                dayNum = result.PreviewDay;
            }
            catch (Exception)
            {
                
            }


            return dayNum;
        }

        /// <summary>
        /// 获取待排产工单信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public LineProductLoadResut GetLineSchedulLoadList(string lineName,string dayTime)
        {
            LineProductLoadResut result = new LineProductLoadResut();
            List<LineProductLoadInfo> lineProductLoadInfos = new List<LineProductLoadInfo>(); //待排产工单列表
            DataTable table = new DataTable();
            List<string> xAxis = new List<string>();
            List<string> legend = new List<string>();
            List<List<LineProductLoadInfo>> series = new List<List<LineProductLoadInfo>>();
            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.MESConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspGetLineSchedulLoadList";
                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@LineName",
                    SqlDbType = SqlDbType.VarChar,
                    Value = lineName
                });

                sqlcom.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@DayTime",
                    SqlDbType = SqlDbType.VarChar,
                    Value = dayTime
                });
                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }
              
                if (ds != null && ds.Tables.Count == 3)
                {
                    table = ds.Tables[0];
                    
                    foreach (DataRow row in ds.Tables[1].Rows)
                    {
                        lineProductLoadInfos.Add(new LineProductLoadInfo()
                        {
                            LineName = row["LineName"].ToString(),
                            DayTime = row["DayTime"].ToString(),
                            LineLoad = Convert.ToDecimal(row["LineLoad"])
                         
                        });
                    }
                    var query = from p in lineProductLoadInfos
                        group p by new {p.LineName}
                        into b
                        select new
                        {
                            LineName = b.Key.LineName
                        };

                    foreach (var q in query)
                    {
                        legend.Add(q.LineName);
                    }

                    foreach (DataRow row in ds.Tables[2].Rows)
                    {
                        var datas = new List<LineProductLoadInfo>();
                        xAxis.Add(row["DayTime"].ToString());
                        /*填充时间段对应的机型计划产能*/
                        foreach (var q in query)
                        {
                            //每一个时间段都得对应数据，所以此处必须初始对象。
                            var newTimePoint = new LineProductLoadInfo() { LineName = q.LineName,LineLoad = 0,DayTime = row["DayTime"].ToString() };

                            var queryTimePoint = from a in lineProductLoadInfos
                                                 where a.LineName == q.LineName && a.DayTime == row["DayTime"].ToString()
                                                 select a;
                            foreach (var timePoint in queryTimePoint)
                            {
                                newTimePoint = timePoint;
                                break;
                            }
                            datas.Add(newTimePoint);
                        }
                        series.Add(datas);
                    }
                }
                result.Table = table;
                result.Legend = legend;
                result.XAxis = xAxis;
                result.Series = series;
                sqlcon.Close();
            }
            return result;
        }

       

        /// <summary>
        /// 排产工单实体类
        /// </summary>
        [Serializable]
        public class LineProductLoadResut
        {
            /// <summary>
            /// 表集合
            /// </summary>
            public System.Data.DataTable Table { get; set; }
           public List<string> Legend { get; set; }
            public List<string> XAxis { get; set; }

            public object Series { get; set; }

        }



        /// <summary>
        /// 线别实体类
        /// </summary>
        [Serializable]
        public class LineProductLoadInfo
        {
            /// <summary>
            /// 线别负荷
            /// </summary>
            public decimal LineLoad { get; set; }
            /// <summary>
            /// 
            /// </summary>
            public string DayTime { get; set; }

            /// <summary>
            /// 
            /// </summary>
            public string LineName { get; set; }


        }

    }
}