using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SteelMesh.Model;
using SKT.LeanMES.Supplier.BLL;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteeOut : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxSteelHistory));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.SteelMesh.BLL.SteelMesh()).GetInfo(idString);
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SteelMeshInfo PageData
        {
            set
            {
                this.lbSteelMeshName.Text = value.SteelName;
                this.lbThick.Text = value.Thick.ToString();
                //供应商
                Suppliers sup = new Suppliers();
                this.lbVendor.Text = sup.GetInfo(value.Vendor).VendorName;

                this.lbEnterDate.Text = value.EnterFactory.ToShortDateString();
                this.lbBarNo.Text = value.VendorBarcode;
                this.lbUserCount.Text = value.UseCount.ToString();
                this.lbStandarLive.Text = value.StandarLive.ToString();
                this.lblCurPosition.Text = value.CurPosition;
                //出入库申请人
                //SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
                //this.lbOutPeople.Text = user.GetInfo(value.OutPeople).UserName;
                //this.lbInPeople.Text = user.GetInfo(value.InPeople).UserName;
            }
        }
    }
}