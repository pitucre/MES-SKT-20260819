using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using SKT.Common.Framework.Model;
using System.Text;

namespace SKT.LeanMES.Web.Client
{
    public partial class RightMenu : System.Web.UI.Page
    {
        /// <summary>
        /// 是否加载工具栏
        /// </summary>
        private bool isLoadToolbar = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            String pageName = Request.QueryString["name"];
            if (pageName == null)
            {
                String path = Request.Path;
                pageName = path.Substring(path.LastIndexOf('/') + 1).Replace(".aspx", "");
            }

            String loadToolbar = Request.QueryString["loadtoolbar"];
            if (loadToolbar != null)
            {
                isLoadToolbar = false;
            }

            Boolean isWarrantted = this.CheckPagePopedom(pageName);
            if (!isWarrantted)
            {
                //throw new MESException(String.Empty, "NotWarranttedToPage", ExceptionLevel.Warning);
                Response.Write("没有适合您的菜单");
            }
        }

        /// <summary>
        /// 检查当前用户是否有访问所请求的页面的权限。
        /// </summary>
        /// <param name="pageName">要检查的页面名称。</param>
        /// <returns>有访问权限返回true，否则返回false。</returns>
        private Boolean CheckPagePopedom(String pageName)
        {
            Boolean isWarrantted = false;
            Int32 userId = AccountController.GetCurrentUser().UserId;

            List<ButtonInfo> buttonList;
            String loadButtonsReference = null;

            isWarrantted = SKT.Common.Framework.BLL.Page.CheckPagePopedom(userId, pageName, out buttonList);

            if (isWarrantted && isLoadToolbar)
            {
                loadButtonsReference = this.GetLoadButtonsReference(buttonList);
            }

            if (loadButtonsReference != null)
            {
                this.ClientScript.RegisterClientScriptBlock(this.GetType(), "LoadButtons", loadButtonsReference, true);
            }

            return isWarrantted;
        }

        private String GetLoadButtonsReference(List<ButtonInfo> buttonList)
        {
            Int32 toolbarButtonIndex = 0;
            Int32 floatToolbarButtonIndex = 0;
            String text, tooltip;
            String[] args;

            StringBuilder loadButtonsReference = new StringBuilder("var buttons=new Array(); var floatButtons;");
            StringBuilder floatButtonsReference = new StringBuilder("floatButtons = \"<div class='floatToolbar' id='floatToolbar'>");//<div class='lineBlock'></div>

            if (buttonList != null && buttonList.Count > 0)
            {
                Int32 btnCount = buttonList.Count;

                floatButtonsReference.Append("<table cellpadding='3' cellspacing='3' border='0'><tr>");

                foreach (ButtonInfo buttonInfo in buttonList)
                {
                    tooltip = (String)this.GetGlobalResourceObject("Buttons", buttonInfo.Tooltip);
                    text = (String)this.GetGlobalResourceObject("Buttons", buttonInfo.Text);

                    if (buttonInfo.InToolbar)
                    {

                        args = new String[] { Convert.ToString(toolbarButtonIndex), text, tooltip, buttonInfo.Icon, buttonInfo.Handler };

                        loadButtonsReference.AppendFormat("buttons[{0}]={{Text:\"{1}\",Tooltip:\"{2}\",Icon:\"{3}\",Handler:\"{4}\"}};", args);

                        toolbarButtonIndex++;
                    }
                    else
                    {
                        String ficonRoot = WebHelper.WebRoot + "/Content/images/icon/";
                        args = new String[] { ficonRoot, buttonInfo.Icon + ".png", text, tooltip, buttonInfo.Handler };
                        floatButtonsReference.AppendFormat("<td><span id='floatBtn" + floatToolbarButtonIndex + "' class='floatbuttonsitem' onclick='{4}' title='{3}'><img src='{0}{1}' alt='{3}' style='width:16px;height:16px; float:left;vertical-align:middle'/>&nbsp;{2}</span></td>", args);
                        if (btnCount > 1)
                        {
                            floatButtonsReference.Append("<td><span class='floatToolbar-line'></span></td>");
                        }
                        floatToolbarButtonIndex++;
                    }
                    btnCount--;
                }



                floatButtonsReference.Append("</tr></table></div>\";");
            }


            loadButtonsReference.Append("try{loadButtons(buttons);}catch(ex){};");

            if (floatToolbarButtonIndex > 0)
            {
                loadButtonsReference.Append(floatButtonsReference);
            }

            return loadButtonsReference.ToString();
        }

        /// <summary>
        /// 设置页面语言
        /// </summary>
        protected override void InitializeCulture()
        {
            String strlang = "zh-cn";
            HttpCookie cookieLang = this.Request.Cookies["lang"];
            if (cookieLang != null)
            {
                cookieLang = Request.Cookies["lang"];
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(cookieLang.Value);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(cookieLang.Value);
            }
            else
            {
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(strlang);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(strlang);
            }
            base.InitializeCulture();
        }
    }
}