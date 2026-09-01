using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MobileApp
{
    
    public partial class VerInfo : System.Web.UI.Page
    {
        public string _verInfo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //版本号
            _verInfo = ConfigurationManager.AppSettings["Version"];

            strVerInfo.InnerHtml = _verInfo;
        }
    }
}