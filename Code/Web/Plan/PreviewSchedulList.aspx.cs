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
    public partial class PreviewSchedulList : BasePage
    {
        public int DayNum = 7;  //预排天数
        public int IsLine = 0;  //是否以线优先 0=不是 1=是
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof (PreviewSchedulList));
            if (!this.IsPostBack)
            {
                SKT.LeanMES.Plan.BLL.PreviewConfig bll = new SKT.LeanMES.Plan.BLL.PreviewConfig();
                PreviewConfigInfo result=bll.GetInfo();
                if (result != null)
                {
                    DayNum = result.PreviewDay;
                    IsLine = result.IsLine;

                }
                else
                {
                    DayNum = 7;
                    IsLine = 0;
                }
             
                //Session["LineSchedulCalendarList"] =bll.GetAllList();
            }
        }

        /// <summary>
        /// 获取待排产工单信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<SchedulingOrderInfo> GetSchedulingOrderList()
        {
            List<SchedulingOrderInfo> result = new List<SchedulingOrderInfo>(); //待排产工单列表
            List<SchedulingLineInfo> schedulingLineList = new List<SchedulingLineInfo>();  //资源绑定列表
            using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.MESConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "uspGetSchedulingList";

                DataSet ds = new DataSet();
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                if (ds != null && ds.Tables.Count == 2)
                {

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        result.Add(new SchedulingOrderInfo()
                        {
                            TableName = row["TableName"].ToString(),
                            OrderNo = row["OrderNo"].ToString(),
                            ItemId = Convert.ToInt32(row["ItemId"]),
                            OrderNum = Convert.ToInt32(row["Qty_to_Build"]),
                            ProdOrderID= Convert.ToInt32(row["ProdOrderID"]),
                            AlreadySchedulingNum = Convert.ToInt32(row["AlreadySchedulingNum"]),
                            
                        });
                    }

                    foreach (DataRow row in ds.Tables[1].Rows)
                    {
                        schedulingLineList.Add(new SchedulingLineInfo()
                        {
                            LineName = row["LineName"].ToString(),
                            LineId = Convert.ToInt32(row["LineId"]),
                            ResName = row["ResName"].ToString(),
                            ResourceId = Convert.ToInt32(row["ResourceId"]),
                            CapacityUnit = row["CapacityUnit"].ToString(),
                            ItemId = Convert.ToInt32(row["ItemId"]),
                            Capacity = Convert.ToInt32(row["Capacity"]),
                            Id = Convert.ToInt32(row["Id"]),
                            TableName = row["Face"].ToString(),
                        });
                    }
                    Session["SchedulingLine"] = schedulingLineList;
                }

                sqlcon.Close();
            }
            return result;
        }


        /// <summary>
        /// 根据产品与面别获取资源列表信息
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="tableName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SchedulingLineInfo> GetSchedulingLine(int itemId, string tableName)
        {
            List<SchedulingLineInfo> result = new List<SchedulingLineInfo>();
            if (Session["SchedulingLine"] != null)
            {
                result = Session["SchedulingLine"] as List<SchedulingLineInfo>;
                result = result.Where(a => a.ItemId == itemId && a.TableName == tableName).ToList();

            }
            return result;
        }

        /// <summary>
        /// 获取所有线别工作日历时长
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<PreviewSchedulModel> GetLineSchedulingWorkTimeList()
        {
            PreviewSchedulDal bll = new PreviewSchedulDal();
            return bll.GetAllList();
            
        }
        /// <summary>
        /// 获取车间线别工作日时长
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<WorkShopLineHourInfo> GetWorkShopLineWorkHourList()
        {
            PreviewSchedulDal bll = new PreviewSchedulDal();
            return bll.GetWorkShopLineWorkHourList();

        }

        

        /// <summary>
        /// 获取已排工单列表信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<PreviewSchedulRecordInfo> GetSchedulingList()
        {
            PreviewSchedulDal bll = new PreviewSchedulDal();
            return bll.GetPreviewSchedulRecordList();

        }
        /// <summary>
        /// 生成排产计划
        /// </summary>
        /// <param name="json"></param>
        /// <param name="days"></param>
        [AjaxMethod]
        public void CreateSchedulPlan(string json,int days)
        {
            var result = JsonConvert.DeserializeObject<List<SchedulPlanInfo>>(json);
            System.Text.StringBuilder strBuilder = new System.Text.StringBuilder();
            if (result != null && result.Count > 0)
            {
                strBuilder.Append("<Root>");
                for (int i = 0; i < result.Count; i++)
                {
                    strBuilder.Append("<ProdPlan ");
                    strBuilder.Append(" ProdOrderId =\"" + result [i].ProdOrderId+ "\"");
                    strBuilder.Append(" ResourceId =\"" + result[i].ResourceId + "\"");
                    strBuilder.Append(" TableName =\"" + result[i].TableName + "\"");
                    strBuilder.Append(" DayCapacityList =\"" + result[i].DayCapacityList + "\"");
                    strBuilder.Append(" ></ProdPlan>");
                }
                strBuilder.Append("</Root>");
            }
            try
            {
                SchedulOrderDal bll = new SchedulOrderDal();
                bll.CreateSchedulPlan(strBuilder.ToString(), AccountController.GetCurrentUserInfo().UserName, days);
            }
            catch (Exception ex)
            {
                
                throw;
            }
           

        }


        /// <summary>
        /// 排产工单实体类
        /// </summary>
        [Serializable]
        public class SchedulingOrderInfo
        {
            public string OrderNo { get; set; }

            /// <summary>
            /// 工单数量
            /// </summary>
            public int OrderNum { get; set; }

            /// <summary>
            /// 生产面别
            /// </summary>
            public string TableName { get; set; }

            /// <summary>
            /// 已排产数量
            /// </summary>
            public int AlreadySchedulingNum { get; set; }

            /// <summary>
            /// 产品ID
            /// </summary>
            public int ItemId { get; set; }

            /// <summary>
            /// 工单ID
            /// </summary>
            public int ProdOrderID { get; set; }
            
        }

        /// <summary>
        /// 排产线别实体类
        /// </summary>
        [Serializable]
        public class SchedulingLineInfo
        {
            /// <summary>
            /// 线别Id
            /// </summary>
            public int LineId { get; set; }
            /// <summary>
            /// 线别名称
            /// </summary>
            public string LineName { get; set; }

            /// <summary>
            /// 资源Id
            /// </summary>
            public int ResourceId { get; set; }

            /// <summary>
            /// 资源名称
            /// </summary>
            public string ResName { get; set; }

            /// <summary>
            /// 生产面别
            /// </summary>
            public string TableName { get; set; }


            public int ItemId { get; set; }

            /// <summary>
            /// 产能
            /// </summary>
            public int Capacity { get; set; }

            /// <summary>
            /// 产能单位(分、时、天)
            /// </summary>
            public string CapacityUnit { get; set; }

            /// <summary>
            /// 产品负荷ID
            /// </summary>
            public int Id { get; set; }
        }

        public class SchedulPlanInfo
        {
            public int LineId { get; set; }
            public int ProdOrderId { get; set; }

            public int ResourceId { get; set; }
            /// <summary>
            /// 工单
            /// </summary>
            public string OrderNo { get; set; }

            public string DayCapacityList { get; set; }
            public string TableName { get; set; }




        }
    }
}