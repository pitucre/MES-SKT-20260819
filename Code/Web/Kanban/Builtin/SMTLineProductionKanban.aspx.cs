using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Kanban.Builtin
{
    public partial class SMTLineProductionKanban : System.Web.UI.Page
    {
        public string T1 = "（该车间工单当天实际产出数累计/当天计划数累计）*100%";
        public string T2 = "总装单机型IE效率取平均值：<br/>各机型IE效率＝(（各机型瓶颈时间（单位为秒）*该机型当前产出数）<br/>/（各机型最后一片板产出时间－各机型第一片板投入时间-异常时间）)*3600*100%";
        public string T3 = "(车间当天对应工单白卡数累计/车间当天产出数累计)*100%";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPlan));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
            /*
            if (!IsPostBack)
            {
                var cmdTxt = " SELECT [Description] FROM dbo.SYS_DictionaryData WHERE Name IN('txtKBCalc1','txtKBCalc2','txtKBCalc3') order by Name asc";
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                if (dt.Rows.Count > 0)
                {
                    T1 = dt.Rows[0]["Description"].ToString();
                    T2 = dt.Rows[1]["Description"].ToString();
                    T3 = dt.Rows[2]["Description"].ToString();
                }
            }
            */
        }
    }
}