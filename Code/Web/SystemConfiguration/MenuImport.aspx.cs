using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Threading;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class MenuImport : BasePage, ICallbackEventHandler
    {
        string myStr = string.Empty;
        public string GetCallbackResult()
        {
            return myStr;
        }

        public void RaiseCallbackEvent(string eventArgument)
        {
            //Thread.Sleep(10000);
            AjaxSysConfiguration ajax = new AjaxSysConfiguration();
            string mess = ajax.UpdateMenu();
            myStr = mess;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSysConfiguration));
            if (!IsPostBack)
            {
                string menuXmlFilePath = HttpContext.Current.Server.MapPath("~/App_Data/Menu.xml");
                string popedomXmlFilePath = HttpContext.Current.Server.MapPath("~/App_Data/Popedom.xml");
                string userName = AccountController.GetCurrentUser().UserName;

                if (!File.Exists(menuXmlFilePath) || !File.Exists(popedomXmlFilePath))
                {
                    this.lblMenuFile.Text = "文件不存在！";
                    this.hdnFileExists.Value = "0";
                }
                else
                {
                    this.lblMenuFile.Text = "Menu.xml";
                    this.lblPopedomFile.Text = "Popedom.xml";
                    this.hdnFileExists.Value = "1";
                }
            }
        }
    }
}