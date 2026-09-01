using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.CommonDataSource.BLL;
using SKT.LeanMES.CommonDataSource.Model;

namespace SKT.LeanMES.Web.SystemConfiguration
{
	public partial class APIEdit : BasePage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSysConfiguration));

            if (!IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SAPAPI apiBLL = new SAPAPI();
                    SAPAPIInfo apiinfo = apiBLL.GetInfo(Convert.ToInt32(idString));
                    if (apiinfo != null)
                    {
                        txtBusinessName.Text = apiinfo.BusinessName;
                        txtFuncName.Text = apiinfo.FuncName;
                        txtRemark.Text = apiinfo.Remark;
                        txtSapFields.Text = apiinfo.SapFields;
                        txtSapParam.Text = apiinfo.SapParam;
                        txtSapParamDesc.Text = apiinfo.SapParamDesc;
                        txtSapTabName.Text = apiinfo.SapTabName;
                        txtTargetTabFields.Text = apiinfo.TargetTabFields;
                        txtTargetTabName.Text = apiinfo.TargetTabName;
                    }
                }
            }
		}
	}
}