using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.Common.Model;
using SKT.LeanMES.CapacityVerfyRecord.Model;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.CapacityVerfyRecord.BLL
{
    public class CapacityVerfy
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// frank.fang 2017/7/31 获取产能信息
        /// </summary>
        /// <param name="Date">查询日期</param>
        /// <param name="Admin">工号</param>
        public List<CapacityVerfyInfo> GetCapacityInfo(string QueryDate, string admin, int OpeId, int PackingType)
        {
            List<CapacityVerfyInfo> list = new List<CapacityVerfyInfo>();
            CapacityVerfyInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UserCode", SqlDbType.VarChar, 50),
                new SqlParameter("@QueryDate", SqlDbType.VarChar,50),
                new SqlParameter("@OpeId", SqlDbType.VarChar,50),
                new SqlParameter("@PackingType", SqlDbType.Int)
            };
            parms[0].Value = admin;
            parms[1].Value = QueryDate;
            parms[2].Value = OpeId;
            parms[3].Value = PackingType;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_GetCapacityInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new CapacityVerfyInfo();
                    entity.StationID = Convert.ToInt32(rdr[0]);
                    entity.EquipmentID = Convert.ToInt32(rdr[1]);
                    entity.ItemID = Convert.ToInt32(rdr[2]);
                    entity.StationName = Convert.ToString(rdr[3]);
                    entity.EquipmentCode = Convert.ToString(rdr[4]);
                    entity.ItemCode = Convert.ToString(rdr[5]);
                    entity.price = Convert.ToString(rdr[6]);
                    entity.Qty = Convert.ToDecimal(rdr[7]);
                    entity.salary = Convert.ToString(rdr[8]);
                    entity.UserCode = Convert.ToString(rdr[9]);
                    entity.UserName = Convert.ToString(rdr[10]);
                    entity.PieceWageID = Convert.ToInt32(rdr[11]);
                    entity.UserId = Convert.ToInt32(rdr[12]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }



        /// <summary>
        /// frank.fang 2017/7/31 产能确认保存
        /// </summary>
        /// <param name="Date">查询日期</param>
        /// <param name="Remark">备注信息</param>
        /// <param name="_userId">用户ID</param>
        /// <param name="ScanSNS">数据集合</param>
        /// <param name="Type">确认类别:0 产能确认 1:上料确认</param>
        /// <param name="PackingType">包装类型:0 出货 1:组件用</param>
        /// <param name="UserName">用户工号</param>
        public void SaveCapacityRecordEdit(string Date, string Remark, int _userId, string ScanSNS, string Type, int PackingType, string UserName)
        {
            DataTable dataT = JsonToDataTable(ScanSNS);
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Type", SqlDbType.Int),
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@QueryDate", SqlDbType.VarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar,50),
                new SqlParameter("@Remark", SqlDbType.VarChar,1000),
                new SqlParameter("@PackingType", SqlDbType.Int),
                new SqlParameter("@SNS", SqlDbType.Structured)
            };
            parms[0].Value = int.Parse(Type);
            parms[1].Value = _userId;
            parms[2].Value = Date;
            parms[3].Value = UserName;
            parms[4].Value = Remark;
            parms[5].Value = PackingType;
            parms[6].Value = dataT;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_SaveCapacityVerfyInfo", parms);
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
                    if (strRows[j].Split(':')[0] == "\"ColdStorageIntime\"")
                    {
                        dr[j] = strRows[j].Split(':')[1].Replace("\"", "") + ":" + strRows[j].Split(':')[2].Replace("\"", "") + ":" + strRows[j].Split(':')[3].Replace("\"", "");
                    }
                    else
                    {
                        dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                    }
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
        }
        #endregion        

    }
}
