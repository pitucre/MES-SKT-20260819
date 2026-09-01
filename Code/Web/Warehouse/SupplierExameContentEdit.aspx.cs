using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class SupplierExameContentEdit : BasePage
    {
        public int parentId = -1;
        public string parentName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSupplierExame));

            txtSupplierExameCompute.Attributes.Add("placeholder", "存储过程");

            var bll = new SupplierExameContent();
            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);
                if (id == -1)
                {
                    parentName = Request["parentName"];
                    parentId = Convert.ToInt32(Request["parentId"]);
                }
                if (id > 0)
                {
                    PageData = bll.GetInfo(id);
                }
            }
        }
        protected SupplierExameContentInfo PageData
        {
            set
            {
                txtSupplierExameContentId.Value = value.SupplierExameContentId.ToString();
                txtHideCreater.Value = value.Creater;
                txtDescription.Text = value.Description;
                txtSupplierExameName.Text = value.SupplierExameName;
                ddlIsEnable.SelectedIndex = value.IsEnable ? 0 : 1;
                parentId = value.ParentId;
                parentName = value.ParentName;
                Sorting.Text = value.Sorting + "";
                txtSupplierExameCompute.Text = value.SupplierExameCompute;
                ddlSupplierExameType.SelectedValue = value.SupplierExameType.ToString();
            }
        }
    }
}