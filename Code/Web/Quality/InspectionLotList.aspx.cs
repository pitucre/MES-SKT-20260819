using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;
using SKT.LeanMES.ProductionCollection.Client;
using SKT.LeanMES.ProductionCollection.Model;
using System.Data;
using SKT.LeanMES.Quality.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionLotList : BasePage
    {
        ProdCollectionQC qcBll = new ProdCollectionQC();

        protected void Page_Load(object sender, EventArgs e)
        {
            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "InspectionLotId";
            Master.DefaultSortExpression = "CreateDateTime DESC,InspectionLotId DESC";
            if (IsPostBack)
            {
                var searchSettings = new SearchSettings();
                searchSettings.AddCondition("InspectionLotNo", txtInspectionLotNo.Text.Trim());
                if (this.ddlState.SelectedValue != "")
                {
                    searchSettings.AddCondition("StateId", this.ddlState.SelectedValue);
                }

                searchSettings.AddCondition("ItemCode", this.txtItemCode.Text.Trim());
                searchSettings.AddCondition("OrderNo", this.txtOrderNo.Text.Trim());
                if (this.ddlResultId.SelectedValue != "")
                {
                    searchSettings.AddCondition("ResultId", this.ddlResultId.SelectedValue);
                }
                string strWhere = "";
                string createDateTimeStart = this.txtCreateDateTimeStart.Text.Trim();
                string createDateTimeEnd = this.txtCreateDateTimeEnd.Text.Trim();
                if (createDateTimeStart != "" && createDateTimeEnd != "")
                {
                    try
                    {
                        if (DateTime.Parse(createDateTimeStart) > DateTime.Parse(createDateTimeEnd))
                        {
                            WebHelper.ShowMessage("开始时间不可大于结束时间！");
                            return;

                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage("请输入正确的时间！");
                    }
                }
                if (this.txtQCType.SelectedValue != "")
                {
                    strWhere += " SystemType=" + this.txtQCType.SelectedValue.Trim() + "";
                }
                if (createDateTimeStart != "")
                {
                    strWhere += String.IsNullOrEmpty(strWhere) ? " convert(varchar(10),CreateDateTime,120) >= '" + createDateTimeStart + "'" : " and convert(varchar(10),CreateDateTime,120) >= '" + createDateTimeStart + "'";
                }
                if (createDateTimeEnd != "")
                {
                    strWhere += String.IsNullOrEmpty(strWhere) ? " convert(varchar(10),CreateDateTime,120) <= '" + createDateTimeEnd + "'" : " and convert(varchar(10),CreateDateTime,120) <= '" + createDateTimeEnd + "'";
                }
           
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;
              
                Master.SearchSettings = searchSettings;
                GridView1.PageIndex = 0;
            }
            //取消锁定
            if (string.Equals(Request.Form["hdnOperate"], "cancelLock", StringComparison.CurrentCultureIgnoreCase))
            {
                try
                {
                    string idStr = Request.Form["hdnIdString"].ToString();
                    if (idStr != null)
                    {
                        var entity = new InspectionInfo { InspectionLotId = Convert.ToInt32(idStr), ModifyBy = AccountController.GetCurrentUser().UserName };
                        qcBll.CancelLock(entity);
                        WebHelper.ShowMessage("取消锁定成功！");
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                }
            }
           
            if (string.Equals(Request.Form["hdnOperate"], "exportexcel", StringComparison.CurrentCultureIgnoreCase))
            {
                DataTable tb = new DataTable();
                string IdStr = Request.Form["hdnIdString"].ToString();
                if (IdStr != "-1" && IdStr != "")
                {
                    int InspectionLotId = Convert.ToInt32(IdStr);
                    tb = BindData(InspectionLotId);
                    if (tb != null)
                    {
                        ExportExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmss"));
                    }
                }
            }
        }
        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(int InspectionLotId)
        {
            System.Data.DataTable tb = new System.Data.DataTable();

            InspectionLot bll = new InspectionLot();
            tb = bll.GetQcLotItemImportToExcel(InspectionLotId);
            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 导出Excel 
        /// </summary>
        /// <param name="table"></param>
        /// <param name="name"></param>
        public static void ExportExcel(DataTable table, string name)
        {
            HttpContext context = HttpContext.Current;
            var book = new NPOI.HSSF.UserModel.HSSFWorkbook();

            //添加一个sheet
            var sheet1 = book.CreateSheet("批次检验项明细列表");
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
    }
}