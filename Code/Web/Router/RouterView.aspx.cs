using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Router.BLL;
using SKT.LeanMES.Router.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Router
{
    public partial class RouterView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxRouter));
            if (!IsPostBack)
            {
                string rIdStr = Request.QueryString["ID"];
                int rId = Convert.ToInt32(rIdStr);

                if (rId > -1)
                {
                    SKT.LeanMES.Router.Model.RouterInfo model = new SKT.LeanMES.Router.BLL.Router().GetInfo(rId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }


        protected SKT.LeanMES.Router.Model.RouterInfo PageData
        {
            set
            {
                this.txtRouterName.Text = value.R_Name;
                this.txtDescription.Text = value.R_Description;
                this.lblRouterStatus.Text = ((SKT.LeanMES.Router.Model.EnumRouterStatus)Enum.Parse(typeof(SKT.LeanMES.Router.Model.EnumRouterStatus), value.R_Status.ToString())).ToString();
            }
        }
    }
}