using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.DataDistribution
{
    public partial class CommonHelperDataDistribution :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDataDistribution));
        }
    }
}