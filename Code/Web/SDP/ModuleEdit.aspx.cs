using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.SDP.Model;

namespace SKT.LeanMES.Web.SDP
{
    public partial class ModuleEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));

            if (!IsPostBack)
            {
                string ID = Request.QueryString["ID"].ToString();
                UIModelInfo info = new UIModel().GetInfo(Convert.ToInt32(ID));
                if (info != null)
                {
                    txtModelueName.Text = info.ModelName;


                }
            }
        }
    }
}