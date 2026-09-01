using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.LeanMES.CommonDataSource.BLL;


namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class SysConfig : BasePage
    {
        readonly string key = "8076926971204F6BBB453737F4CFCF8";
        protected void Page_Load(object sender, EventArgs e)
        {
            //配置password控件安全性
            this.txtMESDBPwd.Attributes.Add("autocomplete", "off");
            this.txtRptDBPwd.Attributes.Add("autocomplete", "off");
            this.txtMidDBPwd.Attributes.Add("autocomplete", "off");
            this.txtSAPPwd.Attributes.Add("autocomplete", "off");

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSysConfiguration));
            if (!IsPostBack)
            {
                #region 读取web.config
                Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
                AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
                string ConnStringEncrypt = appseting.Settings["ConnStringEncrypt"].Value;
                string MESConnString = appseting.Settings["MESConnString"].Value;
                string ReportConnString = appseting.Settings["ReportConnStringNew"].Value;
                //string SessionTimeOut = appseting.Settings["SessionTimeOut"].Value;

                if (!string.IsNullOrEmpty(appseting.Settings["CustomerLogo"].Value))
                {
                    this.llLogo.Text = "<img src='" +appseting.Settings["CustomerLogo"].Value + "' width='200px' height='45px'/>";
                }

                    if (ConnStringEncrypt.ToLower() == "true")
                {
                    MESConnString = SKT.Common.Utility.EncryptHelper.Decrypt(MESConnString, key);
                    ReportConnString = SKT.Common.Utility.EncryptHelper.Decrypt(ReportConnString, key);
                }

                this.ddlIsEncrypt.SelectedValue = ConnStringEncrypt;

                //数据库信息
                string[] mesDBInfo = MESConnString.Split(new Char[] { ';' });
                string[] rptDBInfo = ReportConnString.Split(new Char[] { ';' });

                string str = "";
                string str2 = "";
                //设置MES数据库信息
                for (int i = 0, j = mesDBInfo.Length; i < j; i++)
                {
                    if (mesDBInfo[i] == "") break;
                    str = mesDBInfo[i].Substring(0, mesDBInfo[i].IndexOf("="));
                    str2 = mesDBInfo[i].Substring(mesDBInfo[i].IndexOf("=") + 1);
                    switch (str.ToLower())
                    {
                        case "server":
                            this.txtMESDBServer.Text = str2;
                            break;
                        case "uid":
                            this.txtMESDBUserName.Text = str2;
                            break;
                        case "pwd":
                            this.txtMESDBPwd.Attributes.Add("value",WebHelper.DesEncrypt(str2));
                            break;
                        case "database":
                            this.txtMESDBName.Text = str2;
                            break;
                        case "max pool size":
                            this.txtMESDBPool.Text = str2;
                            break;
                        default:
                            break;
                    }
                }

                //设置报表数据库信息
                for (int i = 0, j = rptDBInfo.Length; i < j; i++)
                {
                    if (rptDBInfo[i] == "") break;
                    str = rptDBInfo[i].Substring(0, rptDBInfo[i].IndexOf("="));
                    str2 = rptDBInfo[i].Substring(rptDBInfo[i].IndexOf("=") + 1);
                    switch (str.ToLower())
                    {
                        case "server":
                            this.txtRptDBServer.Text = str2;
                            break;
                        case "uid":
                            this.txtRptDBUserName.Text = str2;
                            break;
                        case "pwd":
                            this.txtRptDBPwd.Attributes.Add("value", WebHelper.DesEncrypt(str2));
                            break;
                        case "database":
                            this.txtRptDBName.Text = str2;
                            break;
                        case "max pool size":
                            this.txtRptDBPool.Text = str2;
                            break;
                        default:
                            break;
                    }
                }

                //设置ERP中间库的链接内容
                SKT.LeanMES.Lookup.BLL.Lookup lookupBll = new Lookup.BLL.Lookup();
                Dictionary<string, object> obj = new Dictionary<string, object>();
                obj.Add("Alpha1", "ERPMidDB");//ERPMidDB指ERP中间库的标识
                List<Lookup.Model.LookupInfo> lookupInfo = lookupBll.GetLookupByCondition("LinkDBSetting", obj);
                if (lookupInfo.Count > 0)
                {
                    txtMidDBServer.Text = lookupInfo[0].Alpha2.Trim();
                    txtMidDBUid.Text = lookupInfo[0].Alpha3.Trim();
                    txtMidDBPwd.Attributes.Add("value", WebHelper.DesEncrypt(lookupInfo[0].Alpha4.Trim()));
                    txtMidDBName.Text = lookupInfo[0].Alpha5.Trim();
                }

                //获取设置SAP的链接内容
                Common.Model.SearchSettings searchEntity = new Common.Model.SearchSettings();
                SAPConfig configBLL = new SAPConfig();
                List<SAPConfigInfo> configList = configBLL.GetAll(0, 100, "[ID]", searchEntity);
                if (configList.Count > 0)
                {
                    txtSAPDBServer.Text = configList[0].SAPHost;
                    txtSAPPost.Text = configList[0].SAPClient;
                    txtSAPUser.Text = configList[0].SAPUser;
                    txtSAPPwd.Attributes.Add("value", WebHelper.DesEncrypt(configList[0].SAPPwd));
                    txtSAPSysNo.Text = configList[0].SAPNumber;
                    txtSAPLanguage.Text = configList[0].SAPLang;
                    txtMESInterval.Text = configList[0].MESTimeout;
                }
                #endregion
            }
            if(IsPostBack)
            {
                try
                {
                    Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
                    AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
                    if (appseting.Settings["CustomerLogo"] != null)
                    {
                        appseting.Settings["CustomerLogo"].Value = "";
                        config.Save(ConfigurationSaveMode.Modified);

                        String script = "alert('删除客户LOGO成功，页面即将刷新！');top.location.href = top.location.href;";
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "jscrpt", script, true);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                    throw ex;
                }
            }
        }
    }
}