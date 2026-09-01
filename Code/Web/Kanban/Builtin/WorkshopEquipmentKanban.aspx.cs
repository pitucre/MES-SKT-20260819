using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.WorkShop.Model;

namespace SKT.LeanMES.Web.Kanban.Builtin
{
    public partial class WorkshopEquipmentKanban : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["workshopId"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.WorkShop.BLL.WorkShop()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WorkShopInfo PageData
        {
            set
            {
                this.lblWorkShopName.Text = value.WorkShopName;
                this.lblShiftName.Text = value.ShiftName;
                this.lblUserName.Text = value.CName == "" ? "未设置" : value.CName;

            }
        }
    }
}