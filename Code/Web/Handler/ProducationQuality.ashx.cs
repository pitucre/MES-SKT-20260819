using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.ProductionCollection.Model;
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
    /// ProducationQuality 的摘要说明
    /// </summary>
    public class ProducationQuality : IHttpHandler , IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            context.Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            context.Response.ContentType = "text/plain";

            string type = context.Request["Type"];
            int workshopId = context.Request["WorkshopId"] == null ? -1 : Convert.ToInt32(context.Request["WorkshopId"]);
            string itemCode = "";
            if (type == "SearchOQC")
            {
                GetQuanlityResult(-1, -1, 1, context, itemCode, workshopId);
            }
            else if (type == "NcQuanlity")
            {
                GetNcQtyQuanlity(-1, -1, 2, context, itemCode, workshopId);
            }
            else if (type == "NCQty")
            {
                GetNCQty(-1, -1, 3, context, itemCode, workshopId);
            }
            else if (type == "NCPassTime")
            {
                GetNCDateTime(-1, -1, 4, context, itemCode, workshopId);
            }
            else if (type == "NCPassItemCode")
            {
                GetNCItemCode(-1, -1, 6, context, itemCode, workshopId);
            }
            else if (type == "NCPassPer")
            {
                itemCode = context.Request["ItemCode"];
                GetNCItemPassPer(-1, -1, 5, context, itemCode, workshopId);
            }
        }

        //查询最近一周的OQC检验数据
        public void GetQuanlityResult(int lineId, int ItemId, int searchType, HttpContext context, string itemCode, int workshopId)
        {
            List<ProductionOQCInfo> list = new List<ProductionOQCInfo>();
            ProductionOQCInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@LineId",SqlDbType.Int),
                  new SqlParameter("@ItemId",SqlDbType.Int),
                  new SqlParameter("@SearchType",SqlDbType.Int),
                  new SqlParameter("@ItemCode",SqlDbType.VarChar,100),
                  new SqlParameter("@WorkshopId", SqlDbType.Int) { Value = workshopId },
            };
            parms[0].Value = lineId;
            parms[1].Value = ItemId;
            parms[2].Value = searchType;
            parms[3].Value = itemCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspProducationQuality", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProductionOQCInfo();
                    entity.RowID = Convert.ToInt32(rdr["ID"]);
                    entity.LineName = rdr["LineName"].ToString();
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.ItemName = rdr["ItemName"].ToString();
                    entity.LotNo = rdr["LotNo"].ToString();
                    entity.SendQty = Convert.ToInt32(rdr["SendQty"]);
                    entity.NcQty = Convert.ToInt32(rdr["NcQty"]);
                    entity.CheckResult = rdr["CheckResult"].ToString();
                    entity.CheckTime = rdr["CheckTime"].ToString();
                    entity.SamplingQty = Convert.ToInt32(rdr["SamplingQty"]);

                    list.Add(entity);
                }

                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }

        //查询最近一周的不良率
        public void GetNcQtyQuanlity(int lineId, int ItemId, int searchType, HttpContext context, string itemCode, int workshopId)
        {
            List<ProductionNCInfo> list = new List<ProductionNCInfo>();
            ProductionNCInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@LineId",SqlDbType.Int),
                  new SqlParameter("@ItemId",SqlDbType.Int),
                  new SqlParameter("@SearchType",SqlDbType.Int),
                  new SqlParameter("@ItemCode",SqlDbType.VarChar,100),
                  new SqlParameter("@WorkshopId", SqlDbType.Int) { Value = workshopId },
            };
            parms[0].Value = lineId;
            parms[1].Value = ItemId;
            parms[2].Value = searchType;
            parms[3].Value = itemCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspProducationQuality", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProductionNCInfo();
                    entity.NCCode = rdr["NCCode"].ToString();
                    entity.NCDesc = rdr["Description"].ToString();
                    entity.NcQty = Convert.ToInt32(rdr["NcQty"]);
                    list.Add(entity);
                }

                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }

        //查询最近一周的不良数量
        public void GetNCQty(int lineId, int ItemId, int searchType, HttpContext context, string itemCode, int workshopId)
        {
            List<ProductionNCInfo> list = new List<ProductionNCInfo>();
            ProductionNCInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@LineId",SqlDbType.Int),
                  new SqlParameter("@ItemId",SqlDbType.Int),
                  new SqlParameter("@SearchType",SqlDbType.Int),
                  new SqlParameter("@ItemCode",SqlDbType.VarChar,100),
                  new SqlParameter("@WorkshopId", SqlDbType.Int) { Value = workshopId },
            };
            parms[0].Value = lineId;
            parms[1].Value = ItemId;
            parms[2].Value = searchType;
            parms[3].Value = itemCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspProducationQuality", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProductionNCInfo();
                    entity.DataTime = rdr["DataTime"].ToString();
                    entity.NcQty = Convert.ToInt32(rdr["NcQty"]);
                    list.Add(entity);
                }

                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }

        //查询最近一周的允收日期
        public void GetNCDateTime(int lineId, int ItemId, int searchType, HttpContext context, string itemCode, int workshopId)
        {
            List<ProductionNCInfo> list = new List<ProductionNCInfo>();
            ProductionNCInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@LineId",SqlDbType.Int),
                  new SqlParameter("@ItemId",SqlDbType.Int),
                  new SqlParameter("@SearchType",SqlDbType.Int),
                  new SqlParameter("@ItemCode",SqlDbType.VarChar,100),
                  new SqlParameter("@WorkshopId", SqlDbType.Int) { Value = workshopId },
            };
            parms[0].Value = lineId;
            parms[1].Value = ItemId;
            parms[2].Value = searchType;
            parms[3].Value = itemCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspProducationQuality", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProductionNCInfo();
                    entity.DataTime = rdr["DataTime"].ToString();
                    list.Add(entity);
                }

                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }

        //查询最近一周的允收机种
        public void GetNCItemCode(int lineId, int ItemId, int searchType, HttpContext context, string itemCode, int workshopId)
        {
            List<ProductionNCInfo> list = new List<ProductionNCInfo>();
            ProductionNCInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@LineId",SqlDbType.Int),
                  new SqlParameter("@ItemId",SqlDbType.Int),
                  new SqlParameter("@SearchType",SqlDbType.Int),
                  new SqlParameter("@ItemCode",SqlDbType.VarChar,100),
                  new SqlParameter("@WorkshopId", SqlDbType.Int) { Value = workshopId },
            };
            parms[0].Value = lineId;
            parms[1].Value = ItemId;
            parms[2].Value = searchType;
            parms[3].Value = itemCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspProducationQuality", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProductionNCInfo();
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    list.Add(entity);
                }

                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }

        //查询最近一周的允收机种率
        public void GetNCItemPassPer(int lineId, int ItemId, int searchType, HttpContext context, string itemCode, int workshopId)
        {
            List<ProductionNCInfo> list = new List<ProductionNCInfo>();
            ProductionNCInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@LineId",SqlDbType.Int),
                  new SqlParameter("@ItemId",SqlDbType.Int),
                  new SqlParameter("@SearchType",SqlDbType.Int),
                  new SqlParameter("@ItemCode",SqlDbType.VarChar,100),
                  new SqlParameter("@WorkshopId", SqlDbType.Int) { Value = workshopId },
            };
            parms[0].Value = lineId;
            parms[1].Value = ItemId;
            parms[2].Value = searchType;
            parms[3].Value = itemCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspProducationQuality", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProductionNCInfo();
                    entity.PassPer = Convert.ToInt32(rdr["PassPer"]);
                    list.Add(entity);
                }

                rdr.Close();
            }
            //序列化
            string jsonStr = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonStr);
        }
        //不良率
        internal class ProductionNCInfo
        {
            public string NCCode { get; set; }
            public string NCDesc { get; set; }
            public int NcQty { get; set; }

            public string DataTime { get; set; }
            public string ItemCode { get; set; }
            public int PassPer { get; set; }
        }

        //品质报表上面信息
        internal class ProductionOQCInfo
        {
            public int RowID { get; set; }
            public string LineName { get; set; }
            public string ItemCode { get; set; }
            public string ItemName { get; set; }
            public string LotNo { get; set; }
            public int SendQty { get; set; }
            public int NcQty { get; set; }
            public string CheckResult { get; set; }
            public string CheckTime { get; set; }

            /// <summary>
            /// 抽检数量
            /// </summary>
            public int SamplingQty { get; set; }
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