using System;
using SKT.LeanMES.Factory.BLL;
using SKT.LeanMES.Factory.Model;

namespace SKT.LeanMES.Web.Factory
{
public partial class FactoryEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxFactory));

        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new SKT.LeanMES.Factory.BLL.Factory()).GetInfo(Convert.ToInt32(idString));
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private FactoryInfo PageData
    {
        set
        {
            this.txtFactoryName.Text = value.FactoryName;
            this.txtFactoryCode.Text = value.FactoryCode;
            this.txtFactoryCode.Enabled = false;
            this.txtRemark.Text = value.Remark;
            this.chkIsDefaultFactory.Checked = value.ChkIsDefaultFactory.ToString() == "1" ? true : false;
               
         }
    }
  }
}