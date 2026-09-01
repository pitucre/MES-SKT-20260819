using System;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System.Data;
using SKT.LeanMES.Web.AppCode.Utility;
using System.IO;
using System.Data.OleDb;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.Web.Product
{
    public partial class MaterielEdit : BasePage
    {
        public String preDetailId = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPreAssemblySetting));
            preDetailId = Request.Params["ID"];
            if (!this.IsPostBack)
            {
               
                if (Request.Params["ID"] != "-1")
                {
                    try
                    {
                        var bll = new LeanMES.SMT.BLL.PreAssemblySetting();
                        var entity = bll.GetInfo(Request.Params["ID"]);
                        if(entity!=null)
                        {
                            PageData = entity;
                        }
                        
                    }
                    catch (Exception ex)
                    {

                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "import")
                {
                    string param = "@ModelNo";            //获取参数
                    string paramValue = "" + preDetailId + "";     //获取参数值
                    string procName = "uspMaterialImport";
                    this.ExportToExcel(param, paramValue, procName);
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PreAssemblySettingInfo PageData
        {
            set
            {
                this.lblItemName.Text = value.ItemName;
                this.hideItemId.Value = value.ModelID.ToString();
                this.hideItemCode.Value = value.ModelNo;

            }
        }

        public void ExportToExcel(string parmsStr, string parmsValueStr, string procName)
        {
            try
            {
                SKT.LeanMES.Report.BLL.Report bll = new LeanMES.Report.BLL.Report();
                DataTable dt = bll.GetDataTableToExcel(parmsStr, parmsValueStr, procName);
                ExcelHelper.ExportToExcel(dt, "Report_" + DateTime.Now.ToString("yyyyMMdd") + ".xls", "UTF-8");
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }
        }
        private static int GetSheetIndex(byte[] FindTarget, byte[] FindItem)
        {
            int index = -1;

            int FindItemLength = FindItem.Length;
            if (FindItemLength < 1) return -1;
            int FindTargetLength = FindTarget.Length;
            if ((FindTargetLength - 1) < FindItemLength) return -1;

            for (int i = FindTargetLength - FindItemLength - 1; i > -1; i--)
            {
                System.Collections.ArrayList tmpList = new System.Collections.ArrayList();
                int find = 0;
                for (int j = 0; j < FindItemLength; j++)
                {
                    if (FindTarget[i + j] == FindItem[j]) find += 1;
                }
                if (find == FindItemLength)
                {
                    index = i;
                    break;
                }
            }
            return index;
        }

        /* Get XLS sheet Name*/
        private static string GetSheetName(string filePath)
        {
            string sheetName = "Sheet1";

            System.IO.FileStream tmpStream = File.OpenRead(filePath);
            byte[] fileByte = new byte[tmpStream.Length];
            tmpStream.Read(fileByte, 0, fileByte.Length);
            tmpStream.Close();

            byte[] tmpByte = new byte[]{Convert.ToByte(11),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),
           Convert.ToByte(11),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),
           Convert.ToByte(30),Convert.ToByte(16),Convert.ToByte(0),Convert.ToByte(0)};

            int index = GetSheetIndex(fileByte, tmpByte);
            if (index > -1)
            {

                index += 16 + 12;
                System.Collections.ArrayList sheetNameList = new System.Collections.ArrayList();

                for (int i = index; i < fileByte.Length - 1; i++)
                {
                    byte temp = fileByte[i];
                    if (temp != Convert.ToByte(0))
                        sheetNameList.Add(temp);
                    else
                        break;
                }
                byte[] sheetNameByte = new byte[sheetNameList.Count];
                for (int i = 0; i < sheetNameList.Count; i++)
                    sheetNameByte[i] = Convert.ToByte(sheetNameList[i]);

                sheetName = System.Text.Encoding.Default.GetString(sheetNameByte);
            }
            return sheetName;
        }


        /*Check xls columns*/
        static string CheckXLSFormat(DataTable XLS)
        {
            string error = String.Empty;
            if (!XLS.Columns.Contains("产品编码"))
            {
                error = "XLS格式错误，缺少产品编码字段";
            }
            if (!XLS.Columns.Contains("用量"))
            {
                error = "XLS格式错误，缺少用量字段";
            }
            if (!XLS.Columns.Contains("物料位置"))
            {
                error = "XLS格式错误，缺少物料位置字段";
            }
            if (!XLS.Columns.Contains("工位"))
            {
                error = "XLS格式错误，缺少工位字段";
            }
            return error;
        }

        /// <summary>
        /// 检验是否有Excel
        /// </summary>
        /// <returns></returns>
        private bool codeboolisExcelInstalled()
        {
            Type type = Type.GetTypeFromProgID("Excel.Application");
            return type != null;
        }

        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
            try
            {
                if (!codeboolisExcelInstalled())
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('当前系统没有发现可执行的Excel文件, 如需使用Excel功能请先安装office2003!')</script>");
                }
                string saveName = DateTime.Now.ToString("yyyy-MM-dd-HH-MM-ss") + ".xls";
                //用来保存Excel保存后的路径
                string source = "";

                FilesHelper.FilesUpload(this.fuLoadingList, new string[] { ".xls", ".xlsx" }, 2,
                    Server.MapPath(WebHelper.TempFileRoot), saveName, out source);
                string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + System.IO.Path.GetFileName(fuLoadingList.PostedFile.FileName).ToString();
                string filePath = Server.MapPath("..\\TempFile");
                if (!Directory.Exists(filePath))
                {
                    try
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    catch (Exception)
                    {
                        throw new ApplicationException("Create folder failed.");
                    }
                }
                //--end
                fuLoadingList.PostedFile.SaveAs(filePath + "\\" + filename); //modify by Alen 2014-12-31
                filename = filePath + "\\" + filename;//modify by Alen 2014-12-31

                String sheetName = GetSheetName(filename);
                DataTable DT1 = ExcelHelper.QueryExcel(source, sheetName, WebHelper.ExcelConnString);

                //去后Excel转成Table后面没用的字段
                for (int i = DT1.Columns.Count; i >= 0; i--)
                {
                    if (DT1.Columns[i - 1].ColumnName == "F" + i)
                    {
                        DT1.Columns.Remove(DT1.Columns[i - 1].ColumnName);
                    }
                    else
                    {
                        break;
                    }
                }


                try
                {
                    new SKT.LeanMES.Plan.BLL.Plan().ToImportPreAssemblyDetail(DT1, preDetailId, AccountController.GetCurrentUser().UserName);
                    SKT.LeanMES.Web.AppCode.Utility.FilesHelper.DeleteFiles(source);
                    Response.Write("<script language=javascript>alert('导入成功!');</script>");
                    Response.Write("<script language=javascript>window.location.href=window.location.href;</script>");
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }

                /* }*/
            }
            catch (Exception exc)
            {
                Response.Write("<script> alert('模板不正确，请下载正确的计划模板!')</script>");
            }
        }
    }

}