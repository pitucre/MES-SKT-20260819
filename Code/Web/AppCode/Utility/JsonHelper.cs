using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    public class JsonHelper
    {
        /// <summary>
        /// JSON转DataTable
        /// </summary>
        /// <param name="json">json</param>
        /// <returns></returns>
        public static DataTable JsonToDataTable(string json)
        {
            Newtonsoft.Json.Linq.JArray array = Newtonsoft.Json.JsonConvert.DeserializeObject(json) as Newtonsoft.Json.Linq.JArray;
            StringBuilder columns = new StringBuilder();
            DataTable table = new DataTable();
            JObject objColumns = array[0] as JObject;
            //构造表头
            foreach (JToken jkon in objColumns.AsEnumerable<JToken>())
            {
                string name = ((JProperty)(jkon)).Name;
                columns.Append(name + ",");
                table.Columns.Add(name);
            }
            //向表中添加数据
            for (int i = 0; i < array.Count; i++)
            {
                DataRow row = table.NewRow();
                JObject obj = array[i] as JObject;
                foreach (JToken jkon in obj.AsEnumerable<JToken>())
                {
                    string name = ((JProperty)(jkon)).Name;
                    string value = ((JProperty)(jkon)).Value.ToString();
                    row[name] = value;
                }
                table.Rows.Add(row);
            }
            return table;
        }
    }
}