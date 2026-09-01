using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialGrnShow : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ItemId = "";
            if (Request.QueryString["ID"] != null)
            {
                ItemId = Request.QueryString["ID"].ToString();
            }
            if (IsPostBack)
            {
                GetItemInfo(ItemId);
            }
            else
            {
                GetItemInfo(ItemId);                
            }

        }
        public void GetItemInfo(string ItemId) 
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaterialUnitId";
            this.Master.DefaultSortExpression = " StorageDate  ASC ";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " PartId =" + ItemId + " And  [Status] = 4  And  BalanceQty > 0 ";
            this.Master.SearchSettings = searchSettings;
        }
    }
}