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
    public partial class RouterEdit :BasePage
    {
        /// <summary>
        /// 是否复制
        /// </summary>
        public string IsCopy
        {
            get
            {
                return ViewState["IsCopy"] == null ? string.Empty : ViewState["IsCopy"].ToString().Trim();
            }
            set
            {
                ViewState["IsCopy"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxRouter));
            if (!IsPostBack)
            {
                string rIdStr = Request.QueryString["ID"];
                this.IsCopy = Request.QueryString["IsCopy"];
                BindRouterStatus();
                int rId = Convert.ToInt32(rIdStr);

                if (rId > -1)
                {
                    if (!string.Equals(IsCopy, "1"))
                    {
                        this.txtRouterName.Enabled = false;
                        this.txtRouterName.ReadOnly = true;
                    }
                    SKT.LeanMES.Router.Model.RouterInfo model = new SKT.LeanMES.Router.BLL.Router().GetInfo(rId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        protected void BindRouterStatus()
        {
            this.ddlRouterStatus.DataSource = SKT.LeanMES.Web.Utility.EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.Router.Model.EnumRouterStatus));
            this.ddlRouterStatus.DataTextField = "text";
            this.ddlRouterStatus.DataValueField = "value";
            this.ddlRouterStatus.DataBind();
        }

        protected SKT.LeanMES.Router.Model.RouterInfo PageData
        {
            set
            {
                this.txtRouterName.Text = string.Equals(this.IsCopy, "1") ? string.Concat(Resources.Buttons.COM_Copy, " - ", value.R_Name) : value.R_Name;
                this.txtDescription.Text = value.R_Description;
                this.ddlRouterStatus.SelectedValue = value.R_Status.ToString();
            }
        }
    }
}