using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SampleNumberManagement
{
    public partial class SampleNumberImport : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSampleNumber));

            this.GvImport.EmptyDataText = Resources.Messages.EmptyDataText;
            this.GvImport.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";
            this.GvImport.CssClass = "ListTable";
            this.GvImport.HeaderStyle.CssClass = "ListTableHeader";
            this.GvImport.RowStyle.CssClass = "ListTableOddRow";
            this.GvImport.AlternatingRowStyle.CssClass = "ListTableEvenRow";
            this.GvImport.SelectedRowStyle.CssClass = "ListTableSelectedRow";
            this.GvImport.PagerStyle.CssClass = "ListTablePager";
            this.GvImport.AutoGenerateColumns = false;
        }

        /// <summary>
        /// 上传
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string filePath = string.Empty;
            try
            {
                if (!FuUrl.HasFile)
                {
                    WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                    return;
                }
                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/SampleNumber");
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                filePath = path + "/" + FuUrl.FileName;
                this.FuUrl.PostedFile.SaveAs(filePath);
                this.FuUrl.PostedFile.InputStream.Close();
                this.FuUrl.PostedFile.InputStream.Dispose();
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message);
                return;
            }

            DataTable dt = null;
            this.GvImport.DataSource = dt;//重置列表
            this.GvImport.DataBind();

            try
            {
                var dataRowIndex = 1;//数据开始行（非列头开始行）
                dt = NPOIHelpers.Import(filePath, 0, 0, dataRowIndex);
                //校验dt
                if (dt == null || dt.Rows.Count <= 0)
                {
                    WebHelper.ShowMessage("未获取到需要导入的数据");
                    return;
                }
                if (dt.Columns.Count < 5)
                {
                    WebHelper.ShowMessage("导入模板列数不正确，请检查");
                    return;
                }

                dt.Columns[0].ColumnName = "SampleNumber"; //序列号
                dt.Columns[1].ColumnName = "SampleName";   //样品名称
                dt.Columns[2].ColumnName = "Station";   //工序名称
                dt.Columns[3].ColumnName = "ExpirationDate"; //失效日期
                dt.Columns[4].ColumnName = "PrototypeAttr"; //不良属性
                dt.Columns[5].ColumnName = "NcCodes"; //不良代码
                dt.Columns[6].ColumnName = "Remark"; //备注

                this.GvImport.DataSource = dt;
                this.GvImport.DataBind();
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage("读取Excel数据异常:" + ex.Message);
                return;
            }
            finally
            {
                File.Delete(filePath);
            }
        }
    }
}