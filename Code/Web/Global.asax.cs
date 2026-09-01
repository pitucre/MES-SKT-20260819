using Newtonsoft.Json;
using SKT.Common.Account.Model;
using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using SKT.LeanMES.Web.AppCode.Utility;
using ConfigHelper = SKT.Common.Utility.ConfigHelper;

namespace SKT.LeanMES.Web
{
    public class Global : Systems.Web.HttpApplication
    {
        //private static List<string> _listSqlKeyword = null;
        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                if (Request.Files.Count > 0)
                {
                    // 仅对文件上传的请求进行处理
                    foreach (string fileKey in Request.Files)
                    {
                        HttpPostedFile file = Request.Files[fileKey];

                        var fileName = Request.Params["fileName"];

                        if (!string.IsNullOrEmpty(fileName))
                        {
                            // 拓展名
                            var ext = Path.GetExtension(fileName);
                            var fExt = Path.GetExtension(file.FileName);
                            if (ext != fExt)
                            {
                                Response.StatusCode = 400; // Bad Request
                                Response.Write("无效的文件类型！");
                                Response.End();           // 终止请求
                            }
                        }



                        if (!FileValidator.IsAllowed(file.FileName))
                        {
                            Response.StatusCode = 400; // Bad Request
                            Response.Write("文件类型不允许上传！");
                            Response.End();           // 终止请求
                        }
                    }
                }

            }
        }

        protected void Application_AcquireRequestState(object sender, EventArgs e)
        {
            //验证线别数量是否超过License设定的数量，超过则提示并进行跳转
            ValidateLineQty();

            var httpContext = HttpContext.Current;
            bool isNeedLogin = true;

            //AppCode.Utility.FileSync.Start(httpContext);

            if (httpContext.Request.UrlReferrer != null)
            {
                //检查当前页面是否需要登录后才能操作
                var absolutePath = httpContext.Request.UrlReferrer.AbsolutePath.Split('/');
                if (absolutePath != null && absolutePath.Length > 0)
                {
                    string pageName = absolutePath[absolutePath.Length - 1];
                    isNeedLogin = AccountController.CheckIsNeedLogin(pageName);
                }
            }
            if (isNeedLogin
                && httpContext.Session != null
                && httpContext.Session.Count == 0
                && (httpContext.Request.Headers.GetValues("X-AjaxPro-Method") != null || !string.IsNullOrWhiteSpace(httpContext.Request.Form["hdnOperate"]))
                )
            {
                RecordeWrite();
                httpContext.Response.Write("null; r.error = {\"Message\":\"登录超时，请重新登录！\",\"Type\":\"System.Exception\"};/*");
                httpContext.Response.End();
            }
            //非法请求
            string result = Application_BeginSecurityValidate(httpContext, isNeedLogin);
            if (result != null)
            {
                httpContext.Response.Write(result);
                httpContext.Response.End();
                return;
            }

            //记录最后访问时间，处理超出用户并发数
            if (httpContext != null && httpContext.Session != null && httpContext.Session.Count > 0)
            {
                //忽略特殊的url（特别是做轮询操作的）
                List<string> ignoreUrl = new List<string>() {
                    "/Handler/Account.ashx",
                    "/ajax.html"
                };
                if (ignoreUrl.Exists(p => httpContext.Request.Url.AbsoluteUri.Contains(p)))
                {
                    return;
                }
                //设定间隔时间
                int interval = 60;
                DateTime? lastVisitTime = null;
                if (httpContext.Session["LastVisitTime"] != null)
                {
                    lastVisitTime = Convert.ToDateTime(httpContext.Session["LastVisitTime"]);
                    if (lastVisitTime.Value.AddSeconds(interval) > DateTime.Now)
                    {
                        return;
                    }
                }
                var user = AccountController.GetCurrentUser(true);
                if (user != null)
                {
                    //记录最后访问时间
                    httpContext.Session["LastVisitTime"] = DateTime.Now;
                    new SKT.Common.Account.BLL.Users().UpdateLastVistTime(user.UserId);
                    //处理并发用户超出（1.用户并发授权 2.超时 3.当前用户数超过最大并发用户数 4.是否供应商用户并且配置需要校验）
                    if (lastVisitTime.HasValue)
                    {
                        int concurrentUserTimeout = Convert.ToInt32(ConfigHelper.GetAppConfig("ConcurrentUserTimeout") ?? "5");     //并发用户的超时时间
                        bool isCheckSupplierUser = (ConfigHelper.GetAppConfig("IsCheckSupplierUser") ?? "0") == "1";                //是否检查供应商用户
                        //管理员和供应商用户（配置不需要校验时）不处理
                        if (user.UserId == -1 || (user.UserType != -1 && !isCheckSupplierUser))
                        {
                            return;
                        }
                        dynamic licenseInfo = AccountController.GetLicenseInfo(HttpContext.Current);
                        if (licenseInfo.LicenseType == 1
                            && licenseInfo.OnlineUserQty > licenseInfo.UserQty)
                        {
                            //注销用户
                            AccountController.Logout();
                            //提示并跳转登录
                            httpContext.Response.Write("<script>alert('超出用户并发数,自动退出！');window.location.href ='" + SKT.LeanMES.Web.WebHelper.WebRoot + "/Logout.aspx';</script>");
                            httpContext.Response.End();
                            return;
                        }
                    }
                }
            }
        }

        private string Application_BeginSecurityValidate(HttpContext httpContext, bool isNeedLogin)
        {
            try
            {

                string ajax_method = httpContext.Request.Headers["X-AjaxPro-Method"];
                string operate = httpContext.Request.Form["hdnOperate"];

                //表单数据
                Stream stream = httpContext.Request.InputStream;
                long index = stream.Position;
                if (index > 0)
                    stream.Position = 0;
                StreamReader sr = new StreamReader(stream);
                string json = sr.ReadToEnd();
                stream.Position = index;

                //01.反射型XSS
                if (WebHelper.GetWebSafeSet("xss") > 0)
                {
                    string xssresult = null;
                    //Cookie
                    Dictionary<string, object> dic = new Dictionary<string, object>();
                    foreach (var key in httpContext.Request.Cookies.AllKeys)
                    {
                        if (!dic.Keys.Contains(key))
                        {
                            dic.Add(key, httpContext.Request.Cookies[key].Value);
                        }
                    }
                    //查询字符串
                    foreach (var key in httpContext.Request.QueryString.AllKeys)
                    {
                        if (key == null)
                        {
                            continue;
                        }
                        if (key != null && !dic.Keys.Contains(key))
                        {
                            dic.Add(key, httpContext.Request.QueryString[key]);
                        }
                    }
                    xssresult = SecurityValidate_XSS(JsonConvert.SerializeObject(dic));
                    if (xssresult != null)
                        return xssresult;
                    //表单提交
                    if (!string.IsNullOrWhiteSpace(json))
                    {
                        xssresult = SecurityValidate_XSS(json);
                    }
                    if (xssresult != null)
                        return xssresult;
                }
                //SQL注入
                if (WebHelper.GetWebSafeSet("sql") > 0)
                {
                    //SecurityValidate_SQL(json);
                    SKT.LeanMES.SqlInjection.BLL.SqlInjectionHelper.SecurityValidate_SQL(json, httpContext);
                }

                //02.防止重复重复模拟请求
                int? userId = null;
                if (httpContext.Session != null && httpContext.Session.Count > 0)
                {
                    int csrf = WebHelper.GetWebSafeSet("csrf");
                    if (csrf > 0 && ((!string.IsNullOrWhiteSpace(ajax_method) && httpContext.Request.Headers["X-AjaxPro-Key"] != null) || !string.IsNullOrWhiteSpace(operate)))
                    {
                        string time = "";
                        if (!string.IsNullOrWhiteSpace(ajax_method))
                            time = httpContext.Request.Headers["X-AjaxPro-Key"];
                        else
                            time = httpContext.Request.Form["hdnSubmitIdentityKey"];

                        if (string.IsNullOrWhiteSpace(time))
                            return "null; r.error = {\"Message\":\"非法请求:021\",\"Type\":\"System.Exception\"};/*";

                        time = WebHelper.DesDecrypt(time);
                        if (string.IsNullOrWhiteSpace(time))
                            return "null; r.error = {\"Message\":\"非法请求:022\",\"Type\":\"System.Exception\"};/*";

                        long server_time = Convert.ToInt64(time);
                        long now_time = (long)(DateTime.Now - AccountController.StartTime).TotalMilliseconds;
                        if (server_time > now_time)
                            return "null; r.error = {\"Message\":\"非法请求:023\",\"Type\":\"System.Exception\"};/*";

                        if (server_time + csrf * 1000 < now_time)
                        {
                            RecordeWrite("非法请求:" + server_time + "至" + now_time);
                            return "null; r.error = {\"Message\":\"非法请求:024\",\"Type\":\"System.Exception\"};/*";
                        }
                    }
                    //获取用户
                    userId = GetMembershipInfo(httpContext)?.UserId;
                }



                //03.防止越权操作
                //Form验证(华为云评审)
                int formAuth = WebHelper.GetWebSafeSet("formAuth");
                if (formAuth > 0)
                {
                    string fromToken = httpContext.Request.Cookies[".ASPXAUTH"]?.Value;
                    string strPort = httpContext.Request.Url.Port == 80 ? "" : $":{httpContext.Request.Url.Port}";
                    string rootUrl = $"{httpContext.Request.Url.Scheme}://{httpContext.Request.Url.Host}{strPort}{SKT.LeanMES.Web.WebHelper.WebRoot}/";
                    string[] loginPagesUrl = new string[] { "Login.aspx", "Logout.aspx", "Default.aspx", "Index.aspx", "MobileApp/Login.aspx" };
                    bool isLoginPage = (loginPagesUrl.Any(x => httpContext.Request.Url.AbsoluteUri.IndexOf(x, StringComparison.OrdinalIgnoreCase) > -1) || httpContext.Request.Url.AbsoluteUri.Equals(rootUrl, StringComparison.OrdinalIgnoreCase)) ? true
                        : httpContext.Request.UrlReferrer == null ? false
                        : loginPagesUrl.Any(x => httpContext.Request.UrlReferrer.AbsoluteUri.IndexOf(x, StringComparison.OrdinalIgnoreCase) > -1) && httpContext.Request.Headers["X-Requested-With"] != null ? true : false;
                    if (!isLoginPage && string.IsNullOrWhiteSpace(fromToken))
                    {
                        httpContext.Response.StatusCode = 401;
                        httpContext.Response.Write("用户登录令牌失效,没有访问权限");
                        httpContext.Response.End();
                        return null;
                    }
                }

                if (userId == null || userId == -1)
                    return null;

                //MES验证
                string refPopedom = null, popedom = null;
                if (isNeedLogin && WebHelper.GetWebSafeSet("auth") > 0 && (!string.IsNullOrWhiteSpace(ajax_method) || !string.IsNullOrWhiteSpace(operate)))
                {
                    Match match;
                    if (httpContext.Request.UrlReferrer != null)
                    {
                        match = Regex.Match(httpContext.Request.UrlReferrer.Query, @"name=\w+", RegexOptions.IgnoreCase);
                        if (match != null && match.Success)
                            refPopedom = Regex.Replace(match.Value, "name=", "", RegexOptions.IgnoreCase);
                    }
                    if (httpContext.Request.Url != null)
                    {
                        match = Regex.Match(httpContext.Request.Url.Query, @"name=\w+", RegexOptions.IgnoreCase);
                        if (match != null && match.Success)
                            popedom = Regex.Replace(match.Value, "name=", "", RegexOptions.IgnoreCase);
                    }
                    if (!string.IsNullOrWhiteSpace(refPopedom) && !AccountController.CheckUserPopedomName(userId.Value, refPopedom))
                        return "null; r.error = {\"Message\":\"非法请求:您没有权限\",\"Type\":\"System.Exception\"};/*";
                    if (!string.IsNullOrWhiteSpace(popedom) && !AccountController.CheckUserPopedomName(userId.Value, popedom))
                        return "null; r.error = {\"Message\":\"非法请求:您没有权限\",\"Type\":\"System.Exception\"};/*";
                }
                return null;
            }
            catch (Exception ex)
            {
                RecordeWrite("Application_BeginSecurityValidate异常：" + ex.Message + "," + ex.StackTrace);
                return "null; r.error = {\"Message\":\"非法请求:" + ex.Message + "\",\"Type\":\"System.Exception\"};/*";
            }
        }
        /// <summary>
        /// XSS注入
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        private string SecurityValidate_XSS(string json)
        {
            try
            {
                Dictionary<string, object> dic = JsonConvert.DeserializeObject<Dictionary<string, object>>(json);
                foreach (var item in dic)
                {
                    if (item.Value == null)
                        continue;
                    if (item.Value.GetType().Name.Equals("String"))
                    {
                        //第一种情况，html标签 含有脚本
                        //如果含有html标签 标签有属性的情况，如果属性名是on开头或者src，如果内容是非(数字和字母和下划线)组成的，则认为是脚本
                        string label = Regex.Match(item.Value.ToString(), @"<\s*\w+(\s+\w+\s*=\s*((""(?:[^""\\]|\\.)*"")|('(?:[^'\\]|\\.)*')))+\s*/?\s*>", RegexOptions.IgnoreCase).Value;
                        if (!string.IsNullOrWhiteSpace(label))
                        {
                            MatchCollection kvs = Regex.Matches(label, @"\w+\s*=\s*((""(?:[^""\\]|\\.)*"")|('(?:[^'\\]|\\.)*'))", RegexOptions.IgnoreCase);
                            foreach (var kv in kvs)
                            {
                                if (Regex.IsMatch(kv.ToString(), @"^(on\w+|src)\s*=", RegexOptions.IgnoreCase))
                                {
                                    string value = Regex.Match(kv.ToString(), @"((""(?:[^""\\]|\\.)*"")|('(?:[^'\\]|\\.)*'))").Value;
                                    value = value.Substring(1, value.Length - 2);
                                    if (Regex.IsMatch(value, @"\W+"))
                                    {
                                        return "null; r.error = " + JsonConvert.SerializeObject(new Dictionary<string, string>() {
                                            { "Message","非法字符:"+ HttpUtility.UrlEncode(kv.ToString())},
                                            { "Type","System.Exception"}
                                        }) + ";/*";
                                    }
                                }
                            }
                        }
                        //第二种情况，脚本块 < script type=\"text/javascript\" > < / script >   type属性 可有可无
                        string script = Regex.Match(item.Value.ToString(), @"<\s*script(\s+\w+\s*=\s*((""(?:[^""\\]|\\.)*"")|('(?:[^'\\]|\\.)*')))*\s*>(.|\n)+<\s*/\s*script\s*>", RegexOptions.IgnoreCase).Value;
                        if (!string.IsNullOrWhiteSpace(script))
                        {
                            return "null; r.error = " + JsonConvert.SerializeObject(new Dictionary<string, string>() {
                                { "Message","非法字符:"+ HttpUtility.UrlEncode(script) },
                                { "Type","System.Exception"}
                            }) + ";/*";
                        }
                        //第三种情况，XSLT注入
                        string xsl = Regex.Match(item.Value.ToString(), @"\s*system-property\s*(.*xsl.*)\s*", RegexOptions.IgnoreCase).Value;
                        if (!string.IsNullOrWhiteSpace(xsl))
                        {
                            return "null; r.error = " + JsonConvert.SerializeObject(new Dictionary<string, string>() {
                                { "Message","非法字符:"+ HttpUtility.UrlEncode(xsl) },
                                { "Type","System.Exception"}
                            }) + ";/*";
                        }
                        //WASPostParam Cookie注入
                        if (item.Key.Trim().Equals("WASPostParam", StringComparison.OrdinalIgnoreCase))
                        {
                            return "null; r.error = " + JsonConvert.SerializeObject(new Dictionary<string, string>() {
                                { "Message","非法字符:"+ HttpUtility.UrlEncode(item.Key.Trim()) },
                                { "Type","System.Exception"}
                            }) + ";/*";
                        }
                    }
                    else if (item.Value.GetType().Name.Equals("JObject"))
                    {
                        return SecurityValidate_XSS(JsonConvert.SerializeObject(item.Value));
                    }
                }
            }
            catch (Exception)
            {
            }
            return null;
        }


        /// <summary>
        /// SQL注入
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        private void SecurityValidate_SQL(string json)
        {
            var listSqlKeyword = SqlInjectableHelper.GetSqlKeywordList();

            var ignoreKeywords = SqlInjectableHelper.GetIgnoreSqlKeywordList();

            if (listSqlKeyword == null || listSqlKeyword.Count <= 0) return;
            //// 移除忽略的关键字
            //HashSet<string> ignoreCaseSet = new HashSet<string>(
            //    ignoreKeywords,
            //    StringComparer.OrdinalIgnoreCase
            //);

            //listSqlKeyword.RemoveAll(item => ignoreCaseSet.Contains(item));


            var list = new Dictionary<string, string>();
            Dictionary<string, object> dic = null;
            try
            {
                if (!string.IsNullOrWhiteSpace(json))
                {
                    dic = JsonConvert.DeserializeObject<Dictionary<string, object>>(json);
                }
            }
            catch
            {

            }
            if (dic != null)
            {
                //Json格式
                foreach (var item in dic)
                {
                    if (item.Value == null)
                        continue;
                    if (item.Value.GetType().Name.Equals("String"))
                    {
                        list.Add(item.Key, item.Value.ToString());
                    }
                    else if (item.Value.GetType().Name.Equals("JObject"))
                    {
                        SecurityValidate_SQL(JsonConvert.SerializeObject(item.Value));
                    }
                }
            }
            else
            {
                //Form表单
                foreach (var key in Request.Form.AllKeys)
                {
                    // 忽略掉 删除操作传入参数 
                    if (!list.ContainsKey(key))
                    {
                        list.Add(key, Request.Form[key]);
                    }
                }
            }
            //查询字符串
            foreach (var key in Request.QueryString.AllKeys)
            {
                if (key == null)
                {
                    continue;
                }
                if (!list.ContainsKey(key))
                {
                    list.Add(key, Request.QueryString[key]);
                }
            }
            //验证
            foreach (var item in list)
            {
                var value = item.Value;
                // 多个空格替换成一个
                value = Regex.Replace(value, @"\s+", " ");
                if (string.IsNullOrWhiteSpace(value))
                {
                    continue;
                }

                //布尔恒真条件的拦截
                Regex booleanInjectionRegex = new Regex(
                    @"(?i)(['""]\s*(or|and)\s*['""]?[01]?['""]?\s*=\s*['""]?[01]?['""]?)",
                    RegexOptions.Compiled
                );

                if (booleanInjectionRegex.IsMatch(value))
                {
                    throw new Exception($"SQL注入检测：非法输入'{value}'包含非法字符:{booleanInjectionRegex.Match(value).Value}");
                }


                //  数据库关键字验证
                var query = from a in listSqlKeyword
                            where
                            !value.Equals("create", StringComparison.OrdinalIgnoreCase) &&
                            !value.Equals("delete", StringComparison.OrdinalIgnoreCase) &&
                            !value.Equals("insert", StringComparison.OrdinalIgnoreCase) &&
                            !value.Equals("update", StringComparison.OrdinalIgnoreCase)
                            &&
                            (
                            Regex.IsMatch(value,
                              $@"(?i)(['\s]?(and|or|exec)['\s]?{Regex.Escape(a)}.*-{{2,}})",
                              RegexOptions.IgnoreCase
                             )
                            || // 排除系统关键字  delete
                            Regex.IsMatch(
                                value,
                                $@"(^|[^\w-]){Regex.Escape(a)}([^\w-]|$)(\s*$$)?|(^|[^\w-]){Regex.Escape(a)}\s",
                                RegexOptions.IgnoreCase
                            ))
                            select a;
                var sql = query.FirstOrDefault();

                if (sql != null)
                {
                    throw new Exception($"SQL注入检测：非法输入'{value}'包含非法字符:{sql}");
                }
            }
        }




        private MembershipInfo GetMembershipInfo(HttpContext httpContext)
        {
            foreach (var item in httpContext.Session.Keys)
            {
                var value = httpContext.Session[item.ToString()].ToString();

                if (value.ToLower().IndexOf("username") > -1)
                {
                    MembershipInfo info = JsonConvert.DeserializeObject<MembershipInfo>(value);
                    return info;
                }
            }
            return null;
        }
        /// <summary>
        /// 记录攻击信息
        /// </summary>
        protected void RecordeWrite(string content = null)
        {
            try
            {
                string fileDic = "~/Logs/Error/";
                string path = fileDic + DateTime.Today.ToString("dd-MM-yy") + ".txt";
                if (!System.IO.Directory.Exists(HttpContext.Current.Server.MapPath(fileDic)))
                {
                    System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath(fileDic));
                }
                if (!System.IO.File.Exists(HttpContext.Current.Server.MapPath(path)))
                {
                    System.IO.File.Create(HttpContext.Current.Server.MapPath(path)).Close();
                }
                using (System.IO.StreamWriter w = System.IO.File.AppendText(HttpContext.Current.Server.MapPath(path)))
                {
                    if (string.IsNullOrWhiteSpace(content))
                    {
                        w.WriteLine("当前时间：{0}", System.DateTime.Now.ToString());
                        w.WriteLine("当前IP：{0} ", HttpContext.Current.Request.UserHostAddress);
                        w.WriteLine("当前Url：{0} ", HttpContext.Current.Request.Url.ToString());
                    }
                    else
                    {
                        w.WriteLine("时间：" + DateTime.Now.ToString());
                        w.WriteLine(content);
                    }
                    w.WriteLine("__________________________________");
                    w.Flush();
                    w.Close();
                }
            }
            catch (Exception)
            {
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            try
            {
                Exception ex = this.Server.GetLastError();

                WebHelper.WriteException(ex);
                //WebHelper.HandleException(ex);
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message);
            }
        }


        /// <summary>
        /// 验证线别数量是否超过License设定的数量，超过则提示并进行跳转
        /// </summary>
        protected void ValidateLineQty()
        {
            //不是Client或SDP中的页面或页面中没有资源信息的，则不校验
            var url = Request.RawUrl;
            var resource = Request.QueryString["resourceid"];//资源Id
            int resourceId = -1;
            var appPath = Request.ApplicationPath.TrimEnd('/');//移除最后一个/
            if ((!url.StartsWith(string.Concat(appPath, "/Client/")) && !url.StartsWith(string.Concat(appPath, "/SDP/SDPUI.aspx"))) || resource == null || !int.TryParse(resource, out resourceId))
            {
                return;
            }

            //获取License允许的线别数量
            var maxLineQty = Convert.ToInt32(HttpContext.Current.Application["LineQty"]);
            if (maxLineQty <= 0)
            {
                return;
            }

            //判断该线是否在License中设定的数量范围内
            string sql = string.Format(@"
                --验证ID有效
                IF NOT EXISTS(SELECT 1 FROM Basal_Resource WHERE ResourceId =@ResourceId)
                BEGIN
	                SELECT -1
	                RETURN 
                END
                --验证资源是否绑定产线
                IF NOT EXISTS(
	                SELECT 1 FROM Basal_Resource A
		                INNER JOIN Basal_Line B ON B.LineId = A.LineId
	                WHERE A.ResourceId =@ResourceId AND A.LineId <>-1
                )
                BEGIN
	                SELECT -2
	                RETURN 
                END
                --验证资源所在产线是否授权
                IF NOT EXISTS(
	                SELECT 1 FROM (
                        SELECT TOP {0} LineId
                        FROM Basal_Line bl                    
                        WHERE bl.LineId <> -1 ORDER BY bl.LineId
                    ) A INNER JOIN Basal_Resource B ON A.LineId = B.LineId
	                WHERE B.ResourceId =@ResourceId
                )
                BEGIN
	                SELECT 0
	                RETURN
                END
                --返回默认值
                SELECT 1", maxLineQty);
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@ResourceId", SqlDbType.Int),
                };
            parms[0].Value = resourceId;

            int status = -1;
            string msg = "";
            using (SqlDataReader dr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                while (dr.Read())
                {
                    status = dr.GetInt32(0);
                    break;
                }
                dr.Close();
            }
            if (status == -1)
            {
                return;
            }
            else if (status == -2)
            {
                msg = "未找到资源和线体的关联信息，请检查资源绑定！";
            }
            else if (status == 0)
            {
                msg = Resources.Messages.LineQtyLimit;
            }
            if (!string.IsNullOrEmpty(msg))
            {
                string str = string.Format("<script>alert(\"{0}\");location.href=\"{1}/Framework/Console1.aspx\"</script>", msg, WebHelper.WebRoot);
                Response.Write(str);
                Response.End();
                return;
            }
        }


    }
}