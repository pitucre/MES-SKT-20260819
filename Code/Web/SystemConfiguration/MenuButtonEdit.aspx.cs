using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class MenuButtonEdit : BasePage
    {
        public Int32 configTypeId = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            if (!this.IsPostBack)
            {
                //txtlength.Text = "30";
                //txtname.Text = "";
                //txttext.Text = "";
                //ddltype.SelectedValue = "varchar";

                //string column = Request.QueryString["column"];
                //if (!string.IsNullOrWhiteSpace(column))
                //{
                //    SearchSettings ss = new SearchSettings();
                //    ss.AddCondition("name", column);
                //    List<ProductionAttributeConfigInfo> list = new ProductionAttributeConfig().GetAll(0, 1, "name", ss);
                //    if (list != null && list.Count == 1)
                //    {
                //        txtlength.Text = list[0].length;
                //        txtname.Text = list[0].name;
                //        txttext.Text = list[0].text;
                //        ddltype.SelectedValue = list[0].type;
                //    }
                //}
            }
        }
    }
}