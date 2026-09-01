using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Detection
{
    public partial class DetectionRecordsList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "DetectionRecordsId";
            this.Master.DefaultSortExpression = "DetectionRecordsId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (this.txtDetectionCode.Text != "")
            {
                searchSettings.AddCondition("DetectionCode", this.txtDetectionCode.Text.Trim());
            }
            if (this.txtOrderNo.Text != "")
            {
                searchSettings.AddCondition("OrderNo", this.txtOrderNo.Text.Trim());
            }
            if (this.txtSN.Text != "")
            {
                searchSettings.AddCondition("SN", this.txtSN.Text.Trim());
            }
            if (this.txtEquipment.Text != "")
            {
                searchSettings.AddCondition("EquipmentCode", this.txtEquipment.Text.Trim());
            }
            if (this.txtStation.Text != "")
            {
                searchSettings.AddCondition("Station", this.txtStation.Text.Trim());
            }
            if (this.txtResName.Text != "")
            {
                searchSettings.AddCondition("ResName", this.txtResName.Text.Trim());
            }

            if (this.IsPostBack)
            {
                if (txtCheckBeginTime.Text.Trim() == "")
                {
                    //txtCheckBeginTime.Text = DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd");
                }
                if (txtCheckEndTime.Text.Trim() == "")
                {
                    //txtCheckEndTime.Text = DateTime.Now.ToString("yyyy-MM-dd");
                }
            }
            

            if (txtCheckBeginTime.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += (searchSettings.ExtensionCondition == "" ? " " : " and ") + "  CreateTime >=" + Convert.ToDateTime(txtCheckBeginTime.Text.Trim()).ToString("yyyy-MM-dd");
            }
           
            if (txtCheckEndTime.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += (searchSettings.ExtensionCondition == "" ? " " : " and ") + "  CreateTime <=" + Convert.ToDateTime(txtCheckEndTime.Text.Trim()).ToString("yyyy-MM-dd");
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0; 
        }
    }
}