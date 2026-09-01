using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionItemDialog : BasePage
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