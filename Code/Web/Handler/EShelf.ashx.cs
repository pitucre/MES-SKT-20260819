using log4net;
using Newtonsoft.Json;
using SKT.LeanMES.Warehouse.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// 电子货架服务
    /// </summary>
    public class EShelf : IHttpHandler
    {
        private ILog _logger = LogManager.GetLogger(typeof(EShelf));

        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            context.Response.ContentType = "text/plain;charset=utf-8";
            string cmd = context.Request["cmd"];
            switch (cmd)
            {
                case "MAES_Request":
                    MAES_Request(context);
                    break;

                case "SYT_LightUpCellLed":
                    SYT_LightUpCellLed(context);
                    break;
                case "SYT_LightUpCellLedList":
                    SYT_LightUpCellLedList(context);
                    break;

                case "RW_MaterialIn":
                    RW_MaterialIn(context);
                    break;
                case "RW_MaterialTake":
                    RW_MaterialTake(context);
                    break;
                case "RW_MaterialTakeCancel":
                    RW_MaterialTakeCancel(context);
                    break;
                case "RW_CancelWarning":
                    RW_CancelWarning(context);
                    break;
                case "RW_WareHouseLocationSync":
                    RW_WareHouseLocationSync(context);
                    break;
                    
                case "Log":
                    Log(context);
                    break;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        #region 私有方法

        #region MAES电子货架SDK

        /// <summary>
        ///  MAES电子货架服务
        /// </summary>
        /// <param name="context"></param>
        private void MAES_Request(HttpContext context)
        {
            //解析数据
            string jsonData = null;
            using (StreamReader sr = new StreamReader(context.Request.InputStream, Encoding.UTF8))
            {
                jsonData = sr.ReadToEnd();
            }
            //请求地址
            string url = System.Configuration.ConfigurationManager.AppSettings["EShelfAPIUrl"];
            if (string.IsNullOrWhiteSpace(url))
            {
                throw new Exception("请配置webconfig的EShelfAPIUrl");
            }
            //请求头部
            string authorizedUser = System.Configuration.ConfigurationManager.AppSettings["EShelf_MAES_AuthorizedUser"];
            if (string.IsNullOrWhiteSpace(authorizedUser))
            {
                throw new Exception("请配置webconfig的EShelf_MAES_AuthorizedUser");
            }
            Dictionary<string, string> dicHeader = new Dictionary<string, string>();
            dicHeader.Add("Authorization", Base64Encrypt(authorizedUser));
            //发送请求
            string result = DoRequest(url, "POST", jsonData, dicHeader);
            //输出响应
            context.Response.Write(result);
            context.Response.End();
        }

        #endregion

        #region 实益通电子货架SDK

        /// <summary>
        ///  点亮指定储位灯
        /// </summary>
        /// <param name="context"></param>
        private void SYT_LightUpCellLed(HttpContext context)
        {
            //解析数据
            string jsonData = null;
            using (StreamReader sr = new StreamReader(context.Request.InputStream, Encoding.UTF8))
            {
                jsonData = sr.ReadToEnd();
            }
            //请求地址
            string url = System.Configuration.ConfigurationManager.AppSettings["EShelfAPIUrl"];
            if (string.IsNullOrWhiteSpace(url))
            {
                throw new Exception("请配置webconfig的EShelfAPIUrl");
            }
            url += "/api/RackCellMgr/LightUpCellLed";
            //发送请求
            string result = DoRequest(url, "POST", jsonData, null);
            //输出响应
            context.Response.Write(result);
            context.Response.End();
        }

        /// <summary>
        ///  批量点亮指定储位灯
        /// </summary>
        /// <param name="context"></param>
        private void SYT_LightUpCellLedList(HttpContext context)
        {
            //解析数据
            string jsonData = null;
            using (StreamReader sr = new StreamReader(context.Request.InputStream, Encoding.UTF8))
            {
                jsonData = sr.ReadToEnd();
            }
            //请求地址
            string url = System.Configuration.ConfigurationManager.AppSettings["EShelfAPIUrl"];
            if (string.IsNullOrWhiteSpace(url))
            {
                throw new Exception("请配置webconfig的EShelfAPIUrl");
            }
            url += "/api/RackCellMgr/LightUpCellLedList";
            //发送请求
            string result = DoRequest(url, "POST", jsonData, null);
            //输出响应
            context.Response.Write(result);
            context.Response.End();
        }

        #endregion

        #region 瑞微感应式电子货架

        /// <summary>
        ///  同步料架库位信息 
        /// </summary>
        /// <param name="context"></param>
        private void RW_WareHouseLocationSync(HttpContext context)
        {
            ResponseInfo<List<WarehouseLocationInfo>> res = new ResponseInfo<List<WarehouseLocationInfo>>();
            res.status = 0;
            //解析数据
            string shelfID = context.Request["shelfID"].ToString();
            string whCode = context.Request["whCode"].ToString();
            string userName = context.Request["userName"].ToString();
            try
            {
                if (string.IsNullOrWhiteSpace(shelfID)|| string.IsNullOrWhiteSpace(whCode))
                {
                    throw new Exception("料架/仓库信息传输不完整！");
                    return;
                }

                //调用料架接口

                //请求地址
                string url = System.Configuration.ConfigurationManager.AppSettings["EShelfAPIUrl"];
                if (string.IsNullOrWhiteSpace(url))
                {
                    throw new Exception("请配置webconfig的EShelfAPIUrl");
                }
                url += "/api/shelf_location";

                //发送请求
                var data = new { shelf_id = shelfID };
                string result = DoRequest(url, "POST", JsonConvert.SerializeObject(data), null);

                var dataList = JsonConvert.DeserializeObject<ResponseInfo<List<WarehouseStockInfo>>>(result);

                
                if (dataList.data == null || dataList.data.Count == 0)
                {
                    throw new Exception("未找到电子料架库位信息");
                    return;
                }

                if (dataList.status!=0)
                {
                    throw new Exception(dataList.msg);
                }                

                var dataInfo = dataList.data[0];

                if (dataInfo.position_info == null || dataInfo.position_info.Count == 0)
                {
                    throw new Exception("未找到电子料架库位信息");
                    return;
                }

                DataTable dt = new DataTable() ;
                dt.Columns.Add("CWhCode");
                dt.Columns.Add("CStoreCode");
                dt.Columns.Add("CPosCode");
                dt.Columns.Add("CStoreName");
                dt.Columns.Add("CPosName");
                dt.Columns.Add("LocationType");
                dt.Columns.Add("Remark");
                dt.Columns.Add("ProductIsOnly");
                dt.Columns.Add("ShiftCode");
                List<WarehouseLocationInfo> resultList = new List<WarehouseLocationInfo>();
                foreach (var item in dataInfo.position_info)
                {
                    var strArr = item.Split('-');
                    if (strArr.Length==3)
                    {
                        resultList.Add(new WarehouseLocationInfo() {
                            CPosCode= strArr[2],
                            CPosName= strArr[2],
                            CWhCode = whCode,
                            ShiftCode = shelfID,
                            CStoreCode = strArr[0] + "-" + strArr[1],
                            CStoreName = strArr[0] + "-" + strArr[1],
                            LocationType= "电子料架",
                            Remark="",
                            ProductIsOnly=1
                        });
                        DataRow row = dt.NewRow();
                        row["CWhCode"] = whCode;
                        row["CStoreCode"] = strArr[0]+"-"+ strArr[1];
                        row["CPosCode"] = strArr[2];
                        row["CStoreName"] = strArr[0] + "-" + strArr[1];
                        row["CPosName"] = strArr[2];
                        row["LocationType"] = "电子料架";
                        row["Remark"] = "";
                        row["ProductIsOnly"] = 1;
                        row["ShiftCode"] = shelfID;
                        dt.Rows.Add(row);
                    }                   
                }

                //同步料架库位信息
                using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
                {
                    if (sqlcon.State != ConnectionState.Open)
                        sqlcon.Open();

                    SqlCommand sqlcom = new SqlCommand();
                    sqlcom.Connection = sqlcon;
                    sqlcom.CommandType = CommandType.StoredProcedure;
                    sqlcom.CommandText = "uspSaveImportWareLoction_RW";

                    sqlcom.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@WareLocationList",
                        SqlDbType = SqlDbType.Structured,
                        Value = dt
                    });
                    sqlcom.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@UserName",
                        SqlDbType = SqlDbType.NVarChar,
                        Value = userName
                    });
                    sqlcom.ExecuteNonQuery();
                }
                res.data = resultList;
                //输出响应
                context.Response.Write(JsonConvert.SerializeObject( res));
            }
            catch (System.Threading.ThreadAbortException)
            {
                //忽略
            }
            catch (Exception ex)
            {
                res.status = 1;
                res.msg = ex.Message;
                context.Response.Write(res);
            }
        }

        /// <summary>
        ///  上架请求 
        /// </summary>
        /// <param name="context"></param>
        private void RW_MaterialIn(HttpContext context)
        {
            ResponseInfo<WarehouseLocationInfo> res = new ResponseInfo<WarehouseLocationInfo>();
            res.status = 0;
           
            //解析数据
            string grn = context.Request["Grn"].ToString();
            string shelfID = DisStr(context.Request["shelfID"]);
            string userName = DisStr(context.Request["userName"]);
            var step = 0;//运行步骤，如果MES有数据保存，调用料架接口失败，应该删除MES保存的数据
            GrnInfo grnInfo = null;
            try
            {
                if (string.IsNullOrWhiteSpace(grn) || string.IsNullOrWhiteSpace(shelfID))
                {
                    throw new Exception("GRN/料架信息传输不完整！");
                    return;
                }

                //获取GRN信息
                using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
                {
                    if (sqlcon.State != ConnectionState.Open)
                        sqlcon.Open();
                    var sql = @"SELECT u.BalanceQty,i.ItemCode,s.VendorName,u.DateCode,u.LotCode FROM  dbo.Prod_MaterialUnit u INNER JOIN 
                        dbo.Prod_MaterialUnitMember um ON u.MaterialUnitId=um.MaterialUnitId
                        INNER JOIN dbo.Basal_Item i ON um.ItemId=i.ItemID
                        INNER JOIN dbo.Basal_Supplier s ON u.VendorCode=s.VendorCode
                        WHERE u.SerialNumber=@Grn";
                    SqlCommand sqlcom = new SqlCommand();
                    sqlcom.Connection = sqlcon;
                    sqlcom.CommandType = CommandType.Text;
                    sqlcom.CommandText = sql;// "uspSMTLineProduction";

                    sqlcom.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@Grn",
                        SqlDbType = SqlDbType.NVarChar,
                        Value = grn
                    });

                    DataSet ds = new DataSet();
                    using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                    {
                        sda.Fill(ds);
                    }

                    if (ds != null && ds.Tables.Count > 0)
                    {
                        grnInfo = new GrnInfo();
                        grnInfo.reel_id = grn;
                        grnInfo.part_number = DisStr(ds.Tables[0].Rows[0]["ItemCode"]);
                        grnInfo.quantity = DisInt(ds.Tables[0].Rows[0]["BalanceQty"]);
                        grnInfo.vendor = DisStr(ds.Tables[0].Rows[0]["VendorName"]);
                        grnInfo.date_code = DisStr(ds.Tables[0].Rows[0]["DateCode"]);
                        grnInfo.lot_code = DisStr(ds.Tables[0].Rows[0]["LotCode"]);
                        grnInfo.shelf_id = shelfID;
                    }
                }

                if (grnInfo == null)
                {
                    throw new Exception("未找到GRN【" + grn + "】相关信息");
                    return;                    
                }

                //插入上架信息
                using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
                {
                    if (sqlcon.State != ConnectionState.Open)
                        sqlcon.Open();

                    SqlCommand sqlcom = new SqlCommand();
                    sqlcom.Connection = sqlcon;
                    sqlcom.CommandType = CommandType.StoredProcedure;
                    sqlcom.CommandText = "uspWarehouseLocationDetailOperate";

                    sqlcom.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@GRN",
                        SqlDbType = SqlDbType.NVarChar,
                        Value = grn
                    });
                    sqlcom.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@ShelfCode",
                        SqlDbType = SqlDbType.NVarChar,
                        Value = shelfID
                    });
                    sqlcom.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@UserName",
                        SqlDbType = SqlDbType.NVarChar,
                        Value = userName
                    });
                    sqlcom.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@OperateType",
                        SqlDbType = SqlDbType.Int,
                        Value = 0
                    });
                    sqlcom.ExecuteNonQuery();
                }
                step = 1;
                //调用料架接口
                //请求地址
                string url = System.Configuration.ConfigurationManager.AppSettings["EShelfAPIUrl"];
                if (string.IsNullOrWhiteSpace(url))
                {
                    throw new Exception("请配置webconfig的EShelfAPIUrl");
                }
                url += "/api/material_in";
                //发送请求
                string result = DoRequest(url, "POST", JsonConvert.SerializeObject(grnInfo), null);
                res = JsonConvert.DeserializeObject<ResponseInfo<WarehouseLocationInfo>>(result);
                //输出响应
                context.Response.Write(JsonConvert.SerializeObject(res));
            }
            catch (Exception ex)
            {
                //删除MES插入的数据
                if (step==1)
                {
                    using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
                    {
                        if (sqlcon.State != ConnectionState.Open)
                            sqlcon.Open();

                        SqlCommand sqlcom = new SqlCommand();
                        sqlcom.Connection = sqlcon;
                        sqlcom.CommandType = CommandType.Text;
                        sqlcom.CommandText = "delete from Basal_ElectricLoctionDetail where GRN=@GRN";

                        sqlcom.Parameters.Add(new SqlParameter()
                        {
                            ParameterName = "@GRN",
                            SqlDbType = SqlDbType.NVarChar,
                            Value = grn
                        });                        
                        sqlcom.ExecuteNonQuery();
                    }
                }

                res.status = 1;
                res.msg = ex.Message;

                context.Response.Write(JsonConvert.SerializeObject(res));
                context.Response.End();
            }
        }

        /// <summary>
        ///  取料 
        /// </summary>
        /// <param name="context"></param>
        private void RW_MaterialTake(HttpContext context)
        {
            ResponseInfo<object> res = new ResponseInfo<object>();
            res.status = 0;

            int issue_color = DisInt(context.Request["issue_color"]);
            string grns = DisStr(context.Request["grns"]);
            string userName = context.Request["userName"].ToString();

            try
            {
                if (string.IsNullOrWhiteSpace(grns) || issue_color == 0)
                {
                    throw new Exception("GRN/料架颜色信息传输不完整！");
                    return;
                }

                GrnRequestInfo data = null;
                //获取GRN信息
                using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.ReportConnString))
                {
                    if (sqlcon.State != ConnectionState.Open)
                        sqlcon.Open();

                    SqlCommand sqlcom = new SqlCommand();
                    sqlcom.Connection = sqlcon;
                    sqlcom.CommandType = CommandType.StoredProcedure;
                    sqlcom.CommandText = "uspGetGrnInfos";

                    sqlcom.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@Grns",
                        SqlDbType = SqlDbType.NVarChar,
                        Value = grns
                    });

                    DataSet ds = new DataSet();
                    using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                    {
                        sda.Fill(ds);
                    }

                    if (ds != null && ds.Tables.Count > 0)
                    {
                        data = new GrnRequestInfo();
                        data.issue_color = issue_color;
                        data.issue_list = new List<string>();

                        foreach (DataRow r in ds.Tables[0].Rows)
                        {
                            data.issue_list.Add(ds.Tables[0].Rows[0]["GRN"].ToString());
                        }
                        //data.issue_list = new List<issue>();

                        //foreach (DataRow r in ds.Tables[0].Rows)
                        //{
                        //    data.issue_list.Add(new issue()
                        //    {
                        //        reel_id = DisStr(ds.Tables[0].Rows[0]["GRN"]),
                        //        shelf_id = DisStr(ds.Tables[0].Rows[0]["ShelfCode"]),
                        //        position_info = DisStr(ds.Tables[0].Rows[0]["cBarCode"])
                        //    });
                        //}
                    }
                }

                if (data == null)
                {
                    throw new Exception("未找到GRN相关信息");
                    return;
                }

                //调用料架接口
                //请求地址
                string url = System.Configuration.ConfigurationManager.AppSettings["EShelfAPIUrl"];
                if (string.IsNullOrWhiteSpace(url))
                {
                    throw new Exception("请配置webconfig的EShelfAPIUrl");
                }
                url += "/api/push_issue_list";
                //发送请求
                string result = DoRequest(url, "POST", JsonConvert.SerializeObject(data), null);

                res = JsonConvert.DeserializeObject<ResponseInfo<object>>(result);

                //输出响应
                context.Response.Write(JsonConvert.SerializeObject(res));                
            }
            catch (Exception ex)
            {
                res.status = 1;
                res.msg = ex.Message;

                context.Response.Write(JsonConvert.SerializeObject(res));
            }
        }
        /// <summary>
        ///  取消取料 
        /// </summary>
        /// <param name="context"></param>
        private void RW_MaterialTakeCancel(HttpContext context)
        {
            ResponseInfo<WarehouseLocationInfo> res = new ResponseInfo<WarehouseLocationInfo>();
            res.status = 0;
            //解析数据
            string grns = DisStr(context.Request["grns"]);
            string userName = context.Request["userName"].ToString();

            CancelRequestInfo data = new CancelRequestInfo();
            data.recall_list = grns.Split(new string[','], StringSplitOptions.RemoveEmptyEntries).ToList();
            try
            {
                if (string.IsNullOrWhiteSpace(grns))
                {
                    throw new Exception("GRN信息传输不完整");
                    return;
                }

                //请求地址
                string url = System.Configuration.ConfigurationManager.AppSettings["EShelfAPIUrl"];
                if (string.IsNullOrWhiteSpace(url))
                {
                    throw new Exception("请配置webconfig的EShelfAPIUrl");
                }
                url += "/api/cancel_material_light";
                //发送请求
                string result = DoRequest(url, "POST", JsonConvert.SerializeObject(data), null);

                res = JsonConvert.DeserializeObject<ResponseInfo<WarehouseLocationInfo>>(result);

                //输出响应
                context.Response.Write(JsonConvert.SerializeObject(res));                
            }
            catch (Exception ex)
            {
                res.status = 1;
                res.msg = ex.Message;
                context.Response.Write(JsonConvert.SerializeObject(res));                
            }
        }
        /// <summary>
        ///  警报解除 
        /// </summary>
        /// <param name="context"></param>
        private void RW_CancelWarning(HttpContext context)
        {

            ResponseInfo<WarehouseLocationInfo> res = new ResponseInfo<WarehouseLocationInfo>();
            res.status = 0;

            //解析数据
            string shelf_id = DisStr(context.Request["shelf_id"]);
            string userName = context.Request["userName"].ToString();
            try
            {
                if (string.IsNullOrWhiteSpace(shelf_id))
                {
                    throw new Exception("料架信息传输不完整");
                    return;
                }

                //请求地址
                string url = System.Configuration.ConfigurationManager.AppSettings["EShelfAPIUrl"];
                if (string.IsNullOrWhiteSpace(url))
                {
                    throw new Exception("请配置webconfig的EShelfAPIUrl");
                }

                url += "/api/cancel_warning";
                //发送请求
                string result = DoRequest(url, "POST", JsonConvert.SerializeObject(new { shelf_id = shelf_id }) , null);

                res = JsonConvert.DeserializeObject<ResponseInfo<WarehouseLocationInfo>>(result);
                //输出响应
                context.Response.Write(JsonConvert.SerializeObject(res));                
            }
            catch (Exception ex)
            {
                res.status = 1;
                res.msg = ex.Message;
                context.Response.Write(JsonConvert.SerializeObject(res));                
            }
        }

        /// <summary>
        ///  实时库存查询 
        /// </summary>
        /// <param name="context"></param>
        private void RW_WarehouseStock(HttpContext context)
        {
            ResponseInfo<WarehouseLocationInfo> res = new ResponseInfo<WarehouseLocationInfo>();
            res.status = 0;
            //解析数据
            string shelf_id = DisStr(context.Request["shelf_id"]);
            string userName = context.Request["userName"].ToString();

            try
            {

                if (string.IsNullOrWhiteSpace(shelf_id))
                {
                    throw new Exception("料架信息传输不完整");
                    return;
                }

                //请求地址
                string url = System.Configuration.ConfigurationManager.AppSettings["EShelfAPIUrl"];
                if (string.IsNullOrWhiteSpace(url))
                {
                    throw new Exception("请配置webconfig的EShelfAPIUrl");
                }
                url += "/api/warehouse_stock";
                //发送请求
                string result = DoRequest(url, "POST", shelf_id, null);

                res = JsonConvert.DeserializeObject<ResponseInfo<WarehouseLocationInfo>>(result);

                //输出响应
                context.Response.Write(JsonConvert.SerializeObject(res));                
            }
            catch (Exception ex)
            {
                res.status = 1;
                res.msg = ex.Message;

                context.Response.Write(JsonConvert.SerializeObject(res));                
            }
        }
        
        #endregion

        /// <summary>
        /// 转base64String
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        private string Base64Encrypt(string str)
        {
            byte[] encbuff = System.Text.Encoding.UTF8.GetBytes(str);
            return Convert.ToBase64String(encbuff);
        }
        /// <summary>
        /// Web请求
        /// </summary>
        /// <param name="url"></param>
        /// <param name="method"></param>
        /// <param name="jsonData"></param>
        /// <param name="dicHeaders"></param>
        /// <returns></returns>
        private string DoRequest(string url, string method, string jsonData, Dictionary<string, string> dicHeaders)
        {
            string result = "";
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Timeout = 6000;
            request.ContentLength = 0;
            request.ContentType = "application/json";
            request.Method = method;
            if (dicHeaders != null)
            {
                foreach (var item in dicHeaders)
                {
                    request.Headers.Add(item.Key, item.Value);
                }
            }
            if (!string.IsNullOrEmpty(jsonData) && method == "POST")
            {
                byte[] data = Encoding.GetEncoding("UTF-8").GetBytes(jsonData);
                request.ContentLength = data.Length;
                Stream stream = request.GetRequestStream();
                stream.Write(data, 0, data.Length);
                stream.Close();
            }
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using (StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
            {
                result = sr.ReadToEnd();
            }
            response.Close();
            request.Abort();
            return result;
        }
        /// <summary>
        /// 记录日志
        /// </summary>
        /// <param name="context"></param>
        private void Log(HttpContext context)
        {
            string msg = "";
            try
            {
                string logType = context.Request.Params["LogType"];
                string logContent = context.Request.Params["LogContent"];

                if (logType == "1")
                {
                    _logger.Info(logContent);
                }
                else if (logType == "2")
                {
                    _logger.Error(logContent);
                }
                else
                {
                    _logger.Info(logContent);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            context.Response.Write(msg);
            context.Response.End();
        }

        #endregion


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
    }

    public class GrnInfo
    {
        /// <summary>
        /// 物料唯一码
        /// </summary>
        public string reel_id { get; set; }
        /// <summary>
        /// 物料编码
        /// </summary>
        public string part_number { get; set; }
        /// <summary>
        /// 单盘物料颗数
        /// </summary>
        public int quantity { get; set; }
        /// <summary>
        /// 该物料供应商
        /// </summary>
        public string vendor { get; set; }

        /// <summary>
        /// 该盘物料生产日期
        /// </summary>
        public string date_code { get; set; }
        /// <summary>
        /// 该盘物料的批次号
        /// </summary>
        public string lot_code { get; set; }
        /// <summary>
        /// 料架编号
        /// </summary>
        public string shelf_id { get; set; }

    }
    public class GrnRequestInfo
    {
        /// <summary>
        /// 发料颜色（如不传，料架自动分配）
        ///3：蓝
        ///4：黄
        ///5：紫
        ///6：青
        ///7：白
        /// </summary>
        public int issue_color { get; set; }

        public List<string> issue_list { get; set; }
        //public List<issue> issue_list { get; set; }
    }
    public class CancelRequestInfo
    {
        public List<string> recall_list { get; set; }
    }
    public class issue
    {
        /// <summary>
        /// 料架编号
        /// </summary>
        public string shelf_id { get; set; }
        /// <summary>
        /// 料架储位
        /// </summary>
        public string position_info { get; set; }
        /// <summary>
        /// 物料唯一
        /// </summary>
        public string reel_id { get; set; }

    }
    public class ResponseInfo<T> where T : class, new()
    {
        /// <summary>
        /// 结果码（0-OK,其他代表失败）
        ///1: 请求失败,请求参数缺失
        ///2：请求失败,料架离线状态
        ///3：请求失败,料架报警状态
        /// </summary>
        public int status { get; set; }
        /// <summary>
        /// 结果描述
        /// </summary>
        public string msg { get; set; }
        /// <summary>
        /// 结果
        /// </summary>
        public T data { get; set; }
    }

    public class WarehouseStockInfo
    {
        public List<string> position_info { get; set; }
    }
}