using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class AllMaterialHistoryList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaterialUnitId";
            this.Master.DefaultSortExpression = "CreateDateTime DESC";
            txtSerialNumber.Focus();

            string staus = this.ddlMaterialStatus.SelectedValue;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            searchSettings.AddCondition("SerialNumber", this.txtSerialNumber.Value.Trim());
            searchSettings.AddCondition("ItemCode", this.txtItemCode.Value.Trim());
            searchSettings.AddCondition("OperateOrder", this.txtActionOrder.Value.Trim());
            if (ddlMaterialStatus.SelectedValue != "-99")
            {
                searchSettings.AddCondition("ActionId", ddlMaterialStatus.SelectedValue);
            }
            searchSettings.ExtensionCondition = " 1=1 ";
            if (txtDateFrom.Value.Trim() != "")
            {
                searchSettings.ExtensionCondition += " AND CreateDateTime >=CONVERT(DATETIME, '" + txtDateFrom.Value.Trim() + "')";
            }
            if (txtDateTo.Value.Trim() != "")
            {
                var endTime = Convert.ToDateTime(txtDateTo.Value);
                var endTimeStr = endTime.AddDays(1).ToString("yyyy-MM-dd");
                searchSettings.ExtensionCondition += " AND CreateDateTime < CONVERT(DATETIME, '" + endTimeStr + "')";
            }
            //searchSettings.AddCondition("ItemCode", this.txtDateFrom.Value.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (!IsPostBack)
            {
                bindDropMaterialStatus();
            }
        }


        //操作类型数据绑定
        public void bindDropMaterialStatus()
        {

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            List<SKT.LeanMES.Material.Model.MaterialUnitInfo> materialUnit = new SKT.LeanMES.Material.BLL.MaterialUnit().GetMaterialAllAction(0, -1, "", searchSettings);
            ddlMaterialStatus.DataSource = materialUnit;
            ddlMaterialStatus.DataTextField = "MaterialStatus";
            ddlMaterialStatus.DataValueField = "StatusId";
            ddlMaterialStatus.DataBind();
            this.ddlMaterialStatus.Items.Insert(0, new ListItem(Resources.lang.Choose, "-99"));
        }


    }
}