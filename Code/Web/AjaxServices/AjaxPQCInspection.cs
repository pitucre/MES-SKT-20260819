using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using AjaxPro;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// PQC检验
    /// </summary>
    public class AjaxPQCInspection
    {
        #region PQC
        /// <summary>
        /// 通过SN获取PQC检验内容
        /// </summary>
        /// <param name="SN"></param>
        [AjaxMethod]
        public string GetInspectionTemplate(string SN, int StationId)
        {
            string result = "";
            result = new InspectionPQC().GetInspectionTemplate(SN, StationId);
            return result;
        }
        /// <summary>
        /// 保存PQC检验内容
        /// </summary>
        /// <param name="SN"></param>
        /// <param name="StationId"></param>
        /// <param name="ResId"></param>
        /// <param name="IsPass"></param>
        [AjaxMethod]
        public void Save(string stringstr)
        {
            //DataTable DtlListNew = JsonToDataTable(DtlList);
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SN", SqlDbType.VarChar,300),
                    new SqlParameter("@Result", SqlDbType.Bit),
                    new SqlParameter("@DtlList", SqlDbType.Structured),
                };
            ComMethod.Edit<Model>(stringstr, "uspPQCInspectionListSave", parms);
        }
        #endregion





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
    }

    public class Model
    {
        public string InspectionTemplateId { get; set; }
        public string InspectionTemplateName { get; set; }
        public string InspectionItemId { get; set; }
        public string InspectionItemName { get; set; }
        public string InspectionMethodValue { get; set; }
        public string UnitName { get; set; }
        public string CheckFashion { get; set; }
        public string Result { get; set; }
        public string Value { get; set; }
    }
}