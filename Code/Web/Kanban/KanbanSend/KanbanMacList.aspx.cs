using SKT.LeanMES.Kanban.Model;
using SKT.LeanMES.Kanban.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;
using System.Data;

namespace SKT.LeanMES.Web.Kanban.KanbanManage
{
    public partial class KanbanMacList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanbanManage));
            showTree();
            if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "exportexcel")
            {
                string sql = this.hdnSql.Value.Trim();
                if (!string.IsNullOrEmpty(sql))
                {
                    sql = " AND " + sql;
                }
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.ExtensionCondition = sql;

                var bll = new Send();
                DataTable dt = bll.GetAll(string.Empty, searchSettings);
                SetExportColumn(dt);
            }
        }

        public void showTree()
        {
            List<SendInfo> kanban = new Send().GetAll(0, -1, "", null);
            TreeKanBan.Nodes.Clear();
            if (kanban.Count > 0)
            {
                TreeNode treeNode = new TreeNode("看板终端");
                treeNode.SelectAction = TreeNodeSelectAction.None;
                foreach (var entity in kanban)
                {
                    TreeNode snode = new TreeNode(entity.SendName + "(MAC:" + entity.MAC + ")");
                    snode.SelectAction = TreeNodeSelectAction.None;
                    snode.NavigateUrl = entity.KanbanSendId.ToString();
                    treeNode.ChildNodes.Add(snode);
                }
                TreeKanBan.Nodes.Add(treeNode);
                TreeKanBan.SelectedNodeStyle.Font.Bold = true;
                TreeKanBan.RootNodeStyle.CssClass = "tvroot";
                TreeKanBan.RootNodeStyle.Font.ClearDefaults();
                TreeKanBan.ExpandAll();
            }
        }


        /// <summary>
        /// 设置要导出的列
        /// </summary>
        /// <param name="dt"></param>
        public void SetExportColumn(DataTable dt)
        {
            var dic = new Dictionary<string, string>()
            {
                {"RowId","序号" },
                {"SendName","看板终端" },
                {"MAC","MAC"},
                {"Location","位置"},
                {"KanbanName","看板名称" },
                {"UpdateBy","最近修改人" },
                {"UpdateTime","最近修改时间" }
            };

            //更改列名，并设置导出列顺序
            int idx = 0;
            foreach (var item in dic)
            {
                if (dt.Columns.Contains(item.Key))
                {
                    dt.Columns[item.Key].SetOrdinal(idx);
                    dt.Columns[item.Key].ColumnName = item.Value;
                    idx++;
                }
            }
            //移除多余列
            int colCount = dt.Columns.Count;
            for (int i = colCount - 1; i >= idx; i--)
            {
                dt.Columns.RemoveAt(i);
            }
            //导出
            ExportExcel(dt, "看板终端列表-" + DateTime.Now.ToString("yyyyMMddHHmmss"));
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
            var sheet1 = book.CreateSheet("看板终端");
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
            context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
            context.Response.HeaderEncoding = System.Text.Encoding.GetEncoding("gb2312");
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
            context.Response.BinaryWrite(System.Text.Encoding.GetEncoding("gb2312").GetPreamble());
            context.Response.BinaryWrite(ms.ToArray());

        }
    }
}