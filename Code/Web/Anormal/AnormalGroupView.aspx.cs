using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Anormal.Model;
using SKT.LeanMES.Anormal.BLL;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalGroupView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            AnormalGroupInfo model = new AnormalGroupInfo();
            AnormalGroup groupBll = new AnormalGroup();
            model = groupBll.GetInfo(Int32.Parse(idString));
            if (model != null)
            {
                lblGroupName.Text = model.AnormalGroupName;
                lblGroupCode.Text = model.AnormalGroupCode;
            }
        }
    }
}