using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;
using System.Data;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldChangeApplyList : BasePage
    {
        private int columnIndex_Status = -1;
        private int columnIndex_Operator = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;
            columnIndex_Operator = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Operator")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));

            //后台赋值只读，避免postback时控件值丢失的问题
            txtCreateBy.Attributes.Add("Readonly", "True");
            txtAffirmUser.Attributes.Add("Readonly", "True");
            txtOperator.Attributes.Add("Readonly", "True");

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Cid";
            this.Master.DefaultSortExpression = "Cid";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " (1=1) ";
            searchSettings.AddCondition("ApplyNo", Server.HtmlEncode(this.txtApplyNo.Text));
            searchSettings.AddCondition("ItemName", Server.HtmlEncode(this.txtItemName.Text));
            searchSettings.AddCondition("ItemCode", Server.HtmlEncode(this.txtItemCode.Text));
            searchSettings.AddCondition("EquipmentCode", Server.HtmlEncode(this.txtEquipmentCode.Text));
            searchSettings.AddCondition("EquipmentName", Server.HtmlEncode(this.txtEquipmentName.Text));
            searchSettings.AddCondition("CreateBy", Server.HtmlEncode(this.hdCreateBy.Value));
            searchSettings.AddCondition("AffirmUserName", Server.HtmlEncode(this.hdAffirmUser.Value));
            //处理换模人
            var operators = Server.HtmlEncode(this.hdOperator.Value);
            if (!string.IsNullOrEmpty(operators))
            {
                searchSettings.ExtensionCondition += " AND CHARINDEX(','+ '" + Server.HtmlEncode(this.hdOperator.Value) + "' +','  ,  ','+ Operator +',') > 0 ";
            }
            if (this.ddlStatus.SelectedValue != "-1")
            {
                searchSettings.AddCondition("Status", ddlStatus.SelectedValue);
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        MoludApply bll = new MoludApply();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
                if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    DataTable tb = new DataTable();
                    String equipmentCode = txtEquipmentCode.Text;
                    String equipmentName = txtEquipmentName.Text;
                    int equipStatus = -1;
                    //if (ddlEquipmentStatus.SelectedValue != "-1")
                    //{
                    //    equipStatus = Convert.ToInt32(ddlEquipmentStatus.SelectedValue);
                    //}
                    tb = BindData(equipmentCode, equipmentName, equipStatus);
                    if (tb != null)
                    {
                        ExportExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmss"));
                        // ExportToSpreadsheet(tb, DateTime.Now.ToShortDateString());
                    }
                }
               
            }


        }


        /// <summary>
        /// 导出Excel add zx 2017-08-30
        /// </summary>
        /// <param name="table"></param>
        /// <param name="name"></param>
        public static void ExportExcel(DataTable table, string name)
        {
            HttpContext context = HttpContext.Current;
            var book = new NPOI.HSSF.UserModel.HSSFWorkbook();

            //添加一个sheet
            var sheet1 = book.CreateSheet("设备列表");
            //给sheet1添加第一行的头部标题
            var row1 = sheet1.CreateRow(0);
            int rowId = 0;
            foreach (DataColumn column in table.Columns)
            {
                row1.CreateCell(rowId).SetCellValue(column.ColumnName);
                rowId++;
            }

            //创建值
            for (var i = 0; i < table.Rows.Count; i++)
            {
                var rowId2 = 0;
                NPOI.SS.UserModel.IRow rowtemp = sheet1.CreateRow(i + 1);
                foreach (DataColumn column in table.Columns)
                {
                    rowtemp.CreateCell(rowId2).SetCellValue(table.Rows[i][rowId2].ToString());
                    rowId2++;
                }

            }

            // 写入到客户端
            var ms = new System.IO.MemoryStream();
            book.Write(ms);
            context.Response.ContentType = "application/vnd.ms-excel";
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
            context.Response.BinaryWrite(ms.ToArray());

        }



        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(String code, String name,int status)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            SKT.LeanMES.Equipment.BLL.Equipments bll = new SKT.LeanMES.Equipment.BLL.Equipments();
            tb = bll.ImportToExcel(code, name,status);

            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_Status
                //7改为columnIndex_Operator
                Int32 cellNum = 0;
                cellNum = Convert.ToInt32(e.Row.Cells[columnIndex_Status].Text);
                switch (cellNum)
                {
                    case 0:
                        e.Row.Cells[columnIndex_Status].Text = "新申请";
                        break;
                    case 1:
                        e.Row.Cells[columnIndex_Status].Text = "待换模";
                        break;
                    case 2:
                        e.Row.Cells[columnIndex_Status].Text = "换模中";
                        break;
                    case 3:
                        e.Row.Cells[columnIndex_Status].Text = "已完成";
                        break;

                    default:
                        e.Row.Cells[columnIndex_Status].Text = "";
                        break;
                }

                //获取换模人
                string userNames = e.Row.Cells[columnIndex_Operator].Text;
                if (!string.IsNullOrEmpty(userNames))
                {
                    var listUserName = userNames.Split(new char[] { ',' }).ToList();
                    var listUserCName = new List<string>();

                    foreach (var item in listUserName)
                    {
                        MembershipInfo userInfo = user.GetInfo(item);
                        listUserCName.Add((userInfo == null) ? "" : userInfo.EmployeeCName);
                    }
                    e.Row.Cells[columnIndex_Operator].Text = string.Join(",", listUserCName);
                }
            }
        }
    }
}