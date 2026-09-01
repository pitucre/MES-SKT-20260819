using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.DAL.Marshal;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Account.BLL;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class OnlineUser : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Action"] == "getonlineuser")
            {
                GetOnlineUser();
            }
        }
        protected void GetOnlineUser()
        {
            Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new Users().GetOnlineUserList()));
            Response.End();
        }
    }
}