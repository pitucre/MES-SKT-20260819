using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SMT
{
    public partial class SMTSetupLine : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesLoadingList));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.Controls.PageSQLService));
            if (!this.IsPostBack)
            {
                Bind();   
            }
        }
        public void Bind()
        {
            //绑定线别数据
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            SKT.LeanMES.Resource.BLL.Line lineBll = new LeanMES.Resource.BLL.Line();
            string  userName = AccountController.GetCurrentUser().UserName; 
            List<SKT.LeanMES.Resource.Model.LineInfo> lineInfo = lineBll.GetLineNameByUserName(userName);
            ddlLineName.DataSource = lineInfo;
            ddlLineName.DataTextField = "LineName";
            ddlLineName.DataValueField = "LineId";
            ddlLineName.DataBind();
            ddlLineName.Items.Insert(0,"---请选择---");
        }
    }
}