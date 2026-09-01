using System;
using SKT.LeanMES.Maintenance.Model;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;

namespace SKT.LeanMES.Web.Product
{
public partial class ExpirationDateEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.ExpirationDate));
        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                    PageData = (new ExpirationDate().GetInfo(Convert.ToInt32(idString))) ;
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private ExpirationDateInfo PageData
    {
        set
        {
            this.txtExpirationDateName.Text = value.ExpirationDateName;
            this.txtRemark.Text = value.Remark;
        }
    }
  }
}