using System;
using System.Collections;
using System.Web;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.Utility;
using System.Web.UI;
using System.Text;
using System.Security.Cryptography;
using System.Configuration;
using System.Globalization;
using System.Xml;
using Org.BouncyCastle.Math;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.X509;
using Org.BouncyCastle.Asn1.X509;
using Org.BouncyCastle.Asn1.Pkcs;
using Org.BouncyCastle.Pkcs;
using Org.BouncyCastle.Security;

namespace SKT.LeanMES.Web
{
    /// <summary>
    /// 页面的公共方法和属性。
    /// </summary>
    public static class WebHelper
    {
        private static Dictionary<int, Exception> _dictExp = new Dictionary<int, Exception>();
        private static Dictionary<int, string> _dictRem = new Dictionary<int, string>();
        private static String _webRoot = null;

        private static Dictionary<string, int> _websafeset;
        public static int GetWebSafeSet(string key)
        {
            if (_websafeset == null)
                _websafeset = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, int>>(ConfigurationManager.AppSettings["WebSafeSet"]);
            return _websafeset.ContainsKey(key) ? _websafeset[key] : 0;
        }
        /// <summary>
        /// 注册客户端回调。
        /// </summary>
        /// <param name="page">页面对象。</param>
        /// <param name="callServer">引发回调的客户端函数。</param>
        /// <param name="callback">接收处理结果的客户端函数。</param>
        public static void RegisterCallback(System.Web.UI.Page page, String callServer, String callback)
        {
            String callBackRefrence = page.ClientScript.GetCallbackEventReference(page, "arg", callback, "context", "callbackErrorHandler", false);
            String callBackString = String.Format("function {0}(arg, context) {{ {1}; }}", callServer, callBackRefrence);
            callBackString += "function callbackErrorHandler(errorInfo, context) { alert(errorInfo); }";

            page.ClientScript.RegisterClientScriptBlock(page.GetType(), "CallServer", callBackString, true);
        }

        /// <summary>
        /// 显示消息。
        /// </summary>
        /// <param name="message">要显示的消息文本。</param>
        public static void ShowMessage(String message)
        {
            System.Web.UI.Page page = HttpContext.Current.Handler as System.Web.UI.Page;

            if (page != null)
            {
                String script = String.Format("alert(\"{0}\");", message);
                //page.ClientScript.RegisterStartupScript(page.GetType(), "msgBox", script, true);
                ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "msgBox", script, true);
            }
        }

        /// <summary>
        /// 格式化日期
        /// </summary>
        /// <param name="dateString"></param>
        /// <returns></returns>
        public static String FormatToDate(String dateString)
        {
            if (String.IsNullOrEmpty(dateString))
            {
                return "9999-12-31";
            }
            else
            {
                DateTime date = Convert.ToDateTime(dateString);
                if (date < DateTime.Parse("1753-1-1") || date > DateTime.Parse("9999-12-31"))
                {
                    return "9999-12-31";
                }
                else
                {
                    return date.ToString("yyyy-MM-dd");
                }
            }
        }

        /// <summary>
        /// 处理异常。
        /// </summary>
        /// <param name="ex">Exception 对象。</param>
        public static void HandleException(Exception ex)
        {
            HandleException(String.Empty, ex, false);
        }
        /// <summary>
        /// 获取用户上传设备报修图片路径
        /// </summary>
        public static String EquipmentFailureRoot
        {
            get
            {
                return WebRoot + "/UploadFiles/EquipmentFailure/";
            }
        }
        /// <summary>
        /// 处理异常。
        /// </summary>
        /// <param name="operatorName">操作员。</param>
        /// <param name="ex">Exception 对象。</param>
        public static void HandleException(String operatorName, Exception ex)
        {
            HandleException(operatorName, ex, false);
        }

        /// <summary>
        /// 处理异常。
        /// </summary>
        /// <param name="operatorName">操作员。</param>
        /// <param name="ex">Exception 对象。</param>
        /// <param name="isShowMessage">是否显示异常消息。</param>
        public static void HandleException(String operatorName, Exception ex, Boolean isShowMessage)
        {
            //operatorName = AccountController.GetCurrentUser().UserName;
            if (string.IsNullOrWhiteSpace(operatorName))
            {
                //判断是否为空，有些页面可能不需要登录
                try
                {
                    operatorName = AccountController.GetCurrentUser().UserName;
                }
                catch (Exception e)
                {
                    operatorName = string.Empty;
                }
            }

            string msg;
            string logMsg = "";

            if (ex.InnerException == null)
            {
                msg = logMsg = ex.Message;
            }
            else
            {
                if (ex.InnerException.GetType().Name == "SqlException")
                {
                    System.Data.SqlClient.SqlException SqlException = ((System.Data.SqlClient.SqlException)ex.InnerException);
                    var sqlErrorTipFlag = ConfigurationManager.AppSettings["SQLErrorTipFlag"] ?? "0";
                    if (sqlErrorTipFlag == "0" && (SqlException.Number < 50000 || SqlException.Number >= 60000)) //50000及以上错误代码为自定义异常，try catch有小于50000的错误代码时，使用60000以上数字，以便可以正确提示
                    {
                        //不提示具体的错误信息，报数据库错误
                        msg = Resources.Messages.DBAccessError;
                    }
                    else
                    {
                        msg = SqlException.Procedure == "" ? ex.InnerException.Message : SqlException.Message;
                        logMsg = SqlException.Message + " 存储过程：" + SqlException.Procedure + "，操作行：" + (SqlException.LineNumber + 7) + "。";
                    }
                }
                else
                {
                    msg = logMsg = ex.InnerException.Message;
                }
            }

            MESException mesException = ex as MESException;

            if (mesException != null && mesException.MessageResourceClass != "")
            {
                String resourceClass = mesException.MessageResourceClass;
                String resourceKey = mesException.MessageResourceKey;

                if (String.IsNullOrEmpty(resourceClass))
                {
                    resourceClass = "Messages";
                }

                //判断是否带有参数
                string[] paramsKey = null; ;
                if (resourceKey.Contains("|"))
                {
                    paramsKey = resourceKey.Split('|');
                    resourceKey = paramsKey[0];
                    ArrayList al = new ArrayList(paramsKey);
                    al.RemoveAt(0);
                    paramsKey = (string[])al.ToArray(typeof(string));
                }

                Object resource = null;
                try
                {

                    resource = HttpContext.GetGlobalResourceObject(resourceClass, resourceKey, new CultureInfo(GetCurrentCulture()));

                }
                catch (Exception)
                {
                    resource = null;
                }

                if (resource != null)
                {
                    msg = resource.ToString();

                    if (mesException.Args != null)
                    {
                        msg = String.Format(msg, mesException.Args);
                    }
                    if (paramsKey != null)
                    {
                        msg = String.Format(msg, paramsKey);
                    }

                }

                //ErrorLog.WriteEntry(operatorName, msg, ex.StackTrace);
                CommonMethod.InsertSystemErrorLog(operatorName, msg, ex.StackTrace);
            }
            else
            {
                //  ErrorLog.WriteEntry(operatorName, msg, ex.StackTrace);
                CommonMethod.InsertSystemErrorLog(operatorName, logMsg, ex.StackTrace);
            }

            if (isShowMessage)
            {
                ShowMessage(msg);
            }
            else
            {
                throw new Exception(msg);
            }
        }

        /// <summary>
        /// 处理异常
        /// </summary>
        /// <param name="operatorName">操作员。</param>
        /// <param name="ex">Exception 对象。</param>
        /// <param name="custormerMsg">用户自定义异常消息。</param>
        /// <param name="isShowMessage">是否显示异常消息。</param>
        public static void HandleException(String operatorName, Exception ex, String custormerMsg, Boolean isShowMessage)
        {
            //operatorName = AccountController.GetCurrentUser().UserName;
            if (string.IsNullOrWhiteSpace(operatorName))
            {
                //判断是否为空，有些页面可能不需要登录
                try
                {
                    operatorName = AccountController.GetCurrentUser().UserName;
                }
                catch (Exception e)
                {
                    operatorName = string.Empty;
                }
            }

            string msg;
            string logMsg = "";

            if (ex.InnerException == null)
            {
                msg = logMsg = string.IsNullOrWhiteSpace(custormerMsg) ? ex.Message : custormerMsg;
            }
            else
            {
                if (ex.InnerException.GetType().Name == "SqlException")
                {
                    System.Data.SqlClient.SqlException SqlException = ((System.Data.SqlClient.SqlException)ex.InnerException);
                    var sqlErrorTipFlag = ConfigurationManager.AppSettings["SQLErrorTipFlag"] ?? "0";
                    if (sqlErrorTipFlag == "0" && (SqlException.Number < 50000 || SqlException.Number >= 60000)) //50000及以上错误代码为自定义异常，try catch有小于50000的错误代码时，使用60000以上数字，以便可以正确提示
                    {
                        //不提示具体的错误信息，报数据库错误
                        msg = Resources.Messages.DBAccessError;
                    }
                    else
                    {
                        msg = SqlException.Procedure == "" ? ex.InnerException.Message : SqlException.Message;
                        logMsg = SqlException.Message + " 存储过程：" + SqlException.Procedure + "，操作行：" + (SqlException.LineNumber + 7) + "。";
                    }
                }
                else
                {
                    msg = logMsg = ex.InnerException.Message;
                }
            }

            MESException mesException = ex as MESException;

            if (mesException != null && mesException.MessageResourceClass != "")
            {
                String resourceClass = mesException.MessageResourceClass;
                String resourceKey = mesException.MessageResourceKey;

                if (String.IsNullOrEmpty(resourceClass))
                {
                    resourceClass = "Messages";
                }

                //判断是否带有参数
                string[] paramsKey = null; ;
                if (resourceKey.Contains("|"))
                {
                    paramsKey = resourceKey.Split('|');
                    resourceKey = paramsKey[0];
                    ArrayList al = new ArrayList(paramsKey);
                    al.RemoveAt(0);
                    paramsKey = (string[])al.ToArray(typeof(string));
                }

                Object resource = null;
                try
                {

                    resource = HttpContext.GetGlobalResourceObject(resourceClass, resourceKey, new CultureInfo(GetCurrentCulture()));

                }
                catch (Exception)
                {
                    resource = null;
                }

                if (resource != null)
                {
                    msg = resource.ToString();

                    if (mesException.Args != null)
                    {
                        msg = String.Format(msg, mesException.Args);
                    }
                    if (paramsKey != null)
                    {
                        msg = String.Format(msg, paramsKey);
                    }

                }

                //ErrorLog.WriteEntry(operatorName, msg, ex.StackTrace);
                CommonMethod.InsertSystemErrorLog(operatorName, msg, ex.StackTrace);
            }
            else
            {
                //  ErrorLog.WriteEntry(operatorName, msg, ex.StackTrace);
                CommonMethod.InsertSystemErrorLog(operatorName, logMsg, ex.StackTrace);
            }

            if (isShowMessage)
            {
                ShowMessage(msg);
            }
            else
            {
                throw new Exception(msg);
            }

        }
        /// <summary>
        /// 获取异常消息
        /// </summary>
        /// <param name="operatorName"></param>
        /// <param name="ex"></param>
        /// <returns></returns>
        public static string GetExceptionMsg(string operatorName, Exception ex)
        {
            string msg;
            string logMsg = "";

            if (ex.InnerException == null)
            {
                msg = logMsg = ex.Message;
            }
            else
            {
                if (ex.InnerException.GetType().Name == "SqlException")
                {
                    System.Data.SqlClient.SqlException SqlException = ((System.Data.SqlClient.SqlException)ex.InnerException);
                    var sqlErrorTipFlag = ConfigurationManager.AppSettings["SQLErrorTipFlag"] ?? "0";
                    if (sqlErrorTipFlag == "0" && (SqlException.Number < 50000 || SqlException.Number >= 60000)) //50000及以上错误代码为自定义异常，try catch有小于50000的错误代码时，使用60000以上数字，以便可以正确提示
                    {
                        //不提示具体的错误信息，报数据库错误
                        msg = Resources.Messages.DBAccessError;
                    }
                    else
                    {
                        msg = SqlException.Procedure == "" ? ex.InnerException.Message : SqlException.Message;
                        logMsg = SqlException.Message + " 存储过程：" + SqlException.Procedure + "，操作行：" + (SqlException.LineNumber + 7) + "。";
                    }
                }
                else
                {
                    msg = logMsg = ex.InnerException.Message;
                }
            }

            MESException mesException = ex as MESException;

            if (mesException != null && mesException.MessageResourceClass != "")
            {
                String resourceClass = mesException.MessageResourceClass;
                String resourceKey = mesException.MessageResourceKey;

                if (String.IsNullOrEmpty(resourceClass))
                {
                    resourceClass = "Messages";
                }

                //判断是否带有参数
                string[] paramsKey = null; ;
                if (resourceKey.Contains("|"))
                {
                    paramsKey = resourceKey.Split('|');
                    resourceKey = paramsKey[0];
                    ArrayList al = new ArrayList(paramsKey);
                    al.RemoveAt(0);
                    paramsKey = (string[])al.ToArray(typeof(string));
                }

                Object resource = null;
                try
                {

                    resource = HttpContext.GetGlobalResourceObject(resourceClass, resourceKey, new CultureInfo(GetCurrentCulture()));

                }
                catch (Exception)
                {
                    resource = null;
                }

                if (resource != null)
                {
                    msg = resource.ToString();

                    if (mesException.Args != null)
                    {
                        msg = String.Format(msg, mesException.Args);
                    }
                    if (paramsKey != null)
                    {
                        msg = String.Format(msg, paramsKey);
                    }

                }

                //ErrorLog.WriteEntry(operatorName, msg, ex.StackTrace);
                CommonMethod.InsertSystemErrorLog(operatorName, msg, ex.StackTrace);
            }
            else
            {
                //  ErrorLog.WriteEntry(operatorName, msg, ex.StackTrace);
                CommonMethod.InsertSystemErrorLog(operatorName, logMsg, ex.StackTrace);
            }

            return msg;
        }

        /// <summary>
        /// 记住当前用户的异常供错误页面处理。
        /// </summary>
        /// <param name="exp">Exception 对象。</param>
        public static void WriteException(Exception exp)
        {

            int key = AccountController.GetCurrentUser().UserId;
            if (_dictExp.ContainsKey(key))
            {
                _dictExp[key] = exp;
            }
            else _dictExp.Add(key, exp);

        }

        /// <summary>
        /// 读取当前用户的异常。
        /// </summary>
        public static Exception ReadException()
        {

            int key = AccountController.GetCurrentUser().UserId;
            if (_dictExp.ContainsKey(key))
            {
                return _dictExp[key];
            }
            return null;

        }

        /// <summary>
        /// 记住当前用户的须记住的信息。
        /// </summary>
        /// <param name="exp">Exception 对象。</param>
        public static void WriteRemeber(string rem)
        {

            int key = AccountController.GetCurrentUser().UserId;
            if (_dictRem.ContainsKey(key))
            {
                _dictRem[key] = rem;
            }
            else _dictRem.Add(key, rem);

        }

        /// <summary>
        /// 读取当前用户的异常。
        /// </summary>
        public static string ReadRemeber()
        {

            int key = AccountController.GetCurrentUser().UserId;
            if (_dictRem.ContainsKey(key))
            {
                return _dictRem[key];
            }

            return "";
        }

        /// <summary>
        /// 获取网站的根路径
        /// </summary>
        public static String WebRoot
        {
            get
            {
                if (_webRoot == null)
                {
                    _webRoot = HttpContext.Current.Request.ApplicationPath;
                    if (_webRoot.Length > 0 && _webRoot.EndsWith("/"))
                    {
                        _webRoot = _webRoot.Substring(0, _webRoot.Length - 1);
                    }
                }

                return _webRoot;
            }
        }

        /// <summary>
        /// 获取图片的根路径。
        /// </summary>
        public static String ImageRoot
        {
            get
            {
                String theme = "Metro";

                return String.Format("{0}/Content/theme/{1}/Images/", WebRoot, theme);
            }
        }

        /// <summary>
        /// 获取操作图片的根路径。
        /// </summary>
        public static String OperateImageRoot
        {
            get
            {
                return ImageRoot + "Icon/";
            }
        }

        /// <summary>
        /// 获取Excel模板的根路径。
        /// </summary>
        public static String ExcelTemplateRoot
        {
            get
            {
                return WebRoot + "/ExcelTemplate/";
            }
        }

        /// <summary>
        /// 获取出货报告相关文件。
        /// </summary>
        public static String ShippingReport
        {
            get
            {
                return WebRoot + "/UploadFiles/ShippingReport/";
            }
        }
        /// <summary>
        /// 获取实验报告相关文件。
        /// </summary>
        public static string TestReport
        {
            get
            {
                return WebRoot + "/UploadFiles/TestReport/";
            }
        }


        /// <summary>
        /// 模具异常图片
        /// </summary>
        public static String MouldAnormalPictureFileRoot
        {
            get
            {
                return WebRoot + "/UploadFiles/MouldAnormalPicture/";
            }
        }
        /// <summary>
        /// 获取IQC检验相关文件。
        /// </summary>
        public static String InspectionFileRoot
        {
            get
            {
                return WebRoot + "/UploadFiles/Inspection/";
            }
        }
        /// <summary>
        /// 设备图片
        /// </summary>
        public static String EQPictureFileRoot
        {
            get
            {
                return WebRoot + "/UploadFiles/EQPicture/";
            }
        }
        /// <summary>
        /// 设备文件
        /// </summary>
        public static String EQFileRoot
        {
            get
            {
                return WebRoot + "/UploadFiles/EQFile/";
            }
        }
        /// <summary>
        /// 设备校验证书文件
        /// </summary>
        public static String EQCheckOutFileRoot
        {
            get
            {
                return WebRoot + "/UploadFiles/EQFile/CheckOutFile";
            }
        }
        public static string FileModelRoot
        {
            get
            {
                return WebRoot + "/Content/Template/";
            }
        }
        /// <summary>
        /// 获取临时文件的根路径。t
        /// </summary>
        public static String TempFileRoot
        {
            get
            {
                String tempFileVirtualPath = WebRoot + "/TempFile/";
                String tempFilePath = HttpContext.Current.Server.MapPath(tempFileVirtualPath);

                if (System.IO.Directory.Exists(tempFilePath) == false)
                {
                    System.IO.Directory.CreateDirectory(tempFilePath);
                }

                return tempFileVirtualPath;
            }
        }

        /// <summary>
        /// 获取用户上传文件的根路径。
        /// </summary>
        public static String UploadFileRoot
        {
            get
            {
                return WebRoot + "/OnlineService/";
            }
        }

        /// <summary>
        /// 获取Excel连接字符串
        /// 首先说明一下Microsoft.Jet.OLEDB.4.0和Microsoft.ACE.OLEDB.12.0区别：
        /// 有两种接口可供选择：Microsoft.Jet.OLEDB.4.0（以下简称 Jet 引擎）和Microsoft.ACE.OLEDB.12.0（以下简称 ACE 引擎）。
        /// Jet 引擎大家都很熟悉，可以访问 Office 97-2003，但不能访问 Office 2007。
        /// ACE 引擎是随 Office 2007 一起发布的数据库连接组件，既可以访问 Office 2007，也可以访问 Office 97-2003。
        /// 另外：Microsoft.ACE.OLEDB.12.0 可以访问正在打开的 Excel 文件，而 Microsoft.Jet.OLEDB.4.0 是不可以的。
        /// </summary>
        public static String ExcelConnString
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ExcelConnString"].ToString();
            }
        }

        /// <summary>
        /// 工厂代码，如果没有配置，则返回空字符串
        /// </summary>
        public static String Site
        {
            get
            {
                if (!String.IsNullOrEmpty(System.Configuration.ConfigurationManager.AppSettings["Site"]))
                {
                    return System.Configuration.ConfigurationManager.AppSettings["Site"].ToString();

                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// 检查Session，如果超时抛出timeout异常
        /// </summary>
        public static void CheckSession()
        {
            if (AccountController.GetCurrentUser(true) == null)
            {
                throw new Exception("timeout");
            }
        }

        /// <summary>
        /// 获取系统当前的语言
        /// </summary>
        /// <returns></returns>
        public static string GetCurrentCulture()
        {
            HttpCookie cookieLang = new HttpCookie("lang");
            if (HttpContext.Current.Request.Cookies["lang"] != null)
            {
                return HttpContext.Current.Request.Cookies["lang"].Value;
            }
            else
            {
                return "";
            }
        }
        public static string DesDecrypt(string data)
        {
            TripleDES des = TripleDES.Create();
            des.Key = ASCIIEncoding.UTF8.GetBytes("6512bd43d9caa6e02c990b0a");
            des.Mode = CipherMode.ECB;
            des.Padding = PaddingMode.PKCS7;
            ICryptoTransform form = des.CreateDecryptor();
            byte[] bytes = Convert.FromBase64String(data);
            return ASCIIEncoding.UTF8.GetString(form.TransformFinalBlock(bytes, 0, bytes.Length));
        }
        public static string DesEncrypt(string data)
        {
            TripleDES des = TripleDES.Create();
            des.Key = ASCIIEncoding.UTF8.GetBytes("6512bd43d9caa6e02c990b0a");
            des.Mode = CipherMode.ECB;
            des.Padding = PaddingMode.PKCS7;
            ICryptoTransform form = des.CreateEncryptor();
            byte[] bytes = ASCIIEncoding.UTF8.GetBytes(data);
            return Convert.ToBase64String(form.TransformFinalBlock(bytes, 0, bytes.Length));
        }
    }
}