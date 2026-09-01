using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Hold
{
    public partial class UnHoldImport : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
        }       
    }
}