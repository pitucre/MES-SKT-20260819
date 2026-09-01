using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Material
{
    public partial class PrepareMaterialView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));
            Int32 preprareMatId = Convert.ToInt32(Request.QueryString["ID"]);
            if (preprareMatId > 0)
            {
                this.PageData = (new PrepareMatForm()).ShowPrepareMatFormInfo(preprareMatId);
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PrepareMatFormInfo PageData
        {
            set
            {
                this.Label1.Text = value.MOCode;
                this.lblItemCode.Text = "";
                this.lblDeptName.Text = value.DepName;
                this.lblWhName.Text = value.WhCode;
                this.lblUserDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.PMDate);
                this.lblRemark.Text = value.Remark;
            }
        }
    }
}