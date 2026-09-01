using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class PartList : BasePage
    {
        private int columnIndex_CurrentStock = -1;
        private int columnIndex_MinStock = -1;
        private int columnIndex_MaxStock = -1;
        private int columnIndex_PartLive = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPart));

            columnIndex_CurrentStock = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CurrentStock")) + 1;
            columnIndex_MinStock = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "MinStock")) + 1;
            columnIndex_MaxStock = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "MaxStock")) + 1;
            columnIndex_PartLive = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "PartLive")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PartId";
            this.Master.DefaultSortExpression = "PartId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("PartCode", txtPartCode.Text);
            searchSettings.AddCondition("PartName", txtPartName.Text);
            //生产厂商
            searchSettings.AddCondition("FactoryName", txtFactoryName.Text);
            searchSettings.AddCondition("EquipmentTypeName", ddlEquipmentType.Text);
            
            //供应商
         
           searchSettings.AddCondition("VendorName", txtPartSupplierName.Text);
            
           
            //存放位置
      
            searchSettings.AddCondition("PositionName", txtPosition.Text);
           

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Equipment.BLL.Part bll = new SKT.LeanMES.Equipment.BLL.Part();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Int32 cellNum=0;
                //cellNum=Convert.ToInt32(e.Row.Cells[14].Text);
                //switch (cellNum)
                //{
                //    case 0:
                //        e.Row.Cells[14].Text = "新购买";
                //        break;
                //    case 1:
                //        e.Row.Cells[14].Text = "维修中";
                //        break;
                //    case 2:
                //        e.Row.Cells[14].Text = "保养中";
                //        break;
                //    case 3:
                //        e.Row.Cells[14].Text = "故障中";
                //        break;
                //    case 4:
                //        e.Row.Cells[14].Text = "报废";
                //        break;
                //    default:
                //        e.Row.Cells[14].Text = "";
                //        break;
                //}

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //7改为columnIndex_MinStock
                //8改为columnIndex_MaxStock
                //6改为columnIndex_CurrentStock
                var minStock = Convert.ToInt32(e.Row.Cells[columnIndex_MinStock].Text);  //最小库存
                var maxStock = Convert.ToInt32(e.Row.Cells[columnIndex_MaxStock].Text);  //最大库存
                var curStock = Convert.ToInt32(e.Row.Cells[columnIndex_CurrentStock].Text);  //当前库存

                if (minStock != 0)
                {
                    if (curStock < minStock)
                    {
                        e.Row.BackColor = System.Drawing.Color.Red;
                    }
                }
                if (maxStock != 0)
                {
                    if (curStock > maxStock)
                    {
                        e.Row.BackColor = System.Drawing.Color.Red;
                    }
                }
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //12改为columnIndex_PartLive
                //16改为columnIndex_ModifyBy
                //17改为columnIndex_ModifyDateTime
                e.Row.Cells[columnIndex_PartLive].Text = e.Row.Cells[columnIndex_PartLive].Text.Replace(',', ' ');

                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}