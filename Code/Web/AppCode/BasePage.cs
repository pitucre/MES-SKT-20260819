using System;
using System.Web;
using System.Threading;
using System.Globalization;
using System.Collections;
using System.Text;
using System.Web.UI.WebControls;
using System.Reflection;
using AJAXdataHelper;
using System.Collections.Generic;
using SKT.LeanMES.Web;
using Systems.Web;
using SKT.Common.Account.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Account.BLL;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.Security;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.IO;

/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : Systems.Web.UI.Page
{

    protected override void OnPreLoad(EventArgs e)
    {
        base.OnPreLoad(e);
        //验证权限
        PagePopedomValidation();
        //去除文本框左右空格
        TrimTextBox();
    }

    /// <summary>
    /// 去除文本框左右空格
    /// </summary>
    private void TrimTextBox()
    {
        //过滤文本框中的左右空格
        try
        {
            dynamic txtbox;
            if (this.Form==null|| this.Form.Controls == null)
            {
                return;
            }
            //界面中，引用了两层母版页
            foreach (Control control in this.Form.Controls)
            {
                foreach (Control con in control.Controls)
                {
                    if (con is ContentPlaceHolder)
                    {
                        foreach (Control ctrl in con.Controls)
                        {
                            //textbox 例如：<asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox" ClientIDMode="Static">
                            txtbox = ctrl as TextBox;
                            if (txtbox != null)
                            {
                                txtbox.Text = txtbox.Text.Trim();//去除左右空格
                                continue;
                            }
                            //html input text 例如：<input type="text" id="txtSerialNumber" class="TextBox" runat="server" clientidmode="Static" />
                            txtbox = ctrl as HtmlInputText;
                            if (txtbox != null)
                            {
                                txtbox.Value = txtbox.Value.Trim();//去除左右空格
                                continue;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            WebHelper.HandleException(ex);
        }
    }

    /// <summary>
    /// 页面权限验证
    /// </summary>
    /// <summary>
    /// 页面权限验证
    /// </summary>
    protected void PagePopedomValidation()
    {
        string url = HttpContext.Current.Request.Url.AbsolutePath;
        url = url.Replace(HttpContext.Current.Request.ApplicationPath, "");
        url = url.Substring(1, url.Length - 1);
        string PopedomName = "";
        if (HttpContext.Current.Request["name"] != null)
        {
            PopedomName = HttpContext.Current.Request["name"];
        }
        MembershipInfo info = AccountController.GetCurrentUser();

        SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@PopedomName",SqlDbType.NVarChar),
                    new SqlParameter("@Url",SqlDbType.NVarChar,500),
                    new SqlParameter("@UserId",SqlDbType.Int),
                    };
        param[0].Value = PopedomName;
        param[1].Value = url;
        param[2].Value = info.UserId;

        int PopedomId = 0;
        using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "uspPopedomValidation", param))
        {
            while (rdr.Read())
            {
                PopedomId = Convert.ToInt32(rdr["PopedomId"]);
            }
            rdr.Close();
        }
        if (PopedomId != 0 && !Users.CheckUserIsWarrantted(info.UserId, PopedomId))
        {
            WebHelper.WriteException(new Exception("Popedom Error!"));
            base.Response.Redirect(WebHelper.WebRoot + "/Framework/Error.aspx");
        }
    }

    /// <summary>
    /// 设置页面语言
    /// </summary>
    protected override void InitializeCulture()
    {
        HttpCookie cookieLang = new HttpCookie("lang");
        if (Request.Form["lang"] != null)
        {
            String strlang = Request.Form["lang"];
            cookieLang.Value = strlang;
            Response.Cookies.Add(cookieLang);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(strlang);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(strlang);
        }
        else if (Request.Cookies["lang"] != null)
        {
            cookieLang = Request.Cookies["lang"];
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(cookieLang.Value);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(cookieLang.Value);
        }
        else
        {
            cookieLang.Value = "zh-cn";
            Response.Cookies.Add(cookieLang);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("zh-cn");
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("zh-cn");
        }
        base.InitializeCulture();
    }

    /// <summary>
    /// 公用导出GridView数据。
    /// Add by Hanson.Lei on 2016.11.8
    /// </summary>
    /// <param name="grid">GridView</param>
    /// <param name="data">ObjectDataSource</param>
    /// <param name="Filter">筛选不导出的列</param>
    protected void GridViewExpToExcel(System.Web.UI.WebControls.GridView grid, ObjectDataSource data, string expFilename, Func<string, bool> Filter = null)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<TABLE border='1'>");
        sb.Append("<TR>");

        //1.筛选列
        ArrayList arrPropertys = new ArrayList();
        foreach (DataControlField dcf in grid.Columns)
        {
            if (Filter != null && Filter(dcf.HeaderText)) continue;

            arrPropertys.Add(((BoundField)dcf).DataField);

            sb.AppendFormat("<TH>{0}</TH>", dcf.HeaderText);
        }
        sb.Append("</TR>");

        //2.添加行
        foreach (var t in data.Select())
        {
            Type type = t.GetType();

            sb.Append("<TR>");

            foreach (string ptyName in arrPropertys)
            {
                PropertyInfo propertyInfo = type.GetProperty(ptyName);

                //实体属性名称与绑定gridView的字段有可能存在大小写区别
                if (propertyInfo == null)
                {
                    foreach (PropertyInfo p in type.GetProperties())
                    {
                        if (p.Name.ToLower() == ptyName.ToLower())
                        {
                            propertyInfo = p;
                            break;
                        }
                    }
                }

                object cellValue = propertyInfo.GetValue(t, null);
                sb.AppendFormat("<TD {0}>{1}</TD>", SetCellStyle(cellValue), cellValue);
            }
            sb.Append("</TR>");
        }
        sb.Append("</TABLE>");

        ExpToExcel(expFilename, sb.ToString());
    }

    string SetCellStyle(object cellValue)
    {
        //转换文本格式
        if (cellValue != null)
            if (cellValue.ToString().IndexOf('-') > -1)
                return "style='vnd.ms-excel.numberformat:@;'";

        return "";
    }

    /// <summary>
    /// 导出网页格式
    /// </summary>
    /// <param name="text"></param>
    protected void ExpToExcel(string expFilename, string text)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<head><meta http-equiv=Content-Type content=\"text/html; charset=utf-8\" />");
        sb.Append(text);
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + expFilename);
        Response.ContentType = "application/ms-excel";
        Response.Write(sb.ToString());
        Response.End();
    }

    /// <summary>
    /// 合并PDF
    /// </summary>
    /// <param name="size"></param>
    /// <param name="pdfByteContent"></param>
    /// <returns></returns>
    public byte[] MergePdf(string size, List<byte[]> pdfByteContent)
    {
        byte[] allBytes;
        Rectangle pageSize = PageSize.GetRectangle(size);
        using (MemoryStream ms = new MemoryStream())
        {
            Document doc = new Document();
            PdfWriter writer = PdfWriter.GetInstance(doc, ms);
            doc.SetPageSize(pageSize);
            doc.Open();
            PdfContentByte cb = writer.DirectContent;
            PdfImportedPage page;
            PdfReader reader;
            //循环文档
            foreach (byte[] p in pdfByteContent)
            {
                reader = new PdfReader(p);
                int pages = reader.NumberOfPages;
                // 循环文档页面
                for (int i = 1; i <= pages; i++)
                {
                    doc.SetPageSize(pageSize);
                    doc.NewPage();
                    page = writer.GetImportedPage(reader, i);
                    cb.AddTemplate(page, 0, 0);
                }
            }
            doc.Close();
            allBytes = ms.GetBuffer();
            ms.Flush();
            ms.Dispose();
        }
        return allBytes;
    }
}


