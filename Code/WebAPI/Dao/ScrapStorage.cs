using Dapper;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Script.Serialization;
using WebAPI.Models.ERP;
using WebAPI.Models.ScrapStorage;
using WebAPI.Ult;

namespace WebAPI.Dao
{
    /// <summary>
    /// 
    /// </summary>
    public class ScrapStorage
    {
        /// <summary>
        /// 
        /// </summary>
        public IList<ScrapInfo> GetScrapStatus(ScrapNoInfo scrapNoInfo)
        {
           return DBHelper.GetList<ScrapInfo>("uspGetScrapStatus", new { ScrapNo = scrapNoInfo.ScrapNo }, null, CommandType.StoredProcedure);
        }

        /// <summary>
        /// 
        /// </summary>
        public string ScrapStorageCallBack(ScrapStorageBaseInfo<ScrapNoInfo> scrapNoInfo)
        {
            string Result = string.Empty;
            DataTable dataTable = new DataTable();
            dataTable = ToDataTable(JsonConvert.SerializeObject(scrapNoInfo.List));
            try
            {
                DBHelper.Execute("uspScrapStorageCallBack", new { ScrapNoList = dataTable.AsTableValuedParameter("ScrapNoList") }, null, CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Result = ex.Message;
            }
            return Result;
        }
        /// <summary>
        /// Json转换为DataTable
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        public static DataTable ToDataTable(string json)
        {
            System.Collections.ArrayList arrayList = new JavaScriptSerializer
            {
                MaxJsonLength = 2147483647
            }.Deserialize<System.Collections.ArrayList>(json);
            DataTable result;
            if (arrayList.Count == 0)
            {
                result = null;
            }
            else
            {
                DataTable dataTable = new DataTable();
                List<string> listColumnName = new List<string>();
                foreach (System.Collections.Generic.Dictionary<string, object> dictionary in arrayList)
                {
                    //添加列（默认第一个数据行）
                    if (dataTable.Columns.Count == 0)
                    {
                        foreach (string current in dictionary.Keys)
                        {
                            dataTable.Columns.Add(current, (dictionary[current] == null) ? typeof(string) : dictionary[current].GetType());
                            listColumnName.Add(current);
                        }
                    }
                    //添加行
                    DataRow dataRow = dataTable.NewRow();
                    foreach (string current in dictionary.Keys)
                    {
                        //只处理已存在的列
                        if (listColumnName.Contains(current))
                        {
                            dataRow[current] = ((dictionary[current] == null) ? System.DBNull.Value : dictionary[current]);
                        }
                    }
                    dataTable.Rows.Add(dataRow);
                }
                result = dataTable;
            }
            return result;
        }
    }
}