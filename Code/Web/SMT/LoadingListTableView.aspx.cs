using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.SMT.BLL;

namespace SKT.LeanMES.Web.SMT
{
    public partial class LoadingListTableView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            LoadingListTableInfo loadingListTableInfo = (new LoadingListTable()).GetInfo(Convert.ToInt32(idString));

            this.lblTableName.Text = loadingListTableInfo.TableName;
            this.lblTableDesc.Text = loadingListTableInfo.TableDesc;           
            this.lblRemark.Text = loadingListTableInfo.Remark;
            this.lblEnableFlag.Text = loadingListTableInfo.EnableFlag == 0 ? "不启用" : "启用";
        }
    }
}