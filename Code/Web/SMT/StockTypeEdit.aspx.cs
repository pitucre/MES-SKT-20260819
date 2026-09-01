using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Turnover.BLL;
using SKT.LeanMES.Turnover.Model;

namespace SKT.LeanMES.Web.SMT
{
    public partial class StockTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxStock));
            if (!this.IsPostBack)
            {
                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;

                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    StockCarType bll = new StockCarType();
                    StockCarTypeInfo model = null;
                    model = bll.GetInfo(Convert.ToInt32(Id));
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private StockCarTypeInfo PageData
        {
            set
            {
                this.txtTurnoverTypeCode.Text = value.StockTypeCode;
                this.txtTurnoverTypeName.Text = value.StockTypeName;
            }
        }

    }
}