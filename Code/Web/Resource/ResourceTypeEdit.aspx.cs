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
    public partial class ResourceTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceResource));
            int resTypeId = Convert.ToInt32(Request.QueryString["ID"]);
            string action = Request.QueryString["Action"];
            if (resTypeId > -1)
            {
                ResourceTypeInfo model = new ResourceType().GetInfo(resTypeId);
                if (model != null)
                {
                    this.PageData = model;
                    if (action != "Copy")
                    {
                        this.txtResTypeName.Enabled = false;
                    }
                }
            }
        }

        private ResourceTypeInfo PageData
        {
            set
            {
                string action = Request.QueryString["Action"];
                if (action != "Copy")
                {
                    this.txtResTypeName.Text = value.ResTypeName;
                    this.txtResTypeDesc.Text = value.ResTypeDesc;
                }
                else
                {
                    this.txtResTypeName.Text = Resources.Buttons.COM_Copy + "-" + value.ResTypeName;
                    this.txtResTypeDesc.Text = value.ResTypeDesc;
                }
            }
        }
    }
}