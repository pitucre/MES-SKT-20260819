using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using System.Web.Configuration;
using System.IO;
using System.Text.RegularExpressions;

using SKT.Common.Model;
using SKT.Common.Account.BLL;
using SKT.LeanMES.Web.AjaxServices;
using System.Reflection;
using System.Web.SessionState;

namespace SKT.LeanMES.Web
{
    public partial class Login : Systems.Web.AccessPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string org = string.IsNullOrEmpty(Request.QueryString["org"])?"":Request.QueryString["org"].ToString();
            Response.Redirect("Default.aspx?org="+ org);
             
        }
         
    }
}