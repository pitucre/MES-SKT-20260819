using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Synchronization
{
    public partial class SynchronizationView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                this.lblBusinessName.InnerText = value.BusinessName;
                this.lblStoredProcedureName.InnerText = value.StoredProcedureName;
                this.lblTimeout.InnerText = value.Timeout.ToString();
            }
        }
    }
}