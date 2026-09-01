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
    public partial class EqumentLineProductionKanban : System.Web.UI.Page
    {
        public string T1 = "（该工单累计入库数 / 工单总数）*100%";
        public string T2 = "（工单总数－工单不良数）/ 工单总数*100%";
        public string T3 = "（工单有效工时 / 机台标准工时）*100%";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPlan));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
        }
    }
}