using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Turnover.BLL;
using SKT.LeanMES.Turnover.Model;
using SKT.LeanMES.Web.AjaxServices;


namespace SKT.LeanMES.Web.Turnover
{
    public partial class TurnoverTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxTurnover));
            if (!this.IsPostBack)
            {
                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;

                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    TurnoverType bll = new TurnoverType();
                    TurnoverTypeInfo model = null;
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
        private TurnoverTypeInfo PageData
        {
            set
            {
                this.txtTurnoverTypeCode.Text = value.TurnoverTypeCode;
                this.txtTurnoverTypeName.Text = value.TurnoverTypeName;
            }
        }

    }
}