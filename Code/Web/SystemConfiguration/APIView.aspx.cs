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
    public partial class APIView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SAPAPI apiBLL = new SAPAPI();
                    SAPAPIInfo apiinfo = apiBLL.GetInfo(Convert.ToInt32(idString));
                    if (apiinfo != null)
                    {
                        lblBusinessName.InnerHtml = apiinfo.BusinessName;
                        lblFuncName.InnerHtml = apiinfo.FuncName;
                        lblRemark.InnerHtml = apiinfo.Remark;
                        lblSapFields.InnerHtml = apiinfo.SapFields;
                        lblSapParam.InnerHtml = apiinfo.SapParam;
                        lblSapParamDesc.InnerHtml = apiinfo.SapParamDesc;
                        lblSapTabName.InnerHtml = apiinfo.SapTabName;
                        lblTargetTabFields.InnerHtml = apiinfo.TargetTabFields;
                        lblTargetTabName.InnerHtml = apiinfo.TargetTabName;
                    }
                }
            }
        }
    }
}