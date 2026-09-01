using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Jig.Model;
using SKT.LeanMES.Jig.BLL;

namespace SKT.LeanMES.Web.Jig
{
    public partial class JigTypeView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            JigTypeInfo jigTypeInfo = (new JigType()).GetInfo(Convert.ToInt32(idString));

            this.lblTypeName.Text = jigTypeInfo.TypeName;
            this.lblTypeCode.Text = jigTypeInfo.TypeCode;
            this.lblRemark.Text = jigTypeInfo.Remark;
        }
    }
}