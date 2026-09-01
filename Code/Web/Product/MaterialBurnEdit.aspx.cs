using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Molding.BLL;
using SKT.LeanMES.Molding.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class MaterialBurnEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMolding));
            txtReceiveDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new MaterialBurn()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MaterialBurnInfo PageData
        {
            set
            {
                this.txtSoftName.Text = value.SoftName;
                this.txtTestMachine.Text = value.TestMachine;
                this.txtCustomer.Text = value.Customer;
                lblFileName.Text = value.Filename;
                this.txtVerifyCode.Text = value.VerifyCode;
                this.txtReceiveDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.ReceiveDate);
                this.txtUpdateContent.Text = value.UpdateContent;
                this.txtSoftPath.Text = value.SoftPath;
                this.txtDownloadDir.Text = value.DownloadDir;
                this.txtRemark.Text = value.Remark;
                this.txtSoftCreator.Text = value.SoftCreator;
            }
        }
    }
}