using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Accessories.Model;


namespace SKT.LeanMES.Web.Accessories
{
    public partial class SolderLogEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceSolderLog));


            Int32 BarID = Convert.ToInt32(Request.QueryString["ID"]);
            this.divUserHtml.Visible = false;
            if (Request.QueryString["name"] == "Accessories_MakeUseOf")
            {
                this.divUserHtml.Visible = true;
            }

            if (!this.IsPostBack)
            {
                if (BarID != -1)
                {
                    SKT.LeanMES.Accessories.BLL.SOLDBARCODE bll = new SKT.LeanMES.Accessories.BLL.SOLDBARCODE();
                    SKT.LeanMES.Accessories.Model.SOLDBARCODEInfo model = null;
                    model = bll.GetInfo(BarID);
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
        /// 
        private SOLDBARCODEInfo PageData
        {
            set
            {
                this.lblBarCode.Text = value.BARCODE;                
            }
        }
    }
}