using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Shipment
{
    public partial class ShipmentList : BasePage
    {
        private int columnIndex_ItemId = -1;
        private int columnIndex_Qty = -1;
        private int columnIndex_Qtys = -1;
        private int columnIndex_State = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ItemId = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ItemId")) + 1;
            columnIndex_Qty = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Qty")) + 1;
            columnIndex_Qtys = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Qty")) + 1;
            columnIndex_State = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "State")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxShipment));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ShipmentId";
            this.Master.DefaultSortExpression = "ShipmentId DESC"; //也可不赋值
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //searchSettings.ExtensionCondition = strWhere;
            searchSettings.AddCondition("OrderNO", this.TextBox1.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"]!=null&&Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Shipment.BLL.Shipment bll = new SKT.LeanMES.Shipment.BLL.Shipment();
                    string id = Request.Form["hdnIdString"].ToString();
                    SKT.LeanMES.Shipment.Model.ShipmentInfo shipmentInfo = bll.GetInfo(Convert.ToInt32(id));

                    if (shipmentInfo != null && shipmentInfo.State == 1)
                    {
                        bll.Delete(id, AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    else
                    {
                        string stateName = shipmentInfo.State == 2 ? Resources.lang.Audited : Resources.lang.Shipments;
                        WebHelper.ShowMessage(stateName + Resources.Messages.NonOperational);
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //2改为columnIndex_ItemId
                //4改为columnIndex_Qtys
                int col1 = columnIndex_ItemId;
                int itemID = Convert.ToInt32(e.Row.Cells[col1].Text);
                SKT.LeanMES.Product.Model.ItemInfo itemInfo = new SKT.LeanMES.Product.BLL.Item().GetInfo(itemID);
                if (itemInfo != null)
                {
                    e.Row.Cells[col1].Text = itemInfo.ItemName;
                    e.Row.Cells[columnIndex_Qtys].Text = itemInfo.Units;
                }

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //6改为columnIndex_State
                int col2 = columnIndex_State;
                int stateID = Convert.ToInt32(e.Row.Cells[col2].Text);
                if (stateID == 1)
                {
                    e.Row.Cells[col2].Text = Resources.lang.Unaudited;
                }
                else if (stateID == 2)
                {
                    e.Row.Cells[col2].Text = Resources.lang.Audited; ;
                }
                else if (stateID == 3)
                {
                    e.Row.Cells[col2].Text = Resources.lang.Shipments; ; ;
                }

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //3改为columnIndex_Qty
                int col3 = columnIndex_Qty;
                string val = e.Row.Cells[col3].Text.ToString().TrimEnd('0');
                if (val.Substring(val.Length - 1, 1) == ".")
                {
                    val = val.Replace(".", "");
                }
                e.Row.Cells[col3].Text = val;
            }
        }
    }
}