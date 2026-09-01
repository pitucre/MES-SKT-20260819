using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using System.Text;
using System.Collections.Generic;
using System.Linq;

namespace SKT.LeanMES.Web
{
    /// <summary>
    /// 页面公用方法类
    /// </summary>
    public class CommonMethod : System.Web.UI.Page
    {
        public static string WebRoot = HttpRuntime.AppDomainAppPath.ToString();

        ///// <summary>
        ///// 下拉列表数据取得
        ///// </summary>
        ///// <param name="strName">表名</param>
        ///// <param name="strCloumn">栏名</param>
        ///// <param name="ddl">下拉控件</param>
        //public static void getDropdownListBind(string strName, string strCloumn, DropDownList ddl)
        //{
        //    SKT.LeanMES.TableConfig.BLL.TableConfig bll = new SKT.LeanMES.TableConfig.BLL.TableConfig();
        //    ddl.DataSource = bll.GetConfigList(strName, strCloumn, "S");
        //    ddl.DataTextField = "ClDesc";
        //    ddl.DataValueField = "ClValue";
        //    ddl.DataBind();
        //}

        /// <summary>
        /// 设置选择下拉列表被选择项
        /// </summary>
        /// <param name="ddl"></param>
        /// <param name="strSelectedValue"></param>
        /// <param name="vteType"></param>
        public static void setDropDownListSelectedValue(DropDownList ddl, string strSelectedValue, CommonMethod.ValueTypeEnum vteType)
        {
            for (int i = 0; i <= ddl.Items.Count - 1; i++)
            {
                ddl.SelectedIndex = i;
                string a = (vteType == CommonMethod.ValueTypeEnum.Text) ? ddl.SelectedItem.Text : ddl.SelectedItem.Value;
                if (a == strSelectedValue)
                {
                    break;
                }
            }
        }

        public enum ValueTypeEnum
        {
            Text,
            Value
        }

        /// <summary>
        /// 日期查询条件串写
        /// </summary>
        /// <param name="strContition"></param>
        /// <param name="txtDateFrom"></param>
        /// <param name="txtDateTo"></param>
        /// <param name="strCoumns">栏位名称</param>
        /// <returns></returns>
        public static string[] AppendDateContiton(string strContition, string txtDateFrom, string txtDateTo, string strCoumns)
        {
            DateTime tmFrom;
            DateTime tmTo;

            string[] strReturn = new string[2] { "", "" };

            //起始时间添加
            if (txtDateFrom != "" && DateTime.TryParse(txtDateFrom, out tmFrom))
            {
                strContition += (strContition == "" ? "" : "AND") + "( " + strCoumns + " >= '" + tmFrom + "')";
            }
            else
            {
                strReturn[0] = txtDateFrom != "" ? "请输入正确的时间格式（yyyy-MM-dd）" : strReturn[0];
            }

            //结束时间添加
            if (txtDateTo != "" && DateTime.TryParse(txtDateTo, out tmTo))
            {
                strContition += (strContition == "" ? "" : "AND") + "( " + strCoumns + " <= '" + tmTo + "')";
            }
            else
            {
                strReturn[0] = txtDateTo != "" ? "请输入正确的时间格式（yyyy-MM-dd）" : strReturn[0];
            }

            strReturn[1] = strContition;

            return strReturn;
        }

        /// <summary>
        /// 文件上传
        /// </summary>
        /// <param name="FileUpload1"></param>
        /// <param name="strType"></param>
        /// <returns></returns>
        public static string GetFileUploadPath(FileUpload FileUpload1, string strType, string strFolder)
        {
            //check the loading list file
            if (!FileUpload1.HasFile)
            {
                WebHelper.ShowMessage("没有获取到文件");
                return "";
            }
            string fileExtension = System.IO.Path.GetExtension(FileUpload1.PostedFile.FileName).ToLower();
            if (!strType.Contains(fileExtension))
            {
                WebHelper.ShowMessage("文件类型不允许");
                return "";
            }

            string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + System.IO.Path.GetFileName(FileUpload1.FileName).ToString();
            string filePath = createFolder(strFolder);
            if (filePath == "")
            {
                WebHelper.ShowMessage("文件夹获取失败");
                return "";
            }

            //保存文件
            FileUpload1.PostedFile.SaveAs(filePath + "\\" + filename);
            return filePath + "\\" + filename; ;
        }

        //文件夹创建
        private static string createFolder(string strFolder)
        {
            string filePath = System.Web.HttpContext.Current.Server.MapPath("..\\" + strFolder);
            if (!Directory.Exists(filePath))
            {
                try
                {
                    Directory.CreateDirectory(filePath);
                }
                catch
                {
                    return "";
                }
            }
            return filePath;
        }

        //资料汇出
        public static void exportFile(string strFileName, string strFolder)
        {
            //文件夹不存在时创建
            if (strFileName == "")
            {
                WebHelper.ShowMessage("没有导出的文件");
                return;
            }
            else
            {
                System.Web.HttpContext.Current.Response.ClearHeaders();
                System.Web.HttpContext.Current.Response.Clear();
                System.Web.HttpContext.Current.Response.AddHeader("Accept-Language", "zh-tw");
                System.Web.HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + System.Web.HttpContext.Current.Server.UrlEncode(strFileName));
                System.Web.HttpContext.Current.Response.ContentType = "application/ms-excel";
                System.Web.HttpContext.Current.Response.WriteFile(strFolder + strFileName);
                System.Web.HttpContext.Current.Response.Flush();
                System.Web.HttpContext.Current.Response.End();
            }
        }

        /// <summary>
        /// 获取客户端IP地址
        /// </summary>
        /// <returns></returns>
        public static string GetClientIP()
        {
            string result = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (null == result || result == String.Empty)
            {
                result = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            if (null == result || result == String.Empty)
            {
                result = HttpContext.Current.Request.UserHostAddress;
            }
            return result;
        }

        public static void LoginLog(int loginAction, string lmsg, string username)
        {
            var cmdTxt = @" INSERT INTO dbo.SYS_UserLoginLog(UserName,LoginClientIP,LoginTime,LoginAction,Remark)
VALUES(@UserName,@LoginClientIP,@LoginTime,@LoginAction,@Remark) ";
            var clientIp = CommonMethod.GetClientIP();
            SqlParameter[] parms = new SqlParameter[] {
                    new SqlParameter("@UserName",SqlDbType.VarChar,20),
                    new SqlParameter("@LoginClientIP",SqlDbType.VarChar,50),
                    new SqlParameter("@LoginTime",SqlDbType.DateTime),
                    new SqlParameter("@LoginAction",SqlDbType.TinyInt),
                    new SqlParameter("@Remark",SqlDbType.NVarChar,100)
                };
            parms[0].Value = username;
            parms[1].Value = clientIp;
            parms[2].Value = DateTime.Now.ToString();
            parms[3].Value = loginAction;
            parms[4].Value = lmsg;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, cmdTxt, parms);
        }

        //系统错误信息插入
        public static void InsertSystemErrorLog(string userName, string ex, string stark)
        {

            var cmdTxt = @" INSERT INTO [dbo].[SYS_SystemErrorLog](UserName,CreateDateTime,ErrorMsg,Remark,MethodStr)
                         VALUES(@UserName,GETDATE(),@ErrorMsg,@Remark,@MethodStr) ";
            SqlParameter[] parms = new SqlParameter[] {
                    new SqlParameter("@UserName",SqlDbType.NVarChar,50),
                    new SqlParameter("@ErrorMsg",SqlDbType.NVarChar,500),
                    new SqlParameter("@Remark",SqlDbType.NVarChar,500),
                    new SqlParameter("@MethodStr",SqlDbType.NVarChar,1000)
                };
            parms[0].Value = userName;
            parms[1].Value = ex;
            parms[2].Value = ex;
            parms[3].Value = stark;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, cmdTxt, parms);
        }


        public static string GetCurrentClientIP(Int32 userId)
        {
            string clientIP = "";
            StringBuilder str = new StringBuilder();
            str.Append(" SELECT  ClientIP FROM dbo.SYS_UsersOnline  WHERE UserId = @UserId ");
            SqlParameter[] parametrs = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int)
            };
            parametrs[0].Value = userId;
            SqlDataReader reader = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, str.ToString(), parametrs);
            if (reader.Read())
            {
                clientIP = reader["ClientIP"].ToString();
            }
            reader.Close();
            return clientIP;
        }


        //导出excel公用方法--自动根据datatable
        public static void ExportToSpreadsheet(DataTable dt, string FileName)
        {
            var context = System.Web.HttpContext.Current;
            context.Response.Clear();
            context.Response.ContentType = "text/csv";
            context.Response.ContentEncoding = Encoding.UTF8;
            context.Response.AppendHeader("Content-Disposition",
                "attachment; filename=" + HttpUtility.UrlEncode(FileName) + ".xls");
            context.Response.HeaderEncoding = Encoding.UTF8;
            context.Response.BinaryWrite(Encoding.UTF8.GetPreamble());

            //标题添加
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                context.Response.Write(dt.Columns[i].ColumnName + ",");
            }
            context.Response.Write(Environment.NewLine);
            double test;
            foreach (DataRow row in dt.Rows)
            {
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (dt.Columns != null)
                    {
                        //不是日期格式情况
                        if (double.TryParse(row[dt.Columns[j]].ToString(), out test))
                            context.Response.Write("=");
                        context.Response.Write("\"" + row[dt.Columns[j]].ToString() + "\",");
                    }
                    else
                    {
                        context.Response.Write("\"\",");
                    }
                }
                context.Response.Write(Environment.NewLine);
            }
            context.Response.Flush();
            context.Response.End();
        }

        /// <summary>
        /// 导出excel公用方法--自动根据gridview的值获取 -- 只针对BoundField的情况
        /// </summary>
        /// <param name="ds"></param>
        /// <param name="FileName"></param>
        /// <param name="grv"></param>
        /// <param name="arrTemplateField"></param>
        /// <param name="changeValues">字段转换特殊处理</param>
        public static void ExportToSpreadsheet(DataSet ds, string FileName, GridView grv,
            string[] arrTemplateField = null, Dictionary<string, Dictionary<string, string>> changeValues = null, List<string> setTextTypeColumms = null)
        {
            //获取栏位
            string[] arrStr = getGrvColunmName(grv, arrTemplateField);

            var context = System.Web.HttpContext.Current;
            context.Response.Clear();
            context.Response.ContentType = "application/ms-excel";
            context.Response.ContentEncoding = Encoding.UTF8;
            context.Response.AppendHeader("Content-Disposition",
                "attachment; filename=" + HttpUtility.UrlEncode(FileName) + ".xls");
            context.Response.HeaderEncoding = Encoding.UTF8;
            context.Response.BinaryWrite(Encoding.UTF8.GetPreamble());

            var sbHtml = new StringBuilder("<html><head><meta http-equiv=Content-Type content=\"text/html; charset=utf-8\"><body>");
            sbHtml.Append("<table border='1' cellspacing='0' cellpadding='0'>");
            sbHtml.Append("<tr>");
            var lstTitle = new List<string> { "cellName" };

            for (int i = 0; i < grv.Columns.Count; i++)
            {
                sbHtml.AppendFormat("<td style='font-size: 14px;text-align:center;background-color: #DCE0E2; font-weight:bold;' height='25'>{0}</td>", grv.Columns[i].HeaderText);
            }

            sbHtml.Append("</tr>");

            foreach (DataRow row in ds.Tables[0].Rows)
            {
                sbHtml.Append("<tr>");
                for (int j = 0; j < arrStr.Length; j++)
                {
                    if (arrStr[j] != null && ds.Tables[0].Columns.Contains(arrStr[j]))
                    {
                        var curValue = row[arrStr[j]].ToString();
                        //数据转换
                        if (changeValues != null && changeValues.ContainsKey(arrStr[j]))
                        {
                            if (changeValues[arrStr[j]].ContainsKey(curValue))
                            {
                                curValue = changeValues[arrStr[j]][curValue];
                            }
                            else
                            {
                                curValue = changeValues[arrStr[j]].Last().Value;
                            }
                        }
                        //数字转文本
                        if (setTextTypeColumms != null && setTextTypeColumms.Contains(arrStr[j]))
                        {
                            sbHtml.AppendFormat("<td style='vnd.ms-excel.numberformat:@; '>{0}</td>", curValue);
                        }
                        else
                        {
                            sbHtml.AppendFormat("<td style='font-size: 12px;height:20px;'>{0}</td>", curValue);
                        }
                    }
                }
                sbHtml.Append("</tr>");
            }

            sbHtml.Append("</table></body></html>");
            context.Response.Write(sbHtml.ToString());


            context.Response.Flush();
            context.Response.End();
        }

        private static string[] getGrvColunmName(GridView grv, string[] arrTemplateField)
        {
            //展示栏位集合获取
            string[] arrCol = new string[grv.Columns.Count];
            int itemp = 0;
            try
            {
                for (int i = 0; i < grv.Columns.Count; i++)
                {
                    if (grv.Columns[i] is BoundField)
                    {
                        var col = ((BoundField)grv.Columns[i]);
                        arrCol[i] = col.DataField;
                    }
                    else if (grv.Columns[i] is TemplateField)
                    {
                        var col = ((TemplateField)grv.Columns[i]);
                        if (!string.IsNullOrWhiteSpace( col.SortExpression))
                        {
                            arrCol[i] = col.SortExpression;
                        }

                        if (arrTemplateField.Length>= itemp+1)
                        {
                            arrCol[i] = arrTemplateField[itemp];
                        }                                               
                        itemp++;
                    }
                }
                return arrCol;
            }
            catch
            {
                throw new Exception("需定义TemplateField所对应的栏位名称");
            }
        }


        public static DataSet GetData(string sql)
        {
            using (SqlConnection con = new SqlConnection(SQLHelper.MESConnString))
            {
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                return ds;
            }
        }

        /// <summary>
        /// 获取标准的decimal的数字的字符（去掉前后无效0）
        /// </summary>
        /// <param name="qty"></param>
        /// <returns></returns>
        public static string ToDecimalFormatStrNotZero(decimal? qty)
        {
            string returnStr = "";
            if (qty == null)
                return "0";
            string strQty = qty.ToString();
            if (strQty.Contains(".") == false)
            {
                return strQty;
            }
            //包含小数点
            List<string> splitStr = strQty.Split('.').ToList();
            string intStr = splitStr[0];
            string pointStr = splitStr[1] + "";
            pointStr = pointStr.TrimEnd('0');
            if (string.IsNullOrEmpty(pointStr) == true)
            {
                //小数点后面无效
                returnStr = intStr;
            }
            else
            {
                //小数点后面有效
                returnStr = intStr + "." + pointStr;
            }
            return returnStr;
        }

    }
}