using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data;
using System.Collections;
using System.Text;
using System.IO;

namespace SKT.MES.Web.Help
{
    public partial class ImportHelp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 上传Excel，并生成html文件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            #region 上传文件
            HttpPostedFile fileObj = this.flupload.PostedFile;
            if (fileObj.FileName == "")
            {
                this.lblMessage.Text = "请选择Excel文件上传！";
                return;
            }
            if (fileObj.ContentLength <= 0)
            {
                this.lblMessage.Text = "所选文件是空文件！";
                return;
            }
            string allowExt = ".xls|.xlsx";
            string fileExt = fileObj.FileName.Substring(fileObj.FileName.LastIndexOf("."));
            if (allowExt.IndexOf(fileExt) < 0)
            {
                this.lblMessage.Text = "文件格式不正确！";
                return;
            }
            string oldFileName = fileObj.FileName.ToString();
            string newFileName = DateTime.Now.Ticks.ToString() + fileExt;
            string savePath = Server.MapPath("~/Help/Excel/");
            string dataSource = savePath + newFileName;
            this.flupload.PostedFile.SaveAs(dataSource);
            #endregion

            #region 读取并操作Excel
            //创建OLEDB连接字符串
            //string oleStrConn = "Provider = Microsoft.Jet.OLEDB.4.0; Data Source = " + dataSource + ";Extended Properties='Excel 8.0;HDR=NO;'";
            string oleStrConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source= " + dataSource + ";Extended Properties=Excel 12.0";
            OleDbConnection oleConn = null;
            try
            {
                //创建连接
                oleConn = new OleDbConnection(oleStrConn);

                //打开数据库连接
                oleConn.Open();

                //获取所有Sheet
                DataTable dt = oleConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                string s = "";
                DataSet ds = null;

                //循环读取所有表单的内容
                foreach (DataRow row in dt.Rows)
                {
                    string sheetName = row["TABLE_NAME"].ToString();
                    ds = ExcelSheetToDataSet(sheetName, oleStrConn);

                    DataTable _dt = ds.Tables[0];
                    int flag = -1;
                    bool isField = true;

                    //html 文件的基本参数
                    string _html_filename = sheetName.Replace("$", "") + ".htm";
                    string _html_datafield_row = "";
                    string _html_fun_desc = "";
                    string _html_fun_detail = "";
                    string _html_fun_img = "";

                    //循环读取每个表单内容，从第四行开始
                    for (int i = 4; i < _dt.Rows.Count; i++)
                    {
                        if (_dt.Rows[i][0].ToString() != "" && _dt.Rows[i][0].ToString() != "功能描述")
                        {
                            //读取字段
                            if (isField)
                            {
                                _html_datafield_row += String.Format("<tr><td>{0}</td><td>{1}</td></tr>", _dt.Rows[i][0], _dt.Rows[i][1].ToString().Replace("\n","<br/>"));
                            }
                        }
                        else if (_dt.Rows[i][0].ToString() == "功能描述")
                        {
                            flag = i;
                            isField = false;
                        }
                        if (i > flag && i == flag + 1 && i > 4 && flag != -1)
                        {
                            _html_fun_desc = _dt.Rows[i][0].ToString();
                        }

                        if (i > 4 && i > flag + 2 && flag != -1)
                        {
                            _html_fun_img = _dt.Rows[i][5].ToString();
                            string[] arr;
                            arr = _html_fun_img.Split(';');
                            string imgList = "";
                            foreach (string img in arr)
                            {
                                imgList += "<div><img src='images/" + img.Replace("//", "/") + "' alt='' width='100%' height='100%'/></div>";
                            }

                            _html_fun_detail += "<div>";
                            _html_fun_detail += "<div class='list-title'>" + _dt.Rows[i][0].ToString() + "</div>";
                            _html_fun_detail += "<div class='clear10'></div>";
                            _html_fun_detail += "<div class='list-detail'>" + _dt.Rows[i][1].ToString().Replace("\n", "<br/>") + "</div>";
                            _html_fun_detail += "<div class='clear10'></div>";
                            _html_fun_detail += "<div class='list-img'>";
                            _html_fun_detail += imgList;
                            _html_fun_detail += "</div>";
                            _html_fun_detail += "</div>";
                            _html_fun_detail += "<div class='clear10'></div>";
                        }
                    }
                    //生成html文件
                    s = GenerateHtml(sheetName.Replace("$", ""), "", _html_datafield_row, "", _html_fun_desc, _html_fun_detail, _html_filename);
                }
                this.lblMessage.Text = s;

                //关闭OLEDB连接
                oleConn.Close();
                if (s == "")
                {
                    Response.Redirect("~/Help/Help.htm");
                }
            }
            catch (Exception ex)
            {
                this.lblMessage.Text = ex.Message.ToString();
            }

            #endregion
        }

        /// <summary>
        /// 查询Excel数据到DataSet
        /// </summary>
        /// <param name="sheetName"></param>
        /// <param name="strConn"></param>
        /// <returns></returns>
        private DataSet ExcelSheetToDataSet(string sheetName, string strConn)
        {
            DataSet ds = null;
            OleDbDataAdapter ada = null;
            string cmdText = "";
            cmdText = "SELECT * FROM [" + sheetName + "]";
            ada = new OleDbDataAdapter(cmdText, strConn);
            ds = new DataSet();
            ada.Fill(ds, sheetName);
            return ds;
        }

        /// <summary>
        /// 生成HTML文件
        /// </summary>
        /// <param name="HTMLPageTitle">页面名字，从资源文件中取得</param>
        /// <param name="HTMLFieldDescTitle">"字段描述"</param>
        /// <param name="HTMLFieldTableRows">字段</param>
        /// <param name="HTMLFunTitle">"功能描述"</param>
        /// <param name="HTMLFunDesc">功能简介</param>
        /// <param name="HTMLFunDetailList">详细功能描述</param>
        private string GenerateHtml(string HTMLPageTitle, string HTMLFieldDescTitle, string HTMLFieldTableRows, string HTMLFunTitle, string HTMLFunDesc, string HTMLFunDetailList, string HTMLFileName)
        {
            HTMLFieldDescTitle = "字段描述";
            HTMLFunTitle = "功能描述";

            #region 读取模板内容
            StringBuilder templateContent = new StringBuilder();
            //模板页面路径
            string templatePath = Server.MapPath("~/Help/Template/Template.htm");
            if (!File.Exists(templatePath))
            {
                return "模板文件丢失或不存在！";
            }
            try
            {
                using (StreamReader sr = new StreamReader(templatePath))
                {
                    string line = "";
                    while ((line = sr.ReadLine()) != null)
                    {
                        templateContent.Append(line);
                    }
                    sr.Close();
                }
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
            #endregion

            #region 替换模板标签
            templateContent.Replace("{Title}", (String)this.GetGlobalResourceObject("Pages", HTMLPageTitle));
            templateContent.Replace("{HTMLPageTitle}", (String)this.GetGlobalResourceObject("Pages", HTMLPageTitle));
            templateContent.Replace("{HTMLFieldDescTitle}", HTMLFieldDescTitle);
            templateContent.Replace("{HTMLDataFieldName}", "字段名");
            templateContent.Replace("{HTMLDataFieldDesc}", "描述");
            templateContent.Replace("{HTMLFieldTableRows}", HTMLFieldTableRows);
            templateContent.Replace("{HTMLFunTitle}", HTMLFunTitle);
            templateContent.Replace("{HTMLFunDesc}", HTMLFunDesc);
            templateContent.Replace("{HTMLFunDetailList}", HTMLFunDetailList);
            #endregion

            string genHtmlPath = Server.MapPath("~/Help/Documents/");

            #region 生成HTML文件
            try
            {
                using (StreamWriter sw = new StreamWriter(genHtmlPath + HTMLFileName, false, System.Text.Encoding.GetEncoding("GB2312")))
                {
                    sw.WriteLine(templateContent);
                    sw.Flush();
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
            #endregion

            return "";
        }
    }
}