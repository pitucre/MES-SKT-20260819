using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Framework
{
    public partial class FileNotFound : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookieLang = new HttpCookie("lang");
            if (Request.Cookies["lang"] != null)
            {
                cookieLang = Request.Cookies["lang"];
                if (cookieLang.Value != "zh-cn")
                {
                    this.imgfileNotFound.Src = WebHelper.ImageRoot + "fileNotFound_en.gif";
                }
                else
                {
                    this.imgfileNotFound.Src = WebHelper.ImageRoot + "fileNotFound.gif";
                }
            }
            else
            {
                this.imgfileNotFound.Src = WebHelper.ImageRoot + "fileNotFound.gif";
            }
        }
    }
}