using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Resource.BLL;
using SKT.LeanMES.Resource.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Resource
{
    public partial class ResourceTypeView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int resTypeId = Convert.ToInt32(Request.QueryString["ID"]);
            if (resTypeId > -1)
            {
                ResourceTypeInfo model = new ResourceType().GetInfo(resTypeId);
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }

        private ResourceTypeInfo PageData
        {
            set
            {
                this.txtResTypeName.Text = value.ResTypeName;
                this.txtResTypeDesc.Text = value.ResTypeDesc;
            }
        }
    }
}