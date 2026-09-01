using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Synchronization
{
    public partial class SynchronizationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSynchronization));

            String idString = Request.QueryString["ID"];
            SKT.LeanMES.Synchronization.BLL.Synchronization synchronization = new SKT.LeanMES.Synchronization.BLL.Synchronization();
            SKT.LeanMES.Synchronization.Model.SynchronizationInfo info = synchronization.GetInfo(Convert.ToInt32(idString));
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
                this.txtBusinessName.Text = value.BusinessName;
                this.txtStoredProcedureName.Text = value.StoredProcedureName;
                this.txtTimeout.Text = value.Timeout.ToString();
            }
        }
    }

}