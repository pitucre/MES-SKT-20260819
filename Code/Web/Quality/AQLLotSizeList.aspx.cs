using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class AQLLotSizeList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindAQLLotSizeList();
        }

        private void BindAQLLotSizeList()
        {
            rptAQLLotSize.DataSource = new LeanMES.Quality.BLL.AQLRule().GetAQLLotSizeList();
            rptAQLLotSize.DataBind();
        }
    }
}