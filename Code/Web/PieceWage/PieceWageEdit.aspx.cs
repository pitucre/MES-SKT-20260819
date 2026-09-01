using System;
using SKT.LeanMES.PieceWage.BLL;
using SKT.LeanMES.PieceWage.Model;

namespace SKT.LeanMES.Web.PieceWage
{
    public partial class PieceWageEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPieceWage));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.PieceWage.BLL.PieceWage()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PieceWageInfo PageData
        {
            set
            {
                this.hdStationID.Value = Convert.ToString(value.StationId);
                this.txtStation.Text = value.Station;
                this.hdEquipmentID.Value = Convert.ToString(value.EquipmentId);
                this.txtEquipmentCode.Text = value.EquipmentCode;
                this.hdnItemId.Value = Convert.ToString(value.ItemId);
                this.txtItemCode.Text = value.ItemCode;
                this.txtPrice.Text = Convert.ToString(value.Price);
                this.txtRemark.Text = value.Remark;
                this.txtNO.Text = value.NO;
            }
        }
    }
}