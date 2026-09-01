using SKT.LeanMES.Wave.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Wave
{
    public partial class InterfaceManagementDefEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInterfaceManagement));
            BindContent();
            BindSegment();
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new AjaxInterfaceManagement()).GetInterfaceManagementDefById(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }

                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private InterfaceManagementDefInfo PageData
        {
            set
            {

                this.txtRow.Text = (value.Rows.ToString() == "-1" ? "*" : value.Rows.ToString());
                this.ddlSegment.SelectedValue = ("第" + value.Segment.ToString() + "段");
                this.ddlContent.SelectedValue = value.Contents;
            }
        }

        protected void BindContent()
        {
            AjaxInterfaceManagement bll = new AjaxInterfaceManagement();
            this.ddlContent.DataSource = bll.GetContentALL();
            this.ddlContent.DataTextField = "Name";
            this.ddlContent.DataValueField = "Name";
            this.ddlContent.DataBind();
        }

        protected void BindSegment()
        {
            AjaxInterfaceManagement bll = new AjaxInterfaceManagement();
            this.ddlSegment.DataSource = bll.GetSegment();
            this.ddlSegment.DataTextField = "Name";
            this.ddlSegment.DataValueField = "Name";
            this.ddlSegment.DataBind();
        }
    }
}