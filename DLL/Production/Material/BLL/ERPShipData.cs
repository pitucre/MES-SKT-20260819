using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.ERP;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace SKT.LeanMES.Material.BLL
{
    public class ERPShipData
    {
        public string GetU9CShipData()
        {
            DataTable syncdt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "select LastSyncTime from ERP_Sync where SyncCode='U9ShipQuery'", null);
            string syncdate = "";
            if (syncdt!=null && syncdt.Rows.Count>0 && syncdt.Rows[0]["LastSyncTime"]!=DBNull.Value )
            {
                syncdate = syncdt.Rows[0]["LastSyncTime"].ToString();  
            }
            else
            {
                syncdate = "2025-01-01 00:00:00";
            }
            HttpClientHelper client = new HttpClientHelper();
            DataTable dt = new DataTable();
            string shipdata = client.GetU9ShipData(syncdate) ;
            dt.Columns.Add("ID");
            dt.Columns.Add("DocLineNo");
            dt.Columns.Add("ItemID");
            dt.Columns.Add("ItemCode");
            dt.Columns.Add("ShipQtyTUAmount");
            dt.Columns.Add("WhCode");
            WriteTextLog("获取到的数据：",shipdata); 
            if(string.IsNullOrEmpty( shipdata ))
            {
                return "没有获取到数据";
            }
            JObject shipjob = JsonConvert.DeserializeObject<JObject>(shipdata);
            if(shipjob!=null)
            {
                JArray shiparr = JsonConvert.DeserializeObject<JArray>(shipjob["Data"].ToString());
                if(shiparr!=null && shiparr.Count >0)
                {

                    try
                    {
                        SqlConnection con = (SqlConnection)DBHelper.GetConnection();
                        if (con.State == ConnectionState.Closed)
                        {
                            con.Open();
                        }
                        string sz = "";
                        var trans = con.BeginTransaction();
                        try
                        {
                            int k = 0;
                            foreach (JObject ship in shiparr)
                            {
                                sz = JsonConvert.SerializeObject(ship);  
                                SqlCommand cmd = new SqlCommand();
                                cmd.CommandText = "uspSaveProdSaleOrder";
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Connection = con;
                                cmd.Transaction = trans;                               
                                JArray itemarr = JsonConvert.DeserializeObject<JArray>(ship["ShipLines"].ToString());
                                dt.Clear();
                                dt.AcceptChanges();
                                if (itemarr != null && itemarr.Count > 0)
                                {
                                    foreach (JObject itm in itemarr)
                                    {
                                        DataRow dr = dt.NewRow();
                                        dr.BeginEdit();
                                        dr["ID"] = itm["ID"].ToString();                                       
                                        dr["DocLineNo"] = itm["DocLineNo"].ToString();                                       
                                        dr["ItemID"] = itm["ItemInfo"]["ItemID"].ToString();                                       
                                        dr["ItemCode"] = itm["ItemInfo"]["ItemCode"].ToString();                                       
                                        dr["ShipQtyTUAmount"] = itm["ShipQtyTUAmount"].ToString();                                        
                                        dr["WhCode"] = itm["WhCode"].ToString();                                        
                                        dr.EndEdit();
                                        dt.Rows.Add(dr);
                                    }
                                }
                                SqlParameter[] parms = new SqlParameter[] {
                                    new SqlParameter("@ErpId", SqlDbType.VarChar,100),
                                   new SqlParameter("@DocNo", SqlDbType.VarChar,100),
                                     new SqlParameter("@BusinessDate", SqlDbType.DateTime),
                                     new SqlParameter("@CustomerCode", SqlDbType.VarChar,100),
                                     new SqlParameter("@ItemInfo", SqlDbType.Structured),
                                     new SqlParameter("@UpSync", SqlDbType.Int),
                                     new SqlParameter("@Syncdate", SqlDbType.DateTime)
                                };
                                parms[0].Value = ship["ID"].ToString();
                                parms[1].Value = ship["DocNo"].ToString();
                                parms[2].Value = Convert.ToDateTime(ship["BusinessDate"].ToString());
                                parms[3].Value = ship["CustomerCode"].ToString();
                                parms[4].Value = dt; 
                                if(k==shiparr.Count-1)
                                {
                                    parms[5].Value = 1;
                                }
                                else
                                {
                                    parms[5].Value = 0;
                                }
                                parms[6].Value = Convert.ToDateTime(syncdate);
                                cmd.Parameters.AddRange(parms); 
                                cmd.ExecuteNonQuery();
                                k = k + 1;
                            }

                            trans.Commit();
                        }
                        catch (Exception ex)
                        {
                            WriteTextLog("错误原因：", ex.Message);
                            WriteTextLog("数据转换错误：", sz); 
                            trans.Rollback();
                            throw ex;
                        }
                    }
                    catch(Exception ee)
                    {
                        return ee.Message;
                    }
                    
                    
                }
                else
                {
                    return "未有数据";
                }
            }
            else
            {
                return "转换ERP数据出错";
            }
            return "OK";
        }

        public string PostU9ShipBill(string DocNo)
        {
            HttpClientHelper client = new HttpClientHelper();
            return client.PostU9ShipAudit(DocNo); 
        }

        private static void WriteTextLog(string action, string strMessage)
        {
            DateTime time = DateTime.Now;
            string path = AppDomain.CurrentDomain.BaseDirectory + @"\U9CLog\";
            if (!System.IO.Directory.Exists(path))
                System.IO.Directory.CreateDirectory(path);

            string fileFullPath = path + time.ToString("yyyy-MM-dd") + ".txt";
            System.Text.StringBuilder str = new System.Text.StringBuilder();
            str.Append("Time:    " + time.ToString() + "\r\n");
            str.Append("Action:  " + action + "\r\n");
            str.Append("Message: " + strMessage + "\r\n");
            str.Append("-----------------------------------------------------------\r\n\r\n");
            System.IO.StreamWriter sw;
            if (!System.IO.File.Exists(fileFullPath))
            {
                sw = System.IO.File.CreateText(fileFullPath);
            }
            else
            {
                sw = System.IO.File.AppendText(fileFullPath);
            }
            sw.WriteLine(str.ToString());
            sw.Close();
        }
    }
}
