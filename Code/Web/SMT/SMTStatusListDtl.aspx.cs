using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SMT
{
    public partial class SMTStatusListDtl : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int orderId = Convert.ToInt32(Request.QueryString["ID"]);
            string listName = Request.QueryString["list"];
            SKT.LeanMES.SMT.BLL.LoadingList bll = new SKT.LeanMES.SMT.BLL.LoadingList();
            hfDataJson.Value=bll.GetSMTStatusListDtl(orderId,listName);

        }
    }
}