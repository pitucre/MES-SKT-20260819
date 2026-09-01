using SKT.LeanMES.CustomMenu.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.CustomMenu
{
    public partial class SubSystemsEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxCustomMenu));
            string FatherKey = Request.QueryString["ID"];
            if (FatherKey != "-1")
            {
                CustomMenuInfo model = new LeanMES.CustomMenu.BLL.CustomMenu().GetCustomMenuInfo(FatherKey);
                if (model != null)
                {
                    this.txtKeyCNValues.Text = model.KeyCNValues.ToString();
                    this.txtKeyENValues.Text = model.KeyENValues.ToString();
                    this.txtSequence.Text = model.Sequence.ToString();
                    this.txtRemark.Text = model.Remark.ToString();
                }
            }
        }
    }
}