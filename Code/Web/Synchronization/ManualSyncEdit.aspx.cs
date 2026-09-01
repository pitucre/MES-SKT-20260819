using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Synchronization
{
    public partial class ManualSyncEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSynchronization));
            BindContent();
            String idString = Request.QueryString["ID"];
            SKT.LeanMES.Synchronization.BLL.Synchronization synchronization = new SKT.LeanMES.Synchronization.BLL.Synchronization();
            SKT.LeanMES.Synchronization.Model.SynchronizationInfo info = synchronization.GetManualSyncInfo(Convert.ToInt32(idString));
            if (info != null)
            {
                this.PageData = info;
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SKT.LeanMES.Synchronization.Model.SynchronizationInfo PageData
        {
            set
            {
                this.ddlSyncType.SelectedValue = value.SyncType;
                this.txtSyncContent.Text = value.SyncContent;
            }
        }
        protected void BindContent()
        {
            SKT.LeanMES.Synchronization.BLL.Synchronization bll = new SKT.LeanMES.Synchronization.BLL.Synchronization();
            this.ddlSyncType.DataSource = bll.GeSyncTypeALL();
            this.ddlSyncType.DataTextField = "SyncType";
            this.ddlSyncType.DataValueField = "SyncType";
            this.ddlSyncType.DataBind();
        }
    }
}