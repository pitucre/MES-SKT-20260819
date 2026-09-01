using SKT.Common.DAL.Marshal;
using SKT.LeanMES.ProductionCollection.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.WebService
{
    public class LaserCarvingService
    {
        /// <summary>
        /// 验证工单、产品编码关系是否正确
        /// </summary>
        /// <param name="orderNO"></param>
        /// <param name="itemCode"></param>
        /// <param name="msg"></param>
        /// <returns></returns>
        public LaserCarvingOrderInfo LaserCarvingCheckOrder(string orderNO,string itemCode,ref string msg)
        {
            msg = "";
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                    new SqlParameter("@OrderNo",SqlDbType.VarChar,200),
                    new SqlParameter("@ItemCode",SqlDbType.VarChar,200),
                    new SqlParameter("@Msg",SqlDbType.VarChar,200)
                };
                LaserCarvingOrderInfo entity = new LaserCarvingOrderInfo();
                param[0].Value = orderNO;
                param[1].Value = itemCode;
                param[2].Value = "";
                param[2].Direction = ParameterDirection.InputOutput;

                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspLaserCarvingCheckOrderInfo", param))
                {
                    msg = param[2].Value.ToString();
                    if (rdr.Read())
                    {
                        entity.OrderNO = rdr.GetString(0);
                        entity.ItemCode = rdr.GetString(1);
                        entity.QtytoBuild = rdr.GetInt32(2);
                    }
                }
                return entity;
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
                return new LaserCarvingOrderInfo();
            }
        }
       

        /// <summary>
        /// 根据工单号、产品编码与拼板数量，返回(SN)条码，多个用,号分隔。
        /// </summary>
        /// <param name="OrderNO"></param>
        /// <param name="itemCode"></param>
        /// <param name="qty"></param>
        /// <param name="msg"></param>
        /// <returns></returns>
        public string LaserCarvingGetOrderSN(string OrderNO,string itemCode,int qty, ref string msg)
        {
            msg = "";
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                    new SqlParameter("@OrderNO",SqlDbType.NVarChar,200),
                    new SqlParameter("@ItemCode",SqlDbType.VarChar,50),
                    new SqlParameter("@Qty",SqlDbType.Int),
                    new SqlParameter("@Msg",SqlDbType.VarChar,200)
                };
                string sn = "";
                param[0].Value = OrderNO;
                param[1].Value = itemCode;
                param[2].Value = qty;
                param[3].Value = "";
                param[3].Direction = ParameterDirection.InputOutput;
                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspLaserCarvingGetOrderSN", param))
                {
                    msg= param[3].Value.ToString();
                    while (rdr.Read())
                    {
                        sn += rdr.GetString(0) + ",";
                    }
                }
                if (sn.Length > 0)
                {
                    sn = sn.Substring(0, sn.Length - 1);
                }
                return sn;
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
                return "";
            }
        }


        /// <summary>
        /// 接收镭雕结果，更改状态
        /// </summary>
        /// <param name="OrderNO"></param>
        /// <param name="itemCode"></param>
        /// <param name="qty"></param>
        /// <param name="msg"></param>
        /// <returns></returns>
        public string LaserCarvingUpdateSNStatus(string OrderNO, string itemCode, string json, ref string msg)
        {
            msg = "";
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                    new SqlParameter("@OrderNO",SqlDbType.NVarChar,200),
                    new SqlParameter("@ItemCode",SqlDbType.VarChar,50),
                    new SqlParameter("@Json",SqlDbType.NVarChar),
                    new SqlParameter("@Msg",SqlDbType.VarChar,200)
                };
      
                param[0].Value = OrderNO;
                param[1].Value = itemCode;
                param[2].Value = json;
                param[3].Value = "";
                param[3].Direction = ParameterDirection.InputOutput;
                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspLaserCarvingUpdateSNStatus", param))
                {
                    msg = param[3].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
                return "";
            }
            return msg;
        }



        /// <summary>
        /// list 转 DataTable
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        private DataTable GetLaserCarvingOrderGrnInfoToDataTable(List<LaserCarvingOrderGrnInfo> list)
        {
            return SKT.LeanMES.CommonHelper.BLL.ComMethod.ConvertToDataTable(list);
        }
    }
}
