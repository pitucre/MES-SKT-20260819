using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquimentTypeDialog : BasePage
    {
        public string controlId = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["controlId"] != null)
            {
                controlId = Request["controlId"];
            }
        }
    }
}