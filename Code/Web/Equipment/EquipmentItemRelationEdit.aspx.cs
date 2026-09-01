using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
public partial class EquipmentItemRelationEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentItemRelation));

        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new EquipmentItemRelation()).GetInfo(Convert.ToInt32(idString));
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private EquipmentItemRelationInfo PageData
    {
        set
        {
            //this.txtItemCode.Text = value.ItemCode;
            hdeqCode.Value = value.EqCode;
            this.txtEqCode.Text = value.EqCode;
        }
    }
  }
}