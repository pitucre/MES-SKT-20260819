using SKT.LeanMES.Kanban.Model;
using SKT.LeanMES.Kanban.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Kanban.Builtin
{
    public partial class KanbanCarouselConfigEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));

            if (!IsPostBack)
            {
                string strCarouselConfigId = Request.QueryString["carouselConfigId"];
                int carouselConfigId;
                if (strCarouselConfigId != "-1" && int.TryParse(strCarouselConfigId, out carouselConfigId))
                {
                    this.hidCarouselConfigId.Value = carouselConfigId.ToString();

                    KanBanCarouselConfig bll = new KanBanCarouselConfig();
                    var entity = bll.GetInfo(new KanBanCarouselConfigInfo { CarouselConfigId = carouselConfigId });
                    if (entity != null)
                    {
                        this.txtCarouselName.Text = entity.CarouselName;
                        this.txtCarouselTime.Text = entity.CarouselTime.ToString();
                        this.txtRemark.Text = entity.Remark;
                    }
                }
            }
        }
    }
}