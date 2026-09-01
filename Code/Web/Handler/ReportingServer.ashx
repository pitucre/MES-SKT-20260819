<%@ WebHandler Language="C#" Class="ReportingServer" %>

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using SKT.LeanMES.PubItems.BLL;
using SKT.MES.ReportingService.Utility.Common;
using SKT.MES.ReportingService.Utility.Grid;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Web;
using ExcelHelper = SKT.LeanMES.Web.AppCode.Utility.ExcelHelper;
using System.Collections.Generic;
using SKT.LeanMES.Web.AppCode.Utility;
public class ReportingServer : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        // 验证是否权限过期
        var userInfo = AccountController.GetCurrentUser();
        SqlInjectableHelper.Validation(context);
        context.Response.ContentType = "text/plain";
        //context.Response.ContentType = "application/json";
        string action = context.Request["dataAction"];


        switch (action)
        {
            case "PROC":
                TryGetGridViewData();
                break;
            case "TABLE":
                GetFromTable();
                break;
            case "Preview":
                GetFromTable();
                break;
            case "OQCRejectReport":
                GetOqcRejectReport();
                break;
        }

        context.Response.End();
    }

    public void GetOqcRejectReport()
    {
        HttpContext context = HttpContext.Current;
        DateTime startTime = Convert.ToDateTime(context.Request["starttime"]);
        DateTime endtime = Convert.ToDateTime(context.Request["endtime"]);
        Int32 lineId = Convert.ToInt32(context.Request["lineId"]);
        Int32 itemId = Convert.ToInt32(context.Request["itemId"]);

        SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BeginDateTime", SqlDbType.DateTime),
                new SqlParameter("@EndDateTime", SqlDbType.DateTime),
                new SqlParameter("@LineId", SqlDbType.NVarChar,int.MaxValue),
                new SqlParameter("@ItemId", SqlDbType.NVarChar,int.MaxValue)
            };
        parms[0].Value = startTime;
        parms[1].Value = endtime;
        parms[2].Value = lineId;
        parms[3].Value = itemId;
        DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.ReportConnString, "uspGetOQCLotInfoByDate", parms);

        System.Collections.ArrayList arrayList = new System.Collections.ArrayList();
        foreach (DataRow dataRow in dt.Rows)
        {
            Dictionary<string, object> dictionary = new Dictionary<string, object>();  //实例化一个参数集合
            foreach (DataColumn dataColumn in dt.Columns)
            {
                dictionary.Add(dataColumn.ColumnName, dataRow[dataColumn.ColumnName].ToString());
            }
            arrayList.Add(dictionary); //ArrayList集合中添加键值
        }

        context.Response.Write(new JavaScriptSerializer().Serialize(arrayList));
    }

    public void GetFromTable()
    {
        HttpContext context = HttpContext.Current;
        string conditions = context.Request["conditions"];
        string action = context.Request["dataAction"];
        string table = context.Request["gridviewname"];
        string pageNum = context.Request["page"];//Add By Alen 2016-08-17 当前页码
        string pageSize = context.Request["pagesize"];//Add By Alen 2016-08-17 每页记录数
        string selectFields = context.Request["selectFields"];//Add By Alen 2016-08-17 报表要查询的列字符串
        string sortname = context.Request["sortname"];//Add By Alen 2016-08-17 报表排序参数
        string sortorder = context.Request["sortorder"];

        string strSql = "SELECT  * FROM " + table + " WITH(NOLOCK) WHERE 1=1 ";
        string strOrderby = "";

        if (action == "Preview")
        {
            strSql = "SELECT TOP 10 * FROM " + table + " WITH(NOLOCK) WHERE 1=1 ";
        }
        if (conditions != "")
        {
            //Modify By Alen 2016-08-17 使用SearchSettings设置查询条件
            strSql += conditions;
        }
        if (sortname != null && sortname != "")
        {
            strOrderby = "order by " + sortname + " " + sortorder;
        }

        try
        {
            int startRow = (action == "Preview") ? 0 : (Convert.ToInt32(pageNum) - 1) * Convert.ToInt32(pageSize);
            int maxRows = Convert.ToInt32(pageSize) == 0 ? 100 : Convert.ToInt32(pageSize);

            //Modify By Alen 2016-08-17 使用分页存储过程
            //DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, strSql, null);

            /*System.Data.SqlClient.SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, table, selectFields.Substring(0,selectFields.IndexOf(",")), selectFields, searchSettings, "");
            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms);
            */


            //BirongLiang 2016-12-29 

            DataTable dtTotal = SQLHelper.ExcuteDataTableSqlText(SQLHelper.ReportConnString, strSql, null);
            int total = dtTotal.Rows.Count;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@startRow", SqlDbType.Int),
                new SqlParameter("@pageSize", SqlDbType.Int),
                new SqlParameter("@sqlString", SqlDbType.NVarChar,int.MaxValue),
                new SqlParameter("@orderBy", SqlDbType.NVarChar,int.MaxValue)
            };
            parms[0].Value = startRow;
            parms[1].Value = maxRows;
            parms[2].Value = strSql;
            parms[3].Value = strOrderby;
            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.ReportConnString, "uspGetTabelByPagerSQL", parms);

            context.Response.Write(DataTable2Json(dt, total));
        }
        catch (Exception ex)
        {
            context.Response.Write(ex.Message);
        }
    }
    public void TryGetGridViewData()
    {
        HttpContext context = HttpContext.Current;
        string isProcPage = context.Request["isprocpage"];
        string datajson = "";

        GridViewPager pager = new GridViewPager();
        try
        {
            //Modify by zhiman.yuan 2017-6-3 添加存储过程分页方式
            if (isProcPage != null && isProcPage == "true")
            {
                string conditions = context.Request["conditions"];
                string action = context.Request["dataAction"];
                string table = context.Request["gridviewname"];
                string pageNum = context.Request["page"];//Add By Alen 2016-08-17 当前页码
                string pageSize = context.Request["pagesize"];//Add By Alen 2016-08-17 每页记录数
                string selectFields = context.Request["selectFields"];//Add By Alen 2016-08-17 报表要查询的列字符串
                string sortname = context.Request["sortname"];//Add By Alen 2016-08-17 报表排序参数
                string sortorder = context.Request["sortorder"];

                string list = context.Request["paramters"].ToString();
                List<SKT.MES.ReportingService.Utility.Common.Helpers.ParamInfo> listObj = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Collections.Generic.List<SKT.MES.ReportingService.Utility.Common.Helpers.ParamInfo>>(list);

                List<SqlParameter> listParms = new List<SqlParameter>();
                foreach (var item in listObj)
                {
                    SqlParameter parm = new SqlParameter();
                    parm.ParameterName = item.Name;

                    switch (item.Type.ToLower())
                    {
                        case "int":
                            parm.DbType = DbType.Int32;
                            if (item.Value != null && !string.IsNullOrEmpty(item.Value.ToString()))
                            {
                                parm.Value = Convert.ToInt32(item.Value);
                            }
                            break;
                        case "datetime":
                            parm.DbType = DbType.DateTime;
                            parm.Value = Convert.ToDateTime(item.Value);
                            break;
                        case "decimal":
                            parm.DbType = DbType.Decimal;
                            parm.Value = Convert.ToDecimal(item.Value);
                            break;
                        case "varchar":
                            parm.DbType = DbType.String;
                            parm.Value = Convert.ToString(item.Value);
                            break;
                        case "nvarchar":
                            parm.DbType = DbType.String;
                            parm.Value = Convert.ToString(item.Value);
                            break;
                        case "boolean":
                            parm.DbType = DbType.Boolean;
                            parm.Value = Convert.ToBoolean(item.Value);
                            break;
                        default:
                            parm.DbType = DbType.String;
                            parm.Value = Convert.ToString(item.Value);
                            break;
                    }

                    parm.Size = item.Size;
                    listParms.Add(parm);

                }

                SqlParameter pageSizeParam = new SqlParameter();
                pageSizeParam.ParameterName = "@PageSize";
                pageSizeParam.DbType = DbType.Int32;
                pageSizeParam.Value = (pageSize == null ? 0 : Convert.ToInt32(pageSize));

                SqlParameter pageIndexParam = new SqlParameter();
                pageIndexParam.ParameterName = "@PageIndex";
                pageIndexParam.DbType = DbType.Int32;
                pageIndexParam.Value = (pageNum == null ? 0 : Convert.ToInt32(pageNum));

                SqlParameter outParam = new SqlParameter();
                outParam.ParameterName = "@TotalCount";
                outParam.DbType = DbType.Int32;
                outParam.Direction = ParameterDirection.InputOutput;
                outParam.Value = 0;

                listParms.Add(pageSizeParam);
                listParms.Add(pageIndexParam);
                listParms.Add(outParam);
                var paramArr = listParms.ToArray();

                DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.ReportConnString, table, paramArr);

                if (sortname != null && sortorder != null)
                {
                    DataView dtv = dt.DefaultView;
                    dtv.Sort = sortname + " " + sortorder;
                    dt = dtv.ToTable();
                }
                var totalCount = Convert.ToInt32(paramArr[paramArr.Length - 1].Value);
                datajson = DataTable2Json(dt, totalCount);
            }
            else
            {
                datajson = pager.GetDataJSON();
            }
            context.Response.Write(datajson);
        }
        catch (Exception ex)
        {
            context.Response.Write(ex.Message);
            //throw;
        }

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    //BirongLiang  2016-12-30 使用(new PubItems()).GetListJson(dt)生产JSON
    private string DataTable2Json(DataTable dt, int total)
    {
        System.Text.StringBuilder jsonBuilder = new System.Text.StringBuilder();
        jsonBuilder.Append("{\"");
        jsonBuilder.Append("Total");
        jsonBuilder.Append("\":\"" + total + "\",\"");
        jsonBuilder.Append("Rows");
        jsonBuilder.Append("\":");
        var dataSet = (new PubItems()).GetListJson(dt);
        jsonBuilder.Append(dataSet);
        //jsonBuilder.Append("\":[");
        //for (int i = 0; i < dt.Rows.Count; i++)
        //{
        //    jsonBuilder.Append("{");
        //    for (int j = 0; j < dt.Columns.Count; j++)
        //    {
        //        jsonBuilder.Append("\"");
        //        jsonBuilder.Append(dt.Columns[j].ColumnName.Trim());
        //        jsonBuilder.Append("\":\"");
        //        jsonBuilder.Append(dt.Rows[i][j].ToString().Trim());
        //        jsonBuilder.Append("\",");
        //    }
        //    jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        //    jsonBuilder.Append("},");
        //}
        //jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        //jsonBuilder.Append("]");
        jsonBuilder.Append("}");
        return jsonBuilder.ToString();

    }
}