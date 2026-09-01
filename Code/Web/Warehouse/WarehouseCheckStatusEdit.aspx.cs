using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.Warehouse
{
public partial class WarehouseCheckStatusEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCheckStatus));

        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new WarehouseCheckStatus()).GetInfo(Convert.ToInt32(idString));
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private WarehouseCheckStatusInfo PageData
    {
        set
        {
            this.txtWarehouseCheckStatusName.Text = value.WarehouseCheckStatusName;
        }
    }
  }
}