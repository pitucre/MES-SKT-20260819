using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.PieceWage.BLL;
using SKT.LeanMES.PieceWage.Model;

namespace SKT.LeanMES.Web.PieceWage
{
    public partial class StationOutputRateEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)

        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPieceWage));
            if (!this.IsPostBack)
            {

                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.PieceWage.BLL.StationOutputRate()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private StationOutputRateInfo PageData
        {
            set
            {
                this.hdStationID.Value = Convert.ToString(value.StationID);
                this.txtStation.Text = value.Station;
                this.hdnProductTypeId.Value = Convert.ToString(value.ProductTypeID);
                this.txtProductType.Text = value.ProductType;
                this.txtStartRate.Text = Convert.ToString(value.StartRate);
                this.txtEndRate.Text = Convert.ToString(value.EndRate);
                this.txtCoefficient.Text = Convert.ToString(value.Coefficient);
                this.txtRemark.Text = value.Remark;
               
            }
        }
    }
}