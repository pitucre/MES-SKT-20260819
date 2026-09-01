using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Station.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class StationParamView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));

            string IdStr = Request.QueryString["ID"].ToString();
            //string staId = Request.QueryString["StationId"].ToString();
            int Id;
            //int sId;
            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                ItemInfo model = (new Item()).GetInfo(Id);

                this.lblItemName.Text = model.ItemName;
                //this.lblItemCode.Text = model.ItemCode;
            }
            //if (int.TryParse(staId, out sId) && sId > 0)
            //{
            //    SKT.LeanMES.Station.BLL.Station bll = new LeanMES.Station.BLL.Station();
            //    StationInfo model = bll.GetInfo(sId);
            //    this.hdnStationId.Value = model.StationId.ToString();
            //    this.txtStation.Text = model.Station;
            //}
        }
    }
}