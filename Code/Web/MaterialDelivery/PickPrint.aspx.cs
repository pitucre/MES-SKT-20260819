using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MaterialDelivery.Model;

namespace SKT.LeanMES.Web.MaterialDelivery
{
    public partial class PickPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxMaterialDelivery));
            Int32 pickId = Convert.ToInt32(Request.QueryString["ID"]);
            if (!this.IsPostBack)
            {
                if (pickId > 0)
                {
                    PickMaterialInfo model = new SKT.LeanMES.MaterialDelivery.BLL.PickMaterial().GetInfo(pickId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }
        public PickMaterialInfo PageData
        {
            set
            {
                this.lblPickNo.InnerText = value.PickCode;
                this.lblOrderNo.InnerText = value.OrderNo;
                this.lblCreateDateTime.InnerText = value.CreateDateTime.ToString();
                this.lblIssueQty.InnerText = value.Qty.ToString();
                this.lblIssueTo.InnerText = "";
                this.lblLineName.InnerText = value.LineName;
            }
        }
    }
}