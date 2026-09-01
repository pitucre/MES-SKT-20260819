using System;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelZPLView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            LabelZPLInfo labelZPLInfo = (new LabelZPL()).GetInfo(Convert.ToInt32(idString));
            this.lblZplType.Text = labelZPLInfo.ZplType == 0 ? "ZPL指令" : "POSTEK指令";
            this.lblZplName.Text = labelZPLInfo.ZplName;
            this.lblDescription.Text = labelZPLInfo.Description;
        }
    }
}