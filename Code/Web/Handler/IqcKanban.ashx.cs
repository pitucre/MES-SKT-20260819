using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// IqcKanban 的摘要说明
    /// </summary>
    public class IqcKanban : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            SqlInjectableHelper.Validation(context);


            context.Response.ContentType = "text/plain";
            string type = context.Request["Type"];
            if (type == "SearchIQC")
            {
                GetChekckResultList(context);
            }
            else if (type == "GetTop5Supplier")
            {
                GetTop5Supplier(context);
            }
            else if (type == "GetCheckOutInfo")
            {
                GetCheckOutInfo(context);
            }
            else if (type == "GetItemNc")
            {
                GetItemNc(context);
            }
            context.Response.Flush();
            context.Response.End();
        }
        //查询所有待检验列表
        public void GetChekckResultList(HttpContext context)
        {
            List<IqcChekckOutInfo> list = new List<IqcChekckOutInfo>();
            IqcChekckOutInfo entity = null;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetCheckOutList"))
            {
                while (rdr.Read())
                {
                    entity = new IqcChekckOutInfo();
                    entity.RowId = Convert.ToInt32(rdr["ID"]);
                    entity.InspectionNo = rdr["InspectionNo"].ToString();
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.ItemName = rdr["ItemName"].ToString();
                    entity.InspectionQty = rdr["InspectionQty"].ToString();
                    entity.UrgentLevel = Convert.ToInt32(rdr["UrgentLevel"]);
                    entity.UrgentName = Convert.ToString(rdr["UrgentName"]);
                    entity.CreateDateTime = rdr["CreateDateTime"].ToString();
                    entity.VendorSort = rdr["VendorSort"].ToString();
                    entity.CheckOutHours = rdr["CheckOutHours"].ToString();
                    entity.ReciveTime = rdr["ReciveTime"].ToString(); 
                    list.Add(entity);
                }
                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }

        //查询最近一周的Top5不良供应商
        public void GetTop5Supplier(HttpContext context)
        {
            List<Top5SupplierInfo> list = new List<Top5SupplierInfo>();
            Top5SupplierInfo entity = null;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetTop5NcSupplier"))
            {
                while (rdr.Read())
                {
                    entity = new Top5SupplierInfo();
                    entity.VendorSort = rdr["VendorSort"].ToString();
                    entity.ActualQty = rdr["ActualQty"].ToString();
                    entity.NCQty = rdr["NCQty"].ToString();
                    list.Add(entity);
                }

                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }

        //查询最近一周的不良数量
        public void GetCheckOutInfo(HttpContext context)
        {
           
            CheckOutInfo entity = new CheckOutInfo();

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetCheckOutInfo"))
            {
                while (rdr.Read())
                {
                    entity = new CheckOutInfo();
                    entity.DjCount = rdr["DjCount"].ToString();
                    entity.JlCount = rdr["JlCount"].ToString();
                    entity.CheckCount = rdr["CheckCount"].ToString();
                    entity.CheckTotal = rdr["CheckTotal"].ToString();
                    entity.Ncpercentage = Convert.ToDecimal(rdr["Ncpercentage"]);
                        entity.ReciveCount = Convert.ToInt32(rdr["ReciveCount"]);
                }

                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(entity);
            context.Response.Write(jsonStr);
        }


        //查询最近一周的不良数量
        public void GetItemNc(HttpContext context)
        {
            List<ItemNcInfo> list = new List<ItemNcInfo>();
            ItemNcInfo entity = new ItemNcInfo();

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetItemNc"))
            {
                while (rdr.Read())
                {
                    entity = new ItemNcInfo();
                    entity.InspectionItemName = rdr["InspectionItemName"].ToString();
                    entity.SumNc = rdr["SumNc"].ToString();
                    list.Add(entity);

                }

                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }

        






        //待检验信息实体
        internal class IqcChekckOutInfo
        {
            public int RowId { get; set; }
            public string InspectionNo { get; set; }
            public string ItemCode { get; set; }
            public string ItemName { get; set; }
            public string InspectionQty { get; set; }
            public string VendorSort { get; set; }
            public int UrgentLevel { get; set; }
            public string UrgentName { get; set; }
            public string CreateDateTime { get; set; }
            public string CheckOutHours { get; set; }

            public string ReciveTime { get; set; }
        }

        internal class Top5SupplierInfo
        {
            public string VendorSort { get; set; }
            /// <summary>
            /// 统计检验总数
            /// </summary>
            public string ActualQty { get; set; }
            /// <summary>
            /// 统计检验不良数
            /// </summary>
            public string NCQty { get; set; }

        }


        internal class ItemNcInfo
        {
            public string InspectionItemName { get; set; }
   
            /// <summary>
            /// 统计不良数
            /// </summary>
            public string SumNc { get; set; }

        }

        internal class CheckOutInfo
        {
            /// <summary>
            /// 总待检验数量
            /// </summary
            public string DjCount { get; set; }

            /// <summary>
            /// 急料待检数量
            /// </summary>
            public string JlCount { get; set; }

            /// <summary>
            /// 当天总检验数量
            /// </summary>
            public string CheckCount { get; set; }

            /// <summary>
            /// 当天总检验笔数
            /// </summary>
            public string CheckTotal { get; set; }

            /// <summary>
            /// 不良率占比
            /// </summary>
            public decimal Ncpercentage { get; set; }

            /// <summary>
            /// 已接收笔数
            /// </summary>
            public int ReciveCount { get; set; }
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