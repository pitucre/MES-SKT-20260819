using SKT.LeanMES.CommonDataSource.BLL;
using SKT.LeanMES.CommonDataSource.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class WriteBackLogViewXML : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var id = Convert.ToInt32(Request.QueryString["ID"]);//从主页面中传递过来的ID
            var flag = Request.QueryString["flag"];

            if (id != -1)
            {
                ERPWriteBackLogInfo model = new ERPWriteBackLog().GetInfo(new ERPWriteBackLogInfo { WriteBackLogId = id });
                if (model != null)
                {
                    if (flag == "0" && !string.IsNullOrEmpty(model.WriteBackData))
                    {
                        this.XMLData.Text = model.WriteBackData.Replace("<", "&lt").Replace(">", "&gt");
                    }
                    if (flag == "1" && !string.IsNullOrEmpty(model.ReceiveData))
                    {
                        this.XMLData.Text = model.ReceiveData.Replace("<", "&lt").Replace(">", "&gt");
                    }
                }
            }
        }
    }
}