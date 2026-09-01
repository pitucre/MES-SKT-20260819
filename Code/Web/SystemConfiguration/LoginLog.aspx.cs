using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.DAL.Marshal;
using System.Data;
using System.Data.SqlClient;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class LoginLog : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Action"]=="getlog")
            {
                GetLoginLog();
            }
        }

        protected void GetLoginLog()
        {
            var BegTime = Request.QueryString["BegTime"];
            var EndTime = Request.QueryString["EndTime"];
            var strWhere1 = Request.QueryString["strwhere1"];
            DataTable dt = null;
            var cmdtxt = @"SELECT ID,a.UserName,LoginClientIP,CONVERT(VARCHAR(20),LoginTime,120) AS LoginTime,LoginAction,a.Remark,b.CName,b.EName,b.EmployeeNo,b.DepartName 
                             FROM dbo.SYS_UserLoginLog AS a
                            INNER JOIN dbo.vwUsers AS b ON a.username = b.UserName 
                            WHERE LoginTime>=@BegTime and LoginTime<=@EndTime
                            order by logintime desc ";//默认查询一周的(WHERE DATEDIFF(DAY,LoginTime,GETDATE()) <= @strWhere )
            var cmdtxt1 = @"SELECT ID,a.UserName,LoginClientIP,LoginTime,LoginAction,a.Remark,b.CName,b.EName,b.EmployeeNo,b.DepartName 
                            FROM dbo.SYS_UserLoginLog AS a
                            INNER JOIN dbo.vwUsers AS b ON a.username = b.UserName 
                            WHERE LoginTime>=@BegTime and LoginTime<=@EndTime
                            and (a.username = @strWhere1 or b.CName = @strWhere1) 
                            order by logintime desc ";//默认查询一周的
            if (!String.IsNullOrEmpty(strWhere1))
            {
                SqlParameter[] parms = new SqlParameter[] {
                    new SqlParameter("@BegTime", SqlDbType.DateTime),
                    new SqlParameter("@EndTime", SqlDbType.DateTime),
                    new SqlParameter("@strWhere1", SqlDbType.NVarChar,50)
                };
                parms[0].Value = BegTime;
                parms[1].Value = EndTime;
                parms[2].Value = strWhere1;
                dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdtxt1, parms);
            }
            else
            {
                SqlParameter[] parms = new SqlParameter[] {
                    new SqlParameter("@BegTime", SqlDbType.DateTime),
                    new SqlParameter("@EndTime", SqlDbType.DateTime),
                };
                parms[0].Value = BegTime;
                parms[1].Value = EndTime;
                dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdtxt, parms);
            }
            var logJson = "";
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    logJson+="{\"id\":\""+dt.Rows[i]["ID"]+"\",\"username\":\"" + dt.Rows[i]["UserName"] + "\",\"loginclientip\":\""+ dt.Rows[i]["LoginClientIP"] + "\",\"logintime\":\""+ dt.Rows[i]["LoginTime"] + "\",\"loginaction\":\""+ dt.Rows[i]["LoginAction"] + "\",\"remark\":\""+ dt.Rows[i]["Remark"] + "\",\"cname\":\"" + dt.Rows[i]["CName"] + "\",\"ename\":\"" + dt.Rows[i]["EName"] + "\",\"employeeno\":\"" + dt.Rows[i]["EmployeeNo"] + "\",\"departname\":\"" + dt.Rows[i]["DepartName"] + "\"}";
                    if (i < dt.Rows.Count - 1)
                        logJson += ",";
                }
            }
            logJson = "{\"totals\":\"" + dt.Rows.Count.ToString() + "\",\"data\":[" + logJson + "]}";
            Response.Write(logJson);
            Response.End();
        }
    }
}