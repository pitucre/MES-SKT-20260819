using SKT.LeanMES.Quality.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Hold
{
    public partial class OSPTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.AjaxCommon.DBService));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new OSP()).GetOSPTypeInfo(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SKT.LeanMES.Quality.Model.OSPType PageData
        {
            set
            {

                this.txtOperateType.Text = value.OSPTypeName;
                this.txtOSPTypeTime.Text = value.OSPTypeTime.ToString();
                if (value.IsSystem == "是")
                {
                    txtOperateType.Enabled = false;
                }

            }
        }
    }
}