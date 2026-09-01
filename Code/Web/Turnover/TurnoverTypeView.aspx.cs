using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Turnover.BLL;
using SKT.LeanMES.Turnover.Model;

namespace SKT.LeanMES.Web.Turnover
{
    public partial class TurnoverTypeView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                this.lblTurnoverTypeCode.Text = value.TurnoverTypeCode;
                this.lblTurnoverTypeName.Text = value.TurnoverTypeName;
            }
        }

    }
}