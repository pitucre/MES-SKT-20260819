using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using System.Configuration;
using SKT.Common.DAL.Marshal;
using System.IO;
using SKT.Common.Utility;
using SKT.LeanMES.CommonDataSource.BLL;
using SKT.LeanMES.CommonDataSource.Model;
using System.Data.SqlClient;
using System.Xml;
using System.Data;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSysConfiguration
    {
        /// <summary>
        /// 保存全局参数配置中的数据库参数配置
        /// </summary>
        /// <param name="connEncrypt">是否加密</param>
        /// <param name="mesDBLink">MES的数据库链接</param>
        /// <param name="rptDBLink">报表的数据库链接</param>
        /// <param name="midDBLink">ERP中间库链接</param>
        [AjaxMethod]
        public void UpdateWebConfigDBLink(string connEncrypt, DbConnectionInfo dic1, DbConnectionInfo dic2, DbConnectionInfo dic3, SAPConnectionInfo dic4)
        {
            if (AccountController.GetCurrentUser(true) == null)
            {
                throw new Exception("timeout");
            }
            else
            {
                dic1.pwd = WebHelper.DesDecrypt(dic1.pwd);
                dic2.pwd = WebHelper.DesDecrypt(dic2.pwd);
                dic3.pwd = WebHelper.DesDecrypt(dic3.pwd);
                dic4.pwd = WebHelper.DesDecrypt(dic4.pwd);

                string mesDBLink = "server=" + dic1.server + ";uid=" + dic1.uid + ";pwd=" + dic1.pwd + ";database=" + dic1.database + ";Pooling=True;max pool size=" + dic1.pool + ";Connect Timeout=" + dic1.interval;
                string rptDBLink = "server=" + dic2.server + ";uid=" + dic2.uid + ";pwd=" + dic2.pwd + ";database=" + dic2.database + ";Pooling=True;max pool size=" + dic2.pool + ";Connect Timeout=" + dic2.interval;
                string midDBLink = "server=" + dic3.server + ";uid=" + dic3.uid + ";pwd=" + dic3.pwd + ";database=" + dic3.database + ";Pooling=True;max pool size=" + dic3.pool + ";Connect Timeout=" + dic3.interval;
                string sapDBLink = "server=" + dic4.server + ";post=" + dic4.post + ";uid=" + dic4.uid + ";pwd=" + dic4.pwd + ";systemno=" + dic4.systemno + ";lang=" + dic4.lang + ";interval=" + dic4.interval + ";";


                var result = CheckConn(mesDBLink);
                if (result != "")
                {
                    throw new Exception("MES数据库连接失败：" + result);
                };
                result = CheckConn(rptDBLink);
                if (result != "")
                {
                    throw new Exception("报表数据库连接失败：" + result);
                };
                if (!string.IsNullOrWhiteSpace(dic3.pwd))
                {
                    result = CheckConn(midDBLink);
                    if (result != "")
                    {
                        throw new Exception("ERP数据库连接失败：" + result);
                    };
                }
                
                try
                {

                    string userName = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;



                    //Add by wenshun, SAP配置保存
                    SAPConfig configBLL = new SAPConfig();
                    SAPConfigInfo configinfo = configBLL.GetInfo(1);
                    if (configinfo == null)
                    {
                        configinfo = new SAPConfigInfo() { ID = -1 };
                    }
                    string[] sapDBInfo = sapDBLink.Split(new Char[] { ';' });
                    for (int i = 0, j = sapDBInfo.Length; i < j; i++)
                    {
                        if (sapDBInfo[i] == "") break;
                        string str = sapDBInfo[i].Substring(0, sapDBInfo[i].IndexOf("="));
                        string str2 = sapDBInfo[i].Substring(sapDBInfo[i].IndexOf("=") + 1);
                        switch (str.ToLower())
                        {
                            case "server":
                                configinfo.SAPHost = str2;
                                break;
                            case "post":
                                configinfo.SAPClient = str2;
                                break;
                            case "uid":
                                configinfo.SAPUser = str2;
                                break;
                            case "pwd":
                                configinfo.SAPPwd = str2;
                                break;
                            case "systemno":
                                configinfo.SAPNumber = str2;
                                break;
                            case "lang":
                                configinfo.SAPLang = str2;
                                break;
                            case "interval":
                                configinfo.MESTimeout = str2;
                                break;
                            default:
                                break;
                        }
                    }

                    //add by wenshun,for erp middon database info
                    Lookup.Model.LookupInfo entity = new Lookup.Model.LookupInfo()
                    {
                        Id = -1,
                        TabaleName = "LinkDBSetting",
                        Alpha1 = "ERPMidDB",
                        Alpha6 = midDBLink,
                        Creator = userName,
                        CreateDate = DateTime.Now,
                        Modifier = userName,
                        ModifyDate = DateTime.Now
                    };//新增现在中间库的信息 

                    Lookup.BLL.Lookup lookupBll = new Lookup.BLL.Lookup();
                    Dictionary<string, object> obj = new Dictionary<string, object>();
                    obj.Add("Alpha1", "ERPMidDB");//ERPMidDB指ERP中间库的标识
                    List<Lookup.Model.LookupInfo> lookupInfo = lookupBll.GetLookupByCondition("LinkDBSetting", obj);
                    if (lookupInfo.Count > 0)//如果之前有记录重新赋值
                    {
                        entity = lookupInfo[0];
                        entity.Modifier = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                        entity.ModifyDate = DateTime.Now;
                        entity.Alpha6 = midDBLink;
                    }

                    string[] midDBInfo = midDBLink.Split(new Char[] { ';' });
                    for (int i = 0, j = midDBInfo.Length; i < j; i++)
                    {
                        if (midDBInfo[i] == "") break;
                        string str = midDBInfo[i].Substring(0, midDBInfo[i].IndexOf("="));
                        string str2 = midDBInfo[i].Substring(midDBInfo[i].IndexOf("=") + 1);
                        switch (str.ToLower())
                        {
                            case "server":
                                entity.Alpha2 = str2;
                                configinfo.MESHost = str2;
                                break;
                            case "uid":
                                entity.Alpha3 = str2;
                                configinfo.MESUser = str2;
                                break;
                            case "pwd":
                                entity.Alpha4 = str2;
                                configinfo.MESPwd = str2;
                                break;
                            case "database":
                                entity.Alpha5 = str2;
                                configinfo.MESDBName = str2;
                                break;
                            default:
                                break;
                        }
                    }
                    lookupBll.Edit(entity);//新增中间库的内容
                    configBLL.Edit(configinfo);//新增SAP的内容

                    //
                    string key = "8076926971204F6BBB453737F4CFCF8";
                    Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
                    AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
                    string isEncrypt = appseting.Settings["ConnStringEncrypt"].Value;
                    appseting.Settings["ConnStringEncrypt"].Value = connEncrypt;
                    string SysConnString = appseting.Settings["SYSConnString"].Value;
                    string ReportConnString_ = appseting.Settings["ReportConnString"].Value;
                    if (isEncrypt.ToLower() == "true")
                    {
                        SysConnString = EncryptHelper.Decrypt(SysConnString, key);
                        ReportConnString_ = EncryptHelper.Decrypt(ReportConnString_);
                    }
                    if (connEncrypt.ToLower() == "true")
                    {
                        appseting.Settings["MESConnString"].Value = EncryptHelper.Encrypt(mesDBLink, key);
                        appseting.Settings["ReportConnStringNew"].Value = EncryptHelper.Encrypt(rptDBLink, key);
                        //Add By Alen Liu 2016-11-18 页面上只能设置MESConnString和ReportConnStringNew的值，但在修改保存的时候如果是加密则所有链接都要加密码，如果不加密则所有链接都不加密
                        appseting.Settings["SYSConnString"].Value = EncryptHelper.Encrypt(mesDBLink, key);
                        appseting.Settings["ReportConnString"].Value = EncryptHelper.Encrypt(rptDBLink);
                    }
                    else
                    {
                        appseting.Settings["MESConnString"].Value = mesDBLink;
                        appseting.Settings["ReportConnStringNew"].Value = rptDBLink;
                        //Add By Alen Liu 2016-11-18 页面上只能设置MESConnString和ReportConnStringNew的值，但在修改保存的时候如果是加密则所有链接都要加密码，如果不加密则所有链接都不加密
                        appseting.Settings["SYSConnString"].Value = mesDBLink;
                        appseting.Settings["ReportConnString"].Value = rptDBLink;
                    }

                    config.Save(ConfigurationSaveMode.Modified);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }
        }

        /// <summary>
        /// 导入菜单
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string UpdateMenu()
        {
            string message = "";
            if (AccountController.GetCurrentUser(true) == null)
            {
                throw new Exception("timeout");
            }
            else
            {
                try
                {
                    string conn = SQLHelper.SYSConnString;
                    string menuXmlFilePath = HttpContext.Current.Server.MapPath("~/App_Data/Menu.xml");
                    string popedomXmlFilePath = HttpContext.Current.Server.MapPath("~/App_Data/Popedom.xml");
                    string userName = AccountController.GetCurrentUser().UserName;

                    if (!File.Exists(menuXmlFilePath) || !File.Exists(popedomXmlFilePath))
                    {
                        throw new Exception("Fiel Not Exists.");
                    }

                    //SKT.LeanMES.MenuHelper.Menus.ImportMenu(conn, menuXmlFilePath, popedomXmlFilePath, out message, userName);
                    Menus.ImportMenu(conn, menuXmlFilePath, popedomXmlFilePath, out message, userName);
                    //new SKT.LeanMES.CustomMenu.BLL.MenuBottonConfig().Import(userName);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }
            return message;
        }

        #region 检查SAP连接
        [AjaxMethod]
        public string CheckSapConn(string host, string client, string user, string pwd, string sysNum, string lang)
        {
            string result = "";
            try
            {
                pwd = WebHelper.DesDecrypt(pwd);
                SKT.API.SAPRFC.CheckConn(host, client, user, pwd, sysNum, lang);
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }

            return result;
        }
        #endregion

        #region 检查目标库连接
        [AjaxMethod]
        public string CheckMesConn(string server, string user, string pwd, string dbname, string timeout, string pool)
        {
            string result = "";
            try
            {
                pwd = WebHelper.DesDecrypt(pwd);
                using (SqlConnection conn = new SqlConnection("server=" + server + ";uid=" + user + ";pwd=" + pwd + ";database=" + dbname + ";Pooling=True;Max Pool Size=" + pool + ";timeout=" + timeout + ""))
                {
                    conn.Open();
                }
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }

            return result;
        }
        #endregion

        #region 检查目标库连接
        [AjaxMethod]
        public string CheckConn(string connectionString)
        {
            string result = "";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                }
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }

            return result;
        }
        #endregion

        #region 新增，修改SAPAPI接口
        [AjaxMethod]
        public void APIEdit(SKT.LeanMES.CommonDataSource.Model.SAPAPIInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                new SKT.LeanMES.CommonDataSource.BLL.SAPAPI().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 获取SAPAPI接口内容
        [AjaxMethod]
        public SAPAPIInfo GetAPIInfo(Int64 Id)
        {
            SAPAPIInfo entity = null;
            try
            {
                if (Id > 0)
                {
                    entity = new SKT.LeanMES.CommonDataSource.BLL.SAPAPI().GetInfo(Convert.ToInt32(Id));
                }
                else
                {
                    throw new Exception("无法获取有效的ID，传递的参数不对");
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }
        #endregion
    }

    public class DbConnectionInfo
    {
        public string server { get; set; }
        public string uid { get; set; }
        public string pwd { get; set; }
        public string database { get; set; }
        public string pool { get; set; }
        public string interval { get; set; }
    }
    public class SAPConnectionInfo
    {
        public string server { get; set; }
        public string uid { get; set; }
        public string pwd { get; set; }
        public string post { get; set; }
        public string systemno { get; set; }
        public string lang { get; set; }
        public string interval { get; set; }
    }


    public class Menus
    {
        /// <summary>
        /// 导入菜单权限
        /// </summary>
        /// <param name="connectionString">数据库链接字符串</param>
        /// <param name="menuXmlFile">菜单的xml文件路径</param>
        /// <param name="popedomXmlFile">权限的文件路径</param>
        /// <param name="messages">错误输出，成功返回success</param>
        public static void ImportMenu(string connectionString, string menuXmlFile, string popedomXmlFile, out string messages)
        {
            Import(connectionString, menuXmlFile, popedomXmlFile, out messages, "");
        }

        public static void ImportMenu(string connectionString, string menuXmlFile, string popedomXmlFile, out string messages, string userName)
        {
            Import(connectionString, menuXmlFile, popedomXmlFile, out messages, userName);
        }

        private static void Import(string connectionString, string menuXmlFile, string popedomXmlFile, out string messages, string userName)
        {
            messages = "";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    string str = string.Empty;
                    try
                    {
                        XmlDocument document = new XmlDocument();
                        document.Load(menuXmlFile);
                        XmlDocument document2 = new XmlDocument();
                        document2.Load(popedomXmlFile);
                        XmlNode documentElement = document.DocumentElement;
                        XmlNode node2 = null;
                        
                        DataTable dtFrameworkSubSystems = new DataTable();
                        dtFrameworkSubSystems.Columns.Add("Name", typeof(string));
                        dtFrameworkSubSystems.Columns.Add("Icon", typeof(string));
                        dtFrameworkSubSystems.Columns.Add("Sequence", typeof(int));
                        dtFrameworkSubSystems.Columns.Add("Popedom", typeof(int));
                        
                        DataTable dtFrameworkModules = new DataTable();
                        dtFrameworkModules.Columns.Add("SubSystem", typeof(string));
                        dtFrameworkModules.Columns.Add("Name", typeof(string));
                        dtFrameworkModules.Columns.Add("Icon", typeof(string));
                        dtFrameworkModules.Columns.Add("Sequence", typeof(int));
                        dtFrameworkModules.Columns.Add("Popedom", typeof(int));

                        DataTable dtSYSPopedom = new DataTable();
                        dtSYSPopedom.Columns.Add("Popedom", typeof(int));
                        dtSYSPopedom.Columns.Add("Name", typeof(string));
                        dtSYSPopedom.Columns.Add("Description", typeof(string));
                        dtSYSPopedom.Columns.Add("PopedomGroup", typeof(int));
                        dtSYSPopedom.Columns.Add("IsSupper", typeof(bool));

                        DataTable dtFrameworkPages = new DataTable();
                        dtFrameworkPages.Columns.Add("Module", typeof(string));
                        dtFrameworkPages.Columns.Add("Name", typeof(string));
                        dtFrameworkPages.Columns.Add("InMenu", typeof(bool));
                        dtFrameworkPages.Columns.Add("Url", typeof(string));
                        dtFrameworkPages.Columns.Add("Icon", typeof(string));
                        dtFrameworkPages.Columns.Add("Sequence", typeof(int));
                        dtFrameworkPages.Columns.Add("Popedom", typeof(int));

                        DataTable dtFrameworkButtons = new DataTable();
                        dtFrameworkButtons.Columns.Add("Page", typeof(string));
                        dtFrameworkButtons.Columns.Add("Text", typeof(string));
                        dtFrameworkButtons.Columns.Add("Icon", typeof(string));
                        dtFrameworkButtons.Columns.Add("Tooltip", typeof(string));
                        dtFrameworkButtons.Columns.Add("Handler", typeof(string));
                        dtFrameworkButtons.Columns.Add("InToolbar", typeof(bool));
                        dtFrameworkButtons.Columns.Add("Sequence", typeof(int));
                        dtFrameworkButtons.Columns.Add("Popedom", typeof(int));

                        //connection.Open();

                        //str = "DELETE FROM Framework_SubSystems WHERE Flag = 0 ";
                        //command.CommandText = str;
                        //command.ExecuteNonQuery();

                        //str = "DELETE FROM Framework_Modules WHERE Flag = 0 ";
                        //command.CommandText = str;
                        //command.ExecuteNonQuery();

                        //str = "DELETE FROM Framework_Pages WHERE Flag = 0 ";
                        //command.CommandText = str;
                        //command.ExecuteNonQuery();

                        //str = "DELETE FROM Framework_Buttons WHERE Flag = 0 ";
                        //command.CommandText = str;
                        //command.ExecuteNonQuery();

                        //str = "DELETE FROM [SYS_Popedom] WHERE Flag = 0 ";
                        //command.CommandText = str;
                        //command.ExecuteNonQuery();

                        foreach (XmlNode node3 in documentElement.SelectNodes("subSystem"))
                        {
                            string str2;
                            string str3 = node3.Attributes["name"].Value;
                            string str4 = node3.Attributes["icon"].Value;
                            string str5 = node3.Attributes["sequence"].Value;
                            node2 = document2.SelectSingleNode("Popedoms/subSystem [@name='" + node3.Attributes["popedom"].Value + "']");
                            if (node2 == null)
                            {
                                str2 = node3.Attributes["popedom"].Value;
                            }
                            else
                            {
                                str2 = node2.Attributes["popedom"].Value;
                            }

                            //str = "INSERT Framework_SubSystems ([Name], [Icon], [Sequence], [Popedom], [ModifyBy]) VALUES ('" + str3 + "','" + str4 + "'," + str5 + "," + str2 + ",'" + userName + "')";
                            //command.CommandText = str;
                            //command.ExecuteNonQuery();

                            //DataRow drFrameworkSubSystems = dtFrameworkSubSystems.NewRow();
                            //drFrameworkSubSystems["Name"] = str3;
                            //drFrameworkSubSystems["Icon"] = str4;
                            //drFrameworkSubSystems["Sequence"] = str5;
                            //drFrameworkSubSystems["Popedom"] = str2;
                            //dtFrameworkSubSystems.Rows.Add(drFrameworkSubSystems);
                            dtFrameworkSubSystems.Rows.Add(new object[] { str3, str4, str5, str2 });

                            foreach (XmlNode node4 in node3.SelectNodes("module"))
                            {
                                string str6;
                                string str7 = node4.Attributes["name"].Value;
                                string str8 = node4.Attributes["icon"].Value;
                                string str9 = node4.Attributes["sequence"].Value;
                                node2 = document2.SelectSingleNode("Popedoms/subSystem [@popedom=" + str2 + "]/module [@name='" + node4.Attributes["popedom"].Value + "']");
                                if (node2 == null)
                                {
                                    str6 = node4.Attributes["popedom"].Value;
                                }
                                else
                                {
                                    str6 = node2.Attributes["popedom"].Value;
                                }
                                //str = "INSERT Framework_Modules ([SubSystem], [Name], [Icon], [Sequence], [Popedom], [ModifyBy]) VALUES ('" + str3 + "','" + str7 + "','" + str8 + "'," + str9 + "," + str6 + ",'" + userName + "')";
                                //command.CommandText = str;
                                //command.ExecuteNonQuery();
                                dtFrameworkModules.Rows.Add(new object[] { str3, str7, str8, str9, str6 });

                                foreach (XmlNode node5 in document2.SelectNodes("Popedoms/subSystem [@popedom=" + str2 + "]/module [@popedom=" + str6 + "]/popedom"))
                                {
                                    string str10 = node5.Attributes["popedom"].Value;
                                    string str11 = node5.Attributes["name"].Value;
                                    string str12 = node5.Attributes["description"].Value;
                                    string str13 = node5.Attributes["issupper"].Value;
                                    if (str13 == null)
                                    {
                                        str13 = "0";
                                    }
                                    //str = "INSERT [SYS_Popedom] ([Popedom], [Name], [Description], [PopedomGroup], [IsSupper], [CreateBy]) VALUES (" + str10 + ",'" + str11 + "','" + str12 + "'," + str6 + "," + str13 + ",'" + userName + "')";
                                    //command.CommandText = str;
                                    //command.ExecuteNonQuery();
                                    dtSYSPopedom.Rows.Add(new object[] { str10, str11, str12, str6, str13 == "1" });

                                }
                                foreach (XmlNode node6 in node4.SelectNodes("page"))
                                {
                                    string str14;
                                    string str15 = null;
                                    string str16 = node6.Attributes["inMenu"].Value;
                                    string str17 = node6.Attributes["url"].Value;
                                    string str18 = node6.Attributes["icon"].Value;
                                    string str19 = node6.Attributes["sequence"].Value;
                                    node2 = document2.SelectSingleNode("Popedoms/subSystem/module/popedom [@name='" + node6.Attributes["popedom"].Value + "']");
                                    if (node2 == null)
                                    {
                                        str14 = node6.Attributes["popedom"].Value;
                                    }
                                    else
                                    {
                                        str14 = node2.Attributes["popedom"].Value;
                                    }
                                    string[] strArray = str17.Split(new char[] { '?' });
                                    string str20 = strArray[0];
                                    if (strArray.Length > 1)
                                    {
                                        string str21 = strArray[1];
                                        foreach (string str22 in str21.Split(new char[] { '&' }))
                                        {
                                            if (str22.StartsWith("name="))
                                            {
                                                str15 = str22.Split(new char[] { '=' })[1];
                                                break;
                                            }
                                        }
                                    }
                                    if (str15 == null)
                                    {
                                        str15 = str20.Substring(str20.LastIndexOf('/') + 1).Replace(".aspx", "");
                                    }
                                    //str = "INSERT Framework_Pages ([Module], [Name], [InMenu], [Url], [Icon], [Sequence], [Popedom], [ModifyBy]) VALUES ('" + str7 + "','" + str15 + "'," + str16 + ",'" + str17 + "','" + str18 + "'," + str19 + "," + str14 + ",'" + userName + "')";
                                    //command.CommandText = str;
                                    //command.ExecuteNonQuery();
                                    dtFrameworkPages.Rows.Add(new object[] { str7, str15, str16 == "1", str17, str18, str19, str14 });

                                    foreach (XmlNode node7 in node6.SelectNodes("button"))
                                    {
                                        string str23;
                                        string str24 = node7.Attributes["inToolbar"].Value;
                                        string str25 = node7.Attributes["text"].Value;
                                        string str26 = node7.Attributes["tooltip"].Value;
                                        string str27 = node7.Attributes["icon"].Value;
                                        string str28 = node7.Attributes["handler"].Value;
                                        string str29 = node7.Attributes["sequence"].Value;
                                        node2 = document2.SelectSingleNode("Popedoms/subSystem/module/popedom [@name='" + node7.Attributes["popedom"].Value + "']");
                                        if (node2 == null)
                                        {
                                            str23 = node7.Attributes["popedom"].Value;
                                        }
                                        else
                                        {
                                            str23 = node2.Attributes["popedom"].Value;
                                        }
                                        //str = "INSERT Framework_Buttons ([Page], [Text], [Icon], [Tooltip], [Handler], [InToolbar], [Sequence], [Popedom], [ModifyBy]) VALUES ('" + str15 + "','" + str25 + "','" + str27 + "','" + str26 + "','" + str28 + "'," + str24 + "," + str29 + "," + str23 + ",'" + userName + "')";
                                        //command.CommandText = str;
                                        //command.ExecuteNonQuery();
                                        dtFrameworkButtons.Rows.Add(new object[] { str15, str25, str27, str26, str28, str24 == "1", str29, str23 });
                                    }
                                }
                            }
                        }

                        connection.Open();

                        SqlParameter[] parms = new SqlParameter[]
                        {
                            new SqlParameter("@TypeFrameworkSubSystems", SqlDbType.Structured) { Value = dtFrameworkSubSystems },
                            new SqlParameter("@TypeFrameworkModules", SqlDbType.Structured) { Value = dtFrameworkModules },
                            new SqlParameter("@TypeSYSPopedom", SqlDbType.Structured) { Value = dtSYSPopedom },
                            new SqlParameter("@TypeFrameworkPages", SqlDbType.Structured) { Value = dtFrameworkPages },
                            new SqlParameter("@TypeFrameworkButtons", SqlDbType.Structured) { Value = dtFrameworkButtons },
                            new SqlParameter("@ModifyBy", SqlDbType.VarChar) { Value = userName },
                        };
                        SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspImportMenu", parms);

                        messages = "success";
                    }
                    catch (Exception ex)
                    {
                        messages = WebHelper.GetExceptionMsg(AccountController.GetCurrentUser().UserName, ex);
                    }
                    finally
                    {
                        command.Dispose();
                        connection.Close();
                    }
                }
            }
        }
    }

}