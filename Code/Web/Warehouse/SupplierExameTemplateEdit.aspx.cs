using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class SupplierExameTemplateEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSupplierExame));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SupplierExameTemplet()).GetInfo(Convert.ToInt32(idString));

                    System.Collections.Generic.List<SupplierExameTempletDtlInfo> lstTemplateDtl = (new SupplierExameTemplet()).GetTemplateDtlById(Convert.ToInt32(idString));
                    if (lstTemplateDtl!= null && lstTemplateDtl.Count > 0)
                    {
                        hdnIsBeUsed.Value = "1";
                    }
                }
                else
                {
                    try
                    {
                        SKT.LeanMES.Material.BLL.MaterialUnit MaterialUnit = new LeanMES.Material.BLL.MaterialUnit();
                        txtSupplierExameTempletCode.Value = MaterialUnit.GetMaterialStorageNo(-31);
                    }
                    catch(Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SupplierExameTempletInfo PageData
        {
            set
            {
                txtSupplierExameTempletCode.Value = value.SupplierExameTempletCode;
                txtSupplierExameTempletName.Value = value.SupplierExameTempletName;
                ddlIsEnable.SelectedValue = value.IsEnable;
                ddlSupplierExameTempletType.SelectedValue = value.SupplierExameTempletType;
                txtDescription.Text = value.Description;
                cbIsALLSupplier.Checked = value.IsAllSupplier == 0 ? false : true;
            }
        }
    }
}