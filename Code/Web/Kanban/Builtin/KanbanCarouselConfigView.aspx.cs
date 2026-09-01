using SKT.LeanMES.Kanban.BLL;
using SKT.LeanMES.Kanban.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Kanban.Builtin
{
    public partial class KanbanCarouselConfigView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strCarouselConfigId = Request.QueryString["carouselConfigId"];
            int carouselConfigId;
            if (!int.TryParse(strCarouselConfigId, out carouselConfigId))
            {
                WebHelper.ShowMessage("参数格式不正确");
                return;
            }

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "CarouselConfigDetailId";
            this.Master.DefaultSortExpression = "Sequence";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "kcd.CarouselConfigId = " + carouselConfigId;
            this.Master.SearchSettings = searchSettings;

            if (!IsPostBack)
            {
                KanBanCarouselConfig bll = new KanBanCarouselConfig();
                var entity = bll.GetInfo(new KanBanCarouselConfigInfo { CarouselConfigId = carouselConfigId });
                if (entity != null)
                {
                    this.ltrCarouselName.Text = entity.CarouselName;
                    this.ltrCarouselTime.Text = entity.CarouselTime.ToString();
                    this.ltrRemark.Text = entity.Remark;
                }
            }

        }
    }
}