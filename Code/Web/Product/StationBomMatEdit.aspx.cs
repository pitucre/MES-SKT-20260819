using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class StationBomMatEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            int stationInBomId = Convert.ToInt32(Request.QueryString["ID"]);
            if (stationInBomId > 0)
            {
                var entity = (new SKT.LeanMES.Product.BLL.StationInBom()).GetInfo(stationInBomId);
                if (entity != null)
                {
                    this.PageData = entity;
                }
            }
        }

        private SKT.LeanMES.Product.Model.StationInBomInfo PageData
        {
            set
            {
                this.hdnItemChildBomId.Value = value.ItemBomChildId.ToString();
                this.txtItemCode.Text = value.ItemCode;
                this.txtItemBomName.Text = value.BomName;
                this.hdnItemBomId.Value = value.ItemBomId.ToString();
                this.txtStation.Text = value.Station;
                this.hdnStationId.Value = value.StationId.ToString();
                this.txtDataTypeId.Text = value.DataTypeName;
                this.hidDataTypeId.Value = value.DataTypeId.ToString();
            }
        }
    }
}