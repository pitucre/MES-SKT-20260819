using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
public partial class EquipmentPositionEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentPosition));

        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new EquipmentPosition()).GetInfo(Convert.ToInt32(idString));
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private EquipmentPositionInfo PageData
    {
        set
        {
            this.txtPositionName.Text = value.PositionName;
            this.txtRemark.Text = value.Remark;
        }
    }
  }
}