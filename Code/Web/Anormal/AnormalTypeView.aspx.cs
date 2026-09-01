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
    public partial class AnormalTypeView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            AnormalTypeInfo anormal_TypeInfo = (new AnormalType()).GetInfo(Convert.ToInt32(idString));
            AnormalGroupInfo anormal_GroupInfo = (new AnormalGroup()).GetInfo(Convert.ToInt32(anormal_TypeInfo.AnormalGroupId));
            this.lblAnormalGroupName.Text = anormal_GroupInfo.AnormalGroupName;
            this.lblAnormalTypeCode.Text = anormal_TypeInfo.AnormalTypeCode;
            this.lblAnormalTypeName.Text = anormal_TypeInfo.AnormalTypeName;
            this.lblRemark.Text = anormal_TypeInfo.Descriptions;
        }
    }
}