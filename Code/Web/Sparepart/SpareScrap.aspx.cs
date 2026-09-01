using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Sparepart.Model;

namespace SKT.LeanMES.Web.Sparepart
{
    public partial class SpareScrap : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxSparepart));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.Sparepart.BLL.Sparepart()).GetInfo(Convert.ToInt32(idString));
                }
            }
            //SetOpType();
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SparepartInfo PageData
        {
            set
            {
                this.lblPartNickName.Text = value.PartNickName;
                this.labInStockQty.Text = Convert.ToString(value.InStockQty);
                this.labScrapQty.Text = Convert.ToString(value.ScrapQty);
            }
        }
    }
}