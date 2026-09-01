using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.User
{
    public partial class PopedomUsersList : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            string IsGroup = Request.QueryString["IsGroup"];
            if (IsGroup == "1")
            {
                this.ObjectDataSource1.SelectMethod = "GetPopedomUsersSub";
            }
            else
            {
                this.ObjectDataSource1.SelectMethod = "GetPopedomUsers";
            }
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "UserId";

        }

    }
}