using System;
using System.CodeDom.Compiler;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using AjaxPro;
using Microsoft.CSharp;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.LeanMES.CommonLibrary.Common;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.CommonDataSource
{
    public partial class ImportData : BasePage
    {
        public string dataXml = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(ImportData));
            if (!IsPostBack)
            {

                this.GridView1.EmptyDataText = Resources.Messages.EmptyDataText;
                this.GridView1.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";
                this.GridView1.CssClass = "ListTable";
                this.GridView1.HeaderStyle.CssClass = "ListTableHeader";
                this.GridView1.RowStyle.CssClass = "ListTableOddRow";
                this.GridView1.AlternatingRowStyle.CssClass = "ListTableEvenRow";
                this.GridView1.SelectedRowStyle.CssClass = "ListTableSelectedRow";
                this.GridView1.PagerStyle.CssClass = "ListTablePager";
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                int id = e.Row.RowIndex + 1;
                e.Row.Cells[0].Text = id.ToString();
            }
        }


        /// <summary>
        /// 数据导入
        /// </summary>
        /// <param name="dataXml1"></param>
        ///<param name="procName"></param>
        [AjaxMethod]
        public void DataImport(string dataXml1, string procName)
        {
            int userId = -1;
            SqlParameter[] parms = new SqlParameter[]{
                            new SqlParameter("@UserID", SqlDbType.VarChar,30),
                            new SqlParameter("@DataXml", SqlDbType.NVarChar)
                            };
            userId = AccountController.GetCurrentUser().UserId;
            try
            {
                parms[0].Value = userId;
                parms[1].Value = dataXml1;

                SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, procName, parms);


            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        public ImportDataConfigInfo GetInfo(int id)
        {
            ImportDataConfigInfo model = null;
            var bll = new SKT.LeanMES.CommonDataSource.BLL.ImportDataConfig();
            model = bll.GetInfo(id);
            return model;
        }


        public DataTable Distinct(DataTable dt, string[] filedNames)
        {
            DataView dv = dt.DefaultView;
            DataTable DistTable = dv.ToTable("Dist", true, filedNames);
            return DistTable;
        }

        public string[] GetColumnsByDataTable(DataTable dt)
        {
            string[] strColumns = null;
            if (dt.Columns.Count > 0)
            {
                int columnNum = 0;
                columnNum = dt.Columns.Count;
                strColumns = new string[columnNum];
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    strColumns[i] = dt.Columns[i].ColumnName;
                }
            }
            return strColumns;
        }
        protected void Upload_Click(object sender, EventArgs e)
        {
            if (!fileBomUrl.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }
            else
            {
                var id = Convert.ToInt32(this.hdnId.Value);
                string fileExtension = System.IO.Path.GetExtension(fileBomUrl.PostedFile.FileName).ToLower();
                string allowExtension = ".xls";
                string allowTwoExtension = ".xlsx";
                if (fileExtension != allowExtension && fileExtension != allowTwoExtension)
                {
                    WebHelper.ShowMessage(Resources.Messages.FileTypeError.ToString());
                    return;
                }

                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/Feeder");

                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                string filePath = path + "/" + fileBomUrl.FileName;
                this.fileBomUrl.PostedFile.SaveAs(filePath);
                fileBomUrl.PostedFile.InputStream.Close();
                fileBomUrl.PostedFile.InputStream.Dispose();

                try
                {
                    // filePath = @"D://飞达导入模板.xlsx";
                    DataTable userNew = NPOIHelpers.Import(filePath);/* SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.QueryExcel(filePath, WebHelper.ExcelConnString);*/
                    System.Text.StringBuilder strBuilder = new System.Text.StringBuilder();
                    string[] strColumns = GetColumnsByDataTable(userNew);
                    //去掉DataTable中重复数据  add by weixia on 2018.4.25
                    DataTable userListTb = Distinct(userNew, strColumns);
                    if (userListTb != null && userListTb.Rows.Count > 0)
                    {
                        //
                        strBuilder.Append("<Root>");

                        for (int i = 0; i < userListTb.Rows.Count; i++)
                        {
                            if (String.IsNullOrEmpty(userListTb.Rows[i][0].ToString()))//Add By Alen 2018-01-25 增加空数据判断
                            {
                                continue;
                            }

                            strBuilder.Append("<Feeder ");

                            for (int j = 0; j < userListTb.Columns.Count; j++)
                            {
                                var attr = userListTb.Rows[i][j].ToString();
                                //特殊字符处理
                                attr = attr.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;").Replace("\"","“");
                                if (attr.Trim() != "" || userListTb.Columns[j].ColumnName != "")
                                {
                                    strColumns[j] = userListTb.Columns[j].ColumnName;
                                    strBuilder.Append(userListTb.Columns[j].ColumnName);
                                    strBuilder.Append("=\"" + attr + "\" ");
                                }
                            }
                            strBuilder.Append(" ></Feeder>");
                        }
                        strBuilder.Append("</Root>");



                        GridView1.DataSource = userListTb;
                        GridView1.DataBind();
                       this.dataXml1.Value = strBuilder.ToString();
                        var entity = GetInfo(id);
                        txtIdcName.Text = entity.IdcName;
                        lblFileNames.Text = "<a href = '../UploadFiles/ImportDataExecl/" + entity.FileNames + "'> " + entity.FileNames + " </a > ";
                        lblFileNames.Text.ToHtml();
                        lblProcName.Text = entity.ProcName;
                        hdnId.Value = id.ToString();
                    }

                }
                catch (Exception ex)
                {
                    WebHelper.ShowMessage(ex.Message);
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                }
                finally
                {
                    File.Delete(filePath);
                }
            }
        }

        //protected void Unnamed1_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
            
        //        debugRun(@"\LibTwo\SKT.LeanMES.Web.dll");
        //    }
        //    catch (Exception ex)
        //    {
                
        //        throw;
        //    }
            
        //}


    
        /// <summary>
        /// 动态编译并执行代码
        /// </summary>
      
        /// <param name="newPath">输出dll的路径</param>
        /// <returns>返回输出内容</returns>
        private CompilerResults debugRun(string newPath)
        {
            string serverPath = HttpContext.Current.Server.MapPath("~/");
            string classPath = serverPath.Substring(0, serverPath.LastIndexOf("\\"));
            classPath = classPath.Substring(0, classPath.LastIndexOf("\\"));
           

            CSharpCodeProvider complier = new CSharpCodeProvider();
            //获取目录下所有后缀.cs文件路径列表信息
            string[] fileNames = Directory.GetFiles(classPath+"\\Web\\", "*.cs", SearchOption.AllDirectories);
            //获取目录下所有后缀.dll文件路径列表信息
            string[] arr= Directory.GetFiles(classPath + "\\LibTwo\\", "*.dll", SearchOption.AllDirectories);
            ICodeCompiler codeCompiler = complier.CreateCompiler();

            //设置编译参数
            CompilerParameters paras = new CompilerParameters();
            //引入第三方dll
            paras.ReferencedAssemblies.Add(@"System.dll");
            paras.ReferencedAssemblies.Add(@"System.Configuration.dll");
            paras.ReferencedAssemblies.Add(@"System.Data.dll");
            paras.ReferencedAssemblies.Add(@"System.Data.DataSetExtensions.dll");
            paras.ReferencedAssemblies.Add(@"System.Drawing.dll");
            paras.ReferencedAssemblies.Add(@"System.EnterpriseServices.dll");
            paras.ReferencedAssemblies.Add(@"System.Transactions.dll");

            paras.ReferencedAssemblies.Add(@"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.0\PresentationCore.dll");
            paras.ReferencedAssemblies.Add(@"System.Dynamic.dll");
            paras.ReferencedAssemblies.Add(@"System.Web.dll");
            paras.ReferencedAssemblies.Add(@"System.Core.dll");
            paras.ReferencedAssemblies.Add(@"System.Web.ApplicationServices.dll");
            paras.ReferencedAssemblies.Add(@"System.Web.DynamicData.dll");
            paras.ReferencedAssemblies.Add(@"System.Web.Entity.dll");
            paras.ReferencedAssemblies.Add(@"System.Linq.dll");
  
            paras.ReferencedAssemblies.Add(@"System.Web.Extensions.dll");
            paras.ReferencedAssemblies.Add(@"System.Web.Mobile.dll");
            paras.ReferencedAssemblies.Add(@"System.Web.Services.dll");
            paras.ReferencedAssemblies.Add(@"System.Xml.dll");
            paras.ReferencedAssemblies.Add(@"System.Xml.Linq.dll");
            paras.ReferencedAssemblies.Add(@"System.Web.Services.dll");
            paras.ReferencedAssemblies.Add(@"Microsoft.CSharp.dll");
            paras.ReferencedAssemblies.Add(@"Microsoft.JScript.dll");
          
         


            for (int i = 0; i < arr.Length; i++)
            {
                var dd = arr[i].ToString().Substring(arr[i].ToString().LastIndexOf("\\") + 1);
                if (dd != "SKT.LeanMES.Web.dll")
                {
                    paras.ReferencedAssemblies.Add(@"E:\ProjectCode\LeanMES_8_5_Dev\8.5.3\LibTwo\" + dd);
                }
                
            }
           

            //引入自定义dll
            //paras.ReferencedAssemblies.Add(@"E:\ProjectCode\LeanMES_8_5_Dev\8.5.3\Lib\System.Web.Engine.dll");
            //是否内存中生成输出
            paras.GenerateInMemory = false;
            //是否生成可执行文件
            paras.GenerateExecutable = false;
            paras.OutputAssembly = classPath+newPath;
            paras.TreatWarningsAsErrors = false;
            paras.WarningLevel = 0;
            //编译代码
            CompilerResults result = codeCompiler.CompileAssemblyFromFileBatch(paras, fileNames);
            if (result.Errors.HasErrors)
            {
                string msg = "";
                foreach (CompilerError err in result.Errors)
                {
                    msg += err.Line + err.ErrorText + ";==>" + err.FileName+"/r/n";
                  
                }
                throw new Exception(msg);
            }
            return result;
        }
    }
}