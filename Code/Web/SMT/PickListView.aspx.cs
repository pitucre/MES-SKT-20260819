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
    public partial class PickListView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPickList));
            if (!this.IsPostBack)
            {
                int pickListId = Convert.ToInt32(Request.QueryString["ID"]);
                if (pickListId > 0)
                {
                    SKT.LeanMES.SMT.BLL.PickList bll = new LeanMES.SMT.BLL.PickList();
                    var entity = bll.GetInfo(pickListId);
                    if (entity != null)
                    {
                        PageData = entity;
                    }
                }
            }
        }

        private PickListInfo PageData
        {
            set
            {
                this.lblItemName.Text = value.ItemName;               
                this.lblRevison.Text = value.Revision;
                this.lblSetupName.Text = value.ListName;
                this.lblRemark.Text = value.Remark;
                this.cbFullSet.Checked = value.IsFullSet;
                this.lblStatus.Text = value.StatusStr;

            }
        }
    }
}