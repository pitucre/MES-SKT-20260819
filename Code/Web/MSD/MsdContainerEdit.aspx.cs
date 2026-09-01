using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MSD.BLL;

namespace SKT.LeanMES.Web.MSD
{
    public partial class MsdContainerEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMSD));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new MsdContainer()).GetInfo(Convert.ToInt32(idString));
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
        private SKT.LeanMES.MSD.Model.MsdContainerInfo PageData
        {
            set
            {
                this.ddlContainerType.SelectedValue = Convert.ToString(value.ContainerType);
                this.txtContainerCode.Text = value.ContainerCode;
                this.txtMaxTemp.Text = Convert.ToString(value.MaxTemp);
                this.txtMinTemp.Text = Convert.ToString(value.MinTemp);
                this.txtMaxQty.Text = Convert.ToString(value.MaxQty);                
                this.txtRemark.Text = value.Remark;
                this.txtContainerName.Text = value.ContainerName;
            }
        }
    }
}