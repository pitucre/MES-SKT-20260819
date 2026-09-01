using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Web.Quality
{
    public partial class RMAReciveView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string RMAID = Request.QueryString["ID"];
            if (!string.IsNullOrEmpty(RMAID))
            {
                PageData = (new Rma()).GetInfo(Convert.ToInt32(RMAID));
            }

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RMAUnitID";
            this.Master.DefaultSortExpression = "SN"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("RmaId", RMAID);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

        public RmaInfo PageData
        {
            set
            {
                this.lblRMANo.InnerText = value.RmaNo;
                this.lblCustomerName.InnerText = value.CustomerName;
                this.lblItemName.InnerText = value.MachineTypeName;
                this.lblItemCode.InnerText = value.ItemCode;
                this.lblItemSpec.InnerText = value.ItemSpec;
                this.lblNumber.InnerText = value.Number.ToString();
            }
        }
    }
}