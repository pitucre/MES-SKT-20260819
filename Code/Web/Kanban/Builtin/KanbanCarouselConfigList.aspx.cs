using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Kanban.Builtin
{
    public partial class KanbanCarouselConfigList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanbanManage));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "CarouselConfigId";
            this.Master.DefaultSortExpression = "ModifyDateTime DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            string carouselName = this.txtCarouselName.Text.Replace("'", string.Empty).Trim();
            if (carouselName.Length > 0)
            {
                searchSettings.AddCondition("CarouselName", carouselName);
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}