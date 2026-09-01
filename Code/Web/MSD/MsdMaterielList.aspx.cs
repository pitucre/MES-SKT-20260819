using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MSD.BLL;

namespace SKT.LeanMES.Web.MSD
{
    public partial class MsdMaterielList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemID";
            this.Master.DefaultSortExpression = "ItemID DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            searchSettings.AddCondition("IsMSD", "1");
            searchSettings.AddCondition("ItemCode", this.txtItemCode.Text.Trim().Replace("'", "''"));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.MSD.BLL.MsdMateriel bll = new SKT.LeanMES.MSD.BLL.MsdMateriel();
                    bll.Delele(Convert.ToInt32(Request.Form["hdnIdString"].ToString()));
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }
    }
}