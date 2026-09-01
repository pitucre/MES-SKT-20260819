using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
public partial class EquipmentMouldRelationEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentMouldRelation));

        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new EquipmentMouldRelation()).GetInfo(Convert.ToInt32(idString));
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private EquipmentMouldRelationInfo PageData
    {
        set
        {
                //this.txtItemCode.Text = value.ItemCode;
                HiddenEquimentId.Value = value.EquimentId.ToString();
               this.txtEqCode.Text = value.EquimentCode;
        }
    }
  }
}