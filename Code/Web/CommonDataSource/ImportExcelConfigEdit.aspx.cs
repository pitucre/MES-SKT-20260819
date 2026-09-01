using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using Microsoft.Office.Interop.Excel;
using SKT.LeanMES.CommonDataSource.Model;


namespace SKT.LeanMES.Web.CommonDataSource
{
    public partial class ImportExcelConfigEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            AjaxPro.Utility.RegisterTypeForAjax(typeof(ImportExcelConfigEdit));
         
            Int32 id = Convert.ToInt32(Request.QueryString["ID"]);
            var bll = new SKT.LeanMES.CommonDataSource.BLL.ImportDataConfig();


            if (!IsPostBack)
            {
                if (id > -1)
                {
                    ImportDataConfigInfo model = null;

                    model = bll.GetInfo(id);
                    if (model != null)
                    {
                        PageData = model;
                    }
                }
            }

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "eidt")
                {

                    try
                    {
                        SaveEdit(id);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message.ToString());
                    }

                }

              
              
            }
        }

        /// <summary>
        /// 用户数据源编辑检查
        /// </summary>
        /// <returns>0,1</returns>
        [AjaxMethod]
        public void SaveEdit(int id)
        {
            try
            {

                var fileNames = lblFileNames.InnerText;
                if (fileNames == "" && flupload.HasFile == false)
                {
                    WebHelper.ShowMessage("选择导入数据模板");
                    return;
                }

                #region 上传文件
                HttpPostedFile file = flupload.PostedFile;
                var dir = HttpContext.Current.Server.MapPath("~/UploadFiles/ImportDataExecl/");
                var fileName = Path.GetFileName(file.FileName);
                var ext = fileName.Substring(fileName.LastIndexOf(".") + 1).ToLower();
                if (fileName != "")
                {
                    if (ext == "xls" || ext == "xlsx")
                    {
                        if (!Directory.Exists(dir))
                        {
                            Directory.CreateDirectory(dir);
                        }

                        if (File.Exists(dir + fileName))
                        {
                            File.Delete(dir + fileName);
                        }
                        file.SaveAs(dir + fileName);
                    }
                    else
                    {
                        WebHelper.ShowMessage("上传文件格式不对");
                        return;
                    }
                }
                #endregion

                var entity = new ImportDataConfigInfo();
                entity.ID = id;
                entity.IdcName = this.txtIdcName.Text.ToString();
                entity.ProcName = this.txtProcName.Text.ToString();
                entity.FileNames = fileName == "" ? fileNames : fileName;
                entity.CreateBy = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                entity.Remark = this.txtRemark.Text.ToString();

                var bll = new SKT.LeanMES.CommonDataSource.BLL.ImportDataConfig();
                bll.Edit(entity);
                //
                Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "<script>alert('" + Resources.Messages.SaveSuccess + "');parent.window.UpdateList('" + entity.IdcName + "');</script>");
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        private ImportDataConfigInfo PageData
        {
            set
            {
                txtIdcName.Text = value.IdcName;
                lblFileNames.InnerText = value.FileNames;
                txtProcName.Text = value.ProcName;
                txtRemark.Text = value.Remark;
            }
        }

    }
}