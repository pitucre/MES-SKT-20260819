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
    public partial class StockCarEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxStock));
            if (!this.IsPostBack)
            {
                GetInfo();
                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;

                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    StockCar bll = new StockCar();
                    StockCarInfo model = null;
                    model = bll.GetInfo(Convert.ToInt32(Id));
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }


        /***绑定下拉框数据**/
        public void GetInfo()
        {
            /****获取备料车类型********/
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            StockCarType bll = new StockCarType();
            List<StockCarTypeInfo> model = bll.GetAll(0, 100, "StockTypeId",searchSettings);

            ddlStockType.DataSource = model;
            ddlStockType.DataTextField = "StockTypeName";
            ddlStockType.DataValueField = "StockTypeId";
            ddlStockType.DataBind();

            ddlStockType.Items.Insert(0, new ListItem("选择备料车类型", ""));
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private StockCarInfo PageData
        {
            set
            {
                this.txtTurnoverTypeCode.Text = value.StockCarNumber;
                this.ddlStockType.SelectedValue = value.StockTypeId.ToString();
                this.txtMaxQty.Text = value.MaxQty.ToString();
                this.txtMinQty.Text = value.MinQty.ToString();
                this.txtRemark.Text = value.Remark.ToString();
            }
        }

    }
}