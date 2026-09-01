using System;
using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
public partial class EquipmentChildEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(EquipmentChildEdit));

        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new EquipmentChild()).GetInfo(Convert.ToInt32(idString));
            }
        }
    }

        [AjaxMethod]
        public void EquipmentChildEditInfo(EquipmentChildInfo entity)
        {
            try
            {
                new EquipmentChild().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentChildInfo PageData
    {
        set
        {

            this.txtEquipmentName.Text = value.EquipmentName;
            this.HiddenEquipmentId.Value = value.ParentEquipmentId.ToString();
            this.txtEquipmentNameChild.Text = value.EquipmentNameChild;
            this.txtEquipmentCodeChild.Text = value.EquipmentCodeChild;
            this.txtTypeSpec.Text = value.TypeSpec;
            this.txtRemark.Text = value.Remark;
        }
    }
  }
}