using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Warehouse
{
public partial class WarehouseCheckTypeEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCheckType));

        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new WarehouseCheckType()).GetInfo(Convert.ToInt32(idString));
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private WarehouseCheckTypeInfo PageData
    {
        set
        {
            //this.txtErpCode.Text = Convert.ToString(value.ErpCode);
            this.txtWarehouseCheckTypeName.Text = value.WarehouseCheckTypeName;
            this.txtDescribe.Text = value.Describe;
        }
    }
  }
}