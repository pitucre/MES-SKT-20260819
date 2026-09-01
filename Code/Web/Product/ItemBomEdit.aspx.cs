using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SKT.LeanMES.Product.BLL;
namespace SKT.LeanMES.Web.Product
{
    public partial class ItemBomEdit : BasePage
    {
        public String IsMESadd;
        public String IsCopy;

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            var bomBLL = new ItemBom();
            int bomId = -1;
            string idStr = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
            IsCopy = Request.QueryString["Action"] == null ? "" : Request.QueryString["Action"].ToString();
            int.TryParse(idStr, out bomId);
            if (Convert.ToInt32(this.hdnBomId.Value) != -1)
            {
                //新增组件时 特殊处理
                bomId = Convert.ToInt32(this.hdnBomId.Value);
            }

            //第一次加载不Copy
            //if (this.IsPostBack)
            //{
            //    if (bomId != -1)
            //    {
            //        //复制产品BOM信息
            //        if (IsCopy == "Copy")
            //        {
            //            if (this.hdnBomId.Value != "-1")
            //            {
            //                bomId = bomBLL.ItemBomCopy(bomId, AccountController.GetCurrentUser().UserName);
            //                return;
            //            }
            //        }
            //    }
            //}

            if (bomId != -1)
            {
                var entity = bomBLL.GetInfo(bomId);
                if (entity != null)
                {
                    if (entity.ItemId == 0 && string.IsNullOrWhiteSpace(IsCopy)) IsCopy = "Copy";
                    PageData = entity;
                }
            }

            this.hdnBomId.Value = bomId.ToString();
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemBomChildId";
            //this.Master.DefaultSortExpression = "ItemLevel";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "State=1 and ItemBomId = " + this.hdnBomId.Value.ToString();
            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        ItemBomChild bll = new ItemBomChild();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    DataTable tb = new DataTable();

                    tb = BindData(bomId);
                    if (tb != null)
                    {
                        ExportExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmss"));
                    }
                }
                //复制产品BOM信息
                if (Request.Form["hdnOperate"].ToLower().ToLower() == "copy" &&  IsCopy.ToLower() == "copy")
                {
                    if (this.hdnBomId.Value != "-1")
                    {
                        //复制产品编码
                        var itemId=hdnItemId.Value.Trim();
                        bomId = bomBLL.ItemBomCopy(bomId,int.Parse(itemId),AccountController.GetCurrentUser().UserName);
                        return;
                    }
                }
            }
        }

        private SKT.LeanMES.Product.Model.ItemBomInfo PageData
        {
            set
            {
                if (IsCopy == "")  
                {
                    this.hdnItemId.Value = value.ItemId.ToString();
                    this.lblItemName.Text = value.ItemName;
                    this.txtItemCode.Text = value.ItemCode;
                }
               
                this.txtVersion.Text = value.Version;
                this.ddlStatus.SelectedValue = value.State.ToString();
                this.txtBomDesc.Text = value.Description;
                this.ckbIsCurrentRev.Checked = value.IsCurrentVer;
                IsMESadd = value.Source == 1 ? "ERP" : "MES";
            }
        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(int bomId)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            
            SKT.LeanMES.Product.BLL.ItemBomChild bll = new SKT.LeanMES.Product.BLL.ItemBomChild();
            tb = bll.ImportToExcel(bomId);
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
            var sheet1 = book.CreateSheet("物料BOM明细列表");
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