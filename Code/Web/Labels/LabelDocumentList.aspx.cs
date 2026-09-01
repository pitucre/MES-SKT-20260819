using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Labels.BLL;
using System.Collections.Generic;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.Labels.Model;
using System.Data.SqlClient;
using System.IO;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;
using System.Configuration;
using SKT.LeanMES.Report.Model;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelDocumentList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxLabels));

            Bind_ValueID("PrintWay", this.ddlPrintMode);
            if (IsPostBack)
            {
                this.ddlPrintMode.SelectedValue = Request.Form["ctl00$ctl00$ContentPlaceHolder1$SearchContent$ddlPrintMode"];
            }

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "LabelDocumentId";
            this.Master.DefaultSortExpression = "LabelDocumentId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("DocumentName", Server.HtmlEncode(this.txtDocumentName.Text.Trim()));
            searchSettings.AddCondition("TemplateName", Server.HtmlEncode(this.txtTemplateName.Text.Trim()));
            if (this.ddlPrintMode.SelectedValue != "")
            {
                searchSettings.AddCondition("PrintWayId", this.ddlPrintMode.SelectedValue);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Labels.BLL.LabelDocument bll = new SKT.LeanMES.Labels.BLL.LabelDocument();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        //清理无效的模板文件
                        bool isCleanTemplateFiles = (ConfigurationManager.AppSettings["IsCleanTemplateFiles"] ?? "0") == "1";
                        List<string> listDeleteFiles = new List<string>();
                        //获取支持得文件格式
                        List<string> listExt = (ConfigurationManager.AppSettings["UpdateTemplateFileExt"] ?? "")
                            .Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                        if (isCleanTemplateFiles)
                        {
                            List<string> listTemplateFiles = new List<string>();
                            using (SqlDataReader dr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "SELECT DISTINCT TemplatePath FROM dbo.Basal_LabelDocument WHERE TemplatePath <>''", null))
                            {
                                while (dr.Read())
                                {
                                    listTemplateFiles.Add(ComMethod.FromDatabase<string>(dr[0]));
                                }
                                dr.Close();
                            }
                            string url = Context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintTemplate");
                            foreach (var filePath in Directory.GetFiles(url))
                            {
                                FileInfo fileInfo = new FileInfo(filePath);
                                //过滤指定的模板文件
                                if (listExt.Any(p => p.ToUpper() == fileInfo.Extension.ToUpper()))
                                {
                                    if (!listTemplateFiles.Any(p => p.Trim().ToUpper() == fileInfo.Name.Trim().ToUpper()))
                                    {
                                        listDeleteFiles.Add(fileInfo.FullName);
                                    }
                                }
                            }
                            foreach (var filePath in listDeleteFiles)
                            {
                                if (File.Exists(filePath))
                                {
                                    File.Delete(filePath);
                                }
                            }
                        }
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex,true);
                    }
                }
            }
        }

        /// <summary>
        /// 下拉框绑定
        /// </summary>
        /// <param name="Value">查询字段值</param>
        /// <param name="DDList">下拉框</param>
        private void Bind_ValueID(string Value, DropDownList DDList)
        {
            Dictionary dictionary = new Dictionary();
            List<DictionaryInfo> dInfos = dictionary.GetListInfo(Value);
            DDList.DataSource = dInfos;
            DDList.DataTextField = "Value";
            DDList.DataValueField = "DictionaryDataId";
            DDList.DataBind();

            DDList.Items.Insert(0, new ListItem("", ""));
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LabelDocumentInfo entity=e.Row.DataItem as LabelDocumentInfo;
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_ModifyBy
                //7改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
            try
            {
                
            }
            catch { }
        }



    }
}