using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemBomView : BasePage
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
                this.Master.PageGridView = this.GridView1;
                this.Master.PageObjectDataSource = this.ObjectDataSource1;
                this.Master.RecordIDField = "ItemBomChildId";
                //this.Master.DefaultSortExpression = "ItemLevel";

                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                searchSettings.ExtensionCondition = "State=1 and ItemBomId = " + bomId;
                this.Master.SearchSettings = searchSettings;
            }
        }

        private SKT.LeanMES.Product.Model.ItemBomInfo PageData
        {
            set
            {
                this.lblItemName.Text = value.ItemName;
                this.lblItemCode.Text = value.ItemCode;
                this.lblVersion.Text = value.Version;
                this.lblStatus.Text = value.State.ToString()=="1"?"在用":"停用";
                this.lblBomDesc.Text = value.Description;
                this.lblIsCurrentRev.Text = value.IsCurrentVer == true ? "当前版本" : "非当前版本";

            }
        }
    }
}