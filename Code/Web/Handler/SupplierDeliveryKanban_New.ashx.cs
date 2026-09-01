using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// SupplierDeliveryKanban 的摘要说明
    /// </summary>
    public class SupplierDeliveryKanban : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            context.Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            context.Response.ContentType = "text/plain";
            string type = context.Request["Type"];
            if (type == "SupplierDelivery")
            {
                GetSupplierDeliveryList(context);
            }
            else if (type == "GetDeliveryData")
            {
                GetDeliveryData(context);
            }
            else if (type == "GetSummaryInfo")
            {
                GetSummaryInfo(context);
            }
            context.Response.Flush();
            context.Response.End();
        }
        //查询所有供应商送货列表
        public void GetSupplierDeliveryList(HttpContext context)
        {
            List<SupplierDeliveryInfo> list = new List<SupplierDeliveryInfo>();
            SupplierDeliveryInfo entity = null;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetSupplierDeliveryList_New"))
            {
                while (rdr.Read())
                {
                    entity = new SupplierDeliveryInfo();
                    entity.RowId = Convert.ToInt32(rdr["ID"]);
                    entity.POCode = rdr["POCode"].ToString();
                    entity.DeliverNo = rdr["DeliverNo"].ToString();
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.ItemName = rdr["ItemName"].ToString();
                    entity.SentQty = rdr["SentQty"].ToString();
                    entity.CreateDateTime = rdr["CreateDateTime"].ToString();
                    entity.DeliState = rdr["DeliState"].ToString();
                    entity.VendorName = rdr["VendorName"].ToString();
                    entity.ImportState = rdr["ImportState"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }

        //供应商实际到货数与计划数
        public void GetDeliveryData(HttpContext context)
        {
            List<DeliveryInfo> list = new List<DeliveryInfo>();
            DeliveryInfo entity = new DeliveryInfo();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetDeliveryData_New"))
            {
                while (rdr.Read())
                {
                    entity = new DeliveryInfo();
                    entity.SupplierName = rdr["SupplierName"].ToString();
                    entity.ActualQty = rdr["ActualQty"].ToString();
                    entity.PlanQty = rdr["PlanQty"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }

        //供应商实际到货数与计划数
        internal class DeliveryInfo
        {
            /// <summary>
            /// 供应商
            /// </summary>
            public string SupplierName { get; set; }

            /// <summary>
            /// 实际数
            /// </summary>
            public string ActualQty { get; set; }

            /// <summary>
            /// 计划数
            /// </summary>
            public string PlanQty { get; set; }

        }

        //查询供应商的统计数据
        public void GetSummaryInfo(HttpContext context)
        {

            SummaryInfo entity = new SummaryInfo();

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetSummaryInfo_New"))
            {
                while (rdr.Read())
                {
                    entity = new SummaryInfo();
                    entity.PlanQty = rdr["PlanQty"].ToString();
                    entity.ItemCount = rdr["ItemCount"].ToString();
                    entity.ActualQtyTotal = rdr["ActualQtyTotal"].ToString();
                    entity.ActualItemCount = rdr["ActualItemCount"].ToString();
                    entity.ArrivalRate = Convert.ToDecimal(rdr["ArrivalRate"]);
                }

                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(entity);
            context.Response.Write(jsonStr);
        }

        //供应商送货列表实体
        internal class SupplierDeliveryInfo
        {
            public int RowId { get; set; }
            public string POCode { get; set; }
            public string DeliverNo { get; set; }
            public string ItemCode { get; set; }
            public string ItemName { get; set; }
            public string SentQty { get; set; }
            public string CreateDateTime { get; set; }
            public string DeliState { get; set; }
            public string VendorName { get; set; }

            public string ImportState { get; set; }
        }

        internal class SummaryInfo
        {
            /// <summary>
            /// 当天计划数量
            /// </summary
            public string PlanQty { get; set; }

            /// <summary>
            /// 当天计划项次
            /// </summary>
            public string ItemCount { get; set; }

            /// <summary>
            /// 实际到货数量
            /// </summary>
            public string ActualQtyTotal { get; set; }

            /// <summary>
            /// 实际到货项次
            /// </summary>
            public string ActualItemCount { get; set; }

            /// <summary>
            /// 到货率(项次)
            /// </summary>
            public decimal ArrivalRate { get; set; }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}