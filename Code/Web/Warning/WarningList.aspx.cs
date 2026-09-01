using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warning
{
    public partial class WarningList : BasePage
    {
        private int columnIndex_WarningGroup = -1;
        private int columnIndex_MessageType = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_WarningGroup = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "WarningGroup")) + 1;
            columnIndex_MessageType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "MessageType")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarning));

            Boolean hasSearchSettings = false;
            hasSearchSettings = (this.txtWarningName.Text.Trim() != "") ? true : false;
            if (hasSearchSettings)
            {
                this.Master.SetSearchSettings = true;
            }
            else
            {
                this.Master.SetSearchSettings = false;
            }
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarningId";
            this.Master.DefaultSortExpression = "WarningId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("WarningName", this.txtWarningName.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Warning.BLL.Warning bll = new SKT.LeanMES.Warning.BLL.Warning();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //2改为columnIndex_WarningGroup
                string warningGroupStr = e.Row.Cells[columnIndex_WarningGroup].Text.Trim();
                string warningGroupText;
                switch (warningGroupStr)
                {
                    case "1":
                        warningGroupText = Resources.Enum.SystemWarning;
                        break;
                    case "2":
                        warningGroupText = Resources.Enum.ManufactureWarning;
                        break;
                    case "3":
                        warningGroupText = Resources.Enum.QualityWarning;
                        break;
                    default:
                        warningGroupText = String.Empty;
                        break;
                }
                e.Row.Cells[columnIndex_WarningGroup].Text = warningGroupText;


                /*string cycleTypeStr = e.Row.Cells[6].Text.Trim();
                string cycleTypeText;
                switch (cycleTypeStr)
                {
                    case "0":
                        cycleTypeText = "By Count";
                        break;
                    case "1":
                        cycleTypeText = "By Minute";
                        break;
                    case "2":
                        cycleTypeText = "By Hours";
                        break;
                    case "3":
                        cycleTypeText = "By Day";
                        break;
                    case "4":
                        cycleTypeText = "By Week";
                        break;
                    case "5":
                        cycleTypeText = "By Month";
                        break;
                    case "6":
                        cycleTypeText = "By Year";
                        break;
                    default:
                        cycleTypeText = String.Empty;
                        break;
                }
                e.Row.Cells[6].Text = cycleTypeText;*/

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //7改为columnIndex_MessageType
                string messageTypeStr = e.Row.Cells[columnIndex_MessageType].Text.Trim();
                string messageTypeText;
                switch (messageTypeStr)
                {
                    case "1":
                        messageTypeText = Resources.Enum.SMS;
                        break;
                    case "2":
                        messageTypeText = Resources.Enum.Email;
                        break;
                    case "3":
                        messageTypeText = Resources.Enum.Whistle;
                        break;
                    default:
                        messageTypeText = String.Empty;
                        break;
                }
                e.Row.Cells[columnIndex_MessageType].Text = messageTypeText;

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //10改为columnIndex_ModifyBy
                //11改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}