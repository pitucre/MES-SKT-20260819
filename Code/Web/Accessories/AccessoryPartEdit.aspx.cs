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
    public partial class AccessoryPartEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAccessoryPart));
            Int32 PID = Convert.ToInt32(Request.QueryString["ID"]);

            if (!this.IsPostBack)
            {
                if (PID != -1)
                {
                    SKT.LeanMES.Accessories.BLL.AccessoryPart bll = new SKT.LeanMES.Accessories.BLL.AccessoryPart();
                    SKT.LeanMES.Accessories.Model.AccessoryPartInfo model = null;
                    model = bll.GetInfo(PID);
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
        private AccessoryPartInfo PageData
        {
            set
            {
                this.txtItemName.Text = value.ItemName;
                //this.txtPrinterRegular.Text = value.LeedFree;
            }
        }
    }
}