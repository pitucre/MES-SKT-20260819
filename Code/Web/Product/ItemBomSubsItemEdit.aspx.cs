using SKT.LeanMES.Product.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemBomSubsItemEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int bomId = -1;
            string idStr = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
            int.TryParse(idStr, out bomId);

            if (bomId != -1)
            {
                var entity = new ItemBom().GetInfo(bomId);
                if (entity != null)
                {
                    PageData = entity;
                }
            }
        }

        private SKT.LeanMES.Product.Model.ItemBomInfo PageData
        {
            set
            {
                this.lblItemName.Text = value.ItemName;
                this.lblItemCode.Text = value.ItemCode;
                this.lblVersion.Text = value.Version;
                this.lblBomName.Text = value.BomName;                
                this.lblIsCurrentRev.Text = value.IsCurrentVer == true ? "当前版本" : "非当前版本";

            }
        }
    }
}