using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using Newtonsoft.Json;
using System.Web.Script.Serialization;
using SKT.LeanMES.MaterialConfig.Model;
using System.IO;
using Newtonsoft.Json.Linq;


namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialInStorage : BasePage
    {
        private int columnIndex_InspectionResult = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_InspectionResult = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "InspectionResult"));

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " (1=1) ";

             Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "InspectionId";
            Master.DefaultSortExpression = "StorageTime";
            Master.DefaultSortDirection = SortDirection.Descending;
            Master.recordIDField = null;


            SKT.LeanMES.MaterialConfig.BLL.MaterialSourceConfig bll = new LeanMES.MaterialConfig.BLL.MaterialSourceConfig();
            String json = bll.GetMaterialSysConfig(5);

            json = json.Replace("[", "");
            json = json.Replace("]", "");
            Data data = JsonConvert.DeserializeObject<Data>(json);
            string ChoosePageId = data.data.ChoosePageId;
            //检验结果
            string inspectionResult = this.selInspectionResult.Value;
            if (inspectionResult != "")
            {
                if (string.Equals(inspectionResult, "1"))
                {
                    //合格
                    searchSettings.AddCondition("InspectionResult", inspectionResult);
                }
                else
                {
                    //不合格
                    searchSettings.ExtensionCondition += " AND InspectionResult IN (0,2)";
                }
            }
            //处理方式
            if (ddlIQCStatus.Value != "-1")
            {
                searchSettings.AddCondition("ManageResult", ddlIQCStatus.Value);
            }

            //if (int.Parse(ChoosePageId) == 1)
            //{  //需要入库确认
            //    //searchSettings.ExtensionCondition = "InspectionResult  IN (0,2) AND  IsStorage = 1 AND status = 4 ";
            //    //BirongLiang 2017-1-13
            //    searchSettings.ExtensionCondition += " AND IsStorage = 1 AND status = 4 ";
            //}
            //else //不需要入库确认
            //{
            //    //searchSettings.ExtensionCondition = "InspectionResult  IN (0,2) AND  IsStorage = 1 AND status <> 5 ";
            //    searchSettings.ExtensionCondition += "  AND IsStorage = 1 AND status <> 5 ";
            //}
            searchSettings.ExtensionCondition += " AND IsStorage = 1 AND status = 5 ";
            searchSettings.ExtensionCondition += "  AND QualifiedQty>0 ";

            //by beichangzhong  添加逻辑，列表只显示已经入库的IQC单或者正在入库的单据，不显示物料暂收未入库的单据
            searchSettings.ExtensionCondition += "  AND InStorageQty>0 ";
            searchSettings.AddCondition("InspectionNo", txtIQCNo.Text.Trim());
            searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());
            searchSettings.AddCondition("POCode", txtPOCode.Text.Trim());

            Master.SearchSettings = searchSettings;
            GridView1.PageIndex = 0;
            


        }


        public class Data
        {
            public Data1 data { get; set; }
        }
        public class Data1
        {
            public string ChoosePageId { get; set; }

            public string SearchCondition { get; set; }
            public string SourceName { get; set; }
        }



        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                switch (e.Row.Cells[columnIndex_InspectionResult].Text)
                {
                    case "0":
                        e.Row.Cells[columnIndex_InspectionResult].Text = "不合格";
                        break;
                    case "1":
                        e.Row.Cells[columnIndex_InspectionResult].Text = "合格";
                        break;
                    case "2":
                        e.Row.Cells[columnIndex_InspectionResult].Text = "不合格";
                        break;
                    default:
                        e.Row.Cells[columnIndex_InspectionResult].Text = "";
                        break;

                }
            }
        }
    }
}