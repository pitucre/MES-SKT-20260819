using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class StationBomView : BasePage
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
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemBomId";
             

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " ItemBomId = " + bomId.ToString();
            this.Master.SearchSettings = searchSettings;

        }

        private SKT.LeanMES.Product.Model.ItemBomInfo PageData
        {
            set
            {
                this.lblItemName.Text = value.ItemName;
                this.lblItemCode.Text = value.ItemCode;
                this.lblVersion.Text = value.Version;
                this.lblStatus.Text = value.State.ToString() == "1" ? Resources.lang.InUse : Resources.lang.OutOfService;
                this.lblBomDesc.Text = value.Description;
                this.lblIsCurrentRev.Text = value.IsCurrentVer == true ? Resources.lang.CurrentVersion : "No "+Resources.lang.CurrentVersion;        
            }
        }
    }
}