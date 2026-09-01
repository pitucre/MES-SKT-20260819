using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.PackPrint.Model;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Web.Script.Serialization;
using System.Reflection;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.PackPrint.BLL
{
    public class ShipmentListConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Prod_ShipmentListConfig 信息。
        /// </summary>
        /// <param name="entity">Prod_ShipmentListConfig 实体对象。</param>
        public Int32 Edit(string listStr)
        {
            DataTable dataT = JsonToDataTable(listStr);
            SqlParameter[] parms = new SqlParameter[]{
                  new SqlParameter("@ShipList", SqlDbType.Structured)
            };
            parms[0].Value = dataT;
            int num = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEdithipmentlistconfig", parms);
            return num;
        }
        #region 将 Json 解析成 DateTable
        /// <summary>    
        /// 将 Json 解析成 DateTable   
        /// Json 数据格式如:  
        ///     {table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]}///</summary>    
        /// <param name="strJson">要解析的 Json 字符串</param>    
        /// <returns>返回 DateTable</returns>    
        public static DataTable JsonToDataTable(string strJson)
        {
            // 取出表名    
            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);
            string strName = rg.Match(strJson).Value;
            DataTable tb = null;
            // 去除表名    
            strJson = strJson.Substring(strJson.IndexOf("[") + 1);
            strJson = strJson.Substring(0, strJson.IndexOf("]"));
            // 获取数据    
            rg = new Regex(@"(?<={)[^}]+(?=})");
            MatchCollection mc = rg.Matches(strJson);
            for (int i = 0; i < mc.Count; i++)
            {
                string strRow = mc[i].Value;
                string[] strRows = strRow.Split(',');
                // 创建表    
                if (tb == null)
                {
                    tb = new DataTable();
                    tb.TableName = strName;
                    foreach (string str in strRows)
                    {
                        var dc = new DataColumn();
                        string[] strCell = str.Split(':');
                        dc.ColumnName = strCell[0].Replace("\"", "");
                        tb.Columns.Add(dc);
                    }
                    tb.AcceptChanges();
                }
                // 增加内容    
                DataRow dr = tb.NewRow();
                for (int j = 0; j < strRows.Length; j++)
                {
                    dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
        }
        #endregion
        /// <summary>
        /// 取得出货清单配置
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        public List<ShipmentListConfigInfo> GetShipmentListConfigInfos(int ItemId)
        {
            List<ShipmentListConfigInfo> list = new List<ShipmentListConfigInfo>();
            ShipmentListConfigInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int)
            };
            parms[0].Value = ItemId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetShipmentListConfigs", parms))
            {
                while (rdr.Read())
                {
                    entity = new ShipmentListConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetDateTime(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetInt32(14));
                    entity.OnePart = rdr.GetString(15);
                    entity.TwoPart = rdr.GetString(16);
                    entity.ThreePart = rdr.GetString(17);
                    list.Add(entity);
                }
                rdr.Close();
            }                     
            return list;
        }

        /// <summary>
        /// 扫条码过捆包装工位（取得下一个扫的部件名称）
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        public List<ShipmentListConfigInfo> GetProdBalePackingGetInfo(string ItemSN)
        {            
            List<ShipmentListConfigInfo> list = new List<ShipmentListConfigInfo>();
            ShipmentListConfigInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemSN", SqlDbType.VarChar,100)
            };
            parms[0].Value = ItemSN;
            using (DataTable dr = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "USPProdBalePackingGetInfo", parms))
            {
                for (int i = 0; i < dr.Rows.Count;i++ )
                {
                    entity = new ShipmentListConfigInfo();
                    entity.ProductUID = dr.Rows[i]["ProductUID"] == null ? 0 : Convert.ToInt32(dr.Rows[i]["ProductUID"].ToString());
                    entity.ProductItemId = dr.Rows[i]["ProductItemId"] == null ? 0 : Convert.ToInt32(dr.Rows[i]["ProductItemId"].ToString());
                    entity.NextBomName = dr.Rows[i]["NextBomName"] == null ? "" : dr.Rows[i]["NextBomName"].ToString();
                    entity.NextNum = dr.Rows[i]["NextNum"] == null ? 0 : Convert.ToInt32(dr.Rows[i]["NextNum"].ToString());
                    list.Add(entity);
                }                              
            }
            return list;
        }
        /// <summary>
        /// 扫条码过捆包装工位（扫描部件取得新的部件SN）
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        public List<ShipmentListConfigInfo> GetProdBalePackingScanBom(string ItemSN, string BomSn, int num)
        {
            List<ShipmentListConfigInfo> list = new List<ShipmentListConfigInfo>();
            ShipmentListConfigInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemSN", SqlDbType.VarChar,100),
                new SqlParameter("@BomSn", SqlDbType.VarChar,100),
                new SqlParameter("@num", SqlDbType.Int)
            };
            parms[0].Value = ItemSN;
            parms[1].Value = BomSn;
            parms[2].Value = num;
            using (DataTable dr = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "USPProdBalePackingScanBom", parms))
            {
                for (int i = 0; i < dr.Rows.Count; i++)
                {
                    entity = new ShipmentListConfigInfo();
                    entity.ProductUID = dr.Rows[i]["ProductUID"] == null ? 0 : Convert.ToInt32(dr.Rows[i]["ProductUID"].ToString());
                    entity.ProductItemId = dr.Rows[i]["ProductItemId"] == null ? 0 : Convert.ToInt32(dr.Rows[i]["ProductItemId"].ToString());
                    entity.NextBomName = dr.Rows[i]["NextBomName"] == null ? "" : dr.Rows[i]["NextBomName"].ToString();
                    entity.NextNum = dr.Rows[i]["NextNum"] == null ? 0 : Convert.ToInt32(dr.Rows[i]["NextNum"].ToString());
                    //
                    entity.NewSN = dr.Rows[i]["NewSN"] == null ? "" : dr.Rows[i]["NewSN"].ToString();
                    entity.ScanBomId = dr.Rows[i]["ScanBomId"] == null ? 0 : Convert.ToInt32(dr.Rows[i]["ScanBomId"].ToString());
                    entity.BomItemId = dr.Rows[i]["BomItemId"] == null ? 0 : Convert.ToInt32(dr.Rows[i]["BomItemId"].ToString());
                    entity.BomName = dr.Rows[i]["BomName"] == null ? "" : dr.Rows[i]["BomName"].ToString();
                    list.Add(entity);
                }
            }
            return list;
        }
        /// <summary>
        /// 扫条码过捆包装工位（写数据到表里）
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        public int EditProdBalePackingScanBom(int ProductItemId,int ProductUID, string userName ,string partBarCodes)
        {
            DataTable dataT = JsonToDataTable(partBarCodes);
            SqlParameter[] parms = new SqlParameter[]{
                  new SqlParameter("@ItemId", SqlDbType.Int),
                  new SqlParameter("@ItemUID", SqlDbType.Int),
                  new SqlParameter("@Operator", SqlDbType.VarChar,50),
                  new SqlParameter("@BalePacks", SqlDbType.Structured)
            };
            parms[0].Value = ProductItemId;
            parms[1].Value = ProductUID;
            parms[2].Value = userName;
            parms[3].Value = dataT;
            int num = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "USPProdBalePackingAdd", parms);
            return num;
        }

        /// <summary>
        /// 保存SN和MAC的关系
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        public string SaveSNAndMac(int itemId, string SN, string Address, string UserName)
        {
            string result = "";
            SqlParameter[] parms = new SqlParameter[]{
                  new SqlParameter("@itemId", SqlDbType.Int),
                  new SqlParameter("@SN", SqlDbType.VarChar,50),
                  new SqlParameter("@Address", SqlDbType.VarChar,50),
                  new SqlParameter("@UserName", SqlDbType.VarChar,50),
                  new SqlParameter("@ShowMsg", SqlDbType.VarChar,50)

            };
            parms[0].Value = itemId;
            parms[1].Value = SN;
            parms[2].Value = Address;
            parms[3].Value = UserName;
            parms[4].Value = result;
            parms[4].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "UspCheckMacAddressSave", parms);
            return parms[4].Value.ToString();
        }
        /// <summary>
        /// 检验SN和MAC的关系
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        public int CheckSNAndMac(string SN, string Address)
        {
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                  new SqlParameter("@SN", SqlDbType.VarChar,50),
                  new SqlParameter("@Address", SqlDbType.VarChar,50),
                  new SqlParameter("@num",SqlDbType.Int)
            };
            parms[0].Value = SN;
            parms[1].Value = Address;
            parms[2].Value = blResult;
            parms[2].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "UspCheckMacAddressCheck", parms);
            return (int)parms[2].Value;
        }
    }
}
